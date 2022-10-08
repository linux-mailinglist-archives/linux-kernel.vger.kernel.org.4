Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DF95F832B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 07:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJHFvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 01:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJHFvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 01:51:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DF5C58BC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 22:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5980EB803F2
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 05:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BD2C433C1;
        Sat,  8 Oct 2022 05:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665208298;
        bh=W6q1tiZ9Iqp6d4/18VhePkyklrADyF24xpsTzgi4gJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=As/V6+pS+BZOYRWZGJzhz+zgpo0hnVwi/yqW7YDVerHaGIaGgRHCrIjIuIh5fZloN
         i5QKPt8M9L6CL67EvdxW3lryhZVfsCC9k/sjUP8qz3dy2wrgyqT1YVmETGTHiGLBTz
         bRv2C//7y9pln+S9PtGO2kf7wPch8DnyqBRDwm9LUARizrVdRGA0lgd9WyuSDc8EcM
         dpjSEW4/9P1ThMqnUGdCNXVf9incrrvrCpwvY5jN/8WGP3XA+BtUTWir9e+ygQne9A
         OTBOK8duN5hcTWYYvH1dwGJu+Wh3S+z+nmSflGDZ6XX7BePFjNp8CgT/n3QxYU1Pts
         t/8Zx57cqUPVg==
Date:   Sat, 8 Oct 2022 07:51:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Tejun Heo <tj@kernel.org>
Subject: Re: [syzbot] general protection fault in kernfs_get_inode
Message-ID: <20221008055133.jqreizhg5k23umgp@wittgenstein>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
 <20221008054607.fyqzd7oil2ulzf34@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221008054607.fyqzd7oil2ulzf34@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 07:46:12AM +0200, Christian Brauner wrote:
> On Fri, Oct 07, 2022 at 11:35:49AM -1000, Tejun Heo wrote:
> > (cc'ing Christian and quoting whole body)
> > 
> > Christan, I can't repro it here but think what we need is sth like the
> > following. The problem is that cgroup_is_dead() check in the fork path isn't
> > enough as the perm check depends on cgrp->procs_file being available but
> > that is cleared while DYING before DEAD. So, depending on the timing, we can
> > end up trying to deref NULL pointer in may_write.
> > 
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 8ad2c267ff471..603b7167450a1 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -4934,6 +4934,10 @@ static int cgroup_may_write(const struct cgroup *cgrp, struct super_block *sb)
> >  
> >  	lockdep_assert_held(&cgroup_mutex);
> >  
> > +	/*if @cgrp is being removed, procs_file may already be gone */
> > +	if (!cgrp->procs_file.kn)
> > +		return -ENODEV;
> > +
> >  	inode = kernfs_get_inode(sb, cgrp->procs_file.kn);
> >  	if (!inode)
> >  		return -ENOMEM;
> 
> Tejun, thanks for the Cc.
> Yep, that seems to be the correct analysis.
> I assume you're turning this into a proper patch, so:
> 
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

#syz test: git@gitlab.com:brauner/linux.git kernel.cgroup_may_write.fix

From f2517f35b571ee80ab046f205ef8b3143d039d57 Mon Sep 17 00:00:00 2001
From: Not My Commit <not@my.commit>
Date: Sat, 8 Oct 2022 07:44:57 +0200
Subject: [PATCH] NOT A REAL COMMIT

THIS IS JUST FOR SYZBOT.
---
 kernel/cgroup/cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8ad2c267ff47..f8386a066e0e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4934,6 +4934,9 @@ static int cgroup_may_write(const struct cgroup *cgrp, struct super_block *sb)
 
 	lockdep_assert_held(&cgroup_mutex);
 
+	if (!cgrp->procs_file.kn)
+		return -ENODEV;
+
 	inode = kernfs_get_inode(sb, cgrp->procs_file.kn);
 	if (!inode)
 		return -ENOMEM;
-- 
2.34.1

