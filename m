Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD05364A20D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiLLNtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiLLNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:48:42 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EA114D1E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:48:10 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g7so18669595lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Lt0DcCHWVp8VHy64Oaljo4mkMdHYT7NcV/PiQ+jymw=;
        b=SJfWDaePor+a20GHOKxAZsDL0ZrQklzTUxJWnoowC6xEl+iWMngzZ6u6aN6Y712I2y
         9PumnTQAmLsKx1w2EZGDH8/CUjg80mf8CxvYBoKuGZh133JMYgKbRgCV5CDC/zYdZmdT
         KZ5D1j7iD948gfM+D4xuAOdKMRXUmllDZeP2Fbcp+OrZ/OSV6s63jBtc3ZsKFIQbm0IY
         W2bQ7qp/9Of0uGENhAsSHL4QUTnjdqu6ND5elGoK4OzAaga8KpXVH+pcs4ln34HEMVzo
         lTkMLTnjhVuZrkkwzAJLd5IqE0mgKq2lis4UjqB3vvW/26nM48Sm3d3iE1jrTLps9Zlp
         4kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Lt0DcCHWVp8VHy64Oaljo4mkMdHYT7NcV/PiQ+jymw=;
        b=QDLINjvpuB5MpT5afEG6g0CuKvHAELsgzr8AINN7WSAip6vEpOItq81CFf7DA3QW7o
         Xa+oLcm20E9aaHPxLCAx9vCdbX1KFc09/6NzMkTvzpAlT/Dmb2+suYfPb+BRUhD+Py1b
         sUV38e4Li1NiRqgU/TH8/nGad1gYE/pJua6mka18DIqAXFD2qfUdwB+/GaC3eSwb4Hz0
         SNaldfBDSrcPgB2VyhMhWN8ZUaX2vFT2r3Hm27JZQ4yAYAvGzutc11E411WMm9bM3g81
         mNT5hQNBQAMjIsG0Olwrwqy1RDcztnL3Oh5OBgpRypJIDHZu3Ge4fjYANPePnjQ48Ymi
         8DZg==
X-Gm-Message-State: ANoB5pmNaTih7UipZEbvGTFiYnuWBWtuBc/A8y3lyV1blPDM2XTYcCKn
        5JHTUrUvCrV1YFxaV9MH8bpO/Q==
X-Google-Smtp-Source: AA0mqf6TPeb+vPRbIRrsTvNFnPJlXPqob+f10NqEtxJIB9HKOJCQcysYLXjpSrGsEy/L6nwZ57aVQA==
X-Received: by 2002:a05:6512:1690:b0:4b6:eca8:f6ca with SMTP id bu16-20020a056512169000b004b6eca8f6camr1099254lfb.67.1670852888547;
        Mon, 12 Dec 2022 05:48:08 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id o9-20020ac25e29000000b004b5b16c3e8asm1592653lfg.164.2022.12.12.05.48.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:48:08 -0800 (PST)
Date:   Mon, 12 Dec 2022 16:48:05 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/6=5D_arm64=3A_dts=3A_qcom=3A_sc7180=3A?= =?US-ASCII?Q?_move_QUP_and_QSPI_opp_tables_out_of_SoC_node?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221212100232.138519-3-krzysztof.kozlowski@linaro.org>
References: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org> <20221212100232.138519-3-krzysztof.kozlowski@linaro.org>
Message-ID: <D0FE36DB-5A1A-493B-A909-C626467D7B3F@linaro.org>
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



On 12 December 2022 13:02:29 GMT+03:00, Krzysztof Kozlowski <krzysztof=2Ek=
ozlowski@linaro=2Eorg> wrote:
>The SoC node is a simple-bus and its schema expect to have nodes only
>with unit addresses:
>
>  sc7180-trogdor-lazor-r3=2Edtb: soc@0: opp-table-qspi: {'compatible': ['=
operating-points-v2'], 'phandle': [[186]], 'opp-75000000':
>    =2E=2E=2E  'required-opps': [[47]]}} should not be valid under {'type=
': 'object'}
>
>Move to top-level OPP tables:
> - QUP which is shared between multiple nodes,
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
> arch/arm64/boot/dts/qcom/sc7180=2Edtsi | 76 ++++++++++++++--------------
> 1 file changed, 38 insertions(+), 38 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/qcom/sc7180=2Edtsi b/arch/arm64/boot/dts=
/qcom/sc7180=2Edtsi
>index 6d3e86ce2936=2E=2Eeb1e1ea12ff6 100644
>--- a/arch/arm64/boot/dts/qcom/sc7180=2Edtsi
>+++ b/arch/arm64/boot/dts/qcom/sc7180=2Edtsi
>@@ -494,6 +494,44 @@ cpu6_opp16: opp-2553600000 {
> 		};
> 	};
>=20
>+	qspi_opp_table: opp-table-qspi {
>+		compatible =3D "operating-points-v2";
>+
>+		opp-75000000 {
>+			opp-hz =3D /bits/ 64 <75000000>;
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
>@@ -739,25 +777,6 @@ opp-384000000 {
> 			};
> 		};
>=20
>-		qup_opp_table: opp-table-qup {
>-			compatible =3D "operating-points-v2";
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
> 		qupv3_id_0: geniqup@8c0000 {
> 			compatible =3D "qcom,geni-se-qup";
> 			reg =3D <0 0x008c0000 0 0x6000>;
>@@ -2655,25 +2674,6 @@ opp-202000000 {
> 			};
> 		};
>=20
>-		qspi_opp_table: opp-table-qspi {
>-			compatible =3D "operating-points-v2";
>-
>-			opp-75000000 {
>-				opp-hz =3D /bits/ 64 <75000000>;
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
> 		qspi: spi@88dc000 {
> 			compatible =3D "qcom,sc7180-qspi", "qcom,qspi-v1";
> 			reg =3D <0 0x088dc000 0 0x600>;

--=20
With best wishes
Dmitry
