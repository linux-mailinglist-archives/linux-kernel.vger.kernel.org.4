Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECA264A21D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiLLNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiLLNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:49:13 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82538E83
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:48:44 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g7so18672181lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iDMbD/18nuHWQtb1tmVDRwAlv30vkgx0e5NkTsBp0RY=;
        b=urabBlYUPB74hYC9RPseurYJA663uW/HguXnHNxo9VzHCBR8VTRj9TllPIKUx9W4ON
         Uze84l7kAUx/9lyz/MJiSZ5Dr1PWukgvR6ubgrofKqWY5DUqOXGPUtAMYUk/L5xeIgLk
         hnYwTq+7H+vUijes+4LnIgZR+yBBZPW/qNCUG3XjFMwGpHONo7ODjF7Z8f2vlqjRNl3X
         oSi4hyqkzWjtyNZdhzMKm+cedmpv5tk1QQIks/O/GtZbQUOz6Gp3BoMeA1a0anouNuXE
         Em7Izq9xE6Yu380EzHJ70OSYY5DlBOBMfJUr74beuIWPPO2+WOxn/4CI+g5JWdPO/tcq
         X7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDMbD/18nuHWQtb1tmVDRwAlv30vkgx0e5NkTsBp0RY=;
        b=yCe3uJODqncf8pLJJXeRDEdZT6Ej4w9aHujfM0Bwj4AV4VnFZ/+9Fbi+VcAoiCHOek
         Efliwh8XQstOxdpciECoVbPdlC0pPhdhHGyPIdpcpNC2McrWz9qcsuaI+XrW0R/QEzqP
         jL/kST8MEsLCkdjmhDDafyZbwhR8y7UQ03zkhogIQ4Fjwd+r64SJKkMtc9Ki39WgdzOD
         neaMFVEw8QlTMR8M0d487+bYa1CNb1RcLPgIpIjHRLEArC+qAsJl6aRA0uYw7oPHTFeQ
         XqgLsYeobrIMmLzkBUtlb12wLQXdGfzrwxj98x1mH7pjhGm0IEiMjiFLeMIVoK1jHXvK
         B3Cw==
X-Gm-Message-State: ANoB5pk2djZ8/+TP6V2ktII9SpvWhjJuw4Zc5yONRCinjEu9xG3bKDZ7
        mLiihi4h9vn64q6yLsqgr6dVmw==
X-Google-Smtp-Source: AA0mqf7bcBYYJl9MZxH7kjHZRYs7zWOK5eYSERnVAOHv+FaaaWcexvSrRppZZ8gXgo2d3BKpJ6P0+w==
X-Received: by 2002:a05:6512:3092:b0:4b4:e4a3:4a23 with SMTP id z18-20020a056512309200b004b4e4a34a23mr6290583lfd.20.1670852922910;
        Mon, 12 Dec 2022 05:48:42 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512348900b004994c190581sm1646905lfr.123.2022.12.12.05.48.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:48:42 -0800 (PST)
Date:   Mon, 12 Dec 2022 16:48:39 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_6/6=5D_arm64=3A_dts=3A_qcom=3A_sm82?= =?US-ASCII?Q?50=3A_move_sound_and_codec_nodes_out_of_soc?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221212100232.138519-6-krzysztof.kozlowski@linaro.org>
References: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org> <20221212100232.138519-6-krzysztof.kozlowski@linaro.org>
Message-ID: <7110E919-E87C-4AF8-BD23-D10251D769AC@linaro.org>
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



