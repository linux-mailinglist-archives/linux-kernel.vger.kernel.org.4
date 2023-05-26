Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AEA71291C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbjEZPHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbjEZPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:07:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4DE198;
        Fri, 26 May 2023 08:07:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6e1394060so6195555e9.3;
        Fri, 26 May 2023 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685113646; x=1687705646;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES8RGzB55t5peCsf+F1qK6HWTllCpxRLR086UIa9AO8=;
        b=OD4rLDp6WS7NkFEWaEuAF28DxVQiadDspEfsO3iUNw4S4Xe6gVE8fiXzZpHj74TtgN
         dWbGv1P2QupqV8eAJrfULz68MepOYMu+x2audObTALM7uEDDG2evOOdTF8iYo6lbaPra
         C/ld5W+ED8TVRkvBCDbmYzBy2SyzJlt2Mch6zKVVbRLxRZPDeFJnPULd7MhhwP9R0fD7
         UuD8FHkJJ47MQ012fbD/cWWEiPkLESUdjutk0/q82YvPuMNaRuR9asivfou5tTYn2VtD
         s60KqhvSS+Rcz2Q43my83STjsoEZCBJQOU1B5eWW8Men7Q3yOAevOzdkh3IXtdSLBUv2
         HJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685113646; x=1687705646;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES8RGzB55t5peCsf+F1qK6HWTllCpxRLR086UIa9AO8=;
        b=WQogH1dmZbAMOmR6KEtECd2fUA8cxHxpmEwvkdnOuRZQP8s9I5wK9JH655Z4D5P3sX
         Kd3EdbZ3kjSGAwR776EhJO2qUx6yla+Im5KzRt7m57Q/okQpxxHFYxsG0wlxYD6d7T3e
         7+6l88QSoVwK5TaKCJQsB5dZuNLbhlbam7+plCsC/izNfjmn0LSeflrk2OWxMCCoH0nT
         34/PGaCK25Qi1HzQymiIL7ZNLvXdI/RJpoygK00QsG8wizYQcND4Jhjsi6PEIyhne65C
         BDZVChqGkDJlmsqR+qijh3RLt8qcCKv6yAX7grxMv4wku2TVleNb09lN0zCut4kXosEz
         BIMw==
X-Gm-Message-State: AC+VfDwLfVLBqqzMjlNEiiYwrmGG+EEbeZn0dTJ8ja4oYJqh2pIy/FTA
        WkFspeKgUcAGZspKeJc9Q+w=
X-Google-Smtp-Source: ACHHUZ428hc5Wign9sf2JzvpyOaTZWwegw9VZPHoFoOm1332NbO+hSw/F8yuqxNAwY13Z8I0hOpjOQ==
X-Received: by 2002:a1c:ed0b:0:b0:3f6:a66:a372 with SMTP id l11-20020a1ced0b000000b003f60a66a372mr1691807wmh.1.1685113645799;
        Fri, 26 May 2023 08:07:25 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c0b4f00b003f611b2aedesm5436553wmr.38.2023.05.26.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 08:07:25 -0700 (PDT)
Date:   Fri, 26 May 2023 17:07:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: Fix PCIe regulator for Orin Jetson AGX
Message-ID: <ZHDLK9G-GZVgweIr@orome>
References: <20230526111727.26058-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KR53BUBfyAAKgvrH"
Content-Disposition: inline
In-Reply-To: <20230526111727.26058-1-jonathanh@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KR53BUBfyAAKgvrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 12:17:27PM +0100, Jon Hunter wrote:
> The PCIe slot on the Jetson Orin AGX is not working and PCIe cards
> are not detected. The regulator for the 3.3V regulator for the PCIe is
> using the wrong GPIO for turning on the regulator. Fix this by updating
> the 3.3V regulator to use the correct GPIO.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Vidya, any ideas on why this ended up being wrong? Was the original
based on an early version of the hardware, or is this something that we
need to parameterized per SKU?

Thierry

--KR53BUBfyAAKgvrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRwyysACgkQ3SOs138+
s6Gupw/8DF1IdubwZwxmLiNHzYotMJBrI3KyLgh83Jr3vVeVPRSTUbdU8DnmGYff
dOowMlzT39GqwjAKsX1j/yQdj0PZhDovanvmwAfPqx3zsEkMDS/GVnbvFzDQ6pL5
aPPWZTeIGsjFtsMNHv5SbwDGJKz7xtPUJVD/PL6kbiQWMq4BZxd3PB/sieSWbNtV
ALeuqgvPaoT73xEDj1qmF2IMXCCPD3c9rJM0oo67cNc2rSYRR7KdFsaCyrKgdap8
9dfZdIsVzow0rnsBugC2z8GyVsbm79dmmejU93mtMTnosc+G6bXKv2sQg7wkZOFU
/dIlncZ3093TWaDPLRGqNYHjO9Dx98WlYS/Lq+z31Uvbg6Gvd29r9vF+D/G00VeO
bhlAF9NgnDIEjkabJLr4CYNnodcOOU2IEo/Bb/8boAHHazViSzLgDea2hkswlUQ9
1yPFoeY3/QWGvsPW3FaztVf2/Of+59+7uVk4uwnXsUjbZ8hhkSTOa6gMkj85+gYr
aMje0LdEXj754ZOM3okjrAuJoSvV5jQU254wokCtdgjUsvFusdgwVm+hA9Q3OhT/
iCnbiM7MtKO+3pm3LPAwYfYfF07yXrYfAuZ1pqx8pW9+lf9MiNHHyEiOLqdKxUTt
2Hl+ZG/cupALCQC4eg5WyVmemwXYlRlewPGGYHY20NMLCIgXEl8=
=WzY3
-----END PGP SIGNATURE-----

--KR53BUBfyAAKgvrH--
