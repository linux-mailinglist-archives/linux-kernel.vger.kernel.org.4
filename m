Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DC0656998
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiL0Kt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiL0KtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:49:04 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BC49580
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:49:03 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a14so8655028pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFN1R4xsle+6O8QadNOEIMFzl6CPqYVSYyaFUyY0Q9s=;
        b=cvuYV2h6elWnSQkGSlQcPx6m3Ew6IRMACmU64Uz0/GTN4u1qZqxp6S8A36JTs4b68g
         B6Y+60+d97P8acZY6/1WXln+ISLkSiwwwNq21wMGMHXYvsW9NqkQ0cD5uH0ZuRdvcgaY
         9AK/BrHOh/vkHwhw4sKj4kyKD6Thr+MsE3Gg/85gkr6qiNErC36cWd1S1RYReSd2r56/
         JEjSUxTQ4uvAppRQrY59g11AYR+fcTcAEzaopZhcwCq0E0FiSuJivPRuywScaJBoKD3k
         Ae1KTgE1Pf3+FAufm253km3alKT2zfV0Nu1H1mLqUa1RkCGFc29Ycczc5vw3yOLTdMur
         dK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFN1R4xsle+6O8QadNOEIMFzl6CPqYVSYyaFUyY0Q9s=;
        b=P+3Yd6mkEb10DA04Jh0HJAhPK0aTzbu2Wwj6e0nda3gJO5sL9RdVnbEPNjrlqceQKD
         4wW7AOHBhrvjmz7fF4jPsmNlZP4k0m0baXmkvCd95Yur+ymGJMg8T65cKoy/v3gGVR15
         eWFykCD5He53A+oRXBH7A22696TzFmz4OqOyer448iqSN32p3SN5033SKhUJY8+N1GVf
         vp8LMb7OhzkG/mOzAUGk8Ll7U1f0MM/sT1n1YkZGdqTVHUSf2nTo5928Pu+uSKm6gvCf
         ayOdSuUEx7KG05qAMsdv39lKEJ+Fkss3clNVyl2831vPe9sfiOP7/48fNWjl5O70/lT/
         qGAQ==
X-Gm-Message-State: AFqh2koW8GFy9S0J1vdHv/YbophT2dw0LyP/tXW7oXPUoTfmZCFqnuhs
        TL9hrq1SFVxXskjPGxb1YCmFdQ==
X-Google-Smtp-Source: AMrXdXsSnJ5ype6gU2BWnaBDHt82Scq0yaKTCeGbb9Wrx2gGKARAzO8SG7AOQLTgLOPgjPhBg+Tkvg==
X-Received: by 2002:a62:794e:0:b0:581:5b79:a7ad with SMTP id u75-20020a62794e000000b005815b79a7admr3739369pfc.8.1672138143138;
        Tue, 27 Dec 2022 02:49:03 -0800 (PST)
Received: from archl-hc1b.. ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id w18-20020aa79a12000000b00581816425f3sm194809pfj.112.2022.12.27.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 02:49:02 -0800 (PST)
From:   Anand Moon <anand@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, Anand Moon <anand@edgeble.ai>,
        Jagan Teki <jagan@edgeble.ai>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv3 linux-next 2/4] ARM: dts: rockchip: rv1126: Add rgmiim1 pin-control
Date:   Tue, 27 Dec 2022 10:48:32 +0000
Message-Id: <20221227104837.27208-2-anand@edgeble.ai>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221227104837.27208-1-anand@edgeble.ai>
References: <20221227104837.27208-1-anand@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ethernet pin-control for rv1126 SoC.

Reviewed-by: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
v3: add Rev by and SoB Jagan Teki.
v2: drop SoB of Jagan Teki.
---
 arch/arm/boot/dts/rv1126-pinctrl.dtsi | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/rv1126-pinctrl.dtsi b/arch/arm/boot/dts/rv1126-pinctrl.dtsi
index 4bc419cc1210..b77021772781 100644
--- a/arch/arm/boot/dts/rv1126-pinctrl.dtsi
+++ b/arch/arm/boot/dts/rv1126-pinctrl.dtsi
@@ -11,6 +11,14 @@
  * by adding changes at end of this file.
  */
 &pinctrl {
+	clk_out_ethernet {
+		/omit-if-no-ref/
+		clk_out_ethernetm1_pins: clk-out-ethernetm1-pins {
+			rockchip,pins =
+				/* clk_out_ethernet_m1 */
+				<2 RK_PC5 2 &pcfg_pull_none>;
+		};
+	};
 	emmc {
 		/omit-if-no-ref/
 		emmc_rstnout: emmc-rstnout {
@@ -61,6 +69,40 @@ i2c0_xfer: i2c0-xfer {
 				<0 RK_PB5 1 &pcfg_pull_none_drv_level_0_smt>;
 		};
 	};
+	rgmii {
+		/omit-if-no-ref/
+		rgmiim1_pins: rgmiim1-pins {
+			rockchip,pins =
+				/* rgmii_mdc_m1 */
+				<2 RK_PC2 2 &pcfg_pull_none>,
+				/* rgmii_mdio_m1 */
+				<2 RK_PC1 2 &pcfg_pull_none>,
+				/* rgmii_rxclk_m1 */
+				<2 RK_PD3 2 &pcfg_pull_none>,
+				/* rgmii_rxd0_m1 */
+				<2 RK_PB5 2 &pcfg_pull_none>,
+				/* rgmii_rxd1_m1 */
+				<2 RK_PB6 2 &pcfg_pull_none>,
+				/* rgmii_rxd2_m1 */
+				<2 RK_PC7 2 &pcfg_pull_none>,
+				/* rgmii_rxd3_m1 */
+				<2 RK_PD0 2 &pcfg_pull_none>,
+				/* rgmii_rxdv_m1 */
+				<2 RK_PB4 2 &pcfg_pull_none>,
+				/* rgmii_txclk_m1 */
+				<2 RK_PD2 2 &pcfg_pull_none_drv_level_3>,
+				/* rgmii_txd0_m1 */
+				<2 RK_PC3 2 &pcfg_pull_none_drv_level_3>,
+				/* rgmii_txd1_m1 */
+				<2 RK_PC4 2 &pcfg_pull_none_drv_level_3>,
+				/* rgmii_txd2_m1 */
+				<2 RK_PD1 2 &pcfg_pull_none_drv_level_3>,
+				/* rgmii_txd3_m1 */
+				<2 RK_PA4 2 &pcfg_pull_none_drv_level_3>,
+				/* rgmii_txen_m1 */
+				<2 RK_PC6 2 &pcfg_pull_none_drv_level_3>;
+		};
+	};
 	sdmmc0 {
 		/omit-if-no-ref/
 		sdmmc0_bus4: sdmmc0-bus4 {
-- 
2.39.0

