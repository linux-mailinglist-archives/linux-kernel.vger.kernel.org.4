Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD6655100
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiLWN0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiLWN0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:26:09 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760553EAD5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:26:04 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn22so4943814plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5TFO0ecJqFSWeM6hfq5fazXKqNWla1DOE+uuMQWKOY=;
        b=ViC80PP7cGI3SuzqsLmaZkriwH8PZ2Rr5Z43TW6yM9dzuazu5i72v0cVpLoGaCUTE/
         05ent5zVCkvpf5ukQpViSUjVbFaH/Vy4kN2X+iBjaIBzDF79S8yWw+gq6YIl31Ql/zaK
         idc0YyA7ll7XkvsdLXYMN7zk23bpDuKyQvpT75AHW+jH7aZi5DinOUxqjZWR6xQpgTmJ
         OVZOpTQ6t5V+OZ9miatjXfLmfxz/7wJW3bi8xi950JIHjptkSqrr3eO0NM+EpNaTrzxh
         Bj4HDhZ3OgcwM23Td6x0y+siDQ2aeosbVGFEP3zV3J4w4y6anJqRXSdqn6gyVZLWuOqr
         /FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5TFO0ecJqFSWeM6hfq5fazXKqNWla1DOE+uuMQWKOY=;
        b=L/k5cYdsI/t5+UA1z//gLV45XZWoc5uKtwJEBjXuiqrc3oHEfS68rJgMk0aSIHB2R8
         iACkw+S2287OeZulLo46bT98cD2WnXvonhDwTGlIvtDqfCe0KK9frkYuBUw91adaEhFp
         EQACljvRNRqtMUQumKPoFhbbNQpxS5U12K1fot+m7aAv2owNAXNWptVgL+/JvqH96Bhv
         afwyAO99WUC2HCfQG8QVMfy0MzAeZnhGIPS65SPp13YKegpUa2Q50hut2QrG4S5WP5jc
         vTufNSRgt5O4TYhc9dRH3qPkRCtKOLwa/SY5d0GR4tMnuPKPtJy1cCGhxFS+r4ylYKG8
         pkcA==
X-Gm-Message-State: AFqh2kpZ4h5TVnI7QK/kmJGSG9jecOlxe0n7O/5JAIO8kGOFdfAw1BOA
        viXAJzlrWBiDoN2k0j0xvLZ04pyqC+EMmsnh5uY=
X-Google-Smtp-Source: AMrXdXstf28lz6wStpgfgaW5YWmBqBdWkZ+eYdz5G3cg2Jyd9tAARuoLOZ70D/dM8etR+9KmRD+8sw==
X-Received: by 2002:a17:903:18a:b0:189:b0ff:e316 with SMTP id z10-20020a170903018a00b00189b0ffe316mr15049545plg.38.1671801963795;
        Fri, 23 Dec 2022 05:26:03 -0800 (PST)
Received: from archl-hc1b.. ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id m3-20020a635803000000b0047681fa88d1sm1308587pgb.53.2022.12.23.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 05:26:03 -0800 (PST)
From:   Anand Moon <anand@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Anand Moon <anand@edgeble.ai>, Jagan Teki <jagan@edgeble.ai>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv1 linux-next 4/4] ARM: dts: rockchip: rv1126: Enable Ethernet for Neu2-IO
Date:   Fri, 23 Dec 2022 13:22:33 +0000
Message-Id: <20221223132235.16149-4-anand@edgeble.ai>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221223132235.16149-1-anand@edgeble.ai>
References: <20221223132235.16149-1-anand@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip RV1126 has GMAC 10/100/1000M ethernet controller.
Enable ethernet node on Neu2-IO board.

Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
 arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts | 37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
index dded0a12f0cd..bd592026eae6 100644
--- a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
+++ b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
@@ -22,6 +22,43 @@ chosen {
 	};
 };
 
+&gmac {
+	clock_in_out = "input";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmiim1_pins &clk_out_ethernetm1_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&phy>;
+	assigned-clocks = <&cru CLK_GMAC_SRC>, <&cru CLK_GMAC_TX_RX>,
+			<&cru CLK_GMAC_ETHERNET_OUT>;
+	assigned-clock-parents = <&cru CLK_GMAC_SRC_M1>, <&cru RGMII_MODE_CLK>;
+	assigned-clock-rates = <125000000>, <0>, <25000000>;
+	phy-supply = <&vcc_3v3>;
+	tx_delay = <0x2a>;
+	rx_delay = <0x1a>;
+	status = "okay";
+};
+
+&mdio {
+	phy: phy@0 {
+		compatible = "ethernet-phy-id001c.c916",
+			       "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&eth_phy_rst>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	ethernet {
+		eth_phy_rst: eth-phy-rst {
+			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.39.0

