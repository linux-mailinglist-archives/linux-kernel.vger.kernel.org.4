Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9D25F76D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJGKZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJGKZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:25:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60B642EF;
        Fri,  7 Oct 2022 03:25:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s10so5199338ljp.5;
        Fri, 07 Oct 2022 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDaLz05Q12Kw8BNKIwG6b+0mlwsTp6ntRFoc6GuHvLg=;
        b=Lz2lu8nAjo0jFAi1PWeGe1mBwxOH7WLTNOAVT65hCjwkgXHOXuMmlaLzLH0j+46OLG
         B4sVA1/AfoLvf8Vm2uZJr1natq+uLC5HD58h95hW9kgcA1CQrdAdf0F4ZsZbHBf+TbvY
         fZfN56yB3XEYiK6gxXnw5FcdweSgYFxRoitBAEw8WlvbDTs4WXoKKfg7WwxGlZI1IMgY
         e+bh3WwL3svVHsEDPoITCYvWX61VbpY1gSCVxIWkj+I7vZoxRfJIv+wXNZK8aDtc1GTm
         4KqTfig8REI4A+krfyDAZn5++frNPEjZTBj0vJw0VpdTjyKZTii5c7NemR14ar9alvVH
         K6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDaLz05Q12Kw8BNKIwG6b+0mlwsTp6ntRFoc6GuHvLg=;
        b=R2Ajksh/7VToRUwildIc3Fa+ed3+KE0uqmVHZmgXoyStB1BBIQR8tG6Bst6hTOKazg
         y7JSVcKJrkHdlXAxFFpBUs9NnKM5IgQBD03DJ/mEXVr8WIf6/JKE+91P5xHZ+Q3dwtuN
         yZiCHYvw9XvnuhTUvzwU6QMap57BWKXQWfCixKIKmUgXYeKfq5NFP+B6ZqJXsMZq0tBJ
         v8glUW0qgRbm0EQVoyl4Apx/TD4+YpEbAY1H6/VO1X6dq0t8SViZEcpkyooeNfjuqQIH
         n5XE8aJX0moS0Cp3ZgpyZ5cVbEREmzrv8Wxdy61eMyGyZB5Px/DkRK2hatKycWfQH3O2
         Rqmw==
X-Gm-Message-State: ACrzQf0QN6iejimWTWAvtpWt/MZSJvJxgWmsRgItepi5UvaJCKEEx4cI
        YhRX8Q1G6UmKEc2vT1bv3WJ26fHRSvY=
X-Google-Smtp-Source: AMsMyM6beC/6ng/3+Z4qK6rhhjuV5EDj+R7iDlS4JH5CEEgDdVgF0PXSixcBUCNQDnstIbzB0WXr6A==
X-Received: by 2002:a2e:9d05:0:b0:26d:cef7:bced with SMTP id t5-20020a2e9d05000000b0026dcef7bcedmr1461190lji.41.1665138317596;
        Fri, 07 Oct 2022 03:25:17 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q16-20020a05651232b000b00494791fbd80sm232840lfe.307.2022.10.07.03.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 03:25:16 -0700 (PDT)
Date:   Fri, 7 Oct 2022 12:25:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        jonathanh@nvidia.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: Re: [PATCH v3] gpio: tegra186: Check GPIO pin permission before
 access.
Message-ID: <Yz/+ijx/QbUMzqHV@orome>
References: <Yz62XmiH8YG3Dtsf@orome>
 <20221007055936.5446-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ApYiFk6+lskJE3RH"
Content-Disposition: inline
In-Reply-To: <20221007055936.5446-1-pshete@nvidia.com>
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


--ApYiFk6+lskJE3RH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2022 at 11:29:36AM +0530, Prathamesh Shete wrote:
> This change checks if we have the necessary permission to
> access the GPIO. For devices that have support for virtualisation
> we need to check both the TEGRA186_GPIO_VM_REG and the
> TEGRA186_GPIO_SCR_REG registers. For device that do not have
> virtualisation support for GPIOs we only need to check the
> TEGRA186_GPIO_SCR_REG register.
>=20
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/gpio/gpio-tegra186.c | 78 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)

I like it, thanks!

Acked-by: Thierry Reding <treding@nvidia.com>

--ApYiFk6+lskJE3RH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM//okACgkQ3SOs138+
s6HTlRAAqp3IuKkRh2nsqMofRgcg/VSlgx7GJ6SNjs906+WRNWjXXCzlIcepJi2H
BKUB+9eQmtYSxp/dtvivrr07BpLQAAdSiLKN0BaDdbytmfZeCo3P7NndFGWN3ilj
865+nutmPgoindb+tC3y0jlN4jxJv3YhZVfDFMIA8vNxUXhn++bzWWFl7kgLzR6K
bcNDasurDDnwCO4W0ss+FaZCGdbwH4DGvGPUe2oVJT+EHJMKWtNOkClwnR+4Aa94
joqqH5eKdqlpOQPs/GJHUbWnEEQzzyHTUWdwmBSWqRPsoWpfizt7kFUKAjvFjbh2
/xoMOet3DgDNjP76fT9pW+VOMH7/PEbIl9DkeN42KkjVE5Jc0xbMmYIcxTB7c3sU
vItbdpVTnH8dPiMojTKJMYsBtNXXcXeoy7CxvK37fKuHK5+u+qV44U4fl2fAsPa6
gpIL6sF2FYt5g3x/wdWXRUhXE8tHGjlCXz+s4KSBlMvbTmSUK2wZrV6iOvY7PAnO
gCBphsuZNUJRqhsMhvlav75SaB2gug587OWfgIeozA/W2mYEilYqYC9JXhlu/uEl
ClUIprnVsZoVgugYQQ+3OMlap43gAFpk/rZgmNy3AwoJUxJR1YSb40qYF9DQIcM6
h8u7cln6o8T2zy1HBHsA2Jx1x34l+1d6saJyZiXQnoBWcVu5sO0=
=Ci/Q
-----END PGP SIGNATURE-----

--ApYiFk6+lskJE3RH--
