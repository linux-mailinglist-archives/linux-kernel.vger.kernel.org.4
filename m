Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519CD625F19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiKKQES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiKKQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:04:16 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230791120;
        Fri, 11 Nov 2022 08:04:15 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id kt23so13523894ejc.7;
        Fri, 11 Nov 2022 08:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RYiINc4Bd6qZGurHjg+i3dUcjtgpz53hBmH4uiN6W8=;
        b=bpT9H0VSq61mtRaB+w+MwktB4H8/QwY/fZ906ouZhTn7IvSeYM5mJ1dmM8UY3XU9P3
         Nssj9gJ+/0Kx9r9vy2aPbh4f87J/ZqqPrjSQCuCNMOVGK6lwgfBtebBlC5yuE5BSYOO9
         s1KGT107UMiVitYYZmmutd6EIE4P1DDAMda/kxGKZyBzRmExtXEF0Eo0GOuiWWN9dESl
         XNXbyAUTmwjcvW4xN1WHG59CaOC45Ja8j7OhpMzaIDhYR5zMv/u/v00KaZeJa4T28t+n
         cIjB8Y5H/h10YF9Jpqfn82YlNVCkDtZAwqMfjaLCdAL05zDsV/1y3kwGl2InZ5WDXaMU
         /Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RYiINc4Bd6qZGurHjg+i3dUcjtgpz53hBmH4uiN6W8=;
        b=FjHNURBsepfPDHWNCpZGQfceuI66ybSUMci41B8w20D2WJF6nJWWdUcXGalnjkyWJc
         THTAvdZ2yymOb1MPcqAkHrhgc15WYegzwBoFEY5+W7db8lcY7J+0QdZWq3z0WS6fby4D
         hc3ghlldO3V2UIzH4oXT0XZ2rVoNMJRKmKaBH7V5ilRlT1KimjvLD0ZfYwV/TLnB8B5T
         Yk8EUu42kZqGOHyS/Dn4Ybtr9WdArJ1Tzu7BxDrrCe5YI0H1yjsZNx10STg1dEToh+of
         lvo3DJ3b/IKEGTOZscjc7zFwnlHtnJIHEIPuGvyr7KAaAw4miDLTRX80cWGG1Su4t6xH
         2gjA==
X-Gm-Message-State: ANoB5pnsVpDHJxLE56K2CIzT6uDVwcC3vPdClkxt4GrIGkB5SvAMBvru
        xFmkpIwzcx4rfpk8LoX7prQ=
X-Google-Smtp-Source: AA0mqf4AUdHpt/P34pxIzEAXU6V6SkqQL2dQgB7e6fxY93k0WVMr3qmlCKRO9BLsPmuDRIS0pOAIAQ==
X-Received: by 2002:a17:907:7681:b0:78d:d10b:4bd5 with SMTP id jv1-20020a170907768100b0078dd10b4bd5mr2362294ejc.467.1668182653487;
        Fri, 11 Nov 2022 08:04:13 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t18-20020a056402021200b00459f4974128sm1239843edv.50.2022.11.11.08.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:04:12 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:04:10 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: timestamp: Add Tegra234 support
Message-ID: <Y25yerZJMwKWCy3+@orome>
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-5-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OI8OX5lQwVXJ1cTS"
Content-Disposition: inline
In-Reply-To: <20221103174523.29592-5-dipenp@nvidia.com>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OI8OX5lQwVXJ1cTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 10:45:20AM -0700, Dipen Patel wrote:
> Added timestamp provider support for the Tegra234 in devicetree
> bindings.
>=20
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  .../timestamp/nvidia,tegra194-hte.yaml        | 44 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 4 deletions(-)

As I mentioned in the other patch, perhaps we should extend the binding
with a phandle property that lets us point directly to the GPIO
controller that a given HTE is coupled with.

We haven't technically started making use of these bindings yet, so
backwards-compatibility shouldn't be an issue yet.

Thierry

--OI8OX5lQwVXJ1cTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNucnoACgkQ3SOs138+
s6GgsBAAq5eiY8YLwRzd4588a63jlCN9cKM5G6WCoqwddVWxf37jY6Yf4tN1sQ9h
RBmozpq98vzV0IbMFAfxGOruhGetjgAnksZT8646hQQ3I7neGyqH5WYDpNF3m06e
n7eTrWxUuVGhVjesrb2uUh5xNVBE/ovrGLTZeDMxtxrNz30SPDpbYesdamf0Gykw
DuEy8N+9CqH+mqyrEm2lpnHTREI8RdpS3GvmI9R9eFXFoRAsmseh4oyRhNaKXhk4
vqSTIuq4HKh+7DcShUAx4zRDOVyspS5deo0tXi/iawwSCDzx/siy/Q9GsrvnC2uX
yVibpFEqvzN7g3BB/Hf5D69ojnA3sdubEZAS1V8Hg9sM+vAfAsetyGM3nYvoskAQ
5TxNrhhv9+Gv9WDfjAibhsmYMhl+yfWdDzy1nvsH8j0Cih/SIFmHp1iYdLSf0bg3
bXdt8niJNjJgbQhLLDDbAhekeZzJM4cvzzIToJl1eOUEahxq4YAy/qZ3Um9XI7QV
sDbA4jJykgbEXMRJLHdwowCAvbnVpjZytp15bX9uOU6tUwoni4oEMzkV3gDgRIW5
/AIsumuhyyAmxoW3WmKxrCBDojaYN+KFGCMMK8atFrrMQV+NuttPrzpuGTY3IdfA
g8V3pLSXR+eQQzBsWlFkz8uo62TMEvaizeW2ZE6m9EO784fStSw=
=7qDJ
-----END PGP SIGNATURE-----

--OI8OX5lQwVXJ1cTS--
