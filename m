Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEB164EF1F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiLPQaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiLPQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:30:11 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B905D6AC;
        Fri, 16 Dec 2022 08:30:09 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 26CC0E000F;
        Fri, 16 Dec 2022 16:30:05 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bin Yang <yangbin@rock-chips.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v2 1/2] usb: dwc2: allow platforms to prevent core phy initialisation
Date:   Fri, 16 Dec 2022 17:29:28 +0100
Message-Id: <20221206-dwc2-gadget-dual-role-v2-1-0de821615dd3@theobroma-systems.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206-dwc2-gadget-dual-role-v2-0-0de821615dd3@theobroma-systems.com>
References: <20221206-dwc2-gadget-dual-role-v2-0-0de821615dd3@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-141d4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Some USB PHYs need to be controlled dynamically on some platforms.

Let's allow platforms to define whether they should prevent core PHY
initialization by providing a "shadow" value to HCD's
skip_phy_initialization flag before HCD is actually created (e.g. from
a dwc2_set_*_params callback).

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/usb/dwc2/core.h | 6 ++++++
 drivers/usb/dwc2/hcd.c  | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 40cf2880d7e5..6aa9aeb374eb 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -423,6 +423,10 @@ enum dwc2_ep0_state {
  *                      0 - No
  *                      1 - Yes
  *
+ * @hcd_skip_phy_initialization: Shadow value of HCD skip_phy_initialization
+ *				 flag.
+ *				 See include/linux/usb/hcd.h for documentation.
+ *
  * The following parameters may be specified when starting the module. These
  * parameters define how the DWC_otg controller should be configured. A
  * value of -1 (or any other out of range value) for any parameter means
@@ -499,6 +503,8 @@ struct dwc2_core_params {
 	u32 g_tx_fifo_size[MAX_EPS_CHANNELS];
 
 	bool change_speed_quirk;
+
+	unsigned hcd_skip_phy_initialization:1;
 };
 
 /**
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 657f1f659ffa..e2fa9a491cab 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5315,6 +5315,8 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 	if (!IS_ERR_OR_NULL(hsotg->uphy))
 		otg_set_host(hsotg->uphy->otg, &hcd->self);
 
+	hcd->skip_phy_initialization = hsotg->params.hcd_skip_phy_initialization;
+
 	/*
 	 * Finish generic HCD initialization and start the HCD. This function
 	 * allocates the DMA buffer pool, registers the USB bus, requests the

-- 
2.38.1
