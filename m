Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F91B5B9A88
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIOMMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIOMMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:12:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8D6BCD;
        Thu, 15 Sep 2022 05:11:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e16so30558468wrx.7;
        Thu, 15 Sep 2022 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=LPM/AULX8xXLs7+uogOUxKAzfuJtpuv0oPBeLnfAptU=;
        b=CH1OMOjtiwqz7YAYLeKpx1HR4ss1tuzs+xFQlPExYGm64fpkpAGoCji4ONBzn9W5hr
         KyBnhHu306/sHAlQmD7XnaAKWVGclgRsOsaBW0JPOdabqkvKSIu1YFbcA1Y+UqMI3Jc3
         9dcQX6+KwkhuxSXT6I2YUphI2z2gPiCj95dnuz/pUgTklzWoUzObva+FFsWdMjH+8p1z
         zMq1E67lr8Aj4IBC9OXa1UYldvPPUly/7nsmsu5dbMtvo+Ljl1Wg21TPlcz5A6gjIumf
         T6h13cOlMsFRdz8eIEYp4MOQUxiocYQaleVUGnhmyRJyGAyTzJgR6Bd41O1mphQK9vE+
         npYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LPM/AULX8xXLs7+uogOUxKAzfuJtpuv0oPBeLnfAptU=;
        b=wGuQpxYUNdtxzvgorqIZOvuECUZ35TrPcEfoj90BaKvP9Re/JpXWAAy+7R+0Z0sKH7
         mMWyXtEOqYUU+d+2ypt1TXBdH/hmHD0iTi31JoODcRGzrIHOfosxeN6HsW513IPBL9Z6
         eu4GMvKa/2pZwS4JAmPfnhDNXeI9DVhrwUXkR+DTaqIOxHD4g1PLTb7vYrZci7eZkdSK
         FHI6xA1gGoZoWvFXksRfQXZYRlu7W2C67IrCiRkiNN6x7704G3/S0t/wk3fWx0D1+BB1
         8UUabwIusgyagfqBqDYbFBaj/MdKvo4KLxPmH7aJX5qfuyn0vGFugag6BN/IkgOvHuPo
         2cUw==
X-Gm-Message-State: ACrzQf0ehuzi5AVhpYkMksoVl6rfU+/pwNRJWNyP57SpBnYq+jH9opif
        6OmonGs2InpmcatjnJhk4DM=
X-Google-Smtp-Source: AMsMyM6KNXCAIkfB6NDZg1tBoEnF1MIjuOAqFOx9kifr7Kt7Rz6NMEL+V94j0UlHUB2hPxur03DvEQ==
X-Received: by 2002:a05:6000:1e14:b0:22a:c818:9737 with SMTP id bj20-20020a0560001e1400b0022ac8189737mr4854301wrb.515.1663243916298;
        Thu, 15 Sep 2022 05:11:56 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b00228634628f1sm2418444wrq.110.2022.09.15.05.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:11:55 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:11:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Petlozu Pravareshwar <petlozup@nvidia.com>
Cc:     jonathanh@nvidia.com, p.zabel@pengutronix.de,
        dmitry.osipenko@collabora.com, ulf.hansson@linaro.org,
        kkartik@nvidia.com, cai.huoqing@linux.dev, spatra@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: Re: [PATCH] soc/tegra: pmc: Check device node status property
Message-ID: <YyMWiVZm1jAyEHJs@orome>
References: <20220906135117.341529-1-petlozup@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Npy2d1m7ESZZaX7I"
Content-Disposition: inline
In-Reply-To: <20220906135117.341529-1-petlozup@nvidia.com>
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


--Npy2d1m7ESZZaX7I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2022 at 01:51:17PM +0000, Petlozu Pravareshwar wrote:
> In early_initcall, check if PMC device is available for use
> and avoid accessing PMC resources if the device node status
> property is set to disabled.
>=20
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--Npy2d1m7ESZZaX7I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMjFokACgkQ3SOs138+
s6GU1A/9EdIsca8gNvIVWIriSk6N3JY5no5FQlnUXf05gsayIEdev0crlv8OTuav
XCY4Xw5RwOIulDuqZvzxzGtFv8XPoDmy3ZuerXXB4tv/iAWg68EbXqevpJbH1apz
6Uswc5ZbPrXUIx61q/xEpr/J/oL70LygvPxCx35sSNa0m4aVsHJxylk9pgZ9zWOU
rEmJPxiJ1ngXluH9pWo3Y/o8BN8ukdON5NbvMlcHGnfjX/nmb086AE/h6qSxn1Dv
d36WI1t1SW7Ys+MrXV4uu0wlNyYH2VcY5refrx3LdGQjEHKgpNvtpBIV/1R/iSPv
o4quxtmy8NOyMPxIr0hHbxrXMb1cuN9pY0HhCN73KLJEclR0PRPAxEuzaPwWSkvt
p95kvs8UOr5dzZ7SpBTTp5qXQOgPg6YnjEI48v9fRP/Ql/1sDyj0x+QByEICER/z
GioXcrCSnITC9mNbmmpmn+wIhlBZZ25OKJihiipypI6LA4LEqLW8zrLebXhVWUAQ
bne4ymN9uYOy9wjWWb0df/CyZY/tAt41HH7xrEksVyTdN4WyJi53u+Z0QMwfpqdc
Ho6y6bZ7XEyMwybGXXrj2KL4OLUDe0PcwWu0NTUMWxCW1HgJwJPFpV7yen570bc8
5NT43Xr4CS+KmU5ZaOz9v/OfoMEt0FCw/9wBDhNV9/EYmgQw3CI=
=TB7G
-----END PGP SIGNATURE-----

--Npy2d1m7ESZZaX7I--
