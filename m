Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC25874EC27
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGKLBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjGKLBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:01:00 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04095E69
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:00:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b69923a715so87334131fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689073256; x=1691665256;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e71PFyYiC6Y3UsFUtQJWJLx1ymLcHPZ05b2q5jlax+0=;
        b=z6+yAQEepCPybBPJ6beR9Noxz3RdOPYcOM6aIgL38qw3uw1qRmKuUpGrCPkcHTgUUP
         ZFuLPCEWcWVwJX0ScNbKr/uB0rTHvG73yMGg0Uidl2m+q4jhl9o2zdAaX7OERSCjkdGe
         LghVnZ8L6r+6/qB8kBLEOlvSayTW/XRl7X387zKO92+pBa5nNOxh3Dpo4ZhvDWsC6aLE
         n/XUrUDI+/PtWnjkjcGB979o3CP7/UiqS5KkapOXB66VBe0KAsrpfdapj3Kr664Ofkjw
         ZsN98SPWW2Ilr56v2swRfCLsioVBQ+1EsuxsFXHbOTiUx/+Qx1MW7gW15hCI9za/ddNg
         urLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689073256; x=1691665256;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e71PFyYiC6Y3UsFUtQJWJLx1ymLcHPZ05b2q5jlax+0=;
        b=NZhaZRNjn9ZFBSEZYAbuEF10+ewgeNv55KZARpobWwrQmacY55wE4/0hRc4mfSpEwa
         WYRH1/e9vTyTtIk30/ZbSpM/QkVL8HHclEfaL00N0+GHsR/C7E9rEwYguKopuf9giEzm
         1TqFJv0qG0YfVXusqGQfLlh9xswTNLRHJijrYp5cE32msuvM8XEsHjU1Dq8Rh4dqkjAH
         tzEY8p8YLmZXC/EmAfHNt0miZ7CnRMZyDxM7Ai3H5Y6OvNwNagq0eWRpFQslqiog+22s
         /r805Kmxr+4w3fYpuQ1wo/Z7JKKM1LVTI8H7hfAnn1yoHdwATmRjIb+jgIE2NF5w4QWj
         7Kjg==
X-Gm-Message-State: ABy/qLYoZjW084cSVM9T18fYEbg2oN8W1/JI3+KAthzamLFejQNjHyYw
        3Zx1X6RELVnrpIZ/j8DzzSlsXKuccnFSjpIgQiBDVg==
X-Google-Smtp-Source: APBJJlFOrb61WhkwO95sypyv9S+x/OltI27O+G8+iT80bs5tvXqvSXLXJZUUj6wWB+gwy5Wkk6eUPA==
X-Received: by 2002:a2e:700e:0:b0:2b5:97a3:3ba5 with SMTP id l14-20020a2e700e000000b002b597a33ba5mr11968089ljc.10.1689073255962;
        Tue, 11 Jul 2023 04:00:55 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id u15-20020a2e9f0f000000b002b6a5dfc7f3sm406007ljk.30.2023.07.11.04.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 04:00:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 13:00:53 +0200
Subject: [PATCH] arm64: dts: qcom: sc7180: Bring back cpufreq-based DDR
 votes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-topic-7180ddr-v1-1-56e4f13afe9b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGQ2rWQC/x2NywqDQAwAf0VybmCztqz0V0oP+4g1IKtkaymI/
 27wOAPD7NBYhRs8ux2Uf9JkqQZ06yBPsX4YpRiDd753gQi/yyoZAw2uFMUUaOTeD3f/YLAmxca
 YNNY8WVW3eTa5Ko/yvyav93GcDo8pc3QAAAA=
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689073254; l=9646;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Bmevh9zAK+HpB3KmI+Na+AV2fzg4mRRI54dCpsrCbl0=;
 b=fNODqyWG0zyq+V31QU440KRFthHpqZYtcwy+TottlegDIy+yEmWSVW1jo9wgIRQ3ekbP7VXv6
 aoIil0L9bJJBigg1oGLR6v5k99iZn/51iCt2nrIuwjoKQnIM/YKzBBp
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChromeOS folks reported that bwmon is too slow and getting rid of
statically defined CPUFREQ-based votes (effectively floor votes because of
how opp-peak-kBps is interpreted), has a major performance impact in some
common applications. Bring them back until MEMLAT support is introduced.

