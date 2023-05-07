Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5836F9B8D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjEGUbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjEGUbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:31:04 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AE335BF;
        Sun,  7 May 2023 13:31:03 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id CA3DBCC041;
        Sun,  7 May 2023 20:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683491461; bh=MIZ1vBEG5eV2XQXddU637jFQ3/w6ZYtze5ewofEx6BE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MYo9ayUyC5MRGY0rOvExJK8SX4oCSmhf/DJt+aUk3FnSbFNu6UUDNz1hfgTQJU5+8
         34xi1SPDGuRDhBR8Hr5ZEnQc0Nz4wIU2zUymxIzSMVXOeT2X5+LrIr+GKhrOtJluVU
         1yHL5T9jL7QHjQ+tZWBT/RRHTJoi6fjH4jHZaXS0=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: msm8226: Add tsens node and related nvmem cells
Date:   Sun, 07 May 2023 22:31:01 +0200
Message-ID: <2503068.irdbgypaU6@z3ntu.xyz>
In-Reply-To: <20230507201225.89694-6-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-6-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 7. Mai 2023 22:12:23 CEST Matti Lehtim=E4ki wrote:
> Specify pre-parsed per-sensor calibration nvmem cells in the qfprom
> device node rather than parsing the whole data blob in the driver.

I haven't double checked all the qfprom offsets but since you verified it
twice on your side, I believe you ;)

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

>=20
> Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 113 ++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi
> b/arch/arm/boot/dts/qcom-msm8226.dtsi index c34b8f3139ae..a0c3d25eea65
> 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -500,6 +500,34 @@ data-pins {
>  			};
>  		};
>=20
> +		tsens: thermal-sensor@fc4a9000 {
> +			compatible =3D "qcom,msm8226-tsens", "qcom,tsens-v0_1";
> +			reg =3D <0xfc4a9000 0x1000>, /* TM */
> +			      <0xfc4a8000 0x1000>; /* SROT */
> +			nvmem-cells =3D <&tsens_mode>,
> +				      <&tsens_base1>, <&tsens_base2>,
> +				      <&tsens_s0_p1>, <&tsens_s0_p2>,
> +				      <&tsens_s1_p1>, <&tsens_s1_p2>,
> +				      <&tsens_s2_p1>, <&tsens_s2_p2>,
> +				      <&tsens_s3_p1>, <&tsens_s3_p2>,
> +				      <&tsens_s4_p1>, <&tsens_s4_p2>,
> +				      <&tsens_s5_p1>, <&tsens_s5_p2>,
> +				      <&tsens_s6_p1>, <&tsens_s6_p2>;
> +			nvmem-cell-names =3D "mode",
> +					   "base1", "base2",
> +					   "s0_p1", "s0_p2",
> +					   "s1_p1", "s1_p2",
> +					   "s2_p1", "s2_p2",
> +					   "s3_p1", "s3_p2",
> +					   "s4_p1", "s4_p2",
> +					   "s5_p1", "s5_p2",
> +					   "s6_p1", "s6_p2";
> +			#qcom,sensors =3D <6>;
> +			interrupts =3D <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "uplow";
> +			#thermal-sensor-cells =3D <1>;
> +		};
> +
>  		restart@fc4ab000 {
>  			compatible =3D "qcom,pshold";
>  			reg =3D <0xfc4ab000 0x4>;
> @@ -510,6 +538,91 @@ qfprom: qfprom@fc4bc000 {
>  			reg =3D <0xfc4bc000 0x1000>;
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
> +
> +			tsens_base1: base1@1c1 {
> +				reg =3D <0x1c1 0x2>;
> +				bits =3D <5 8>;
> +			};
> +
> +			tsens_s0_p1: s0-p1@1c2 {
> +				reg =3D <0x1c2 0x2>;
> +				bits =3D <5 6>;
> +			};
> +
> +			tsens_s1_p1: s1-p1@1c4 {
> +				reg =3D <0x1c4 0x1>;
> +				bits =3D <0 6>;
> +			};
> +
> +			tsens_s2_p1: s2-p1@1c4 {
> +				reg =3D <0x1c4 0x2>;
> +				bits =3D <6 6>;
> +			};
> +
> +			tsens_s3_p1: s3-p1@1c5 {
> +				reg =3D <0x1c5 0x2>;
> +				bits =3D <4 6>;
> +			};
> +
> +			tsens_s4_p1: s4-p1@1c6 {
> +				reg =3D <0x1c6 0x1>;
> +				bits =3D <2 6>;
> +			};
> +
> +			tsens_s5_p1: s5-p1@1c7 {
> +				reg =3D <0x1c7 0x1>;
> +				bits =3D <0 6>;
> +			};
> +
> +			tsens_s6_p1: s6-p1@1ca {
> +				reg =3D <0x1ca 0x2>;
> +				bits =3D <4 6>;
> +			};
> +
> +			tsens_base2: base2@1cc {
> +				reg =3D <0x1cc 0x1>;
> +				bits =3D <0 8>;
> +			};
> +
> +			tsens_s0_p2: s0-p2@1cd {
> +				reg =3D <0x1cd 0x1>;
> +				bits =3D <0 6>;
> +			};
> +
> +			tsens_s1_p2: s1-p2@1cd {
> +				reg =3D <0x1cd 0x2>;
> +				bits =3D <6 6>;
> +			};
> +
> +			tsens_s2_p2: s2-p2@1ce {
> +				reg =3D <0x1ce 0x2>;
> +				bits =3D <4 6>;
> +			};
> +
> +			tsens_s3_p2: s3-p2@1cf {
> +				reg =3D <0x1cf 0x1>;
> +				bits =3D <2 6>;
> +			};
> +
> +			tsens_s4_p2: s4-p2@446 {
> +				reg =3D <0x446 0x2>;
> +				bits =3D <4 6>;
> +			};
> +
> +			tsens_s5_p2: s5-p2@447 {
> +				reg =3D <0x447 0x1>;
> +				bits =3D <2 6>;
> +			};
> +
> +			tsens_s6_p2: s6-p2@44e {
> +				reg =3D <0x44e 0x1>;
> +				bits =3D <1 6>;
> +			};
> +
> +			tsens_mode: mode@44f {
> +				reg =3D <0x44f 0x1>;
> +				bits =3D <5 3>;
> +			};
>  		};
>=20
>  		spmi_bus: spmi@fc4cf000 {




