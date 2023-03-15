Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0F86BBC11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjCOSaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjCOS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3F8ABE5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4067061E07
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 18:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C271C433EF;
        Wed, 15 Mar 2023 18:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678904981;
        bh=IElDfGkli0DP+TpNpslvFjebzjXzSrZFS4o5fGnwePY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqnVZoe/U83ZX+F6sVpj9f8R60GXGqBmEmu576WDauUYLp88UbKmjoj+dJNtJclRd
         JMD6gWopws9xtsqmp8pEU9IBmEXW0ULXSx0VN7kQ/w4vB5OilIn0HWY5GF2Jld61yN
         e97Uijet2pH/Ei82RjjuE2eAgKBUNgpVHCvg5jqMFHUfPDvTkpjQ8HT6NefHEEd6va
         5VyrJJuwvT5F0R2lUna3CwEtQ2M1YWcpHnrrMgpSsdPC1w15M2pjYNy+NCPoF4oHPs
         2gSuZHrRJMX+BIMoVHbbDv1EMC2/hQnI7mrDvN/rQOpWpOxmlK+77OKTQlLf68yGgH
         SUl+htP7bSxiA==
Date:   Wed, 15 Mar 2023 18:29:37 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, conor.dooley@microchip.com,
        ionela.voinescu@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arch_topology: Clear LLC sibling when cacheinfo
 teardown
Message-ID: <70faf5fa-65c2-45a6-9815-8bab38bdae75@spud>
References: <20230314075345.1325187-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WXSODWlx7Ag6BoSl"
Content-Disposition: inline
In-Reply-To: <20230314075345.1325187-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WXSODWlx7Ag6BoSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 03:53:45PM +0800, Song Shuai wrote:
> The teardown of CPUHP_AP_BASE_CACHEINFO_ONLINE now only invokes
> free_cache_attributes() to clear share_cpu_map of cacheinfo list.
> At the same time, clearing cpu_topology[].llc_sibling is
> called quite late at the teardown code in hotplug STARTING section.
>=20
> To avoid the incorrect LLC sibling masks generated, move its clearing
> right after free_cache_attributes().
>=20

> Link: https://lore.kernel.org/linux-kernel/20230313102752.1134472-1-suagr=
fillet@gmail.com/

btw, I think you've added the wrong link here - this seems to be a link
to your previous submission. Was it meant to link to something else?

Cheers,
Conor.

> Fixes: 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection in th=
e CPU hotplug path")
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
> changes from V1:
>  - fix implicit declaration of clear_llc_topology
> ---
>  drivers/base/arch_topology.c  | 16 ++++++++++++++--
>  drivers/base/cacheinfo.c      |  2 ++
>  include/linux/arch_topology.h |  3 +++
>  3 files changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index b1c1dd38ab01..8681654d6c07 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -769,6 +769,20 @@ void update_siblings_masks(unsigned int cpuid)
>  	}
>  }
> =20
> +void clear_llc_topology(unsigned int cpu)
> +{
> +	int sib;
> +
> +	for_each_cpu(sib, topology_llc_cpumask(cpu)) {
> +		if (sib =3D=3D cpu)
> +			continue;
> +		if (last_level_cache_is_shared(cpu, sib)) {
> +			cpumask_clear_cpu(cpu, topology_llc_cpumask(sib));
> +			cpumask_clear_cpu(sib, topology_llc_cpumask(cpu));
> +		}
> +	}
> +}
> +
>  static void clear_cpu_topology(int cpu)
>  {
>  	struct cpu_topology *cpu_topo =3D &cpu_topology[cpu];
> @@ -811,8 +825,6 @@ void remove_cpu_topology(unsigned int cpu)
>  		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
>  	for_each_cpu(sibling, topology_cluster_cpumask(cpu))
>  		cpumask_clear_cpu(cpu, topology_cluster_cpumask(sibling));
> -	for_each_cpu(sibling, topology_llc_cpumask(cpu))
> -		cpumask_clear_cpu(cpu, topology_llc_cpumask(sibling));
> =20
>  	clear_cpu_topology(cpu);
>  }
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index f6573c335f4c..1c276b30fd5a 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/smp.h>
>  #include <linux/sysfs.h>
> +#include <linux/arch_topology.h>
> =20
>  /* pointer to per cpu cacheinfo */
>  static DEFINE_PER_CPU(struct cpu_cacheinfo, ci_cpu_cacheinfo);
> @@ -814,6 +815,7 @@ static int cacheinfo_cpu_pre_down(unsigned int cpu)
>  		cpu_cache_sysfs_exit(cpu);
> =20
>  	free_cache_attributes(cpu);
> +	clear_llc_topology(cpu);
>  	return 0;
>  }
> =20
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index a07b510e7dc5..569e05607934 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -89,9 +89,12 @@ void store_cpu_topology(unsigned int cpuid);
>  const struct cpumask *cpu_coregroup_mask(int cpu);
>  const struct cpumask *cpu_clustergroup_mask(int cpu);
>  void update_siblings_masks(unsigned int cpu);
> +void clear_llc_topology(unsigned int cpu);
>  void remove_cpu_topology(unsigned int cpuid);
>  void reset_cpu_topology(void);
>  int parse_acpi_topology(void);
> +#else
> +static inline void clear_llc_topology(unsigned int cpu) { }
>  #endif
> =20
>  #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
> --=20
> 2.20.1
>=20

--WXSODWlx7Ag6BoSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBIOkQAKCRB4tDGHoIJi
0iPyAP0dyvyYAXc7fXVhiF7RViNcSjXUh5HCIST0t557EwELfAEAwSk39ME6BWq6
w3JUWTbThvkmqEsvuAdkY1s3bkJHmAg=
=z29j
-----END PGP SIGNATURE-----

--WXSODWlx7Ag6BoSl--
