Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E5B69254F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjBJSZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjBJSZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:25:24 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2AA6359E;
        Fri, 10 Feb 2023 10:25:22 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id dr8so18101333ejc.12;
        Fri, 10 Feb 2023 10:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ2TcNqdLFOAVmLP5M0cy768AQ+LH1yHfkoCaBZyfHc=;
        b=P4Cyqdnd70mhdxO3RK9uEwrJUnV0pnLT7dy056n4u+u/+L9yzEAAUgn3U9LGa31Z4m
         D6nzdWRQNvoCNfApP/7ozpYabM/ETKwH0qZbVwdGWtwfNyreTUHv1SCG+cGOazHic+ma
         iSDRVWwnY9fe4OEWZ+psBH4mT2PsvuU1+7My8yv2DG6tlJizuhvWwxRFVoq9CPqUfrWV
         D/WqtDAAEZXnrBvoJ4HXZEqBdnlVo5ABTW19fIqyN/vC/SGP6wmmIf1P6EDyPRTb9ZIM
         V6bcmgegiX97MXVWNL/tjGXtGLVAWZH8OW2BjWA2eyt+kqB8sU6e0u6wLtlN1Vvq2tW6
         bWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQ2TcNqdLFOAVmLP5M0cy768AQ+LH1yHfkoCaBZyfHc=;
        b=HxOgv9wqzinQwgnS/Mdz8DbdHtSWkatxGMfPpBNvBn2yHWzjWiSEnaPrhV7CWt7LxU
         qZIHCxa68GVilGdnBa9F6P2yzRPQu4MPLeevYOqbdaaH77kRpgCOKiCuANgzrZ7EHqAW
         SgWBhJiy3nK5DLjoocb/r+HUA59QH9QT1TQMW0MXamXx9fdfCqnmgXzxeod0Qkg/xlGS
         BHNSVM0vj+YRyhq9wbqoaHTUHubfRgSNQ+jG1h2I2X+/Vul9XdzN8KpVJORTHa5CSeGN
         Xms6DQOfLdPwIF5SSHJbKS85b8VdXXb2YAt6ZFk31jOY4A5oRLRKV81CRK6Kq3U//VeY
         mgFQ==
X-Gm-Message-State: AO0yUKWv8hqFJJrPkuVjpVSP51E7W4efFJFYDPWwsR1P2t8NZ2/SBZVW
        rwNA/QGSe53yt5MU+cFwgDI=
X-Google-Smtp-Source: AK7set/jOf8U2uDeIMXN7sLu64zG4Q6TvF/CNq5kPekt86MNECu2qEg+gRlcIb9Fap72KoCeg3+edw==
X-Received: by 2002:a17:906:29cb:b0:87f:5d0a:c610 with SMTP id y11-20020a17090629cb00b0087f5d0ac610mr16518249eje.32.1676053521286;
        Fri, 10 Feb 2023 10:25:21 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906024400b008aef19f678asm2708966ejl.165.2023.02.10.10.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:25:21 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com
Subject: [PATCH v3 3/5] arm: dts: mt7623: change mt7530 switch address
Date:   Fri, 10 Feb 2023 21:25:03 +0300
Message-Id: <20230210182505.24597-4-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230210182505.24597-1-arinc.unal@arinc9.com>
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

In the case of muxing phy0 of the MT7530 switch, the switch and the phy
will have the same address on the mdio bus, 0. This causes the ethernet
driver to fail since devices on the mdio bus cannot share an address.

Any address can be used for the switch, therefore, change the switch
address to 0x1f.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/mt7623a.dtsi                | 4 ++--
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 4 ++--
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
index fbb5731a3a53..dd522e508eb3 100644
--- a/arch/arm/boot/dts/mt7623a.dtsi
+++ b/arch/arm/boot/dts/mt7623a.dtsi
@@ -36,9 +36,9 @@ mdio: mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		switch0: switch@0 {
+		switch0: switch@1f {
 			compatible = "mediatek,mt7530";
-			reg = <0>;
+			reg = <0x1f>;
 			mediatek,mcm;
 			resets = <&ethsys MT2701_ETHSYS_MCM_RST>;
 			reset-names = "mcm";
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 1e03a3de654f..dc9b4f99eb8b 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -189,9 +189,9 @@ mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		switch@0 {
+		switch@1f {
 			compatible = "mediatek,mt7530";
-			reg = <0>;
+			reg = <0x1f>;
 			reset-gpios = <&pio 33 0>;
 			core-supply = <&mt6323_vpa_reg>;
 			io-supply = <&mt6323_vemc3v3_reg>;
diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
index 5e328c2a6a6e..6b0c3d1006ab 100644
--- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
@@ -185,9 +185,9 @@ phy5: ethernet-phy@5 {
 			phy-mode = "rgmii-rxid";
 		};
 
-		switch@0 {
+		switch@1f {
 			compatible = "mediatek,mt7530";
-			reg = <0>;
+			reg = <0x1f>;
 			reset-gpios = <&pio 33 0>;
 			core-supply = <&mt6323_vpa_reg>;
 			io-supply = <&mt6323_vemc3v3_reg>;
-- 
2.37.2

