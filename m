Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029BA724205
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbjFFMYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjFFMY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:24:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957410C3;
        Tue,  6 Jun 2023 05:24:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE1D91FD67;
        Tue,  6 Jun 2023 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686054262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nv039ijnnfMsX6t+ULMzYy3KDMKTfCs6xgYzSU+unSk=;
        b=f/0FLFEpZstNEVxmd90E5Cii68oOxvsxjA5/z1KNGpV5J7FeBCRRc00v1fmQN0m1PRYFVp
        djD5onE9ZU4/UY06ooBjWAJp98p153MwYMk2rGDC3R5XilDaCwqE0C1v9OYS+6Oo/zbWie
        Ovb0zDljWpveCBxExtP9ifHf99oBsoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686054262;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nv039ijnnfMsX6t+ULMzYy3KDMKTfCs6xgYzSU+unSk=;
        b=Qu4gWkZek7l/XHofzq2+ELWEwHC7HgFWCQ4o9UZ1HqSQURt7apz0aPw5v8ssiVsGM+EPvp
        cbnTUtVejR4sAVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 971C113519;
        Tue,  6 Jun 2023 12:24:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cTDeJHYlf2R+OAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 06 Jun 2023 12:24:22 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 0/1] nvmet-fcloop: unblock module removal
Date:   Tue,  6 Jun 2023 14:24:10 +0200
Message-Id: <20230606122411.7972-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.1
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

With the recent FC related changes in blktests we only need one patch to unlock
all tests. That means blktests is able to run through all tests but not all will
passs. These fail look like real bugs in the FC code except nvme/040. I do see
the unload loop module failure also with tcp, rdma and loop.

We have an issue open on github to track the 'module unload before fc resource
cleanup' bug:

  https://github.com/osandov/blktests/issues/120

Anyway, let's address one thing at the time:

The nvme/048 will block forever on the current nvme-6.4 branch:

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
  INFO: lockdep is turned off.
 

