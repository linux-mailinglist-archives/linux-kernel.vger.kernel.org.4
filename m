Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6408E710795
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbjEYIet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbjEYIej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:34:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D748CE4D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:34:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f606a80d34so2269775e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685003638; x=1687595638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3sm0sOG8kJdGXppUS7SqrEsY1zLRiuVvK2VuTgB8S8=;
        b=f9lp641QvszKDqXr/dcjmtgWVIP1qzwN/4cqxgf+52rNs179pQqakOD5UTKOL/jxp4
         XMQJ1gzdl26G5hDIYeRorsYEMjaWvkJxMSq0COnCscqEBGyeAf4Kf67jWEnbycQIwAUs
         vUm1K/R8zdaPCXq3X7L9fq42cOyr1Un6nJGGd5hYJEH1AJRvBAowKuVYeV7n7VwKs+h6
         xrw7tfUYoIR3Ffv1IpX2vlXR8B38+aETXdc07zJdOW4pXFVyPLwOQY2kkz4RZG2btOik
         zkXKPlsVXlJ6/cqH+a6UltGsqsYcJazQRLAVX/dNNl3sFUd2S1rndeEtyqWcf9gxHRDn
         pVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685003638; x=1687595638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3sm0sOG8kJdGXppUS7SqrEsY1zLRiuVvK2VuTgB8S8=;
        b=XH6gjWc4bhVLD1iIraEUtAP6/o+uj5q7ZzhidMuraaxu3NVfVcFUj2fJFKMaJhDT+l
         Jx1C/CZaWYH8pShmK7VR3peb8civPYu1xlC3YlfE7DJ65EznUd1K4eG99AQjxiWyuWav
         tZJvylKT/HEb+cuPAH5NaDgAacyrM8Qy0GBy3efWpWT38CwE4/0oSCBPkXSNDS0sgSUm
         ISpsK/l9UL8zu/tbPRPriw5TcSltwcwWw1qgQ+cY0suQ9apOWbdIhlTWDyS7wNoB/f/5
         J2rcB5xfgrjLX+acRVhCV4/lht5reGBiVk2/rHKYlNSZ180cHci4Uv8Nw2LNRbAJvdie
         DP2A==
X-Gm-Message-State: AC+VfDyxa3mlvrwMwjIevvY3DRqfaSF4szm8/ato3jPI5BMkJ6KVFK8v
        PJE1SBUhi+J33h951+CFNf9DcfE0oPcDZik1M44=
X-Google-Smtp-Source: ACHHUZ597gM54jthlc4sodF7mY2YbjsqEtuPE+bwsgwgwmqT/Slvsp1X86sm8eZnXaLtqXFTQOJVZw==
X-Received: by 2002:a7b:ca55:0:b0:3f6:da2:bc83 with SMTP id m21-20020a7bca55000000b003f60da2bc83mr1554877wml.33.1685003638126;
        Thu, 25 May 2023 01:33:58 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o3-20020a5d6843000000b003095a329e90sm945809wrw.97.2023.05.25.01.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:33:57 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 25 May 2023 10:33:13 +0200
Subject: [PATCH v8 04/10] arm64: dts: mediatek: add mt6357 PMIC support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v8-4-7019f3fd0adf@baylibre.com>
References: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=QwAiDhJXueyKUnGYKSko4cktLia5bmqONipL6za+jZs=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkbx1vx8LNUWxBp0aHwE8AGYzpFTDng4XFcXnuQvIx
 pRDExReJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZG8dbwAKCRArRkmdfjHURXJ9EA
 CbfA/Oqko58S6ZJVJTy07eTvvFu27rFBrH4SOrdYvo15F7T5vCrqugjfIPtyY0cPoIIgM6Iz025zNL
 jGU7TdcqpZ4Msr2p7dtId1QDkUNcAoE11ibsjNPAbo7GLZwPG4DarPUVUpqslnESspuiiXJmf5eEFK
 7bOH6ESvSft9rthWT3A70NiAgzm2giDLpjpQhV2o/Dbh0CAsYOILetQZGuj3vPcQ/6gdgeP23ESnNm
 HLT+uOzdevQb/4jUi2x/JzxTUd589twxFHVrrScdR4SSqsw4osO5OszzrnkU5FOOFufboym4eiVCET
 90ohS+5idlDTHS0Ddqwe/pD+JL/cBp+PbJgr++vWM9mXNKj9Ov2hAy3nUQewxyvUKxgxARwpZWTIZL
 smUHCPAQ3E66TdFv9F1XVipuGJXJ0sBN+tn4bnlzrN0sbpu0uDAct5UNiLoo9kZuerYq23lNl7VIj4
 UTfNLd1mOxGLg0/i6Tvps1RtX9oYn2eulB0n0KmCFNdNLn8TXEAwf0gHrrcKvcmquK+LTAgfHPxwJk
 9SYon7fPwu1HNGJ5QdjoJ55dTdQYhIVo06GbHY6V5Nww8HyXO53gQpJWUNCMgvCmmW6PdpU6IE0DBF
 N+s1eUtCKEvLKcfvVAivRjVX63pchnAmFgQbt+SKOutE5d7Y3OqcQaakvM3A==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This power management system chip integration helps to manage regulators
and keys.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index ceb48eb1a6e6..6074aa9c1c3e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/mt8365-pinfunc.h>
 #include "mt8365.dtsi"
+#include "mt6357.dtsi"
 
 / {
 	model = "MediaTek MT8365 Open Platform EVK";
@@ -94,6 +95,12 @@ &i2c0 {
 	status = "okay";
 };
 
+&mt6357_pmic {
+	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
+
 &pio {
 	gpio_keys: gpio-keys-pins {
 		pins {

-- 
2.25.1

