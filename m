Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410DF625E01
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiKKPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiKKPOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:14:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A78A787BC;
        Fri, 11 Nov 2022 07:12:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so5781688wmb.2;
        Fri, 11 Nov 2022 07:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo3JAnH1xBKjU4dLHHIr86K+WcPVTrl0yYDNVMrnptw=;
        b=ImjGOMhLbf7obSKOo3l/4UqmzeCE8pJGc7lFqAYOzebH+RYpIfid3IiaspLPkWZmAY
         35C570rWC+fKHjGXO90jVrVp6E43FS/mFSjThvqMfzAcnhiS5B2V5pnWxRjpVHG87SLd
         IST85hgXCEWbsLwnTjHzX6KIDXk0KUpA1SAECM6EMmqtc5MB0ARUSOkItgGJi07P8uBO
         iMQipNs7331yasXYJWze8OJ+yjWUSCgt6L4ZlHh0smWgcssg6syjgbbjZNpSEAY69vYS
         hSJIoYD0ozTXspZKE/R6B0XkxgZuUHNQF/KuWt45XWR0R3V7CDC1rtdQ+8T0iGHSmqvv
         PDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yo3JAnH1xBKjU4dLHHIr86K+WcPVTrl0yYDNVMrnptw=;
        b=IluVValgH1FaItGvX540OVeJg8lHsG7RiHjKciL6AuN+eIOtfYuzvVEDFvxKi+HQx6
         YMrn8P3ZdjDIrxih15IJXN8bKRb3a8iwnMFKj/DZ3XzYkqW/OiyqMHExrZP2q6IUNnRD
         Su9zrRW82EVrvXNa0zSJW3OB9OI7kEXN/ZrfSYYQy9OWNGH6+7qo3RCoVOEYH36XHywx
         WBhMxgzBxd0+KZiYnN9/1Hq9oaW2eyAHjculUJygaOptoUtGqrr7A80tN/wWB0R5hqV5
         dlg2kKvDewLErgSfKsxUYLlF7TZ2p/+C/Zult6v4Wdr8u97ugG5i+uNE+JnToBZH6eLo
         DrwA==
X-Gm-Message-State: ANoB5pkVxrHiyTY04B57XL64b3Z/t5vHdBYOgUBtszmKVAwo5lpKgcGa
        XbBauvLhpiYXeb3A6tkd/Gg=
X-Google-Smtp-Source: AA0mqf7qLi6TIreoTPriWv8spYJZdMAhflwSulBFXrWvDRFpAvcuhZ+NR8N2JY+BsfITMPEO80/11Q==
X-Received: by 2002:a05:600c:3b82:b0:3cf:72d9:10b0 with SMTP id n2-20020a05600c3b8200b003cf72d910b0mr1596846wms.26.1668179534996;
        Fri, 11 Nov 2022 07:12:14 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003cfbbd54178sm13944410wms.2.2022.11.11.07.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 07:12:14 -0800 (PST)
Date:   Fri, 11 Nov 2022 16:12:11 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
Message-ID: <Y25mS7bKQbww7a0A@orome>
References: <20221111113732.461881-1-thierry.reding@gmail.com>
 <Y241vwu47PbjrbBQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FcC3BGDnC/jm6qBq"
Content-Disposition: inline
In-Reply-To: <Y241vwu47PbjrbBQ@smile.fi.intel.com>
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


--FcC3BGDnC/jm6qBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2022 at 01:45:03PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 11, 2022 at 12:37:32PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The OF node store in chip->fwnode is used to explicitly override the FW
> > node for a GPIO chip. For chips that use the default FW node (i.e. that
> > of their parent device), this will be NULL and cause the chip not to be
> > fully registered.
> >=20
> > Instead, use the GPIO device's FW node, which is set to either the node
> > of the parent device or the explicit override in chip->fwnode.
>=20
> Thank you!
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> P.S.
> It's good we have this report, which means I have to reconsider the
> followup I'm cooking. In any case I will send it after v6.2-rc1 for
> broader testing.

Feel free to add me on Cc if you need the patches tested on OF systems.

Thierry

--FcC3BGDnC/jm6qBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNuZkkACgkQ3SOs138+
s6ExSA/7BD6Hk92SBu9AfBzKPMAlKmHtdBADgIpNRLvSuvULJQuk8PCQA3YX6S4j
WCtL7HsnzLJ2mqXjAVTDVo8/hPj0R51yffSvKspswtW2Au3A9kBKerol9TPyJnZ3
9piQ/c3NbkrnvGIQaZzUl3dsRQ4u+sbh8k5suDCy3VIbt7QSiaj6LHyaPiO4gTu6
eL5j/YAYMGzetHYZnbSK8g0z8GtKWKDja1TPXp0RCuqQhNR2MkJ11gw6PE03iDdo
Ay1sEPc8slKLBewq+ph3+PjowitYgVRu0/9KKALdiDQsnTdespSerwCQqGdv5Q86
W/OiPMG8zWRL1UoI6xHQGFCMHJuVXn+m8oET8mOZOAqbSZfIOUVC2V+ZU+sP6pbt
cLZuXyjHmbE/PUfHqYSsIWoS6ky2u+nVc/yJbdDcLfCZ/HRn/EyZ9smb0thqJ1CZ
RyB7Z0wxaU58dH33iYKlZQZFvye3TcC6lQVGYZZTUGigaH0lsZoBndtBOzrcKnaL
ETpnAkjCWkXYZ+FlYzZcFFK+kcHaHM1k02YwbIHJ1tCHaRllu6nFQBIRKGvb8dT6
5N0GU5IHgzbxXA/0phXIdVWctHkLCNxx20FQ00R7KNJpfN+295IK0PGdaL0d58hA
nkfbff4489Gm5oVW9k7FVWlv4DoA+1l7WAAn3+fleCHevBgLZUw=
=vvq/
-----END PGP SIGNATURE-----

--FcC3BGDnC/jm6qBq--
