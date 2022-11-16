Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A912062C979
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiKPUDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbiKPUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:03:06 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24834663C2;
        Wed, 16 Nov 2022 12:02:52 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w23so11010488ply.12;
        Wed, 16 Nov 2022 12:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hlf4RPnys2xlptR6hKKlXQBW5qSMO1/p3GZVaaL5DEk=;
        b=p1xoRO47ZrZ1DdmzZr9wv/ZEi13KH85MY5IcJaX02FD68/K/cmdmHDvzNED+iQn6fi
         b/BywVdnyw7bc1gzPutqrwvD8uma5HbPaN9VxphqGCIXb9Oi1B0cCgbkoobNrkjbaYe7
         nN5k/BCr2axXuXqOWPhfsVw/0ldm+p2Qz+Ni//ONsEcVAAZiGlqV/odH2z4xuqy4gAI1
         YL67GKHiSw63d4ySeeWwOlXjWAKS8bK1oPHYv3zp2EybFz58fl28AJHD9Xqm8dmpaHLN
         eW81F2sIX89Df+kGKWG2KvKyO2744SmkuuquwI35IOh8l5MNJx5ETidYVQxKmuVi1cCD
         AkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hlf4RPnys2xlptR6hKKlXQBW5qSMO1/p3GZVaaL5DEk=;
        b=NrX6YXYrjaK5MzrPEXz4ohQtYCj97s2+adxMlzyYzENQ46rly7LAMpylB3dxrOE9b3
         AQDJuq9Wx7NOCChKQh5tAofxFY02dq281G8mEr4uhZGpjEyxqfV3WmWcgXCXIqSyJg5O
         lZzsIKdHjyMp/Ix8UzsMYG5/jmVF5dDCETl1Rl2TmdmV3dVOaG7CgPjFFwtpAkURkn6U
         LLPJA0T8RkZm8I2TR3BXI0T3Lx+fuucnCyBrbuuqM9zlXQUF4ejejD1iobGqwpPszZJz
         fVE2rgvnv7qNj6nnPpsHOTf3lTs337cjqieysRSLMYy+SHRav8JEW32n2vmD+GEJAsTo
         aRAQ==
X-Gm-Message-State: ANoB5pki4zK0JtV0hrSdmH9oCCUdyiyCYqosvXhLMruSGSaa6VkQC+7z
        pYga265N1T8YpabBqcOfYYc=
X-Google-Smtp-Source: AA0mqf7C+XsGFEi9GeihjTn5V5WPZwj9QlHhQ6Xr1g1pK9CvcEqH7Zj01PlVmvLBIF1bcTXt+nB5cA==
X-Received: by 2002:a17:902:e791:b0:186:9870:506a with SMTP id cp17-20020a170902e79100b001869870506amr10439418plb.45.1668628971684;
        Wed, 16 Nov 2022 12:02:51 -0800 (PST)
Received: from localhost.localdomain ([103.51.72.182])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b00186a6b6350esm12423950ple.268.2022.11.16.12.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:02:51 -0800 (PST)
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
Subject: [linux-next-v2 4/5] arm64: dts: rockchip: Add support of interrupt to ethernet node on Rock 3A SBC
Date:   Wed, 16 Nov 2022 20:01:47 +0000
Message-Id: <20221116200150.4657-6-linux.amoon@gmail.com>
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

As per the shematic gmac1 support gpio interrupt controller 
GMAC1_INT/PMEB_GPIO3_A7 add the support for this.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: new patch added
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 5378254c57ca..9f84a23a8789 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -588,10 +588,14 @@ rgmii_phy1: ethernet-phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <0x0>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&eth_phy_rst>;
+		pinctrl-0 = <&eth_phy_rst>, <&eth_phy_int>;
 		reset-assert-us = <20000>;
 		reset-deassert-us = <100000>;
 		reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&gpio3>;
+		/* GMAC1_INT/PMEB_GPIO3_A7 */
+		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
+		#interrupt-cells = <1>;
 	};
 };
 
@@ -630,6 +634,10 @@ vcc_mipi_en: vcc_mipi_en {
 	};
 
 	ethernet {
+		eth_phy_int: eth-phy-int {
+			rockchip,pins = <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
 		eth_phy_rst: eth_phy_rst {
 			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-- 
2.38.1