This is a partial revert of the commit referenced in the fixes tag.

Fixes: adc16b84e1ea ("arm64: dts: qcom: sc7180: Hook up BWMONs")
Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-lite.dtsi | 10 ++--
 arch/arm64/boot/dts/qcom/sc7180.dtsi      | 76 +++++++++++++++++--------------
 2 files changed, 47 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
index 975d4422f27b..4b306a59d9be 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
@@ -6,21 +6,21 @@
  */
 
 &cpu6_opp10 {
-	opp-peak-kBps = <22425600>;
+	opp-peak-kBps = <7216000 22425600>;
 };
 
 &cpu6_opp11 {
-	opp-peak-kBps = <22425600>;
+	opp-peak-kBps = <7216000 22425600>;
 };
 
 &cpu6_opp12 {
-	opp-peak-kBps = <23347200>;
+	opp-peak-kBps = <8532000 23347200>;
 };
 
 &cpu6_opp13 {
-	opp-peak-kBps = <23347200>;
+	opp-peak-kBps = <8532000 23347200>;
 };
 
 &cpu6_opp14 {
-	opp-peak-kBps = <23347200>;
+	opp-peak-kBps = <8532000 23347200>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 179544ba12db..9af94e267f84 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -85,7 +85,8 @@ &LITTLE_CPU_SLEEP_1
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -115,7 +116,8 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_100>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
@@ -139,7 +141,8 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_200>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
@@ -163,7 +166,8 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_300>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
@@ -187,7 +191,8 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_400>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_400: l2-cache {
@@ -211,7 +216,8 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_500>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_500: l2-cache {
@@ -235,7 +241,8 @@ &BIG_CPU_SLEEP_1
 			dynamic-power-coefficient = <480>;
 			next-level-cache = <&L2_600>;
 			operating-points-v2 = <&cpu6_opp_table>;
-			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
@@ -259,7 +266,8 @@ &BIG_CPU_SLEEP_1
 			dynamic-power-coefficient = <480>;
 			next-level-cache = <&L2_700>;
 			operating-points-v2 = <&cpu6_opp_table>;
-			interconnects = <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_700: l2-cache {
@@ -379,52 +387,52 @@ cpu0_opp_table: opp-table-cpu0 {
 
 		cpu0_opp1: opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
-			opp-peak-kBps = <4800000>;
+			opp-peak-kBps = <1200000 4800000>;
 		};
 
 		cpu0_opp2: opp-576000000 {
 			opp-hz = /bits/ 64 <576000000>;
-			opp-peak-kBps = <4800000>;
+			opp-peak-kBps = <1200000 4800000>;
 		};
 
 		cpu0_opp3: opp-768000000 {
 			opp-hz = /bits/ 64 <768000000>;
-			opp-peak-kBps = <4800000>;
+			opp-peak-kBps = <1200000 4800000>;
 		};
 
 		cpu0_opp4: opp-1017600000 {
 			opp-hz = /bits/ 64 <1017600000>;
-			opp-peak-kBps = <8908800>;
+			opp-peak-kBps = <1804000 8908800>;
 		};
 
 		cpu0_opp5: opp-1248000000 {
 			opp-hz = /bits/ 64 <1248000000>;
-			opp-peak-kBps = <12902400>;
+			opp-peak-kBps = <2188000 12902400>;
 		};
 
 		cpu0_opp6: opp-1324800000 {
 			opp-hz = /bits/ 64 <1324800000>;
-			opp-peak-kBps = <12902400>;
+			opp-peak-kBps = <2188000 12902400>;
 		};
 
 		cpu0_opp7: opp-1516800000 {
 			opp-hz = /bits/ 64 <1516800000>;
-			opp-peak-kBps = <15052800>;
+			opp-peak-kBps = <3072000 15052800>;
 		};
 
 		cpu0_opp8: opp-1612800000 {
 			opp-hz = /bits/ 64 <1612800000>;
-			opp-peak-kBps = <15052800>;
+			opp-peak-kBps = <3072000 15052800>;
 		};
 
 		cpu0_opp9: opp-1708800000 {
 			opp-hz = /bits/ 64 <1708800000>;
-			opp-peak-kBps = <15052800>;
+			opp-peak-kBps = <3072000 15052800>;
 		};
 
 		cpu0_opp10: opp-1804800000 {
 			opp-hz = /bits/ 64 <1804800000>;
-			opp-peak-kBps = <22425600>;
+			opp-peak-kBps = <4068000 22425600>;
 		};
 	};
 
@@ -434,82 +442,82 @@ cpu6_opp_table: opp-table-cpu6 {
 
 		cpu6_opp1: opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
-			opp-peak-kBps = <8908800>;
+			opp-peak-kBps = <2188000 8908800>;
 		};
 
 		cpu6_opp2: opp-652800000 {
 			opp-hz = /bits/ 64 <652800000>;
-			opp-peak-kBps = <8908800>;
+			opp-peak-kBps = <2188000 8908800>;
 		};
 
 		cpu6_opp3: opp-825600000 {
 			opp-hz = /bits/ 64 <825600000>;
-			opp-peak-kBps = <8908800>;
+			opp-peak-kBps = <2188000 8908800>;
 		};
 
 		cpu6_opp4: opp-979200000 {
 			opp-hz = /bits/ 64 <979200000>;
-			opp-peak-kBps = <8908800>;
+			opp-peak-kBps = <2188000 8908800>;
 		};
 
 		cpu6_opp5: opp-1113600000 {
 			opp-hz = /bits/ 64 <1113600000>;
-			opp-peak-kBps = <8908800>;
+			opp-peak-kBps = <2188000 8908800>;
 		};
 
 		cpu6_opp6: opp-1267200000 {
 			opp-hz = /bits/ 64 <1267200000>;
-			opp-peak-kBps = <12902400>;
+			opp-peak-kBps = <4068000 12902400>;
 		};
 
 		cpu6_opp7: opp-1555200000 {
 			opp-hz = /bits/ 64 <1555200000>;
-			opp-peak-kBps = <15052800>;
+			opp-peak-kBps = <4068000 15052800>;
 		};
 
 		cpu6_opp8: opp-1708800000 {
 			opp-hz = /bits/ 64 <1708800000>;
-			opp-peak-kBps = <19353600>;
+			opp-peak-kBps = <6220000 19353600>;
 		};
 
 		cpu6_opp9: opp-1843200000 {
 			opp-hz = /bits/ 64 <1843200000>;
-			opp-peak-kBps = <19353600>;
+			opp-peak-kBps = <6220000 19353600>;
 		};
 
 		cpu6_opp10: opp-1900800000 {
 			opp-hz = /bits/ 64 <1900800000>;
-			opp-peak-kBps = <22425600>;
+			opp-peak-kBps = <6220000 22425600>;
 		};
 
 		cpu6_opp11: opp-1996800000 {
 			opp-hz = /bits/ 64 <1996800000>;
-			opp-peak-kBps = <22425600>;
+			opp-peak-kBps = <6220000 22425600>;
 		};
 
 		cpu6_opp12: opp-2112000000 {
 			opp-hz = /bits/ 64 <2112000000>;
-			opp-peak-kBps = <22425600>;
+			opp-peak-kBps = <6220000 22425600>;
 		};
 
 		cpu6_opp13: opp-2208000000 {
 			opp-hz = /bits/ 64 <2208000000>;
-			opp-peak-kBps = <22425600>;
+			opp-peak-kBps = <7216000 22425600>;
 		};
 
 		cpu6_opp14: opp-2323200000 {
 			opp-hz = /bits/ 64 <2323200000>;
-			opp-peak-kBps = <22425600>;
+			opp-peak-kBps = <7216000 22425600>;
 		};
 
 		cpu6_opp15: opp-2400000000 {
 			opp-hz = /bits/ 64 <2400000000>;
-			opp-peak-kBps = <23347200>;
+			opp-peak-kBps = <8532000 23347200>;
 		};
 
 		cpu6_opp16: opp-2553600000 {
 			opp-hz = /bits/ 64 <2553600000>;
-			opp-peak-kBps = <23347200>;
+			opp-peak-kBps = <8532000 23347200>;
 		};
 	};
 

---
base-commit: 8e4b7f2f3d6071665b1dfd70786229c8a5d6c256
change-id: 20230711-topic-7180ddr-b71fe328425e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

