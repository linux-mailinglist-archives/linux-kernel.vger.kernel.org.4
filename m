Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E446C923F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 05:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCZDim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 23:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCZDik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 23:38:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BC349C4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 20:38:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id kc4so5492649plb.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 20:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679801917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QABbW2XBVz0RHFY7jQaR4WR5+U+GoXdriZENBnOcHlg=;
        b=AADv8WbEYrOp9Cu0upuT29E7QKosKEdJpb9COQNqqPdx6Sz7lmsXPEuUX9buGC9oVg
         E7iAhoDxdsC+mThvCgoVZUYRnaV+Q4Ms6qJtTsDIPuRVs2ecYNE6HfeMJ1ujexiIF3YU
         GtNh3HTfiILV4CckpagX0XVCFKkDKetjmCjaJAULiMH8gM9tLF9iMeKvQPZKr4yLlhFM
         dx7zXhKoHfG2fHKJq/WrFqXrej07lbUOdPGO2WL94q9CY/9BVyiL9FqHNE7qcqwrAJBa
         XfOKylyUBYDsKcKHuMxMr1yoiQU2JFLdLIJAeVEzK41+Tz/64GgRYVrifrz7OPsLVJEG
         cg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679801917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QABbW2XBVz0RHFY7jQaR4WR5+U+GoXdriZENBnOcHlg=;
        b=5jvVc07BCUYat4z9FopfSezkE9ji2DS9+s88ffFpem4pXKUodmlL4fKng9FA7we/Z6
         z8lgFVZtUzFDvvZZ0Y3WLy1P5jAK+/pPF4XdW8Bwmh80XPLmuRcVoBCpFAa6m2cuZTsl
         B8bs73I5nx1Z4H9RDWIW/mThksIQ8HpKz9oEWAzuD1WD5/8O52dd0Cj/TJiUFwdAe6MC
         pBgm28k+drxC8bwggCG3z8MYLETC44sPYNmVEbF8UVAUy5E8NVCp7JC9h1+RawTO0bjP
         6/0elf1Uhm9bbQkzoCbC/TbDHcaJ7nEDgqE+EvSa/GtypR+mhwmOvRrIzLJz4GrZIIlL
         4s1w==
X-Gm-Message-State: AAQBX9czBisDg1vptSToLOjdud8rk4Jla6Mhk/HmTfwKhDqraq7XIDZ+
        xZ5rLc93z47rEIW/HIOnK8E=
X-Google-Smtp-Source: AKy350blIotmf+4cPBlMS8pFxbbhZuE8pRycvOMqGaQsOjyLz61lGlbugvKEWRMsU3BF8S48i0wISQ==
X-Received: by 2002:a17:903:4306:b0:1a1:98a9:4069 with SMTP id jz6-20020a170903430600b001a198a94069mr6384255plb.9.1679801917187;
        Sat, 25 Mar 2023 20:38:37 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-69.three.co.id. [180.214.233.69])
        by smtp.gmail.com with ESMTPSA id jk23-20020a170903331700b001a19bde435fsm16706959plb.65.2023.03.25.20.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 20:38:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8E625106510; Sun, 26 Mar 2023 10:38:32 +0700 (WIB)
Date:   Sun, 26 Mar 2023 10:38:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Traian Teodorescu <traian.teodorescu@bluewin.ch>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: Fwd: Fwd: Linux entropy
Message-ID: <ZB++OBSuwLom3e9M@debian.me>
References: <fbf48030-c702-8964-7614-365bbcb4faee@bluewin.ch>
 <3dc7e744-dcfd-8da3-ed73-8f222d68031c@bluewin.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dkKdwnDyLpc4B4F0"
Content-Disposition: inline
In-Reply-To: <3dc7e744-dcfd-8da3-ed73-8f222d68031c@bluewin.ch>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dkKdwnDyLpc4B4F0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 26, 2023 at 12:03:52AM +0100, Traian Teodorescu wrote:
> Hello, can you please answer to my question below ? It's about the
> "/proc/sys/kernel/random/entropy_avail" variable which doesn't show anymo=
re
> a credible value.

Hi and welcome to LKML!

First, when replying, use "Reply all" instead of forwarding and don't
top-post; reply inline with appropriate context instead.

Second, to improve the chance of getting an answer, Cc: relevant
lists and maintainers (see MAINTAINERS).

Last but not least, see catb document on how to ask smart questions [1].

Thanks!

[1]: http://www.catb.org/~esr/faqs/smart-questions.html=20

--=20
An old man doll... just what I always wanted! - Clara

--dkKdwnDyLpc4B4F0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZB++NAAKCRD2uYlJVVFO
o76LAQCNM/4Et0NXqqbzGY7oxQtlh/Ayx7R0LyxTK5V2DcLysAEAhDrsVXYRA3LU
tX/zBGaiMqsnuHxDJcJTzAJiigJu6Q0=
=WIO3
-----END PGP SIGNATURE-----

--dkKdwnDyLpc4B4F0--
