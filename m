Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C96E6538
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjDRNCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjDRNCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:02:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3542126AE;
        Tue, 18 Apr 2023 06:02:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B54D31F8D7;
        Tue, 18 Apr 2023 13:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681822929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YmGp27V7vgaUQ2zzNolY+Ow/6qOXdLQK1cMzzRDMuOk=;
        b=TaqJz3lZ9k/JoSEsopHdTwbbvy1xzajMsauU/asXld2VdNGbINE1d4vJMk7EexpwQr3WM5
        EE+Uv6CWnJ3w7KgaA8652FNurshiZximbz0QuB8aVheYUcupwancHXaJP3/Ffb1tqzYgD8
        yXjDglvaOQM8PL3by9STJV2q1axcWxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681822929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YmGp27V7vgaUQ2zzNolY+Ow/6qOXdLQK1cMzzRDMuOk=;
        b=7ldHwj8B7xsHusrsjiTm5Y5kIGlLISsrljbhlm3lZl3QTHFXgwrslVLYfoS+pr1wAoZvfV
        cP60mqwTym1YS3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3D3E139EC;
        Tue, 18 Apr 2023 13:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hED5J9GUPmR8JwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 13:02:09 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 0/4] nvmet-fcloop: unblock module removal
Date:   Tue, 18 Apr 2023 15:01:55 +0200
Message-Id: <20230418130159.11075-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
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

I got it somewhat working with this version here and the blktest fcloop cleanup
fix[1].

There is a BIG if though. I have to disable manually the auto connect udev rules
from the host system. I've played a bit around how to disable them during
runtime. There is a way to inject a runtime global variable into udev rules via
'udevadm control -p BLKTESTS=1'. The udev rule file can then be extended with a
rule like 'ENV{BLKTESTS}="1", GOTO=...' but I was not able to get this working
reliable. It looks like the update is not getting promotted to all udev daemon
threads. Even a 'sleep 5' or 'udevadm settle' didn't help.

The only way I found so far is to do

  ln -s /dev/null /etc/udev/rules.d/70-nvmf-autoconnect.rules

which obviously sucks. IIRC, Martin B has the same issue with nvme-stats and
nvme-cli...

Anyway, it doesn't creash anymore and there are not warning from lockdep or
KASAN. The first few tests cases are passing. So the failing ones could actually
be 'real' bugs, who knows :)

# nvme_trtype=fc ./check nvme
nvme/002 (create many subsystems and test discovery)         [not run]
    nvme_trtype=fc is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller)
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.277s  ...  10.479srt: No such file or directory
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.976s  ...  1.723s
nvme/005 (reset local loopback target)                       [passed]
    runtime  2.203s  ...  1.829s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.248s  ...  0.221s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.156s  ...  0.127s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.945s  ...  1.658s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.854s  ...  1.711s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  44.555s  ...  41.625s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  89.795s  ...  71.931s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  61.607s  ...  49.917s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  109.725s  ...  79.189s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  7.902s  ...  5.977s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  7.229s  ...  5.734s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    runtime  44.446s  ...  
    nvme_trtype=fc is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    runtime  45.306s  ...  
    nvme_trtype=fc is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.834s  ...  1.721s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.832s  ...  1.804s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.811s  ...  1.717s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.807s  ...  1.703s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.914s  ...  1.784s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.852s  ...  1.730s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.730s  ...  1.754s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.759s  ...  1.719s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.764s  ...  1.675s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.734s  ...  1.703s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.831s  ...  1.732s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.388s  ...  2.065s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.756s  ...  0.631s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  4.566s  ...  3.441s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.054s  ...  0.055s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O)
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.948s  ...  7.866srk/blktests/results/tmpdir.nvme.040.4lT': Directory not empty
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
    runtime  0.964s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/041 (Create authenticated connections)                  [failed]
    runtime  0.964s  ...  0.311s
    --- tests/nvme/041.out      2023-02-20 10:31:10.953935278 +0100
    +++ /home/wagi/work/blktests/results/nodev/nvme/041.out.bad 2023-04-18 14:31:05.122062907 +0200
    @@ -1,6 +1,8 @@
     Running nvme/041
     Test unauthenticated connection (should fail)
    +failed to lookup subsystem for controller nvme0
     NQN:blktests-subsystem-1 disconnected 0 controller(s)
     Test authenticated connection
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +failed to lookup subsystem for controller nvme0
    ...
    (Run 'diff -u tests/nvme/041.out /home/wagi/work/blktests/results/nodev/nvme/041.out.bad' to see the entire diff)
