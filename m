Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FD6731454
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbjFOJoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245024AbjFOJoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:44:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCA21BF9;
        Thu, 15 Jun 2023 02:44:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 880B4223BA;
        Thu, 15 Jun 2023 09:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686822242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=n5pjg/fCgnrgGrdkPSR3HbmaWlbjpvDa5iaWKn4LzO4=;
        b=m+5VYLOA/bkv8Q28cuJEpr4tIX0dgZO4DJEtdEskOguTneqJzV8aqT0l11AV1sQwX2RSeL
        gSI0jCIE96L5GSPZ4NYHjoCXqE+lwcQzdDHq2p0evSDP9qbCdckyNdXSUZUMYrLmxNs4eZ
        N4571dOSZjzhEsRpQ1wcSDifHkFENAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686822242;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=n5pjg/fCgnrgGrdkPSR3HbmaWlbjpvDa5iaWKn4LzO4=;
        b=xUpI62rR/HvggSEP+Y1L5tDmyXpKRBHq5Ufx9Mz4We0XDj9PSecClkKZvX1LvycrNDl1+8
        8cjrTon/dtUAuRAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79C5113A47;
        Thu, 15 Jun 2023 09:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 17a1HWLdimRLWgAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 15 Jun 2023 09:44:02 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 0/2] nvme-fc: Fix blktests hangers
Date:   Thu, 15 Jun 2023 11:43:54 +0200
Message-Id: <20230615094356.14878-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple more fixes to enable blktests for the fc transport.

