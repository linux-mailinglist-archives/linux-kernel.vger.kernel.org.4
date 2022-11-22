Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9E9633ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiKVOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiKVOYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:24:13 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E91D64B;
        Tue, 22 Nov 2022 06:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669127049; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d3ilnwvGSIbuymsxkNTBN2+qw4DZ1au5wceKlKjVAIY=;
        b=RFuR586+lXhPojTRvRKzmmtzBhSvNBAktZrO0gKeeJyOIFlJNpCaRu879PVH//9AZPXnRg
        3KdhPH7zN8tLvoA2hib6oGSLWTUHzm/JWKIL/l/7pfdvy6ZBxEZ0o4VKqKV7PCdcBPS+iT
        8cy41F9JIiI4lYIvz1wW0EJx9z7N+XE=
Date:   Tue, 22 Nov 2022 14:24:00 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clocksource: ingenic-ost: define pm functions properly in
 platform_driver struct
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <0O6RLR.G9QGB8EGFCT01@crapouillou.net>
In-Reply-To: <20221122141434.30498-1-lukas.bulwahn@gmail.com>
References: <20221122141434.30498-1-lukas.bulwahn@gmail.com>
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

Le mar. 22 nov. 2022 =E0 15:14:34 +0100, Lukas Bulwahn=20
<lukas.bulwahn@gmail.com> a =E9crit :
> Commit ca7b72b5a5f2 ("clocksource: Add driver for the Ingenic JZ47xx=20
> OST")
> adds the struct platform_driver ingenic_ost_driver, with the=20
> definition of
> pm functions under the non-existing config PM_SUSPEND, which means the
> intended pm functions were never actually included in any build.
>=20
> Since commit 7a82e97a11b9 ("PM: core: introduce pm_ptr() macro"), the
> default pattern for platform_driver definitions is to use pm_ptr().
> Assuming CONFIG_PM_SUSPEND really intended to mean CONFIG_PM (and not
> CONFIG_PM_SLEEP), use pm_ptr() just as most other drivers do.

It actually was supposed to be CONFIG_PM_SLEEP, yes. You can see that=20
because the only callbacks are .suspend_noirq and .resume_noirq.=20
Therefore you can use pm_sleep_ptr() instead of pm_ptr().

By the way, once you use this macro then the __maybe_unused tags on the=20
dev_pm_ops structure and its callbacks are not needed anymore, so you=20
can remove these as well.

> Fixes: ca7b72b5a5f2 ("clocksource: Add driver for the Ingenic JZ47xx=20
> OST")

That Fixes: tag won't work since the pm_ptr() macro did not exist back=20
then (besides, you didn't Cc linux-stable).

I'd advocate to remove the Fixes: tag, since it is not really a bug=20
fix, more like an improvement.

Cheers,
-Paul

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/clocksource/ingenic-ost.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/clocksource/ingenic-ost.c=20
> b/drivers/clocksource/ingenic-ost.c
> index 06d25754e606..6b64731df15c 100644
> --- a/drivers/clocksource/ingenic-ost.c
> +++ b/drivers/clocksource/ingenic-ost.c
> @@ -181,9 +181,7 @@ static const struct of_device_id=20
> ingenic_ost_of_match[] =3D {
>  static struct platform_driver ingenic_ost_driver =3D {
>  	.driver =3D {
>  		.name =3D "ingenic-ost",
> -#ifdef CONFIG_PM_SUSPEND
> -		.pm =3D &ingenic_ost_pm_ops,
> -#endif
> +		.pm =3D pm_ptr(&ingenic_ost_pm_ops),
>  		.of_match_table =3D ingenic_ost_of_match,
>  	},
>  };
> --
> 2.17.1
>=20


