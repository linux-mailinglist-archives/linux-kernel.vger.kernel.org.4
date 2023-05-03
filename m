Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46106F537E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjECIkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjECIje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:39:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5018E4EE8;
        Wed,  3 May 2023 01:39:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 118CC21E2D;
        Wed,  3 May 2023 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683103099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xSSkXVe1t4+y8aarOchJvEGbB8BgCUoCkb7YG1lURIU=;
        b=VpEQY5CfEMc3+JhWpnWPZ2aUtGmR2UTr2NTOjznUJI1Y2CFed3lXxt2Kt8HMjhdALSDq3t
        KJ8QJzuWKDzQRgL5gmSH8Tejpapgup+x3nIGUj3AUiWsI829n+NoKtcWErGSiz44E3n0Ve
        PAKdL5kORLfx+Z2qJXWgSjRlREQvNAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683103099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xSSkXVe1t4+y8aarOchJvEGbB8BgCUoCkb7YG1lURIU=;
        b=4I7KDceQZa/IOuVyeAF5u+CTeA4jviHAlt+N8asTEIt9Yg6q7N72JL94neFsFblFNpxglG
        Vqm/5DEQ+nCIRyAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2612139F8;
        Wed,  3 May 2023 08:38:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2mcnO3odUmSudQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:38:18 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 0/2] nvme_trtype=fc fixes
Date:   Wed,  3 May 2023 10:38:14 +0200
Message-Id: <20230503083816.18792-1-dwagner@suse.de>
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

I've dropped the unrelated rdma change from v2. With the kernel patches

  https://lore.kernel.org/linux-nvme/20230418130159.11075-1-dwagner@suse.de/

I get this here:

# nvme_img_size=16M nvme_num_iter=10 nvme_trtype=fc ./check nvme
nvme/002 (create many subsystems and test discovery)         [not run]
    nvme_trtype=fc is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.252s  ...  10.259s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.662s  ...  1.810s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.905s  ...  1.925s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.161s  ...  0.149s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.132s  ...  0.098s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.776s  ...  1.760s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.665s  ...  1.738s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  2.693s  ...  2.744s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  2.981s  ...  3.066s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [not run]
    nvme_img_size must be at least 350m
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [not run]
    nvme_img_size must be at least 350m
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  1.976s  ...  1.963s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  1.945s  ...  1.787s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    nvme_trtype=fc is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    nvme_trtype=fc is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.773s  ...  1.779s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.738s  ...  1.806s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.600s  ...  1.596s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.698s  ...  1.735s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.831s  ...  1.853s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.762s  ...  1.800s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.722s  ...  1.747s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.713s  ...  1.725s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.672s  ...  1.731s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.719s  ...  1.764s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.702s  ...  1.701s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.053s  ...  2.180s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.683s  ...  0.631s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  3.438s  ...  3.770s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.053s  ...  0.057s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O)
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.737s  ...  7.819srk/blktests/results/tmpdir.nvme.040.5O2': Directory not empty
nvme/041 (Create authenticated connections)                 
    runtime  0.275s  ...
WARNING: Test did not clean up fc device: nvme1
nvme/041 (Create authenticated connections)                  [failed]
    runtime  0.275s  ...  0.384s
    --- tests/nvme/041.out      2023-04-18 17:43:18.167745976 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/041.out.bad 2023-05-03 10:28:09.639741275 +0200
    @@ -1,6 +1,8 @@
     Running nvme/041
     Test unauthenticated connection (should fail)
    +failed to lookup subsystem for controller nvme1
     NQN:blktests-subsystem-1 disconnected 0 controller(s)
     Test authenticated connection
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +failed to lookup subsystem for controller nvme1
    ...
    (Run 'diff -u tests/nvme/041.out /home/wagi/work/blktests/results/nodev/nvme/041.out.bad' to see the entire diff)
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  4.377s  ...  4.613s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  2.895s  ...  2.736s
nvme/044 (Test bi-directional authentication)               
    runtime  1.125s  ...
WARNING: Test did not clean up fc device: nvme1
nvme/044 (Test bi-directional authentication)                [failed]
    runtime  1.125s  ...  1.133s
    --- tests/nvme/044.out      2023-04-18 17:43:18.167745976 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/044.out.bad 2023-05-03 10:28:20.343798581 +0200
    @@ -2,9 +2,12 @@
     Test host authentication
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test invalid ctrl authentication (should fail)
    +failed to lookup subsystem for controller nvme1
     NQN:blktests-subsystem-1 disconnected 0 controller(s)
     Test valid ctrl authentication
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    ...
    (Run 'diff -u tests/nvme/044.out /home/wagi/work/blktests/results/nodev/nvme/044.out.bad' to see the entire diff)
nvme/045 (Test re-authentication)                            [passed]
    runtime  5.689s  ...  5.835s
nvme/047 (test different queue types for fabric transports)  [not run]
    nvme_trtype=fc is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [failed]
    runtime  16.271s  ...  15.564s
    --- tests/nvme/048.out      2023-04-18 17:43:18.171745996 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/048.out.bad 2023-05-03 10:28:43.931924866 +0200
    @@ -1,3 +1,7 @@
     Running nvme/048
    +expected state "connecting" not  reached within 5 seconds
    +FAIL
    +expected state "connecting" not  reached within 5 seconds
    +FAIL
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete

changes:
v3:
 - changed subject prefix
 - drop the rdma cleanup reordering part

v2:
  - release fc resource in reverse order
  - https://lore.kernel.org/linux-nvme/20230419084757.24846-1-dwagner@suse.de/
v1:
  - https://lore.kernel.org/linux-nvme/20230418123252.3725-1-dwagner@suse.de/

Daniel Wagner (2):
  nvme/rc: Cleanup fc ports in reverse order
  nvme/rc: Cleanup fc resource before module unloading

 tests/nvme/rc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.40.0

