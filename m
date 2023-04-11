Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0446DDA42
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDKMH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDKMH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:07:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA38272A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:07:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 40E311FDE0;
        Tue, 11 Apr 2023 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681214845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CY6u9OiVsw2eK1cAkqe1rwv42GQahD0MpOgUCcwxNro=;
        b=fdp7+GD3t7pSVJ1rpRXaheEYW4rNDZwC7DQLwYC2RUVcrWJRYWiFujYybk8WJ4ftqpKveK
        8TjSNULrfn9uFN4glq9mR5DLRObjJxe98X+D7A0qeS0/IfRjgvzPvtyZsMNqwDLWlFi4ut
        5CjsypOAU/NqIgrookaC49G6/9knSZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681214845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CY6u9OiVsw2eK1cAkqe1rwv42GQahD0MpOgUCcwxNro=;
        b=x37nl0mnwX8qkg1vZyDo0G8yolfNzS9X3SAFlc0knrlH5aTTUGGU6dEikrgfMbToRmYmj4
        s0fQR6o584CmOEAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 323E113638;
        Tue, 11 Apr 2023 12:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ecc2DH1NNWR3BgAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 12:07:25 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/4] nvmet-fcloop: unblock module removal
Date:   Tue, 11 Apr 2023 14:07:14 +0200
Message-Id: <20230411120718.14477-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blktests is not able to unload the FC related modules. It is possible to unload
the modules but it still will not work correctly. The host and the controller
seem to be in a kind of live deadlock:

 loop: module loaded
 run blktests nvme/003 at 2023-04-11 13:55:57
 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
 nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
 (NULL device *): {0:0} Association created
 [71] nvmet: ctrl 1 start keep-alive timer for 120 secs
 nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
 nvme nvme0: NVME-FC{0}: controller connect complete
 nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
 nvme nvme1: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
 (NULL device *): {0:1} Association created
 [453] nvmet: ctrl 2 start keep-alive timer for 5 secs
 nvmet: creating nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
 [71] nvmet: adding queue 1 to ctrl 2.
 [45] nvmet: adding queue 2 to ctrl 2.
 [453] nvmet: adding queue 3 to ctrl 2.
 [105] nvmet: adding queue 4 to ctrl 2.
 nvme nvme1: NVME-FC{1}: controller connect complete
 nvme nvme1: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1"
 [453] nvmet: ctrl 2 reschedule traffic based keep-alive timer
 [105] nvmet: ctrl 2 update keep-alive timer for 5 secs
 [105] nvmet: ctrl 2 update keep-alive timer for 5 secs
 nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
 [45] nvmet: ctrl 1 stop keep-alive
 (NULL device *): {0:0} Association deleted
 (NULL device *): {0:0} Association freed
 (NULL device *): Disconnect LS failed: No Association
 nvme nvme1: rescanning namespaces.
 nvme nvme1: NVME-FC{1}: io failed due to lldd error 6
 nvme nvme1: NVME-FC{1}: transport association event: transport detected io error
 nvme nvme1: NVME-FC{1}: resetting controller
 [105] nvmet: ctrl 2 stop keep-alive
 nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
 (NULL device *): {0:1} Association deleted
 (NULL device *): {0:0} Association created
 (NULL device *): {0:1} Association freed
 nvmet: connect request for invalid subsystem nqn.2014-08.org.nvmexpress.discovery!
 nvme nvme0: Connect Invalid Data Parameter, subsysnqn "nqn.2014-08.org.nvmexpress.discovery"
 (NULL device *): Disconnect LS failed: No Association
 nvme nvme1: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
 nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (16770)
 (NULL device *): {0:1} Association created
 nvme nvme0: NVME-FC{0}: reconnect failure
 nvmet: connect request for invalid subsystem blktests-subsystem-1!
 nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
 nvme nvme1: Connect Invalid Data Parameter, subsysnqn "blktests-subsystem-1"
 nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
 nvme nvme1: NVME-FC{1}: reset: Reconnect attempt failed (16770)
 nvme nvme1: NVME-FC{1}: reconnect failure
 nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
 (NULL device *): {0:0} Association deleted
 (NULL device *): {0:0} Association freed
 (NULL device *): Disconnect LS failed: No Association
 (NULL device *): {0:1} Association deleted
 (NULL device *): {0:1} Association freed
 (NULL device *): Disconnect LS failed: No Association
 nvmet_fc: nvmet_fc_exit_module: targetport list not empty

I think these patches here are not very controversial and should propably go in
even if we still haven't fix for the above scenario.

v2:
  - added additional fixes

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
 drivers/nvme/target/fcloop.c |  5 ++++-
 3 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.40.0

