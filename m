Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE8A68E129
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjBGT3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjBGT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:29:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADB234032
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:29:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so1505967wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 11:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZRz65dFGssUM9GWtmz6zrmKbHxxfil5UcSIAJSRpQY=;
        b=dpgWCIDZ0rvoh30EPHPjSzcl4l1h/f5+wcCj5cKLfX789BP/yGZrnufuq8PnnU7nIy
         3Ky7v/lg+kxIPkhEpBkCXkipHKaXZyuDPBwtOuAM3QShmQR/GTIs46E47T+U4kSXXlQt
         CsoyjBRBDhR0MvwEpGS1Dh5IItlRqTKQogO8cK9Nu5o3pT8+31CgGYMQI0VNJeMgtpeY
         1CgqZCK7pRWs+1il6GrL34ClI6vaZqJiFAwf/TuvX1Mc70MLpIBE4TvNJ3MLirjA1kP9
         4bJ3LqcW4ynl1Q639/NqlPLbd/x2yAHkrXW1OVK0GIDHiFKmZhCJstjjEvVJ1AsYYhFr
         F45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZRz65dFGssUM9GWtmz6zrmKbHxxfil5UcSIAJSRpQY=;
        b=vN+FhfUfDQ5fvRFfWxgQeupZk4iKmLWHpqBmdl4wdCbI5f9nQ+2P8SiqP4LVWbYI59
         TeoHZVsy0cgrY/pd/sVz5a7RPpI1l6IrrhNlA7CSSaTmtrFvrX8ALxg4MwcdSbWFp564
         ukFYPfXQ5jR2osZkVLYhli08KXKfLoSBk+bA6LIyVWawRCTELBlpi6yk8hxtBbUS/1BV
         dDUkD+cHb90bTvCIK67f+KwatWrh8dG62C6WLteaY7m7qBi1XhcFoNjda4NDX2PI5HTc
         9MtmHgb8TXoffErmYuGxSOA9bgCXjyY0KqTwwRWoMd8u/ttlhwHxD2w1cKzUIeWBU9cZ
         CI4g==
X-Gm-Message-State: AO0yUKVGBOONrvwssClmBciTLdSkTkMriGDY+jEpgsV1VpQi27XrXPWI
        OD/ZnT7O5z9Nqb56CyBWZbQXKQ==
X-Google-Smtp-Source: AK7set/fyw5j/FU5oFTP4iDfoRD2zN02IXizdaeNXRKwpLyjWgyPf4njKck75oJ1RRq7JlfQQ3wJoA==
X-Received: by 2002:a05:600c:755:b0:3e0:6c4:6a3a with SMTP id j21-20020a05600c075500b003e006c46a3amr4026715wmn.22.1675798139649;
        Tue, 07 Feb 2023 11:28:59 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003db0ad636d1sm22770818wms.28.2023.02.07.11.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 11:28:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ARM: dts: exynos: move MIPI phy to PMU node in Exynos3250
Date:   Tue,  7 Feb 2023 20:28:50 +0100
Message-Id: <20230207192851.549242-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207192851.549242-1-krzysztof.kozlowski@linaro.org>
References: <20230207192851.549242-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI phy is actually part of the Power Management Unit system
controller.  It does not have its own address space, thus keeping the
node under soc causes warnings:

  exynos3250-artik5-eval.dtb: soc: video-phy: {'compatible': ['samsung,s5pv210-mipi-video-phy'],
    '#phy-cells': [[1]], 'syscon': [[15]], 'phandle': [[23]]} should not be valid under {'type': 'object'}

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 28bb2ce8ccf7..cb2c59c98c4a 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -346,7 +346,7 @@ sys_reg: syscon@10010000 {
 		};
 
 		pmu_system_controller: system-controller@10020000 {
-			compatible = "samsung,exynos3250-pmu", "syscon";
+			compatible = "samsung,exynos3250-pmu", "simple-mfd", "syscon";
 			reg = <0x10020000 0x4000>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
@@ -354,12 +354,11 @@ pmu_system_controller: system-controller@10020000 {
 			clock-names = "clkout8";
 			clocks = <&cmu CLK_FIN_PLL>;
 			#clock-cells = <1>;
-		};
 
-		mipi_phy: video-phy {
-			compatible = "samsung,s5pv210-mipi-video-phy";
-			#phy-cells = <1>;
-			syscon = <&pmu_system_controller>;
+			mipi_phy: mipi-phy {
+				compatible = "samsung,s5pv210-mipi-video-phy";
+				#phy-cells = <1>;
+			};
 		};
 
 		pd_cam: power-domain@10023c00 {
-- 
2.34.1

