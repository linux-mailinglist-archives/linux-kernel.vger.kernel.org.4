Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63927645AA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiLGNTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLGNTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:19:45 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B14140BC;
        Wed,  7 Dec 2022 05:19:43 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id D722E240008;
        Wed,  7 Dec 2022 13:19:40 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        William Wu <william.wu@rock-chips.com>,
        Bin Yang <yangbin@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 1/3] usb: dwc2: disable lpm feature on Rockchip SoCs
Date:   Wed,  7 Dec 2022 14:19:16 +0100
Message-Id: <20221206-dwc2-gadget-dual-role-v1-1-36515e1092cd@theobroma-systems.com>
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

LPM feature of DWC2 module integrated in Rockchip SoCs doesn't work
properly or needs some additional handling, so disable it for now.
Without disabling LPM feature, the USB ADB communication fail with
the following error log:

dwc2 ff580000.usb: new address 27
dwc2 ff580000.usb: Failed to exit L1 sleep state in 200us.
dwc2 ff580000.usb: dwc2_hsotg_send_reply: cannot queue req
dwc2 ff580000.usb: dwc2_hsotg_process_req_status: failed to send reply
dwc2 ff580000.usb: dwc2_hsotg_enqueue_setup: failed queue (-11)
dwc2 ff580000.usb: Failed to exit L1 sleep state in 200us.

Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
[diff vs vendor kernel: added lpm_clock_gating, besl and
 hird_threshold_en settings as seen in  commit 53febc956900 ("usb: dwc2:
 disable Link Power Management on STM32MP15 HS OTG")]
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/usb/dwc2/params.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 8eab5f38b1101..9ed9fd9569404 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -113,6 +113,10 @@ static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 <<
 		GAHBCFG_HBSTLEN_SHIFT;
 	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
+	p->lpm = false;
+	p->lpm_clock_gating = false;
+	p->besl = false;
+	p->hird_threshold_en = false;
 }
 
 static void dwc2_set_ltq_params(struct dwc2_hsotg *hsotg)

-- 
b4 0.10.1
