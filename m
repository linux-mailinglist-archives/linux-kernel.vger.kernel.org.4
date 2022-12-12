Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECE7649B97
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiLLKDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiLLKCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:02:48 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70C42DC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:02:45 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id n1so11952533ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3vEjbU4OBSDOtUCM9Wt4KBN/qFz8DdboyKF7lJ0Y5bA=;
        b=AQZfai+wn5sBVMoXTo5P2/oNGdHPFWIDDOxs/DDGifb5xh4E6qFlNGvvpdTXeNbcro
         ohnAKOwNnLBSpbUyVnKdLXNwsntNWt35/sNpM8ytt8JscxeWZ4Br4p2A/9uYLihyl/FU
         h5qWA0YpM9HrFCFstOz/8lB+mMhUiKp63NKLVaRCbBpgrHG7J7Mvl8hjs5xMtrsY70KP
         /gjTrW3rGZvZSgOvvuiZ7aVwVTVhDKwYOcy2m2e5lwfU9hG8c+qbvyQRmuIfpZ9CzfJi
         eIzzyjfsmlMCNyGK+dR2wJ2WvLdNczeZDXtVJUod3PBeOpX5Ynv4n0AI7fuITFRLHwZo
         DtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vEjbU4OBSDOtUCM9Wt4KBN/qFz8DdboyKF7lJ0Y5bA=;
        b=vuQgaEtgUoUwaTjjfcCj4JeIuZB0NOJn/aoFsHfn1++3RPLRWey3D9uMukTslcq7Kt
         6XkpiPPyww89J7Ard9S327L2iRpSTqPEV9R8XAeoTm8oSmWIbseWvmJs5LAAXvHqVccv
         uO7knKsYO1FsgjO2Uh1dX5AKxNpLCF8QiHb5qf5cbvv7sV1Tp934kPX350efLZTgQXrN
         1iS2/v33pfhRqtv/kV76nc1aAe8lpcp7UJlKit3ihWZPy41HTQ5Mbi3Yt7LmFTG7Gp2E
         PPTycp9vbxB9j8lB7CZoXYnPBq1vq8CoFOynpVLzeRu0kNb2jZy7kZPGvAb/QXJuX+mE
         UPDQ==
X-Gm-Message-State: ANoB5pnvVwUi5u7oVz3j8K1QXm6zSdUs/OG2ANpeOfC1ckXW4C6amNsT
        ew1l6TN7p3JpZKdMwCPcBzBtdQ==
X-Google-Smtp-Source: AA0mqf66ulkIMS8nB+P3zSg1GOCpwZC8sb72bFEi+FWYCNNZ4PRqd59cX1A4sUI1Dmoif2oR3KIeYA==
X-Received: by 2002:a2e:a58e:0:b0:279:8e95:a3d with SMTP id m14-20020a2ea58e000000b002798e950a3dmr5093821ljp.13.1670839364154;
        Mon, 12 Dec 2022 02:02:44 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i124-20020a2e2282000000b0027712379ec8sm1145101lji.28.2022.12.12.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 02:02:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] arm64: dts: qcom: sc7180: order top-level nodes alphabetically
Date:   Mon, 12 Dec 2022 11:02:27 +0100
Message-Id: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Order top-level nodes like memory, reserved-memory, opp-table-cpu
alphabetically for easier code maintenance.  No functional change (same
dtx_diff).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 144 +++++++++++++--------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index ea886cf08b4d..6d3e86ce2936 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -27,8 +27,6 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	chosen { };
-
 	aliases {
 		mmc1 = &sdhc_1;
 		mmc2 = &sdhc_2;
@@ -54,6 +52,8 @@ aliases {
 		spi11 = &spi11;
 	};
 
+	chosen { };
+
 	clocks {
 		xo_board: xo-board {
 			compatible = "fixed-clock";
@@ -68,62 +68,6 @@ sleep_clk: sleep-clk {
 		};
 	};
 
-	reserved_memory: reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		hyp_mem: memory@80000000 {
-			reg = <0x0 0x80000000 0x0 0x600000>;
-			no-map;
-		};
-
-		xbl_mem: memory@80600000 {
-			reg = <0x0 0x80600000 0x0 0x200000>;
-			no-map;
-		};
-
-		aop_mem: memory@80800000 {
-			reg = <0x0 0x80800000 0x0 0x20000>;
-			no-map;
-		};
-
-		aop_cmd_db_mem: memory@80820000 {
-			reg = <0x0 0x80820000 0x0 0x20000>;
-			compatible = "qcom,cmd-db";
-			no-map;
-		};
-
-		sec_apps_mem: memory@808ff000 {
-			reg = <0x0 0x808ff000 0x0 0x1000>;
-			no-map;
-		};
-
-		smem_mem: memory@80900000 {
-			reg = <0x0 0x80900000 0x0 0x200000>;
-			no-map;
-		};
-
-		tz_mem: memory@80b00000 {
-			reg = <0x0 0x80b00000 0x0 0x3900000>;
-			no-map;
-		};
-
-		ipa_fw_mem: memory@8b700000 {
-			reg = <0 0x8b700000 0 0x10000>;
-			no-map;
-		};
-
-		rmtfs_mem: memory@94600000 {
-			compatible = "qcom,rmtfs-mem";
-			reg = <0x0 0x94600000 0x0 0x200000>;
-			no-map;
-
-			qcom,client-id = <1>;
-			qcom,vmid = <15>;
-		};
-	};
-
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -398,6 +342,18 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
 		};
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm-sc7180", "qcom,scm";
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0 0x80000000 0 0>;
+	};
+
 	cpu0_opp_table: opp-table-cpu0 {
 		compatible = "operating-points-v2";
 		opp-shared;
@@ -538,20 +494,69 @@ cpu6_opp16: opp-2553600000 {
 		};
 	};
 
-	memory@80000000 {
-		device_type = "memory";
-		/* We expect the bootloader to fill in the size */
-		reg = <0 0x80000000 0 0>;
-	};
-
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	firmware {
-		scm {
-			compatible = "qcom,scm-sc7180", "qcom,scm";
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: memory@80000000 {
+			reg = <0x0 0x80000000 0x0 0x600000>;
+			no-map;
+		};
+
+		xbl_mem: memory@80600000 {
+			reg = <0x0 0x80600000 0x0 0x200000>;
+			no-map;
+		};
+
+		aop_mem: memory@80800000 {
+			reg = <0x0 0x80800000 0x0 0x20000>;
+			no-map;
+		};
+
+		aop_cmd_db_mem: memory@80820000 {
+			reg = <0x0 0x80820000 0x0 0x20000>;
+			compatible = "qcom,cmd-db";
+			no-map;
+		};
+
+		sec_apps_mem: memory@808ff000 {
+			reg = <0x0 0x808ff000 0x0 0x1000>;
+			no-map;
+		};
+
+		smem_mem: memory@80900000 {
+			reg = <0x0 0x80900000 0x0 0x200000>;
+			no-map;
+		};
+
+		tz_mem: memory@80b00000 {
+			reg = <0x0 0x80b00000 0x0 0x3900000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@8b700000 {
+			reg = <0 0x8b700000 0 0x10000>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@94600000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0x94600000 0x0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
 		};
 	};
 
@@ -640,11 +645,6 @@ ipa_smp2p_in: ipa-modem-to-ap {
 		};
 	};
 
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
 	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.34.1

