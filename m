Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC6A6773FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 03:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjAWCPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 21:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjAWCPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 21:15:20 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B2125A5;
        Sun, 22 Jan 2023 18:15:19 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z31so4648563pfw.4;
        Sun, 22 Jan 2023 18:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0w/FUIkADD3JU/Qgu7gJ7esBnA/a6+CuHcQ7odJBT2E=;
        b=koPFvxz/TDXpDpqDSe2U7h9ID67nkcYvuOcj6k1JEwOF6cBDzvflpjV2bFD2b5HZp0
         OmjNxLyj/SnsfBQRh6QX7ezaMzvb5qTJzDAjf9BVCtJAMC+0Vi0aFby3sCnbehfadaPg
         Cj99B4AmBxBWufATsdHQ+btkmMPmdvJL01amK/iYsuKxjol4UScY2WwW0ax9mAFpG1kX
         aP7klCZTj/PxOzg1cDIFOHq5kRO5/qjgksq9DXTY64Q35iL3MPvb4vgrDsCl+EDZTqFz
         yedgH4C29p5UFL57AIFXbtKbbLI16n39rv1JDNm2YtadjAe5NdgnjpIvcY/duuEHC2ko
         Yg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0w/FUIkADD3JU/Qgu7gJ7esBnA/a6+CuHcQ7odJBT2E=;
        b=wv7Kb2ai5FDheIqlgaELqejGm9WEr6cg8AjZZSAdfXF3TJq6ZQv4UMJ1TB/vEpEUJp
         Jeu+W8+SuJGye6t7Bp7yEx+jCuKBN0GuiOjbntMtEfQWvufet20AnErAFB0JAyadWJxT
         bD5g3CD8F/1ygAw7xS/muecIiFCFyffzDxPhHv5nZhv0xn46wBU9y3gEI2mOH+xPu9KU
         GZGomPqCyePZQuX9tfCEjE1l2v+M34UwIRBrm2zZF0tsrbbQAEQOmegAtb3ghshTr0ox
         dCcujykAvlgfJ9v0osJ5qpjCDsvBdw1sRuAR0mcuV1vyp1FOh1TLzX0zcyPKq4Pl31xV
         vkeg==
X-Gm-Message-State: AFqh2koLa3ZgLoTOEEww0s7SksI8bZAjQjWWkaCWR/ydVlnFGXuWlx2l
        QQhZhtgyhzMSmSsOVvNs2SezTERh8mht1eZs
X-Google-Smtp-Source: AMrXdXu/CAtoaI7Aq1tQzoXl1SrfgLHYWz6D2rifi/FZHTxVhLVY4SSf7SyyVjUWsLQwkTTEQ9mJgQ==
X-Received: by 2002:a62:640f:0:b0:581:f301:23fc with SMTP id y15-20020a62640f000000b00581f30123fcmr38872218pfb.12.1674440118966;
        Sun, 22 Jan 2023 18:15:18 -0800 (PST)
Received: from debian.me (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id k11-20020aa79d0b000000b00588fb6fafe0sm25431297pfp.188.2023.01.22.18.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 18:15:18 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 17573101C11; Mon, 23 Jan 2023 09:15:16 +0700 (WIB)
Date:   Mon, 23 Jan 2023 09:15:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Diederik de Haas <didi.debian@cknow.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: rv: Fix full name of the GPL
Message-ID: <Y83ts1TVZnwyZjnH@debian.me>
References: <20230122181224.53996-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+N+rLQO10Pw4nNOq"
Content-Disposition: inline
In-Reply-To: <20230122181224.53996-1-didi.debian@cknow.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+N+rLQO10Pw4nNOq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 22, 2023 at 07:12:23PM +0100, Diederik de Haas wrote:
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>  Documentation/tools/rv/common_appendix.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/tools/rv/common_appendix.rst b/Documentation/t=
ools/rv/common_appendix.rst
> index f4239192bee8..655e1bd9bbe4 100644
> --- a/Documentation/tools/rv/common_appendix.rst
> +++ b/Documentation/tools/rv/common_appendix.rst
> @@ -13,4 +13,4 @@ COPYING
>  =3D=3D=3D=3D=3D=3D=3D
> =20
>  Copyright \(C) 2022 Red Hat, Inc. Free use of this software is granted u=
nder
> -the terms of the GNU Public License (GPL).
> +the terms of the GNU General Public License (GPL).
=20
Similar response as [1].

Thanks.

[1]: https://lore.kernel.org/linux-doc/Y83tLoHnM496akUH@debian.me/

--=20
An old man doll... just what I always wanted! - Clara

--+N+rLQO10Pw4nNOq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY83tswAKCRD2uYlJVVFO
o77VAQCoYFJdqc+bj1pW+J0ywnUMgMZDyLOIZWSdDBQoyVwwPwD/eZ1ZHzdkT1ol
Tj7QvV0bR36l2ZZSQlxXnZ88ACALegg=
=Q7O0
-----END PGP SIGNATURE-----

--+N+rLQO10Pw4nNOq--
