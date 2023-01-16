Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16E66BAA4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjAPJkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjAPJjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:39:21 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FA18B2B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:39:18 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bf43so41898623lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SznKHiGcp/8WHrkgnMXn+1yfwqaexNaDkHfRLG7zyX0=;
        b=dl4ztDDvHttg7n4iOIEIlzTVy83O+5E6aXbgzHBe6boBV7iiF1eNmHxvou1t1XuuVt
         8bHXOa3g2M696sVpFU4HDQN9Pyd+0lJeSdbO3s0xuC4LLeLhkAzR52FW9xYZ6wVUZAaA
         oxIIKWSmWIn2fL5qxD+uwfgvQ13iBwDZqD5SxmZXPT1L2PenJfFVQjlW1mwvTySFfkPa
         0dsEy5Ca/xo54KoirU3wpwMuLzqs9i8TLGozCCWwME/ty2rC+dvGnp3foqaAZPWtxzCJ
         Fa8+UrFU/eAFAT7+09kvM1ei68/3TMYVhGhvRCNgbGNl+quuB7YfSs9iWmbTYm530kj8
         TpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SznKHiGcp/8WHrkgnMXn+1yfwqaexNaDkHfRLG7zyX0=;
        b=ylkfAyZdqqWcWyCa0XvycrzyraBuJjEIqDqHGmNkHcOn6L6401CKDVFAqCPMCTEBZL
         brZmJWGyk5H1zVnDNU+hFhaViYZJz5+E9+5i1IXWGgVdzTho+SCkMPxX1mCTFcO22W2f
         /TL5qkBsKNU4cdFnMdvghCMg0h4X4VwYdirqxp0VtoR94PeOl9CJlxNz1tMjxe0CAQcd
         XgytUE1qdNxyEIUMjYknRW/ecEIVnVVwxj9CF/S0rGwtgIetwjBCm69m0OVOcXv4r7JF
         ofKZv5JAZosh4m3Px+tBcz6mylp12aOFVzkPgy6zIqW+YgwFCRkp9LeGVyFboTOddqGD
         oGMQ==
X-Gm-Message-State: AFqh2krOXp8PZXiTc/uftVkxjJJY7xHGGObWPKW1f3gjl4ntcwxnsQ+o
        iV2nNQH20O99xrxdUa/B6p2UFA==
X-Google-Smtp-Source: AMrXdXs3qcBzoSyLr9qhIS41ButplqoYEst6fMinNodrw4FJjVD7CWEmkRcAhsh/xFMmx/ZrYzIe5g==
X-Received: by 2002:ac2:551c:0:b0:4a4:68b8:c2b8 with SMTP id j28-20020ac2551c000000b004a468b8c2b8mr2980405lfk.15.1673861956497;
        Mon, 16 Jan 2023 01:39:16 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id c5-20020a056512074500b004b53eb60e3csm316985lfs.256.2023.01.16.01.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 01:39:16 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/6] arm64: dts: qcom: msm8998: Configure CPRh
Date:   Mon, 16 Jan 2023 10:38:45 +0100
Message-Id: <20230116093845.72621-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116093845.72621-1-konrad.dybcio@linaro.org>
References: <20230116093845.72621-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Now that the CPR v3/v4/Hardened is ready, enable it on MSM8998.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: separate from adding cpufreq, sort nodes and use lowercase hex]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 873 ++++++++++++++++++++++++++
 1 file changed, 873 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index af29a4bfd109..aa9b32ba2556 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -139,6 +139,9 @@ CPU0: cpu@0 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -153,6 +156,9 @@ CPU1: cpu@1 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 		};
 
 		CPU2: cpu@2 {
@@ -163,6 +169,9 @@ CPU2: cpu@2 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 		};
 
 		CPU3: cpu@3 {
@@ -173,6 +182,9 @@ CPU3: cpu@3 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			power-domains = <&apc_cprh 0>;
+			power-domain-names = "cprh";
 		};
 
 		CPU4: cpu@100 {
@@ -183,6 +195,9 @@ CPU4: cpu@100 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -197,6 +212,9 @@ CPU5: cpu@101 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 		};
 
 		CPU6: cpu@102 {
@@ -207,6 +225,9 @@ CPU6: cpu@102 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 		};
 
 		CPU7: cpu@103 {
@@ -217,6 +238,9 @@ CPU7: cpu@103 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			power-domains = <&apc_cprh 1>;
+			power-domain-names = "cprh";
 		};
 
 		cpu-map {
@@ -310,6 +334,606 @@ scm {
 		};
 	};
 
