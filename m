Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955AB64A200
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiLLNsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiLLNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:47:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B3E231
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:47:37 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c1so18662231lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NQF7pjiTnNNFymipgs9V+yZ6tQ/uznOPcvWdZcLONmk=;
        b=ikEAprxQOUzlbYQ90huCEmPM3QGV8raOt/nbeL97MLlnf++cSRyKE2O4jGdCB64hBj
         Wcqhv4d1pZ2mCN1w8MNEDKmT4zE+dLriEIqKesnHh6MnJz92FKRbb5QDe17tuZ9+F5uH
         JOJMW02RC8pX3QTbzc82xqUUbBk0FPjFzAIXCPM1N4DsFdqyQe65UmR100q+haIapB9u
         31izm8T7yOQ/+FLG7Fj+7F57eZ2o4rhMRzgCLdadZZVbjmrUuXF4qKxeGplWDOIEd1/O
         fHOJ3zGCv+XgTy7ogSSZplGUOtH//a1OiyWGN72DfoxJhT9Fa2ywyWqRv1tGpatk+rGq
         /dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQF7pjiTnNNFymipgs9V+yZ6tQ/uznOPcvWdZcLONmk=;
        b=dInTlsoDKAKyplEbO0xcj+fri7uEATr+u/FNFUTxcMjKrmygsA5pcsBlfJE9iccjme
         pjE87Ke5KKQMlAs5U/5IIKXsw+kaXJffIkLkMlQynLzzaZv0ROWU4yRDWM7yDKFvFGsV
         nLgHdHwpEowZU/w6cOuqpOYlz5/cmUQZOwf/pNMJDRpGPuULetQB0vKlEJ7CsZaQAqYu
         eHLGOOSXoiW4KwQuOxdYTRI2Leb96tigBNO+Aa4FCkG+LZLQL1p+6QLD0Fx5kXP59TLo
         5GqcdxUTDoGtCIHG6f5kSOK4LZ+jmTDgnw8XXKFU0qKx9Rq2BhSkumXxi46MPaHeVNjV
         1hcA==
X-Gm-Message-State: ANoB5pk3LlFAbMZhO+DxVzqivrOW31KU6cfGsE03QAUiQzrZcnh0kDH1
        3RMGko2LYj3tBECg3E91N1p2Lw==
X-Google-Smtp-Source: AA0mqf4rlJgD4VhI00+NHK2rN9eP0jPIVm2NT/3o7iJJBf+bNIVqZqdXWP9u6iXoy4XL17f4Oq4AEQ==
X-Received: by 2002:a05:6512:3e17:b0:4a4:7be4:9baf with SMTP id i23-20020a0565123e1700b004a47be49bafmr5946554lfv.59.1670852855444;
        Mon, 12 Dec 2022 05:47:35 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id x23-20020ac24897000000b004b4e67c3c00sm1621660lfc.53.2022.12.12.05.47.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:47:35 -0800 (PST)
Date:   Mon, 12 Dec 2022 16:47:31 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/6=5D_arm64=3A_dts=3A_qcom=3A_sdm?= =?US-ASCII?Q?845=3A_order_top-level_nodes_alphabetically?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221212100232.138519-2-krzysztof.kozlowski@linaro.org>
References: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org> <20221212100232.138519-2-krzysztof.kozlowski@linaro.org>
Message-ID: <E5855ED0-53E5-4A14-A3F3-29840C6C64AA@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 December 2022 13:02:28 GMT+03:00, Krzysztof Kozlowski <krzysztof=2Ek=
ozlowski@linaro=2Eorg> wrote:
>Order top-level nodes like memory, reserved-memory, opp-table-cpu
>alphabetically for easier code maintenance=2E  No functional change (same
>dtx_diff, except phandle changes)=2E
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof=2Ekozlowski@linaro=2Eorg>

Reviewed-by: Dmitry Baryshkov<dmitry=2Ebaryshkov@linaro=2Eorg>