WARNING: Test did not clean up fc device: nvme0
failed to lookup subsystem for controller nvme0
Did not find device nvme0
nvme/042 (Test dhchap key types for authenticated connections) [failed]
    runtime  4.495s  ...  4.226s
    --- tests/nvme/042.out      2022-08-30 10:20:14.174819528 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/042.out.bad 2023-04-18 14:31:09.654086133 +0200
    @@ -1,7 +1,9 @@
     Running nvme/042
     Testing hmac 0
    +failed to lookup subsystem for controller nvme0
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Testing hmac 1
    +failed to lookup subsystem for controller nvme0
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
    ...
    (Run 'diff -u tests/nvme/042.out /home/wagi/work/blktests/results/nodev/nvme/042.out.bad' to see the entire diff)
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  3.592s  ...  8.750s
nvme/044 (Test bi-directional authentication)               
    runtime  1.099s  ...
WARNING: Test did not clean up fc device: nvme0
nvme/044 (Test bi-directional authentication)                [failed]
    runtime  1.099s  ...  1.064s
    --- tests/nvme/044.out      2023-02-20 10:31:10.953935278 +0100
    +++ /home/wagi/work/blktests/results/nodev/nvme/044.out.bad 2023-04-18 14:31:20.042139370 +0200
    @@ -2,9 +2,12 @@
     Test host authentication
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test invalid ctrl authentication (should fail)
    +failed to lookup subsystem for controller nvme0
     NQN:blktests-subsystem-1 disconnected 0 controller(s)
     Test valid ctrl authentication
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    ...
    (Run 'diff -u tests/nvme/044.out /home/wagi/work/blktests/results/nodev/nvme/044.out.bad' to see the entire diff)
WARNING: Test did not clean up fc device: nvme0
failed to lookup subsystem for controller nvme0
Did not find device nvme0
nvme/045 (Test re-authentication)                            [passed]
    runtime  5.582s  ...  6.262s
nvme/047 (test different queue types for fabric transports)  [not run]
    nvme_trtype=fc is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [failed]
    runtime  15.586s  ...  16.545s
    --- tests/nvme/048.out      2023-04-06 10:12:58.333064747 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/048.out.bad 2023-04-18 14:31:43.614260172 +0200
    @@ -1,3 +1,7 @@
     Running nvme/048
    +expected state "connecting" not  reached within 5 seconds
    +FAIL
    +expected state "connecting" not  reached within 5 seconds
    +FAIL
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete

[1] https://lore.kernel.org/linux-nvme/20230418123252.3725-1-dwagner@suse.de/

changes:
v3:
  - do not unlink rport twice

v2:
  - added additional fixes
  - https://lore.kernel.org/linux-nvme/20230411120718.14477-1-dwagner@suse.de/

v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20230411092209.12719-1-dwagner@suse.de/

Daniel Wagner (4):
  nvmet-fcloop: Remove remote port from list when unlinking
  nvmet-fcloop: Do not wait on completion when unregister fails
  nvmet-fc: Do not wait in vain when unloading module
  nvmet-fc: Release reference on target port

 drivers/nvme/host/fc.c       | 20 +++++++++++++-------
 drivers/nvme/target/fc.c     |  1 +
 drivers/nvme/target/fcloop.c | 10 ++++------
 3 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.40.0

