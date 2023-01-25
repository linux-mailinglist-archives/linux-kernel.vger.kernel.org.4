Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E8A67B8E1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjAYR6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbjAYR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:58:00 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53EA2449E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:57:57 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so1901480wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pGSSEalDoYWNAGFpA7qaWXhO8XIQF7qfeP8WxyF/Pk=;
        b=Wk/1ouDpgc5GRvhFuO6qq8dZP2yZ2GywvHMD5KCrWlUq/3KHpbBJQyIfI+szvBgi7J
         a5+ZHMW0txtX/gHXDauyeN58d5L+abTHvohFQoUvvYuPNdx5NN2XaN23oVVyfx1eE/XB
         yNWsmKFENCcXW74xdcSsyMpozuDC+4LBSDzQQ0BeTJzXZ9U0BLQmWoegXGDCISWD3WCB
         5W/XdqIBhD9+EC2CEHYMqwVPu3jKRyPmE1aVDt88KKOjwS8/tkcDgxFNuzfSEgg4KlRy
         P+AfeoRsrU0vZ/Ohxi95/dShoZ2Uob+TmwcxN6cPNZlUjji/v8eOXr4cvg7RG3+k2U1v
         fZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pGSSEalDoYWNAGFpA7qaWXhO8XIQF7qfeP8WxyF/Pk=;
        b=MIxTUGp/SCWRa9I8Ms10s08PTwUTRA+wX8+Nr1R85aZgN/ievNtTISloE/s3vJVaY5
         TvcVOTK4FR26EkoUcKF36H+pCR/Rm74V0o9gImPYf82fo9S+7lfpizjnwUXLjpijZK9I
         6OYjIkISkQuPN5Z1wmxaaaXNXUXraT/bM0OFA9+gBSpm880UgjXfl/gPrfjH49G5Wr7p
         cqrwjmx9IUCLuQmUSUiJzOPaCnhS9/c714mBpLjWt3DrpluthzGb7rqGGqHujhRY3i5d
         x+Chah+GkbElVR61WEf7den6TmKUQJBSzxqjFhC7d0JF2xrtNtZomBvLASigQh5p98l3
         76GQ==
X-Gm-Message-State: AFqh2krCy0gRZHcvq4WB0Ai1ad8jhd2CBA0DniGVjQrkDPxDJ5Ya/HSO
        K5RP2EsHP/ZvanCf3bWeRpIfyg==
X-Google-Smtp-Source: AMrXdXsFkkY0XSu0kApB7XLYTb1DPlMiA4cLuMhgak8E3FvNmmM60B2nm5l0LXRSOe0f2ZpkFE6h8w==
X-Received: by 2002:a05:600c:5025:b0:3db:14dc:8cff with SMTP id n37-20020a05600c502500b003db14dc8cffmr28072464wmr.33.1674669476262;
        Wed, 25 Jan 2023 09:57:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003da28dfdedcsm3421197wms.5.2023.01.25.09.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:57:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: exynos: add unit address to DWC3 node wrapper in Exynos54xx
Date:   Wed, 25 Jan 2023 18:57:51 +0100
Message-Id: <20230125175751.675090-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125175751.675090-1-krzysztof.kozlowski@linaro.org>
References: <20230125175751.675090-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither simple-bus bindings nor dtc W=1 accept device nodes in soc@ node
which do not have unit address.  Therefore usethe address space
of child device (actual DWC3 Controller) as the wrapper's address to
fix:

  exynos5422-odroidhc1.dtb: soc: usb3-0: {'compatible': ['samsung,exynos5250-dwusb3'],
    ... } should not be valid under {'type': 'object'}

  exynos54xx.dtsi:145.21-159.5: Warning (simple_bus_reg): /soc/usb3-0: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos54xx.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 3ec43761d8b9..08786fd9c6ea 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -142,8 +142,9 @@ hsi2c_7: i2c@12cd0000 {
 			status = "disabled";
 		};
 
-		usbdrd3_0: usb3-0 {
+		usbdrd3_0: usb-wrapper@12000000 {
 			compatible = "samsung,exynos5250-dwusb3";
+			reg = <0x12000000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -164,8 +165,9 @@ usbdrd_phy0: phy@12100000 {
 			#phy-cells = <1>;
 		};
 
-		usbdrd3_1: usb3-1 {
+		usbdrd3_1: usb-wrapper@12400000 {
 			compatible = "samsung,exynos5250-dwusb3";
+			reg = <0x12400000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.34.1

