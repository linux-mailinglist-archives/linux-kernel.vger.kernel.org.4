Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E9070B7A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjEVIbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEVIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:30:59 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DF107
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:29:58 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6680A1BF216;
        Mon, 22 May 2023 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684744197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5Fe74h5JTNsqGr8I0pihoWU3MQrRGJcpIZ7H5+Yuaw=;
        b=a8a4j4Clxo8d5bzikhJNekIR81/QiEf//S8c/8AmZB6aQokS0b8929x+y91azAmh5XfwvZ
        f3RlZcqPlv/ikgmwXlenr/lzRTdukZD4ZAkpR3s0YYn4fsSvMdCW4pKdFUxfwy4LnheIMG
        uOB+oS8lZTSGn09/jDUf+znTBJgsIE23Xxf2hDxlpko0+ulyFgi8mOa6LskWvTOOVULL2M
        dAnzBhi/H+9UEjtpkv+fq91qe+WnntNkHvxOJa2j0anFyIvLEGi6CzYpVQEtqJ+K5n32gT
        B0nr3CkhV/71lnXQ6RO/jnQqcp4V0NqfEE3Xd79lqBSKe3llkhYpHXD4FGXRZQ==
Date:   Mon, 22 May 2023 10:29:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     richard@nod.at, todd.e.brandt@intel.com, vigneshr@ti.com,
        pratyush@kernel.org, michael@walle.cc,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, bagasdotme@gmail.com,
        regressions@lists.linux.dev, joneslee@google.com,
        Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix divide by zero for spi-nor-generic
 flashes
Message-ID: <20230522102953.2fdf2b02@xps-13>
In-Reply-To: <20230518085440.2363676-1-tudor.ambarus@linaro.org>
References: <20230518085440.2363676-1-tudor.ambarus@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

tudor.ambarus@linaro.org wrote on Thu, 18 May 2023 08:54:40 +0000:

> We failed to initialize n_banks for spi-nor-generic flashes, which
> caused a devide by zero when computing the bank_size.
>=20
> By default we consider that all chips have a single bank. Initialize
> the default number of banks for spi-nor-generic flashes. Even if the
> bug is fixed with this simple initialization, check the n_banks value
> before dividing so that we make sure this kind of bug won't occur again
> if some other struct instance is created uninitialized.
>=20
> Suggested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217448
> Fixes: 9d6c5d64f028 ("mtd: spi-nor: Introduce the concept of bank")
> Link: https://lore.kernel.org/all/20230516225108.29194-1-todd.e.brandt@in=
tel.com/
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi-nor/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 0bb0ad14a2fc..5f29fac8669a 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2018,6 +2018,7 @@ static const struct spi_nor_manufacturer *manufactu=
rers[] =3D {
> =20
>  static const struct flash_info spi_nor_generic_flash =3D {
>  	.name =3D "spi-nor-generic",
> +	.n_banks =3D 1,

I definitely missed that structure.

>  	/*
>  	 * JESD216 rev A doesn't specify the page size, therefore we need a
>  	 * sane default.
> @@ -2921,7 +2922,8 @@ static void spi_nor_late_init_params(struct spi_nor=
 *nor)
>  	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
>  		spi_nor_init_default_locking_ops(nor);
> =20
> -	nor->params->bank_size =3D div64_u64(nor->params->size, nor->info->n_ba=
nks);
> +	if (nor->info->n_banks > 1)
> +		params->bank_size =3D div64_u64(params->size, nor->info->n_banks);

I'm fine with the check as it is written because it also look like an
optimization, but bank_size should never be 0 otherwise it's a real bug
that must be catch and fixed. We do not want uninitialized bank_size's.

>  }
> =20
>  /**
> @@ -2987,6 +2989,7 @@ static void spi_nor_init_default_params(struct spi_=
nor *nor)
>  	/* Set SPI NOR sizes. */
>  	params->writesize =3D 1;
>  	params->size =3D (u64)info->sector_size * info->n_sectors;
> +	params->bank_size =3D params->size;
>  	params->page_size =3D info->page_size;

We actually discarded that line in a previous discussion:
https://lore.kernel.org/linux-mtd/20230331194620.839899-1-miquel.raynal@boo=
tlin.com/T/#mcb4f90f7ca48ffe3d9838b2ac6f74e44460c51bd

I'm fine to re-add it though, it does not hurt.

> =20
>  	if (!(info->flags & SPI_NOR_NO_FR)) {

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
