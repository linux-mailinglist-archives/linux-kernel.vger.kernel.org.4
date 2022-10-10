Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DE65FA8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJJXyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJJXyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:54:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E327A747
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:54:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso14413764pjf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OzbnP7Gk5CEafBhODW2u4dKE3BlAzuVBXh7PpKChns=;
        b=cFwRL6BTK7ThqE90YIIwWrfSONtGJyzewGd+Zs3fA55ZwPJQIZDblYXZAdHVaHmiuu
         PFIr9GDEVmfCx2y7H9kn80QYiiJZ7H5l91hDHUo7QsO8D99zoggGJQHE5ZT+CMXhQLv1
         c5Z+LP++9T+mHwAITGtRCErT9xydPyP/In7Xpf/IMiYqG3zUWUttpYB12XX0zvkUh8x5
         AdcGRjFezFAyJhOlgbOKtdF21buj3DzoLsyrlyzaX47MIm4u2u1zuvboyxueflPT48ob
         ozHphGNG9oS9YeRtrm0oDZqOrPlunhsIS77Grq46f5CNmnAHgds3BRlljN7pWpxfT2Yc
         41qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OzbnP7Gk5CEafBhODW2u4dKE3BlAzuVBXh7PpKChns=;
        b=KjeNCgblbUZYtgQckP5JdgJ24UR5h079dm4jX0b6Xz0ejN72nh/FRCAsqVxb9lEHwX
         A76gePZD8BG3TW7NoqFaae/o80gGauLbH7GQJOJs5L5EOpUTUwV/TzKf1LU+zI4E1ble
         uKCxBBvoWuy/L4lYsJ2+QSIVDTnrBTf9DuQzlL3ItbGc91dLQRfc3IcozxJkI35JNlMc
         xdNFI85DgD5ZLu5tdT9YVZXvjF9YrC8cSkijHfU9dOZyyywaO/t22V63Uw7qUNuM9gSg
         M0lk2EDjz4nxbbPOZtwP/mzdiNSaJUIUgbhF8w5SO+fUyQzRJnfKQxKuyUCnkqVJ7BUt
         nMzg==
X-Gm-Message-State: ACrzQf0OtdqMnPNI7JpXnKfJpe76EYKXPvM+drw/To7Oe5C529MJj4g5
        COCHLXS5yaCGrrA1JMipeq0=
X-Google-Smtp-Source: AMsMyM6SyfKcYizbeqGyJW7ccplZRfdwJLOxFYUoHwbG1NZ8G8YFhPJ5yyiIol5fWtBXa3rretqWhA==
X-Received: by 2002:a17:90b:3b82:b0:20b:516:5ff5 with SMTP id pc2-20020a17090b3b8200b0020b05165ff5mr22822648pjb.92.1665446058431;
        Mon, 10 Oct 2022 16:54:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id nm12-20020a17090b19cc00b0020a9af6bb1asm6664888pjb.32.2022.10.10.16.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 16:54:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 13:54:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH driver-core-linus] kernfs: Fix spurious lockdep warning in
 kernfs_find_and_get_node_by_id()
