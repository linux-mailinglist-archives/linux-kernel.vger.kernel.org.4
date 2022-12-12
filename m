Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF7764A1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiLLNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiLLNrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:47:17 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02802DE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:47:15 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id cf42so18690596lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fwa7UHeP4jWr8lw9HsvvYN2BPWxn5fGIfh6v2PbeSVw=;
        b=uGXb6zN5+CR+1yVrTz8KgytqXqqgC/zOKLH4rIJMHaAwhG0KidU1J5uCwMUt9cmjUQ
         /YHkYuM/C5+gsLwjfADnJZF4Xx5eADunA83FlWFbYU1pbisutKxWsQAO8Zu2KgG30OEI
         ECyzC6l4wlagv9bVrBOsBdWn2WzNeyVMNck2lEQDe1+AJIgJfd04isE+UmDb3HCN7xgb
         LOeiZpfBdADTX3y5S/O8tC1Uspf0m4iqrbUvSViohqp2NtSYbrnwxJNUo1QXWGtMeh/b
         46K4qFVHNQIBzqEA9e4eZkrGOYpWWjDWTttwJNVTtmToJA/3McFmNrCNVk+ipduQmJ97
         Xekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwa7UHeP4jWr8lw9HsvvYN2BPWxn5fGIfh6v2PbeSVw=;
        b=IuSGX4KKjyedZRCWykdOk0xu2v6rdU83DLsC8nfWHMwOSgRXWt6N2SxsggT7ZDKkYJ
         UTyo73pMlEef34A2foPvNr94XnRnMi81gr6DCpOaDZeY/HPwZGXa62Z0R35Xs0d6tkmN
         rCThKhtr/vbWXda7GN/9S0IdF2FSJPizHlrU9LmUPBIafeCERlePfnUeTJVBlaMmR8UQ
         CR6uLEhmAgW3YwOTLJE8n52GdGmuvC2h8VP4BM+zgwEFCChGU+Er2Y/AuQJb24Iv266f
         cycRJeejvF2aD7mRKntLLkec1JvfqrO0YcoiXkVbqbcB59t7NjEJs0bvlHHDpDw9dXtL
         a13g==
X-Gm-Message-State: ANoB5plIngKU5QqPhxZZ55jKnWJi7ufNKzJlW7UEXwm0ROczfCVub72n
        T5cvIvaIN9QOG0/CzRLXtlA8LEuUo/dxCL/wnl8=
X-Google-Smtp-Source: AA0mqf6S9ilREXYP4pJVvd2O0SwbUhO/LdlOqSxcoQLTs+D42tILpcbn5Ti8IubBFgBb79ELwQY5Xg==
X-Received: by 2002:ac2:52b9:0:b0:4b5:83ba:8c55 with SMTP id r25-20020ac252b9000000b004b583ba8c55mr4024394lfm.8.1670852834104;
        Mon, 12 Dec 2022 05:47:14 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id y20-20020a05651c021400b002797d6bb516sm1209659ljn.20.2022.12.12.05.47.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:47:13 -0800 (PST)
Date:   Mon, 12 Dec 2022 16:47:10 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/6=5D_arm64=3A_dts=3A_qcom=3A_sc7?= =?US-ASCII?Q?180=3A_order_top-level_nodes_alphabetically?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org>
References: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org>
Message-ID: <725A4567-0024-451A-99F1-30E6FED04E5B@linaro.org>
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



On 12 December 2022 13:02:27 GMT+03:00, Krzysztof Kozlowski <krzysztof=2Ek=
ozlowski@linaro=2Eorg> wrote:
>Order top-level nodes like memory, reserved-memory, opp-table-cpu
>alphabetically for easier code maintenance=2E  No functional change (same
>dtx_diff)=2E
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof=2Ekozlowski@linaro=2Eorg>

Reviewed-by: Dmitry Baryshkov<dmitry=2Ebaryshkov@linaro=2Eorg>

