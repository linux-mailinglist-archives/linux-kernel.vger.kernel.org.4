Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2986F5B9AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIOMVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIOMVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:21:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDCD8981A;
        Thu, 15 Sep 2022 05:21:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id 13so12722160ejn.3;
        Thu, 15 Sep 2022 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=k83bs0hBxICFx55i2HJIwrB5h1+F3bDwhE6gHy6icWA=;
        b=D/nB8oD2fkq618/mURvaCoHwpL4dgnIOW4OyecdZ68hRgLCe3/LpQmP4JsF31gNPSS
         O5qEyZk0q7guRNYSfdQ6XT5JRMLmtG58ipbXCMIDPkpgZzVYT0Qk/OT6oM/hvNLwry9+
         lJUq8ywGu533PKH5zXX52ej8DOZ+vcyYAPbTjM5vBfRbA0Ex/AzpL3Oy7qx2Y8n2kKY6
         FL4QxtR/1KGh9zFNIKBFC2uCKw+3y8QYF0w4eLLJqSQKUSsP2GegWQIRLe8Z8orARY/X
         +L9abGGUKm+ESOyEJR0360Eo+KKa8uBFWmklTtQv88qh1qdwpIF09bFGAUIKRedsPcYX
         w6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k83bs0hBxICFx55i2HJIwrB5h1+F3bDwhE6gHy6icWA=;
        b=ip4kG4YslBBIlZWL9F8ja+Ygh0a9DuHcbOQZcWnWvyNFY5EbVEsW6oaGXrj7GabeAE
         Iquct/Z1qnkOB1dClQT9sH1QkLEO6O6Fb6HeXYWF0RlcPfxM3y85LrkKZsEixY6jYsQ7
         i1fQVYiwoCTsLCEuGQJo6bzuUvqq5fI5ESt2Yf8tZgtSULBoV2hpCojMxcKX8CISZCwx
         IXp5EKOpmsBJka829sJ2VlgpzmTQUaOkSMCZmRJMMcyCE9PjtDT6T4YBkndln1DpGsfe
         5P5Miu39kz/DMsPHxUfjFEcJ4hJDvSjMHCIhzBXGZXeXyE5D9PokaDX+7cAAcfeVCv4U
         Xo6A==
X-Gm-Message-State: ACgBeo0k9YzvwOqvvD6IEvsS6NVMaWO3P83Jz7/JTYKQH4gsuas/2lQh
        7vY8zkKvyExj0KanolbhAcA=
X-Google-Smtp-Source: AA6agR4sFQyJadPBbcrwlDaYMGlvDinRXNtejShnRWoBKLKAYDN4baD15rfPh70nfDqaH6+N1F0NKw==
X-Received: by 2002:a17:907:3d86:b0:780:2e5b:58e0 with SMTP id he6-20020a1709073d8600b007802e5b58e0mr5710749ejc.312.1663244478168;
        Thu, 15 Sep 2022 05:21:18 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fq32-20020a1709069da000b00770812e2394sm9021717ejc.160.2022.09.15.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:21:17 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:21:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     viresh.kumar@linaro.org, rafael@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com
Subject: Re: [Patch] cpufreq: tegra239: Add support for T239
Message-ID: <YyMYu9Y38OeaM1WS@orome>
References: <20220905155759.17743-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eqokmArovlNi/Exy"
Content-Disposition: inline
In-Reply-To: <20220905155759.17743-1-sumitg@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eqokmArovlNi/Exy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2022 at 09:27:59PM +0530, Sumit Gupta wrote:
> Adding support for Tegra239 SoC which has eight cores in
> a single cluster. Also, moving num_clusters to soc data
> to avoid over allocating memory for four clusters always.
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

The subject is a little confusing. Typically the prefix refers to the
driver, so it would be something like "cpufreq: tegra194: ".

Furthermore, please always spell out Tegra239 for consistency. This
makes it easier to grep for.

Otherwise, looks good. So with the above fixed, this is:

