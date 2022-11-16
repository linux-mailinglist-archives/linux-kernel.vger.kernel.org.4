Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5662C973
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiKPUCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKPUCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:02:35 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D6657EF;
        Wed, 16 Nov 2022 12:02:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w23so11009652ply.12;
        Wed, 16 Nov 2022 12:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As0fulMLun+eJjqjObjSTdg/PTBD9UNPaQIMHAXZOXg=;
        b=HF+WPJyRYMs597lubkXXvkdDma+90w/DWbM/ldOz6YR0pmeg3/ztGGIkmlIlb9vErS
         nLkLssypMX366ESoLasH3xX4jIb/d3PI5KNYYhpn7wjhV/81J/VMCw//RVp2PExQHVMP
         /UhkGVXOuZLhy/KZYOeyAgjZpSt8frCme9FgOy+5VP2uuk6Q7I3DrbpycnxZb+MWlONg
         g6VHarv+9bkOdWOIQ+Xt4kpq5KIew1mfIJ1xE9iTO2vzcSwJ0GcTm17t9mSK6qdpGtvx
         tzKLD9qGlBH59gUTR6EW5Jy601opo5iJKh69FcFHrpTn9HVXom4nItSUZXgLZaEJMiWG
         Bh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=As0fulMLun+eJjqjObjSTdg/PTBD9UNPaQIMHAXZOXg=;
        b=I5+LDdY+UIcFnesATSsiDOZq+6sgjpUwt1kc4n907l1W+xEjYvKQLQ5Gx0CuFXSmXN
         0idvvq3ppyTxMdEWDcSvoylQVseOepr0qHsCrhBYCjNJTkAgcxRNtG466oFAFDqi3zNK
         lXfyP02oFkXchPmw4Wq7SVuHVnZvw0nGAAZku4qW62O5VFROPFMrMBAPYtq8TkYovrXT
         fFBgS7UGadD25BWljyoffSHRAmjrNP00JKlmWdEJaYOoSdwT+H6RqG8DK7MpTDozOtGS
         mF+ZBXiDuFn7I22qpdMMs8miU0e4ytbRaWjaCZwnkwAPiXUPDxDuxT/9UjaOiDosK0wa
         eKHA==
X-Gm-Message-State: ANoB5pnF8VhI54bq+Q4D9epud2mYNBd0yZ/x/so7lWEmcNbg7ehDrHFI
        rmZ7OKVV0KA8JnNMhmEXyiE=
X-Google-Smtp-Source: AA0mqf5K1iGwEgJfomYHvGNZlBmAKHUob/dddxCYWbbDWYXMYIUVPRGmp/cnjjkHHHFqrb3PbXovHA==
X-Received: by 2002:a17:902:ba91:b0:188:c395:1748 with SMTP id k17-20020a170902ba9100b00188c3951748mr10019993pls.155.1668628951901;
        Wed, 16 Nov 2022 12:02:31 -0800 (PST)
Received: from localhost.localdomain ([103.51.72.182])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b00186a6b6350esm12423950ple.268.2022.11.16.12.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:02:31 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [linux-next-v2 2/5] arm64: dts: rockchip: Add support of external clock to ethernet node on Rock 3A SBC
Date:   Wed, 16 Nov 2022 20:01:44 +0000
Message-Id: <20221116200150.4657-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116200150.4657-1-linux.amoon@gmail.com>
References: <20221116200150.4657-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of external clock gmac1_clkin which is used as input clock
to ethernet node.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V2: None
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index e1c75532dcee..b848282ea005 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -32,6 +32,13 @@ hdmi_con_in: endpoint {
 		};
 	};
 
+	gmac1_clkin: external-gmac1-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "gmac1_clkin";
+		#clock-cells = <0>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -249,9 +256,8 @@ &cpu3 {
 
 &gmac1 {
 	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
-	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
-	assigned-clock-rates = <0>, <125000000>;
-	clock_in_out = "output";
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&gmac1_clkin>;
+	clock_in_out = "input";
 	phy-handle = <&rgmii_phy1>;
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
@@ -259,6 +265,7 @@ &gmac1 {
 		     &gmac1m1_tx_bus2
 		     &gmac1m1_rx_bus2
 		     &gmac1m1_rgmii_clk
+		     &gmac1m1_clkinout
 		     &gmac1m1_rgmii_bus>;
 
 	tx_delay = <0x4f>;
-- 
2.38.1

