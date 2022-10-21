Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C96606DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJUCeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJUCej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:34:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B139F36BDF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A70FCB8291C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55601C4FEB9;
        Fri, 21 Oct 2022 02:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666319674;
        bh=580rqartSgXXhJapFprYMMcudTR1XAKCGjA2+wbw7n0=;
        h=From:To:Cc:Subject:Date:From;
        b=CGXMB7pFLUwX0p6r8P7m3dddcVf8gdsoPBzDzWG0l+lK/r7v4x/nEExifC6QyObmF
         zAnu7jChIwUvsGFqnK41++j/hSrhpfsACUVDVWOI5XTyro93r/zqZUjlfU1s4m77KO
         gjqVYYBnxYfTCKIBZUCE/XVIM2525JQpSVOA1RnXeJBniR5Xj0KbHz8Vuy+LYvHAdX
         SGWaZcMXu6qXTtPCJaHNDnckA3feuWCls0b6S4w9Tu0AZnsTXh9K9cqMPRFzCJAP19
         HqgLHGyUtF9/jcVtOSazyp3M7QQNBurKnP45rBSOglYk+si+KlBoB1PGRiSt20KUYK
         XTXirLrSraxZw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        syzbot+035a381ea1afb63f098d@syzkaller.appspotmail.com,
        syzbot+729c925c2d9fc495ddee@syzkaller.appspotmail.com
Subject: [PATCH v2] f2fs: fix to invalidate dcc->f2fs_issue_discard in error path
Date:   Fri, 21 Oct 2022 10:34:22 +0800
Message-Id: <20221021023422.3101585-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reports a NULL pointer dereference issue as below:

 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 get_task_struct include/linux/sched/task.h:110 [inline]
 kthread_stop+0x34/0x1c0 kernel/kthread.c:703
 f2fs_stop_discard_thread+0x3c/0x5c fs/f2fs/segment.c:1638
 kill_f2fs_super+0x5c/0x194 fs/f2fs/super.c:4522
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x14c kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x26c/0xbe0 kernel/exit.c:795
 do_group_exit+0x60/0xe8 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __wake_up_parent+0x0/0x40 kernel/exit.c:934
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

The root cause of this issue is in error path of f2fs_start_discard_thread(),
it missed to invalidate dcc->f2fs_issue_discard, later kthread_stop() may
access invalid pointer.

Fixes: 4d67490498ac ("f2fs: Don't create discard thread when device doesn't support realtime discard")
Reported-by: syzbot+035a381ea1afb63f098d@syzkaller.appspotmail.com
Reported-by: syzbot+729c925c2d9fc495ddee@syzkaller.appspotmail.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add more commit message and Fixes and Reported-by tag.
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index acf3d3fa4363..7a4f7c88b8b9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2025,8 +2025,10 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
 
 	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
 				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
-	if (IS_ERR(dcc->f2fs_issue_discard))
+	if (IS_ERR(dcc->f2fs_issue_discard)) {
 		err = PTR_ERR(dcc->f2fs_issue_discard);
+		dcc->f2fs_issue_discard = NULL;
+	}
 
 	return err;
 }
-- 
2.25.1

