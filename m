Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3D72910D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbjFIH3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbjFIH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:29:43 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0A130CB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:29:14 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1a1fa977667so462833fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686295754; x=1688887754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fiqfy79Fm9eELrPZKhr0IzKYUTLKfOcN1zfjvWIor1U=;
        b=LxMNX7PgqJYg8YS2zT4J43YxXo9Sb8PLiIJ9k2lgNd1Xh5voESEHcivw8u8jtBBzP/
         WiRjfyprxZi9kjfz9+meNBuo3OXBMaIc9u8YgtjYmT8e8l4RFqLi+LfeOuUoUm04yQKX
         bABGqbnX15cF3yKr5Ljr5dlBDIn9cA8v6Uc0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295754; x=1688887754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fiqfy79Fm9eELrPZKhr0IzKYUTLKfOcN1zfjvWIor1U=;
        b=ct77bIZh24UIyCYdRVHcZC9nvZxXJIWruBzEchQVE1jZRNytdVLVccPk+fK6FAziOk
         A215RhozpRcPZZKvWimqgZsCqppp9YWwBO9Utpa+zHHKL2Wbzz7h8wwFhfIhtSkXuSBT
         mblzj5HNWEqIgJiVwyW1jw4ztrjmnCcj5pIVx0FAHSJj7Bn6eoAy6xynNwkljTcHeZ7x
         waKQZGGL7DlLrL1HN98uGNLZqH4lUSad9CX/cj66msce8vuVg/XqB7Huyg3DV5a+28Ke
         yXUpmcB/4y0uCuc2dDBWNXq5B/mq7bV/BB/wSi1E1fRBM1bcG9M4LljPD6E2rcljSbRN
         lfnw==
X-Gm-Message-State: AC+VfDyG+Zn6viI1x1rzIvRoOK3rPLrs6i7Ydo6ajHFvl2UKygdpbAep
        jmUJHPaDMrZoAySFufVCbImOxw==
X-Google-Smtp-Source: ACHHUZ501Ve/MgepNvdJuxacEzoyyJ1OpWSjaxrZfy48TfjQ3Y9Q5kePfUaxCgQyognbCgNex8NP+g==
X-Received: by 2002:a05:6870:3505:b0:1a3:5de8:e78b with SMTP id k5-20020a056870350500b001a35de8e78bmr576923oah.21.1686295754188;
        Fri, 09 Jun 2023 00:29:14 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c2ea:d8e4:1fe8:21f0])
        by smtp.gmail.com with ESMTPSA id y9-20020a655a09000000b005287a0560c9sm2160283pgs.1.2023.06.09.00.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:29:13 -0700 (PDT)
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
Subject: [PATCH v2 1/4] arm64: dts: mediatek: mt8186: Add CCI node and CCI OPP table
Date:   Fri,  9 Jun 2023 15:29:02 +0800
Message-ID: <20230609072906.2784594-2-wenst@chromium.org>
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

Add a device node for the CCI (cache coherent interconnect) and an OPP
table for it. The OPP table was taken from the downstream ChromeOS
kernel.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Angelo, I didn't pick up your Reviewed-by since I dropped the
"opp-level" properties.

 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 101 +++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 8c02232cac38..93f3c45ba372 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -27,6 +27,99 @@ aliases {
 		rdma1 = &rdma1;
 	};
 
+	cci: cci {
+		compatible = "mediatek,mt8186-cci";
+		clocks = <&mcusys CLK_MCU_ARMPLL_BUS_SEL>,
+			 <&apmixedsys CLK_APMIXED_MAINPLL>;
+		clock-names = "cci", "intermediate";
+		operating-points-v2 = <&cci_opp>;
+	};
+
+	cci_opp: opp-table-cci {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cci_opp_0: opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <600000>;
+		};
+
+		cci_opp_1: opp-560000000 {
+			opp-hz = /bits/ 64 <560000000>;
+			opp-microvolt = <675000>;
+		};
+
+		cci_opp_2: opp-612000000 {
+			opp-hz = /bits/ 64 <612000000>;
+			opp-microvolt = <693750>;
+		};
+
+		cci_opp_3: opp-682000000 {
+			opp-hz = /bits/ 64 <682000000>;
+			opp-microvolt = <718750>;
+		};
+
+		cci_opp_4: opp-752000000 {
+			opp-hz = /bits/ 64 <752000000>;
+			opp-microvolt = <743750>;
+		};
+
+		cci_opp_5: opp-822000000 {
+			opp-hz = /bits/ 64 <822000000>;
+			opp-microvolt = <768750>;
+		};
+
+		cci_opp_6: opp-875000000 {
+			opp-hz = /bits/ 64 <875000000>;
+			opp-microvolt = <781250>;
+		};
+
+		cci_opp_7: opp-927000000 {
+			opp-hz = /bits/ 64 <927000000>;
+			opp-microvolt = <800000>;
+		};
+
+		cci_opp_8: opp-980000000 {
+			opp-hz = /bits/ 64 <980000000>;
+			opp-microvolt = <818750>;
+		};
+
+		cci_opp_9: opp-1050000000 {
+			opp-hz = /bits/ 64 <1050000000>;
+			opp-microvolt = <843750>;
+		};
+
+		cci_opp_10: opp-1120000000 {
+			opp-hz = /bits/ 64 <1120000000>;
+			opp-microvolt = <862500>;
+		};
+
+		cci_opp_11: opp-1155000000 {
+			opp-hz = /bits/ 64 <1155000000>;
+			opp-microvolt = <887500>;
+		};
+
+		cci_opp_12: opp-1190000000 {
+			opp-hz = /bits/ 64 <1190000000>;
+			opp-microvolt = <906250>;
+		};
+
+		cci_opp_13: opp-1260000000 {
+			opp-hz = /bits/ 64 <1260000000>;
+			opp-microvolt = <950000>;
+		};
+
+		cci_opp_14: opp-1330000000 {
+			opp-hz = /bits/ 64 <1330000000>;
+			opp-microvolt = <993750>;
+		};
+
+		cci_opp_15: opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1031250>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -83,6 +176,7 @@ cpu0: cpu@0 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu1: cpu@100 {
@@ -101,6 +195,7 @@ cpu1: cpu@100 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu2: cpu@200 {
@@ -119,6 +214,7 @@ cpu2: cpu@200 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu3: cpu@300 {
@@ -137,6 +233,7 @@ cpu3: cpu@300 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu4: cpu@400 {
@@ -155,6 +252,7 @@ cpu4: cpu@400 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu5: cpu@500 {
@@ -173,6 +271,7 @@ cpu5: cpu@500 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu6: cpu@600 {
@@ -191,6 +290,7 @@ cpu6: cpu@600 {
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu7: cpu@700 {
@@ -209,6 +309,7 @@ cpu7: cpu@700 {
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		idle-states {
-- 
2.41.0.162.gfafddb0af9-goog

