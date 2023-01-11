Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DB06654D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjAKGtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbjAKGt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:49:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1DE12A96
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:49:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id dw9so13473221pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6O+3B9iJZ9CCy3n1rtb8gBedSyHiR9ZlkmoYj+KH2I=;
        b=zQ2DBcbnZdTbmpOaEPsOOBckXPH0aYxDabSHu23Nc64Lg6WTcUjYacWJ49000sRqj+
         MhGW/GZ9sCOJkKUXv+BQ0lvm10570rB5uHq0W+Z2HImh2ZvA6C3r1+0kdJ4ZOb5wNil/
         IcCHfp1sgDXmCXkBV8AEscRjRBZCAKN1rvoQfFcDZ4lhZTQP6gCRMVRTGaGag9PrAA9o
         xYJc6g55cZ9KArT6N8bqOo6/YqaEYfrNhrpwKEsKRVisgF/jD7ZczNOa3tcar9q2P9u9
         FcCk7yS6qkNSFcL6HLfw8HF473ixxhXl5i5OkJRIhzhw5DyZhgpHJBTmLqfl0DGZqS/+
         SZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6O+3B9iJZ9CCy3n1rtb8gBedSyHiR9ZlkmoYj+KH2I=;
        b=FqJQKoGo2Tv/I0vexzWzjqMIefMdK+X5dQNDpfpHlHgYYxKA9go/dNjEWEKIJVFxE8
         lcR8iHtKQy1kSqFnrwdRAAxJ4NX72lQyLNiXPKQOTSSP7MG1heFVFP2lC8PVjLoqKVGD
         MVLnkZ41CqhG0UHTVhLykvXKuMVmQmb1nj9f8pY81u83KXyzjWSSiSxom/vIivYB90ZM
         rHYpScL71Ze6ve6haidqPsMF1hZhwsuVYEqAEMVpIm0lC4oVthMNPDdXUGVkG/sP7as1
         xe0EtSB9v54VKFDj0WcSDnHJT/rzKC8TpwUBZUHlNsXCBjfsgJyvZiCej4tGuNmuQnfd
         G46A==
X-Gm-Message-State: AFqh2kqbS2AqgYNdiMYs4S88tFzn6KVxuB07a+AhdrWcrCtV9q3pnyBh
        GbZ8ZA80h+PEDsr1aIF3LrhnMw==
X-Google-Smtp-Source: AMrXdXu2dxbPB5QdrNT/INy7sEKaWL92dHycLBjLklpQNgTxNQwGwtqj58osfflnN9NidTBsLaWW9g==
X-Received: by 2002:a17:902:eb11:b0:194:46e0:1b61 with SMTP id l17-20020a170902eb1100b0019446e01b61mr2895869plb.63.1673419753115;
        Tue, 10 Jan 2023 22:49:13 -0800 (PST)
Received: from archl-hc1b.. ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b001930e89f5f6sm9301861plx.98.2023.01.10.22.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 22:49:12 -0800 (PST)
From:   Anand Moon <anand@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, Anand Moon <anand@edgeble.ai>,
        Jagan Teki <jagan@edgeble.ai>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv4 linux-next 4/4] ARM: dts: rockchip: rv1126: Enable Ethernet for Neu2-IO
Date:   Wed, 11 Jan 2023 06:48:39 +0000
Message-Id: <20230111064842.5322-4-anand@edgeble.ai>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111064842.5322-1-anand@edgeble.ai>
References: <20230111064842.5322-1-anand@edgeble.ai>
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
v4: none
v3: Address review coments from Johan and Add SoB Jagan Teki.
v2: drop SoB of Jagan Teki.
---
 arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts | 37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
index dded0a12f0cd..3340fc3f0739 100644
--- a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
+++ b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
@@ -22,6 +22,43 @@ chosen {
 	};
 };
 
+&gmac {
+	assigned-clocks = <&cru CLK_GMAC_SRC>, <&cru CLK_GMAC_TX_RX>,
+			  <&cru CLK_GMAC_ETHERNET_OUT>;
+	assigned-clock-parents = <&cru CLK_GMAC_SRC_M1>, <&cru RGMII_MODE_CLK>;
+	assigned-clock-rates = <125000000>, <0>, <25000000>;
+	clock_in_out = "input";
+	phy-handle = <&phy>;
+	phy-mode = "rgmii";
+	phy-supply = <&vcc_3v3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmiim1_pins &clk_out_ethernetm1_pins>;
+	tx_delay = <0x2a>;
+	rx_delay = <0x1a>;
+	status = "okay";
+};
+
+&mdio {
+	phy: ethernet-phy@0 {
+		compatible = "ethernet-phy-id001c.c916",
+			     "ethernet-phy-ieee802.3-c22";
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

