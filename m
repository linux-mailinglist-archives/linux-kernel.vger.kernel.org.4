Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519264A1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiLLNqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiLLNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:46:22 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B233714D27
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:46:05 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x11so12546849ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uDqtmi6A0eZmDUY2kvvCiXovAuzNGSGMJBSvPYiPqjo=;
        b=vUTtPCtoN7ZLTCcte06IJow9K4YSWsSTTneJEVMksJQHI9i6Rn4lQ6rfu5MKLOufFo
         ikv1H8/XcCYxg7UYtL6PvvVhAPPvFR2YV2sySfO9RmiAl3VQKqzWiUbmcWAaJuq5i7C0
         c88n4NYcjOGxqESmnYmx7Zgw6WwQYBLMnNNkLK1a7Sw15aUmOnXKTE+ZYYJl179GYVpZ
         4jlvrUDXRXJCAx1JFmUtyshKNJBCK6C7UXfE3C3uDB7MJyQrCbcpuaHKBwjLIH8czwmr
         sz47g0lrLQ3UDVpP3P7ghFlALGoK6oS8Fb0/uEM+NZ0imH+PGDKiSjaeZdM3Ee1JoFoJ
         wR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDqtmi6A0eZmDUY2kvvCiXovAuzNGSGMJBSvPYiPqjo=;
        b=BKGzpf3nBVw+mx4CaYhY4ZQ6gtFxvkZtHQRK8QRwil/KKKKhKSerQLI/pP1A4FyD2n
         1S9wIL7P9QY7pBCX/l4Rw512tMkt6wNx/QFAtQ6vAjFjM567RxzKXu7Np2L/SDgG5GEQ
         bITtM7aFN3UQMl37SoB4YuqtZN1EbNkwxPw79lEovjzWkFsvIuQTWUEr/Tkvlz7FOD5v
         Tt1TG0PknHVUDoYIUIGL6INEzp4HMP8MEU7PYldKx0if1ZbkdM0ytpeDzhy/DbExNS+r
         nRAiyhPjAWlPFhweCo+uB1dnolba83Hol6Y3qE9BN4OQE+AY/gfTWGwm0jHsK14poWvU
         6wkQ==
X-Gm-Message-State: ANoB5plgM/BZJ7WmDwK35+ojg/1ww5Ud4Gd8zt0zobuMkbxVFQtxWj/s
        ljSLoolpAogeZsAvVmfXVcrsIg==
X-Google-Smtp-Source: AA0mqf7+rxBgGmL5btjg4YyYk7sb9Ys4ucLmzWa5rX1i5pEnyyFaNYbh0ZDpigB9AyYFkLRxmQMZFQ==
X-Received: by 2002:a05:651c:2226:b0:278:d139:7420 with SMTP id y38-20020a05651c222600b00278d1397420mr5504463ljq.44.1670852763931;
        Mon, 12 Dec 2022 05:46:03 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id c8-20020ac25308000000b004b55075f813sm1625013lfh.227.2022.12.12.05.46.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:46:03 -0800 (PST)
Date:   Mon, 12 Dec 2022 16:46:00 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_4/6=5D_arm64=3A_dts=3A_qcom=3A_sdm845=3A?= =?US-ASCII?Q?_move_DSI/QUP/QSPI_opp_tables_out_of_SoC_node?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221212100232.138519-4-krzysztof.kozlowski@linaro.org>
References: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org> <20221212100232.138519-4-krzysztof.kozlowski@linaro.org>
Message-ID: <C262B514-6AB2-41C8-BBBA-CAE3186BBB3D@linaro.org>
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



On 12 December 2022 13:02:30 GMT+03:00, Krzysztof Kozlowski <krzysztof=2Ek=
ozlowski@linaro=2Eorg> wrote:
>The SoC node is a simple-bus and its schema expect to have nodes only
>with unit addresses:
>
>  sdm850-lenovo-yoga-c630=2Edtb: soc@0: opp-table-qup: {'compatible': ['o=
perating-points-v2'], 'phandle': [[60]], 'opp-50000000':
>  =2E=2E=2E 'required-opps': [[55]]}} should not be valid under {'type': =
'object'}
>
>Move to top-level OPP tables:
> - DSI and QUP which are shared between multiple nodes,

