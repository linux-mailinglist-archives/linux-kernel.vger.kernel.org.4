Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD969336F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBKUAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKUAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:00:16 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F729166C4;
        Sat, 11 Feb 2023 12:00:15 -0800 (PST)
Received: from fpc.. (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id F051440737BD;
        Sat, 11 Feb 2023 20:00:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F051440737BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1676145614;
        bh=93bV2WieYLWq+kaliUadEmc3b0Jd3KUsc6VwwvEQkXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2LAA5q9yi+O797y4LwnxNt+wc6wL6UkGwdDvtSfCds1jUaCddLqKlmmkEU/Am5qY
         J8CuW7TBzaUdIEp7Za5ECsaKOVOClDqhe2ITB/iK98YqiPsNvwBEcN+iXRr0+Qdd8j
         he9igLohqF8Z9nJBreq8RRHl/drYcNPZeSnt9TyM=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Ian Kent <raven@themaw.net>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Takeshi Misawa <jeliantsurux@gmail.com>,
        autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        syzbot+5e53f70e69ff0c0a1c0c@syzkaller.appspotmail.com
Subject: [PATCH 1/1] autofs: fix memory leak of waitqueues in autofs_catatonic_mode
Date:   Sat, 11 Feb 2023 22:59:50 +0300
Message-Id: <20230211195950.452364-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230211195950.452364-1-pchelkin@ispras.ru>
References: <20230211195950.452364-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reports a memory leak:

BUG: memory leak
unreferenced object 0xffff88810b279e00 (size 96):
  comm "syz-executor399", pid 3631, jiffies 4294964921 (age 23.870s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 9e 27 0b 81 88 ff ff  ..........'.....
    08 9e 27 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ..'.............
  backtrace:
    [<ffffffff814cfc90>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1046
    [<ffffffff81bb75ca>] kmalloc include/linux/slab.h:576 [inline]
    [<ffffffff81bb75ca>] autofs_wait+0x3fa/0x9a0 fs/autofs/waitq.c:378
    [<ffffffff81bb88a7>] autofs_do_expire_multi+0xa7/0x3e0 fs/autofs/expire.c:593
    [<ffffffff81bb8c33>] autofs_expire_multi+0x53/0x80 fs/autofs/expire.c:619
    [<ffffffff81bb6972>] autofs_root_ioctl_unlocked+0x322/0x3b0 fs/autofs/root.c:897
    [<ffffffff81bb6a95>] autofs_root_ioctl+0x25/0x30 fs/autofs/root.c:910
    [<ffffffff81602a9c>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81602a9c>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81602a9c>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81602a9c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff84608225>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608225>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

autofs_wait_queue structs should be freed if their wait_ctr becomes zero.
Otherwise they will be lost.

In this case an AUTOFS_IOC_EXPIRE_MULTI ioctl is done, then a new
waitqueue struct is allocated in autofs_wait(), its initial wait_ctr
equals 2. After that wait_event_killable() is interrupted (it returns
-ERESTARTSYS), so that 'wq->name.name == NULL' condition may be not
satisfied. Actually, this condition can be satisfied when
autofs_wait_release() or autofs_catatonic_mode() is called and, what is
also important, wait_ctr is decremented in those places. Upon the exit of
autofs_wait(), wait_ctr is decremented to 1. Then the unmounting process
begins: kill_sb calls autofs_catatonic_mode(), which should have freed the
waitqueues, but it only decrements its usage counter to zero which is not
a correct behaviour.

So in catatonic mode we should free waitqueues which counter becomes zero.

Reported-by: syzbot+5e53f70e69ff0c0a1c0c@syzkaller.appspotmail.com
Suggested-by: Takeshi Misawa <jeliantsurux@gmail.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 fs/autofs/waitq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 54c1f8b8b075..efdc76732fae 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -32,8 +32,9 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name.name - wq->offset);
 		wq->name.name = NULL;
-		wq->wait_ctr--;
 		wake_up_interruptible(&wq->queue);
+		if (!--wq->wait_ctr)
+			kfree(wq);
 		wq = nwq;
 	}
 	fput(sbi->pipe);	/* Close the pipe */
-- 
2.34.1

