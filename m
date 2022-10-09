Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190D25F8A36
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 10:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiJIInM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 04:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIInJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 04:43:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0204D27DEB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 01:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B05D2B80C91
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 08:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E24DC433C1;
        Sun,  9 Oct 2022 08:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665304985;
        bh=Ej0LAvFl1M2gxzYuzoNaryu+q0+p7PwbEkXRhK1/xIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BEZMZfyWdgL08msAM47D89k35sUxYE6Vt8WrWoTwoNH+pnAg71v8Ro04Be2wKui+V
         tsiIAcG/FQnNxFBgMwrCmLueuVWpKU5wlo7nmY4uxNRbnYD/dFasioFAFcSRWiioog
         MxpmZicedC7O6HW34G9sJSXWgb0qUWw8yOcdklzyA2inN6WtWKF+CXx+e0PRWdZCQ6
         aTrnlWcEAA2E/Bxzb5+usdfQZelStfiYRDcrT9OUfiAgpV2L5e3oDh/7KNTq0sX0dd
         bd1390LTUzLSIKggifbjnI+ol/iaBqaj6gQdI/SXf1QxxpQAnPFdwMqM92JmfVsaJE
         ydEbGcZaKPp6A==
Date:   Sun, 9 Oct 2022 10:42:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Christian A. Ehrhardt" <lk@c--e.de>
Cc:     Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [syzbot] general protection fault in kernfs_get_inode
Message-ID: <20221009084039.cw6meqbvy4362lsa@wittgenstein>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
 <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 08:29:40PM +0200, Christian A. Ehrhardt wrote:
> 
> Hi (from another Christian),
> 
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
> I had syzbot hit the same crash here and as can be seen from the
> reproducer the root cause is that the target cgroup (specified
> via CLONE_INTO_CGROUP) is a version 1 cgroup. These cgroups just
> don't initialize ->procs_file.kn.
> 
> This is a regression from v6.0 caused by 
> 
>    f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")   

Yeah, this patch is wrong in its simple form and definitely breaks CLONE_INTO_CGROUP.
CLONE_INTO_CGROUP can only work with cgroup2 fds. It absolutely cannot
work with cgroup1 fds. The semantics would be terrible as controllers
can be mounted into separate hierarchies.

> 
> Unless we want to revert this patch the correct fix might be
> something like this:
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index f487c54a0087..67474b1ae087 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6249,6 +6249,11 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
>  		goto err;
>  	}
>  
> +	if (!cgroup_on_dfl(dst_cgrp)) {
> +		ret = -EBADF;
> +		goto err;
> +	}

That seems like a good enough patch to me.
