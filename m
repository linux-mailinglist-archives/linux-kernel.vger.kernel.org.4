Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514565B520F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 01:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIKX7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 19:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIKX7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 19:59:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A41D0DC;
        Sun, 11 Sep 2022 16:59:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQmsn1rFKz4xG7;
        Mon, 12 Sep 2022 09:59:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662940749;
        bh=dpaurtSATUmrTNvO1b0E1fP9bxLdyCWdPLFblSLZCEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ClNW2SPvyu+lmZ8qJGZJdSJ3qyxWWOplaEZSdVd2CYm5e5zOHypd8QDyy+63pkghQ
         TQhAP7awaUd1uXlX4mQ2AYIIkGWw+z23ebLMKxXAZKS/r+9Vp0G8zKiRneGiSnGtW5
         QZbN2BEGUoFj91TknVRr7UeZkWMTA89vcfdzUQ+qWd/UiDLhj7IStvlV4ypgi7ST+a
         r+aZktgQjD0xMNyD4zU+8zOi2Mhs6N1vIG2cKHrMkhSDbzGnS+yqSopRojMzYhdL7C
         CDhZAq/BQKJ539NxV5pBpJf7worQv+eLf1F7JpdTq6AXd3pkEpUMn6wc1qWz1YBwFX
         1zbcPM1DL4lfg==
Date:   Mon, 12 Sep 2022 09:55:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kbuild tree
Message-ID: <20220912095559.26de75c9@canb.auug.org.au>
In-Reply-To: <CAK7LNARiW66Hk5JJgRYb-edkb6sgTWPbNr1iETkq-RASCo-YkA@mail.gmail.com>
References: <20220909090024.47458048@canb.auug.org.au>
        <CAK7LNARPX2Ov-nLAT6mPWbgqQMDCuoW84VN_C2sS1CJkR_n8YQ@mail.gmail.com>
        <20220909152453.5400cf7e@canb.auug.org.au>
        <20220909161354.2c94a495@canb.auug.org.au>
        <CAK7LNATR0-Y_yHTcD62J4N36T-_4G=-N1me8EWYNTNYbwXerDw@mail.gmail.com>
        <20220909174904.0342dcb8@canb.auug.org.au>
        <CAK7LNARiW66Hk5JJgRYb-edkb6sgTWPbNr1iETkq-RASCo-YkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q6=uT3.TY9sfysF9+Tin8Yn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q6=uT3.TY9sfysF9+Tin8Yn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Fri, 9 Sep 2022 19:30:24 +0900 Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
>
> The following fix will make it working again.
>=20
 diff --git a/Makefile b/Makefile
> index b459e3d0fc5a..c8fba03ec93c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1151,7 +1151,6 @@ quiet_cmd_autoksyms_h =3D GEN     $@
>  $(autoksyms_h):
>         $(call cmd,autoksyms_h)
>=20
> -targets +=3D vmlinux.o
>  vmlinux.o: autoksyms_recursive $(KBUILD_VMLINUX_OBJS)
> $(KBUILD_VMLINUX_LIBS) FORCE
>         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o

Thank you.  The kbuild tree merge builds fine again.

--=20
Cheers,
Stephen Rothwell

--Sig_/Q6=uT3.TY9sfysF9+Tin8Yn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMedY8ACgkQAVBC80lX
0Gw+sgf+MOvdDutU4SuXfZKu0cO6LfqSvC7ZiQgbUw4Y1+3VUNDO8TJJvrEThZlt
Kaw6GJDXDvOE/dCpLko36BjivEjdsnIbKdqV8gt0ChTFJthWv+U4wR9qsayhc2vW
dvRD4qn9DDoqoojeSfWCeH2km9Wo1kFM8kIr/WWufyc1TFldjepQmvKtx8m/UAqU
cycHoQFLzdHhEZzMHLU56LGl1cZXFGpw6TtojZtEblTa7qBAEzl02ycIFXHceU8a
+Poy+Z4rKLfd1nOpBWlUjFpt3pETqXauJhjcBI03UvaQiOrx7vI/Gj3wO4gpENzM
BNojrkFdROEQ92iSju5vtILLb33kFw==
=HFrI
-----END PGP SIGNATURE-----

--Sig_/Q6=uT3.TY9sfysF9+Tin8Yn--
