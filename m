Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6556E725989
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbjFGJIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbjFGJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:07:41 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4468426B1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:07:03 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1a27ffe9dcdso6801206fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686128822; x=1688720822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz76j0qRG7M80pmlEKyVRAG1FYXj27a46ctowWFtgUI=;
        b=EwJ6ylXOZhGaP+0ge6C4IJsrjlSUexk1wQ6jL3h3wsudSISMlA/XDzEVnr91bilrJY
         ctT78e5Tf15nGS3bKaNGTd0zw4MoJ/EAwEfIcwuz2YEKYPhx6pX96frDRMCVbZKPXuIf
         zUPolFsiG4YV2W9LmDFX6U3BILbEJB4grFYuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128822; x=1688720822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nz76j0qRG7M80pmlEKyVRAG1FYXj27a46ctowWFtgUI=;
        b=WNGMXV37+1cVGLLcN35IWPjKvfwrLUt4yybOARN/QYA4bSNPDEqt3gjgVcRdz6QE8g
         LU9NxrPDUitX/An2LQacaVVEa0bY/uLOGQnS6Zxg+2/+C+NKfar+jVrcUziDoluaraGN
         sZV8GYUUA0GRGaVb+JkqcATlQRGFzAYMHuHaKEyRdLV0ElLH98RUAx0DXtQ5j0oteVyt
         14E9xgtIAjNxyrnS25RInpV5l+3OQzdbLWdgK3pPYOo994UrZy0nSV7K6wUbNCxpCDa7
         +FQXMBiRagcrgucLUIoTzIK+6rBhxJVcJSIzr2OY3h/ww5T8IgzRbYhHqXr8gSISPl6a
         Adiw==
X-Gm-Message-State: AC+VfDznwyNbiQmJxDgdztiFoHCEhbEZGjOi+j0NYvxicWAETAxGqevA
        FRFoYIdvT0hb06HWUYw0ln+LYw==
X-Google-Smtp-Source: ACHHUZ7hcSVOowiPXhPeqmmoXLnSzASTWamdqYbyKBsrA0/VfrVRfq1YMn7GAAugHeW71s9tNSygag==
X-Received: by 2002:a05:6358:c591:b0:125:a552:4389 with SMTP id fc17-20020a056358c59100b00125a5524389mr2980713rwb.22.1686128822414;
        Wed, 07 Jun 2023 02:07:02 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:443b:29bb:b677:185d])
        by smtp.gmail.com with ESMTPSA id b38-20020a631b66000000b0051eff0a70d7sm8505732pgm.94.2023.06.07.02.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:07:02 -0700 (PDT)
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
Subject: [PATCH 1/4] arm64: dts: mediatek: mt8186: Add CCI node and CCI OPP table
Date:   Wed,  7 Jun 2023 17:06:49 +0800
Message-ID: <20230607090653.2468317-2-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230607090653.2468317-1-wenst@chromium.org>
References: <20230607090653.2468317-1-wenst@chromium.org>
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
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 117 +++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 8c02232cac38..1b754f7a0725 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -27,6 +27,115 @@ aliases {
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
+			opp-level = <15>;
+		};
+
+		cci_opp_1: opp-560000000 {
+			opp-hz = /bits/ 64 <560000000>;
+			opp-microvolt = <675000>;
+			opp-level = <14>;
+		};
+
+		cci_opp_2: opp-612000000 {
+			opp-hz = /bits/ 64 <612000000>;
+			opp-microvolt = <693750>;
+			opp-level = <13>;
+		};
+
+		cci_opp_3: opp-682000000 {
+			opp-hz = /bits/ 64 <682000000>;
+			opp-microvolt = <718750>;
+			opp-level = <12>;
+		};
+
+		cci_opp_4: opp-752000000 {
+			opp-hz = /bits/ 64 <752000000>;
+			opp-microvolt = <743750>;
+			opp-level = <11>;
+		};
+
+		cci_opp_5: opp-822000000 {
+			opp-hz = /bits/ 64 <822000000>;
+			opp-microvolt = <768750>;
+			opp-level = <10>;
+		};
+
+		cci_opp_6: opp-875000000 {
+			opp-hz = /bits/ 64 <875000000>;
+			opp-microvolt = <781250>;
+			opp-level = <9>;
+		};
+
+		cci_opp_7: opp-927000000 {
+			opp-hz = /bits/ 64 <927000000>;
+			opp-microvolt = <800000>;
+			opp-level = <8>;
+		};
+
+		cci_opp_8: opp-980000000 {
+			opp-hz = /bits/ 64 <980000000>;
+			opp-microvolt = <818750>;
+			opp-level = <7>;
+		};
+
+		cci_opp_9: opp-1050000000 {
+			opp-hz = /bits/ 64 <1050000000>;
+			opp-microvolt = <843750>;
+			opp-level = <6>;
+		};
+
+		cci_opp_10: opp-1120000000 {
+			opp-hz = /bits/ 64 <1120000000>;
+			opp-microvolt = <862500>;
+			opp-level = <5>;
+		};
+
+		cci_opp_11: opp-1155000000 {
+			opp-hz = /bits/ 64 <1155000000>;
+			opp-microvolt = <887500>;
+			opp-level = <4>;
+		};
+
+		cci_opp_12: opp-1190000000 {
+			opp-hz = /bits/ 64 <1190000000>;
+			opp-microvolt = <906250>;
+			opp-level = <3>;
+		};
+
+		cci_opp_13: opp-1260000000 {
+			opp-hz = /bits/ 64 <1260000000>;
+			opp-microvolt = <950000>;
+			opp-level = <2>;
+		};
+
+		cci_opp_14: opp-1330000000 {
+			opp-hz = /bits/ 64 <1330000000>;
+			opp-microvolt = <993750>;
+			opp-level = <1>;
+		};
+
+		cci_opp_15: opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1031250>;
+			opp-level = <0>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -83,6 +192,7 @@ cpu0: cpu@0 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu1: cpu@100 {
@@ -101,6 +211,7 @@ cpu1: cpu@100 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu2: cpu@200 {
@@ -119,6 +230,7 @@ cpu2: cpu@200 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu3: cpu@300 {
@@ -137,6 +249,7 @@ cpu3: cpu@300 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu4: cpu@400 {
@@ -155,6 +268,7 @@ cpu4: cpu@400 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu5: cpu@500 {
@@ -173,6 +287,7 @@ cpu5: cpu@500 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu6: cpu@600 {
@@ -191,6 +306,7 @@ cpu6: cpu@600 {
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu7: cpu@700 {
@@ -209,6 +325,7 @@ cpu7: cpu@700 {
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		idle-states {
-- 
2.41.0.rc0.172.g3f132b7071-goog

