Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9855C67110D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjARCVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjARCVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:21:31 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EE33E0B8;
        Tue, 17 Jan 2023 18:21:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v10-20020a17090abb8a00b00229c517a6eeso828947pjr.5;
        Tue, 17 Jan 2023 18:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iWYTihBJS74YNhLStx6/+KX0Vup6pyB8J1ojVOxW77s=;
        b=IIEBhucqwIjVzETPDncrlgqtMmeISCPNb/OAE63apeu3wCenKBObN5WUJkzVQRFrc8
         rDmquwUcx0wyw/n0l//veBN95GoQa8QHMzTx+jIsvPXD4giCNFdnzgpUBrKrMmET/5YV
         EymvzQBl+XsIi1QHoxqWzRXYzD3WAv/1WLR65vjQ8AVzN2x4ceL6dVCiouCk/4c0j8IH
         k1kYKn9Mgp+fj2HaSfZwlqMhBw5vjV2AvKPVV7gGjd/lcNTgCEC3BdNfGvPxeRgq6cz2
         1kmrqG8zjufFxVnOL9M3xKQoVEKMoi4d2DxKiADzkDKjZ6OP+WkGUksU+07ppwkUvTFz
         /HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWYTihBJS74YNhLStx6/+KX0Vup6pyB8J1ojVOxW77s=;
        b=fGdzQZmJtb3MJRLQDKVqRCJ3UQ4LqQ9p6HWTd5f7lpg2PTOe3XCBwujxtWRKTpSnft
         yVilkMRQ1M8VWKmJ80TYoyuwJeWBnFOe/Mos6ynSHXSxPtgzSnZKnVgA4Shndswtxwn4
         QmUjuNv1IlYDCRnTXqq1FX4lGafriifZM/nu0tuLf6A/VOFTN+17DyBELffW+47y89k/
         oDkNsqXKNmbLOm8R8JD1RmcT/u0jz/fEgRQdATwT695ZqW6qMbeDsM3lnB0nbAO30ikB
         fDdtWIEm1QPkcvYEbTrew1Y+0mENxcurJfV5Ngi92ZUceRKCvoXQ23O7BCDD2R2pG4/K
         tGxw==
X-Gm-Message-State: AFqh2krUowT/5oHwUNLLLBFYpFlIuUg6lk1BuBW3+o0c9YP2504zFEVq
        Nc6iGyNWGbITrmEHghOMTso=
X-Google-Smtp-Source: AMrXdXtwXQpDynSdIkPgl6syh577OrdWqmpYPyKHat0a84Nho4mEAsmISNgGqvkNXgoCecdUCkR+hQ==
X-Received: by 2002:a17:903:1ce:b0:193:29db:e0b7 with SMTP id e14-20020a17090301ce00b0019329dbe0b7mr8025365plh.54.1674008489679;
        Tue, 17 Jan 2023 18:21:29 -0800 (PST)
Received: from debian.me (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b0019488a36e2asm5726884pln.277.2023.01.17.18.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 18:21:29 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 005861016F2; Wed, 18 Jan 2023 09:21:25 +0700 (WIB)
Date:   Wed, 18 Jan 2023 09:21:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Deming Wang <wangdeming@inspur.com>, corbet@lwn.net,
        fmdefrancesco@gmail.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, ira.weiny@intel.com, rppt@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/highmem: fix spelling mistakeo
Message-ID: <Y8dXpe5CCo5Kl3Zg@debian.me>
References: <20230118004356.4198-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mw4POEwxCQT0tDQk"
Content-Disposition: inline
In-Reply-To: <20230118004356.4198-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mw4POEwxCQT0tDQk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2023 at 07:43:56PM -0500, Deming Wang wrote:
> Substitute occurrencies of "higmem" with "highmem".
>=20
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  Documentation/mm/highmem.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> index 59d1078f53df..7da4a0d175f0 100644
> --- a/Documentation/mm/highmem.rst
> +++ b/Documentation/mm/highmem.rst
> @@ -83,7 +83,7 @@ list shows them in order of preference of use.
>    for pages which are known to not come from ZONE_HIGHMEM. However, it is
>    always safe to use kmap_local_page() / kunmap_local().
> =20
> -  While it is significantly faster than kmap(), for the higmem case it
> +  While it is significantly faster than kmap(), for the highmem case it
>    comes with restrictions about the pointers validity. Contrary to kmap()
>    mappings, the local mappings are only valid in the context of the call=
er
>    and cannot be handed to other contexts. This implies that users must

Are you sure you have seen the other occurences of higmem in the same
doc? If so, do s/higmem/highmem/g.

Also, the patch subject prefix should have been Documentation: mm:
highmem, and also s/mistakeo/mistake/ in the subject.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Mw4POEwxCQT0tDQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8dXnAAKCRD2uYlJVVFO
o08VAQDEEhStJpa6Cgxi3uNSqAxm4VevQ6Z9DCxAAmI3m26C8gD+L+leay6lI/iN
n7nFfjH+K05bGxtoIlBFVRxXFTKe1Q0=
=vy/I
-----END PGP SIGNATURE-----

--Mw4POEwxCQT0tDQk--
