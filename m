Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB2605B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJTJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJTJyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:54:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EA31CB507;
        Thu, 20 Oct 2022 02:54:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l22so29094661edj.5;
        Thu, 20 Oct 2022 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV+BhU4+eXmpbQ5EMlBERw33VBGYIV/n2IV6kgz4qs4=;
        b=Y8kY0+W7tAFL4p4oF9BMEabmjjxrUnQfhNH4j6smaKv2UddIFYLR5qktsADgmXJ7MX
         LcsMBoKIna5vbjZMNDZdralmG1EC6p3UxhEu02n2lB6KORlQNMQDotsTWQGG7DCGqzqL
         dH+qiPymZbq4LuiqJzeaAD7ljyjD1JQDNvwAaLi74caq05GUOwMuLYGQol5f9vdpxFHB
         JUPlzKQcmmlbD6RZ+vNPjH6o1wf5WBL+hvPAHruDrpkDNkJndXCNUtk0yQIUQzgRU3in
         4fbVIxe5DpkF9eV/Y66JKt6rvkjJUcXxWU8HU8bIh9JI4RJbO0XLKnLDzQtMZwabrcAo
         fDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV+BhU4+eXmpbQ5EMlBERw33VBGYIV/n2IV6kgz4qs4=;
        b=ku4jM02OYl4yhz9TTkbhgCXaErZ6EpBqI+nkZVuXs6AGJB/atVPOyc1oApPCXjtmLN
         OwcgSMWHO0Y9yKzlRlkkY/+7P4A+Ow8DOVUSTSriPPCpY3Z3e/NyVrB9QGndqiFqa9vI
         Ggn7q5dDEjFEm7v8U1ODFZWKRB0oun5v4Et2BLPxWKj6J7WwNY+LuFqtUJhss+2G0pta
         0dADCk6W1e49cUyIBnbigbDmmPe6PmXbM0Ljkp4yGviW9CIxm+MtoncgVw0bCwONWdhf
         8/fJuiOS+7eY4ODimYox697QjXnf+MN+A12rMC6+52bZT1H+1NC6p1/81r0mV70zmPeb
         /lLw==
X-Gm-Message-State: ACrzQf1O5p47KOkOl1Yjy2wEAzY54CRjaYPiLntlFP2T7Ho8a/WpgFJn
        UGCLz+CNc9oBSq1Sh3DrBik=
X-Google-Smtp-Source: AMsMyM6tvYDFR1I556ogk2L3YeWTWwy+Bi+Z3BcWJgPiTyUi6JHt++CVuVYZJleZyH9COy5I4Q3IFg==
X-Received: by 2002:a05:6402:518b:b0:45d:9a19:66d2 with SMTP id q11-20020a056402518b00b0045d9a1966d2mr11272878edd.43.1666259647774;
        Thu, 20 Oct 2022 02:54:07 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b6-20020a056402138600b00457b5ba968csm11835744edv.27.2022.10.20.02.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:54:06 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:54:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Kartik <kkartik@nvidia.com>, jonathanh@nvidia.com, windhl@126.com,
        sumitg@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc/tegra: fuse: Export tegra_get_platform() &
 tegra_is_silicon()
Message-ID: <Y1EavIxVymPSfwJC@orome>
References: <1664186759-9821-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="csjkOe4a4bB5CbtM"
Content-Disposition: inline
In-Reply-To: <1664186759-9821-1-git-send-email-kkartik@nvidia.com>
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


--csjkOe4a4bB5CbtM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 03:35:59PM +0530, Kartik wrote:
> Functions tegra_get_platform() and tegra_is_silicon() are required
> for pre-silicon development to correctly identify the platform on
> which the software is running.
>=20
> Export tegra_get_platform() and tegra_is_silicon(), so they can be
> used for pre-slicon development of device drivers and kernel space
> tests.
>=20
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 ++
>  1 file changed, 2 insertions(+)

Hi Arnd, Olof,

can you take a quick look at this and provide some feedback regarding
acceptance? It's slightly unorthodox because the only in-tree users of
these functions are built-in drivers and early code, so they don't
technically need to be exported for strictly in-kernel users. However,
we do see these used quite frequently in pre-silicon development and
having these available upstream would help with internal kernel
transitions and so on. We may also see them used more commonly in
upstream drivers in the future.

Thierry

> diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/f=
use/tegra-apbmisc.c
> index 3351bd872ab2..904797f651a1 100644
> --- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
> +++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
> @@ -56,6 +56,7 @@ u8 tegra_get_platform(void)
>  {
>  	return (tegra_read_chipid() >> 20) & 0xf;
>  }
> +EXPORT_SYMBOL(tegra_get_platform);
> =20
>  bool tegra_is_silicon(void)
>  {
> @@ -76,6 +77,7 @@ bool tegra_is_silicon(void)
>  	 */
>  	return true;
>  }
> +EXPORT_SYMBOL(tegra_is_silicon);
> =20
>  u32 tegra_read_straps(void)
>  {
> --=20
> 2.17.1
>=20

--csjkOe4a4bB5CbtM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNRGroACgkQ3SOs138+
s6FwXg//WryMEFn2nVhGG7yvCvBIuN0FbNxCLzcnvYvT5tvMc82WFe7CTMBIbhHv
mBFCjYGq2McKAu9u3lyXkmVBrn8+9IeZhux7oNbABG1UYDBBcW9dFf1lfCi4B47/
IpQJHFggZo62o+wHGJa9+d+8I+18HN1CV/4veMCDetByllqRtXVEVaS/uFvwdbaE
VSw2PbBUaVgk5EUMCE90TUn8iaxCkvdqL/zWVityx9ASPPZZQDhz5hmpCgLX5+Vb
+C5/Vh6PwSEYV+Pb+bDzjS50ugtPVoLjGwYNr6gLw6n/LyEZdxEoMzqKWFtQDdsy
cX8Qa5JC+1mslU1FO7FhjZbyOk7C5VFk+uYRsFhnQB+QBGCFTQCjsd1am9pnktAk
Ocdo0wNCAW996RQkjHBwrK7fVMuRmDfAV4oMEzgC8k2233QfM8g7sD4DnaSzEt+I
k6EJikmS0JX6um+UxTQicXg6Gkmauz+rj/6Nv8kPGDavQGZIUiZ9HSMunzRo9n5t
/9CTtyzZT+XcAgCzODqw+kVA1WiVacPVG4zzV/xftrwo8RWeXEBQl3emS87VCrIS
OHEkxSxp0uIYCwDz9x7uSfDU5Qy0EugWZy5rgGFGufmubknLw5YsV1GKLdpcxig3
THyk91RGltq+ysoMKRE2I/ebUjsPQXs5jClKEGFk/9klcOGhO8E=
=AN8t
-----END PGP SIGNATURE-----

--csjkOe4a4bB5CbtM--
