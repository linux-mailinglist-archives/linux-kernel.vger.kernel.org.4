Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57E36D6D29
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbjDDTaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbjDDT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:29:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0765E10E5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 892A1633E3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 19:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB65C433EF;
        Tue,  4 Apr 2023 19:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680636591;
        bh=lxOKTCvPksW7Jtj6LMV9HNZS1AI82kjwKyiRLo8C7FE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+uJnlv8xhTy2338ZnQ4Gq34nsIqMcWrTCp27aiqvH04bHG4bgYg2WfsOIYroFEjw
         BXZGR742UYZ4vYXtcmL3I00/xxMy28CXZSnjsQRM+Vcfh8gDHqKs7znupt1zfZVrxW
         ONGkBw1f+HR/R3CZ8M6seUDuajaXaV49FeB3Uj0b/jFdeAcHBR7/c9YlwzOPOwYRJq
         uZwXi5QnMhBlkQINy7DqPPBRTDwcZbcNzOm8QdxIN6dm2MIFT9v8wyS0vnYjYWm1zP
         PxNjuYC3pWOeG7bLjlDKN9qfH8CHAoWYU6AmDcBYrtUYNfEYvWVAd1osyRTKrXxtpc
         tstkB9ggmQzzQ==
Date:   Tue, 4 Apr 2023 20:29:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH 2/3] cacheinfo: Check cache properties are present in DT
Message-ID: <20230404-hatred-swimmer-6fecdf33b57a@spud>
References: <20230327115953.788244-1-pierre.gondois@arm.com>
 <20230327115953.788244-3-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pi8T+o/24pYeiODx"
Content-Disposition: inline
In-Reply-To: <20230327115953.788244-3-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pi8T+o/24pYeiODx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Pierre,

On Mon, Mar 27, 2023 at 01:59:50PM +0200, Pierre Gondois wrote:
> If a Device Tree (DT) is used, the presence of cache properties is
> assumed. Not finding any is not considered. For arm64 platforms,
> cache information can be fetched from the clidr_el1 register.
> Checking whether cache information is available in the DT
> allows to switch to using clidr_el1.
>=20
> init_of_cache_level()
> \-of_count_cache_leaves()
> will assume there a 2 cache leaves (L1 data/instruction caches), which
> can be different from clidr_el1 information.
>=20
> cache_setup_of_node() tries to read cache properties in the DT.
> If there are none, this is considered a success. Knowing no
> information was available would allow to switch to using clidr_el1.
>

Alex reported seeing a bunch of messages in his boot log in QEMU since
-rc1 which appears to be the fault of, as far as I can tell, e0df442ee49
("cacheinfo: Check 'cache-unified' property to count cache leaves")
like:
cacheinfo: Unable to detect cache hierarchy for CPU N

The RISC-V QEMU virt machine doesn't define any cache properties of any
sort in the dtb, and unlike the arm64 virt machine I tried (a72) doesn't
have some registers that cache info is discoverable from.
When we call of_count_cache_leaves() from init_of_cache_level() and
there are of course no reasons to increment leaves, we hit the return 2
case you mention above, setting num_leaves to 2.

As you mention, when we hit cache_setup_of_node(), levels is not going
to be set to one, so we trigger the condition (this_leaf->level !=3D 1)
and, as there are no cache nodes, break out of the loop without
incrementing index. Index is therefore less than 2, and thus we return
-ENOENT.
This is of course propagated back out to detect_cache_attributes() and
triggers the "Unable to detect..." printout :(

With this patch(set), the spurious error prints go away, but we are left
with a "Early cacheinfo failed, ret =3D -22" which will need to be fixed.

So I think this also needs to be:
Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count ca=
che leaves")

Probably also needs a:
Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
since he's found an actual, rather than theoretical, problem!

Cheers,
Conor.

> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/base/cacheinfo.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 4ca117574af1..5b0edf2d5da8 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -78,6 +78,9 @@ bool last_level_cache_is_shared(unsigned int cpu_x, uns=
igned int cpu_y)
>  }
> =20
>  #ifdef CONFIG_OF
> +
> +static bool of_check_cache_nodes(struct device_node *np);
> +
>  /* OF properties to query for a given cache type */
>  struct cache_type_info {
>  	const char *size_prop;
> @@ -205,6 +208,11 @@ static int cache_setup_of_node(unsigned int cpu)
>  		return -ENOENT;
>  	}
> =20
> +	if (!of_check_cache_nodes(np)) {
> +		of_node_put(np);
> +		return -ENOENT;
> +	}
> +
>  	prev =3D np;
> =20
>  	while (index < cache_leaves(cpu)) {
> @@ -229,6 +237,25 @@ static int cache_setup_of_node(unsigned int cpu)
>  	return 0;
>  }
> =20
> +static bool of_check_cache_nodes(struct device_node *np)
> +{
> +	struct device_node *next;
> +
> +	if (of_property_read_bool(np, "cache-size")   ||
> +	    of_property_read_bool(np, "i-cache-size") ||
> +	    of_property_read_bool(np, "d-cache-size") ||
> +	    of_property_read_bool(np, "cache-unified"))
> +		return true;
> +
> +	next =3D of_find_next_cache_node(np);
> +	if (next) {
> +		of_node_put(next);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int of_count_cache_leaves(struct device_node *np)
>  {
>  	unsigned int leaves =3D 0;
> @@ -260,6 +287,9 @@ int init_of_cache_level(unsigned int cpu)
>  	struct device_node *prev =3D NULL;
>  	unsigned int levels =3D 0, leaves, level;
> =20
> +	if (!of_check_cache_nodes(np))
> +		goto err_out;
> +
>  	leaves =3D of_count_cache_leaves(np);
>  	if (leaves > 0)
>  		levels =3D 1;
> --=20
> 2.25.1
>=20

--pi8T+o/24pYeiODx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCx6qgAKCRB4tDGHoIJi
0lLFAQDaPIa1OUdhPwmPtXU4arYYjYn97JNiEXAJOVtsGeJZnQEAzxGcMW6AYQD7
73njRu6NY//OIQjaCy+Cou8mFSM1pQ0=
=Gepo
-----END PGP SIGNATURE-----

--pi8T+o/24pYeiODx--
