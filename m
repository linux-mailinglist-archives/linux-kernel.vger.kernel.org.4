Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1064F69EAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjBUXD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBUXD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:03:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE69014EA2;
        Tue, 21 Feb 2023 15:03:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLvwm2qdNz4x5X;
        Wed, 22 Feb 2023 10:03:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677020633;
        bh=gRMxZZYB5Y5zxtDjgWP0wu271FoxOqzl1Ksa1RbOAI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cBlvqLfFS32KO3M4WzSiZePqHOplkHiObyugNejTzTx1PUvb8EUnIMWfdvxpNVGbc
         xBNOm+nVRyI2vnczbf1vcCNFbf8+sH7UHGbYaOPKZK1bsSiB8saqfNB7dKAKNIx9v6
         F1Abvz6WnNbJOoFbozelmf67tnFE9oPDoQQzg+2DIbjZ+BTLWL9DpTDJ6JP2W0tMZl
         SKNfBurhwV06k258/2okFfnydW05epe/gGbeaD5lkrSpp4N7vbj+bXFQvDAn1g6Z5I
         53+FJ9qLgNTKjueXQM/qWf6oZI4+IqlCXleKhzbjWxHYON8wKgkJUjta3y5YhJD+8M
         UWHhkxn/cHAaw==
Date:   Wed, 22 Feb 2023 10:03:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the s390 tree
Message-ID: <20230222100351.5801c81b@canb.auug.org.au>
In-Reply-To: <20230210120021.4a507539@canb.auug.org.au>
References: <20230210120021.4a507539@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ux/QtfQV2t1netYC=6F.tGW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ux/QtfQV2t1netYC=6F.tGW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 10 Feb 2023 12:00:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   arch/s390/kernel/idle.c
>=20
> between commit:
>=20
>   c01016299dc7 ("s390/idle: move idle time accounting to account_idle_tim=
e_irq()")
>=20
> from the s390 tree and commit:
>=20
>   89b3098703bd ("arch/idle: Change arch_cpu_idle() behavior: always exit =
with IRQs disabled")
>=20
> from the tip tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc arch/s390/kernel/idle.c
> index dd8351e76539,b04fb418307c..000000000000
> --- a/arch/s390/kernel/idle.c
> +++ b/arch/s390/kernel/idle.c
> @@@ -61,7 -57,15 +61,6 @@@ void noinstr arch_cpu_idle(void
>  =20
>   	/* psw_idle() returns with interrupts disabled. */
>   	psw_idle(idle, psw_mask);
> - 	raw_local_irq_enable();
>  -
>  -	/* Account time spent with enabled wait psw loaded as idle time. */
>  -	raw_write_seqcount_begin(&idle->seqcount);
>  -	idle_time =3D idle->clock_idle_exit - idle->clock_idle_enter;
>  -	idle->clock_idle_enter =3D idle->clock_idle_exit =3D 0ULL;
>  -	idle->idle_time +=3D idle_time;
>  -	idle->idle_count++;
>  -	account_idle_time(cputime_to_nsecs(idle_time));
>  -	raw_write_seqcount_end(&idle->seqcount);
>   }
>  =20
>   static ssize_t show_idle_count(struct device *dev,

This is now a conflict between the s390 tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ux/QtfQV2t1netYC=6F.tGW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP1TdcACgkQAVBC80lX
0GxXcwf9FKWBJiS3L4p9UGpjYMJwUVJfaE91bpPMLvncZilIIrmJFk+dSLlCWrD6
WUkI8SyyFf8csECQuv0LRa1vsja5tqhDDVZzosWaD4UDqP5ptaudp+wur1Nc1/lm
YwS08XMjAc1o2dd601W35AM1VHQ/YohcUUnyAiN8lC312u/GS9IuB0SDfqAYWl2Q
KQTta1e66Oo7JrhBEvSDUuJP7HUJM6uFyqp7qcs+LnCk0xpWMvuVw9W0Llc2IGB+
HlbnDBT9n2x3ZlZE0dzAO1JlVhygwnx4Mf3Cw3qe26UBADjTR/mN9n/gPAcwWZ+p
fFiN4qQuorKcWDMB0hCXJdNE6TbU9A==
=jQYz
-----END PGP SIGNATURE-----

--Sig_/ux/QtfQV2t1netYC=6F.tGW--
