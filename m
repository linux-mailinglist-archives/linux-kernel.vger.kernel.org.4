Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9474962C977
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiKPUCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKPUCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:02:46 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EC663B94;
        Wed, 16 Nov 2022 12:02:45 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s196so17748098pgs.3;
        Wed, 16 Nov 2022 12:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hlf4RPnys2xlptR6hKKlXQBW5qSMO1/p3GZVaaL5DEk=;
        b=Q1vmNkgnMV1rfn9shs7EUPv1E8qMY58IiMlv0wjSwmEEfxjXjMTTfXyJEBhBiZo4RV
         1jqoXycSq7g9T26erjmpPfcESFrKSgB+0GZ9uXRuDnLliTwzcp3CITDb5rLft3pHUUpi
         Uk/ztpz5RY8cTkGXRuGcM71hNwq5QyUBzol5xPf0dZrny2lfx3BZa6ABxvJWlWOVNpv/
         XHOslswzR/EJoP37wdNKNz8kCdbb+T/xvt0e+VpK+v0o88GygLfHfFUJ01ijAAnOvSuC
         2OvmU1Qfgf4o7q2CmJmFZvLTNWSz59rzYkXWJyMLkM4/jBLVp2C4joBXxUv+a2T27LLc
         EBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hlf4RPnys2xlptR6hKKlXQBW5qSMO1/p3GZVaaL5DEk=;
        b=YRmH9ZxFmcL/pZODih/5GuhxvRGMmJWs7Ubel0wNr/jT2dCbVaQiK0sgDnDT0bz6yL
         mbhu7jh+Gn2XqSe5B3zghbIRB9b1fpGR6kKI3wK+KyBJWVdkUmL8z5a8GnYedEhatVnz
         27/apTN1LOflgdxrWXYPQB3kwLwJ4BuUjYOB9pvpYV+MsfaXC2yfOs5Ml5IoKs0aNODW
         paDkRve4M3sdYcW/NzwV5DkeMofdmnNDoWeuZEAMLUbkBRxb0qDzKVphPSBGid39e17M
         eo4yjeeObXk2ghO6Uw5nX8T7yJIbOa3QfZcrmM9rYs0qIn2fuMcIcgmeIh9ml4vFlE9O
         yfmg==
X-Gm-Message-State: ANoB5plcjWL/bQBSg6+qeV5Nv52HgvWgbrB3EIdclpqunGFX3h+L9fwk
        ck3X/n97+QHcixPWUXUE6HE=
X-Google-Smtp-Source: AA0mqf6qbEHBcFkhsJEvfxwuN4QewKdZ0Bpri9Q9/YF+J2TGtG47mtLJ3TFInumyyIdAseU3vRyqgQ==
X-Received: by 2002:a05:6a00:4186:b0:56b:d951:67d2 with SMTP id ca6-20020a056a00418600b0056bd95167d2mr24621348pfb.55.1668628964901;
        Wed, 16 Nov 2022 12:02:44 -0800 (PST)
Received: from localhost.localdomain ([103.51.72.182])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b00186a6b6350esm12423950ple.268.2022.11.16.12.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:02:44 -0800 (PST)
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
Date:   Wed, 16 Nov 2022 20:01:46 +0000
Message-Id: <20221116200150.4657-5-linux.amoon@gmail.com>
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

