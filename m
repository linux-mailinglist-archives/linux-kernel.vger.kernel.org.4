Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2345738A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjFUP6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjFUP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:58:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25053E2;
        Wed, 21 Jun 2023 08:58:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C88A01FF04;
        Wed, 21 Jun 2023 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687363119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Z1pyl5WK5UaVsChPbUuWx8TlPJRxgAguKY43gUgCHuk=;
        b=ZLm6WsKQNrxHwRIlJmQhIXDGro4VV6VZwzvYMDOiA1NEIC9vvoYtzyMCz+oS3UF2GgVLw8
        UZORHIErrCZblVbO0BWccEC0+BIE1G2srApilaOage0oS2pyTZbrNBFMBZQxJNiu0chGlZ
        EGizsKNvuz30uXVd+T8BaYCIzzC2JPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687363119;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Z1pyl5WK5UaVsChPbUuWx8TlPJRxgAguKY43gUgCHuk=;
        b=SIzt9XL3KIo8BUIAkrIE63I9NMOL5gAKOUg0Qd23J2CqaIvvs9brATGGSo2Djcpilsl038
        GtSZdZAfoNBNIjCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9378134B1;
        Wed, 21 Jun 2023 15:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sRUyLS8ek2RHMgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 21 Jun 2023 15:58:39 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin George <Martin.George@netapp.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 0/1] Test case for 'nvme: short-circuit connection retries'
Date:   Wed, 21 Jun 2023 17:58:24 +0200
Message-ID: <20230621155825.20146-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
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

We had a longer discussion on how to interpret the DNR bit on reconnect attempts
in [1]. The conclusion was (if I got this right) is we should not try to reconnect
when the error response had the DNR bit set using the same parameters.

The FC transport already implemented this behavior with

  f25f8ef70ce2 ("nvme-fc: short-circuit reconnect retries")

Hannes also provided patches for TCP and RDMA [2]. With these patches this test
will pass.

The nvme/050 implements this test case by (ab)using the queue count mechanism to
trigger a reconnect. Before the reconnect is triggered the tests set the
allowed_any_host attribute to 0 and forces the reconnect to fail.

[1] https://lore.kernel.org/linux-nvme/20220927143157.3659-1-dwagner@suse.de/
[2] https://lore.kernel.org/linux-nvme/20220715063356.134124-1-hare@suse.de/


This patch is based on top of
  blktests: https://lore.kernel.org/linux-nvme/20230620132703.20648-1-dwagner@suse.de/
  linux: https://lore.kernel.org/linux-nvme/20230620133711.22840-1-dwagner@suse.de/


fc:

nvme/050 (test DNR is handled on connect attempt with invalid arguments) [passed]
    runtime  8.845s  ...  3.756s

tcp:

nvme/050 (test DNR is handled on connect attempt with invalid arguments) [failed]
    runtime  3.756s  ...  8.836s
    --- tests/nvme/050.out      2023-06-21 11:47:47.767788898 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/050.out.bad 2023-06-21 15:19:08.368414289 +0200
    @@ -1,2 +1,3 @@
     Running nvme/050
    +controller "nvme2" not deleted within 5 seconds
     Test complete

fc:

 run blktests nvme/050 at 2023-06-21 15:11:31
 loop0: detected capacity change from 0 to 32768
 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
 nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
 (NULL device *): {0:0} Association created
 [7088] nvmet: ctrl 1 start keep-alive timer for 5 secs
 nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a.
 [6743] nvmet: adding queue 1 to ctrl 1.
 [6312] nvmet: adding queue 2 to ctrl 1.
 [7088] nvmet: adding queue 3 to ctrl 1.
 [6927] nvmet: adding queue 4 to ctrl 1.
 nvme nvme2: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1"
 nvme nvme2: NVME-FC{0}: io failed due to lldd error 6
 nvme nvme2: NVME-FC{0}: transport association event: transport detected io error
 nvme nvme2: NVME-FC{0}: resetting controller
 [7088] nvmet: ctrl 1 stop keep-alive
 (NULL device *): {0:0} Association deleted
 nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
 (NULL device *): {0:0} Association freed
 (NULL device *): {0:0} Association created
 (NULL device *): Disconnect LS failed: No Association
 nvmet: connect by host nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a for subsystem blktests-subsystem-1 not allowed
 nvme_fabrics: nvmf_log_connect_error: DNR 1
 nvme nvme2: Connect for subsystem blktests-subsystem-1 is not allowed, hostnqn: nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a
 nvme nvme2: NVME-FC{0}: reset: Reconnect attempt failed (16772)
 nvme nvme2: NVME-FC{0}: reconnect failure
 nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
 (NULL device *): {0:0} Association deleted
 (NULL device *): {0:0} Association freed
 (NULL device *): Disconnect LS failed: No Association

