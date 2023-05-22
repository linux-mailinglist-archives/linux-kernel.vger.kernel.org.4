Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132AD70B968
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjEVJv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjEVJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:51:13 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479BA12B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:51:01 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8BF8EFF806;
        Mon, 22 May 2023 09:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684749059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kgR+kx+E0h6xq8/SEAddPn5xEBZ+n4iSnzTGkQdqPCU=;
        b=QREtmBvMDa3AjoLPdCnHG4flZ2Jonaih9xj1Rwxy3w1npB0GOG8OoOnC+4/6LJPX0EjzfK
        Pd67+4Xpm2MXyiV7Tb63FVWFPGEHr0dhzAIQo2cj7jbq8TTZM2WhW0Dv6nhwyU+vxuMsIp
        oYKJd0nL+EtUcjfmVNcxTCegLV8OU9GUSGlw3YphLXganZGh0iIMAkbx0bKnWtXGStwMOr
        hpd9+RE6gfNvUUrnJrmDEqcr2SAhnljIUKdFN8+zJ55U0S2EBVOhGDuY9RY6aL3NyJ6A4L
        YwxbXidCbdbX387eoZzFDOp04bnhhSgw9jiT8gfhQEEz7JNtXi3tBFpXnBVHGg==
Date:   Mon, 22 May 2023 11:50:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>, richard@nod.at,
        todd.e.brandt@intel.com, vigneshr@ti.com, pratyush@kernel.org,
        michael@walle.cc, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, regressions@lists.linux.dev,
        joneslee@google.com, Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix divide by zero for spi-nor-generic
 flashes
Message-ID: <20230522115056.5fefd73f@xps-13>
In-Reply-To: <e7d682f3-c1a3-6ddb-5854-8e814dd66333@redhat.com>
References: <20230518085440.2363676-1-tudor.ambarus@linaro.org>
        <20230522102953.2fdf2b02@xps-13>
        <0c8a54ae-7f32-2614-9717-a00fe561513e@linaro.org>
        <e7d682f3-c1a3-6ddb-5854-8e814dd66333@redhat.com>
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

Hello,

hdegoede@redhat.com wrote on Mon, 22 May 2023 11:34:55 +0200:

> Hi,
>=20
> On 5/22/23 11:22, Tudor Ambarus wrote:
> >=20
> >=20
> > On 5/22/23 09:29, Miquel Raynal wrote: =20
> >> Hi Tudor, =20
> >=20
> > Hi, Miquel,
> >  =20
> >>
> >> tudor.ambarus@linaro.org wrote on Thu, 18 May 2023 08:54:40 +0000:
> >> =20
> >>> We failed to initialize n_banks for spi-nor-generic flashes, which
> >>> caused a devide by zero when computing the bank_size.
> >>>
> >>> By default we consider that all chips have a single bank. Initialize
> >>> the default number of banks for spi-nor-generic flashes. Even if the
> >>> bug is fixed with this simple initialization, check the n_banks value
> >>> before dividing so that we make sure this kind of bug won't occur aga=
in
> >>> if some other struct instance is created uninitialized.
> >>>
> >>> Suggested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> >>> Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> >>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217448
> >>> Fixes: 9d6c5d64f028 ("mtd: spi-nor: Introduce the concept of bank")
> >>> Link: https://lore.kernel.org/all/20230516225108.29194-1-todd.e.brand=
t@intel.com/
> >>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >>> ---
> >>>  drivers/mtd/spi-nor/core.c | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >>> index 0bb0ad14a2fc..5f29fac8669a 100644
> >>> --- a/drivers/mtd/spi-nor/core.c
> >>> +++ b/drivers/mtd/spi-nor/core.c
> >>> @@ -2018,6 +2018,7 @@ static const struct spi_nor_manufacturer *manuf=
acturers[] =3D {
> >>> =20
> >>>  static const struct flash_info spi_nor_generic_flash =3D {
> >>>  	.name =3D "spi-nor-generic",
> >>> +	.n_banks =3D 1, =20
> >>
> >> I definitely missed that structure.
> >> =20
> >>>  	/*
> >>>  	 * JESD216 rev A doesn't specify the page size, therefore we need a
> >>>  	 * sane default.
> >>> @@ -2921,7 +2922,8 @@ static void spi_nor_late_init_params(struct spi=
_nor *nor)
> >>>  	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
> >>>  		spi_nor_init_default_locking_ops(nor);
> >>> =20
> >>> -	nor->params->bank_size =3D div64_u64(nor->params->size, nor->info->=
n_banks);
> >>> +	if (nor->info->n_banks > 1)
> >>> +		params->bank_size =3D div64_u64(params->size, nor->info->n_banks);=
 =20
> >>
> >> I'm fine with the check as it is written because it also look like an
> >> optimization, but bank_size should never be 0 otherwise it's a real bu=
g =20
> >=20
> > bank_size was introduced just for chips featuring several banks, but we
> > made this field mandatory for all flashes, regardless of their type. I
> > find this restriction unnecessary, because we can differentiate the RWW
> > flashes by checking the SNOR_F_RWW flag. So the alternative to this
> > patch is to remove the n_banks restriction and set it just for the RWW
> > flashes. I think I prefer this, but keep in mind that I never read a RWW
> > flash's datasheet, not publicly available, so the decision is in your
> > court. Happy to make a patch. =20
>=20
> Since this is causing a serious regression causing people's laptops to ha=
ng
> on suspend I believe it would be best to queue up the simplest fix for
> this (which seems to be this patch as is) for 6.4 asap.
>=20
> Any more involved changes to fix this in a better way can then be added
> on top for the 6.5 cycle.

Absolutely. I actually am totally fine with the current state, I
believe expecting all flashes to have one bank is sane, that's why I
took this path in the first place. But this can be changed later
anyway.

Thanks,
Miqu=C3=A8l
