Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97B66241D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjAILWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbjAILWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:22:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97931869F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:22:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3906417wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 03:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+2JafMP4Z0J1ZI6rBEzhiM1z4nyMhn9KM4gsH+cqzk=;
        b=pgFFKhQHZkL6wlJiARzD46PYG7+a/uKfG9Gr+nS6ggE9Z4m1Z57meAzLopmfBVP4lf
         0afUCjDtlENvdXg0+Q6yIJ2ROzmGtkyDCBPphJVVulttADSF+qjMuGcGQ1UioxUqFwGC
         nBSRwtv4TK+ovMv2dxTSaZgy4WIwV0cTdl/6mcQ5ukiDEYETjXclgAHVSyDJL++2JYwT
         vHRMKaMwRPkVfHo0Zbw14H21iJh78j8gb5s2ViumesfzEL1eZVcp/z3w94amDAlNf8Vu
         GxLx2ADrrACFTggYYotjEC1B6rY+67Hcj4BC+pQxcroOLoLv6OVWpfDTGICe+2IiN4UF
         nQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+2JafMP4Z0J1ZI6rBEzhiM1z4nyMhn9KM4gsH+cqzk=;
        b=zGLRrDSnYVrzHX1qogd25WVdB97gkPqfOq5pqWTRdJ45+qf86eJJlQZFEquUdfib90
         jy/SSFLF/gp+E4d9eZl6ZVuoA2sImCa73z/pk2/DxES9oohYr53XJreibpbEzPaKzYz2
         iMGv30p/r9gZyQ/aA6fTdhyOVJfmHUd8q++gfsMe4wvjBVn0/JvxRSAhoy/vBnENSH5N
         NmY9Htihz8uwF5yPnWihor94B09Uagp3MqzR3Bkb4ixlmtFn5RA9REbFAl+ulAe8U6Rc
         /94PphGsysQSdXObrTGATLGcb+0v/ZjVyju0rZsNU+xGwnVVgUcl1Rjpaihacgj9/X3S
         mVAA==
X-Gm-Message-State: AFqh2kod6bs9Lz5u5eNfjy+PKsbC0gvKu5kNCFAyEGg8OkuJEqqzszOl
        dRg72iJ8UhoM8ULlvJ7QZE9IvQ==
X-Google-Smtp-Source: AMrXdXuujlpAfyjVzZbHV6KTRvDpA7+5oKguWRIF08CzXMr44jmOdAQXB5w0NKcTWyqjET44ZMqZHw==
X-Received: by 2002:a7b:c003:0:b0:3d2:bca5:10a2 with SMTP id c3-20020a7bc003000000b003d2bca510a2mr45807936wmb.22.1673263347183;
        Mon, 09 Jan 2023 03:22:27 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c3b8e00b003b49bd61b19sm17456986wms.15.2023.01.09.03.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:22:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/4] arm64: dts: qcom: align OPP table node name with DT schema
Date:   Mon,  9 Jan 2023 12:22:19 +0100
Message-Id: <20230109112221.102473-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109112221.102473-1-krzysztof.kozlowski@linaro.org>
References: <20230109112221.102473-1-krzysztof.kozlowski@linaro.org>
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

Bindings expect OPP tables to start with "opp-table".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add tags.
2. Re-order nodes (Johan)
---
 arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi |   2 +-
 arch/arm64/boot/dts/qcom/sa8540p.dtsi      |   4 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi     | 388 ++++++++++-----------
 arch/arm64/boot/dts/qcom/sdm845.dtsi       |   2 +-
 4 files changed, 198 insertions(+), 198 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
