Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B782870C30C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjEVQLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEVQLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:11:51 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81DFDB;
        Mon, 22 May 2023 09:11:49 -0700 (PDT)
Received: from g550jk.localnet (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0E607C45E6;
        Mon, 22 May 2023 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684771878; bh=33AZvqJd+4/KhFKyPgkNpJwBfdbXu2WgQzXOzA8B7dY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uynRXwL1BY1loUD5++lQkj5eiYQKd3lMULzhSppegcT8g8d4t9HXdrhlU5Hl5NpQI
         Y8Cl4OO4RXzX2LmNI/UcNsu8Jnk/aPTF5VGlqQm4k0pJpR+wavwd+eESmuWUi8VL4y
         RfmgmTukIxtla+4nwT8wtDgzgshkfWFz+edOf+iY=
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
Subject: Re: [PATCH v2 4/4] ARM: dts: qcom: msm8226: Add IMEM node
Date:   Mon, 22 May 2023 18:11:17 +0200
Message-ID: <4828763.31r3eYUQgx@z3ntu.xyz>
In-Reply-To: <20230520121933.15533-5-matti.lehtimaki@gmail.com>
References: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
 <20230520121933.15533-5-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 20. Mai 2023 14:19:33 CEST Matti Lehtim=E4ki wrote:
> This enables userspace to signal the bootloader to go into the
> bootloader or recovery mode.
>=20
> The magic values can be found in both the downstream kernel and the LK
> kernel (bootloader).
>=20
> Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
> Changes in v2:
>   - Always enable IMEM node
>   - Move reboot-mode magic numbers to platform,
>     those should be always the same
> ---
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi
> b/arch/arm/boot/dts/qcom-msm8226.dtsi index 8644540f5aae..284b7c666fea
> 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -641,6 +641,20 @@ smd-edge {
>  				label =3D "lpass";
>  			};
>  		};
> +
> +		sram@fe805000 {
> +			compatible =3D "qcom,msm8226-imem", "syscon",=20
"simple-mfd";
> +			reg =3D <0xfe805000 0x1000>;
> +
> +			reboot-mode {
> +				compatible =3D "syscon-reboot-mode";
> +				offset =3D <0x65c>;
> +
> +				mode-bootloader =3D <0x77665500>;
> +				mode-normal     =3D <0x77665501>;
> +				mode-recovery   =3D <0x77665502>;
> +			};
> +		};
>  	};
>=20
>  	timer {




