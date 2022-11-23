Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75A76367C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiKWRzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbiKWRy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:54:59 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4DF6A6AE;
        Wed, 23 Nov 2022 09:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669226095; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHjYY2fJd6j8Ey0DgGBVJy1ZtjI/zI9LZpso74F6uno=;
        b=1ceT52ICq2ZQyZ4ilTggZSteICvAwpgdUn1vYvVXSE1Mpod8SfUX32Wt/8J54K2lHRso31
        snZSJGXMiK4SQZ2abeu3/UdXwAg09siupD1vdHV0NmqLQ+Dk6DCG8amLlA0klFo4G47bUL
        SH03ByJZwO+d1SzA5l3/31j22IB6uJQ=
Date:   Wed, 23 Nov 2022 17:54:47 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2] clocksource: ingenic-ost: define pm functions properly
 in platform_driver struct
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <B3BTLR.7FLNQ6FO762W3@crapouillou.net>
In-Reply-To: <20221123083159.22821-1-lukas.bulwahn@gmail.com>
References: <20221123083159.22821-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

Le mer. 23 nov. 2022 =E0 09:31:59 +0100, Lukas Bulwahn=20
<lukas.bulwahn@gmail.com> a =E9crit :
> Commit ca7b72b5a5f2 ("clocksource: Add driver for the Ingenic JZ47xx=20
> OST")
> adds the struct platform_driver ingenic_ost_driver, with the=20
> definition of
> pm functions under the non-existing config PM_SUSPEND, which means the
> intended pm functions were never actually included in any build.
>=20
> As the only callbacks are .suspend_noirq and .resume_noirq, we can=20
> assume
> that it is intended to be CONFIG_PM_SLEEP.
>=20
> Since commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros,=20
> deprecate
> old ones"), the default pattern for platform_driver definitions
> conditional for CONFIG_PM_SLEEP is to use pm_sleep_ptr().
>=20
> As __maybe_unused annotations on the dev_pm_ops structure and its=20
> callbacks
> are not needed anymore, remove these as well.
>=20
> Suggested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> v1:=20
> https://lore.kernel.org/all/20221122141434.30498-1-lukas.bulwahn@gmail.co=
m/
>=20
> v1 -> v2:
>   - incorporated Paul Cercueil's feedback:
>     - changed to pm_sleep_ptr
>     - dropped Fixes: tag
>=20
>  drivers/clocksource/ingenic-ost.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clocksource/ingenic-ost.c=20
> b/drivers/clocksource/ingenic-ost.c
> index 06d25754e606..9f7c280a1336 100644
> --- a/drivers/clocksource/ingenic-ost.c
> +++ b/drivers/clocksource/ingenic-ost.c
> @@ -141,7 +141,7 @@ static int __init ingenic_ost_probe(struct=20
> platform_device *pdev)
>  	return 0;
>  }
>=20
> -static int __maybe_unused ingenic_ost_suspend(struct device *dev)
> +static int ingenic_ost_suspend(struct device *dev)
>  {
>  	struct ingenic_ost *ost =3D dev_get_drvdata(dev);
>=20
> @@ -150,14 +150,14 @@ static int __maybe_unused=20
> ingenic_ost_suspend(struct device *dev)
>  	return 0;
>  }
>=20
> -static int __maybe_unused ingenic_ost_resume(struct device *dev)
> +static int ingenic_ost_resume(struct device *dev)
>  {
>  	struct ingenic_ost *ost =3D dev_get_drvdata(dev);
>=20
>  	return clk_enable(ost->clk);
>  }
>=20
> -static const struct dev_pm_ops __maybe_unused ingenic_ost_pm_ops =3D {
> +static const struct dev_pm_ops ingenic_ost_pm_ops =3D {
>  	/* _noirq: We want the OST clock to be gated last / ungated first */
>  	.suspend_noirq =3D ingenic_ost_suspend,
>  	.resume_noirq  =3D ingenic_ost_resume,
> @@ -181,9 +181,7 @@ static const struct of_device_id=20
> ingenic_ost_of_match[] =3D {
>  static struct platform_driver ingenic_ost_driver =3D {
>  	.driver =3D {
>  		.name =3D "ingenic-ost",
> -#ifdef CONFIG_PM_SUSPEND
> -		.pm =3D &ingenic_ost_pm_ops,
> -#endif
> +		.pm =3D pm_sleep_ptr(&ingenic_ost_pm_ops),
>  		.of_match_table =3D ingenic_ost_of_match,
>  	},
>  };
> --
> 2.17.1
>=20