>
>---
>
>Changes since v1:
>1=2E New patch
>---
> arch/arm64/boot/dts/qcom/sc7180=2Edtsi | 144 +++++++++++++--------------
> 1 file changed, 72 insertions(+), 72 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/qcom/sc7180=2Edtsi b/arch/arm64/boot/dts=
/qcom/sc7180=2Edtsi
>index ea886cf08b4d=2E=2E6d3e86ce2936 100644
>--- a/arch/arm64/boot/dts/qcom/sc7180=2Edtsi
>+++ b/arch/arm64/boot/dts/qcom/sc7180=2Edtsi
>@@ -27,8 +27,6 @@ / {
> 	#address-cells =3D <2>;
> 	#size-cells =3D <2>;
>=20
>-	chosen { };
>-
> 	aliases {
> 		mmc1 =3D &sdhc_1;
> 		mmc2 =3D &sdhc_2;
>@@ -54,6 +52,8 @@ aliases {
> 		spi11 =3D &spi11;
> 	};
>=20
>+	chosen { };
>+
> 	clocks {
> 		xo_board: xo-board {
> 			compatible =3D "fixed-clock";
>@@ -68,62 +68,6 @@ sleep_clk: sleep-clk {
> 		};
> 	};
>=20
>-	reserved_memory: reserved-memory {
>-		#address-cells =3D <2>;
>-		#size-cells =3D <2>;
>-		ranges;
>-
>-		hyp_mem: memory@80000000 {
>-			reg =3D <0x0 0x80000000 0x0 0x600000>;
>-			no-map;
>-		};
>-
>-		xbl_mem: memory@80600000 {
>-			reg =3D <0x0 0x80600000 0x0 0x200000>;
>-			no-map;
>-		};
>-
>-		aop_mem: memory@80800000 {
>-			reg =3D <0x0 0x80800000 0x0 0x20000>;
>-			no-map;
>-		};
>-
>-		aop_cmd_db_mem: memory@80820000 {
>-			reg =3D <0x0 0x80820000 0x0 0x20000>;
>-			compatible =3D "qcom,cmd-db";
>-			no-map;
>-		};
>-
>-		sec_apps_mem: memory@808ff000 {
>-			reg =3D <0x0 0x808ff000 0x0 0x1000>;
>-			no-map;
>-		};
>-
>-		smem_mem: memory@80900000 {
>-			reg =3D <0x0 0x80900000 0x0 0x200000>;
>-			no-map;
>-		};
>-
>-		tz_mem: memory@80b00000 {
>-			reg =3D <0x0 0x80b00000 0x0 0x3900000>;
>-			no-map;
>-		};
>-
>-		ipa_fw_mem: memory@8b700000 {
>-			reg =3D <0 0x8b700000 0 0x10000>;
>-			no-map;
>-		};
>-
>-		rmtfs_mem: memory@94600000 {
>-			compatible =3D "qcom,rmtfs-mem";
>-			reg =3D <0x0 0x94600000 0x0 0x200000>;
>-			no-map;
>-
>-			qcom,client-id =3D <1>;
>-			qcom,vmid =3D <15>;
>-		};
>-	};
>-
> 	cpus {
> 		#address-cells =3D <2>;
> 		#size-cells =3D <0>;
>@@ -398,6 +342,18 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
> 		};
> 	};
>=20
>+	firmware {
>+		scm {
>+			compatible =3D "qcom,scm-sc7180", "qcom,scm";
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
>@@ -538,20 +494,69 @@ cpu6_opp16: opp-2553600000 {
> 		};
> 	};
>=20
>-	memory@80000000 {
>-		device_type =3D "memory";
>-		/* We expect the bootloader to fill in the size */
>-		reg =3D <0 0x80000000 0 0>;
>-	};
>-
> 	pmu {
> 		compatible =3D "arm,armv8-pmuv3";
> 		interrupts =3D <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> 	};
>=20
>-	firmware {
>-		scm {
>-			compatible =3D "qcom,scm-sc7180", "qcom,scm";
>+	psci {
>+		compatible =3D "arm,psci-1=2E0";
>+		method =3D "smc";
>+	};
>+
>+	reserved_memory: reserved-memory {
>+		#address-cells =3D <2>;
>+		#size-cells =3D <2>;
>+		ranges;
>+
>+		hyp_mem: memory@80000000 {
>+			reg =3D <0x0 0x80000000 0x0 0x600000>;
>+			no-map;
>+		};
>+
>+		xbl_mem: memory@80600000 {
>+			reg =3D <0x0 0x80600000 0x0 0x200000>;
>+			no-map;
>+		};
>+
>+		aop_mem: memory@80800000 {
>+			reg =3D <0x0 0x80800000 0x0 0x20000>;
>+			no-map;
>+		};
>+
>+		aop_cmd_db_mem: memory@80820000 {
>+			reg =3D <0x0 0x80820000 0x0 0x20000>;
>+			compatible =3D "qcom,cmd-db";
>+			no-map;
>+		};
>+
>+		sec_apps_mem: memory@808ff000 {
>+			reg =3D <0x0 0x808ff000 0x0 0x1000>;
>+			no-map;
>+		};
>+
>+		smem_mem: memory@80900000 {
>+			reg =3D <0x0 0x80900000 0x0 0x200000>;
>+			no-map;
>+		};
>+
>+		tz_mem: memory@80b00000 {
>+			reg =3D <0x0 0x80b00000 0x0 0x3900000>;
>+			no-map;
>+		};
>+
>+		ipa_fw_mem: memory@8b700000 {
>+			reg =3D <0 0x8b700000 0 0x10000>;
>+			no-map;
>+		};
>+
>+		rmtfs_mem: memory@94600000 {
>+			compatible =3D "qcom,rmtfs-mem";
>+			reg =3D <0x0 0x94600000 0x0 0x200000>;
>+			no-map;
>+
>+			qcom,client-id =3D <1>;
>+			qcom,vmid =3D <15>;
> 		};
> 	};
>=20
>@@ -640,11 +645,6 @@ ipa_smp2p_in: ipa-modem-to-ap {
> 		};
> 	};
>=20
>-	psci {
>-		compatible =3D "arm,psci-1=2E0";
>-		method =3D "smc";
>-	};
>-
> 	soc: soc@0 {
> 		#address-cells =3D <2>;
> 		#size-cells =3D <2>;

--=20
With best wishes
Dmitry