Message-ID: <Y0SwqBsZ9BMmZv6x@slm.duckdns.org>
References: <00000000000013300305eaa8f1bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000013300305eaa8f1bf@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c25491747b21 ("kernfs: Add KERNFS_REMOVING flags") made
kernfs_find_and_get_node_by_id() test kernfs_active() instead of
KERNFS_ACTIVATED. kernfs_find_and_get_by_id() is called without holding the
kernfs_rwsem triggering the following lockdep warning.

  WARNING: CPU: 1 PID: 6191 at fs/kernfs/dir.c:36 kernfs_active+0xe8/0x120 fs/kernfs/dir.c:38
  Modules linked in:
  CPU: 1 PID: 6191 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-09413-g4899a36f91a9 #0
  Hardware name: linux,dummy-virt (DT)
  pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : kernfs_active+0xe8/0x120 fs/kernfs/dir.c:36
  lr : lock_is_held include/linux/lockdep.h:283 [inline]
  lr : kernfs_active+0x94/0x120 fs/kernfs/dir.c:36
  sp : ffff8000182c7a00
  x29: ffff8000182c7a00 x28: 0000000000000002 x27: 0000000000000001
  x26: ffff00000ee1f6a8 x25: 1fffe00001dc3ed5 x24: 0000000000000000
  x23: ffff80000ca1fba0 x22: ffff8000089efcb0 x21: 0000000000000001
  x20: ffff0000091181d0 x19: ffff0000091181d0 x18: ffff00006a9e6b88
  x17: 0000000000000000 x16: 0000000000000000 x15: ffff00006a9e6bc4
  x14: 1ffff00003058f0e x13: 1fffe0000258c816 x12: ffff700003058f39
  x11: 1ffff00003058f38 x10: ffff700003058f38 x9 : dfff800000000000
  x8 : ffff80000e482f20 x7 : ffff0000091d8058 x6 : ffff80000e482c60
  x5 : ffff000009402ee8 x4 : 1ffff00001bd1f46 x3 : 1fffe0000258c6d1
  x2 : 0000000000000003 x1 : 00000000000000c0 x0 : 0000000000000000
  Call trace:
   kernfs_active+0xe8/0x120 fs/kernfs/dir.c:38
   kernfs_find_and_get_node_by_id+0x6c/0x140 fs/kernfs/dir.c:708
   __kernfs_fh_to_dentry fs/kernfs/mount.c:102 [inline]
   kernfs_fh_to_dentry+0x88/0x1fc fs/kernfs/mount.c:128
   exportfs_decode_fh_raw+0x104/0x560 fs/exportfs/expfs.c:435
   exportfs_decode_fh+0x10/0x5c fs/exportfs/expfs.c:575
   do_handle_to_path fs/fhandle.c:152 [inline]
   handle_to_path fs/fhandle.c:207 [inline]
   do_handle_open+0x2a4/0x7b0 fs/fhandle.c:223
   __do_compat_sys_open_by_handle_at fs/fhandle.c:277 [inline]
   __se_compat_sys_open_by_handle_at fs/fhandle.c:274 [inline]
   __arm64_compat_sys_open_by_handle_at+0x6c/0x9c fs/fhandle.c:274
   __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
   invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
   el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
   do_el0_svc_compat+0x40/0x70 arch/arm64/kernel/syscall.c:212
   el0_svc_compat+0x54/0x140 arch/arm64/kernel/entry-common.c:772
   el0t_32_sync_handler+0x90/0x140 arch/arm64/kernel/entry-common.c:782
   el0t_32_sync+0x190/0x194 arch/arm64/kernel/entry.S:586
  irq event stamp: 232
  hardirqs last  enabled at (231): [<ffff8000081edf70>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
  hardirqs last  enabled at (231): [<ffff8000081edf70>] finish_lock_switch kernel/sched/core.c:4943 [inline]
  hardirqs last  enabled at (231): [<ffff8000081edf70>] finish_task_switch.isra.0+0x200/0x880 kernel/sched/core.c:5061
  hardirqs last disabled at (232): [<ffff80000c888bb4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:404
  softirqs last  enabled at (228): [<ffff800008010938>] _stext+0x938/0xf58
  softirqs last disabled at (207): [<ffff800008019380>] ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
  ---[ end trace 0000000000000000 ]---

The lockdep warning in kernfs_active() is there to ensure that the activated
state stays stable for the caller. For kernfs_find_and_get_node_by_id(), all
that's needed is ensuring that a node which has never been activated can't
be looked up and guaranteeing lookup success when the caller knows the node
to be active, both of which can be achieved by testing the active count
without holding the kernfs_rwsem.

Fix the spurious warning by introducing __kernfs_active() which doesn't have
the lockdep annotation.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com
Fixes: c25491747b21 ("kernfs: Add KERNFS_REMOVING flags")
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 fs/kernfs/dir.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 3990f3e270cb6..f33b3baad07cb 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -31,10 +31,15 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 #define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
 
+static bool __kernfs_active(struct kernfs_node *kn)
+{
+	return atomic_read(&kn->active) >= 0;
+}
+
 static bool kernfs_active(struct kernfs_node *kn)
 {
 	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
-	return atomic_read(&kn->active) >= 0;
+	return __kernfs_active(kn);
 }
 
 static bool kernfs_lockdep(struct kernfs_node *kn)
@@ -705,7 +710,12 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 			goto err_unlock;
 	}
 
-	if (unlikely(!kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
+	/*
+	 * We should fail if @kn has never been activated and guarantee success
+	 * if the caller knows that @kn is active. Both can be achieved by
+	 * __kernfs_active() which tests @kn->active without kernfs_rwsem.
+	 */
+	if (unlikely(!__kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
 		goto err_unlock;
 
 	spin_unlock(&kernfs_idr_lock);

