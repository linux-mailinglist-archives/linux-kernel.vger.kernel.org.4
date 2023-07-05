Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE79874874F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjGEPCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjGEPBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:01:51 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE261985
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:01:21 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b698937f85so115109061fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569274; x=1691161274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1rN3ipgesHiYjPePiPOURsWgd9LrOnJ6UtzIVJbQoQ=;
        b=GuNRFMOu5B04UulRHgzb4b/IrJYJU8Ms2WYKP61D+456WCWC2d/8eu8tlgOv0GwHfG
         /WzRkdY92cdQXvxU9sJMWlvGlmt6OCgxENPALEDHltklViNsgEpmI4W3Ai55GQBTGR0Q
         b7xlX01XXcTZW8yhIYDK/JHON8OpxnNEBUBrJpuL9ttDJZw+zidks4+kOjubu5Emwo1t
         TWCmmjfohcEf/8E2tsNqqiHtfHi99h25w06EmT4oeMWG4QQKWyFluW35GZK5l3VYzqkX
         Ro+84AnWheig1UHYz3nyQS47wHgB10hT8B9wlQ85CQJI80HoeDNEl7jaOrco5mXUn5iT
         HJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569274; x=1691161274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1rN3ipgesHiYjPePiPOURsWgd9LrOnJ6UtzIVJbQoQ=;
        b=JwlPz1gcO3w2lXhfGZeI23X9672tqgTXDQR41jYHI9lSM+3IAtpDbXqQrLfcrNeik1
         GZrkCzEY39gjSirkblPVSX287AFkHJRhVuSkPZOVGujUBZ2paacY9uZycBuayYJ0Zi9P
         mQ1QV8oh1uHUsuL51E6GuTw/j3fphFJ8WMisZGtec58TmQOg6nUSKG74jsSqtIae3KoD
         ybuQ4JJrPtLUlQUWGigEEgeIDunO7RwDuUuUynPVLqSl49XKRG/AioBpvV4Tr0DYFtvH
         7QjYx2RBkRx4cEsaWmM1LzcGsYtx/J+3IvdIZC4N6CQuKM8N1epUVMRHNZ9WfkZk3FEJ
         2PJw==
X-Gm-Message-State: ABy/qLZ4XbVwPIk8R1pXn6Xu4LJ0PkF+48AFm2mu3iTpUTKkwK/QTnBZ
        oT3yn+aiitEIrpvaZk77JopTjA==
X-Google-Smtp-Source: APBJJlHE/3L+c+SvxD+CwLp89NiZ73HBKXHSKtFz9EfZC03bnFEmwoFw7YSR5zFNybXrRCZ98YHdvA==
X-Received: by 2002:a2e:900e:0:b0:2b6:e121:cf68 with SMTP id h14-20020a2e900e000000b002b6e121cf68mr8061011ljg.5.1688569274314;
        Wed, 05 Jul 2023 08:01:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709064b5900b009929d998ab6sm9001667ejv.131.2023.07.05.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:01:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: broadcom: add missing space before {
Date:   Wed,  5 Jul 2023 17:01:08 +0200
Message-Id: <20230705150108.293999-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705150108.293999-1-krzysztof.kozlowski@linaro.org>
References: <20230705150108.293999-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi    | 2 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts | 2 +-
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index f549bda8c48c..2f124b027bbf 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -577,7 +577,7 @@ leds: leds@800 {
 			#size-cells = <0>;
 		};
 
-		hsspi: spi@1000{
+		hsspi: spi@1000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "brcm,bcm4908-hsspi", "brcm,bcmbca-hsspi-v1.0";
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
index 699f7742ce7f..1d314f17bbdd 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
@@ -114,7 +114,7 @@ partition@4000000 {
 			reg = <0x04000000 0x06400000>; /*  100MB */
 		};
 
-		partition@a400000{
+		partition@a400000 {
 			label = "ncustfs";
 			reg = <0x0a400000 0x35c00000>; /*  860MB */
 		};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 7aece79bf882..f049687d6b96 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -565,7 +565,7 @@ dma0: dma-controller@310000 {
 			iommus = <&smmu 0x6000 0x0000>;
 		};
 
-		enet: ethernet@340000{
+		enet: ethernet@340000 {
 			compatible = "brcm,amac";
 			reg = <0x00340000 0x1000>;
 			reg-names = "amac_base";
-- 
2.34.1

