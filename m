Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FFD6BE333
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCQIXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjCQIXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:23:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E11A5E4;
        Fri, 17 Mar 2023 01:22:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q189so2429925pga.9;
        Fri, 17 Mar 2023 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679041352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CvZiznDb8feEQFPyw13u7jzCgvHCPleXRdMTnsLV7lw=;
        b=C8TyryX7x0nOZ97prNCZujblQ48n0MKZf+xrMx4QaLu0I/EHiQXEr9P1ACNGDKEGMl
         AwaKjtQUhL2sK4kCKib3CImwYzmS8e+Ew83YM5u/6gghKH1lTImrrwiTnWoCSy42BVIk
         nfT0kyS9bwedBVEzkf9jffVgYxAktc2x4tLFUEDR+gr6QSRcIfrHCbqRELGn+UsgrljO
         VFsvNInVq0rQocz9c1jqHK/fiAhYib6Lf4T4mi0UxtvmqVm/2catXHsNRqlHB9qaKEkA
         E7BT0U359ir9fFvyLffQa3FuWq9IMF/7rPCHlDzavP8nVh0XdNEzLO7kfO4FBlzLIHAN
         qy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679041352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvZiznDb8feEQFPyw13u7jzCgvHCPleXRdMTnsLV7lw=;
        b=CjviwO4+vc8fGfOdGsE/NFTooJunLfsxAxL9/T/6McAXNfWALyiCJSKJuvos9UAxdv
         XmwiXFBKIzBCmnkVVZgbI5ZU2p/9jcavHKQehXMPFO7XVsYN8yIZ8XGhgAqAerx/BBGw
         XsKOY9RW1LjIZOfiPRQ98M96PP9zfSNs6thNwvsX3p/a3ubjtuDBNcxIFOPrZnUCPHHJ
         wgcoWrRlFxZaji8BHKMrdm/k/iv+Wy9BpweHbaYGEkTjmo2ki5Qnd+Frjwi3N19kTerl
         ku7eZnH/qgUdrr/fNAR0wPFypWbXDvF1YDmEJvT2QAXIdL88a1SKldC+5ddnqkUAzMED
         anRg==
X-Gm-Message-State: AO0yUKVWpYCw9T1i72nfaxyc3bVFSlC3Zs7Ac0OIS2/mLVssCQXSVoy3
        d/UEeDMgiOGkixtycO5y6ho=
X-Google-Smtp-Source: AK7set/FA59a7uWFIVnTi0ZBQn89n77yG+1RamBNmOtXukjVceklC42Q/lvsQUOox1U2EBkHEC24vg==
X-Received: by 2002:aa7:9830:0:b0:625:55e5:afe4 with SMTP id q16-20020aa79830000000b0062555e5afe4mr6021026pfl.26.1679041352007;
        Fri, 17 Mar 2023 01:22:32 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-2.three.co.id. [180.214.232.2])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b005d4360ed2bbsm964214pfm.197.2023.03.17.01.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 01:22:31 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9737C106581; Fri, 17 Mar 2023 15:22:28 +0700 (WIB)
Date:   Fri, 17 Mar 2023 15:22:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] ELF: document some de-facto PT_* ABI quirks
Message-ID: <ZBQjRLiXOwfmoIs+@debian.me>
References: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
 <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xx//7xiLGuGFtrC6"
Content-Disposition: inline
In-Reply-To: <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xx//7xiLGuGFtrC6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 07:34:11PM -0700, Randy Dunlap wrote:
> Hi,
>=20
> [adding linux-doc for other interested parties]

Unfortunately akpm had already applied this doc as 60b38b7cbb295d ("ELF:
document some de-facto PT_* ABI quirks") while it being reviewed and
doesn't have any consensus yet.

> And could the document have a title, like:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> ELF header usage in Linux
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

The current doc path is Documentation/ELF/ELF.rst, which means that
readers expect to find general info about the executable format, not
some sort of trivia/niche like this.

>=20
> (I just made that up. Feel free to change it. :)
>=20
> Also, the .rst file should be added to some chapter in the current
> documentation tree, such as under "Other documentation", so add this file=
 name
> to Documentation/staging/index.rst. In fact this file could live in
> Documentation/staging instead of in Documentation/ELF/ (IMO of course).

If there are more ELF docs there then a separate directory may be
warranted.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--xx//7xiLGuGFtrC6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZBQjPwAKCRD2uYlJVVFO
owcuAP4lDPdQVO6AVHUCej5SAiOUSoMlyrGjiEIDl26TaprLNgD+K4PvtF55ZbCc
XjJzxMW1l5SXOEdmoWt8jltxCwrvWAg=
=eLk5
-----END PGP SIGNATURE-----

--xx//7xiLGuGFtrC6--
