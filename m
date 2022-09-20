Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB65BE557
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiITMMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiITMMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:12:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF16A494
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86E51B82884
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C6FC433C1;
        Tue, 20 Sep 2022 12:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663675929;
        bh=jvuFGIULX8oXMR4ltvFXg4hxYJPD0wE9EXhLXqHl1cs=;
        h=From:To:Cc:Subject:Date:From;
        b=KW14w/s6JVBGAwySzV0uhC5Hvn7Tx4NKADW5+4wEhiQyc22LyRuKfWOnXh6z+/wus
         YAmZtTLqQwxffoejMPq67n8n8TEkfOeEnEsHZRgHaYOy7kpfrwBlBFStx89x8qWoIz
         yL4KJJUPRB0iOUTDg19x6fnAy1renU0cgcKN+nBnvaYBjSLbnDetTdD0of/G9c4fyZ
         6SIGKS3qNUL3Wc2zp+hLQt6cjl0gdNa0PFzRNoLyvyHmj9jR4Zs/ZrzBEZTxn7YToE
         Y+J6UJ6th3fKK+nU7gzlyXA1c80yxo/qyK00qZn5Pw38VNUupGO/AW/sbailk68z78
         9IlJ/+RB+h4hw==
Received: by pali.im (Postfix)
        id 3ACDE97E; Tue, 20 Sep 2022 14:12:06 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: Reset COMPHY registers before USB 3.0 power on
Date:   Tue, 20 Sep 2022 14:11:54 +0200
Message-Id: <20220920121154.30115-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turris MOX board with older ARM Trusted Firmware version v1.5 is not able
to detect any USB 3.0 device connected to USB-A port on Mox-A module after
commit 0a6fc70d76bd ("phy: marvell: phy-mvebu-a3700-comphy: Remove broken
reset support"). On the other hand USB 2.0 devices connected to the same
USB-A port are working fine.

It looks as if the older firmware configures COMPHY registers for USB 3.0
somehow incompatibly for kernel driver. Experiments show that resetting
COMPHY registers via setting SFT_RST auto-clearing bit in COMPHY_SFT_RESET
register fixes this issue.

Reset the COMPHY in mvebu_a3700_comphy_usb3_power_on() function as a first
step after selecting COMPHY lane and USB 3.0 function. With this change
Turris MOX board can successfully detect USB 3.0 devices again.

Before the above mentioned commit this reset was implemented in PHY reset
method, so this is the reason why there was no issue with older firmware
version then.

Fixes: 0a6fc70d76bd ("phy: marvell: phy-mvebu-a3700-comphy: Remove broken reset support")
Reported-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
Shinichiro, could you please check that all USB functionality still
works correctly on your board?
---
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
index 67712c77d806..d641b345afa3 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -826,6 +826,9 @@ mvebu_a3700_comphy_usb3_power_on(struct mvebu_a3700_comphy_lane *lane)
 	if (ret)
 		return ret;
 
+	/* COMPHY register reset (cleared automatically) */
+	comphy_lane_reg_set(lane, COMPHY_SFT_RESET, SFT_RST, SFT_RST);
+
 	/*
 	 * 0. Set PHY OTG Control(0x5d034), bit 4, Power up OTG module The
 	 * register belong to UTMI module, so it is set in UTMI phy driver.
-- 
2.20.1

