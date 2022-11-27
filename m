Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696E3639C85
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiK0TRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiK0TRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:17:01 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35676DE93
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:17:00 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g7so14368566lfv.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NGH9cftrwxkXZWuNI+4yp8sE7HxPX2x/A4tZLZXh3Zc=;
        b=MXg67/u31QEDWctvxTRsQBTYvNfIh+xFqDL2kTG52VOt3Yn4CLRVtnz9Oyi0RQC7b0
         nZGFNom2AqyswJe487nsKB6tCHeLSW2iiblGdzff19Wn3+lY2tzHrVa3oh8nBMiie+aA
         4dkZpBDwJBAMVE7vTI2bg+EH0MXZsdd5t6q1rvdMcdMI5K7UsqDnTdVq3gypcCuoj7De
         0m7DGplXkR4tizITQ5qv1YWirEWV/cbdL91a98Yaj9fZqHaZOgIqT8JSf1+Dr3wfJjU6
         manevg37tDmKcKm18qKnWiDLHBBEh5JLGADnkyc4/2VCBP6uXYe6/gFlfotFP4LIO5vk
         qMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGH9cftrwxkXZWuNI+4yp8sE7HxPX2x/A4tZLZXh3Zc=;
        b=uP9D4OgweTxLR/PY2qp3dHTFYWRg/pqDauUiLAMawBkFcjQC5oki1kGssAtM6jgAgF
         ctqKOqK/iWzekAWq/TESLXhQQuk0jpcWxIl2C8ML86ROuzHUPat73VQ8hp2u06Ny7rMA
         tlO8CPu4DPN0MAPPLZkwzY7XNkes93miffBHLQcR3JeTntNEuOkRlHbvTVFVp8UOWfbx
         AO1K1kMuU4Iiv+SNnY4o8lOHUGuUU3Ace+GyPQX6wqgcRUDKEMNOw1vK6Y3WfT5Q0NCX
         GTQU8ov8RBs0yYu2CIjEbkwjfAwQJ1SCetWg6hPg0c0H/znvduapmh25ooN712K6QsTK
         36Ow==
X-Gm-Message-State: ANoB5plWgQK+DBp2FVb3z2Y9Wn1SGYdfc84riozXxWZPtdS8c13cIn9q
        erQx/5JNSukvooA/YMUXaI5G3A==
X-Google-Smtp-Source: AA0mqf5uiHMuidAnc8tp8K1EMEOMu5D3yl9AbBKnr4a9k5s49ia+lNfHB9o7KLfnRcL2m+F80auC5g==
X-Received: by 2002:ac2:4288:0:b0:4b4:f950:81e1 with SMTP id m8-20020ac24288000000b004b4f95081e1mr5809206lfh.139.1669576618598;
        Sun, 27 Nov 2022 11:16:58 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.62])
        by smtp.gmail.com with ESMTPSA id c20-20020a056512075400b004a2588520f5sm1380429lfs.166.2022.11.27.11.16.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Nov 2022 11:16:58 -0800 (PST)
Date:   Sun, 27 Nov 2022 22:16:54 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     David Wronek <davidwronek@gmail.com>, linux-kernel@vger.kernel.org
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/3=5D_arm64=3A_dts=3A_qcom=3A_sm82?= =?US-ASCII?Q?50-lenovo-j716f=3A_Enable_ADSP/CDSP/SLPI?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221127170858.440040-4-davidwronek@gmail.com>
References: <20221127170858.440040-1-davidwronek@gmail.com> <20221127170858.440040-4-davidwronek@gmail.com>
Message-ID: <B8A21315-C88B-4855-833D-C846A2CE4E99@linaro.org>
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



On 27 November 2022 20:08:58 GMT+03:00, David Wronek <davidwronek@gmail=2E=
com> wrote:
>Enabled the ADSP, CDSP and SLPI remoteprocs with a simple "okay"=2E
>Firmware needs to be provided by the Linux distribution, as it's signed
>and needs to come from stock Android=2E
>
>Signed-off-by: David Wronek <davidwronek@gmail=2Ecom>
>---
> arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f=2Edts | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f=2Edts b/arch/ar=
m64/boot/dts/qcom/sm8250-lenovo-j716f=2Edts
>index c493721ef664=2E=2E33edeb6f3ef4 100644
>--- a/arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f=2Edts
>+++ b/arch/arm64/boot/dts/qcom/sm8250-lenovo-j716f=2Edts
>@@ -76,6 +76,11 @@ vreg_s6c_0p88: smpc6-regulator {
> 	};
> };
>=20
>+&adsp {
>+	status =3D "okay";
>+	firmware-name =3D "qcom/sm8250/j716f/adsp=2Embn";
>+};
>+
> &apps_rsc {
> 	pm8150-rpmh-regulators {
> 		compatible =3D "qcom,pm8150-rpmh-regulators";
>@@ -434,6 +439,11 @@ vreg_l7f_1p8: ldo7 {
> 	};
> };
>=20
>+&cdsp {
>+	status =3D "okay";
>+	firmware-name =3D "qcom/sm8250/j716f/cdsp=2Embn";

Please add vendor to the firmware path, see sc8280 x13s dts


>+};
>+
> &gpi_dma0 {
> 	status =3D "okay";
> };
>@@ -515,6 +525,11 @@ &qupv3_id_2 {
> 	status =3D "okay";
> };
>=20
>+&slpi {
>+	status =3D "okay";
>+	firmware-name =3D "qcom/sm8250/j716f/slpi=2Embn";
>+};
>+
> &tlmm {
> 	gpio-reserved-ranges =3D <40 4>;
> };

--=20
With best wishes
Dmitry
