Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0272F625EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiKKP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiKKP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:59:14 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B30B1E2;
        Fri, 11 Nov 2022 07:59:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso3389254wmp.5;
        Fri, 11 Nov 2022 07:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohmJDlGvawHM1PU67AFGw15XY9I6v3mJN4cAPcGaOUU=;
        b=UeEznNUpH1I0cqZJ9qzwmXlQVmqqZWWFEC0/7sbIdlioNq4XJAa438LfFyvNKVmqse
         NUlBiLWA63ENhwbqdvbrfUqCG6Dqg/tJ5MwY/7vKoYWRwdIcsIJ7oHwP6mfdzT3znd+Z
         iulHcDIvX4N3xLz0sOmjslisWNucgZ6JNeUOp/ddNrw0ISM5IhC/Yof+NsJtmrbgqd80
         b7I0nSNnAhxr3SGiPsZaKpYshxJhcOwtSHwwy1vAkhuD7B0BTuSNZFEOKCip3FeGFOwG
         0rNe4Vn0bRbII6uD5ee++Q+mNL6PWIwlyph5gEexiYs6BGtWyVwt526ZaTnugnxdoG4C
         lIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohmJDlGvawHM1PU67AFGw15XY9I6v3mJN4cAPcGaOUU=;
        b=ghYMcd/MzdauBr7e+YNSYtRdTE8fmb2lWvo70MR8o/AFNveByJrEuBVzevzz2rGarU
         8rWu+tJt1bu8Q3Afm3yDNAm+K0A6H+VrBngfzd4ZBreG0F7LvlO2t9E6F8QN21/cYFWl
         E9t9d//EYqt2w2giKmkLA4DJvjxFIiKx4AP8S3CfO8SvA2kU1l1JhweII6gL21nF/A59
         ZGb9BYBc2MdSlld66M0ZlosJqxh3S6Zmu1mcoHRnE3nQfknU5WgknMprkhfgSrRWrDyW
         FkBO0iDVKV5mgJ392/UxeFFmrPnEncF++kPPiNNRRorvqNwUIyNnMm6mC90+NmGn/jNG
         mvQQ==
X-Gm-Message-State: ANoB5pmmnyQKGEiDI6psiEgqNYlgGe6k4zuvJfgqTGb4bmE8klpxqDTf
        KjswR+wDWUb0r8hZS1X4jOw=
X-Google-Smtp-Source: AA0mqf46L20MRpl9fl1tWJuOGUpr9czjERNHWobNUROa7CZUYth4B1lmuxcdMgrxxFWxqCRvMLir+g==
X-Received: by 2002:a05:600c:54c3:b0:3cf:70a0:f689 with SMTP id iw3-20020a05600c54c300b003cf70a0f689mr1748749wmb.161.1668182351546;
        Fri, 11 Nov 2022 07:59:11 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05600c3c8100b003cfaae07f68sm9574447wmb.17.2022.11.11.07.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 07:59:10 -0800 (PST)
Date:   Fri, 11 Nov 2022 16:59:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 1/7] MAINTAINERS: Add HTE/timestamp subsystem details
Message-ID: <Y25xTRHi1nAbhjEr@orome>
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-2-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o5dSA0wiUZnlsGDz"
Content-Disposition: inline
In-Reply-To: <20221103174523.29592-2-dipenp@nvidia.com>
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


--o5dSA0wiUZnlsGDz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 10:45:17AM -0700, Dipen Patel wrote:
> Add tree, mailing list and patchwork details.
>=20
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--o5dSA0wiUZnlsGDz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNucUwACgkQ3SOs138+
s6E8ww//So6wdCUNfgEcOeGhongH9BYQmf/ddOAxv2nN07VU4ZM64Sw0ErA+Y7fo
9yYY5pYKUAFw2is5VEPLkackYGoUuc+aWr/hQopNdADDKKmbIYwzdWhChroNAbGg
wN4f2LGXY96ecks85uzAGOvRBovPV/DNJiCS8L5ONV5S7Av5E8c2Lf7L6LT1nDIA
pqwnsAJyjv+QIX6RrrRIxm8AuBT+6kStHZ/AOjYnhTWuXID4dTgzon18olUN3IRc
SrHCCY586RO9D/N6YR3lPo+8dljoJYRTa5MYvkiVKNB34oX8mcCGvMtVAh4YW5O4
oVoBacIw8JMP8X1pXSakFJsFAHdv6yOGTZNiRWLM3UdDZrGMzwWZwfUPPuTP5k7s
f78aRODtVg2hxqDgrclxIiV8y57C54/TbRGouvhCBTUtoccqVtuEbSyfO0uTnr3k
mbUq4l53dinj8PkSq81kv1y980xK1M6Z8WPBxAKDm86xdxaLNT6LqTz8s9CjX/W3
ukll0c/xL5jXagas8qadORYY9u3fNE2jJJtswH+v3n6NR/e/+cd8DjrjTHhNbwLV
bg5NA4JKTaEz0vuN39jJl77EfNNyR+Y7dq4cqdGYOzbWLACfLs9eiOU0VbN3r8Og
hSWKG3vZxkEMTsBuQi6+9a9CdOvRXC7vrH6ekYWp9utImm77umA=
=LoTo
-----END PGP SIGNATURE-----

--o5dSA0wiUZnlsGDz--