This makes me rise a question: on other platforms we have been placing the=
 shared dsi opp table into one of DSI nodes (usually into the second one)=
=2E Should we also move such tables up to the top level?


> - QSPI which cannot be placed in its node due to address/size cells=2E
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof=2Ekozlowski@linaro=2Eorg>
>Reviewed-by: Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg>

Reviewed-by: Dmitry Baryshkov<dmitry=2Ebaryshkov@linaro=2Eorg>

>
>---
>
>Changes since v1:
>1=2E Only rebase due to node reorderings=2E
>2=2E Add Rb tag=2E
>---
> arch/arm64/boot/dts/qcom/sdm845=2Edtsi | 154 +++++++++++++--------------
> 1 file changed, 77 insertions(+), 77 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/qcom/sdm845=2Edtsi b/arch/arm64/boot/dts=
/qcom/sdm845=2Edtsi
>index 88e7d4061aae=2E=2E8eeb3aa261d5 100644
>--- a/arch/arm64/boot/dts/qcom/sdm845=2Edtsi
>+++ b/arch/arm64/boot/dts/qcom/sdm845=2Edtsi
>@@ -604,6 +604,83 @@ cpu4_opp32: opp-2803200000 {
> 		};
> 	};
>=20
>+	dsi_opp_table: opp-table-dsi {
>+		compatible =3D "operating-points-v2";
>+
>+		opp-19200000 {
>+			opp-hz =3D /bits/ 64 <19200000>;
>+			required-opps =3D <&rpmhpd_opp_min_svs>;
>+		};
>+
>+		opp-180000000 {
>+			opp-hz =3D /bits/ 64 <180000000>;
>+			required-opps =3D <&rpmhpd_opp_low_svs>;
>+		};
>+
>+		opp-275000000 {
>+			opp-hz =3D /bits/ 64 <275000000>;
>+			required-opps =3D <&rpmhpd_opp_svs>;
>+		};
>+
>+		opp-328580000 {
>+			opp-hz =3D /bits/ 64 <328580000>;
>+			required-opps =3D <&rpmhpd_opp_svs_l1>;
>+		};
>+
>+		opp-358000000 {
>+			opp-hz =3D /bits/ 64 <358000000>;
>+			required-opps =3D <&rpmhpd_opp_nom>;
>+		};
>+	};
>+
>+	qspi_opp_table: opp-table-qspi {
>+		compatible =3D "operating-points-v2";
>+
>+		opp-19200000 {
>+			opp-hz =3D /bits/ 64 <19200000>;
>+			required-opps =3D <&rpmhpd_opp_min_svs>;
>+		};
>+
>+		opp-100000000 {
>+			opp-hz =3D /bits/ 64 <100000000>;
>+			required-opps =3D <&rpmhpd_opp_low_svs>;
>+		};
>+
>+		opp-150000000 {
>+			opp-hz =3D /bits/ 64 <150000000>;
>+			required-opps =3D <&rpmhpd_opp_svs>;
>+		};
>+
>+		opp-300000000 {
>+			opp-hz =3D /bits/ 64 <300000000>;
>+			required-opps =3D <&rpmhpd_opp_nom>;
>+		};
>+	};
>+
>+	qup_opp_table: opp-table-qup {
>+		compatible =3D "operating-points-v2";
>+
>+		opp-50000000 {
>+			opp-hz =3D /bits/ 64 <50000000>;
>+			required-opps =3D <&rpmhpd_opp_min_svs>;
>+		};
>+
>+		opp-75000000 {
>+			opp-hz =3D /bits/ 64 <75000000>;
>+			required-opps =3D <&rpmhpd_opp_low_svs>;
>+		};
>+
>+		opp-100000000 {
>+			opp-hz =3D /bits/ 64 <100000000>;
>+			required-opps =3D <&rpmhpd_opp_svs>;
>+		};
>+
>+		opp-128000000 {
>+			opp-hz =3D /bits/ 64 <128000000>;
>+			required-opps =3D <&rpmhpd_opp_nom>;
>+		};
>+	};
>+
> 	pmu {
> 		compatible =3D "arm,armv8-pmuv3";
> 		interrupts =3D <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
>@@ -1117,30 +1194,6 @@ rng: rng@793000 {
> 			clock-names =3D "core";
> 		};
>=20
>-		qup_opp_table: opp-table-qup {
>-			compatible =3D "operating-points-v2";
>-
>-			opp-50000000 {
>-				opp-hz =3D /bits/ 64 <50000000>;
>-				required-opps =3D <&rpmhpd_opp_min_svs>;
>-			};
>-
>-			opp-75000000 {
>-				opp-hz =3D /bits/ 64 <75000000>;
>-				required-opps =3D <&rpmhpd_opp_low_svs>;
>-			};
>-
>-			opp-100000000 {
>-				opp-hz =3D /bits/ 64 <100000000>;
>-				required-opps =3D <&rpmhpd_opp_svs>;
>-			};
>-
>-			opp-128000000 {
>-				opp-hz =3D /bits/ 64 <128000000>;
>-				required-opps =3D <&rpmhpd_opp_nom>;
>-			};
>-		};
>-
> 		gpi_dma0: dma-controller@800000 {
> 			#dma-cells =3D <3>;
> 			compatible =3D "qcom,sdm845-gpi-dma";
>@@ -3799,30 +3852,6 @@ opp-201500000 {
> 			};
> 		};
>=20
>-		qspi_opp_table: opp-table-qspi {
>-			compatible =3D "operating-points-v2";
>-
>-			opp-19200000 {
>-				opp-hz =3D /bits/ 64 <19200000>;
>-				required-opps =3D <&rpmhpd_opp_min_svs>;
>-			};
>-
>-			opp-100000000 {
>-				opp-hz =3D /bits/ 64 <100000000>;
>-				required-opps =3D <&rpmhpd_opp_low_svs>;
>-			};
>-
>-			opp-150000000 {
>-				opp-hz =3D /bits/ 64 <150000000>;
>-				required-opps =3D <&rpmhpd_opp_svs>;
>-			};
>-
>-			opp-300000000 {
>-				opp-hz =3D /bits/ 64 <300000000>;
>-				required-opps =3D <&rpmhpd_opp_nom>;
>-			};
>-		};
>-
> 		qspi: spi@88df000 {
> 			compatible =3D "qcom,sdm845-qspi", "qcom,qspi-v1";
> 			reg =3D <0 0x088df000 0 0x600>;
>@@ -4420,35 +4449,6 @@ clock_camcc: clock-controller@ad00000 {
> 			clock-names =3D "bi_tcxo";
> 		};
>=20
>-		dsi_opp_table: opp-table-dsi {
>-			compatible =3D "operating-points-v2";
>-
>-			opp-19200000 {
>-				opp-hz =3D /bits/ 64 <19200000>;
>-				required-opps =3D <&rpmhpd_opp_min_svs>;
>-			};
>-
>-			opp-180000000 {
>-				opp-hz =3D /bits/ 64 <180000000>;
>-				required-opps =3D <&rpmhpd_opp_low_svs>;
>-			};
>-
>-			opp-275000000 {
>-				opp-hz =3D /bits/ 64 <275000000>;
>-				required-opps =3D <&rpmhpd_opp_svs>;
>-			};
>-
>-			opp-328580000 {
>-				opp-hz =3D /bits/ 64 <328580000>;
>-				required-opps =3D <&rpmhpd_opp_svs_l1>;
>-			};
>-
>-			opp-358000000 {
>-				opp-hz =3D /bits/ 64 <358000000>;
>-				required-opps =3D <&rpmhpd_opp_nom>;
>-			};
>-		};
>-
> 		mdss: mdss@ae00000 {
> 			compatible =3D "qcom,sdm845-mdss";
> 			reg =3D <0 0x0ae00000 0 0x1000>;

--=20
With best wishes
Dmitry