On 12 December 2022 13:02:32 GMT+03:00, Krzysztof Kozlowski <krzysztof=2Ek=
ozlowski@linaro=2Eorg> wrote:
>The sound and on-board WCD9380 codec nodes are not properties of the
>soc, but rather board as it describes the sound configuration=2E  They al=
so
>does not have unit addresses:
>
>  sm8250-hdk=2Edtb: soc@0: sound: {} should not be valid under {'type': '=
object'}
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof=2Ekozlowski@linaro=2Eorg>
>Reviewed-by: Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg>

Reviewed-by: Dmitry Baryshkov<dmitry=2Ebaryshkov@linaro=2Eorg>


>
>---
>
>Changes since v1:
>1=2E Add Rb tag=2E
>2=2E Rephrase commit msg=2E
>---
> arch/arm64/boot/dts/qcom/sm8250-mtp=2Edts | 40 ++++++++++++-------------
> arch/arm64/boot/dts/qcom/sm8250=2Edtsi    |  6 ++--
> 2 files changed, 22 insertions(+), 24 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp=2Edts b/arch/arm64/boot/=
dts/qcom/sm8250-mtp=2Edts
>index 3ed8c84e25b8=2E=2Eb741b7da1afc 100644
>--- a/arch/arm64/boot/dts/qcom/sm8250-mtp=2Edts
>+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp=2Edts
>@@ -27,6 +27,25 @@ chosen {
> 		stdout-path =3D "serial0:115200n8";
> 	};
>=20
>+	wcd938x: codec {
>+		compatible =3D "qcom,wcd9380-codec";
>+		#sound-dai-cells =3D <1>;
>+		reset-gpios =3D <&tlmm 32 GPIO_ACTIVE_LOW>;
>+		vdd-buck-supply =3D <&vreg_s4a_1p8>;
>+		vdd-rxtx-supply =3D <&vreg_s4a_1p8>;
>+		vdd-io-supply =3D <&vreg_s4a_1p8>;
>+		vdd-mic-bias-supply =3D <&vreg_bob>;
>+		qcom,micbias1-microvolt =3D <1800000>;
>+		qcom,micbias2-microvolt =3D <1800000>;
>+		qcom,micbias3-microvolt =3D <1800000>;
>+		qcom,micbias4-microvolt =3D <1800000>;
>+		qcom,mbhc-buttons-vthreshold-microvolt =3D <75000 150000 237000 500000=
 500000 500000 500000 500000>;
>+		qcom,mbhc-headset-vthreshold-microvolt =3D <1700000>;
>+		qcom,mbhc-headphone-vthreshold-microvolt =3D <50000>;
>+		qcom,rx-device =3D <&wcd_rx>;
>+		qcom,tx-device =3D <&wcd_tx>;
>+	};
>+
> 	thermal-zones {
> 		camera-thermal {
> 			polling-delay-passive =3D <0>;
>@@ -631,27 +650,6 @@ &slpi {
> 	firmware-name =3D "qcom/sm8250/slpi=2Embn";
> };
>=20
>-&soc {
>-	wcd938x: codec {
>-		compatible =3D "qcom,wcd9380-codec";
>-		#sound-dai-cells =3D <1>;
>-		reset-gpios =3D <&tlmm 32 GPIO_ACTIVE_LOW>;
>-		vdd-buck-supply =3D <&vreg_s4a_1p8>;
>-		vdd-rxtx-supply =3D <&vreg_s4a_1p8>;
>-		vdd-io-supply =3D <&vreg_s4a_1p8>;
>-		vdd-mic-bias-supply =3D <&vreg_bob>;
>-		qcom,micbias1-microvolt =3D <1800000>;
>-		qcom,micbias2-microvolt =3D <1800000>;
>-		qcom,micbias3-microvolt =3D <1800000>;
>-		qcom,micbias4-microvolt =3D <1800000>;
>-		qcom,mbhc-buttons-vthreshold-microvolt =3D <75000 150000 237000 500000=
 500000 500000 500000 500000>;
>-		qcom,mbhc-headset-vthreshold-microvolt =3D <1700000>;
>-		qcom,mbhc-headphone-vthreshold-microvolt =3D <50000>;
>-		qcom,rx-device =3D <&wcd_rx>;
>-		qcom,tx-device =3D <&wcd_tx>;
>-	};
>-};
>-
> &sound {
> 	compatible =3D "qcom,sm8250-sndcard";
> 	model =3D "SM8250-MTP-WCD9380-WSA8810-VA-DMIC";
>diff --git a/arch/arm64/boot/dts/qcom/sm8250=2Edtsi b/arch/arm64/boot/dts=
/qcom/sm8250=2Edtsi
>index d517d6a80bdc=2E=2Efbbbae29e0c2 100644
>--- a/arch/arm64/boot/dts/qcom/sm8250=2Edtsi
>+++ b/arch/arm64/boot/dts/qcom/sm8250=2Edtsi
>@@ -2826,9 +2826,6 @@ compute-cb@8 {
> 			};
> 		};
>=20
>-		sound: sound {
>-		};
>-
> 		usb_1_hsphy: phy@88e3000 {
> 			compatible =3D "qcom,sm8250-usb-hs-phy",
> 				     "qcom,usb-snps-hs-7nm-phy";
>@@ -4910,6 +4907,9 @@ cpufreq_hw: cpufreq@18591000 {
> 		};
> 	};
>=20
>+	sound: sound {
>+	};
>+
> 	timer {
> 		compatible =3D "arm,armv8-timer";
> 		interrupts =3D <GIC_PPI 13

--=20
With best wishes
Dmitry
