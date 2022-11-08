Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F49662126F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiKHNaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiKHN37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:29:59 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518417079;
        Tue,  8 Nov 2022 05:29:58 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f27so38632997eje.1;
        Tue, 08 Nov 2022 05:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xbk5KvaKCBFjDGxiFClGZRsCdkkDd8jtBj+grZQY+s=;
        b=KLuigQkvkapDRRH4I9tHY1W2ZEN6W4n+frfXdxtwdesyp1CIpRv9kabCsU5zKSAsyR
         zsDNZ6MYNE3g/v9to88a+1OZprC/ijTd1cMBQG9rBqjPxIkM2c4Xn/SvQyAPWySUIaND
         D1DuvetuAPWO+8QPhS8GDkPWgTsnk5wgOOTAuCFlE5RfXqNGOJfg2a/+Oub7hdVHT94B
         jUn1Sqm7n7p50CO2quoZIzHeKKiHcZBI1fT5GnhGpvJ4608fU0fUEjIqJJ7BjI+goWLQ
         YSigRMjAWI3fXfFDKrvStLraFd3FEU1fd3MWHJmNAfakStUmLGVmnO95cdxOeRTb+tts
         3NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xbk5KvaKCBFjDGxiFClGZRsCdkkDd8jtBj+grZQY+s=;
        b=p76EC3YCbsBjZKJB+hMfTTtl3ZpF/nHBjqyAfjZNvTOz25fZLvfHRyHvLSEiBHbd7K
         E+EIFyYDwFGYjKn/GmadFsib61MIpgyNBOJkObsvfuy8pd71DBimavSxC6v/jEg8NjG3
         min78Spvfvo7vuOvLUZcEqWBeMxhAtdo77edfWjbKu7lOuHuP4c9sgIOS0Fzho5v+K6m
         IQ6WqwhyZ0hITf9OL2Z+ZaDmLSv3L0jDO15QVywcDkiSrubUOOJ6kmhiQIUQzsYe/QL0
         dAOS7gmwBeEZ/Vo7WeyO0R4jfHJG7lBusxGPKZur/nhYP3x3/atXYD9bzX6e/N+R6M6I
         Td9g==
X-Gm-Message-State: ACrzQf1krBUTIVfzKzgErL4/dvln61tE2yGbGS0kBLSubllEWonbbAcA
        cpiK1TfvxIeb8bPFw6F7DE8=
X-Google-Smtp-Source: AMsMyM5rCaudzBBEcGQPNwsYtFep8MhqHrkQlflyXUYz3K8Ismsbw3Qw4A9UWUYOKhbP7eaBSw64sg==
X-Received: by 2002:a17:906:6a1c:b0:7ad:e132:bb86 with SMTP id qw28-20020a1709066a1c00b007ade132bb86mr42887065ejc.408.1667914197134;
        Tue, 08 Nov 2022 05:29:57 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i24-20020aa7dd18000000b0046267f8150csm5515086edv.19.2022.11.08.05.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 05:29:55 -0800 (PST)
Date:   Tue, 8 Nov 2022 14:29:54 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        jonathanh@nvidia.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: Re: [PATCH v2] gpio: tegra186: Check PMC driver status before any
 request
Message-ID: <Y2pZ0kQ0ocG/0G8t@orome>
References: <Y1aa3/oJA2ElSGp0@orome>
 <20221026070614.24446-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sBtpdFTNqM0kOPdh"
Content-Disposition: inline
In-Reply-To: <20221026070614.24446-1-pshete@nvidia.com>
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


--sBtpdFTNqM0kOPdh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2022 at 12:36:14PM +0530, Prathamesh Shete wrote:
> This patch fixes the issue where even if PMC driver status is
> disabled still we are trying to look up for the IRQ domain
> that PMC driver would've registered if it had been enabled.
>=20
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/gpio/gpio-tegra186.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--sBtpdFTNqM0kOPdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNqWdIACgkQ3SOs138+
s6FrlA/+LCyj6wLVY4+sOLjWM9pZWC3q10z5N6lN2RtqulMr/Ojx9bIzRD4TUAHy
jSBMthXJSLt21u+4V2SRZFVBDG3ZX2X6xCugB689zizVI7jMtjmJ4eifMMZ/aPuT
/ZI33QJiYyDv9x8QxTqrZ0G4gjJUCqgECe9IukE8+hDN51aiR3Yh4PBOuoC+Yz7K
pmlfQWt0NKydq1Le48tbZsh5RayRam42IGHhVbaKqzKsVhHR5AOlEcSoWvBlg4dF
ss3ZjwUJaGBm0iNADfU3aKEjdrouTFxsZxp1UsZ+LRSj32nD1kEncKgEgHL5Yol+
f3kSbbzIsAl+fbk6uk0+9yo6MyYtK88xyZl8Pxmp3ekKhjZsi5Gw9cy0xzFYWUcR
CUb2gCiRkC235aifkJfvIlz/0msiQrOqpUqM9Q6Hut2PALk+DvAOuDl4W2Ui6f6c
9m2EncKu9puv2CpUZKeFqIh1E/Q6KDcCtZ5YtTx1H+bqjTh4EtmRg+zjZejAF1n5
0Wv6XBaiyjCuT+sTnDkJbRevnDkyN7GinhoToarZ+ivWwkhNqeUycHOVTJlLfBnj
+J1flU3sIaIMgYpHnkZwQ/BRb6mkdYzR1cXaCsdPUPZdoaAmrP5oOpvsJNF+9/vM
NzaLsenD9wHdyJGK9JLROvrd9YTSbVd6KR8Btd64+YqdHkaZTfc=
=Vbbz
-----END PGP SIGNATURE-----

--sBtpdFTNqM0kOPdh--
