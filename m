Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FDE6E26DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjDNPYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDNPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:24:37 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2E88A5A;
        Fri, 14 Apr 2023 08:24:35 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 4C8645FD25;
        Fri, 14 Apr 2023 18:24:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681485873;
        bh=09WqdKYRyw2DjfHpWjzV6C/vopcEZSQEhMfI25aDH40=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=SHKv3Sz6dKqRl3xEMp3YCFcI87PO0RRN6UG+Ap/geWAsxptpePbI9uV9og2cLbym+
         31Ya1Biqp7lNlZi2VZha/RlhuZfIewNctx6BDQTUFFRKr6TWRrCB2iDh9Tzs8tUnG5
         pj5/YVqlXFgmVoCjVGfv/vRA6Xd2YDGT5iq41z5bB3oZ690XEtg4Hq5Go0zho0Hwgc
         rh5PfU7wTjZqpK13jAktPzoI2aFqQS1Ug0g+ewLCOUe+Eif6K4fAIkJi3jKjI0wzaH
         1DOmj68rBYrvtnnfLy+ZklpiD58kNAgvtnsnkQzUw5Lv5zFlAisl4l4aHJijJOpgNy
         xQqXeJ1niLmRg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 14 Apr 2023 18:24:33 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <mturquette@baylibre.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <hminas@synopsys.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <yue.wang@amlogic.com>, <hanjie.lin@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-phy@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1 2/5] usb: dwc2: support dwc2 IP for Amlogic A1 SoC family
Date:   Fri, 14 Apr 2023 18:24:20 +0300
Message-ID: <20230414152423.19842-3-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230414152423.19842-1-ddrokosov@sberdevices.ru>
References: <20230414152423.19842-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/14 08:08:00 #21104846
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic A1 uses dwc2 Synopsys IP as its USB peripheral (gadget)
endpoint, with different DWC2 parameters when compared to previous
Amlogic SoCs.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/usb/dwc2/params.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 9ed9fd956940..098fbfc774ab 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -161,6 +161,25 @@ static void dwc2_set_amlogic_g12a_params(struct dwc2_hsotg *hsotg)
 	p->hird_threshold_en = false;
 }
 
+static void dwc2_set_amlogic_a1_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->otg_caps.hnp_support = false;
+	p->otg_caps.srp_support = false;
+	p->speed = DWC2_SPEED_PARAM_HIGH;
+	p->host_rx_fifo_size = 192;
+	p->host_nperio_tx_fifo_size = 128;
+	p->host_perio_tx_fifo_size = 128;
+	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
+	p->phy_utmi_width = 8;
+	p->ahbcfg = GAHBCFG_HBSTLEN_INCR8 << GAHBCFG_HBSTLEN_SHIFT;
+	p->lpm = false;
+	p->lpm_clock_gating = false;
+	p->besl = false;
+	p->hird_threshold_en = false;
+}
+
 static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
@@ -258,6 +277,8 @@ const struct of_device_id dwc2_of_match_table[] = {
 	  .data = dwc2_set_amlogic_params },
 	{ .compatible = "amlogic,meson-g12a-usb",
 	  .data = dwc2_set_amlogic_g12a_params },
+	{ .compatible = "amlogic,meson-a1-usb",
+	  .data = dwc2_set_amlogic_a1_params },
 	{ .compatible = "amcc,dwc-otg", .data = dwc2_set_amcc_params },
 	{ .compatible = "apm,apm82181-dwc-otg", .data = dwc2_set_amcc_params },
 	{ .compatible = "st,stm32f4x9-fsotg",
-- 
2.36.0

