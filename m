Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740D66F02B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbjD0IlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243120AbjD0Iky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:40:54 -0400
X-Greylist: delayed 605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 01:40:48 PDT
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81F8F4ED4;
        Thu, 27 Apr 2023 01:40:48 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id 447661086A7;
        Thu, 27 Apr 2023 10:30:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C_QRgtPax6JY; Thu, 27 Apr 2023 10:29:55 +0200 (CEST)
Received: from localhost (softwrestling.org [95.216.36.37])
        by vm3.sequanux.org (Postfix) with ESMTPSA id 94A861080D6;
        Thu, 27 Apr 2023 10:29:55 +0200 (CEST)
Date:   Thu, 27 Apr 2023 10:29:41 +0200
From:   Simon Guinot <simon.guinot@sequanux.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>
Subject: Re: [PATCH 1/1] gpio-f7188x: fix pin count on nct6116d bank 7
Message-ID: <ZEoydXMDRONgbhY8@76cbfcf04d45>
References: <20230425153911.32135-1-henning.schild@siemens.com>
 <20230425153911.32135-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lk7i3m2T2NkJgXE3"
Content-Disposition: inline
In-Reply-To: <20230425153911.32135-2-henning.schild@siemens.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Lk7i3m2T2NkJgXE3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Tue, Apr 25, 2023 at 05:39:11PM +0200, Henning Schild wrote:
> The count was wrong because i looked at the wrong spec for the chip in
> question. I now got access to the spec for that very chip and group7 has
> all 8 pins, just like the other groups.

Did you use the NCT6102D / NCT6106D datasheet in a first place ?

If the only difference with NCT6116D is the number of pins on port
GPIO-7, then maybe we should handle it and claim support for this models
as well ?

Simon
=20
>=20
> Fixes: d0918a84aff0 ("gpio-f7188x: Add GPIO support for Nuvoton NCT6116")
> Reported-by: Xing Tong Wu <xingtong.wu@siemens.com>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/gpio/gpio-f7188x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index 9effa7769bef..05c0edc4778f 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -282,7 +282,7 @@ static struct f7188x_gpio_bank nct6116d_gpio_bank[] =
=3D {
>  	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
>  	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
>  	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
> -	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
> +	F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
>  };
> =20
>  static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned of=
fset)
> --=20
> 2.39.2

--Lk7i3m2T2NkJgXE3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmRKMnEACgkQzyg/RDPm
szpmnBAAjOLLHaY/XpmFwJofHE0dYlcMU1TvJLrzVYngBLOXgJC1ItKIoinIdxqq
ZT7M8iuEpH8/gJ0jcwWIOfnoZU0A4CF7CEeedW1c3ofrsOLipdrl4cdrQrO4+M0p
WC1Kg+az2/Bi1IuYDzRZ1bcQFM3K6mJHOyFUFUjpPPabnPLpevBEx6t8mvBMu1J1
HeZN9Qvd9NNIKJw7osVAT39Azg7hoL+JRp2huGII0U0/4RnLwEFf4RfFc4cj9JBa
tkYckAThgn6YCLhHl+GO/vrvtiIsJ07//I4LRKFPYOPF1O9fyXc3v9zJqVZLzk5T
I962a+OIXC0nVyoHiRwfjMr5yZkSl0Zzjy8V+u3/YnWuxmNcaIFBY0YViIiS5jjJ
q3lXewtwQlnEIti9/6qQN1wKWr54lBLtTu4/IPVbDzrbHQyz9Q9+4qfs3idyKwL1
jtQV5A1OnM2HDADW43qskGkQkdnC23zLC0TXk2L2S3K8twZ6SDcDjmwbxEbACZDS
RyXu/DJIAJLAQEzWpfiHLPvcCe9C4yhS8zbvn4LLcs1lhwUWEJMLmrSE7NFTUmZq
k6AXUsi/OMcN4cxOPwO5uzCRumm3EdklK4urSZp4FcKb6VGGmvgb9C07XnDx2M/V
ay4WxrO0zySq8riy+0c9IA+Mp3zH4qqP7FX6NQb6IkEEkAiWgiU=
=fkZu
-----END PGP SIGNATURE-----

--Lk7i3m2T2NkJgXE3--
