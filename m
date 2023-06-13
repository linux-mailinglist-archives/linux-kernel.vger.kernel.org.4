Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F6572DE47
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjFMJut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241659AbjFMJud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:50:33 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469D5AC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:50:28 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E82163F04B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686649824;
        bh=+S8RVn4cwZ2hxJXT/iwldZ/F9edrSEM7MNIbg+01La8=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=stDxZJwaqxmIEJPja6YSD3PdKc2m+MeNvs9z2wyIND12/fScDD1hvtexSYc7ZdbBq
         M0orxMZcgijfOIaNuZBRNeKZEfB87JIJ+vFzRFdoJ6OlwGfdsruAsHWZUayuU8MBgY
         Rd53phZmDRp5KItSZ6C+0MivEdzary6RGJf8rdp0ORuyA5iQPUiLIn6T6LBkrBHobp
         WKA7Pk5/2+6TmOkDWIIqXPR8aALPzU8fz1W+9bir/FHVpqrceMHSSi59YS13ldTYLy
         ZmW4LOWVlJWuyJQT4U0rXq7AYhUJ6Tdobb1ihtATU8YtMbbsKSwTtD1LU3O1wid8b0
         Yx09m/2p4pDQQ==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30fa3ea38bcso1382926f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686649821; x=1689241821;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+S8RVn4cwZ2hxJXT/iwldZ/F9edrSEM7MNIbg+01La8=;
        b=Basmd7Pq9lQ8tFw+hoJIK6xeWxBDBhL6Vt/32B00yg75k5i5v6BBH9NdagG1JUHxie
         QJPjeGI66EHnB7+D4aE18A6MDs0UsoDMpo6QJ6uxPaF/opB6QTtMHjEh3dHjzolKuKE/
         JeY9FJmqLzeCfPdz0DujgGPRy9xYi1weMKnRnJJrzv0reMmtpfAjvbfMM6vuEBdL9mRE
         HlfJRgvTmQBbl15OwHgoKvDrx0Ndzb+IHP5WdIlvcxG7R/LRj/5DWs5COn4motBtd1Wc
         4W0xc3W12Sn7cA7EBCg8xj3LSjKeY2zbj35DsIFqnSOa5ZHL2zBCqmU7rGr3tKJnefUk
         TSUg==
X-Gm-Message-State: AC+VfDx1IlBRIKoKnj4nH4tdZ8xoBGAcCcP1VOlcCJ61V68YXIPVnKLc
        aNBMnby5OGBWVe9S4X7XM6DsXn7IE4dX0oOTakA3JHHfCToXtfvpaS3d/pCPwYxIcrGCPrE+wKa
        XRVdrYD3lwYaMml+x0pM8zHl5pcKbPjc89GBdmXdq9A==
X-Received: by 2002:adf:f5d1:0:b0:30a:e973:b182 with SMTP id k17-20020adff5d1000000b0030ae973b182mr5621215wrp.1.1686649821374;
        Tue, 13 Jun 2023 02:50:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qsylu7h96z/YokKVYhvI775gxBdTlvE0mtDesHac9WjQrm8pjsK7JHPCjjoGLyNjMF04RdA==
X-Received: by 2002:adf:f5d1:0:b0:30a:e973:b182 with SMTP id k17-20020adff5d1000000b0030ae973b182mr5621204wrp.1.1686649821059;
        Tue, 13 Jun 2023 02:50:21 -0700 (PDT)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b0030fa3567541sm11795106wro.48.2023.06.13.02.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 02:50:20 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:50:18 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     juerg.haefliger@canonical.com
Cc:     gregkh@linuxfoundation.org, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, martin.blumenstingl@googlemail.com,
        mchehab@kernel.org, narmstrong@baylibre.com
Subject: Re: [PATCH v2 resend] media: meson: vdec: Add MODULE_FIRMWARE macro
Message-ID: <20230613115018.562c843f@gollum>
In-Reply-To: <20230126153258.1558471-1-juerg.haefliger@canonical.com>
References: <20220818064810.17856-1-juerg.haefliger@canonical.com>
        <20230126153258.1558471-1-juerg.haefliger@canonical.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ghcr7VuYGJ=w+H+lw1iLJue";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ghcr7VuYGJ=w+H+lw1iLJue
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Ping


> The meson-vdec module loads firmware so add MODULE_FIRMWARE macros to
> provide that information via modinfo.
>=20
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>=20
> ---
> v2:
>   - Drop duplicates
>   - Add Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/staging/media/meson/vdec/vdec_platform.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/staging/media/meson/vdec/vdec_platform.c b/drivers/s=
taging/media/meson/vdec/vdec_platform.c
> index 88c9d72e1c83..70c9fd7c8bc5 100644
> --- a/drivers/staging/media/meson/vdec/vdec_platform.c
> +++ b/drivers/staging/media/meson/vdec/vdec_platform.c
> @@ -280,3 +280,12 @@ const struct vdec_platform vdec_platform_sm1 =3D {
>  	.num_formats =3D ARRAY_SIZE(vdec_formats_sm1),
>  	.revision =3D VDEC_REVISION_SM1,
>  };
> +
> +MODULE_FIRMWARE("meson/vdec/g12a_h264.bin");
> +MODULE_FIRMWARE("meson/vdec/g12a_vp9.bin");
> +MODULE_FIRMWARE("meson/vdec/gxbb_h264.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_h264.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_vp9.bin");
> +MODULE_FIRMWARE("meson/vdec/gxm_h264.bin");
> +MODULE_FIRMWARE("meson/vdec/sm1_vp9_mmu.bin");


--Sig_/ghcr7VuYGJ=w+H+lw1iLJue
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmSIO9oACgkQD9OLCQum
QrcQVA//Xnyo7NgEIg7RU1068vZ3jYv79u7ET2NDlEqPLkXRGNpC09DHkjFbVsh6
pIKGdGT27w2eN7UoOueSXoX3UMr5ZMXVdfh/zsQSmfb7Jxm1cAujfJwiBLwtnGZz
J2IBevnvVy8BddBMtAlxcR1cVWj0H5SZWoO2rYGQWJ3udpA0l7kb2taZndeUNs4i
Pklfe4w7FsgFWoIAyG67C3prc9LQh657mYzLvdWWNfnhhFGmy/SvXXWaLMKraboF
u97X7QT92k8dOn08zUwCGfzFePuFUidcSFQMrf0hf1hCWSzxYMP1ELWqJNBnqo4l
pt4ivVVr2RarOXRpnJfM8+sCjVcJh3HNsW5zZp0nACBUQ2dLarBvf8Zwmo59oQC6
e2VjXIrLImN03fz+rlFG4w+Y12fRJq0tDNoCoAcksZx361ppaAWgjyU414hDpXjp
WNIcZXhEwpgqqUCHpb8Os9q3y6LbMy45ybhoxhpf3HkvZ2QgUdOEZkDtk90GHPxY
5ApOAm9Z1fZdD/wv+3JIMu7GZ41+F12cT6fnt9Xk1shNv9kqOFVlLy1r1il92wZ9
kqLfQBqg1PU9aBRJ+331N+ILCDxM3L/NV5pAftDB+oI9oB3x872Ap+Kk/4K5zMjz
B/yf3x6QDrX8eJKRmcOYR93LIgb5vMquSlhJ18eoWhimhazb5qc=
=sYn1
-----END PGP SIGNATURE-----

--Sig_/ghcr7VuYGJ=w+H+lw1iLJue--
