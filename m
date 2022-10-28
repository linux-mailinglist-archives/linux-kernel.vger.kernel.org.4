Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E3610E97
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiJ1Kev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiJ1Keg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:34:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4086ADFD9;
        Fri, 28 Oct 2022 03:34:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v1so6025827wrt.11;
        Fri, 28 Oct 2022 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ea1wwle1wP6aS8WKh/9HKEpPf2vMavxdmBWSIJ+2x8=;
        b=NNTAM0gN1azqcsIQcpxHh/vJKSdMlq2PNJCAVA94ROn0+UeZjBze0YQCH9cB+18hwo
         VgvcWgMIuAhlhk6w1cDK+uHp/sJfOcXvz1PgIFgyNMkXrYcTuqXmtW3kKaHsScmKCSiz
         sYYnwEiUoppjrmHhIbcmmWEfAiF+pRLfpYqWVQr4Kj786YQIc3KPec35hb1OZvGm9g1x
         JwGIMbyNm8lFyDjDskUL5VmSGSRNOH0ZQrf7gkhaWXdFYtrMX8hy1/+sl2gTtIlt35Bb
         ica46gWkMK7HiViHe73k0g5Jq/bPJQhaK8DGo4zI3Oo49JDMxPlzUMoDuIejti5yWx3Y
         oFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ea1wwle1wP6aS8WKh/9HKEpPf2vMavxdmBWSIJ+2x8=;
        b=O+Ch6RYgkeDfnSxk1FfjmX4o4PMKtkHIY/nDpRFz+tnUnDllzDSGhEfrpv7bO2jkCS
         dytgzE85ewvhPKNuSP/OP7AOBQDKACplLqR3ShByaEixfFi6xKYnhN+VGsRVBIDL2x+O
         OmSiXLyBZ3oXpZAlAhMsSDSiN38KgM0HS4VoRCNqO6Ybpo7FIlmi98vh+fO7FvTaup9d
         p1zJGGDF12etJmDtpIicCxg4PA60Ahxj+8iRG8eO9EdNMyWAEJKhW79ZP2YTfNUeHUAm
         /p+5l7JfaNKZfj4A0JSnoINR7aBGbbexine020Bf46ea2wRB+B8cvJc/m6ubiRGI/Upf
         sHGA==
X-Gm-Message-State: ACrzQf3hyJOostUpg+J64r2ILW9mGfiw/PSst+qJD9Ja7slG7LZaQzOq
        YgJWbUuQSO8RiC342F9iQt8=
X-Google-Smtp-Source: AMsMyM4QIDPnl/FJuOUa3z7Y8zZHoMcOpnJ+EsbVC9SdL2Uoer1FNZxCWJbIqQnW+zje1w/fVlULVA==
X-Received: by 2002:a05:6000:15ce:b0:230:a14d:997b with SMTP id y14-20020a05600015ce00b00230a14d997bmr35708359wry.370.1666953267858;
        Fri, 28 Oct 2022 03:34:27 -0700 (PDT)
Received: from localhost (94.197.40.204.threembb.co.uk. [94.197.40.204])
        by smtp.gmail.com with ESMTPSA id ay31-20020a05600c1e1f00b003cf537ec2efsm4116465wmb.36.2022.10.28.03.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:34:27 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tsbogend@alpha.franken.de, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] mips: dts: ingenic: Remove unnecessary AIC clocks
Date:   Fri, 28 Oct 2022 11:34:17 +0100
Message-Id: <20221028103418.17578-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
References: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clocks arguably don't belong in the DT because there isn't
much the AIC can do with them in principle. It's safe to remove
them because the jz4740-i2s Linux driver has never depended on
them in the DT, despite superficial appearances to the contrary.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 arch/mips/boot/dts/ingenic/jz4725b.dtsi | 7 ++-----
 arch/mips/boot/dts/ingenic/jz4740.dtsi  | 7 ++-----
 arch/mips/boot/dts/ingenic/jz4770.dtsi  | 5 ++---
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4725b.dtsi b/arch/mips/boot/dts/ingenic/jz4725b.dtsi
index e9e48022f631..acbbe8c4664c 100644
--- a/arch/mips/boot/dts/ingenic/jz4725b.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4725b.dtsi
@@ -198,11 +198,8 @@ aic: audio-controller@10020000 {
 
 		#sound-dai-cells = <0>;
 
-		clocks = <&cgu JZ4725B_CLK_AIC>,
-			 <&cgu JZ4725B_CLK_I2S>,
-			 <&cgu JZ4725B_CLK_EXT>,
-			 <&cgu JZ4725B_CLK_PLL_HALF>;
-		clock-names = "aic", "i2s", "ext", "pll half";
+		clocks = <&cgu JZ4725B_CLK_AIC>, <&cgu JZ4725B_CLK_I2S>;
+		clock-names = "aic", "i2s";
 
 		interrupt-parent = <&intc>;
 		interrupts = <10>;
diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 7f76cba03a08..bdd6f4d82ec9 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -192,11 +192,8 @@ aic: audio-controller@10020000 {
 		interrupt-parent = <&intc>;
 		interrupts = <18>;
 
-		clocks = <&cgu JZ4740_CLK_AIC>,
-			 <&cgu JZ4740_CLK_I2S>,
-			 <&cgu JZ4740_CLK_EXT>,
-			 <&cgu JZ4740_CLK_PLL_HALF>;
-		clock-names = "aic", "i2s", "ext", "pll half";
+		clocks = <&cgu JZ4740_CLK_AIC>, <&cgu JZ4740_CLK_I2S>;
+		clock-names = "aic", "i2s";
 
 		dmas = <&dmac 25 0xffffffff>, <&dmac 24 0xffffffff>;
 		dma-names = "rx", "tx";
diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
index bda0a3a86ed5..9c0099919db7 100644
--- a/arch/mips/boot/dts/ingenic/jz4770.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
@@ -238,9 +238,8 @@ aic: audio-controller@10020000 {
 
 		#sound-dai-cells = <0>;
 
-		clocks = <&cgu JZ4770_CLK_AIC>, <&cgu JZ4770_CLK_I2S>,
-			 <&cgu JZ4770_CLK_EXT>, <&cgu JZ4770_CLK_PLL0>;
-		clock-names = "aic", "i2s", "ext", "pll half";
+		clocks = <&cgu JZ4770_CLK_AIC>, <&cgu JZ4770_CLK_I2S>;
+		clock-names = "aic", "i2s";
 
 		interrupt-parent = <&intc>;
 		interrupts = <34>;
-- 
2.38.1