+	cprh_opp_table: opp-table-cprh {
+		compatible = "operating-points-v2-qcom-level";
+
+		cprh_opp1: opp-1 {
+			opp-level = <1>;
+			qcom,opp-fuse-level = <1>;
+			qcom,opp-cloop-vadj = <0>;
+			qcom,opp-oloop-vadj = <0>;
+		};
+
+		cprh_opp2: opp-2 {
+			opp-level = <2>;
+			qcom,opp-fuse-level = <1>;
+			qcom,opp-cloop-vadj = <0>;
+			qcom,opp-oloop-vadj = <0>;
+		};
+
+		cprh_opp3: opp-3 {
+			opp-level = <3>;
+			qcom,opp-fuse-level = <1>;
+			qcom,opp-cloop-vadj = <0>;
+			qcom,opp-oloop-vadj = <0>;
+		};
+
+		cprh_opp4: opp-4 {
+			opp-level = <4>;
+			qcom,opp-fuse-level = <1>;
+			qcom,opp-cloop-vadj = <0>;
+			qcom,opp-oloop-vadj = <0>;
+		};
+
+		cprh_opp5: opp-5 {
+			opp-level = <5>;
+			qcom,opp-fuse-level = <1>;
+			qcom,opp-cloop-vadj = <0>;
+			qcom,opp-oloop-vadj = <0>;
+		};
+
+		cprh_opp6: opp-6 {
+			opp-level = <6>;
+			qcom,opp-fuse-level = <1>;
+			qcom,opp-cloop-vadj = <0>;
+			qcom,opp-oloop-vadj = <0>;
+		};
+
+		cprh_opp7: opp-7 {
+			opp-level = <7>;
+			qcom,opp-fuse-level = <1>;
+			qcom,opp-cloop-vadj = <0>;
+			qcom,opp-oloop-vadj = <0>;
+		};
+
+		cprh_opp8: opp-8 {
+			opp-level = <8>;
+			qcom,opp-fuse-level = <1>;
+			qcom,opp-cloop-vadj = <0>;
+			qcom,opp-oloop-vadj = <0>;
+		};
+
+		cprh_opp9: opp-9 {
+			opp-level = <9>;
+			qcom,opp-fuse-level = <2>;
+			qcom,opp-cloop-vadj = <0>;
+			qcom,opp-oloop-vadj = <0>;
+		};
+
+		cprh_opp10: opp-10 {
+			opp-level = <10>;
+			qcom,opp-fuse-level = <2>;
+			qcom,opp-cloop-vadj = <0>;
+			qcom,opp-oloop-vadj = <0>;
+		};
+
+		cprh_opp11: opp-11 {
+			opp-level = <11>;
+			qcom,opp-fuse-level = <2>;
+			qcom,opp-cloop-vadj = <0>;
+			qcom,opp-oloop-vadj = <0>;
+		};
+
+		cprh_opp12: opp-12 {
+			opp-level = <12>;
+			qcom,opp-fuse-level = <3 2>;
+			qcom,opp-cloop-vadj = <(-10000) (-10000)>;
+			qcom,opp-oloop-vadj = <(-12000) (-8000)>;
+		};
+
+		cprh_opp13: opp-13 {
+			opp-level = <13>;
+			qcom,opp-fuse-level = <3>;
+			qcom,opp-cloop-vadj = <(-11000) (-10000)>;
+			qcom,opp-oloop-vadj = <(-16000) (-16000)>;
+		};
+
+		cprh_opp14: opp-14 {
+			opp-level = <14>;
+			qcom,opp-fuse-level = <3>;
+			qcom,opp-cloop-vadj = <(-12000) (-11000)>;
+			qcom,opp-oloop-vadj = <(-16000) (-12000)>;
+		};
+
+		cprh_opp15: opp-15 {
+			opp-level = <15>;
+			qcom,opp-fuse-level = <3>;
+			qcom,opp-cloop-vadj = <(-13000) (-12000)>;
+			qcom,opp-oloop-vadj = <(-12000) (-16000)>;
+		};
+
+		cprh_opp16: opp-16 {
+			opp-level = <16>;
+			qcom,opp-fuse-level = <3>;
+			qcom,opp-cloop-vadj = <(-14000) (-12000)>;
+			qcom,opp-oloop-vadj = <(-12000) (-16000)>;
+		};
+
+		cprh_opp17: opp-17 {
+			opp-level = <17>;
+			qcom,opp-fuse-level = <3>;
+			qcom,opp-cloop-vadj = <(-14000) (-13000)>;
+			qcom,opp-oloop-vadj = <(-16000) (-12000)>;
+		};
+
+		cprh_opp18: opp-18 {
+			opp-level = <18>;
+			qcom,opp-fuse-level = <3>;
+			qcom,opp-cloop-vadj = <(-15000) (-14000)>;
+			qcom,opp-oloop-vadj = <(-16000) (-16000)>;
+		};
+
+		cprh_opp19: opp-19 {
+			opp-level = <19>;
+			qcom,opp-fuse-level = <4 3>;
+			qcom,opp-cloop-vadj = <(-21000) (-14000)>;
+			qcom,opp-oloop-vadj = <(-20000) (-16000)>;
+		};
+
+		cprh_opp20: opp-20 {
+			opp-level = <20>;
+			qcom,opp-fuse-level = <4 3>;
+			qcom,opp-cloop-vadj = <(-24000) (-15000)>;
+			qcom,opp-oloop-vadj = <(-24000) (-16000)>;
+		};
+
+		cprh_opp21: opp-21 {
+			opp-level = <21>;
+			qcom,opp-fuse-level = <4>;
+			qcom,opp-cloop-vadj = <(-26000) (-16000)>;
+			qcom,opp-oloop-vadj = <(-28000) (-24000)>;
+		};
+
+		cprh_opp22: opp-22 {
+			opp-level = <22>;
+			qcom,opp-fuse-level = <4>;
+			qcom,opp-cloop-vadj = <(-28000) (-16000)>;
+			qcom,opp-oloop-vadj = <(-28000) (-16000)>;
+		};
+
+		cprh_opp23: opp-23 {
+			opp-level = <23>;
+			qcom,opp-fuse-level = <4>;
+			qcom,opp-cloop-vadj = <0 (-17000)>;
+			qcom,opp-oloop-vadj = <0 (-20000)>;
+		};
+
+		cprh_opp24: opp-24 {
+			opp-level = <24>;
+			qcom,opp-fuse-level = <4>;
+			qcom,opp-cloop-vadj = <0 (-15000)>;
+			qcom,opp-oloop-vadj = <0 (-16000)>;
+		};
+
+		cprh_opp25: opp-25 {
+			opp-level = <25>;
+			qcom,opp-fuse-level = <4>;
+			qcom,opp-cloop-vadj = <0 (-14000)>;
+			qcom,opp-oloop-vadj = <0 (-12000)>;
+		};
+
+		cprh_opp26: opp-26 {
+			opp-level = <26>;
+			qcom,opp-fuse-level = <4>;
+			qcom,opp-cloop-vadj = <0 (-27000)>;
+			qcom,opp-oloop-vadj = <0 (-28000)>;
+		};
+
+		cprh_opp27: opp-27 {
+			opp-level = <27>;
+			qcom,opp-fuse-level = <4>;
+			qcom,opp-cloop-vadj = <0 (-27000)>;
+			qcom,opp-oloop-vadj = <0 (-28000)>;
+		};
+
+		cprh_opp28: opp-28 {
+			opp-level = <28>;
+			qcom,opp-fuse-level = <4>;
+			qcom,opp-cloop-vadj = <0 (-28000)>;
+			qcom,opp-oloop-vadj = <0 (-28000)>;
+		};
+
+		cprh_opp29: opp-29 {
+			opp-level = <29>;
+			qcom,opp-fuse-level = <4>;
+			qcom,opp-cloop-vadj = <0 (-28000)>;
+			qcom,opp-oloop-vadj = <0 (-28000)>;
+		};
+
+		cprh_opp30: opp-30 {
+			opp-level = <30>;
+			qcom,opp-fuse-level = <4>;
+			qcom,opp-cloop-vadj = <0 (-28000)>;
+			qcom,opp-oloop-vadj = <0 (-28000)>;
+		};
+	};
+
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			required-opps = <&cprh_opp22>;
+			qcom,pll-override = <0x094f004f>;
+			qcom,spare-data = <3>;
+		};
+
+		opp-1824000000 {
+			opp-hz = /bits/ 64 <1824000000>;
+			required-opps = <&cprh_opp21>;
+			qcom,pll-override = <0x084c004c>;
+			qcom,spare-data = <3>;
+		};
+
+		opp-1747200000 {
+			opp-hz = /bits/ 64 <1747200000>;
+			required-opps = <&cprh_opp20>;
+			qcom,pll-override = <0x08490049>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1670400000 {
+			opp-hz = /bits/ 64 <1670400000>;
+			required-opps = <&cprh_opp19>;
+			qcom,pll-override = <0x08460046>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1555200000 {
+			opp-hz = /bits/ 64 <1555200000>;
+			required-opps = <&cprh_opp18>;
+			qcom,pll-override = <0x07410041>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1478400000 {
+			opp-hz = /bits/ 64 <1478400000>;
+			required-opps = <&cprh_opp17>;
+			qcom,pll-override = <0x073e003e>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			required-opps = <&cprh_opp16>;
+			qcom,pll-override = <0x063a003a>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			required-opps = <&cprh_opp15>;
+			qcom,pll-override = <0x06370037>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			required-opps = <&cprh_opp14>;
+			qcom,pll-override = <0x05340034>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1171200000 {
+			opp-hz = /bits/ 64 <1171200000>;
+			required-opps = <&cprh_opp13>;
+			qcom,pll-override = <0x05310031>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+			required-opps = <&cprh_opp12>;
+			qcom,pll-override = <0x052e002e>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			required-opps = <&cprh_opp11>;
+			qcom,pll-override = <0x042b002b>;
+			qcom,spare-data = <1>;
+		};
+
+		opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			required-opps = <&cprh_opp10>;
+			qcom,pll-override = <0x4280028>;
+			qcom,spare-data = <1>;
+		};
+
+		opp-883200000 {
+			opp-hz = /bits/ 64 <883200000>;
+			required-opps = <&cprh_opp9>;
+			qcom,pll-override = <0x4250025>;
+			qcom,spare-data = <1>;
+		};
+
+		opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			required-opps = <&cprh_opp8>;
+			qcom,pll-override = <0x3200022>;
+			qcom,spare-data = <1>;
+		};
+
+		opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+			required-opps = <&cprh_opp7>;
+			qcom,pll-override = <0x3200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-672000000 {
+			opp-hz = /bits/ 64 <672000000>;
+			required-opps = <&cprh_opp6>;
+			qcom,pll-override = <0x3200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-595200000 {
+			opp-hz = /bits/ 64 <595200000>;
+			required-opps = <&cprh_opp5>;
+			qcom,pll-override = <0x2200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-518400000 {
+			opp-hz = /bits/ 64 <518400000>;
+			required-opps = <&cprh_opp4>;
+			qcom,pll-override = <0x2200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-441600000 {
+			opp-hz = /bits/ 64 <441600000>;
+			required-opps = <&cprh_opp3>;
+			qcom,pll-override = <0x2200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-364800000 {
+			opp-hz = /bits/ 64 <364800000>;
+			required-opps = <&cprh_opp2>;
+			qcom,pll-override = <0x1200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			required-opps = <&cprh_opp1>;
+			qcom,pll-override = <0x1200020>;
+		};
+	};
+
+	cpu4_opp_table: opp-table-cpu4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-2361600000 {
+			opp-hz = /bits/ 64 <2361600000>;
+			required-opps = <&cprh_opp30>;
+			qcom,pll-override = <0x0a620062>;
+			qcom,spare-data = <3>;
+		};
+
+		opp-2342400000 {
+			opp-hz = /bits/ 64 <2342400000>;
+			required-opps = <&cprh_opp29>;
+			qcom,pll-override = <0x0a620062>;
+			qcom,spare-data = <3>;
+		};
+
+		opp-2323200000 {
+			opp-hz = /bits/ 64 <2323200000>;
+			required-opps = <&cprh_opp28>;
+			qcom,pll-override = <0x0a610061>;
+			qcom,spare-data = <3>;
+		};
+
+		opp-2265600000 {
+			opp-hz = /bits/ 64 <2265600000>;
+			required-opps = <&cprh_opp27>;
+			qcom,pll-override = <0x0a5e005e>;
+			qcom,spare-data = <3>;
+		};
+
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			required-opps = <&cprh_opp26>;
+			qcom,pll-override = <0x0a5c005c>;
+			qcom,spare-data = <3>;
+		};
+
+		opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			required-opps = <&cprh_opp25>;
+			qcom,pll-override = <0x0a580058>;
+			qcom,spare-data = <3>;
+		};
+
+		opp-2035200000 {
+			opp-hz = /bits/ 64 <2035200000>;
+			required-opps = <&cprh_opp24>;
+			qcom,pll-override = <0x09550055>;
+			qcom,spare-data = <3>;
+		};
+
+		opp-1958400000 {
+			opp-hz = /bits/ 64 <1958400000>;
+			required-opps = <&cprh_opp23>;
+			qcom,pll-override = <0x09520052>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1881600000 {
+			opp-hz = /bits/ 64 <1881600000>;
+			required-opps = <&cprh_opp22>;
+			qcom,pll-override = <0x094e004e>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			required-opps = <&cprh_opp21>;
+			qcom,pll-override = <0x084b004b>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1728000000 {
+			opp-hz = /bits/ 64 <1728000000>;
+			required-opps = <&cprh_opp20>;
+			qcom,pll-override = <0x08480048>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			required-opps = <&cprh_opp19>;
+			qcom,pll-override = <0x07450045>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1574400000 {
+			opp-hz = /bits/ 64 <1574400000>;
+			required-opps = <&cprh_opp18>;
+			qcom,pll-override = <0x07420042>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			required-opps = <&cprh_opp17>;
+			qcom,pll-override = <0x073e003e>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
+			required-opps = <&cprh_opp16>;
+			qcom,pll-override = <0x063b003b>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			required-opps = <&cprh_opp15>;
+			qcom,pll-override = <0x06380038>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			required-opps = <&cprh_opp14>;
+			qcom,pll-override = <0x06350035>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			required-opps = <&cprh_opp13>;
+			qcom,pll-override = <0x05320032>;
+			qcom,spare-data = <2>;
+		};
+
+		opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			required-opps = <&cprh_opp12>;
+			qcom,pll-override = <0x052f002f>;
+			qcom,spare-data = <1>;
+		};
+
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			required-opps = <&cprh_opp11>;
+			qcom,pll-override = <0x052c002c>;
+			qcom,spare-data = <1>;
+		};
+
+		opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			required-opps = <&cprh_opp10>;
+			qcom,pll-override = <0x4290029>;
+			qcom,spare-data = <1>;
+		};
+
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			required-opps = <&cprh_opp9>;
+			qcom,pll-override = <0x4260026>;
+			qcom,spare-data = <1>;
+		};
+
+		opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			required-opps = <&cprh_opp8>;
+			qcom,pll-override = <0x3200022>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			required-opps = <&cprh_opp7>;
+			qcom,pll-override = <0x3200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			required-opps = <&cprh_opp6>;
+			qcom,pll-override = <0x3200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			required-opps = <&cprh_opp5>;
+			qcom,pll-override = <0x2200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-499200000 {
+			opp-hz = /bits/ 64 <499200000>;
+			required-opps = <&cprh_opp4>;
+			qcom,pll-override = <0x2200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-422400000 {
+			opp-hz = /bits/ 64 <422400000>;
+			required-opps = <&cprh_opp3>;
+			qcom,pll-override = <0x2200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-345600000 {
+			opp-hz = /bits/ 64 <345600000>;
+			required-opps = <&cprh_opp2>;
+			qcom,pll-override = <0x1200020>;
+			qcom,spare-data = <1>;
+			qcom,pll-div = <1>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			required-opps = <&cprh_opp1>;
+			qcom,pll-override = <0x1200020>;
+			qcom,spare-data = <1>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -839,6 +1463,174 @@ qfprom: qfprom@784000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			cpr_efuse_speedbin: speedbin@133 {
+				reg = <0x133 0x8>;
+				bits = <5 3>;
+			};
+
+			cpr_fuse_revision: cpr_fusing_rev@13e {
+				reg = <0x13e 0x1>;
+				bits = <3 3>;
+			};
+
+			/* CPR Ring Oscillator: Power Cluster */
+			cpr_ro_sel3_pwrcl: rosel3_pwrcl@218 {
+				reg = <0x218 0x1>;
+				bits = <0 4>;
+			};
+
+			cpr_ro_sel2_pwrcl: rosel2_pwrcl@218 {
+				reg = <0x218 0x1>;
+				bits = <4 4>;
+			};
+
+			cpr_ro_sel1_pwrcl: rosel1_pwrcl@219 {
+				reg = <0x219 0x1>;
+				bits = <0 4>;
+			};
+
+			cpr_ro_sel0_pwrcl: rosel0_pwrcl@219 {
+				reg = <0x219 0x1>;
+				bits = <4 4>;
+			};
+
+			/* CPR Init Voltage: Power Cluster */
+			cpr_init_voltage3_pwrcl: ivolt3_pwrcl@21a {
+				reg = <0x21a 0x1>;
+				bits = <0 6>;
+			};
+
+			cpr_init_voltage2_pwrcl: ivolt2_pwrcl@21a {
+				reg = <0x21a 0x1>;
+				bits = <6 6>;
+			};
+
+			cpr_init_voltage1_pwrcl: ivolt1_pwrcl@21b {
+				reg = <0x21b 0x1>;
+				bits = <4 6>;
+			};
+
+			cpr_init_voltage0_pwrcl: ivolt0_pwrcl@21c {
+				reg = <0x21c 0x1>;
+				bits = <2 6>;
+			};
+
+			/* CPR Target Quotients: Power Cluster */
+			cpr_quot3_pwrcl: quot3_pwrcl@21d {
+				reg = <0x21d 0x2>;
+				bits = <6 12>;
+			};
+
+			cpr_quot2_pwrcl: quot2_pwrcl@21f {
+				reg = <0x21f 0x2>;
+				bits = <2 11>;
+			};
+
+			cpr_quot1_pwrcl: quot1_pwrcl@220 {
+				reg = <0x220 0x2>;
+				bits = <6 12>;
+			};
+
+			cpr_quot0_pwrcl: quot0_pwrcl@222 {
+				reg = <0x222 0x2>;
+				bits = <2 12>;
+			};
+
+			/* CPR Quotient Offsets: Power Cluster */
+			cpr_quot_offset3_pwrcl: qoff3_pwrcl@226 {
+				reg = <0x226 0x1>;
+				bits = <1 7>;
+			};
+
+			cpr_quot_offset2_pwrcl: qoff2_pwrcl@227 {
+				reg = <0x227 0x1>;
+				bits = <0 7>;
+			};
+
+			cpr_quot_offset1_pwrcl: qoff1_pwrcl@227 {
+				reg = <0x227 0x1>;
+				bits = <7 6>;
+			};
+
+			/* CPR Ring Oscillator: Performance Cluster */
+			cpr_ro_sel3_perfcl: rosel3_perfcl@229 {
+				reg = <0x229 0x1>;
+				bits = <6 4>;
+			};
+
+			cpr_ro_sel2_perfcl: rosel2_perfcl@22a {
+				reg = <0x22a 0x1>;
+				bits = <2 4>;
+			};
+
+			cpr_ro_sel1_perfcl: rosel1_perfcl@22a {
+				reg = <0x22a 0x1>;
+				bits = <6 4>;
+			};
+
+			cpr_ro_sel0_perfcl: rosel0_perfcl@22b {
+				reg = <0x22b 0x1>;
+				bits = <2 4>;
+			};
+
+			/* CPR Init Voltage: Performance Cluster */
+			cpr_init_voltage3_perfcl: ivolt3_perfcl@22b {
+				reg = <0x22b 0x1>;
+				bits = <6 6>;
+			};
+
+			cpr_init_voltage2_perfcl: ivolt2_perfcl@22c {
+				reg = <0x22c 0x1>;
+				bits = <4 6>;
+			};
+
+			cpr_init_voltage1_perfcl: ivolt1_perfcl@22d {
+				reg = <0x22d 0x1>;
+				bits = <2 6>;
+			};
+
+			cpr_init_voltage0_perfcl: ivolt0_perfcl@22e {
+				reg = <0x22e 0x1>;
+				bits = <0 6>;
+			};
+
+			/* CPR Target Quotients: Performance Cluster */
+			cpr_quot3_perfcl: quot3_perfcl@22f {
+				reg = <0x22f 0x2>;
+				bits = <4 11>;
+			};
+
+			cpr_quot2_perfcl: quot2_perfcl@231 {
+				reg = <0x231 0x2>;
+				bits = <0 12>;
+			};
+
+			cpr_quot1_perfcl: quot1_perfcl@232 {
+				reg = <0x232 0x2>;
+				bits = <4 12>;
+			};
+
+			cpr_quot0_perfcl: quot0_perfcl@234 {
+				reg = <0x234 0x2>;
+				bits = <0 12>;
+			};
+
+			/* CPR Quotient Offsets: Performance Cluster */
+			cpr_quot_offset3_perfcl: qoff3_perfcl@237 {
+				reg = <0x237 0x1>;
+				bits = <7 6>;
+			};
+
+			cpr_quot_offset2_perfcl: qoff2_perfcl@238 {
+				reg = <0x238 0x1>;
+				bits = <6 7>;
+			};
+
+			cpr_quot_offset1_perfcl: qoff1_perfcl@239 {
+				reg = <0x239 0x1>;
+				bits = <5 3>;
+			};
+
 			qusb2_hstx_trim: hstx-trim@23a {
 				reg = <0x23a 0x1>;
 				bits = <0 4>;
@@ -2998,6 +3790,87 @@ frame@17928000 {
 			};
 		};
 
+		apc_cprh: power-controller@179c8000 {
+			compatible = "qcom,msm8998-cprh", "qcom,cprh";
+			reg = <0x179c8000 0x4000>, <0x179c4000 0x4000>;
+
+			clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
+			clock-names = "ref";
+
+			/* Set the CPR clock here, it needs to match XO */
+			assigned-clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			operating-points-v2 = <&cprh_opp_table>;
+			power-domains = <&rpmpd MSM8998_VDDCX_AO>;
+			#power-domain-cells = <1>;
+
+			nvmem-cells = <&cpr_efuse_speedbin>,
+				      <&cpr_fuse_revision>,
+				      <&cpr_quot0_pwrcl>,
+				      <&cpr_quot1_pwrcl>,
+				      <&cpr_quot2_pwrcl>,
+				      <&cpr_quot3_pwrcl>,
+				      <&cpr_quot_offset1_pwrcl>,
+				      <&cpr_quot_offset2_pwrcl>,
+				      <&cpr_quot_offset3_pwrcl>,
+				      <&cpr_init_voltage0_pwrcl>,
+				      <&cpr_init_voltage1_pwrcl>,
+				      <&cpr_init_voltage2_pwrcl>,
+				      <&cpr_init_voltage3_pwrcl>,
+				      <&cpr_ro_sel0_pwrcl>,
+				      <&cpr_ro_sel1_pwrcl>,
+				      <&cpr_ro_sel2_pwrcl>,
+				      <&cpr_ro_sel3_pwrcl>,
+				      <&cpr_quot0_perfcl>,
+				      <&cpr_quot1_perfcl>,
+				      <&cpr_quot2_perfcl>,
+				      <&cpr_quot3_perfcl>,
+				      <&cpr_quot_offset1_perfcl>,
+				      <&cpr_quot_offset2_perfcl>,
+				      <&cpr_quot_offset3_perfcl>,
+				      <&cpr_init_voltage0_perfcl>,
+				      <&cpr_init_voltage1_perfcl>,
+				      <&cpr_init_voltage2_perfcl>,
+				      <&cpr_init_voltage3_perfcl>,
+				      <&cpr_ro_sel0_perfcl>,
+				      <&cpr_ro_sel1_perfcl>,
+				      <&cpr_ro_sel2_perfcl>,
+				      <&cpr_ro_sel3_perfcl>;
+			nvmem-cell-names = "cpr_speed_bin",
+					   "cpr_fuse_revision",
+					   "cpr0_quotient1",
+					   "cpr0_quotient2",
+					   "cpr0_quotient3",
+					   "cpr0_quotient4",
+					   "cpr0_quotient_offset2",
+					   "cpr0_quotient_offset3",
+					   "cpr0_quotient_offset4",
+					   "cpr0_init_voltage1",
+					   "cpr0_init_voltage2",
+					   "cpr0_init_voltage3",
+					   "cpr0_init_voltage4",
+					   "cpr0_ring_osc1",
+					   "cpr0_ring_osc2",
+					   "cpr0_ring_osc3",
+					   "cpr0_ring_osc4",
+					   "cpr1_quotient1",
+					   "cpr1_quotient2",
+					   "cpr1_quotient3",
+					   "cpr1_quotient4",
+					   "cpr1_quotient_offset2",
+					   "cpr1_quotient_offset3",
+					   "cpr1_quotient_offset4",
+					   "cpr1_init_voltage1",
+					   "cpr1_init_voltage2",
+					   "cpr1_init_voltage3",
+					   "cpr1_init_voltage4",
+					   "cpr1_ring_osc1",
+					   "cpr1_ring_osc2",
+					   "cpr1_ring_osc3",
+					   "cpr1_ring_osc4";
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			reg = <0x17a00000 0x10000>,       /* GICD */
-- 
2.39.0

