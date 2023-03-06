Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05796AD107
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCFWD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCFWD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:03:57 -0500
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EC337737;
        Mon,  6 Mar 2023 14:03:56 -0800 (PST)
Date:   Mon, 06 Mar 2023 22:03:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1678140234; x=1678399434;
        bh=OTDepwlsOdLgprucsSOriozVDNnd/jcEVBfUOz9Dh+A=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=LzdQQ8oY/Ukfzb2VBvlugRtJkjCLGNjiCoRNuGa6mSM0RIe6N03DUl1OXPbzIB0CL
         zNVvuEs3icrrDVWc2/jrLx2sqBm+iWixV4WWmpqCcVMXL2z0MEyrp8+MJ6Ik9A1klb
         2aMpH77AiFJTeE6IsalUySLkdDURRgFFvfpuTBJk=
To:     Gergo Koteles <soyer@irl.hu>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-oneplus-common: add Hall sensor
Message-ID: <940dec11-dbcb-d6df-3722-0375bfe86508@connolly.tech>
In-Reply-To: <20230306174147.185239-1-soyer@irl.hu>
References: <20230306174147.185239-1-soyer@irl.hu>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/03/2023 17:41, Gergo Koteles wrote:
> Enable the Hall effect sensor (flip cover) for OnePlus 6/6T.
> The GPIO is mapped to SW_LID events as in msm8916, msm8994,
> msm8998 devices.
>
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/a=
rm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index 64638ea94db7..b01542d79ae2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -29,6 +29,23 @@ chosen {
>  =09=09stdout-path =3D "serial0:115200n8";
>  =09};
>
> +=09gpio-hall-sensor {
> +=09=09compatible =3D "gpio-keys";
> +=09=09label =3D "Hall effect sensor";
> +
> +=09=09pinctrl-0 =3D <&hall_sensor_default>;
> +=09=09pinctrl-names =3D "default";
> +
> +=09=09event-hall-sensor {
> +=09=09=09gpios =3D <&tlmm 124 GPIO_ACTIVE_LOW>;
> +=09=09=09label =3D "Hall Effect Sensor";
> +=09=09=09linux,input-type =3D <EV_SW>;
> +=09=09=09linux,code =3D <SW_LID>;
> +=09=09=09linux,can-disable;
> +=09=09=09wakeup-source;
> +=09=09};
> +=09};
> +
>  =09gpio-keys {
>  =09=09compatible =3D "gpio-keys";
>  =09=09label =3D "Volume keys";
> @@ -753,6 +770,14 @@ &usb_1_hsphy {
>  &tlmm {
>  =09gpio-reserved-ranges =3D <0 4>, <81 4>;
>
> +=09hall_sensor_default: hall-sensor-default-state {
> +=09=09pins =3D "gpio124";
> +=09=09function =3D "gpio";
> +=09=09drive-strength =3D <2>;
> +=09=09bias-disable;
> +=09=09input-enable;
> +=09};
> +
>  =09tri_state_key_default: tri-state-key-default-state {
>  =09=09pins =3D "gpio40", "gpio42", "gpio26";
>  =09=09function =3D "gpio";
> --
> 2.39.2
>

--
Kind Regards,
Caleb

