Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147AE5F8C8C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 19:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJIRho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJIRhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 13:37:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154182A25B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 10:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDA5DB80D86
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 17:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A385C433C1;
        Sun,  9 Oct 2022 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665337054;
        bh=4YKJ75aAYfVmuih5WjBkBqJZZGk12SfM0ZqEAhECx5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YbOZyjk6bc5fW5z2bUreAFMwQDFZ//XoKW5IxwOlYXEDRSTTSXn6XANjG4Jqcs7cD
         jxvVj2NxP+UDVSXUNwe+OVSGUhOjD2FvSM6gu+2IMbpxzTLeR+j0yV+8TEayRJRFdk
         Y8FlaN1qDUjVAxccvs2sx/sqwJsFzvesKx7eHHzZrsgBGjan52mdpLMKPikpv7+Pxm
         eE/psrePVCPs8l3HZLYfR/DjjkPwFTokLDD9DviKDXGOasqdX/JmK6a5bTJsKt5wu/
         MxLfx9ZsRUwwyaUOX/dGBaGesgxC2AFGjxHTLADtZQMVfzVsCShxDwRjfHd7uJd2t2
         mlTqtxE1Lw91g==
Date:   Sun, 9 Oct 2022 19:35:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Christian A. Ehrhardt" <lk@c--e.de>, Tejun Heo <tj@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] cgroup: Fix crash with CLONE_INTO_CGROUP and v1 cgroups
Message-ID: <20221009173519.jwuissylg5haicie@wittgenstein>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
 <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein>
 <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 03:10:36PM +0200, Christian A. Ehrhardt wrote:
> 
> Since commit f3a2aebdd6, Version 1 cgroups no longer cause an
> error when used with CLONE_INTO_CGROUP. However, the permission
> checks performed during clone assume a Version 2 cgroup.
> 
> Restore the error check for V1 cgroups in the clone() path.
> 
> Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/lkml/000000000000385cbf05ea3f1862@google.com/
> Fixes: f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---

Thanks for fixing this,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Fwiw, @Tejun, after
f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")
that non-me-Christian fixes with this patch cgroup_get_from_file() looks
a bit odd. It could use sm like:

From 0a8a5f7acbec0385ec16cd93a9cff2486fae0ecb Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 9 Oct 2022 19:33:21 +0200
Subject: [PATCH] cgroup: remove unneeded local variable

Since commit f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")
the assigment to @cgrp has become pointless.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 kernel/cgroup/cgroup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8ad2c267ff47..550e7bd96b76 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6160,14 +6160,12 @@ void cgroup_fork(struct task_struct *child)
 static struct cgroup *cgroup_get_from_file(struct file *f)
 {
 	struct cgroup_subsys_state *css;
-	struct cgroup *cgrp;
 
 	css = css_tryget_online_from_dir(f->f_path.dentry, NULL);
 	if (IS_ERR(css))
 		return ERR_CAST(css);
 
-	cgrp = css->cgroup;
-	return cgrp;
+	return css->cgroup;
 }
 
 /**
-- 
2.34.1

