Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A635967E8EE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjA0PIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjA0PID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:08:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C017C6B988;
        Fri, 27 Jan 2023 07:08:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u21so4995114edv.3;
        Fri, 27 Jan 2023 07:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQY7as07wyV/M4q3eGv2MuJiZZJokf+ndr0ZBxVZpfY=;
        b=lazzYgl/ZlI58pCeE20VF0Acf29+9RBG8uD4+RqND8MAqd668xjO2ErQpsm4gn30IR
         C+DUL/MFzKVQCy87LXRvbu0F+V7ksP8SDr/AIIYd2QyPRnTSlSUJdP2goPsdwtpLe4He
         gWIkDNiqsb6LOuwAC0wHUBT6zMKqw+x6s+OcblQZMoh0hF3t8DB3DvBPr1wp4LQTynfn
         GW7K+qNiLh2VB329VKzblKs997YjqUwn6Iuli7aXu8lLyv+7WH1SnWgG7OItO9TY9RcD
         deYLqmGzKN210kJfZ0Lhk3kR0JAEt0VykBJ4IZRP0PrHDRmaMXQNzxWszQFDt32y9JFu
         4B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQY7as07wyV/M4q3eGv2MuJiZZJokf+ndr0ZBxVZpfY=;
        b=ShwtM7xKN/cqloOsTDxaHqMmyJnqxY42DY3y8zfgfMUZ+z/lGs4wVZ5337TcHAnZg5
         vqnTWE2GyD8P0tZC6//2gqepeVD3xt3DRASQMwfW+ilDzvs9UsBLv0hoN+bYSN304jTq
         PKIEsnhMW4Gy+RX5wj/QAHXQ4XuelEcOaZepCT9sP57ZKAYKjI7Xe0tzCtycf+u4a2XQ
         c+FkzAa/iKaLJZsed0ry2TTkmlE5Sk8ZCRy/jTCHAFHpnmGOnJMmDhktx1Bc/msE1G+P
         VqzB78ae6BsT6vrEmZFbb96PhGHFJyEEqoFo1ZmDwvFTqCd8TmSHqJL8eImmOF+8m/0s
         sRQg==
X-Gm-Message-State: AO0yUKUu8cl1uCYWgVHA7pjB5/FRebeMKSJGI6w4vkxr49znRGo7QZ20
        dhbfkK9UeBNTjQa45rStEuU=
X-Google-Smtp-Source: AK7set+3qNcUhDRJ4ojMw7eJtfoqP3ecGBIXvwkbuABApAyMnm/hjuqD0xHpyFp8K456bwN8IluKng==
X-Received: by 2002:aa7:d74c:0:b0:4a2:1b8c:5b58 with SMTP id a12-20020aa7d74c000000b004a21b8c5b58mr186373eds.34.1674832080105;
        Fri, 27 Jan 2023 07:08:00 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g5-20020a50ee05000000b004835bd8dfe5sm2453653eds.35.2023.01.27.07.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:07:59 -0800 (PST)
Date:   Fri, 27 Jan 2023 16:07:57 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 1/7] kbuild: do not put .scmversion into the source
 tarball
Message-ID: <Y9PozQphFcXZmEJz@orome>
References: <20230122141428.115372-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mek4sDuTCVXiKQCU"
Content-Disposition: inline
In-Reply-To: <20230122141428.115372-1-masahiroy@kernel.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mek4sDuTCVXiKQCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 22, 2023 at 11:14:21PM +0900, Masahiro Yamada wrote:
> .scmversion is used by (src)rpm-pkg and deb-pkg to carry KERNELRELEASE.
>=20
> In fact, deb-pkg does not rely on it any more because the generated
> debian/rules specifies KERNELRELEASE from the command line.
>=20
> Do likwise for (src)rpm-pkg, and remove this feature.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Makefile.package |  6 ++----
>  scripts/package/mkspec   |  6 +++---
>  scripts/setlocalversion  | 19 +------------------
>  3 files changed, 6 insertions(+), 25 deletions(-)

Hi Masahiro,

I've been observing some strange behaviour when doing incremental builds
on recent linux-next versions. What happens is that the kernel version
doesn't get updated as I switch branches.

For instance I was rebuilding in a kernel tree which I hadn't touched in
a very long while and rebased on a recent linux-next. The kernel version
then stayed at the prior version rather than being updated to reflect
the actual state of the working tree.

Reverting all of the seven patches in this series fixes the issue, but I
don't really have a clue where exactly it fails. Do you have any ideas
how to fix this?

Thanks,
Thierry