>
>---
>
>Changes since v1:
>1=2E New patch
>---
> arch/arm64/boot/dts/qcom/sdm845=2Edtsi | 384 +++++++++++++--------------
> 1 file changed, 192 insertions(+), 192 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/qcom/sdm845=2Edtsi b/arch/arm64/boot/dts=
/qcom/sdm845=2Edtsi
>index a63dbd12230f=2E=2E88e7d4061aae 100644
>--- a/arch/arm64/boot/dts/qcom/sdm845=2Edtsi
>+++ b/arch/arm64/boot/dts/qcom/sdm845=2Edtsi
>@@ -69,122 +69,18 @@ aliases {
>=20
> 	chosen { };
>=20
>-	memory@80000000 {
>-		device_type =3D "memory";
>-		/* We expect the bootloader to fill in the size */
>-		reg =3D <0 0x80000000 0 0>;
>-	};
>-
>-	reserved-memory {
>-		#address-cells =3D <2>;
>-		#size-cells =3D <2>;
>-		ranges;
>-
>-		hyp_mem: hyp-mem@85700000 {
>-			reg =3D <0 0x85700000 0 0x600000>;
>-			no-map;
>-		};
>-
>-		xbl_mem: xbl-mem@85e00000 {
>-			reg =3D <0 0x85e00000 0 0x100000>;
>-			no-map;
>-		};
>-
>-		aop_mem: aop-mem@85fc0000 {
>-			reg =3D <0 0x85fc0000 0 0x20000>;
>-			no-map;
>-		};
>-
>-		aop_cmd_db_mem: aop-cmd-db-mem@85fe0000 {
>-			compatible =3D "qcom,cmd-db";
>-			reg =3D <0x0 0x85fe0000 0 0x20000>;
>-			no-map;
>-		};
>-
>-		smem@86000000 {
>-			compatible =3D "qcom,smem";
>-			reg =3D <0x0 0x86000000 0 0x200000>;
>-			no-map;
>-			hwlocks =3D <&tcsr_mutex 3>;
>-		};
>-
>-		tz_mem: tz@86200000 {
>-			reg =3D <0 0x86200000 0 0x2d00000>;
>-			no-map;
>-		};
>-
>-		rmtfs_mem: rmtfs@88f00000 {
>-			compatible =3D "qcom,rmtfs-mem";
>-			reg =3D <0 0x88f00000 0 0x200000>;
>-			no-map;
>-
>-			qcom,client-id =3D <1>;
>-			qcom,vmid =3D <15>;
>-		};
>-
>-		qseecom_mem: qseecom@8ab00000 {
>-			reg =3D <0 0x8ab00000 0 0x1400000>;
>-			no-map;
>-		};
>-
>-		camera_mem: camera-mem@8bf00000 {
>-			reg =3D <0 0x8bf00000 0 0x500000>;
>-			no-map;
>-		};
>-
>-		ipa_fw_mem: ipa-fw@8c400000 {
>-			reg =3D <0 0x8c400000 0 0x10000>;
>-			no-map;
>-		};
>-
>-		ipa_gsi_mem: ipa-gsi@8c410000 {
>-			reg =3D <0 0x8c410000 0 0x5000>;
>-			no-map;
>-		};
>-
>-		gpu_mem: gpu@8c415000 {
>-			reg =3D <0 0x8c415000 0 0x2000>;
>-			no-map;
>-		};
>-
>-		adsp_mem: adsp@8c500000 {
>-			reg =3D <0 0x8c500000 0 0x1a00000>;
>-			no-map;
>-		};
>-
>-		wlan_msa_mem: wlan-msa@8df00000 {
>-			reg =3D <0 0x8df00000 0 0x100000>;
>-			no-map;
>-		};
>-
>-		mpss_region: mpss@8e000000 {
>-			reg =3D <0 0x8e000000 0 0x7800000>;
>-			no-map;
>-		};
>-
>-		venus_mem: venus@95800000 {
>-			reg =3D <0 0x95800000 0 0x500000>;
>-			no-map;
>-		};
>-
>-		cdsp_mem: cdsp@95d00000 {
>-			reg =3D <0 0x95d00000 0 0x800000>;
>-			no-map;
>-		};
>-
>-		mba_region: mba@96500000 {
>-			reg =3D <0 0x96500000 0 0x200000>;
>-			no-map;
>-		};
>-
>-		slpi_mem: slpi@96700000 {
>-			reg =3D <0 0x96700000 0 0x1400000>;
>-			no-map;
>+	clocks {
>+		xo_board: xo-board {
>+			compatible =3D "fixed-clock";
>+			#clock-cells =3D <0>;
>+			clock-frequency =3D <38400000>;
>+			clock-output-names =3D "xo_board";
> 		};
>=20
>-		spss_mem: spss@97b00000 {
>-			reg =3D <0 0x97b00000 0 0x100000>;
>-			no-map;
>+		sleep_clk: sleep-clk {
>+			compatible =3D "fixed-clock";
>+			#clock-cells =3D <0>;
>+			clock-frequency =3D <32764>;
> 		};
> 	};
>=20
>@@ -436,6 +332,18 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
> 		};
> 	};
>=20
>+	firmware {
>+		scm {
>+			compatible =3D "qcom,scm-sdm845", "qcom,scm";
>+		};
>+	};
>+
>+	memory@80000000 {
>+		device_type =3D "memory";
>+		/* We expect the bootloader to fill in the size */
>+		reg =3D <0 0x80000000 0 0>;
>+	};
>+
> 	cpu0_opp_table: opp-table-cpu0 {
> 		compatible =3D "operating-points-v2";
> 		opp-shared;
>@@ -701,32 +609,174 @@ pmu {
> 		interrupts =3D <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> 	};
>=20
>-	timer {
>-		compatible =3D "arm,armv8-timer";
>-		interrupts =3D <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
>-			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
>-			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
>-			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
>-	};
>+	psci: psci {
>+		compatible =3D "arm,psci-1=2E0";
>+		method =3D "smc";
>=20
>-	clocks {
>-		xo_board: xo-board {
>-			compatible =3D "fixed-clock";
>-			#clock-cells =3D <0>;
>-			clock-frequency =3D <38400000>;
>-			clock-output-names =3D "xo_board";
>+		CPU_PD0: power-domain-cpu0 {
>+			#power-domain-cells =3D <0>;
>+			power-domains =3D <&CLUSTER_PD>;
>+			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
> 		};
>=20
>-		sleep_clk: sleep-clk {
>-			compatible =3D "fixed-clock";
>-			#clock-cells =3D <0>;
>-			clock-frequency =3D <32764>;
>+		CPU_PD1: power-domain-cpu1 {
>+			#power-domain-cells =3D <0>;
>+			power-domains =3D <&CLUSTER_PD>;
>+			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
>+		};
>+
>+		CPU_PD2: power-domain-cpu2 {
>+			#power-domain-cells =3D <0>;
>+			power-domains =3D <&CLUSTER_PD>;
>+			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
>+		};
>+
>+		CPU_PD3: power-domain-cpu3 {
>+			#power-domain-cells =3D <0>;
>+			power-domains =3D <&CLUSTER_PD>;
>+			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
>+		};
>+
>+		CPU_PD4: power-domain-cpu4 {
>+			#power-domain-cells =3D <0>;
>+			power-domains =3D <&CLUSTER_PD>;
>+			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
>+		};
>+
>+		CPU_PD5: power-domain-cpu5 {
>+			#power-domain-cells =3D <0>;
>+			power-domains =3D <&CLUSTER_PD>;
>+			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
>+		};
>+
>+		CPU_PD6: power-domain-cpu6 {
>+			#power-domain-cells =3D <0>;
>+			power-domains =3D <&CLUSTER_PD>;
>+			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
>+		};
>+
>+		CPU_PD7: power-domain-cpu7 {
>+			#power-domain-cells =3D <0>;
>+			power-domains =3D <&CLUSTER_PD>;
>+			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
>+		};
>+
>+		CLUSTER_PD: power-domain-cluster {
>+			#power-domain-cells =3D <0>;
>+			domain-idle-states =3D <&CLUSTER_SLEEP_0>;
> 		};
> 	};
>=20
>-	firmware {
>-		scm {
>-			compatible =3D "qcom,scm-sdm845", "qcom,scm";
>+	reserved-memory {
>+		#address-cells =3D <2>;
>+		#size-cells =3D <2>;
>+		ranges;
>+
>+		hyp_mem: hyp-mem@85700000 {
>+			reg =3D <0 0x85700000 0 0x600000>;
>+			no-map;
>+		};
>+
>+		xbl_mem: xbl-mem@85e00000 {
>+			reg =3D <0 0x85e00000 0 0x100000>;
>+			no-map;
>+		};
>+
>+		aop_mem: aop-mem@85fc0000 {
>+			reg =3D <0 0x85fc0000 0 0x20000>;
>+			no-map;
>+		};
>+
>+		aop_cmd_db_mem: aop-cmd-db-mem@85fe0000 {
>+			compatible =3D "qcom,cmd-db";
>+			reg =3D <0x0 0x85fe0000 0 0x20000>;
>+			no-map;
>+		};
>+
>+		smem@86000000 {
>+			compatible =3D "qcom,smem";
>+			reg =3D <0x0 0x86000000 0 0x200000>;
>+			no-map;
>+			hwlocks =3D <&tcsr_mutex 3>;
>+		};
>+
>+		tz_mem: tz@86200000 {
>+			reg =3D <0 0x86200000 0 0x2d00000>;
>+			no-map;
>+		};
>+
>+		rmtfs_mem: rmtfs@88f00000 {
>+			compatible =3D "qcom,rmtfs-mem";
>+			reg =3D <0 0x88f00000 0 0x200000>;
>+			no-map;
>+
>+			qcom,client-id =3D <1>;
>+			qcom,vmid =3D <15>;
>+		};
>+
>+		qseecom_mem: qseecom@8ab00000 {
>+			reg =3D <0 0x8ab00000 0 0x1400000>;
>+			no-map;
>+		};
>+
>+		camera_mem: camera-mem@8bf00000 {
>+			reg =3D <0 0x8bf00000 0 0x500000>;
>+			no-map;
>+		};
>+
>+		ipa_fw_mem: ipa-fw@8c400000 {
>+			reg =3D <0 0x8c400000 0 0x10000>;
>+			no-map;
>+		};
>+
>+		ipa_gsi_mem: ipa-gsi@8c410000 {
>+			reg =3D <0 0x8c410000 0 0x5000>;
>+			no-map;
>+		};
>+
>+		gpu_mem: gpu@8c415000 {
>+			reg =3D <0 0x8c415000 0 0x2000>;
>+			no-map;
>+		};
>+
>+		adsp_mem: adsp@8c500000 {
>+			reg =3D <0 0x8c500000 0 0x1a00000>;
>+			no-map;
>+		};
>+
>+		wlan_msa_mem: wlan-msa@8df00000 {
>+			reg =3D <0 0x8df00000 0 0x100000>;
>+			no-map;
>+		};
>+
>+		mpss_region: mpss@8e000000 {
>+			reg =3D <0 0x8e000000 0 0x7800000>;
>+			no-map;
>+		};
>+
>+		venus_mem: venus@95800000 {
>+			reg =3D <0 0x95800000 0 0x500000>;
>+			no-map;
>+		};
>+
>+		cdsp_mem: cdsp@95d00000 {
>+			reg =3D <0 0x95d00000 0 0x800000>;
>+			no-map;
>+		};
>+
>+		mba_region: mba@96500000 {
>+			reg =3D <0 0x96500000 0 0x200000>;
>+			no-map;
>+		};
>+
>+		slpi_mem: slpi@96700000 {
>+			reg =3D <0 0x96700000 0 0x1400000>;
>+			no-map;
>+		};
>+
>+		spss_mem: spss@97b00000 {
>+			reg =3D <0 0x97b00000 0 0x100000>;
>+			no-map;
> 		};
> 	};
>=20
>@@ -1018,64 +1068,6 @@ slpi_smp2p_in: slave-kernel {
> 		};
> 	};
>=20
>-	psci: psci {
>-		compatible =3D "arm,psci-1=2E0";
>-		method =3D "smc";
>-
>-		CPU_PD0: power-domain-cpu0 {
>-			#power-domain-cells =3D <0>;
>-			power-domains =3D <&CLUSTER_PD>;
>-			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
>-		};
>-
>-		CPU_PD1: power-domain-cpu1 {
>-			#power-domain-cells =3D <0>;
>-			power-domains =3D <&CLUSTER_PD>;
>-			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
>-		};
>-
>-		CPU_PD2: power-domain-cpu2 {
>-			#power-domain-cells =3D <0>;
>-			power-domains =3D <&CLUSTER_PD>;
>-			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
>-		};
>-
>-		CPU_PD3: power-domain-cpu3 {
>-			#power-domain-cells =3D <0>;
>-			power-domains =3D <&CLUSTER_PD>;
>-			domain-idle-states =3D <&LITTLE_CPU_SLEEP_0>;
>-		};
>-
>-		CPU_PD4: power-domain-cpu4 {
>-			#power-domain-cells =3D <0>;
>-			power-domains =3D <&CLUSTER_PD>;
>-			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
>-		};
>-
>-		CPU_PD5: power-domain-cpu5 {
>-			#power-domain-cells =3D <0>;
>-			power-domains =3D <&CLUSTER_PD>;
>-			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
>-		};
>-
>-		CPU_PD6: power-domain-cpu6 {
>-			#power-domain-cells =3D <0>;
>-			power-domains =3D <&CLUSTER_PD>;
>-			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
>-		};
>-
>-		CPU_PD7: power-domain-cpu7 {
>-			#power-domain-cells =3D <0>;
>-			power-domains =3D <&CLUSTER_PD>;
>-			domain-idle-states =3D <&BIG_CPU_SLEEP_0>;
>-		};
>-
>-		CLUSTER_PD: power-domain-cluster {
>-			#power-domain-cells =3D <0>;
>-			domain-idle-states =3D <&CLUSTER_SLEEP_0>;
>-		};
>-	};
>-
> 	soc: soc@0 {
> 		#address-cells =3D <2>;
> 		#size-cells =3D <2>;
>@@ -5771,4 +5763,12 @@ modem_alert0: trip-point0 {
> 			};
> 		};
> 	};
>+
>+	timer {
>+		compatible =3D "arm,armv8-timer";
>+		interrupts =3D <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
>+			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
>+			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
>+			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
>+	};
> };

--=20
With best wishes
Dmitry
