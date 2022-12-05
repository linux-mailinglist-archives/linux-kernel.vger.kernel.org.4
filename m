Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D236436C1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiLEVYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiLEVYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:24:25 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5782C65D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:24:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so20561686lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UBWI6DHH7DjDOuFNz14MhteVSf07LGZhhr0wC/bQFVg=;
        b=GK8MkCjXP6JNnDrit2+fZfbCyLJiywf6EBxGU77IvO+UBYfJd+jAazbVIQOa4+k1K6
         2iszSHnFb2qDKWhtcPbezVzogxaxraEQjm8H34N/kAk8wD6fuzMQ5PLoqEbIpxISk1o5
         rTM/VBcoxNX/2CkbIdgnk0iKSepd2v2SebyOLueiRMLHBEEjScgaLdmNb9GnH70zL0qj
         Jy5SM7Ot4IICBbWFD5di2LhEYtWl+4A4xOPIt7cqX+auzpqBxUgC1wgVFyMm/abTJbUa
         hjww+9NrCA3dzKj5am9HHDm91mYZUutRnOk0TBhcdvDKTJKgLs/U4fHrIWpQlJu+s8Io
         pKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBWI6DHH7DjDOuFNz14MhteVSf07LGZhhr0wC/bQFVg=;
        b=4KkAfJsLXAqmeC1JwPkJ34eGXM+o4iO8NMKHjz/0oJbbPxOn6/HlqQvAnaRGHn2Z0s
         1GwRDbuGbsPfWo3IBK964cq0qw1EuzUX8ffIEk130Ou/Jv9XlzVsGqkRP+aKlZ6AvRjM
         UDU8WkCMkDnShbXKWYNr/dGCnGwB2vLGQjYZ0T8/yVy/PM9WkGlCp6+gbvsj8xbqNOS8
         oiqqvAjfSEHA1FMHDDM7z2IcGK3ri+sU30elZexMc9JKU1QKRU2+JMhCMcmmmr8Ywknm
         rKuP2hOEZuGhc7NcSVKshgANN2mOoqlZwUwF1whELC8McA21hhNfH8jfwtMd/KXqzqDE
         hswA==
X-Gm-Message-State: ANoB5pmgVs9vmroTW+mLx3ydhMgRe+7z4v5SpMd3e/X+Qx4SHkU+6TFe
        HDQlBWqPv7Su1uJyp2gZ3jovjcANi8JTgRmS
X-Google-Smtp-Source: AA0mqf6NLxfdGcgAUKPIFMbImS+xXXr0xSRy0XaT3lnLXh+uKEO6gX2a+oL7m+XvKUevbxENcbLH+Q==
X-Received: by 2002:a19:6d0b:0:b0:4a2:489d:490f with SMTP id i11-20020a196d0b000000b004a2489d490fmr29405143lfc.196.1670275448106;
        Mon, 05 Dec 2022 13:24:08 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651c131100b00279f213302bsm678020lja.57.2022.12.05.13.24.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:24:07 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:23:59 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/13] arm64: dts: qcom: sc8280xp-crd: Enable EDP