tcp:

 run blktests nvme/050 at 2023-06-21 15:11:36
 loop0: detected capacity change from 0 to 32768
 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
 nvmet_tcp: enabling port 0 (127.0.0.1:4420)
 [62] nvmet: ctrl 1 start keep-alive timer for 5 secs
 nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a.
 nvme nvme2: creating 4 I/O queues.
 nvme nvme2: mapped 4/0/0 default/read/poll queues.
 [62] nvmet: adding queue 1 to ctrl 1.
 [214] nvmet: adding queue 2 to ctrl 1.
 [215] nvmet: adding queue 3 to ctrl 1.
 [177] nvmet: adding queue 4 to ctrl 1.
 nvme nvme2: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
 nvme nvme2: starting error recovery
 nvme nvme2: Reconnecting in 1 seconds...
 [6743] nvmet: ctrl 1 stop keep-alive
 nvmet: connect by host nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a for subsystem blktests-subsystem-1 not allowed
 nvme_fabrics: nvmf_log_connect_error: DNR 1
 nvme nvme2: Connect for subsystem blktests-subsystem-1 is not allowed, hostnqn: nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a
 nvme nvme2: failed to connect queue: 0 ret=16772
 nvme nvme2: Failed reconnect attempt 1
 nvme nvme2: Reconnecting in 1 seconds...
 nvmet: connect by host nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a for subsystem blktests-subsystem-1 not allowed
 nvme_fabrics: nvmf_log_connect_error: DNR 1
 nvme nvme2: Connect for subsystem blktests-subsystem-1 is not allowed, hostnqn: nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a
 nvme nvme2: failed to connect queue: 0 ret=16772
 nvme nvme2: Failed reconnect attempt 2
 nvme nvme2: Reconnecting in 1 seconds...
 nvmet: connect by host nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a for subsystem blktests-subsystem-1 not allowed
 nvme_fabrics: nvmf_log_connect_error: DNR 1
 nvme nvme2: Connect for subsystem blktests-subsystem-1 is not allowed, hostnqn: nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a
 nvme nvme2: failed to connect queue: 0 ret=16772
 nvme nvme2: Failed reconnect attempt 3
 nvme nvme2: Reconnecting in 1 seconds...
 nvmet: connect by host nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a for subsystem blktests-subsystem-1 not allowed
 nvme_fabrics: nvmf_log_connect_error: DNR 1
 nvme nvme2: Connect for subsystem blktests-subsystem-1 is not allowed, hostnqn: nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a
 nvme nvme2: failed to connect queue: 0 ret=16772
 nvme nvme2: Failed reconnect attempt 4
 nvme nvme2: Reconnecting in 1 seconds...
 nvmet: connect by host nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a for subsystem blktests-subsystem-1 not allowed
 nvme_fabrics: nvmf_log_connect_error: DNR 1
 nvme nvme2: Connect for subsystem blktests-subsystem-1 is not allowed, hostnqn: nqn.2014-08.org.nvmexpress:uuid:77b49aba-06b4-431a-9af8-75e318740f1a
 nvme nvme2: failed to connect queue: 0 ret=16772
 nvme nvme2: Failed reconnect attempt 5
 nvme nvme2: Reconnecting in 1 seconds...
 nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
 nvme nvme2: Property Set error: 880, offset 0x14

Daniel Wagner (1):
  nvme/050: test DNR handling on reconnect

 tests/nvme/050     | 126 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out |   2 +
 2 files changed, 128 insertions(+)
 create mode 100644 tests/nvme/050
 create mode 100644 tests/nvme/050.out

-- 
2.41.0

