Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC896D7140
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjDEA2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjDEA2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:28:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3D844A2;
        Tue,  4 Apr 2023 17:28:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Prlq820FBz4x1f;
        Wed,  5 Apr 2023 10:28:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680654516;
        bh=IK+wQSWATW2SBQfuxCqPJzZRVCiDm2H3nNB7sONCNag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wp0zf63NQrpV1Z6NZnxx5g+DM2DA4rybDANyh9w4iM4nKvMUdd8wOna+c8wpahbCb
         r2IiBmt6z5RHnEgFlOoWwOr/SsdQPFllUnCoBUkDQTsrsHH94scpjPFpGpksrILvze
         pOc8Enmwi0PKIHHiFttRssXB34XUpghKJNdyD2oldeRJ6gUrPFG/NJLps886w26BiE
         ypX4pQdd/0T+RBbwt5BLc+Rhd2xzsisnG5wsvbPKoptA41DNaYzp0jgzx17stg3Yvr
         8QxP0WokJ6inKYM1G7h10y56NLsjR49dc9YEZqNckc7hD/LP1HizDvpr0WGGg9saQl
         z6umbq3AdIPmQ==
Date:   Wed, 5 Apr 2023 10:28:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the clk tree
Message-ID: <20230405102834.2ad44472@canb.auug.org.au>
In-Reply-To: <20230403095939.423806fa@canb.auug.org.au>
References: <20230403095939.423806fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dun5jGAOw/Lz_slIS91M_q_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dun5jGAOw/Lz_slIS91M_q_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 3 Apr 2023 09:59:39 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the clk tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> In file included from include/linux/device/driver.h:21,
>                  from include/linux/device.h:32,
>                  from include/linux/platform_device.h:13,
>                  from drivers/clk/mediatek/clk-mt8188-wpe.c:9:
> drivers/clk/mediatek/clk-mt8188-wpe.c:91:31: error: 'clk_mt8188_vpp1_id_t=
able' undeclared here (not in a function)
>    91 | MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp1_id_table);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/module.h:243:15: note: in definition of macro 'MODULE_DEVIC=
E_TABLE'
>   243 | extern typeof(name) __mod_##type##__##name##_device_table        =
       \
>       |               ^~~~
> include/linux/module.h:243:21: error: '__mod_platform__clk_mt8188_vpp1_id=
_table_device_table' aliased to undefined symbol 'clk_mt8188_vpp1_id_table'
>   243 | extern typeof(name) __mod_##type##__##name##_device_table        =
       \
>       |                     ^~~~~~
> drivers/clk/mediatek/clk-mt8188-wpe.c:91:1: note: in expansion of macro '=
MODULE_DEVICE_TABLE'
>    91 | MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp1_id_table);
>       | ^~~~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   f42b9e9a43e3 ("clk: mediatek: Add MT8188 wpesys clock support")
>=20
> I have used the clk tree from next-20230331 for today.

I am still getting this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/dun5jGAOw/Lz_slIS91M_q_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQswLIACgkQAVBC80lX
0GyipQf/WGMqwZz29ywsCdO0OsVyg01gHFGsViQlO+4TaDV9wP23TVGSPKYBo90T
BtoaznguPn6iWZge0JULraLddDhITtnuEDD00yyOfN9GLf0aN0oQMt9M7IJf/Les
Pv+K2IsizSynRRssci3N4jKwjDMuBDuAxSHHUdAetBvCbcsRVyRe7LpVsxOzGXBC
4/05XQ5eIJW7zEZquRfDCuOHUHokM/9uVZMKE01nOJOeazMrwc0ZU9YSDufTcxtY
Ir+wOK+dQSrP0vX0lA8qKLol8/mmQ2oUgvSke4gska7vx6ViqQaywgWthLJTttsw
YBLQO4XZZmf8elZ1zcm5AadoGmmTng==
=lHoL
-----END PGP SIGNATURE-----

--Sig_/dun5jGAOw/Lz_slIS91M_q_--
