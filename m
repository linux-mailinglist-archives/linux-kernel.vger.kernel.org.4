Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C977C6BB662
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjCOOpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjCOOpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:45:07 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EFD7EEB;
        Wed, 15 Mar 2023 07:45:04 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FAR1Yl018817;
        Wed, 15 Mar 2023 15:44:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=R+9Q/84aRguOkrbuEcVpRrUSAL1kHPOZZn9+ptjgzkw=;
 b=Y1RkDh260UO0oFcvEv9kK138Cx6yHE9LBVSSbt0Em2J6o9x+oHSpfMsRzXzbHkrFNgO1
 /avevxBhoWlvcXWQGwuUWgdgh9Kj+t9YEqxB5nKmVTjIcRKNWPMm12hZ03haw81Cn30q
 X3VKGuWimG+ZlCiFXEyY1XbKly7vEocmPupQnSlxzPlE4xF55pra3VMiUttrUQFRke2v
 4zNwQhIYcZFRcE7QbORxjGpmGLGfwmgp0ZhiJIzC0+4Db7rjvoiJHcDqj9gKAhjrsKHA
 uNlgfY6nO4oJHOZiRi3yc7og5OFNmfSBmb5bImremjgGGSqdf/FkTF0oRn5iZEtSnoze hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pb2aqw7hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 15:44:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B9FA100034;
        Wed, 15 Mar 2023 15:44:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CAD9021ADDD;
        Wed, 15 Mar 2023 15:44:56 +0100 (CET)
Received: from localhost (10.48.1.102) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 15 Mar
 2023 15:44:55 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <quentin.schulz@theobroma-systems.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH] usb: dwc2: fix a race, don't power off/on phy for dual-role mode
Date:   Wed, 15 Mar 2023 15:44:33 +0100
Message-ID: <20230315144433.3095859-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_08,2023-03-15_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When in dual role mode (dr_mode == USB_DR_MODE_OTG), platform probe
successively basically calls:
- dwc2_gadget_init()
- dwc2_hcd_init()
- dwc2_lowlevel_hw_disable() since recent change [1]
- usb_add_gadget_udc()

The PHYs (and so the clocks it may provide) shouldn't be disabled for all
SoCs, in OTG mode, as the HCD part has been initialized.

On STM32 this creates some weird race condition upon boot, when:
- initially attached as a device, to a HOST
- and there is a gadget script invoked to setup the device part.
Below issue becomes systematic, as long as the gadget script isn't
started by userland: the hardware PHYs (and so the clocks provided by the
PHYs) remains disabled.
It ends up in having an endless interrupt storm, before the watchdog
resets the platform.

[   16.924163] dwc2 49000000.usb-otg: EPs: 9, dedicated fifos, 952 entries in SPRAM
[   16.962704] dwc2 49000000.usb-otg: DWC OTG Controller
[   16.966488] dwc2 49000000.usb-otg: new USB bus registered, assigned bus number 2
[   16.974051] dwc2 49000000.usb-otg: irq 77, io mem 0x49000000
[   17.032170] hub 2-0:1.0: USB hub found
[   17.042299] hub 2-0:1.0: 1 port detected
[   17.175408] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently in Host mode
[   17.181741] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently in Host mode
[   17.189303] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently in Host mode
...

The host part is also not functional, until the gadget part is configured.

The HW may only be disabled for peripheral mode (original init), e.g.
dr_mode == USB_DR_MODE_PERIPHERAL, until the gadget driver initializes.

But when in USB_DR_MODE_OTG, the HW should remain enabled, as the HCD part
is able to run, while the gadget part isn't necessarily configured.

I don't fully get the of purpose the original change, that claims disabling
the hardware is missing. It creates conditions on SOCs using the PHY
initialization to be completely non working in OTG mode. Original
change [1] should be reworked to be platform specific.

[1] https://lore.kernel.org/r/20221206-dwc2-gadget-dual-role-v1-2-36515e1092cd@theobroma-systems.com

Fixes: ade23d7b7ec5 ("usb: dwc2: power on/off phy for peripheral mode in dual-role mode")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/dwc2/gadget.c   | 6 ++----
 drivers/usb/dwc2/platform.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 62fa6378d2d7..8b15742d9e8a 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4549,8 +4549,7 @@ static int dwc2_hsotg_udc_start(struct usb_gadget *gadget,
 	hsotg->gadget.dev.of_node = hsotg->dev->of_node;
 	hsotg->gadget.speed = USB_SPEED_UNKNOWN;
 
-	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL ||
-	    (hsotg->dr_mode == USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg))) {
+	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL) {
 		ret = dwc2_lowlevel_hw_enable(hsotg);
 		if (ret)
 			goto err;
@@ -4612,8 +4611,7 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
 	if (!IS_ERR_OR_NULL(hsotg->uphy))
 		otg_set_peripheral(hsotg->uphy->otg, NULL);
 
-	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL ||
-	    (hsotg->dr_mode == USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg)))
+	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
 		dwc2_lowlevel_hw_disable(hsotg);
 
 	return 0;
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 23ef75996823..262c13b6362a 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -576,8 +576,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	dwc2_debugfs_init(hsotg);
 
 	/* Gadget code manages lowlevel hw on its own */
-	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL ||
-	    (hsotg->dr_mode == USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg)))
+	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
 		dwc2_lowlevel_hw_disable(hsotg);
 
 #if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
-- 
2.25.1

