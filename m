Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E5665699A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiL0Kth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiL0KtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:49:18 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41129588
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:49:15 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id b12so8568644pgj.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qrV1+U1PAwZ8aTWO8bBklveUtfQ087C4HvxRsD6AFI=;
        b=NvCaXjgDKWKtWlc95hAFYPXcCwPA9WeBpX1HYoJN/cl0qlOl6DGWpIRxQyHPxAqFeu
         g04Nv3vIFE08OuhA9lWiKnBrL1v5GZF8Pca2ZDPXsQpEQfWqiAh4jRGF9ltlwpWFdtnn
         LM5f3xpVELdN1bgcHFygF1VDtNJPTCDdU7awX5EzPw/0s/4VtAEOOkzM/VsrxLYnHSvD
         ORg1aMjTxO/qu2LzIGkpUHnkkCa4m8Ax/yOv79Cgth2KdJzauoWkc4YMFhmhHaZWTDOW
         qmJe5Wf1iyBEvb4/aWBqJ/VrecnHg4jYrzm+Jpj23saX6vmZ/dnVjHuQ9X/65Gir10CZ
         H89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qrV1+U1PAwZ8aTWO8bBklveUtfQ087C4HvxRsD6AFI=;
        b=aLY+0qsW1r6RqRRrOt1YF0MGyQFg8XfAA9+sVI9SAuGJBld6Ef4OqPzzaa210GaIXp
         nrUeDiYiHuHIK1lijQ5XcjPlAtgPVCUHHaABnBiWVwLGefU7YS1qwpMjRbM02sDtaQV9
         YZdnMtG91ZI+VPj/qrWM57sORX+UWM6zmpbayr5CwnSYQJ9NgwY9+8qMhHDmxt7mD9tb
         BHxRs+lEw3Po5nJSg0F1kg3UhTRftLXVjBeieEfV5qWIyem3wOf8DDr91w4c3hKH6908
         vtWpTwL2Gekda/wjHTSr4jEN109JwZt9J+6PoyMKXTkC56wpwuMfbgJ10WRU69PFJgyn
         C7cw==
X-Gm-Message-State: AFqh2kpZiERdOlpiuMBppWhsqu3hGZ2b0j5gx8816IKzZu8z+v1nhfvo
        jF/gAVXquvjgUuoV3QoWZqrwzw==
X-Google-Smtp-Source: AMrXdXv2wfHzBIqnNINzqCh5/AyiZtGFRaCSje/rvCO90gqbx2pedSP4FM+WHmcQDleDMO60b82ebw==
X-Received: by 2002:a05:6a00:3027:b0:577:8d87:d8f4 with SMTP id ay39-20020a056a00302700b005778d87d8f4mr23836820pfb.34.1672138155421;
        Tue, 27 Dec 2022 02:49:15 -0800 (PST)
Received: from archl-hc1b.. ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id w18-20020aa79a12000000b00581816425f3sm194809pfj.112.2022.12.27.02.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 02:49:15 -0800 (PST)
From:   Anand Moon <anand@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, Anand Moon <anand@edgeble.ai>,
        Jagan Teki <jagan@edgeble.ai>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv3 linux-next 4/4] ARM: dts: rockchip: rv1126: Enable Ethernet for Neu2-IO
Date:   Tue, 27 Dec 2022 10:48:34 +0000
Message-Id: <20221227104837.27208-4-anand@edgeble.ai>
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

Rockchip RV1126 has GMAC 10/100/1000M ethernet controller.
Enable ethernet node on Neu2-IO board.

Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
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

