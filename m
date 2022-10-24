Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6426E60ADFA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiJXOm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiJXOmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:42:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764A8F4180;
        Mon, 24 Oct 2022 06:18:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m16so30981495edc.4;
        Mon, 24 Oct 2022 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ICJRxZH0RUpiutp3YbkbCUI9oCvNwfygdd1JOaKdoo=;
        b=hAbJ76RJsSVi9rOp9fShaB9sC0hbYZsP17LtWwyfIN9yERneelucqWPF06HZXS36JR
         ap4N+rrjvE8r22XJWqMW2s3ZgJo98QNDV7Kr3LFYcXjWlehg5b91u6BpITic591ki3YQ
         hGuyWVfFK/D/VO1oKk8iFVQ2BK/HxyMzw8Dy+36CkPKnlPHPv7fKlD9CvTOu+LZuBKI3
         xMfYBmkyXeGiVMtmNlvR3U+QQQde1xV9krR4BCtTF6ngFSvispJKzJ9aVmktRhj8JF56
         2EYkYeDWLHSJULcr96ZblNk6Qd0scq2vDhTIKLsOAnG9yEW6nZqx1/TFPEmnqO4XcY3r
         WBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ICJRxZH0RUpiutp3YbkbCUI9oCvNwfygdd1JOaKdoo=;
        b=PjfNkapiB+nxkOXPqqEEybB7/o25EBVTeON0W2BA+lUqdu9Rg2P83RyKI428KLzNBs
         Sr9gvwNm9RwGqwLw6i1RyHgQW0Fmxxfblf//Isf7eTMO1ckXkMR4nZlDltgnFncZN8hP
         vRJH9nX714uXGn2FPsx9Qr6qOeXvV1nv7cqO4J4tseg3opx2cbqn82J1SXDL3NOYGC4P
         agF2HR+pwyH6+UL8oldFe2ZcOBPOOa1sx5rFrzRyk3uaVAnwgklKhd0mzrkNdKOhK1M8
         WeGu+7YuedXD/zGtTV8h7L4nVTTcUrRidfSbkfmkeEYcvzOR54X5sBCbVyuMKZYbGXVw
         IGKg==
X-Gm-Message-State: ACrzQf3ZPV6qtf3UD7U2fGD/ayY9NpBvqOXTNjTJly1U1CVraJVcZ6Ai
        I9pDbeYvJ7vPzAE66XjZQWoXuvFaqGY=
X-Google-Smtp-Source: AMsMyM4XWRNqnZkkyZP0VHD6FJw7YrdgS2D2rBdncvPGiuQ2162GtUIlTAcu/v0nCQwUoXYr7Bb2JA==
X-Received: by 2002:a17:906:5dce:b0:78d:e71a:6e0 with SMTP id p14-20020a1709065dce00b0078de71a06e0mr27112534ejv.360.1666617385459;
        Mon, 24 Oct 2022 06:16:25 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lf18-20020a170906ae5200b007aa239cf4d9sm765350ejb.89.2022.10.24.06.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:16:24 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:16:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, mperttunen@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] arm64: tegra: Fix Prefetchable aperture ranges of
 Tegra234 PCIe controllers
Message-ID: <Y1aQJvrpfpueeeLa@orome>
References: <20220928062731.18032-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUB+8c/MuhUoy5ym"
Content-Disposition: inline
In-Reply-To: <20220928062731.18032-1-vidyas@nvidia.com>
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


--fUB+8c/MuhUoy5ym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 11:57:31AM +0530, Vidya Sagar wrote:
> commit edf408b946d3 ("PCI: dwc: Validate iATU outbound mappings against
> hardware constraints") exposes an issue with the existing partitioning of
> the aperture space where the Prefetchable apertures of controllers
> C5, C7 and C9 in Tegra234 cross the 32GB boundary hardware constraint.
> This patch makes sure that the Prefetchable region doesn't spill over
> the 32GB boundary.
>=20
> Fixes: ec142c44b026 ("arm64: tegra: Add P2U and PCIe controller nodes to =
Tegra234 DT")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--fUB+8c/MuhUoy5ym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNWkCYACgkQ3SOs138+
s6H7TBAAiv+ffzj8R37kH4ROZ5iKBTXm9qBUOe9FxkCm1S57aioqxeTL6fRlpjG3
FKP6HSOWTjCSLxizOMns1R/qRVl5QLd/Ln5MbncagivcsxnyaEnM0jV7thAPocKI
2e5HLrpvIMh6xNQN+BmXcNefURfNNirlY2Aj+KIsq2bhG8GDCYl4hQolnIouVGJ4
ZQoraqc2Z35pQgmCZsr6tLwaLrxmjdvJ8u0wloUDfCwiaf+W0vBemhgGf/WnVg3E
njKbd8vMP9hELuAJyKgN4DTzMFUS79MGDdXPN/S9/dxBS+6xBF39dMBo6KchTjqh
wtKgC91LOSm/ZqsfH1JgudznS26OMR0hFdg42bNlQfypSotzwij2SId0Sdocm5dP
lvZsdqv1Etb26iPtxL0FRHSEF/Dz9Zo0glvutWVdAIasaNzZYcVhjnwne7qlvBzu
+IVGNxUG33ASuI4SWOoo/hhvksLOAq7j789593nJTk+0a9t9yTwuxD1WjZBdla0s
1DLIslLNrIGMMo4UoSMd0O0LZec6yeNdc/ImW9FXSlOLta+SoGsfGwU2m9R047yK
QJiVDHtDzcvf+ierAaJvfXnm7yWziCp4WV7HuaXcv9iRnFMZ2dY3g9qqM9acyq1V
in07La0upqk26/7Jb0+QFoLBLoqWJdiRHPFBc50AAZvnYpcSCFM=
=QODt
-----END PGP SIGNATURE-----

--fUB+8c/MuhUoy5ym--
