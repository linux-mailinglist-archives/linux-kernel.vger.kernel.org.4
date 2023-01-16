Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ECB66C8A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjAPQlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjAPQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:40:53 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A76C36B2E;
        Mon, 16 Jan 2023 08:29:07 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kt14so10414641ejc.3;
        Mon, 16 Jan 2023 08:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s7i4e/9M2UcJLxes9insspm/+PoKa2o1GchG8eSBbc=;
        b=Jhd1ZnirmUUEaqs4PzBrNVNrHZrjJCRRvfLXAsFPQFqmYRYykhG//aWcQjTKnEvJg/
         IhAncth9L+aQ81KqrJeQq0AGpvl/0NMIfiyEUPZqkxsluCf+AFMXOKdAMWP/tKLpYqnV
         xA+usSt8BKe3NtBuju6wwvrYPwV+MSanG9GbB7ap/rQwDXPR8hwdPgYPbq7m/ZnVy+jm
         zf5FaKjGGG0Bh8CZ91xbdWy5mG6ukzoJEJmqjft4kLyFWEfcAywncnIlxatu7cm/WFu1
         UAaSfTXEOEnBqDZt3VJmZYXcn3nfhqf8A31CCpHIhSlqwBUUwf3B951KZcgSawFs8h5h
         8AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5s7i4e/9M2UcJLxes9insspm/+PoKa2o1GchG8eSBbc=;
        b=JgP6ALS0hM+G68LxQidu49+EcpOlyBIDnm05fUi1k0Zp+qDvLjPv8WC6VoY9ecj6k+
         9vvN1CGXBnmziIpvQhdD0xC+fHp3IarzzGB/ZYDfpO6ebBeUZtuNCiM3gzPHYUkIeNgq
         Xgsk3SxMKZLKlLAYwn2XsWAGEDns2TFBgORTuXwUbUqm5hnmW/J81rY/Kv0K0tMuoRzI
         be6biPYtCzyZXLk4XOqZE7yHlQB4x1UL01gvNpRHl0oGM+3LUWg/PMy9SJEe/+KkqO/8
         QWGtAz9jIfhRIGmfz6EF2pALQx5CVmywwqd4OeP4ynTupCCwYtoo10vS99aF72b4qAdQ
         oXFw==
X-Gm-Message-State: AFqh2kqzdd+YILCXTbrbyswvlwUxDCBGecwZ0WxsyVO70fjNIJRwF4J6
        SZyVvC0Oqz5PAa0H9ofFxS8=
X-Google-Smtp-Source: AMrXdXuwjYY4SeuRhYiBmpNcCIWXCkDyZdQ881c1TRZlr/sdeKegiB+f2b8el7lPUC6lY45jc9547w==
X-Received: by 2002:a17:907:76f2:b0:869:236c:ac43 with SMTP id kg18-20020a17090776f200b00869236cac43mr14778321ejc.32.1673886545881;
        Mon, 16 Jan 2023 08:29:05 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id tc9-20020a1709078d0900b0086edf177209sm2343403ejc.78.2023.01.16.08.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:29:05 -0800 (PST)
Date:   Mon, 16 Jan 2023 17:29:02 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, krzysztof.kozlowski@linaro.org,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
Subject: Re: [Patch v1 06/10] arm64: tegra: Add cpu OPP tables and
 interconnects property
Message-ID: <Y8V7TkAiEWizF70l@orome>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-7-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZMip0bUSH42JeHsT"
Content-Disposition: inline
In-Reply-To: <20221220160240.27494-7-sumitg@nvidia.com>
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


--ZMip0bUSH42JeHsT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 09:32:36PM +0530, Sumit Gupta wrote:
> Add OPP table and interconnects property required to scale DDR
> frequency for better performance. The OPP table has CPU frequency
> to per MC channel bandwidth mapping in each operating point entry.
> One table is added for each cluster even though the table data is
> same because the bandwidth request is per cluster. OPP framework
> is creating a single icc path if the table is marked 'opp-shared'
> and shared among all clusters. For us the OPP table is same but
> the MC client ID argument to interconnects property is different
> for each cluster which makes different icc path for all.
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 276 +++++++++++++++++++++++
>  1 file changed, 276 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra234.dtsi
> index eaf05ee9acd1..ed7d0f7da431 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -2840,6 +2840,9 @@
> =20
>  			enable-method =3D "psci";
> =20
> +			operating-points-v2 =3D <&cl0_opp_tbl>;
> +			interconnects =3D <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;

I dislike how this muddies the water between hardware and software
description. We don't have a hardware client ID for the CPU clusters, so
there's no good way to describe this in a hardware-centric way. We used
to have MPCORE read and write clients for this, but as far as I know
they used to be for the entire CCPLEX rather than per-cluster. It'd be
interesting to know what the BPMP does underneath, perhaps that could
give some indication as to what would be a better hardware value to use
for this.

Failing that, I wonder if a combination of icc_node_create() and
icc_get() can be used for this type of "virtual node" special case.

Thierry

--ZMip0bUSH42JeHsT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPFe0wACgkQ3SOs138+
s6F2yBAAjowmxzjVq6aVzA6zhSk3nbCgl0QL/OEp6PY0OzH2xVKJUuu4zOttfnbe
Yp1JqpDpVvueEBIRSRWV2bwEwtJ6W5vYrcW2TkNfM5biG3c1uYRCVcADJPwSO4gL
Obyy7iew33hS30m/9uynImJVGAh/WuVIZJ/2JTkFGzjP7K7nvhASuyABnVE4+CvJ
uIgl1XUxTdgD/hS6BmVlKv5S6M9bU7UkWTCWqX2xS/t51K+iv7nBc9NeeVrJZdwF
sChYSmFEmKMPyZF15al5UK//xakf3l9M1Q3p7QEo/VK6Ee5D8nAvGRzMYWD2uSvv
rfhT9hZNaLYaHUQkdGJP7hcIspsR3CucHasz6UqDgsWSJkL9b4QlDYLFK9StTEyV
LrrYjQHe6jTYSGegIBqwzANd3Kp/Enbzdz0Rb9d7fXelYuEkPdxc4xMjw22qe7Er
9DuaDmkeh1218GaEWeepVrQvDKDiaK2KrhQGd8uu2iXGXe9xOG2TtT0lvQENZpLX
WkEpDjrh+ZJrSrd8A06oRFmRzHP/Y8W4QUH7dUFujcfip+JQjMlq+K1+EMyRwapR
yrWPyYqk/2NxS+vlfAwyX+K+DkB/xlvPNRRsdof93MKdbGUgFQ9pbGtzCddzyAOK
sPo4xnV+1yI+JBT9/OafTN0UMaSLCArvPLubL+7mfrjqaBrPQ54=
=eSEA
-----END PGP SIGNATURE-----

--ZMip0bUSH42JeHsT--