>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 525a2820976f..e84c4e8ceb8e 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -32,7 +32,7 @@ export KDEB_SOURCENAME
>  TAR_CONTENT :=3D Documentation LICENSES arch block certs crypto drivers =
fs \
>                 include init io_uring ipc kernel lib mm net rust \
>                 samples scripts security sound tools usr virt \
> -               .config .scmversion Makefile \
> +               .config Makefile \
>                 Kbuild Kconfig COPYING $(wildcard localversion*)
>  MKSPEC     :=3D $(srctree)/scripts/package/mkspec
> =20
> @@ -47,10 +47,8 @@ if test "$(objtree)" !=3D "$(srctree)"; then \
>  	echo >&2; \
>  	false; \
>  fi ; \
> -$(srctree)/scripts/setlocalversion --save-scmversion; \
>  tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
> -	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
> -rm -f $(objtree)/.scmversion
> +	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
> =20
>  # rpm-pkg
>  # ----------------------------------------------------------------------=
-----
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index adab28fa7f89..d3c6701b7769 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -90,7 +90,7 @@ $S	rm -f scripts/basic/fixdep scripts/kconfig/conf
>  $S	rm -f tools/objtool/{fixdep,objtool}
>  $S
>  $S	%build
> -$S	$MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=3D%{release}
> +$S	$MAKE %{?_smp_mflags} KERNELRELEASE=3D%{version} KBUILD_BUILD_VERSION=
=3D%{release}
>  $S
>  	%install
>  	mkdir -p %{buildroot}/boot
> @@ -101,8 +101,8 @@ $S
>  	%else
>  	cp \$($MAKE -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
>  	%endif
> -$M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=3D%{buildroot} modules_install
> -	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=3D%{buildroot}/usr headers_insta=
ll
> +$M	$MAKE %{?_smp_mflags} KERNELRELEASE=3D%{version} INSTALL_MOD_PATH=3D%=
{buildroot} modules_install
> +	$MAKE %{?_smp_mflags} KERNELRELEASE=3D%{version} INSTALL_HDR_PATH=3D%{b=
uildroot}/usr headers_install
>  	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
>  	cp .config %{buildroot}/boot/config-$KERNELRELEASE
>  $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index af4754a35e66..3b31702b4a4a 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -11,16 +11,11 @@
>  #
> =20
>  usage() {
> -	echo "Usage: $0 [--save-scmversion] [srctree]" >&2
> +	echo "Usage: $0 [srctree]" >&2
>  	exit 1
>  }
> =20
> -scm_only=3Dfalse
>  srctree=3D.
> -if test "$1" =3D "--save-scmversion"; then
> -	scm_only=3Dtrue
> -	shift
> -fi
>  if test $# -gt 0; then
>  	srctree=3D$1
>  	shift
> @@ -35,10 +30,6 @@ scm_version()
>  	short=3Dfalse
> =20
>  	cd "$srctree"
> -	if test -e .scmversion; then
> -		cat .scmversion
> -		return
> -	fi
>  	if test "$1" =3D "--short"; then
>  		short=3Dtrue
>  	fi
> @@ -103,14 +94,6 @@ collect_files()
>  	echo "$res"
>  }
> =20
> -if $scm_only; then
> -	if test ! -e .scmversion; then
> -		res=3D$(scm_version)
> -		echo "$res" >.scmversion
> -	fi
> -	exit
> -fi
> -
>  if ! test -e include/config/auto.conf; then
>  	echo "Error: kernelrelease not valid - run 'make prepare' to update it"=
 >&2
>  	exit 1
> --=20
> 2.34.1
>=20

--mek4sDuTCVXiKQCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPT6MsACgkQ3SOs138+
s6HZNRAAl2gzbhEdVwithiv/nG9Mv64Y5zHiGLeHeuDXWmrqJxvFVi1mve1puEQD
UncXfvh7dW53lv1wdZVjIgBAxj8iL5NLuZEA2/lQy0CG5EIhJSDYCv+g1fczweb2
7Qqjkd6u18OKm9GH/WmjeJNL0WOqv9h7uVxk2+dU3ffB6iQUCxkSvO6vS6kdyC5W
vGUX9hS6sIvSezZB1OQBtR0ZTU6g5eKM1vgp4P6+7guO9yphCOrpwFDcDaFbkmxT
CVvdD2z5sWHjj4Z8ZxJbZX9BpD3m/fFTOkxFbjXzgKnF84luRW5uAvBvTpQDLHOb
Loh00GN9kkOrO5/fLr/E9jzjivsUV1EFYZnLKwsJM5KSXp0F4vVqoHlIfqewiuIj
gwjqwP4NWn085RTYajmZIwOBuw2NmORGM4JUrEDyK0tOm1KtSb427S2XONQXPcFn
O/RVxwfJasl/+66WMMG+jmterFkpa9ZIJM1Q0Uw62kw+q2mJRQbN2nr6SbqopBI3
barqJwdHcVb6D4lCtgDKGqfqCapDvN0AoEdFD7HBEBrLNMX+SHUMMKlKAlt9RU1f
JF9giQSyIbPcujVDnkU6VmBhnvgh5pnPnXQqNRtPW0SburIVByv7bGvAjzQilhPs
dgAhsc9n/W9OurEhBCJtgAgC3hbvs3Tx+XrUbHfq8IBulgG9CpM=
=MKZx
-----END PGP SIGNATURE-----

--mek4sDuTCVXiKQCU--
