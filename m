Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05FF6F9B74
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjEGU0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGU0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:26:48 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB121BC2;
        Sun,  7 May 2023 13:26:46 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id DB65FCEC2E;
        Sun,  7 May 2023 20:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683491175; bh=aegps/P9c6zcUqRWs2saK8qqf/VAU7m54ZeN6GwFwDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=I7154nsY8eJSEfNDJEBvYIMeUdCPtNRm2qfoRBiHwLU45g1K5VDfenn4uLUinbo7O
         ZwIEUlBTq+ryznCJd6lU8lHmiJ5w/59BPb+lgHXgErtUeDZDQgvxaYNjyRkR7w1My5
         rduJW2udh+hoKNVS1z7YO7vGx3wVvaArEAEP50ho=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Subject: Re: [PATCH 3/6] thermal/drivers/qcom/tsens-v0_1: Add support for MSM8226
Date:   Sun, 07 May 2023 22:26:14 +0200
Message-ID: <4841313.LvFx2qVVIh@z3ntu.xyz>
In-Reply-To: <20230507201225.89694-4-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-4-matti.lehtimaki@gmail.com>
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

On Sonntag, 7. Mai 2023 22:12:21 CEST Matti Lehtim=E4ki wrote:
> The MSM8226 TSENS IP has 6 thermal sensors in a TSENS v0.1 block.
> The thermal sensors use non-standard slope values.

Matches the configuration found in msm8226-v2.dtsi in msm-3.10 kernel.

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

>=20
> Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>
> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 27 ++++++++++++++++++++++++++-
>  drivers/thermal/qcom/tsens.c      |  3 +++
>  drivers/thermal/qcom/tsens.h      |  2 +-
>  3 files changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c
> b/drivers/thermal/qcom/tsens-v0_1.c index e89c6f39a3ae..ad57ab94546b 1006=
44
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -243,6 +243,18 @@ static int calibrate_8974(struct tsens_priv *priv)
>  	return 0;
>  }
>=20
> +static int __init init_8226(struct tsens_priv *priv)
> +{
> +	priv->sensor[0].slope =3D 2901;
> +	priv->sensor[1].slope =3D 2846;
> +	priv->sensor[2].slope =3D 3038;
> +	priv->sensor[3].slope =3D 2955;
> +	priv->sensor[4].slope =3D 2901;
> +	priv->sensor[5].slope =3D 2846;
> +
> +	return init_common(priv);
> +}
> +
>  static int __init init_8939(struct tsens_priv *priv) {
>  	priv->sensor[0].slope =3D 2911;
>  	priv->sensor[1].slope =3D 2789;
> @@ -258,7 +270,7 @@ static int __init init_8939(struct tsens_priv *priv) {
>  	return init_common(priv);
>  }
>=20
> -/* v0.1: 8916, 8939, 8974, 9607 */
> +/* v0.1: 8226, 8916, 8939, 8974, 9607 */
>=20
>  static struct tsens_features tsens_v0_1_feat =3D {
>  	.ver_major	=3D VER_0_1,
> @@ -313,6 +325,19 @@ static const struct tsens_ops ops_v0_1 =3D {
>  	.get_temp	=3D get_temp_common,
>  };
>=20
> +static const struct tsens_ops ops_8226 =3D {
> +	.init		=3D init_8226,
> +	.calibrate	=3D tsens_calibrate_common,
> +	.get_temp	=3D get_temp_common,
> +};
> +
> +struct tsens_plat_data data_8226 =3D {
> +	.num_sensors	=3D 6,
> +	.ops		=3D &ops_8226,
> +	.feat		=3D &tsens_v0_1_feat,
> +	.fields	=3D tsens_v0_1_regfields,
> +};
> +
>  static const struct tsens_ops ops_8916 =3D {
>  	.init		=3D init_common,
>  	.calibrate	=3D calibrate_8916,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 8020ead2794e..eb33a8bf0488 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1095,6 +1095,9 @@ static const struct of_device_id tsens_table[] =3D {
>  	}, {
>  		.compatible =3D "qcom,mdm9607-tsens",
>  		.data =3D &data_9607,
> +	}, {
> +		.compatible =3D "qcom,msm8226-tsens",
> +		.data =3D &data_8226,
>  	}, {
>  		.compatible =3D "qcom,msm8916-tsens",
>  		.data =3D &data_8916,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index dba9cd38f637..433eba370998 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -635,7 +635,7 @@ int get_temp_common(const struct tsens_sensor *s, int
> *temp); extern struct tsens_plat_data data_8960;
>=20
>  /* TSENS v0.1 targets */
> -extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
> +extern struct tsens_plat_data data_8226, data_8916, data_8939, data_8974,
> data_9607;
>=20
>  /* TSENS v1 targets */
>  extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;




