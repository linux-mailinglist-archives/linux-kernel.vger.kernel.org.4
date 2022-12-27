Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B8656999
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiL0Ktd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiL0KtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:49:11 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFD19591
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:49:10 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b145so4565415pfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS5tPAjce0gx/cz+s3NHMhRAvu++L/Im07aMJCXAmyA=;
        b=7bBMIzvZOC1cSAwCHkULXLTpm6F4ZJG8Yorc/h+NGP2MBfeihct/yOTiLCfEMb2Auk
         k9LZO7QmSY0lhlC7g95Wb1nlFj0VgHWtKg8UOuNVs6qqgoxmRTWx07cidOsigCEGQIYs
         /Uaitgimb2wafFkQ6rcCCajDqLgS8yc3Ol0dOXqPGOKwrn9obYc7SslcV3Nmc8Dhl+2S
         5q1oXaqZP4fmLdFFiRnb29pNhwz+tKgsHF+ek/xCTxJ6ypW5VC0Dk/rdBHExfaEZHyMM
         smCBYKrEt0bLqBT/RkjB0c26YjSxAfkGVLalLDxz4cufRDEq8QH+elc76ZJ9QH8KN4Tb
         /ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tS5tPAjce0gx/cz+s3NHMhRAvu++L/Im07aMJCXAmyA=;
        b=byC4a5uFa1Y8doYJhszxH347zmYxUsFkxv1hrxgZGrzq4ZSn3OxhlKXoxeKvmyyR4e
         hMGLkXSw9Ot9o3h7Zmwo9vLvDoByKnqsJYFHjEUa3LMCJxw4kJibmEtXUro8FII/1tJ7
         h2aOq/l1RaWqv1MYkwe0EUKvqheB7ghpJ4MUOkhU7/QV7iKnb309RyqSc2panBL3X/Jg
         S5a1URXHN/mqZXDO0zJ/JSM9w8NJqWzxeYHNCfxTURFU56eZiXnL9ckAqZUTVpX9ycTC
         po9uuGWCnCFnNgkTbiJF/sC4LbYLVok6wOPvvjnlXKD9dGueOKJ+8HI+SkkiBi1oi1zH
         XFaw==
X-Gm-Message-State: AFqh2koYTBjTRDFpsquXw6ehGrO9egihBSnsTkHe2GjzmQK+Fedg4QI7
        a3BswrfE7qYJyh//1QbfsThVvQ==
X-Google-Smtp-Source: AMrXdXtL6B070FxeDmjmgXUmmYD5GUeOiKhiubSwfWS3V/RxStzpdDzJkmBFTL85DqJuDwnk7X++sQ==
X-Received: by 2002:a62:6345:0:b0:580:cfbc:2902 with SMTP id x66-20020a626345000000b00580cfbc2902mr11541269pfb.1.1672138149477;
        Tue, 27 Dec 2022 02:49:09 -0800 (PST)
Received: from archl-hc1b.. ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id w18-20020aa79a12000000b00581816425f3sm194809pfj.112.2022.12.27.02.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 02:49:09 -0800 (PST)
From:   Anand Moon <anand@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     Johan Jonker <jbx6244@gmail.com>, Anand Moon <anand@edgeble.ai>,
        Jagan Teki <jagan@edgeble.ai>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCHv3 linux-next 3/4] ARM: dts: rockchip: rv1126: Add GMAC node
Date:   Tue, 27 Dec 2022 10:48:33 +0000
Message-Id: <20221227104837.27208-3-anand@edgeble.ai>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221227104837.27208-1-anand@edgeble.ai>
References: <20221227104837.27208-1-anand@edgeble.ai>
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

Rockchip RV1126 has GMAC 10/100/1000M ethernet controller
add GMAC node for RV1126 SoC.

Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
v3: drop the gmac_clkin_m0 & gmac_clkin_m1 fix clock node which are not
used, Add SoB of Jagan Teki.
V2: drop SoB of Jagan Teki.
---
 arch/arm/boot/dts/rv1126.dtsi | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/rv1126.dtsi b/arch/arm/boot/dts/rv1126.dtsi
index 1cb43147e90b..e20fdd0d333c 100644
--- a/arch/arm/boot/dts/rv1126.dtsi
+++ b/arch/arm/boot/dts/rv1126.dtsi
@@ -90,6 +90,55 @@ xin24m: oscillator {
 		#clock-cells = <0>;
 	};
 
+	gmac: ethernet@ffc40000 {
+		compatible = "rockchip,rv1126-gmac", "snps,dwmac-4.20a";
+		reg = <0xffc40000 0x4000>;
+		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq", "eth_wake_irq";
+		rockchip,grf = <&grf>;
+		clocks = <&cru CLK_GMAC_SRC>, <&cru CLK_GMAC_TX_RX>,
+			 <&cru CLK_GMAC_TX_RX>, <&cru CLK_GMAC_REF>,
+			 <&cru ACLK_GMAC>, <&cru PCLK_GMAC>,
+			 <&cru CLK_GMAC_TX_RX>, <&cru CLK_GMAC_PTPREF>;
+		clock-names = "stmmaceth", "mac_clk_rx",
+			      "mac_clk_tx", "clk_mac_ref",
+			      "aclk_mac", "pclk_mac",
+			      "clk_mac_speed", "ptp_ref";
+		resets = <&cru SRST_GMAC_A>;
+		reset-names = "stmmaceth";
+
+		snps,mixed-burst;
+		snps,tso;
+
+		snps,axi-config = <&stmmac_axi_setup>;
+		snps,mtl-rx-config = <&mtl_rx_setup>;
+		snps,mtl-tx-config = <&mtl_tx_setup>;
+		status = "disabled";
+
+		mdio: mdio {
+			compatible = "snps,dwmac-mdio";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+		};
+
+		stmmac_axi_setup: stmmac-axi-config {
+			snps,wr_osr_lmt = <4>;
+			snps,rd_osr_lmt = <8>;
+			snps,blen = <0 0 0 0 16 8 4>;
+		};
+
+		mtl_rx_setup: rx-queues-config {
+			snps,rx-queues-to-use = <1>;
+			queue0 {};
+		};
+
+		mtl_tx_setup: tx-queues-config {
+			snps,tx-queues-to-use = <1>;
+			queue0 {};
+		};
+	};
+
 	grf: syscon@fe000000 {
 		compatible = "rockchip,rv1126-grf", "syscon", "simple-mfd";
 		reg = <0xfe000000 0x20000>;
-- 
2.39.0

