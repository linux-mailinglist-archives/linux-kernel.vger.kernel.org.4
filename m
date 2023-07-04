Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE6746C42
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjGDIqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjGDIqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:46:15 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B47B2;
        Tue,  4 Jul 2023 01:46:13 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688460371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQjBl3xjsOvqrn/5MSnlNvfmLvFW7KbTctHheLwyri4=;
        b=Nx+gbrqlmWo18DeiRQmsO25hjYZTl74Ctko9c9XGKlzwBZoCPIXX71gbWa3Y9Ou2tN1xle
        h1KwBVTYAMeC6ZXXk6R1KQDbvytw3u6BGAUrThI5JwyqvnvIYtSn80B6SjGD0QmvSetWWS
        s7GND8pJdkB0+tCuEwbqKHVMF7LtmMGr0Ecj2me0fR8YejgsldVz4EydVN0f3nhIcfzoDT
        R4prtYHVnqTCuSF0DFfNf6xyY7+mSruczDkgDxarYk0TdEU+0B9/lefr2DhwwKrw25If0z
        qaCbqYZtPnw8770cPqLduqXjWVWbSrin8Ijpos9e14n6IvfKovkjEGFWZxksEQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDAA06000E;
        Tue,  4 Jul 2023 08:46:09 +0000 (UTC)
Date:   Tue, 4 Jul 2023 10:46:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, wenst@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/5] thermal/drivers/armada: convert to use
 devm_request_threaded_irq_emsg()
Message-ID: <20230704104608.29527ec3@xps-13>
In-Reply-To: <20230703090455.62101-3-frank.li@vivo.com>
References: <20230703090455.62101-1-frank.li@vivo.com>
        <20230703090455.62101-3-frank.li@vivo.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

frank.li@vivo.com wrote on Mon,  3 Jul 2023 17:04:51 +0800:

> There are more than 700 calls to the devm_request_threaded_irq method.
> Most drivers only request one interrupt resource, and these error
> messages are basically the same. If error messages are printed
> everywhere, more than 1000 lines of code can be saved by removing the
> msg in the driver.
>=20
> And tglx point out that:
>=20
>   If we actually look at the call sites of
>   devm_request_threaded_irq() then the vast majority of them print more or
>   less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
>=20
>      519 messages total (there are probably more)
>=20
>      352 unique messages
>=20
>      323 unique messages after lower casing
>=20
>          Those 323 are mostly just variants of the same patterns with
>          slight modifications in formatting and information provided.
>=20
>      186 of these messages do not deliver any useful information,
>          e.g. "no irq", "
>=20
>      The most useful one of all is: "could request wakeup irq: %d"
>=20
>   So there is certainly an argument to be made that this particular
>   function should print a well formatted and informative error message.
>=20
>   It's not a general allocator like kmalloc(). It's specialized and in the
>   vast majority of cases failing to request the interrupt causes the
>   device probe to fail. So having proper and consistent information why
>   the device cannot be used _is_ useful.
>=20
> Let's use devm_request_threaded_irq_emsg(), which ensure that all error
> handling branches print error information. In this way, when this function
> fails, the upper-layer functions can directly return an error code without
> missing debugging information. Otherwise, the error message will be
> printed redundantly or missing.
>=20
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/thermal/armada_thermal.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_th=
ermal.c
> index 9f6dc4fc9112..a5e140643f00 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -913,15 +913,12 @@ static int armada_thermal_probe(struct platform_dev=
ice *pdev)
> =20
>  	/* The overheat interrupt feature is not mandatory */
>  	if (irq > 0) {
> -		ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> -						armada_overheat_isr,
> -						armada_overheat_isr_thread,
> -						0, NULL, priv);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Cannot request threaded IRQ %d\n",
> -				irq);
> +		ret =3D devm_request_threaded_irq_emsg(&pdev->dev, irq,
> +						     armada_overheat_isr,
> +						     armada_overheat_isr_thread,
> +						     0, NULL, priv, NULL);
> +		if (ret)

I don't see a patch renaming this helper with s/emsg//, do you plan to
keep it like that? I bet nobody outside of this series will notice the
new helper and will continue to add error messages because it kind
of feels "right" to do so.

I would rather prefer returning to the original function name which
everybody knows/uses.

Anyhow, I'm fine with the idea of dropping custom error messages, so
whatever the final solution:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
