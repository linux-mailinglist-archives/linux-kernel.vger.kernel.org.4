Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8D75B30F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiIIHwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiIIHwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:52:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C2F2253C;
        Fri,  9 Sep 2022 00:49:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MP7RQ1Y66z4wgr;
        Fri,  9 Sep 2022 17:49:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662709746;
        bh=ptrXobyWO/PErfEZKC1j5lnvqHO5gnGmK5xD2LWFIzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FmW72rOEWh4Kj0//3yEiPvdxIWcwULRuVntveIjv0CuEe5FlslK8r8UpxGEtl3jLc
         KxvKJiQrkX8Q/RAp70oFiqJb5Wd5ms0B594/pDSstaIAfrsQNZCYdt16CKQ/ExWQ0h
         JpVKzcHmD6LQZm8aM902dRYsevs8kFfsS/JP0B+ZwI4PT6gV1li0Ev4xdnGUmuFF5Z
         cT3sQKNGBfH1hhYnFkaM0SFyWzCRWQ8pKVuUXnKKdqgEWTDxAgbMsJn7qNWtXFFHu+
         6P1cXPgMWC3XWiCfMfQ1pEZdVrQQUVrPo2okUdUV7yY/yUrdODCETOWu9N5D6MuTTu
         m2a5QrqqK04MQ==
Date:   Fri, 9 Sep 2022 17:49:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kbuild tree
Message-ID: <20220909174904.0342dcb8@canb.auug.org.au>
In-Reply-To: <CAK7LNATR0-Y_yHTcD62J4N36T-_4G=-N1me8EWYNTNYbwXerDw@mail.gmail.com>
References: <20220909090024.47458048@canb.auug.org.au>
        <CAK7LNARPX2Ov-nLAT6mPWbgqQMDCuoW84VN_C2sS1CJkR_n8YQ@mail.gmail.com>
        <20220909152453.5400cf7e@canb.auug.org.au>
        <20220909161354.2c94a495@canb.auug.org.au>
        <CAK7LNATR0-Y_yHTcD62J4N36T-_4G=-N1me8EWYNTNYbwXerDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JP.Grb+nBd/3dezHOo+qh3p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JP.Grb+nBd/3dezHOo+qh3p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 9 Sep 2022 15:48:55 +0900 Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
>
>> I tried this.
>=20
> I built fa8e6bb658f682ff63b3af3dd4c5e4d3b43f4ffd (pending-fixes) first,
> then merged b326faa3e125.

I don't have b326faa3e125 in my tree at all ... the kbuild/for-next
branch I fetched this morning is commit

  99ea8da56dca "kbuild: use objtool-args-y to clean up objtool arguments"

Commit b326faa3e125 looks like it is your "foo3" branch which does
*not* contain your for-next branch.

I presume your builds are on an x86_64 machine?

I did a bisect which lead me to commit

f96f5ad080fe kbuild: move vmlinux.o rule to the top Makefile

So, I did:

build pending-fixes
merge f96f5ad080fe^
build again - which works fine

reset to pending-fixes and rebuild
merge f96f5ad080fe
build fails

--=20
Cheers,
Stephen Rothwell

--Sig_/JP.Grb+nBd/3dezHOo+qh3p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMa7/AACgkQAVBC80lX
0GwpQwf+IoBfbu9GM//a5G3eYGbUxHlt8JLRO7iFZmft3arnEHSwX0rIjXH5UeAa
l13MFUqVbf4LHCy49LJ3bPUDzzapjK74i/ykMd1Y6D5z3U/J4LuSkp94i1RAbBFn
DSvXSSGejXMmkAmlT5v/YSRfCJ9lfa1joc8lh1B7OLiOmNDPKH60EZ7bpXyB3CFE
xTUnsuGfC3Cv0RAU3j+ebzgrrI7zecZQj2g0vjhcaPepPWAD172v1FJNJDUHj3Yo
cEfw6jEaghMKDgiug7NiIWpc58uxxZK4cb9zKPMwXE3C0WXVi9J0Xn7G3csfxMT0
cjiH9hKS7ykGA2zIyjOXC+4IRr/XTQ==
=NgRn
-----END PGP SIGNATURE-----

--Sig_/JP.Grb+nBd/3dezHOo+qh3p--
