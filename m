Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75F6729129
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbjFIHaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbjFIH3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:29:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E408D30E6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:29:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-651f2f38634so1494839b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686295760; x=1688887760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD+KUgBGAZpos34KVNAuisH6maHzuZAbYL+cYk7AnpI=;
        b=W6ECPmFEywudFTGADngeW+8j6+RKfhMzOXW4JMxiaZhlyu+6dKLJveZYohzA7gk8N0
         AkMgpbgmIfbZN1J9GhdzzkDX1+7MJh0oKuSRU+/09Ozmua9SOnTfqJSKU0rOAaTjLQRb
         8ew0IxErShJiSYgM11P0AxrpUYhArPvNmzAN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295760; x=1688887760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TD+KUgBGAZpos34KVNAuisH6maHzuZAbYL+cYk7AnpI=;
        b=GVWmyxTSsZZdMInV/2HpcMEjtyP57yWIIU9L7qtZhvkcARPnGjTBymMwidyHI5jNH6
         mSV9FU+xJw6GUDFOJVgYBGssQHWd/DtYQ0Ow3N/ziJg0jjOt6YfD+rh2tRkPD/NmM9aV
         E8E0g14x/tKbHC4z204ohChTMRUs0De7upRwO9v1dx9DTXQI7FRnxExYz+y/S8yY8+YH
         W+naUQv1HjiZQygQpKt5Y7l4GqMeqCa2GcTC8ggi/K9EELdk4YWy8TQf2VrUjRQ3I/yI
         nQIK2s2k4DrMysU1+1692KwnAgpFx0X2yng5/ml2ANf++ETYBaMPD3scOK8ZfsfEDIXB
         FJlQ==
X-Gm-Message-State: AC+VfDx3lj0ReMvFxkO9x6vtRpyhfFQVF6+5WaLZZwuhe4b7XcTxSUDk
        4CfuCAV4I8F91h+xrD/sMwmCZQ==
X-Google-Smtp-Source: ACHHUZ7CXCPz6Rn/bdtxmBFup4pQKAtT7ra/3D7+Bw2zj9cvrvb/EnPtR1cjdyv3l+/SW2uZbtn23g==
X-Received: by 2002:aa7:8896:0:b0:658:f86f:b18e with SMTP id z22-20020aa78896000000b00658f86fb18emr643979pfe.22.1686295760403;
        Fri, 09 Jun 2023 00:29:20 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c2ea:d8e4:1fe8:21f0])
        by smtp.gmail.com with ESMTPSA id y9-20020a655a09000000b005287a0560c9sm2160283pgs.1.2023.06.09.00.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:29:20 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 4/4] arm64: dts: mediatek: mt8186: Wire up GPU voltage/frequency scaling
Date:   Fri,  9 Jun 2023 15:29:05 +0800
Message-ID: <20230609072906.2784594-5-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609072906.2784594-1-wenst@chromium.org>
References: <20230609072906.2784594-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the GPU's OPP table. This is from the downstream ChromeOS kernel,
adapted to the new upstream opp-supported-hw binning format. Also add
dynamic-power-coefficient for the GPU.

Also add label for mfg1 power domain. This is to be used at the board
level to add a regulator supply for the power domain.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 140 ++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 3762a70ccafb..f04ae70c470a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -647,6 +647,142 @@ clk32k: oscillator-32k {
 		clock-output-names = "clk32k";
 	};
 
+	gpu_opp_table: opp-table-gpu {
+		compatible = "operating-points-v2";
+
+		opp-299000000 {
+			opp-hz = /bits/ 64 <299000000>;
+			opp-microvolt = <612500>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-332000000 {
+			opp-hz = /bits/ 64 <332000000>;
+			opp-microvolt = <625000>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-366000000 {
+			opp-hz = /bits/ 64 <366000000>;
+			opp-microvolt = <637500>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <643750>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-434000000 {
+			opp-hz = /bits/ 64 <434000000>;
+			opp-microvolt = <656250>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-484000000 {
+			opp-hz = /bits/ 64 <484000000>;
+			opp-microvolt = <668750>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-535000000 {
+			opp-hz = /bits/ 64 <535000000>;
+			opp-microvolt = <687500>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-586000000 {
+			opp-hz = /bits/ 64 <586000000>;
+			opp-microvolt = <700000>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-637000000 {
+			opp-hz = /bits/ 64 <637000000>;
+			opp-microvolt = <712500>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-690000000 {
+			opp-hz = /bits/ 64 <690000000>;
+			opp-microvolt = <737500>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-743000000 {
+			opp-hz = /bits/ 64 <743000000>;
+			opp-microvolt = <756250>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-796000000 {
+			opp-hz = /bits/ 64 <796000000>;
+			opp-microvolt = <781250>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-850000000 {
+			opp-hz = /bits/ 64 <850000000>;
+			opp-microvolt = <800000>;
+			opp-supported-hw = <0xff>;
+		};
+
+		opp-900000000-3 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <850000>;
+			opp-supported-hw = <0x8>;
+		};
+
+		opp-900000000-4 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <837500>;
+			opp-supported-hw = <0x10>;
+		};
+
+		opp-900000000-5 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <825000>;
+			opp-supported-hw = <0x30>;
+		};
+
+		opp-950000000-3 {
+			opp-hz = /bits/ 64 <950000000>;
+			opp-microvolt = <900000>;
+			opp-supported-hw = <0x8>;
+		};
+
+		opp-950000000-4 {
+			opp-hz = /bits/ 64 <950000000>;
+			opp-microvolt = <875000>;
+			opp-supported-hw = <0x10>;
+		};
+
+		opp-950000000-5 {
+			opp-hz = /bits/ 64 <950000000>;
+			opp-microvolt = <850000>;
+			opp-supported-hw = <0x30>;
+		};
+
+		opp-1000000000-3 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <950000>;
+			opp-supported-hw = <0x8>;
+		};
+
+		opp-1000000000-4 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <912500>;
+			opp-supported-hw = <0x10>;
+		};
+
+		opp-1000000000-5 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <875000>;
+			opp-supported-hw = <0x30>;
+		};
+	};
+
 	pmu-a55 {
 		compatible = "arm,cortex-a55-pmu";
 		interrupt-parent = <&gic>;
@@ -765,7 +901,7 @@ mfg0: power-domain@MT8186_POWER_DOMAIN_MFG0 {
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
 
-					power-domain@MT8186_POWER_DOMAIN_MFG1 {
+					mfg1: power-domain@MT8186_POWER_DOMAIN_MFG1 {
 						reg = <MT8186_POWER_DOMAIN_MFG1>;
 						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
@@ -1558,6 +1694,8 @@ gpu: gpu@13040000 {
 			#cooling-cells = <2>;
 			nvmem-cells = <&gpu_speedbin>;
 			nvmem-cell-names = "speed-bin";
+			operating-points-v2 = <&gpu_opp_table>;
+			dynamic-power-coefficient = <4687>;
 			status = "disabled";
 		};
 
-- 
2.41.0.162.gfafddb0af9-goog

