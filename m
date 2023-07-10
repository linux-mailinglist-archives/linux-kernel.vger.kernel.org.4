Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1757F74D10F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGJJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGJJKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:10:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F56FEB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:09:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b9d80e33fbso5621555ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688980199; x=1691572199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfziryGEywF1OCFAiRrD5HH2CawNQQd/yh4CzyASrxI=;
        b=EgnRXmIty3Veat9BxmT9s9PzIR26yGSc64PHjsJASW6rQkjDt6h6hF6dFNdPEL6Nt4
         PUT0zti06eDX6hNIbbMG/t6j3cpQBB1RBa8+w18HTM904n9b+ueSlinzNk0MtsoG8+oz
         dLQk3zFQTzQaXt6W+/yDX0add7uJCFrqJirKxFpXM3dhQ3jpmshjbjruAZ4SOuuujXaF
         lCkjeuiAwSs3Ebu3Ya3oj5RwWphbVmTerT/FkoDqWeTTTorZy1PMc8NMKXMPur7dzvig
         oUGnp5EJBFTJyQv8Fywqlmmpt6Z43QAsdsq/8J//KV/53/E6RuYZHW08OlipX40ilE1F
         vhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688980199; x=1691572199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfziryGEywF1OCFAiRrD5HH2CawNQQd/yh4CzyASrxI=;
        b=QDC78KtuTuexK2jrwcWUdz0qkkTMQVc/jTBPCIMH5ubzPWJLhDkQ+5Fb+2ZZCz8MC3
         yrQ8I2UFbNereJg86Ks2+sHz+6LOnAI7SYsT7HFRIwDiwtpES2+UdMciebGsuztiXT/F
         z+QwyJEkhFx6fXvnM+NNStWN/NUqRF08EYRJ+OK2WyV33jQx3J8pKSpbKiQVxaPdXjNs
         gbDJ4HTiz53GDJJXFMtBWfm7x0qWzJTrcmJzGR+W2Wplnbs27LkqkogHlmMGvaBI2X1U
         eBo+t/gHY7fyRA0gg1w7KbsOwTmWRoMndbZ6e6zhwB3Xx8XN0oEJ9t0z/tZpx+pyhf8t
         hZvQ==
X-Gm-Message-State: ABy/qLZCjGxDnsQoeHY8PRUmNF+TWw6F1iWjM//7H4R3nEy1zmPccFrU
        LGHI+aYy84PsS+d3IyuDlQ0=
X-Google-Smtp-Source: APBJJlECPiX2JObsb+RjoZmVK9i5eoWA4utCjAYXj24Z5oVB1RCRjZJ3hDpsi5MIPpxKT6wRYYOytQ==
X-Received: by 2002:a17:902:c409:b0:1b8:28f6:20e6 with SMTP id k9-20020a170902c40900b001b828f620e6mr13600129plk.34.1688980198740;
        Mon, 10 Jul 2023 02:09:58 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902ea0c00b001b9df8f14d7sm1822852plg.267.2023.07.10.02.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:09:57 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id AF9DF91C4E4C; Mon, 10 Jul 2023 16:09:52 +0700 (WIB)
Date:   Mon, 10 Jul 2023 16:09:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     sunran001@208suo.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/iccsense:
Message-ID: <ZKvK4NXzkKZTE35E@debian.me>
References: <20230710070505.53916-1-xujianghui@cdjrlc.com>
 <1ddf673283e93e83d912066f2241b976@208suo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sesJufGAkiPhMEHr"
Content-Disposition: inline
In-Reply-To: <1ddf673283e93e83d912066f2241b976@208suo.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sesJufGAkiPhMEHr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 03:06:47PM +0800, sunran001@208suo.com wrote:
> Fixed error: 'do not use assignment in if condition'
>=20
> This patch fixes error: 'do not use assignment in if condition'
> in drm/nouveau/iccsense

I guess this is checkpatch fix, right?

>=20
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> index 8f0ccd3664eb..2428f3d6e477 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> @@ -322,7 +322,8 @@ int
>  nvkm_iccsense_new_(struct nvkm_device *device, enum nvkm_subdev_type typ=
e,
> int inst,
>             struct nvkm_iccsense **iccsense)
>  {
> -    if (!(*iccsense =3D kzalloc(sizeof(**iccsense), GFP_KERNEL)))
> +    *iccsense =3D kzalloc(sizeof(**iccsense), GFP_KERNEL);
> +    if (!*iccsense)
>          return -ENOMEM;
>      INIT_LIST_HEAD(&(*iccsense)->sensors);
>      INIT_LIST_HEAD(&(*iccsense)->rails);

Your patch is corrupted (tabs converted to spaces) because you're using
Roundcube. Please use git-send-mail(1) instead.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--sesJufGAkiPhMEHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZKvK2QAKCRD2uYlJVVFO
o30SAQCBQ0XJUZtYK5k23vpkl8YQStJLMGNiuEo8Wulk+Ne03QEAkGbjMCU8DRCz
Ohcbe1uBj+CW/b2kAyogZavYb8WBBAE=
=5wr9
-----END PGP SIGNATURE-----

--sesJufGAkiPhMEHr--
