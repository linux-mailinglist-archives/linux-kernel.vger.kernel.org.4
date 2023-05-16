Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50909704872
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjEPJIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEPJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:08:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A064E2D4A;
        Tue, 16 May 2023 02:08:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so1792363966b.1;
        Tue, 16 May 2023 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684228129; x=1686820129;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4ndlDI27cEimuq0EFy8IEEE+q5oKNUX46KIz6kfkk0=;
        b=laqtmOjUCI/NXXdAq0NEN9qesOHsPXREALspUOUzRGdBwqJYV47J3mbjH/UT7NKmWp
         ss6jHOboieZZrhRcrCAVRj6oIrSWfbdwN0eSN/cxtttTrudgBB4z3MLYbYVDEM3CayKZ
         1gt/kRIhaoi9Kx9MhiMLPxNYMTOGZSd4M0+vutd1UwGNJF2asfdxY2gjIGEjZa+j5DJg
         Qq+IVvieaWqFQJ7/1YLrpiF4qNwTM6p681PFVmT7FOb/3OCHDtxXFqi+UIqtYLWwxdQI
         cxnvtdTOGMDLqlLxqDBndboSyuRMVik32D9PohVT9YXw2Nny94Cowjeut93XLjxmi5bM
         TraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228129; x=1686820129;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4ndlDI27cEimuq0EFy8IEEE+q5oKNUX46KIz6kfkk0=;
        b=feG3YaHRUctkkljUZNdKr3fPF1Jkp2eYcopl1XsijIiBbZIyHiOOGfpbg5SMsFj6cc
         3raNY2ybFQDEZwgvftXyTGHCHPM1Y9WWAvgh89aaPdQdoORbBDqxdlF0K0KJVTb5i7Kd
         6cLWH5kbZJNSRD3PXyIVfgaKAqEzFy1y92hxGcQMypD61W7IRA4f1xBUI/qevW3P+uS0
         hTC+wrdwWJYmZnN4iuU1C7hQ67WX8tMLPvHrXI2a3FCHtJwVM2yvEK3i1WQQqsP4ykU/
         46XksJy2qIKOvNMD6pZVYHQU6/MbuD5CzD3omnBkSOtjbQpkHodekyEuvIUzlRvRVNDp
         bptg==
X-Gm-Message-State: AC+VfDw3LF9cYGPvysHxjWemM4UolY3THuE8PFY/H1sgZLMXerLg0AUD
        xypfZnqpb3QKxaCFKPrO2CY=
X-Google-Smtp-Source: ACHHUZ5ElEkQ2gllGMct3/ZSfekvpDSz82v4wq+++K9CvhiG62HoYYzQcrBW0/1RnaWe+Qb3aQ8V8w==
X-Received: by 2002:a17:907:26cb:b0:96a:bdb0:5744 with SMTP id bp11-20020a17090726cb00b0096abdb05744mr10225185ejc.26.1684228128642;
        Tue, 16 May 2023 02:08:48 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id hv7-20020a17090760c700b00965be665811sm10710685ejc.2.2023.05.16.02.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:08:48 -0700 (PDT)
Date:   Tue, 16 May 2023 11:08:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     jonathanh@nvidia.com, Stefan Kristiansson <stefank@nvidia.com>,
        arnd@arndb.de, kkartik@nvidia.com, sumitg@nvidia.com,
        windhl@126.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v4 3/6] soc/tegra: fuse: Add support for Tegra264
Message-ID: <ZGNIHhKsU8cdH6k0@orome>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-4-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OcoYUGIu0vGP3IFM"
Content-Disposition: inline
In-Reply-To: <20230511132048.1122075-4-pdeschrijver@nvidia.com>
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


--OcoYUGIu0vGP3IFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 04:20:48PM +0300, Peter De Schrijver wrote:
> From: Stefan Kristiansson <stefank@nvidia.com>
>=20
> Add support for Tegra264 to the fuse handling code.
>=20
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 3 ++-
>  include/soc/tegra/fuse.h               | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--OcoYUGIu0vGP3IFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRjSB4ACgkQ3SOs138+
s6Fr5w/8Cf2F66+JtZifyXsnHsKzsmtVs4LcnHoa9R4XjZD2JKCs5DzrjLqYq7bM
PAE77ZlUu8ouXZfGeB0jqFaWSThh6VpoLj4NLJCiQ7/4GuYaVYL063JUMaMlx6Pj
fI8eMiSlW5Ee9b8yTEtJtHeB96j05rUWYo8zwwER8dh8OvsBNaaO4IarjboCgdLt
ilxZX66u5uY5kg9UmeZjYeoY+hZFOFMdt8Qw9a6cANS7XJEOnpfIRTqP9dRsRzPh
ZGoQM07EWmFoGW1PrP6jphRHkLMrZhed+zZ/I9NTjHEhGmH9krZzaTf8d1AvxOrK
jg9Zrj9BxLSKpSsfKviFmrI+itaj8udCkMvXMeHNPhFyOtHqDradagH6IVYHxD65
jFKdVKfbh5wP77ZYSaA0owR0zJe87awYQ47SkwJH+TM1WzqWLBolJG0yeBGtWoPd
ZXSIWB+9Z1QlHHHUckQDNTV6vipWbiEN5zBL2NeDpVy8RlOmfrv73bxaSwaWLSjW
kg4/5PGApF+8OwQ5LevK0aLZuUACxQ3gFBCZMI2EC9HXL0Z4zdtS9rdvCF/+eXX6
qBg1D1Reesf31BZHG0BFY+13ZoeThXlrBqvZ7Y0EatdO48rW1qXsg9mLAZm7x+L4
fEl3F+RUyNGMqbIDbrK3lcqOwJLJFAcg/yG7/zFy4Kxmq0eajts=
=YRCS
-----END PGP SIGNATURE-----

--OcoYUGIu0vGP3IFM--
