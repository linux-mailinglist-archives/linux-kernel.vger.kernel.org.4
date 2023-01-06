Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B1465FA8F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 05:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjAFEEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 23:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAFEEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 23:04:33 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F7DF60;
        Thu,  5 Jan 2023 20:04:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso531515pjc.2;
        Thu, 05 Jan 2023 20:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rwrbQ89JxGf5E1tqt615Grch6aQdxBCOBt3gXa1CYss=;
        b=qagZxk6Kofq1foEbMVlPeOlXomkklr4c4SbxgdC9aEuXQWcxvNkeae47eUNaSlKW7z
         KvAm2dzEBTsoLD+dNfYN/wj+UE/cNxceZmvvdQuS/ZvakclnPg7W4r9yW0hE8dE7SFdQ
         4W4JMGMuWzftTJabfLDpeo2A+PzFmsd7jHKcALG/Fvgyc0nRGlBpPykWAn3PxzCAhv8V
         Tpfuh2978tJZ4dRJTXs0Vq38SzN0SshM9XJO1aA19fWFETN6aJHeCs/JQGDicoRKxE2h
         D3Pu4jOkHcVjn9YXtIhxPv+e8Qkgv2ot2O3QydBTMspFmSGkbXW0D0YVAxfYxb8+6STX
         iMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwrbQ89JxGf5E1tqt615Grch6aQdxBCOBt3gXa1CYss=;
        b=y2lb0xw3u9bu9+aiTZFrN7SIwe368EA18gOSzAqgNcNjb2SfGTMxD1JgHhXWOxAh5A
         /gQB8ZA5Y0AXl6VgPTMS+KKeehzQl14SJnKc7bXz9yrY/SlF7y2dxnIWLEwQ5ihJSXLK
         tsTZAAF6aSWjQu1eqPshiagEbse9UKx8CHrmfB3y/NgiI1btUVkMNKPUVIjdQRf2R4vh
         HgB6EnZWarZ1sfpe8RMsUioihkEiePPj0fpbzfW4OKtBThZtHTtpZZomTGP3ITU9Hxqx
         Vd/OuPsVczV3Wd/52ubZvy4k2dVbtZgNo3aM42VQZyc7kTVSnblmk/uXBc03AClCQOoC
         dW6g==
X-Gm-Message-State: AFqh2kqVSknHNq4Bu1e5QC+PIMYOoUYOZ6gcBdTTrIB7SXYBV194JUzW
        3b8PnvrSbck0CRXyjRb6l8I=
X-Google-Smtp-Source: AMrXdXsf2Qq9QgyRBD0DLUoRwv38lSdxrCy33bs8koo1xImvj/pNg+54ZHpRBncdxxPKxBo56ZC6tw==
X-Received: by 2002:a05:6a20:9f48:b0:ac:29b6:a235 with SMTP id ml8-20020a056a209f4800b000ac29b6a235mr64334893pzb.54.1672977871165;
        Thu, 05 Jan 2023 20:04:31 -0800 (PST)
Received: from debian.me (subs32-116-206-28-2.three.co.id. [116.206.28.2])
        by smtp.gmail.com with ESMTPSA id q2-20020a63cc42000000b004788780dd8esm56089pgi.63.2023.01.05.20.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 20:04:30 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id E1CCF103B03; Fri,  6 Jan 2023 11:04:27 +0700 (WIB)
Date:   Fri, 6 Jan 2023 11:04:27 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with the cgroup tree
Message-ID: <Y7edy9vr4VQ7BwzP@debian.me>
References: <20230106125915.60c8b547@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FkfKZnor6TbpOfrD"
Content-Disposition: inline
In-Reply-To: <20230106125915.60c8b547@canb.auug.org.au>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FkfKZnor6TbpOfrD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2023 at 12:59:15PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the mm tree got a conflict in:
>=20
>   Documentation/admin-guide/cgroup-v1/memory.rst
>=20
> between commit:
>=20
>   da3ad2e14f63 ("docs: cgroup-v1: add internal cross-references")
>=20
> from the cgroup tree and commits:
>=20
>   6cd7ad27c60f ("mm: memcontrol: deprecate charge moving")
>   9bf9f4ba8bd5 ("mm-memcontrol-deprecate-charge-moving-fix")
>=20
> from the mm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc Documentation/admin-guide/cgroup-v1/memory.rst
> index 27d89495ac88,258e45cc3b2d..000000000000
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@@ -725,10 -719,15 +727,17 @@@ If we want to change this to 1G, we ca
>          It is recommended to set the soft limit always below the hard li=
mit,
>          otherwise the hard limit will take precedence.
>  =20
>  +.. _cgroup-v1-memory-move-charges:
>  +
> - 8. Move charges at task migration
> - =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + 8. Move charges at task migration (DEPRECATED!)
> + =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=20
> + THIS IS DEPRECATED!
> +=20
> + It's expensive and unreliable! It's better practice to launch workload
> + tasks directly from inside their target cgroup. Use dedicated workload
> + cgroups to allow fine-grained policy adjustments without having to
> + move physical pages between control domains.
>  =20
>   Users can move charges associated with a task along with task migration=
, that
>   is, uncharge task's pages from the old cgroup and charge them to the ne=
w cgroup.


Ah! I see the oversight in 4ddb1a2aa1a3c4 ("docs: cgroup-v1: wrap
remaining admonitions in admonition blocks") instead. I forgot to remove
mention to the deprecation notice, which is present in mm tree rather
than cgroups one...

The fixup makes the deprecation notice isn't consistent with other
admonitions in the doc (which have been wrapped), so I have recently sent
the wrapper patch for it at [1].

Thanks.

[1]: https://lore.kernel.org/linux-doc/20230106034836.23708-1-bagasdotme@gm=
ail.com/

--=20
An old man doll... just what I always wanted! - Clara

--FkfKZnor6TbpOfrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY7edxwAKCRD2uYlJVVFO
oxfrAP0RG/b2ksVJx0lGIaCpk+lu5J8KcHWOUQ6UodhgBAAKdAD/fOR8tFzUoTBM
b+vu6/5wpFVyegwGxKCTBo2q5FeVhgo=
=Cusr
-----END PGP SIGNATURE-----

--FkfKZnor6TbpOfrD--