1) Another module unloading hanger which can be triggered with
   the nvme/048 tests:

   run blktests nvme/048 at 2023-06-06 13:04:49
   nvmet: adding nsid 1 to subsystem blktests-subsystem-1
   nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
   (NULL device *): {0:0} Association created
   [478] nvmet: ctrl 1 start keep-alive timer for 1 secs
   [478] nvmet: check nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4-af29-2168953bfc0a
   [478] nvmet: nvmet_setup_dhgroup: ctrl 1 selecting dhgroup 0
   [478] nvmet: No authentication provided
   nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4-af29-2168953bfc0a.
   [478] nvmet: adding queue 1 to ctrl 1.
   [407] nvmet: adding queue 2 to ctrl 1.
   [6549] nvmet: adding queue 3 to ctrl 1.
   [1760] nvmet: adding queue 4 to ctrl 1.
   nvme nvme2: NVME-FC{0}: controller connect complete
   nvme nvme2: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1"
   [478] nvmet: ctrl 1 reschedule traffic based keep-alive timer
   [407] nvmet: ctrl 1 update keep-alive timer for 1 secs
   nvme nvme2: NVME-FC{0}: io failed due to lldd error 6
   nvme nvme2: NVME-FC{0}: transport association event: transport detected io error
   nvme nvme2: NVME-FC{0}: resetting controller
   [478] nvmet: ctrl 1 stop keep-alive
   (NULL device *): {0:0} Association deleted
   nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
   (NULL device *): {0:0} Association freed
   (NULL device *): {0:0} Association created
   (NULL device *): Disconnect LS failed: No Association
   [407] nvmet: ctrl 1 start keep-alive timer for 1 secs
   [407] nvmet: check nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4-af29-2168953bfc0a
   [407] nvmet: nvmet_setup_dhgroup: ctrl 1 selecting dhgroup 0
   [407] nvmet: No authentication provided
   nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4-af29-2168953bfc0a.
   nvme nvme2: reconnect: revising io queue count from 4 to 1
   [478] nvmet: adding queue 1 to ctrl 1.
   nvme nvme2: NVME-FC{0}: controller connect complete
   [478] nvmet: ctrl 1 reschedule traffic based keep-alive timer
   [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [407] nvmet: ctrl 1 update keep-alive timer for 1 secs
   nvme nvme2: NVME-FC{0}: io failed due to lldd error 6
   nvme nvme2: NVME-FC{0}: transport association event: transport detected io error
   nvme nvme2: NVME-FC{0}: resetting controller
   [478] nvmet: ctrl 1 stop keep-alive
   (NULL device *): {0:0} Association deleted
   (NULL device *): {0:0} Association freed
   (NULL device *): Disconnect LS failed: No Association
   nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
   (NULL device *): {0:0} Association created
   [1760] nvmet: ctrl 1 start keep-alive timer for 1 secs
   [1760] nvmet: check nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4-af29-2168953bfc0a
   [1760] nvmet: nvmet_setup_dhgroup: ctrl 1 selecting dhgroup 0
   [1760] nvmet: No authentication provided
   nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:3d0c3f5d-cb37-4bc4-af29-2168953bfc0a.
   nvme nvme2: reconnect: revising io queue count from 1 to 4
   [478] nvmet: adding queue 1 to ctrl 1.
   [407] nvmet: adding queue 2 to ctrl 1.
   [6549] nvmet: adding queue 3 to ctrl 1.
   [1760] nvmet: adding queue 4 to ctrl 1.
   nvme nvme2: NVME-FC{0}: controller connect complete
   [1760] nvmet: ctrl 1 reschedule traffic based keep-alive timer
   [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [478] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [1760] nvmet: ctrl 1 update keep-alive timer for 1 secs
   [6549] nvmet: ctrl 1 update keep-alive timer for 1 secs
   nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
   [407] nvmet: ctrl 1 stop keep-alive
   (NULL device *): {0:0} Association deleted
   (NULL device *): {0:0} Association freed
   (NULL device *): Disconnect LS failed: No Association
   nvme_fc: nvme_fc_exit_module: waiting for ctlr deletes
   BTRFS info (device vda2): qgroup scan completed (inconsistency flag cleared)
   INFO: task modprobe:11758 blocked for more than 491 seconds.
         Tainted: G        W          6.4.0-rc2+ #3
   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
   task:modprobe        state:D stack:0     pid:11758 ppid:11585  flags:0x00004002
   Call Trace:
    <TASK>
    __schedule+0x17b5/0x4870
    ? finish_lock_switch+0x8f/0x120
    ? finish_task_switch+0x17f/0x5c0
    ? __sched_text_start+0x10/0x10
    ? __schedule+0x17bd/0x4870
    ? do_raw_spin_trylock+0xc9/0x1f0
    schedule+0xe6/0x1e0
    schedule_timeout+0x7e/0x1e0
    ? __cfi_schedule_timeout+0x10/0x10
    ? do_raw_spin_trylock+0xc9/0x1f0
    ? __cfi_lock_release+0x10/0x10
    ? do_raw_spin_unlock+0x116/0x8a0
    wait_for_common+0x377/0x600
    ? wait_for_completion+0x30/0x30
    cleanup_module+0x222/0x240 [nvme_fc bda1ef6f83d00208ba257c5d0ac34dd6bdb58bf9]
    __se_sys_delete_module+0x388/0x550
    ? __x64_sys_delete_module+0x50/0x50
    ? task_work_run+0x236/0x290
    ? syscall_enter_from_user_mode+0x2e/0x210
    do_syscall_64+0x6e/0xa0
    ? syscall_exit_to_user_mode+0x5e/0x220
    ? do_syscall_64+0x7d/0xa0
    ? syscall_exit_to_user_mode+0x5e/0x220
    ? do_syscall_64+0x7d/0xa0
    ? syscall_exit_to_user_mode+0x5e/0x220
    ? do_syscall_64+0x7d/0xa0
    entry_SYSCALL_64_after_hwframe+0x72/0xdc
   RIP: 0033:0x7fa80811aebb
   RSP: 002b:00007fff80ea0a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
   RAX: ffffffffffffffda RBX: 000055a0b5acf1f0 RCX: 00007fa80811aebb
   RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055a0b5acf258
   RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
   R10: 00007fa808193ac0 R11: 0000000000000206 R12: 00007fff80ea0ad0
   R13: 000055a0b5acf1f0 R14: 0000000000000000 R15: 0000000000000000
    </TASK>
 

2) When executing blktests nvme/030 in a tight loop, I was able to
   reproduce a different hanger. In this case the ->done() function
   was never executed on the host fc side. It turns out we didn't
   enqueue work items correctly and thus would only process one
   work item.

   run blktests nvme/030 at 2023-06-13 14:03:52
   nvmet: adding nsid 1 to subsystem blktests-subsystem-1
   nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
   (NULL device *): {0:0} Association created
   [23733] nvmet: ctrl 1 start keep-alive timer for 120 secs
   nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
   nvme nvme2: NVME-FC{0}: controller connect complete
   nvme nvme2: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
   nvme nvme2: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
   [23771] nvmet: ctrl 1 stop keep-alive
   nvmet: adding nsid 1 to subsystem blktests-subsystem-2
   (NULL device *): {0:0} Association deleted
   (NULL device *): {0:0} Association freed
   (NULL device *): Disconnect LS failed: No Association
   nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
   (NULL device *): {0:0} Association created
   [27320] nvmet: ctrl 1 start keep-alive timer for 120 secs
   nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
   nvme nvme2: NVME-FC{0}: controller connect complete
   nvme nvme2: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
   nvme nvme2: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
   [27320] nvmet: ctrl 1 stop keep-alive
   nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
   (NULL device *): {0:1} Association created
   (NULL device *): {0:0} Association deleted
   (NULL device *): {0:0} Association freed
   (NULL device *): Disconnect LS failed: No Association
   INFO: task kworker/u8:4:102 blocked for more than 491 seconds.
         Tainted: G        W          6.4.0-rc2+ #3
   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
   task:kworker/u8:4    state:D stack:0     pid:102   ppid:2      flags:0x00004000
   Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
   Call Trace:
    <TASK>
    __schedule+0x17b5/0x4870
    ? try_to_wake_up+0xb5/0xfc0
    ? __cfi_lock_release+0x10/0x10
    ? __sched_text_start+0x10/0x10
    ? _raw_spin_unlock_irqrestore+0x24/0x50
    ? lock_release+0x2aa/0xd10
    ? wq_worker_sleeping+0x1e/0x200
    schedule+0xe6/0x1e0
    schedule_timeout+0x7e/0x1e0
    ? __cfi_schedule_timeout+0x10/0x10
    ? mark_lock+0x94/0x340
    ? lockdep_hardirqs_on_prepare+0x2aa/0x5e0
    wait_for_common+0x377/0x600
    ? queue_work_on+0x57/0xa0
    ? wait_for_completion+0x30/0x30
    nvme_fc_connect_ctrl_work+0x7dc/0x1a80 [nvme_fc 39e2bf78272df3a610fb1f9884513e99038af746]
    process_one_work+0x80f/0xfb0
    ? rescuer_thread+0x1130/0x1130
    ? do_raw_spin_trylock+0xc9/0x1f0
    ? lock_acquired+0x310/0x9a0
    ? worker_thread+0xd5e/0x1260
    worker_thread+0xbde/0x1260
    kthread+0x25d/0x2f0
    ? __cfi_worker_thread+0x10/0x10
    ? __cfi_kthread+0x10/0x10
    ret_from_fork+0x29/0x50
    </TASK>
 
Daniel Wagner (2):
  nvme-fc: Do not wait in vain when unloading module
  nvme-fcloop: queue work items correctly

 drivers/nvme/host/fc.c       | 20 +++++++++++++-------
 drivers/nvme/target/fcloop.c |  8 ++++----
 2 files changed, 17 insertions(+), 11 deletions(-)

-- 
2.40.1

