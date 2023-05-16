Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEECB705948
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjEPVJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEPVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:09:18 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97326A7C;
        Tue, 16 May 2023 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1684271349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZotjqSno6mlnSCl5RmCgXDL7y9mTXfMTXPW1dTQHAV8=;
        b=kzi9D6d8/kUP+OHe+02DGcYjw1n+dLg+P+bihL2p4w9Bm0iBJpGxEb/xoh13bTboropQLZ
        ygJllG6vg94bilMDWjdq6r2OGvBBNEwDqsnGqbb0yPGXdL0O3BRncl5T1Xhdz3VgAJJwNw
        qUhI8paElVeY3NuHvSgdkK8Cp8S3BXk=
Message-ID: <7dc34b53bc464cdaae3aea75814625c60315f2ca.camel@crapouillou.net>
Subject: Re: [PATCH] mtd: rawnand: ingenic: fix empty stub helper definitions
From:   Paul Cercueil <paul@crapouillou.net>
To:     Arnd Bergmann <arnd@kernel.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 16 May 2023 23:09:07 +0200
In-Reply-To: <20230516202133.559488-1-arnd@kernel.org>
References: <20230516202133.559488-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 16 mai 2023 =C3=A0 22:21 +0200, Arnd Bergmann a =C3=A9crit=C2=A0:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> A few functions provide an empty interface definition when
> CONFIG_MTD_NAND_INGENIC_ECC is disabled, but they are accidentally
> defined as global functions in the header:
>=20
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:39:5: error: no previous
> prototype for 'ingenic_ecc_calculate'
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:46:5: error: no previous
> prototype for 'ingenic_ecc_correct'
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:53:6: error: no previous
> prototype for 'ingenic_ecc_release'
> drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:57:21: error: no previous
> prototype for 'of_ingenic_ecc_get'
>=20
> Turn them into 'static inline' definitions instead.
>=20
> Fixes: 15de8c6efd0e ("mtd: rawnand: ingenic: Separate top-level and
> SoC specific code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Good catch.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0drivers/mtd/nand/raw/ingenic/ingenic_ecc.h | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
> b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
> index 2cda439b5e11..017868f59f22 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
> @@ -36,25 +36,25 @@ int ingenic_ecc_correct(struct ingenic_ecc *ecc,
> =C2=A0void ingenic_ecc_release(struct ingenic_ecc *ecc);
> =C2=A0struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np);
> =C2=A0#else /* CONFIG_MTD_NAND_INGENIC_ECC */
> -int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
> +static inline int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct ingenic_ecc_params *params,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const u8 *buf, u8 *ecc_code)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> =C2=A0}
> =C2=A0
> -int ingenic_ecc_correct(struct ingenic_ecc *ecc,
> +static inline int ingenic_ecc_correct(struct ingenic_ecc *ecc,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
uct ingenic_ecc_params *params, u8 *buf,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 =
*ecc_code)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> =C2=A0}
> =C2=A0
> -void ingenic_ecc_release(struct ingenic_ecc *ecc)
> +static inline void ingenic_ecc_release(struct ingenic_ecc *ecc)
> =C2=A0{
> =C2=A0}
> =C2=A0
> -struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
> +static inline struct ingenic_ecc *of_ingenic_ecc_get(struct
> device_node *np)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-ENODEV);
> =C2=A0}

