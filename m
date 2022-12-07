Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F039645AA7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLGNT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLGNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:19:50 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A870140F7;
        Wed,  7 Dec 2022 05:19:49 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 72C2B24000F;
        Wed,  7 Dec 2022 13:19:44 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        William Wu <william.wu@rock-chips.com>,
        Bin Yang <yangbin@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 3/3] usb: dwc2: prevent core phy initialisation
Date:   Wed,  7 Dec 2022 14:19:18 +0100
Message-Id: <20221206-dwc2-gadget-dual-role-v1-3-36515e1092cd@theobroma-systems.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206-dwc2-gadget-dual-role-v1-0-36515e1092cd@theobroma-systems.com>
References: <20221206-dwc2-gadget-dual-role-v1-0-36515e1092cd@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

From: Bin Yang <yangbin@rock-chips.com>

The usb phys need to be controlled dynamically on some Rockchip SoCs.
So set the new HCD flag which prevents USB core from trying to manage
our phys.

Signed-off-by: Bin Yang <yangbin@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/usb/dwc2/hcd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 657f1f659ffaf..757a66fa32fa8 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5315,6 +5315,13 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 	if (!IS_ERR_OR_NULL(hsotg->uphy))
 		otg_set_host(hsotg->uphy->otg, &hcd->self);
 
+	/*
+	 * do not manage the PHY state in the HCD core, instead let the driver
+	 * handle this (for example if the PHY can only be turned on after a
+	 * specific event)
+	 */
+	hcd->skip_phy_initialization = 1;
+
 	/*
 	 * Finish generic HCD initialization and start the HCD. This function
 	 * allocates the DMA buffer pool, registers the USB bus, requests the

-- 
b4 0.10.1
