Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA062E7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiKQWPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKQWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:14:58 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBE7E0F9;
        Thu, 17 Nov 2022 14:14:57 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id kt23so8618270ejc.7;
        Thu, 17 Nov 2022 14:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dEy2MWffxARTA6zpS6WOEHguSrey9IVoa1qUoLFPs4=;
        b=SsvdE486wdBDaI76GLLefpDMcukxSC2ydeKO7li5+P8D/HufZpWnL4XqybMcFXTFFQ
         EJX1qOsg0PFY2nlHwGeCAn0/tgY8T2QgNhzk3rnMs6FPHbtRSOqoH5aiwSiRAOx6aJDM
         fgDr3nAo2hmCTgWPdNpXo7Ufobj7r0oR/F+mntl/2WoYhJ8r499RGjVREbdYUSlkbE5f
         UIz3thBewuiUQBcJl7uWhJ3E+IIElopwoKRNGqGSGWdQ6k3WzkT3RZWUgB0JrX1VZxvl
         4v461OkclKir2WTqNn4bo+2nNm+hDfUo/Z2jVFhueprKISk9gz6ei/mYdRZ2TUgdKdHo
         x/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dEy2MWffxARTA6zpS6WOEHguSrey9IVoa1qUoLFPs4=;
        b=ic+qEbnALG1XwPoy8BdMXsda0KaPXWBrFqHoRdbwDJXGTazuRs/UDMJPlYlfMFOtKb
         bKapSpCWJiml56oeVNc50dI3GPS+MlPK8Nv04rEv+vvuYfi4hjbvHFykn+cIDUY+HUSl
         THAlGpPvfRaacnGW4oKhS9FCPdNQP1kP5ckvnzaDqCvK8GBI66NZhD8J8zsO3vQc/wy6
         wzqEWIB6TVHF3MN70gPIDSqK+vQC0K+6ZJ50OVcJoq2z26dsOlO5G4nO2cEduRxRFtqH
         TiYkN9FeKtPiyN40qWL161QCVjDIZqO+GqxCE8jPfaJJLc108jUuxYF0HGe3qOnlgydA
         kPaQ==
X-Gm-Message-State: ANoB5plSO6EuwpYcF5NMxPSaW51Bs2VDnaJWXNUwZ3Jc5IFuVjmta1u8
        7f1o/y/OlEl1F4v9XJrIzQ8msnxU1S4=
X-Google-Smtp-Source: AA0mqf5HHmn9aGkgvNgEdSfyi0YoolnK75N0aXwLkLPDfM0HyM1C03peox32AgBn9Clt3mqbR3NFJg==
X-Received: by 2002:a17:907:d042:b0:78c:c893:1965 with SMTP id vb2-20020a170907d04200b0078cc8931965mr3659378ejc.247.1668723296241;
        Thu, 17 Nov 2022 14:14:56 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s22-20020a1709067b9600b0077205dd15basm885027ejo.66.2022.11.17.14.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:14:55 -0800 (PST)
Date:   Thu, 17 Nov 2022 23:14:54 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manish Bhardwaj <mbhardwaj@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: tegra: include IVC header file only once
Message-ID: <Y3ayXgIRy4VbdiPy@orome>
References: <20220922102627.16705-1-mbhardwaj@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zcYlsKaSwNVzHDgz"
Content-Disposition: inline
In-Reply-To: <20220922102627.16705-1-mbhardwaj@nvidia.com>
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


--zcYlsKaSwNVzHDgz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2022 at 03:56:27PM +0530, Manish Bhardwaj wrote:
> Add the necessary definition to prevent compilation
> errors from the ivc.h file being included multiple times.
> This does not currently cause any compilation issues,
> but fix this anyway.
>=20
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> ---
>  include/soc/tegra/ivc.h | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--zcYlsKaSwNVzHDgz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN2slsACgkQ3SOs138+
s6EkVxAAnTnoskRCD7m1CAL+RyukULpNnsNkW3cJen/TppR33yeGnjobJeeDhJaj
hwGCe1KCzVdS1UFgkHVJtuZ0MiGn8M2sZWRvpCNPh7BLQ1PaoNsSBTJYPA3Zbsdd
cDpFci0ZVuaFGZEi4Y1uDwKvU/8DYVnD5f1RcfoPrG3VfliZD+e8oK050V8nNsV7
626tSCTcS0Jpe99F/mJMnbku8l0G8aNVYIq4kO8UkPfezb0Fk+cOpcB0/BJ9TDBz
TePS6ogNnSYYr/oDTb6H6XVa4OmH/0BNPRcMkqtI0LvGMfg+UtqZBbMt3bA9YD4R
N2pf+3rsrIUUuNS4ERQSAaHRqj74kWllKOCEgvzMGSXbr0PNtZz5eiYPUTlvBgFB
bosXJ9SIgXiOBCeVE2LhNMVIqdUxVk0qosWop+dyQLTArRrbyZI99RoOzGuZA8S7
q4MG4I+W4myqiqkUtpSgKwmRBqJKT/qdV08UsnQbIc+ZN4HEP8aIfC2j3NLYBzmU
U029HWJOqepUzFKCNYv808S6Li4GyBYFb9oeeexXf8ueqnGIVCD5HdWTcUYduq4V
6KHIyNuUvnqI8oGMSwFaPHr908BtVSsr4mHUh46BMrHpUxYMl46PeHSVrfXUnpp2
RWG8E5+cdv8j/39MvTJtk/VMd5m49ebGjkw5rEacObPnVlcPuFw=
=jMO4
-----END PGP SIGNATURE-----

--zcYlsKaSwNVzHDgz--