Acked-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra19=
4-cpufreq.c
> index 1216046cf4c2..f38a760da61b 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -38,14 +38,6 @@
>  /* cpufreq transisition latency */
>  #define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanosec=
onds */
> =20
> -enum cluster {
> -	CLUSTER0,
> -	CLUSTER1,
> -	CLUSTER2,
> -	CLUSTER3,
> -	MAX_CLUSTERS,
> -};
> -
>  struct tegra_cpu_ctr {
>  	u32 cpu;
>  	u32 coreclk_cnt, last_coreclk_cnt;
> @@ -67,12 +59,12 @@ struct tegra_cpufreq_ops {
>  struct tegra_cpufreq_soc {
>  	struct tegra_cpufreq_ops *ops;
>  	int maxcpus_per_cluster;
> +	size_t num_clusters;
>  	phys_addr_t actmon_cntr_base;
>  };
> =20
>  struct tegra194_cpufreq_data {
>  	void __iomem *regs;
> -	size_t num_clusters;
>  	struct cpufreq_frequency_table **tables;
>  	const struct tegra_cpufreq_soc *soc;
>  };
> @@ -166,6 +158,14 @@ static const struct tegra_cpufreq_soc tegra234_cpufr=
eq_soc =3D {
>  	.ops =3D &tegra234_cpufreq_ops,
>  	.actmon_cntr_base =3D 0x9000,
>  	.maxcpus_per_cluster =3D 4,
> +	.num_clusters =3D 3,
> +};
> +
> +const struct tegra_cpufreq_soc tegra239_cpufreq_soc =3D {
> +	.ops =3D &tegra234_cpufreq_ops,
> +	.actmon_cntr_base =3D 0x4000,
> +	.maxcpus_per_cluster =3D 8,
> +	.num_clusters =3D 1,
>  };
> =20
>  static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *cluste=
rid)
> @@ -382,7 +382,7 @@ static int tegra194_cpufreq_init(struct cpufreq_polic=
y *policy)
> =20
>  	data->soc->ops->get_cpu_cluster_id(policy->cpu, NULL, &clusterid);
> =20
> -	if (clusterid >=3D data->num_clusters || !data->tables[clusterid])
> +	if (clusterid >=3D data->soc->num_clusters || !data->tables[clusterid])
>  		return -EINVAL;
> =20
>  	start_cpu =3D rounddown(policy->cpu, maxcpus_per_cluster);
> @@ -433,6 +433,7 @@ static struct tegra_cpufreq_ops tegra194_cpufreq_ops =
=3D {
>  static const struct tegra_cpufreq_soc tegra194_cpufreq_soc =3D {
>  	.ops =3D &tegra194_cpufreq_ops,
>  	.maxcpus_per_cluster =3D 2,
> +	.num_clusters =3D 4,
>  };
> =20
>  static void tegra194_cpufreq_free_resources(void)
> @@ -525,15 +526,14 @@ static int tegra194_cpufreq_probe(struct platform_d=
evice *pdev)
> =20
>  	soc =3D of_device_get_match_data(&pdev->dev);
> =20
> -	if (soc->ops && soc->maxcpus_per_cluster) {
> +	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters) {
>  		data->soc =3D soc;
>  	} else {
>  		dev_err(&pdev->dev, "soc data missing\n");
>  		return -EINVAL;
>  	}
> =20
> -	data->num_clusters =3D MAX_CLUSTERS;
> -	data->tables =3D devm_kcalloc(&pdev->dev, data->num_clusters,
> +	data->tables =3D devm_kcalloc(&pdev->dev, data->soc->num_clusters,
>  				    sizeof(*data->tables), GFP_KERNEL);
>  	if (!data->tables)
>  		return -ENOMEM;
> @@ -558,7 +558,7 @@ static int tegra194_cpufreq_probe(struct platform_dev=
ice *pdev)
>  		goto put_bpmp;
>  	}
> =20
> -	for (i =3D 0; i < data->num_clusters; i++) {
> +	for (i =3D 0; i < data->soc->num_clusters; i++) {
>  		data->tables[i] =3D init_freq_table(pdev, bpmp, i);
>  		if (IS_ERR(data->tables[i])) {
>  			err =3D PTR_ERR(data->tables[i]);
> @@ -590,6 +590,7 @@ static int tegra194_cpufreq_remove(struct platform_de=
vice *pdev)
>  static const struct of_device_id tegra194_cpufreq_of_match[] =3D {
>  	{ .compatible =3D "nvidia,tegra194-ccplex", .data =3D &tegra194_cpufreq=
_soc },
>  	{ .compatible =3D "nvidia,tegra234-ccplex-cluster", .data =3D &tegra234=
_cpufreq_soc },
> +	{ .compatible =3D "nvidia,tegra239-ccplex-cluster", .data =3D &tegra239=
_cpufreq_soc },
>  	{ /* sentinel */ }
>  };
> =20
> --=20
> 2.17.1
>=20

--eqokmArovlNi/Exy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMjGLsACgkQ3SOs138+
s6E6RhAAkOM+qtlaafy1K18OV+dbEYuZmgEA9LTfzEiURxgh0xQWDetovYhQ9aNq
92SA2NZgEActCeIPJKICB7nJvzs7/5eW3j7SuNEpyRvweV3JALWWxvrFRFPtR5FG
QuK/iTgytQ4J1FuqCIiPd/FRwyR9fBE74o+9qhmLq6KdXF1VB8O79n2ORfROlau+
ahKMqU4+F5SAiUSx7+EW7cC/BgFWK7WImxnCrctcJJcyIcdI2tFdLzsOMF6YxtbI
pjb3CLyOITgAmT9hDX+vo2QllyxDgr0rUzM785Tk/lEVzk9/1jCSxxpB36ssPXmp
UQVMDYzndSMs7EdRS+m3vSPnBntEfmMTKZr0fapEDHzdCQhywpyzHNBtG5a5m+04
md4vRO+kzqgdo+ZFU4AiHySWLBX2dqp8lUvAdtrutF5hQEhP6FaI0yOt2yHIIdOy
l6pE15n+zjDsSBpTJUjtFGl3MkEZOgIbnBl9sxOmDY5WYOa4SuZ8/aO4193G85Ej
kGyiLvxA/JcpCdRQXfqklVksrCFQoWXdrrUCERU5fDSLe1aiDil2lq87YmbCWP09
D4MuI0z4YilrQPPpfOTDKn1UV3fWhoCJwbLyuaTMtyvowmQXBdLjX6rxquROsLy8
vtoEug5fHNVFawjzU5w1xmevM692k8uO8w07P7Pbcfd5KstU1/w=
=Ja4c
-----END PGP SIGNATURE-----

--eqokmArovlNi/Exy--