index 5728583af41e..929bdcd45d02 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
@@ -19,7 +19,7 @@ / {
   * features get enabled upstream.
   */
 
-gpu_opp_table_3_0: gpu-opp-table-30 {
+gpu_opp_table_3_0: opp-table-gpu30 {
 	compatible = "operating-points-v2";
 
 	opp-624000000 {
diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index a88452c20d05..4a990fda8fc3 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -10,7 +10,7 @@
 /delete-node/ &cpu4_opp_table;
 
 / {
-	cpu0_opp_table: cpu0-opp-table {
+	cpu0_opp_table: opp-table-cpu0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -92,7 +92,7 @@ opp-2246400000 {
 		};
 	};
 
-	cpu4_opp_table: cpu4-opp-table {
+	cpu4_opp_table: opp-table-cpu4 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 109c9d2b684d..79838ef8f8a6 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -33,186 +33,6 @@ sleep_clk: sleep-clk {
 		};
 	};
 
-	cpu0_opp_table: cpu0-opp-table {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-300000000 {
-			opp-hz = /bits/ 64 <300000000>;
-			opp-peak-kBps = <(300000 * 32)>;
-		};
-		opp-403200000 {
-			opp-hz = /bits/ 64 <403200000>;
-			opp-peak-kBps = <(384000 * 32)>;
-		};
-		opp-499200000 {
-			opp-hz = /bits/ 64 <499200000>;
-			opp-peak-kBps = <(480000 * 32)>;
-		};
-		opp-595200000 {
-			opp-hz = /bits/ 64 <595200000>;
-			opp-peak-kBps = <(576000 * 32)>;
-		};
-		opp-691200000 {
-			opp-hz = /bits/ 64 <691200000>;
-			opp-peak-kBps = <(672000 * 32)>;
-		};
-		opp-806400000 {
-			opp-hz = /bits/ 64 <806400000>;
-			opp-peak-kBps = <(768000 * 32)>;
-		};
-		opp-902400000 {
-			opp-hz = /bits/ 64 <902400000>;
-			opp-peak-kBps = <(864000 * 32)>;
-		};
-		opp-1017600000 {
-			opp-hz = /bits/ 64 <1017600000>;
-			opp-peak-kBps = <(960000 * 32)>;
-		};
-		opp-1113600000 {
-			opp-hz = /bits/ 64 <1113600000>;
-			opp-peak-kBps = <(1075200 * 32)>;
-		};
-		opp-1209600000 {
-			opp-hz = /bits/ 64 <1209600000>;
-			opp-peak-kBps = <(1171200 * 32)>;
-		};
-		opp-1324800000 {
-			opp-hz = /bits/ 64 <1324800000>;
-			opp-peak-kBps = <(1267200 * 32)>;
-		};
-		opp-1440000000 {
-			opp-hz = /bits/ 64 <1440000000>;
-			opp-peak-kBps = <(1363200 * 32)>;
-		};
-		opp-1555200000 {
-			opp-hz = /bits/ 64 <1555200000>;
-			opp-peak-kBps = <(1536000 * 32)>;
-		};
-		opp-1670400000 {
-			opp-hz = /bits/ 64 <1670400000>;
-			opp-peak-kBps = <(1612800 * 32)>;
-		};
-		opp-1785600000 {
-			opp-hz = /bits/ 64 <1785600000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-1881600000 {
-			opp-hz = /bits/ 64 <1881600000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-1996800000 {
-			opp-hz = /bits/ 64 <1996800000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2112000000 {
-			opp-hz = /bits/ 64 <2112000000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2227200000 {
-			opp-hz = /bits/ 64 <2227200000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2342400000 {
-			opp-hz = /bits/ 64 <2342400000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2438400000 {
-			opp-hz = /bits/ 64 <2438400000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-	};
-
-	cpu4_opp_table: cpu4-opp-table {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-825600000 {
-			opp-hz = /bits/ 64 <825600000>;
-			opp-peak-kBps = <(768000 * 32)>;
-		};
-		opp-940800000 {
-			opp-hz = /bits/ 64 <940800000>;
-			opp-peak-kBps = <(864000 * 32)>;
-		};
-		opp-1056000000 {
-			opp-hz = /bits/ 64 <1056000000>;
-			opp-peak-kBps = <(960000 * 32)>;
-		};
-		opp-1171200000 {
-			opp-hz = /bits/ 64 <1171200000>;
-			opp-peak-kBps = <(1171200 * 32)>;
-		};
-		opp-1286400000 {
-			opp-hz = /bits/ 64 <1286400000>;
-			opp-peak-kBps = <(1267200 * 32)>;
-		};
-		opp-1401600000 {
-			opp-hz = /bits/ 64 <1401600000>;
-			opp-peak-kBps = <(1363200 * 32)>;
-		};
-		opp-1516800000 {
-			opp-hz = /bits/ 64 <1516800000>;
-			opp-peak-kBps = <(1459200 * 32)>;
-		};
-		opp-1632000000 {
-			opp-hz = /bits/ 64 <1632000000>;
-			opp-peak-kBps = <(1612800 * 32)>;
-		};
-		opp-1747200000 {
-			opp-hz = /bits/ 64 <1747200000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-1862400000 {
-			opp-hz = /bits/ 64 <1862400000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-1977600000 {
-			opp-hz = /bits/ 64 <1977600000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2073600000 {
-			opp-hz = /bits/ 64 <2073600000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2169600000 {
-			opp-hz = /bits/ 64 <2169600000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2284800000 {
-			opp-hz = /bits/ 64 <2284800000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2400000000 {
-			opp-hz = /bits/ 64 <2400000000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2496000000 {
-			opp-hz = /bits/ 64 <2496000000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2592000000 {
-			opp-hz = /bits/ 64 <2592000000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2688000000 {
-			opp-hz = /bits/ 64 <2688000000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2803200000 {
-			opp-hz = /bits/ 64 <2803200000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2899200000 {
-			opp-hz = /bits/ 64 <2899200000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-		opp-2995200000 {
-			opp-hz = /bits/ 64 <2995200000>;
-			opp-peak-kBps = <(1689600 * 32)>;
-		};
-	};
-
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -528,6 +348,200 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <(300000 * 32)>;
+		};
+		opp-403200000 {
+			opp-hz = /bits/ 64 <403200000>;
+			opp-peak-kBps = <(384000 * 32)>;
+		};
+		opp-499200000 {
+			opp-hz = /bits/ 64 <499200000>;
+			opp-peak-kBps = <(480000 * 32)>;
+		};
+		opp-595200000 {
+			opp-hz = /bits/ 64 <595200000>;
+			opp-peak-kBps = <(576000 * 32)>;
+		};
+		opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-peak-kBps = <(672000 * 32)>;
+		};
+		opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			opp-peak-kBps = <(768000 * 32)>;
+		};
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <(864000 * 32)>;
+		};
+		opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <(960000 * 32)>;
+		};
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-peak-kBps = <(1075200 * 32)>;
+		};
+		opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			opp-peak-kBps = <(1171200 * 32)>;
+		};
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <(1267200 * 32)>;
+		};
+		opp-1440000000 {
+			opp-hz = /bits/ 64 <1440000000>;
+			opp-peak-kBps = <(1363200 * 32)>;
+		};
+		opp-1555200000 {
+			opp-hz = /bits/ 64 <1555200000>;
+			opp-peak-kBps = <(1536000 * 32)>;
+		};
+		opp-1670400000 {
+			opp-hz = /bits/ 64 <1670400000>;
+			opp-peak-kBps = <(1612800 * 32)>;
+		};
+		opp-1785600000 {
+			opp-hz = /bits/ 64 <1785600000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-1881600000 {
+			opp-hz = /bits/ 64 <1881600000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2227200000 {
+			opp-hz = /bits/ 64 <2227200000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2342400000 {
+			opp-hz = /bits/ 64 <2342400000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2438400000 {
+			opp-hz = /bits/ 64 <2438400000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+	};
+
+	cpu4_opp_table: opp-table-cpu4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			opp-peak-kBps = <(768000 * 32)>;
+		};
+		opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <(864000 * 32)>;
+		};
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-peak-kBps = <(960000 * 32)>;
+		};
+		opp-1171200000 {
+			opp-hz = /bits/ 64 <1171200000>;
+			opp-peak-kBps = <(1171200 * 32)>;
+		};
+		opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			opp-peak-kBps = <(1267200 * 32)>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			opp-peak-kBps = <(1363200 * 32)>;
+		};
+		opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <(1459200 * 32)>;
+		};
+		opp-1632000000 {
+			opp-hz = /bits/ 64 <1632000000>;
+			opp-peak-kBps = <(1612800 * 32)>;
+		};
+		opp-1747200000 {
+			opp-hz = /bits/ 64 <1747200000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-1862400000 {
+			opp-hz = /bits/ 64 <1862400000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-1977600000 {
+			opp-hz = /bits/ 64 <1977600000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2073600000 {
+			opp-hz = /bits/ 64 <2073600000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2169600000 {
+			opp-hz = /bits/ 64 <2169600000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2284800000 {
+			opp-hz = /bits/ 64 <2284800000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2496000000 {
+			opp-hz = /bits/ 64 <2496000000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2592000000 {
+			opp-hz = /bits/ 64 <2592000000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2688000000 {
+			opp-hz = /bits/ 64 <2688000000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2803200000 {
+			opp-hz = /bits/ 64 <2803200000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2899200000 {
+			opp-hz = /bits/ 64 <2899200000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+		opp-2995200000 {
+			opp-hz = /bits/ 64 <2995200000>;
+			opp-peak-kBps = <(1689600 * 32)>;
+		};
+	};
+
+	qup_opp_table_100mhz: opp-table-qup100mhz {
+		compatible = "operating-points-v2";
+
+		opp-75000000 {
+			opp-hz = /bits/ 64 <75000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
@@ -591,20 +605,6 @@ CLUSTER_PD: cpu-cluster0 {
 		};
 	};
 
-	qup_opp_table_100mhz: qup-100mhz-opp-table {
-		compatible = "operating-points-v2";
-
-		opp-75000000 {
-			opp-hz = /bits/ 64 <75000000>;
-			required-opps = <&rpmhpd_opp_low_svs>;
-		};
-
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			required-opps = <&rpmhpd_opp_svs>;
-		};
-	};
-
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 65032b94b46d..ba48adc01170 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4619,7 +4619,7 @@ port@1 {
 					};
 				};
 
-				dp_opp_table: dp-opp-table {
+				dp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
 					opp-162000000 {
-- 
2.34.1

