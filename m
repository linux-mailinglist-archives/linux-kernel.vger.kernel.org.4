Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9695D6D3FB9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjDCJJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCJJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:09:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688057D80;
        Mon,  3 Apr 2023 02:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12E0AB8160F;
        Mon,  3 Apr 2023 09:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B170C433D2;
        Mon,  3 Apr 2023 09:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680512958;
        bh=5Z3JKHk5FHuPEkQfx8RtRlEsG+NvUUF3lgarLGMZR/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oVBa5zJMtx5Y8+fYzXaa5e/apRgaxMEoTLhM9FBr4mN3TeC4MMp9XcdrnpiMfojsf
         jdJEL3Z6c/2J4VQW7TphiKPhh7ly2b1Z4SFyeWrmhmkxDTg/5JpkZuIH5KecfGMs11
         iR0mcLjpylhGPWGYOtvoVNVKdg5vvFQuwlLHXEaYfDHoRNwFpNl5DskFIdnqBZsm1S
         AOMdYHiOXWbxmBfrovICW7IN5XmCv3fdSH4VDVtsML8jtEWDWNaS8ChA7H8UG63ZJ4
         zrTI2EZ6EVzFMAUSDL2hvJOgdpHpxOi7r7H+W52DjzVXziYhtYhgDG50ggBVO7iAgW
         O0sjiVn4WhPvg==
Date:   Mon, 3 Apr 2023 11:09:14 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, NeilBrown <neilb@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] leds: tca6507: fix error handling of using
 fwnode_property_read_string
Message-ID: <20230403110914.6106602e@dellmb>
In-Reply-To: <cbae7617db83113de726fcc423a805ebaa1bfca6.1680433978.git.hns@goldelico.com>
References: <cbae7617db83113de726fcc423a805ebaa1bfca6.1680433978.git.hns@goldelico.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  2 Apr 2023 13:12:59 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Commit 96f524105b9c ("leds: tca6507: use fwnode API instead of OF")
>=20
> changed to fwnode API but did not take into account that a missing proper=
ty
> "linux,default-trigger" now seems to return an error and as a side effect
> sets value to -1. This seems to be different from of_get_property() which
> always returned NULL in any case of error.
>=20
> Neglecting this side-effect leads to
>=20
> [   11.201965] Unable to handle kernel paging request at virtual address =
ffffffff when read
>=20
> in the strcmp() of led_trigger_set_default() if there is no led-trigger
> defined in the DTS.
>=20
> I don't know if this was recently introduced somewhere in the fwnode lib
> or if the effect was missed in initial testing. Anyways it seems to be a
> bug to ignore the error return value of an optional value here in the
> driver.
>=20
> Fixes: 96f524105b9c ("leds: tca6507: use fwnode API instead of OF")
> Cc: Marek Beh=C3=BAn <kabel@kernel.org>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/leds/leds-tca6507.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
> index 07dd12686a696..634cabd5bb796 100644
> --- a/drivers/leds/leds-tca6507.c
> +++ b/drivers/leds/leds-tca6507.c
> @@ -691,8 +691,9 @@ tca6507_led_dt_init(struct device *dev)
>  		if (fwnode_property_read_string(child, "label", &led.name))
>  			led.name =3D fwnode_get_name(child);
> =20
> -		fwnode_property_read_string(child, "linux,default-trigger",
> -					    &led.default_trigger);
> +		if (fwnode_property_read_string(child, "linux,default-trigger",
> +						&led.default_trigger))
> +			led.default_trigger =3D NULL;
> =20
>  		led.flags =3D 0;
>  		if (fwnode_device_is_compatible(child, "gpio"))

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
