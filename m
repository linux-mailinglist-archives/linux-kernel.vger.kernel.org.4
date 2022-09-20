Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B975BF006
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiITWUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiITWUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:20:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B709564FB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:20:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXGFk3W7Kz4xGW;
        Wed, 21 Sep 2022 08:20:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663712427;
        bh=e4x/7F4x3jtxWPQYW02kArFwt0baGQdR/h9YzM/rOD4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l3bD3IbeEH5ilclgSJSHygo/u1C4bkPIXSc3gfU4rQP2Wvd5ihJ+V7GHUvWDyAutZ
         KuQXveucPc6oL4Tdf5GoeQXFP0ZDUMn2Kho4+dyLtoAJwTj3vyu2P7tr+MCzrnGmaQ
         b5ezfE4+kNj6jtuD0qVK1ZD9IkvfmpsxsO6RRmYsNnsGeesabT+V5YnY0gWWq7LsAJ
         K9IZex5f5lXZ/3tHR9ejeyAgA0XTsKU6Q/899yfIgoXqHn8EpqR9Q8QLss9k/hC3X+
         oBFtfL4PKKwFmBO6dNFIcyYdcZONLdJjazsYorc4aszUrGRCmwudpTA2iSb1pLGd8L
         e+o1TJdAfUg2A==
Date:   Wed, 21 Sep 2022 08:20:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alan Modra <amodra@au1.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] powerpc/64: don't refer nr_cpu_ids in asm code when
 it's undefined
Message-ID: <20220921082006.2235b7d2@canb.auug.org.au>
In-Reply-To: <20220920152935.1569605-1-yury.norov@gmail.com>
References: <20220920152935.1569605-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1cQ.H=BGhInvidNYFoNGEGJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1cQ.H=BGhInvidNYFoNGEGJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Tue, 20 Sep 2022 08:29:35 -0700 Yury Norov <yury.norov@gmail.com> wrote:
>

> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index cf2c08902c05..7cb97881635e 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -400,7 +400,11 @@ generic_secondary_common_init:
>  #else
>  	LOAD_REG_ADDR(r8, paca_ptrs)	/* Load paca_ptrs pointe	 */
>  	ld	r8,0(r8)		/* Get base vaddr of array	 */
> +#if (NR_CPUS =3D=3D 1) || defined(CONFIG_FORCE_NR_CPUS)
> +	LOAD_REG_IMMEDIATE(r7, NR_CPUS)
> +#else
>  	LOAD_REG_ADDR(r7, nr_cpu_ids)	/* Load nr_cpu_ids address       */
> +#endif
>  	lwz	r7,0(r7)		/* also the max paca allocated 	 */
>  	li	r5,0			/* logical cpu id                */
>  1:
> --=20
> 2.34.1
>=20

I don't know PPC assembly very well, but should the #endif be one line
lower so that the constant is not dereferenced in the non-#else case?=20

--=20
Cheers,
Stephen Rothwell

--Sig_/1cQ.H=BGhInvidNYFoNGEGJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMqPJYACgkQAVBC80lX
0Gwr3Af/UChWHeWYob9IqQw/8bJH2CgzIK17TDOUa16U/RWb1MPcCNItY3652WX6
0XQA4oqVJkODYSwsU25iTYv81MXo3HxjMsXattrhnUM0mfwe/UeM00OK9Nao7jIt
FhGAtWldTdBt7Gju45zxNtCsJkK+pYidhFgXF/5w2VZGie8oU3N5J1Pd53gOtNW4
Cyp/YVNaCKYmk6A4P4nx6lqieFMn+3KSqzcYy3U6foEpzsa6rmyDQQG3Ex251Ct0
WW6BOzh3aKM/eZLoClSCQcrfKw+Q28loIBrQReL9krg3btZTrAyWb++bVOFeTXxA
HwBhQceRlM/gkVoHBrFEoQzuN8eraA==
=MWuQ
-----END PGP SIGNATURE-----

--Sig_/1cQ.H=BGhInvidNYFoNGEGJ--
