Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B205745000
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjGBSwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGBSwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:52:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DF1C6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 11:52:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9922d6f003cso466120466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688323891; x=1690915891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k0/D6Od9BJ8+b84piDb5tg8kbjMdXggz6hvE4EQ9a9w=;
        b=ew8rZyDpE2YyJb+og5uu4u8aMR09sM5walTcl5XWWAdQ3o/Eb8mkU9DlqpyOnXSR3J
         acyiSJPNrNfIr/rXfUM2kPA1lAAZAvs2zxuiN/w/wtGhAWv56Diujr3CLpi/TnqbQpo5
         xFSLQh+5tFzbgR0MQa96de6NpUgeXJZkxcxRxv8ETc/yUBE5pQbN64Z15YjaGVc1F8a8
         qzu5cK4KwMTEb+w+0MtBRtQ/8KYnMyM8z8XNDlXaA1hECvStSv/wqD/XmzMXlFCMaCJs
         PUIDQQtsY8WEWzffkdMQzwserQlC6o8HiIZ/NxEC2M4zCVe8iuqLTvgc7zZBqzuuvc/d
         osBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688323891; x=1690915891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0/D6Od9BJ8+b84piDb5tg8kbjMdXggz6hvE4EQ9a9w=;
        b=j+olrP3zwZXNzG8AggzqxYQQ4hsDnhPUpOG82yDIJzl0fQKhSfK/Ssam3M+xZQykUO
         WkzwfgN9UwNES4LyM3Ei1enc0b5OYjV8fODkjJJp49zED7wh6QvMjo0oRYupgMaoCErh
         tB3lxGaaKwBHjbGCbrHQUNumrAQEOsnPjeR/A/R3HPzcx05EBBxJXSKtSSx0ApMhuWqw
         gLl6MyjkX5U/UFLRKH8fQk++Imx3zeHh4ijDqYqmMcluKWbnc1YOqxICQsn0+GrNLePx
         F4LHrcretdKnL+ngv0MeHCFbQ1wa/cuz6JlglVLpOrccX2gRMvO9VDMprW583y2AF0xP
         GVLw==
X-Gm-Message-State: AC+VfDxQAGvhcO1np7glsiVWyHoeXd3Ey1rygz9gVfs1UYo9GhTWXS3n
        XDFTUbFhCaQD6CnrC1atAuo5pA==
X-Google-Smtp-Source: APBJJlGeqpgbF2rHnrt+xL1LlnmvAn+UVpaAyDRwPj8+9QmJF7hUYtAi7npeyLqy6MqPn1ZW+091lw==
X-Received: by 2002:a17:906:8314:b0:978:ab6b:afd4 with SMTP id j20-20020a170906831400b00978ab6bafd4mr5473018ejx.43.1688323890764;
        Sun, 02 Jul 2023 11:51:30 -0700 (PDT)
Received: from krzk-bin.. ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b0099297782aa9sm5343084ejb.49.2023.07.02.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 11:51:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: mediatek: minor whitespace cleanup around '='
Date:   Sun,  2 Jul 2023 20:51:27 +0200
Message-Id: <20230702185128.44052-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 6 +++---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 6 +++---
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts             | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index e4605d23fdc8..07484c219364 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -385,9 +385,9 @@ mux {
 	i2s1_pins: i2s1-pins {
 		mux {
 			function = "i2s";
-			groups =  "i2s_out_mclk_bclk_ws",
-				  "i2s1_in_data",
-				  "i2s1_out_data";
+			groups = "i2s_out_mclk_bclk_ws",
+				 "i2s1_in_data",
+				 "i2s1_out_data";
 		};
 
 		conf {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index dad8e683aac5..a885a3fbe456 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -311,9 +311,9 @@ mux {
 	i2s1_pins: i2s1-pins {
 		mux {
 			function = "i2s";
-			groups =  "i2s_out_mclk_bclk_ws",
-				  "i2s1_in_data",
-				  "i2s1_out_data";
+			groups = "i2s_out_mclk_bclk_ws",
+				 "i2s1_in_data",
+				 "i2s1_out_data";
 		};
 
 		conf {
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index b2485ddfd33b..937120f3ff59 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -79,7 +79,7 @@ optee_reserved: optee@43200000 {
 };
 
 &eth {
-	phy-mode ="rgmii-id";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethernet_phy0>;
 	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
 	snps,reset-delays-us = <0 10000 80000>;
-- 
2.34.1

