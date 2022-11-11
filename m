Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FEE625ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiKKP5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiKKP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:57:06 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B461120;
        Fri, 11 Nov 2022 07:57:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i21so8164093edj.10;
        Fri, 11 Nov 2022 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSd1W9KaiQ/Vxkk5Tbqh0CBM8cHKLe4bD6yR/hl9Tvk=;
        b=QJO8vIRF2KfP+7NGmGuwdNZzHjimcpGFrQdCW76IQ9300GbT/Y+rjPcMhixPJ8l0VK
         V8VuJis1WUF7nBFbjv5aZ6ZN1En268uzjxz8AUTO1UEu/TF04z6W7v2iFv2kyCcy8BVd
         RPPSHLBkqp1YgZBXkT8XVBuYoEKuwpFJtRX5ZU/riEjyJ/V+QodtPf06FWvVP8syW1DT
         Bo3J6ByeIUAB8jRq409aL5v/aZeJBs2Z9rMq8ln4396oJbuRO+H5+bSasn7LMd6cYXA5
         N/RF0V4pw55LTaoGPFxZawpIzlta9HMBaRC6x8MuKSsWqGsQ3o3dzgEP4hx8np3nplDQ
         Ktkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSd1W9KaiQ/Vxkk5Tbqh0CBM8cHKLe4bD6yR/hl9Tvk=;
        b=sa6bmC093Q8JZgZoMcdHE90oZq9X3o4ymST5rwuKPK5OdAzIXfjUCYeGaBM9ygK5oG
         J8s9qVvEPTWy8UwMMNWl2ZpUmWeG9j4ZqoN6zabzdgkq8OccAqz26rmVSc5NHamKMliS
         kjA7Y4GM3fVJyU7Rr0Tq3FIjBrp3S8MuGpwrcWoVJuK2ofGDYVPT8iERCFXsFGzRtL4F
         MA2+tLlj1HkqnzW7caqSA0hqeLZ3Qi6ybS1UIIK5Kj9rKOFmCxhCty+YqVCOnIWZOinx
         V/TYGpm2RAzSwbXuSTHV9QVvc7NffTIWvOQ0R7sLFJJykjdRGXn4Sp7bRF5jFVVmfr/q
         XvFA==
X-Gm-Message-State: ANoB5pmW4ISVF81QVmp9n9p2JsUSIQ5TORBUx3MDBL6wDcwUyHAMGVOB
        P2Rp8liop2uQnYynWmx5cx879IcF2gA=
X-Google-Smtp-Source: AA0mqf5NX5Rvl0cu2KJ/QAcNDoIjG09dRaaghNXLeTANBL1W5bqReHpIpvsnDo2jz35UuNhbnREm8w==
X-Received: by 2002:aa7:dd0a:0:b0:461:524f:a8f4 with SMTP id i10-20020aa7dd0a000000b00461524fa8f4mr2058277edv.260.1668182170034;
        Fri, 11 Nov 2022 07:56:10 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906118b00b0078cb06c2ef9sm1027107eja.8.2022.11.11.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 07:56:08 -0800 (PST)
Date:   Fri, 11 Nov 2022 16:56:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 0/7] Add Tegra234 HTE support
Message-ID: <Y25wl/C3gJC0GLV9@orome>
References: <20221103174523.29592-1-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DdrEW+XUNwnSlmwF"
Content-Disposition: inline
In-Reply-To: <20221103174523.29592-1-dipenp@nvidia.com>
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


--DdrEW+XUNwnSlmwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 10:45:16AM -0700, Dipen Patel wrote:
> The patch series:
> - Adds tegra Tegra234 HTE(timestamp) provider supports.
> - Updates MAINTAINERS file for git tree, mail list fields.
> - Updates devicetree and API documentations.
> - Enables HTE subsystem, Tegra194 and Tegra234 HTE providers
> by default in arm64 defconfig and dts files.
>=20
> Dipen Patel (7):
>   MAINTAINERS: Add HTE/timestamp subsystem details
>   hte: Add Tegra234 provider
>   gpio: tegra186: Add Tegra234 hte support
>   dt-bindings: timestamp: Add Tegra234 support
>   hte: Re-phrase tegra API document
>   arm64: tegra: Enable GTE nodes
>   arm64: defconfig: Enable HTE config

I've applied patches 6 and 7 to the Tegra tree.

Thanks,
Thierry

--DdrEW+XUNwnSlmwF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNucJMACgkQ3SOs138+
s6EBixAAsKlQJbWRY4AIH9s8A5zrtjBCyzgynZHny5RuuSIJMGnL6d0Ers1eQ4cS
+KHTqzVsPwklKM6ndOcpEMjbji4nTAb4H2DN7dkw7NxDFYxgNA28PGmAibBpmms5
eIhY5TJKdsVfwKSaj/0KR0pNVn9FSAbdKtBGr8n2WFreMINVA8q3Lpc4/FJAbAf5
i9UvjNVXY1Ult89pI6EVKHQToYPLZbjWaFyZB/wLXsqLtGUbCCQEftKFLbqemkd0
pMlDTK9F7N2Jj36Ut2XBgLQr7erupgM//IQ+UokPJ8S0y6xkAIc0clqydLmlBQKg
tybntnbRcLZ4YNtpHv7PpUSyg/P9LJ6VSNz9L5vkPjuAajnkR9iQY28Y6+DuEx5p
KkINnMjgHcAHFDrKmjxbk7KJDIOi8/jdsCNV3Ja8j/mICefnv705NSBjJhBRlF2x
vH9SDVgkRPMaFQ8quNstchyr4nhkUjdiVBR0lFyYiv/J7xHohqpMoFvjHYE0Rdm+
+qZrJoOlbNbtW7LRK1gImhnMAOqKc1KmhdbJxfAML5MvehVjdkBbhvuOr33LU0vY
v5LGWehUyaGq76KrAr50UglxRlNnXwG9xUWhxESZd1FP08AERjdqyZCiqojCMqEZ
XtanmlhC2I+WwQnN4Fbo6jMhhqPY2QUlgzcgQt703hUszSxq2eA=
=fPxC
-----END PGP SIGNATURE-----

--DdrEW+XUNwnSlmwF--
