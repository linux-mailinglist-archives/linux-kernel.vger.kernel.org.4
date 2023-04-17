Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C376E4BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjDQOw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:52:54 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB236A7C;
        Mon, 17 Apr 2023 07:52:53 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1poQDo-0006yd-BB; Mon, 17 Apr 2023 16:52:48 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1poQDn-001hqR-2e;
        Mon, 17 Apr 2023 16:52:47 +0200
Message-ID: <3a857172b78f1bbd6427600bdd5afa81dd21c73f.camel@decadent.org.uk>
Subject: Re: [PATCH 1/2] kbuild: add srcdeb-pkg target
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bastian Germann <bage@linutronix.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Apr 2023 16:52:41 +0200
In-Reply-To: <20230417142548.249610-1-masahiroy@kernel.org>
References: <20230417142548.249610-1-masahiroy@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-nstfiAqeePdqAIEfaHxQ"
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nstfiAqeePdqAIEfaHxQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2023-04-17 at 23:25 +0900, Masahiro Yamada wrote:
> This new target builds only the debian source package.
>=20
> Unify the build rules of deb-pkg, srcdeb-pkg, bindeb-pkg to avoid
> code duplication.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> ---
[...]
>  bindeb-pkg: debian
> -	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG=
_FLAGS) -b -nc -uc
> +deb-pkg srcdeb-pkg bindeb-pkg:
> +	+$(strip dpkg-buildpackage \
> +	--build=3D$(build-type) --no-pre-clean --unsigned-changes \
> +	$(if $(findstring source, $(build-type)), \
> +		--unsigned-source) \
> +	$(if $(findstring binary, $(build-type)), \
> +		-r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
> +		--no-check-builddeps) \
[...]

There is no need to make the use of --unsigned-source (-us) or -r
conditional on the build type.  They will be ignored if not applicable.

This is also adding --no-check-builddeps (-d), which is not explained
in the commit message.  It might be valid to add this for srcdeb-pkg,
but the build dependency check is valuable for bindeb-pkg and deb-pkg.

Ben.

--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.

--=-nstfiAqeePdqAIEfaHxQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmQ9XTkACgkQ57/I7JWG
EQm3tg//YIH/o965SlLladsBwHQezdYzMmPB3fAn76hctwemgizoIoj/cCj+bYGE
hUUx9Sfv/QC79KOSaQdIBZ7UsyQenTh0nnkM91ZxlWnC5gLseE26Xrxdgl2aQoAt
P1xsaqgGDNGGjGjoadxVzG8x8wD7H3LlU8f5RTxnIgcxWwzTuSDdIneLEZm9I+Lk
mAF1xxn08ia/t5sFDSPWlfmoTRn2OehpkNXccIojyBgG445zce+tS3yGxQbbGLqe
9ae1uTv4dUoZ/FOMPzz4mwM60anr3y7IMexChCOQL9wUnX6L19wdeu3Ae6Rfl010
/uwKgyJHC7vser5RUda41SFXHrxoX8cZogxBFm2HMtQ7ZP2iUmukdxYmlumENSCF
DesQ50R48J5AFqYVCsq+AKoOZnY7fBwiCL4bqVcc3dgqyAvIC8h0FUFOg32nRyER
McDxKjEaYgesmMdXdPgyB/2TzMYIOl47extx6/EqIQLzVVv8xWakT7jBUgbWHs6p
eRTHOFaMFO1N6Sc1r2v0hcijwotH7ZQ/GP74oXXe0DjwoLY6JInRHu7yI/0+c7AD
p16JKcfPQhGI439r4OPyqwOq8eucT4MddLqxKUHnsV9nEnxNC9e1nPcMkMLczW4s
tCEolNPKRg4VkjAITJv0c7k6By8pS8kVNGta9obI/aBiSnTPWus=
=WjHm
-----END PGP SIGNATURE-----

--=-nstfiAqeePdqAIEfaHxQ--
