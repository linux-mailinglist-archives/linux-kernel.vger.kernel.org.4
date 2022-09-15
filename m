Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA535B9AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiIOMXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIOMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:22:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7B689812;
        Thu, 15 Sep 2022 05:22:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m3so6845039eda.12;
        Thu, 15 Sep 2022 05:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8W3ePrho10IJuw4z7hoEUly3NS+NeZ7T3273mT8cs48=;
        b=MXZrORyvfoCWHn593WD9E7F/vuXYRt0Ssj0vrB0WbK6WkHD6DaWN801IiiBiuZNYV+
         +tsq3PFUVVKmDdkjWvRQmkOYplDGiOBbOZNIXoNQxfMXXfPPAwLtu7h0nmmf4VP3r4I3
         VLGYbiHNbe+EREBYq1JhGh2i2EJFO0OVGBIGkk1Qe0DigfewooYffc0msgY7dZTfvGmh
         8mNgyCYHEvaJx9Hg9shs4jBDbBSX6HbH/Hhryh9XLP1aejgea2x7zaUe3laFH34V606V
         fTIZE+eR7+nBj9pekcs76uZfLbwPnTgokJbUDn1u81CUQPoEm3zJ/u3HhPX8D1PyuIwW
         VoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8W3ePrho10IJuw4z7hoEUly3NS+NeZ7T3273mT8cs48=;
        b=MfjNr9+pv8sNgBFMRpXuRY1khnPZQf8N8aKKnHVmksuRt+Vk08DoIZEPfBr22vagVk
         CJ1RZlYPKhqRebH0zahzHUIkSILHnPISQGbiPCc5lJcxKH+TOyVlszxt35/5rIOGjf7/
         PRsL6jWe8xhyD0NwGMvlSYPErDyYRbPADwKANBfQhmzxe0Zk5y4WiiSXP1Xdv+Cag1R0
         or9+c5EQM09gydAmLXzrGBdYAIWXJw1PBkUehpAvH/AVmTKAJntjoCgUN9BdQHhpKWYn
         aafLtM319roy5xle7JgtsvErWkzsdJAaVmoxXRVmGw8urkz+PIgk58kL263DU/35sBXh
         w4tA==
X-Gm-Message-State: ACgBeo38KidaTKaRuEAKWmnv40tOTeASzGJrJDmJs6ABMa4dRYr79g3Q
        juvnDTgL7C+ij8a6Ab+94DAQ+VHACeY=
X-Google-Smtp-Source: AA6agR7mqpGbWoirsws2WzvDFQCYpIXanS0pYxVHi6yhtUn4hac8oKiCNb1XgW4v7yr9R1VZkawQNQ==
X-Received: by 2002:a05:6402:33c4:b0:448:e63e:4f40 with SMTP id a4-20020a05640233c400b00448e63e4f40mr34167088edc.203.1663244573852;
        Thu, 15 Sep 2022 05:22:53 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7d9d1000000b0044f21c69608sm11740115eds.10.2022.09.15.05.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:22:53 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:22:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     viresh.kumar@linaro.org, rafael@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com
Subject: Re: [Patch] cpufreq: tegra239: Add support for T239
Message-ID: <YyMZG9ydqFYTWf0a@orome>
References: <20220905155759.17743-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VSgregLn1wDWg58s"
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


--VSgregLn1wDWg58s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2022 at 09:27:59PM +0530, Sumit Gupta wrote:
> Adding support for Tegra239 SoC which has eight cores in
> a single cluster. Also, moving num_clusters to soc data

Found two more minor things: s/soc/SoC/ for consistent spelling.

> to avoid over allocating memory for four clusters always.
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
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

Might want to make this unsigned int while at it. size_t is preferred
for things that actually refer to the size of something, while this is a
count, so unsigned int fits slightly better. It's admittedly a bit
pedantic...

Thierry

--VSgregLn1wDWg58s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMjGRsACgkQ3SOs138+
s6Gx3A/+PaXRkEuVONdV64pgBJOx2j5tUm0Dfkscj3amnxKz3YN47Tx+PK2NtOn8
hILMZoXSyjHxthf3P8nbUlo/nPHR4ePvkBSyi0b/EFC9+0uiiSV1YFTV1I9EcVgX
OF6W/5S2HIPEDEo4KbAUXakJ824LBUdJhj61UPwnJHWEvF36kbgFzFufNiZiszoB
9mpw21qnU+GzleSvY6t4H18TpdU79m1q9YqAMgMCygWKVO0z4wFnU5HhSTAv43di
aEB695hAlsYai8sPJCe8aNnge+byMBdRg46Ex4AeW1j7jee9CbSaXfnSQBb7NrUC
dZzDmXocP+lvdQw6wWUE/47mlRpOUbz29ua9yibP1c7m0YqmkloBPZ270uqw2ZRz
SjXrxI49YARWAbfeUogcLzaZkhBZlW6XKMVDrhoGaxqFB7wVi88+zd8xx7QG+L3v
5JKDnWXAVWIQTd1u1SCpizAxfDEoit938q/Fu25LzfVw3x6+RYGNmVy/t3JRnHDi
t8xRC8dPUDu9F/Y7bduO0JCR/K9b5EhiIAtQHfTCzm8lvwQOcrM0vpRanTLcRmAy
QanNJbHdtTmwTKlhIo4VC5DTkaqnIs7DCG8sWb3WoBkE//jWOIJIqOzdGrSCrYKM
AedvQw3JND4aI1vsV4RryNqx46iHJHT5Gg531EoGgEb65xGw/u4=
=Zqyw
-----END PGP SIGNATURE-----

--VSgregLn1wDWg58s--
