Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C2D62E86C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiKQWah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240285AbiKQWa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:30:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A8B7C011;
        Thu, 17 Nov 2022 14:30:27 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x2so4698912edd.2;
        Thu, 17 Nov 2022 14:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZlYZaMI0i0q3ZjoRIRUu8jIac51V1AtRy6iQMfIMg4=;
        b=qjE+5ZsLUKc7pRZyK7eqW35RUiMBBUxSxhfPNHYMlPkZZBocoQP9Wd//S/XU8O3JMq
         +nlS5jnSQL+QfneBM7Oj18HNPzcUKtOdmkJY5Z+kYWGM0mhEo/KiS0aFFgFT9KMzPybd
         R1gyZdx4eY6hrjQx3h+If4rP5u5KI+z8x/+Kp7JGA3Nbb8+MwMzEe6C6tdhjPqkFKhs6
         lbK6umwPr+DT43sW6Y4HMmqFS87602K6AKO4GBmB0QQKLmsVFz3NHJORP7aqHqwx3Nyt
         Fb1nl0rwX5Ioew7o5MHPtJ3OwZHXLBJEodYHe90ivV4EJb4EytSCGm2QYkz2J0JwbiKm
         In4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZlYZaMI0i0q3ZjoRIRUu8jIac51V1AtRy6iQMfIMg4=;
        b=VHN2JF3nPbaaPdrAEnkeDt7RCc2NqmZzNoRtzhHE4QCA8cHzjlaJ1IB139DxuwbXYd
         678mrslYU6KnX6QldAFqnnA9H+Hqp7qw9eJyFR7th6321yKwyeJjDsvMRccPvoB5haCG
         vIMYUtYBGAbt3UjU9heAHE9odhoq7h04c9ygHS4+3+RTUylv8JzrTu3UpKQpmTxv4MLU
         ZHvgXM8+b5hcdT7AJYgNXvG6CjvR9reGYHeT/aOjVq5I+NWoD6zFWc9PeyD3bLVf+eHJ
         m0IM3Hl6//X1V8AWFBENQihS3tjKa4rV+uyKfV7XJRXfKA6Ve/L3bBsaP647gHJJAgZS
         uc5A==
X-Gm-Message-State: ANoB5pmJqk0iR/F8coABuBX5W9+6TVT5MnvX8hVjRrz4TJGdqNK1mLPj
        ztI7ITVyePUKWZJl4bVuOiOXELHkCgk=
X-Google-Smtp-Source: AA0mqf7XGxoc02RJpZgXj8OMj968pLbmekhchhOXtxDfpUM+S3h6xHWwRkX97YHZoxR4F0VMgAY7yQ==
X-Received: by 2002:a05:6402:5289:b0:462:70ee:fdb8 with SMTP id en9-20020a056402528900b0046270eefdb8mr4024266edb.66.1668724226172;
        Thu, 17 Nov 2022 14:30:26 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u21-20020a170906125500b007a7f9b6318asm898955eja.50.2022.11.17.14.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:30:25 -0800 (PST)
Date:   Thu, 17 Nov 2022 23:30:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jim Lin <jilin@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Petlozu Pravareshwar <petlozup@nvidia.com>
Subject: Re: [PATCH v7 3/3] xhci: tegra: USB2 pad power controls
Message-ID: <Y3a2ABwfrRgASGvX@orome>
References: <20221111101813.32482-1-jilin@nvidia.com>
 <20221111101813.32482-4-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NU5b/l/UYHATU9hL"
Content-Disposition: inline
In-Reply-To: <20221111101813.32482-4-jilin@nvidia.com>
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


--NU5b/l/UYHATU9hL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2022 at 06:18:13PM +0800, Jim Lin wrote:
> From: Petlozu Pravareshwar <petlozup@nvidia.com>
>=20
> Program USB2 pad PD controls during port connect/disconnect, port
> suspend/resume, and test mode, to reduce power consumption on
> disconnect or suspend.
>=20
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> Co-developed-by: Jim Lin <jilin@nvidia.com>
> Signed-off-by: Jim Lin <jilin@nvidia.com>
>=20
> ---
> v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124
> v3: No change on copyright
> v4: Remove hcd_to_tegra_xusb() function which is used only once.
> v5: Update .hub_control in tegra_xhci_overrides (xhci-tegra.c)
>     Invoke xhci_hub_control() directly (xhci-tegra.c)
> v6: Change author to Petlozu
>     Changed from u32 to u8 for variable enable_utmi_pad_after_lp0_exit
>     Modified tegra_xhci_disable_phy_wake(), tegra_xhci_program_utmi_power=
_lp0_exit(),
>     tegra_xhci_hub_control()
> v7: no change
>=20
>  drivers/usb/host/xhci-tegra.c | 125 ++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--NU5b/l/UYHATU9hL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN2tgAACgkQ3SOs138+
s6EuVA//TL0LyZuNMsPd4otru2NpRQqXptr6yWZDbvdmRkcDImGoJxH0YO3jifBA
g6z0mp45YM8dvoFtlpNJWSvMGqUSj+ib3ES5UG1P9YOALA9ileBn2waLG9huzwxt
gJ9v9ihv7lMcpLGJGwNmXq+33FKHDMjA6tEJ5Oxf2dsTSL1uNKNfBEff0a6Y0jtI
u5M4m8rNuWRXzA7kRzWXVhVIEwAEUSs//CGnBhtc2bghW0XTv9hGK6VvKNB5Qxoi
osALx3hA+sB0yXKZva2iqg56+4DeE7eyt4/1f3Vk70VieRYK3vhBK55mmuYXT/TG
coOox8FUK8c/Ky2dVObCpApPatb7uZDkbnrfj9prxg92BDdSSJI3Bv3FdTiNyaas
XJfBhKNypdHjUibJ5RwvjKP9rdpztJj5rN6BmPBlLwp419k9PTCALDqmdAJ6wTGn
MFVYvFeHj01sAKy5wPS99hYpa3Rvm3JT6vQOiTJaaHubInAC+/Dkcms4dAk1kozG
/xv8pjaN/Wh/rcU0R6B3lK/Pb75bCc7skDiQJ+R0vl97JbqBEevonT2KwN3g4GbH
WReykc48GG9xwJxvmQTExiqbjDKxZMccYrrnrpih/y9WF/g8J/JwdBRqN9dT2zAh
5UaIWAuOuC0PnHYhS8ikrT4qeoxN6hTUpwLh3Km8OpFc4h81nfI=
=EAwG
-----END PGP SIGNATURE-----

--NU5b/l/UYHATU9hL--
