Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC27B725F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjFGMgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjFGMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:36:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E63310F8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:36:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3DFF21FDB0;
        Wed,  7 Jun 2023 12:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686141403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PGvn6ZdohOOtVUUdOvyiYpScXO3VVCt1a9Kf6pUq/oo=;
        b=c+AMWVzZLkboDs3i9HYvNVea+80TZY8OLFt31HnDAQD8RVVGlB/WU3txkylDnJV+TljaBf
        Uuxyhud9XLrbu6MzRg6uAjrkRJnWOHLj9hpjrtFfE4ZBWBMvoFRH7OoVldnlUA0WhSjxoI
        Onf1if4shMM1/GQMrW0D95Yx3gFqGFw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19A4713776;
        Wed,  7 Jun 2023 12:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ubJ8Bdt5gGQySgAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Wed, 07 Jun 2023 12:36:43 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] xen/xenbus: Avoid a lockdep warning when adding a watch
Date:   Wed,  7 Jun 2023 14:36:24 +0200
Message-Id: <20230607123624.15739-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following lockdep warning appears during boot on a Xen dom0 system:

[   96.388794] ======================================================
[   96.388797] WARNING: possible circular locking dependency detected
[   96.388799] 6.4.0-rc5-default+ #8 Tainted: G            EL
[   96.388803] ------------------------------------------------------
[   96.388804] xenconsoled/1330 is trying to acquire lock:
[   96.388808] ffffffff82acdd10 (xs_watch_rwsem){++++}-{3:3}, at: register_xenbus_watch+0x45/0x140
[   96.388847]
               but task is already holding lock:
[   96.388849] ffff888100c92068 (&u->msgbuffer_mutex){+.+.}-{3:3}, at: xenbus_file_write+0x2c/0x600
[   96.388862]
               which lock already depends on the new lock.

[   96.388864]
               the existing dependency chain (in reverse order) is:
[   96.388866]
               -> #2 (&u->msgbuffer_mutex){+.+.}-{3:3}:
[   96.388874]        __mutex_lock+0x85/0xb30
[   96.388885]        xenbus_dev_queue_reply+0x48/0x2b0
[   96.388890]        xenbus_thread+0x1d7/0x950
[   96.388897]        kthread+0xe7/0x120
[   96.388905]        ret_from_fork+0x2c/0x50
[   96.388914]
               -> #1 (xs_response_mutex){+.+.}-{3:3}:
[   96.388923]        __mutex_lock+0x85/0xb30
[   96.388930]        xenbus_backend_ioctl+0x56/0x1c0
[   96.388935]        __x64_sys_ioctl+0x90/0xd0
[   96.388942]        do_syscall_64+0x5c/0x90
[   96.388950]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   96.388957]
               -> #0 (xs_watch_rwsem){++++}-{3:3}:
[   96.388965]        __lock_acquire+0x1538/0x2260
[   96.388972]        lock_acquire+0xc6/0x2b0
[   96.388976]        down_read+0x2d/0x160
[   96.388983]        register_xenbus_watch+0x45/0x140
[   96.388990]        xenbus_file_write+0x53d/0x600
[   96.388994]        vfs_write+0xe4/0x490
[   96.389003]        ksys_write+0xb8/0xf0
[   96.389011]        do_syscall_64+0x5c/0x90
[   96.389017]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   96.389023]
               other info that might help us debug this:

[   96.389025] Chain exists of:
                 xs_watch_rwsem --> xs_response_mutex --> &u->msgbuffer_mutex

[   96.413429]  Possible unsafe locking scenario:

[   96.413430]        CPU0                    CPU1
[   96.413430]        ----                    ----
[   96.413431]   lock(&u->msgbuffer_mutex);
[   96.413432]                                lock(xs_response_mutex);
[   96.413433]                                lock(&u->msgbuffer_mutex);
[   96.413434]   rlock(xs_watch_rwsem);
[   96.413436]
                *** DEADLOCK ***

[   96.413436] 1 lock held by xenconsoled/1330:
[   96.413438]  #0: ffff888100c92068 (&u->msgbuffer_mutex){+.+.}-{3:3}, at: xenbus_file_write+0x2c/0x600
[   96.413446]

An ioctl call IOCTL_XENBUS_BACKEND_SETUP (record #1 in the report)
results in calling xenbus_alloc() -> xs_suspend() which introduces
ordering xs_watch_rwsem --> xs_response_mutex. The xenbus_thread()
operation (record #2) creates xs_response_mutex --> &u->msgbuffer_mutex.
An XS_WATCH write to the xenbus file then results in a complain about
the opposite lock order &u->msgbuffer_mutex --> xs_watch_rwsem.

The dependency xs_watch_rwsem --> xs_response_mutex is spurious. Avoid
it and the warning by changing the ordering in xs_suspend(), first
acquire xs_response_mutex and then xs_watch_rwsem. Reverse also the
unlocking order in xs_suspend_cancel() for consistency, but keep
xs_resume() as is because it needs to have xs_watch_rwsem unlocked only
after exiting xs suspend and re-adding all watches.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/xen/xenbus/xenbus_xs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 12e02eb01f59..028a182bcc9e 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -840,8 +840,8 @@ void xs_suspend(void)
 {
 	xs_suspend_enter();
 
-	down_write(&xs_watch_rwsem);
 	mutex_lock(&xs_response_mutex);
+	down_write(&xs_watch_rwsem);
 }
 
 void xs_resume(void)
@@ -866,8 +866,8 @@ void xs_resume(void)
 
 void xs_suspend_cancel(void)
 {
-	mutex_unlock(&xs_response_mutex);
 	up_write(&xs_watch_rwsem);
+	mutex_unlock(&xs_response_mutex);
 
 	xs_suspend_exit();
 }
-- 
2.35.3

