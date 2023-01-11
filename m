Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A101A6661FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjAKRbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239644AbjAKR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:28:44 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C853DBE4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:24:54 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so20785657pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrnP374OLqQox6yNLama6RD8TqjNv743WGDKqrtWcqc=;
        b=McNc+Klm8bXRlr6O1q4qWW5BwulSqCy4gqqIMn0+CQu2O0rs9oonXR0kbFItNUoUwB
         rk2cyr7ClUoOsgzHxXoyTq+aPDLNqjA0Q878btaoEhEuVLwoIqCgBXmW3m0v3H+JNf7F
         A7zA9W8iKnHbN5vRr7AmaSdXVyJRGga4wVOGYAtu+Pb5I4urSYHpuIP3FLbt5n0ajTJR
         TDBEFQT+2YLvm0/hg451DYVQ8nM271lCarBGiR4LE/oKPwbhWoY5ucQLIJtuuaPCSw6M
         t4eIRd3KJAtOkY7iHKGwYgfDBEv9xWqpcSOuhjI7T/lVWnHQ0Iw0RAWT2jLkZ53inrlq
         raxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrnP374OLqQox6yNLama6RD8TqjNv743WGDKqrtWcqc=;
        b=yojmeP4VYBrcjh1Vha0u41OETnHRucT4pLK5ej9KNoI7Wtmpzk3LHOQGS+m8catvtc
         Ncc9BOlK2nnC59jm7l65E9OrlRsk56d8RpsWe65yq9S3WN0XK4Rb98gWyFX4RDL0LkuA
         xd9L+1eJrDE9oXbrtkSV0mhCpgG1OZ4zWrXGx72QrkgPAS8D7TqqRLEVkwdbZmqQSL/E
         RMqVJ1TMIqag9+DPSmDzerJQi/TdrerFLc8t7oB+/A+iEpCEbTpUO8ihGjl1e45iSzL1
         /LTFsPH1kwGU8QJb07JNkcM8wxoGMYTp385oGYSyXn5TipHEwFK28K4c78w/mijLR773
         wqgQ==
X-Gm-Message-State: AFqh2kq+x3qMmQ4u3nCSKDPzJ+Ns/g6iXl7i9ppyi/LPuafZibnDAyGG
        08VtTIg/aZoMtXYfxa5kOLtE1A==
X-Google-Smtp-Source: AMrXdXvxMAo84bW3XcTC5ybOyCCRbJnCG67wgbIbJaCywRhTaUaj42SsCQsydRtaAsDAtIRmreOzQQ==
X-Received: by 2002:a17:90a:e02:b0:227:1017:ee71 with SMTP id v2-20020a17090a0e0200b002271017ee71mr11916866pje.33.1673457893586;
        Wed, 11 Jan 2023 09:24:53 -0800 (PST)
Received: from archl-hc1b.. ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id rm14-20020a17090b3ece00b00218fa115f83sm11110722pjb.57.2023.01.11.09.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:24:53 -0800 (PST)
From:   Anand Moon <anand@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, Anand Moon <anand@edgeble.ai>,
        Jagan Teki <jagan@edgeble.ai>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 linux-next 2/4] ARM: dts: rockchip: rv1126: Add ethernet rgmiim1 pin-control
Date:   Wed, 11 Jan 2023 17:24:32 +0000
Message-Id: <20230111172437.5295-2-anand@edgeble.ai>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111172437.5295-1-anand@edgeble.ai>
References: <20230111172437.5295-1-anand@edgeble.ai>
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

Co-Developed-by: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
v5: add Cod of Jagan
v4: drop Rev by Jagan: Both SoB and RoB of same person is incorrect.
    update the $subject.
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

