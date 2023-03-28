Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16206CBFFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjC1M7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjC1M7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:59:11 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB009EC6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:58:53 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2872240014;
        Tue, 28 Mar 2023 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680008331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaraH5Y77gs5q9fjwC2tIxEic4YCl0W2OFuwmvWv0mc=;
        b=dsXuhsKyObeBblYlxHAMlTqFDwoZAoeu4ltY0Ows9OgexMiHB24FGwxidITC62ZsxiwCoF
        WeOEgXBdJ9A0957X9ZDsrsTwXuN5vnZ4ndccXSTVyagOw9zhhENPVAJuyoxvOhTxXvj2wZ
        dNqGAig/kWxcWMgzgaNAWz5A9exTAvHxFq6ilpwObe+CsC1Zi5gmQE778spJIQshqGQmgo
        dFpw07/xcCXEkd8sb4ltR2Gz9jOKiarTALJzTIkGDMjnp9KmJtoY4SBrBWG4e7UUKJyBs8
        aYXR8vp9vJBflmbr2qmfXSWy36RdAEj4J22Wbm2W54+YFbF4Xg5lbDpYzy6Hvg==
Date:   Tue, 28 Mar 2023 14:58:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bang Li <libang.linuxer@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtdblock: tolerate corrected bit-flips
Message-ID: <20230328145848.5c7e4f14@xps-13>
In-Reply-To: <20230323140350.69908-1-libang.linuxer@gmail.com>
References: <20230323140350.69908-1-libang.linuxer@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

libang.linuxer@gmail.com wrote on Thu, 23 Mar 2023 22:03:50 +0800:

> mtd_read() may return -EUCLEAN in case of corrected bit-flips.This
> particular condition should not be treated like an error.

I'm fine with the patch, Richard, are you okay as well?

> Signed-off-by: Bang Li <libang.linuxer@gmail.com>
> ---
>  drivers/mtd/mtdblock.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
> index 1e94e7d10b8b..a0a1194dc1d9 100644
> --- a/drivers/mtd/mtdblock.c
> +++ b/drivers/mtd/mtdblock.c
> @@ -153,7 +153,7 @@ static int do_cached_write (struct mtdblk_dev *mtdblk=
, unsigned long pos,
>  				mtdblk->cache_state =3D STATE_EMPTY;
>  				ret =3D mtd_read(mtd, sect_start, sect_size,
>  					       &retlen, mtdblk->cache_data);
> -				if (ret)
> +				if (ret && !mtd_is_bitflip(ret))
>  					return ret;
>  				if (retlen !=3D sect_size)
>  					return -EIO;
> @@ -188,8 +188,12 @@ static int do_cached_read (struct mtdblk_dev *mtdblk=
, unsigned long pos,
>  	pr_debug("mtdblock: read on \"%s\" at 0x%lx, size 0x%x\n",
>  			mtd->name, pos, len);
> =20
> -	if (!sect_size)
> -		return mtd_read(mtd, pos, len, &retlen, buf);
> +	if (!sect_size) {
> +		ret =3D mtd_read(mtd, pos, len, &retlen, buf);
> +		if (ret && !mtd_is_bitflip(ret))
> +			return ret;
> +		return 0;
> +	}
> =20
>  	while (len > 0) {
>  		unsigned long sect_start =3D (pos/sect_size)*sect_size;
> @@ -209,7 +213,7 @@ static int do_cached_read (struct mtdblk_dev *mtdblk,=
 unsigned long pos,
>  			memcpy (buf, mtdblk->cache_data + offset, size);
>  		} else {
>  			ret =3D mtd_read(mtd, pos, size, &retlen, buf);
> -			if (ret)
> +			if (ret && !mtd_is_bitflip(ret))
>  				return ret;
>  			if (retlen !=3D size)
>  				return -EIO;


Thanks,
Miqu=C3=A8l
