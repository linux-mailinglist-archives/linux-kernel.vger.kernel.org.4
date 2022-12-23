Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4956550FB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiLWNZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbiLWNZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:25:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E31313CFC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:25:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so4971335pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiT9KYDx3RWtZOPtEp+4OpN+KsQgOdSJKLeTP2zJWcs=;
        b=GkBa160SclbJh4m4+Uvp0lPozlPivWtIJN0Ejk04u5nAj/brwEzVRt0PVJCx0DFy4B
         cjQlwmXKnSoFJjWvq4NQZHUOL4jD+fcp680/1S2mx8RmC1R5F1noBoBbtbpPxxrjnZTF
         F2PC6MW6KblVmd3dTCn3dNBnKhSuNmHakt+b82Jm+DmgUN4Yxagsoxo9Lobf/19Bk8hS
         bT9AYYB5MqfoimYFLS/gGwVBm5h7j2ZTdoDhiTFtV4nRbrt1fCaq6Vtwr6Z7Cn/bwNsT
         2FdjeQo2h2vSxMbZc+wRSINIfsDs5tDOOGGdH08Qqk4MdDc9UJNmCHnQOidfb7RbHMZT
         atGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiT9KYDx3RWtZOPtEp+4OpN+KsQgOdSJKLeTP2zJWcs=;
        b=hEWB7fV7B3WAVtDuFOjb8eldvERYm4PPpXGAlA1GWNg5mSLPObhNONuy2KiBlfY46j
         JO5mJXRq3al7yMNJfExMo9tvjQzEBbUdzTcv+0CIGoMGI8EWjmhfBbREK8fHl6A/Nrfg
         3V7r92KJYHq9n2x0M/aIT/YSJimL63yLR46DEHwCBSHQDDN9vqYchQD+NKoKqZAnbdxr
         MC6ZPPzwOraYPrpwVFEPivCaOIV34ZS3CDWUg9jnT+eZWfA035LONHvVuLuKUA05Omfk
         Vriq7Sd31CugbNr3wzk4Fe/UHygILhz8ls+vhlxhylw4ABnkeCB6+JkWrTWqyu+n2w2r
         /XZQ==
X-Gm-Message-State: AFqh2kqAenlaFnR/LJclcwhS0cgEcc8kqgeIlaHmtcQxHEJ1i4RBPc+g
        8ShO1AfM7XK7slS/VRHOmM6Owayd7HA8a054+n4=
X-Google-Smtp-Source: AMrXdXti9h/NrRYG5tbJrKi6OGMy8J3N5HQuTT5LyCzyDyi8oa6oBJO6uPoipFdscTyMJ6g5+ihMgA==
X-Received: by 2002:a05:6a20:bb10:b0:ad:2c7c:9510 with SMTP id fc16-20020a056a20bb1000b000ad2c7c9510mr10966527pzb.19.1671801952092;
        Fri, 23 Dec 2022 05:25:52 -0800 (PST)
Received: from archl-hc1b.. ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id m3-20020a635803000000b0047681fa88d1sm1308587pgb.53.2022.12.23.05.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 05:25:51 -0800 (PST)
From:   Anand Moon <anand@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Anand Moon <anand@edgeble.ai>, Jagan Teki <jagan@edgeble.ai>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv1 linux-next 2/4] ARM: dts: rockchip: rv1126: Add rgmiim1 pin-control
Date:   Fri, 23 Dec 2022 13:22:31 +0000
Message-Id: <20221223132235.16149-2-anand@edgeble.ai>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221223132235.16149-1-anand@edgeble.ai>
References: <20221223132235.16149-1-anand@edgeble.ai>
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

Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
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

