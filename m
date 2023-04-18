Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB56E5FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjDRLSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjDRLSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:18:23 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8896619AA;
        Tue, 18 Apr 2023 04:17:36 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id F24565FD78;
        Tue, 18 Apr 2023 14:16:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681816581;
        bh=MDzMe5CZfB1jJP7T11BEyo9k6M0Db32prO+SmusTuWw=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=brqLeNnHFhrcMVFs0R8yx2+7mwYyq+eOWHy5gKsQDSSPFOT7vG87eoE21J0MCPUtj
         /ZDLMSEpazMaB90uVs0YZdxxHZ7tOmH1cTT114+/ioSqRj/FsNG0Sp6dXxdFAaa1OX
         rKSIS8T9C8d5kkEeelMcSH88IvZqE4VcFgSF9189TzLEDVJ49KX/mNmRM7CNd7BN4s
         z/Qv7rzi2lLNjo+HKfZ4RDa7QP25N+bNu+y5IyVdZcn9ztNZXrPxytrGFO3+Vj+p6H
         G8OSARnLw0zTmHuJdvWWGWSFpibgD/h+oSUZaKgWAADMczYKrHxgbQgkD6xSvatfc7
         UTNN778qGqelw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 18 Apr 2023 14:16:20 +0300 (MSK)
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
Subject: [PATCH v2 1/5] phy: amlogic: enable/disable clkin during Amlogic USB PHY init/exit
Date:   Tue, 18 Apr 2023 14:16:08 +0300
Message-ID: <20230418111612.19479-2-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230418111612.19479-1-ddrokosov@sberdevices.ru>
References: <20230418111612.19479-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/18 05:44:00 #21123121
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, all Amlogic boards used the XTAL clock as the default board
clock for the USB PHY input, so there was no need to enable it.
However, with the introduction of new Amlogic SoCs like the A1 family,
the USB PHY now uses a gated clock. Hence, it is necessary to enable
this gated clock during the PHY initialization sequence, or disable it
during the PHY exit, as appropriate.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/phy/amlogic/phy-meson-g12a-usb2.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
index 9d1efa0d9394..80938751da4f 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
@@ -172,10 +172,16 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 	int ret;
 	unsigned int value;
 
-	ret = reset_control_reset(priv->reset);
+	ret = clk_prepare_enable(priv->clk);
 	if (ret)
 		return ret;
 
+	ret = reset_control_reset(priv->reset);
+	if (ret) {
+		clk_disable_unprepare(priv->clk);
+		return ret;
+	}
+
 	udelay(RESET_COMPLETE_TIME);
 
 	/* usb2_otg_aca_en == 0 */
@@ -277,8 +283,11 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 static int phy_meson_g12a_usb2_exit(struct phy *phy)
 {
 	struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
+	int ret = reset_control_reset(priv->reset);
+
+	clk_disable_unprepare(priv->clk);
 
-	return reset_control_reset(priv->reset);
+	return ret;
 }
 
 /* set_mode is not needed, mode setting is handled via the UTMI bus */
-- 
2.36.0