with the patch nvme/048 test will at least terminate:


  # nvme_trtype=fc nvme_img_size=16M nvme_num_iter=10 ./check nvme
  nvme/002 (create many subsystems and test discovery)         [not run]
      nvme_trtype=fc is not supported in this test
  nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
      runtime  10.337s  ...  10.413s
  nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
      runtime  1.817s  ...  1.988s
  nvme/005 (reset local loopback target)                       [passed]
      runtime  1.951s  ...  2.128s
  nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
      runtime  0.176s  ...  0.271s
  nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
      runtime  0.124s  ...  0.191s
  nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
      runtime  1.899s  ...  2.062s
  nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
      runtime  1.815s  ...  2.004s
  nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
      runtime  2.795s  ...  3.367s
  nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
      runtime  3.196s  ...  3.934s
  nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [not run]
      nvme_img_size must be at least 350m
  nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [not run]
      nvme_img_size must be at least 350m
  nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
      runtime  2.012s  ...  2.270s
  nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
      runtime  1.953s  ...  2.237s
  nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
      nvme_trtype=fc is not supported in this test
  nvme/017 (create/delete many file-ns and test discovery)     [not run]
      nvme_trtype=fc is not supported in this test
  nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
      runtime  1.862s  ...  1.996s
  nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
      runtime  1.807s  ...  2.075s
  nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
      runtime  1.739s  ...  1.926s
  nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
      runtime  1.807s  ...  2.041s
  nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
      runtime  1.944s  ...  2.066s
  nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
      runtime  1.772s  ...  1.901s
  nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
      runtime  1.800s  ...  1.997s
  nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
      runtime  1.806s  ...  1.955s
  nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
      runtime  1.837s  ...  1.945s
  nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
      runtime  1.762s  ...  2.006s
  nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
      runtime  1.801s  ...  2.102s
  nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
      runtime  2.175s  ...  2.597s
  nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
      runtime  0.616s  ...  0.805s
  nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
      runtime  3.415s  ...  4.329s
  nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
      runtime  0.064s  ...  0.114s
  nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O)
  nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
      runtime  7.854s  ...  8.058srk/blktests/results/tmpdir.nvme.040.qkb': Directory not empty
  modprobe: FATAL: Module loop is in use.
  modprobe: FATAL: Module loop is in use.
  modprobe: FATAL: Module loop is in use.
  modprobe: FATAL: Module loop is in use.
  modprobe: FATAL: Module loop is in use.
  modprobe: FATAL: Module loop is in use.
  modprobe: FATAL: Module loop is in use.
  modprobe: FATAL: Module loop is in use.
  modprobe: FATAL: Module loop is in use.
  modprobe: FATAL: Module loop is in use.
  nvme/041 (Create authenticated connections)                 
      runtime  0.302s  ...
  WARNING: Test did not clean up fc device: nvme2
  nvme/041 (Create authenticated connections)                  [failed]
      runtime  0.302s  ...  0.435s
      --- tests/nvme/041.out      2023-04-18 17:43:18.167745976 +0200
      +++ /home/wagi/work/blktests/results/nodev/nvme/041.out.bad 2023-06-06 14:07:48.836546072 +0200
      @@ -1,6 +1,8 @@
       Running nvme/041
       Test unauthenticated connection (should fail)
      +failed to lookup subsystem for controller nvme2
       NQN:blktests-subsystem-1 disconnected 0 controller(s)
       Test authenticated connection
      -NQN:blktests-subsystem-1 disconnected 1 controller(s)
      +failed to lookup subsystem for controller nvme2
      ...
      (Run 'diff -u tests/nvme/041.out /home/wagi/work/blktests/results/nodev/nvme/041.out.bad' to see the entire diff)
  nvme/042 (Test dhchap key types for authenticated connections) [passed]
      runtime  4.832s  ...  4.489s
  nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
      runtime  2.698s  ...  9.475s
  nvme/044 (Test bi-directional authentication)               
      runtime  1.205s  ...
  WARNING: Test did not clean up fc device: nvme2
  nvme/044 (Test bi-directional authentication)                [failed]
      runtime  1.205s  ...  1.048s
      --- tests/nvme/044.out      2023-04-18 17:43:18.167745976 +0200
      +++ /home/wagi/work/blktests/results/nodev/nvme/044.out.bad 2023-06-06 14:08:08.524660313 +0200
      @@ -2,9 +2,12 @@
       Test host authentication
       NQN:blktests-subsystem-1 disconnected 1 controller(s)
       Test invalid ctrl authentication (should fail)
      +failed to lookup subsystem for controller nvme2
       NQN:blktests-subsystem-1 disconnected 0 controller(s)
       Test valid ctrl authentication
      -NQN:blktests-subsystem-1 disconnected 1 controller(s)
      ...
      (Run 'diff -u tests/nvme/044.out /home/wagi/work/blktests/results/nodev/nvme/044.out.bad' to see the entire diff)
  nvme/045 (Test re-authentication)                            [passed]
      runtime  6.133s  ...  4.742s
  nvme/047 (test different queue types for fabric transports)  [not run]
      nvme_trtype=fc is not supported in this test
  nvme/048 (Test queue count changes on reconnect)             [failed]
      runtime  16.300s  ...  16.278s
      --- tests/nvme/048.out      2023-06-05 17:20:59.370208331 +0200
      +++ /home/wagi/work/blktests/results/nodev/nvme/048.out.bad 2023-06-06 14:08:33.720806513 +0200
      @@ -1,3 +1,7 @@
       Running nvme/048
      +expected state "connecting" not  reached within 5 seconds
      +FAIL
      +expected state "connecting" not  reached within 5 seconds
      +FAIL
       NQN:blktests-subsystem-1 disconnected 1 controller(s)
       Test complete
  

Daniel Wagner (1):
  nvmet-fcloop: Do not wait on completion when unregister fails

changes:
v4:
  - drop module unload before fc resource cleanup patches
 
v3:
  - do not unlink rport twice
  - https://lore.kernel.org/linux-nvme/20230418130159.11075-1-dwagner@suse.de/

v2:
  - added additional fixes
  - https://lore.kernel.org/linux-nvme/20230411120718.14477-1-dwagner@suse.de/

v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20230411092209.12719-1-dwagner@suse.de/
  
 drivers/nvme/target/fcloop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.40.1