User-Agent: K-9 Mail for Android
In-Reply-To: <20221205174433.16847-13-quic_bjorande@quicinc.com>
References: <20221205174433.16847-1-quic_bjorande@quicinc.com> <20221205174433.16847-13-quic_bjorande@quicinc.com>
Message-ID: <419ABEAD-3E80-4A6D-AE44-8DF30C4CBA71@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5 December 2022 20:44:32 GMT+03:00, Bjorn Andersson <quic_bjorande@quic=
inc=2Ecom> wrote:
>From: Bjorn Andersson <bjorn=2Eandersson@linaro=2Eorg>
>
>The SC8280XP CRD has a EDP display on MDSS0 DP3, enable relevant nodes
>and link it together with the backlight control=2E
>
>Signed-off-by: Bjorn Andersson <bjorn=2Eandersson@linaro=2Eorg>
>Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc=2Ecom>
>---
>
>Changes since v3:
>- Added description of the regulator that powers the panel=2E
>
> arch/arm64/boot/dts/qcom/sc8280xp-crd=2Edts | 72 ++++++++++++++++++++++-
> 1 file changed, 71 insertions(+), 1 deletion(-)
>
>diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd=2Edts b/arch/arm64/boo=
t/dts/qcom/sc8280xp-crd=2Edts
>index f09810e3d956=2E=2Ea7d2384cbbe8 100644
>--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd=2Edts
>+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd=2Edts
>@@ -20,7 +20,7 @@ aliases {
> 		serial0 =3D &qup2_uart17;
> 	};
>=20
>-	backlight {
>+	backlight: backlight {
> 		compatible =3D "pwm-backlight";
> 		pwms =3D <&pmc8280c_lpg 3 1000000>;
> 		enable-gpios =3D <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
>@@ -34,6 +34,22 @@ chosen {
> 		stdout-path =3D "serial0:115200n8";
> 	};
>=20
>+	vreg_edp_3p3: regulator-edp-3p3 {
>+		compatible =3D "regulator-fixed";
>+
>+		regulator-name =3D "VREG_EDP_3P3";
>+		regulator-min-microvolt =3D <3300000>;
>+		regulator-max-microvolt =3D <3300000>;
>+
>+		gpio =3D <&tlmm 25 GPIO_ACTIVE_HIGH>;
>+		enable-active-high;
>+
>+		pinctrl-names =3D "default";
>+		pinctrl-0 =3D <&edp_reg_en>;
>+
>+		regulator-boot-on;
>+	};
>+
> 	vreg_edp_bl: regulator-edp-bl {
> 		compatible =3D "regulator-fixed";
>=20
>@@ -230,6 +246,54 @@ vreg_l9d: ldo9 {
> 	};
> };
>=20
>+&dispcc0 {
>+	status =3D "okay";
>+};
>+
>+&mdss0 {
>+	status =3D "okay";
>+};
>+
>+&mdss0_dp3 {
>+	compatible =3D "qcom,sc8280xp-edp";
>+	status =3D "okay";
>+
>+	data-lanes =3D <0 1 2 3>;
>+
>+	aux-bus {
>+		panel {
>+			compatible =3D "edp-panel";
>+			power-supply =3D <&vreg_edp_3p3>;
>+
>+			backlight =3D <&backlight>;
>+
>+			ports {
>+				port {
>+					edp_panel_in: endpoint {
>+						remote-endpoint =3D <&mdss0_dp3_out>;
>+					};
>+				};
>+			};
>+		};
>+	};
>+
>+	ports {
>+		port@1 {
>+			reg =3D <1>;

You already have reg assignment in the SoC dtsi=2E

>+			mdss0_dp3_out: endpoint {
>+				remote-endpoint =3D <&edp_panel_in>;
>+			};
>+		};
>+	};
>+};
>+
>+&mdss0_dp3_phy {
>+	status =3D "okay";
>+
>+	vdda-phy-supply =3D <&vreg_l6b>;
>+	vdda-pll-supply =3D <&vreg_l3b>;
>+};
>+
> &pcie2a {
> 	perst-gpios =3D <&tlmm 143 GPIO_ACTIVE_LOW>;
> 	wake-gpios =3D <&tlmm 145 GPIO_ACTIVE_LOW>;
>@@ -496,6 +560,12 @@ hastings_reg_en: hastings-reg-en-state {
> &tlmm {
> 	gpio-reserved-ranges =3D <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>=20
>+	edp_reg_en: edp-reg-en-state {
>+		pins =3D "gpio25";
>+		function =3D "gpio";
>+		output-enable;
>+	};
>+
> 	kybd_default: kybd-default-state {
> 		disable-pins {
> 			pins =3D "gpio102";

--=20
With best wishes
Dmitry
