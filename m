Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB982617EC2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiKCOCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiKCOCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:02:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B4515A01;
        Thu,  3 Nov 2022 07:01:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f5so5495607ejc.5;
        Thu, 03 Nov 2022 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8KBHFKCCV98EGQ0XNAh6f+GyuIELNYOs9+rs4Vjisk=;
        b=PM3sDavtwmpBa9SzVwuAW8ocUuLOyw5n79S3/pdi6Ss0i09waaIpEaRLPCKx476mWk
         jycWA5LjGory2a2IFrwpWs1mokSxWnq/icf6U733EkfykpxMP3vD/2MKn+vj5NaxCbL8
         +vehfKEcSsL9bQm5gE3IsSj5Pyh+RDhDb5+n/dWmVdcxXxPpRL4u9Q/ibFB7OJdaWVv0
         aLBIH4tqG/VxSvbh54Z1wMiXnv0zwo5g9baojtcukDUE2ANtVPDl9enFgNtcpAA7B26c
         9hZM4cn3Z1Ppf3ngatHbl51+oH9nxo5u5wNYYu2NzeHt9Y3mqOwzDyxN7Ue41IxVqWyH
         E6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8KBHFKCCV98EGQ0XNAh6f+GyuIELNYOs9+rs4Vjisk=;
        b=hKWtpzLd+2QenePLM4OOWR/s2W3TeodsPFw1f3dIW+VptHRkC9BQkX/bynbQBpTuH3
         /CW9WYPNrvmp7yIPuh5d1Kh8ddu2AFmGegZ3Fji52LyZmh+NWg7Y7XSGMDS8DzBROB2q
         q+7KiO9rOJ2dJ5haNol9OlIZVJZpknnWRHUGVqKWNKc9p/A6o5/kP9MBG1A5FimphOx6
         S4+UNUV4OIfuOelgEsaKsHWjOutCx6ZFvj4rXqwV2ylhvK+9BPd1N4wqX8fZE67bPKLA
         iNe6UMR8R/C8BlHOJRV306FZvL1HrRzDX5e3eh4X+SoweaT/hS9o7wb2r+7mutl69lp3
         dH+g==
X-Gm-Message-State: ACrzQf1kvix5k9QjTJ4OF4MocMf1rG50sOLBtg/Pa5GftUm5pO00PjgZ
        pnRS7YDj++DgNF1KT6fTZtw=
X-Google-Smtp-Source: AMsMyM7XJXH2PC/t6FNCsEX7I+z1C4W2HQEJ9aLW8fkd/ImJ/OKSmZBl8druoW65YOOMfmSOa1gqqg==
X-Received: by 2002:a17:907:b07:b0:7a8:beb3:aa2a with SMTP id h7-20020a1709070b0700b007a8beb3aa2amr28968653ejl.459.1667484078436;
        Thu, 03 Nov 2022 07:01:18 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bu24-20020a170906a15800b00722e50dab2csm534317ejb.109.2022.11.03.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:01:17 -0700 (PDT)
Date:   Thu, 3 Nov 2022 15:01:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Prathamesh Shete <pshete@nvidia.com>, joro@8bytes.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        iommu@lists.linux.dev, anrao@nvidia.com, smangipudi@nvidia.com,
        kyarlagadda@nvidia.com, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
Message-ID: <Y2PJq27wkVwPg6rp@orome>
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
 <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cJiVwhbrNzxCoobg"
Content-Disposition: inline
In-Reply-To: <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com>
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


--cJiVwhbrNzxCoobg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 12:23:20PM +0000, Robin Murphy wrote:
> On 2022-11-03 04:38, Prathamesh Shete wrote:
> > In order to fully make use of the !IOMMU_API stub functions, make the
> > struct iommu_fwspec always available so that users of the stubs can keep
> > using the structure's internals without causing compile failures.
>=20
> I'm really in two minds about this... fwspecs are an internal detail of t=
he
> IOMMU API that are meant to be private between individual drivers and
> firmware code, so anything poking at them arguably does and should depend=
 on
> CONFIG_IOMMU_API. It looks like the stub for dev_iommu_fwspec_get() was o=
nly
> added for the sake of one driver that was misusing it where it really wan=
ted
> device_iommu_mapped(), and has since been fixed, so if anything my
> preference would be to remove that stub :/

Tegra has been using this type of weak dependency on IOMMU_API mainly in
order to allow building without the IOMMU support on some old platforms
where people may actually care about the kernel size (Tegra20 systems
were sometimes severely constrained and don't have anything that we'd
call an IOMMU today).

We have similar stubs in place for most other major subsystems in order
to allow code to simply compile out if the subsystem is disabled, which
is quite convenient for sharing code between platforms that may want a
given feature and other platforms that may not want it, without causing
too much of a hassle with compile-testing.

> I don't technically have much objection to this patch in isolation, but w=
hat
> I don't like is the direction of travel it implies. I see the anti-pattern
> is only spread across Tegra drivers, making Tegra-specific assumptions, so
> in my view the best answer would be to abstract that fwpsec dependency in=
to
> a single Tegra-specific helper, which would better represent the nature of
> what's really going on here.

I don't see how this is an anti-pattern. It might not be common for
drivers to need to reach into iommu_fwspec, so that might indeed be
specific to Tegra (for whatever reason our IP seems to want extra
flexibility), but the general pattern of using stubs is wide-spread,
so I don't see why IOMMU_API would need to be special.

Of course we could get rid of the stubs and make these hard
dependencies, but I suspect some people may then get mad that they can
no longer disable the IOMMU dependency.

Thierry

--cJiVwhbrNzxCoobg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNjyagACgkQ3SOs138+
s6HGYxAAh6pI7eahKNv7gYp1al3CnXjMWsTEFnZEfgGUoTtGAXTOdR4I7jLa2ZiH
aywKvhMZ5Jn/C5uwx+ylsElQNkmsmwJAusICnt+iJaYxGndYyQWndaUaGJrOa2b6
mFDi6xpxykGuJwLdz2Y0hvGprBZc5y5d9j6SiuUjWYGqGSddGAvXe2QzvLeZTwYf
mmzO01+KdOshRJItVefZCEM1shmzUu1wfS8I+JT/iKSM4GL1vPtGsq6Z3H2vb5h3
gnapMRTmZZKiPwJCjykuSOcZ8++HFjA+LA8EZ5peVtMkwaRaXicdhs0ymwettr/x
PxlDnsuhPbMxxLz71RRoCaHqN+83ow9opGOKhdaiztyf4AKlXc8koGg1x1wBgn8c
jKcff0GCs3D7QAHIoOqsHSIIMK6NfxBcNViOybyR5ffqRo3SY2NYWO8bp9h/dJiM
SDobn0DUMOgYcLomqBDwTqQqc1Lcu+hvQexA6sBRP8pvIpJ19IWzfnPtH/NaExbV
KfuTqtXscsX/8YG/oiCjVfa6fOS1tb7ftygdxWGgmRRZl3T/mswU67UbNMmiHhkC
VY1e4tQx5IKdiP1BRk0wBe4rIguA2F2xtImJpakSRJnxCYoFInFrYXBhXSeEG3ys
L3NiAeBplKi2ZGAPAnp/w0wsq9tjT9svzmIdjzWdeGmIU/Lx1qc=
=WjKJ
-----END PGP SIGNATURE-----

--cJiVwhbrNzxCoobg--
