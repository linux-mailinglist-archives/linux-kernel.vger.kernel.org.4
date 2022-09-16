Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31125BA976
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIPJbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIPJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:31:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C25EAA340
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:31:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id cc5so25219648wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2UsYFpJOWZXEK9G6y9vWyigUYAlahTONvBFa8QXRcZw=;
        b=jYr+5AUrb+MNBu1c9xVs+UvjhZZm4XOucnxp7gaFNJ4ryiowiN+sPuQf6gpR2VcWeI
         /y0WcFWv/7jKlCYogIwkME2yqYdUVmenrDnsd9NDlTl66Xamje6mC3/RM/udqdlWvdZI
         28rkmkfL7fpPsCyyH2pBFgUDQdm7eTkvJ/7wMnXmFT87LYAOnnw5zWq18LmOEedvJ657
         hIxhAgxNg0CNLAy5qaIYkIgOWYwuOj3TCwaiUAkcdbO/UM8EtN74Q1u3Dr5DAW4Glwez
         RZ7CwN/OoQxn42rJDsVeuauNArH7TMTBEIlHGibTdPX3BHjY1lQ5V7axqcwdiBdeKCXU
         x21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2UsYFpJOWZXEK9G6y9vWyigUYAlahTONvBFa8QXRcZw=;
        b=aXDV7Kmq4eRnqcoJs0plflNiwan3dY9aqBFXeBdV+LeRnqXjNeeIlD2qdaNyJVyYF0
         zs72/gfYcR6uI5dWDeIb7R3xUAYYDxiMMV4KVQbCegXf50HXAEmfT9rUPhE5aeTZNesx
         +deWo4N56Nkyr4GM3qnuMoJVS0Tf3Wjw38dRzDlC/S/SWx8y1p52fyNc3BzyRQaLFvNv
         FAA8PyHdlf9fmP6NysIHDhz9c2VVCeWZ5jMULOTNOCWZHDsnfJ+A2Vc7QuCO3mylgZRF
         emBKzjKNQ+6GvTsjrp6zJ/2civDfW9ZRYMxrlP5Wf2YY4XyirwjLRFBMI7PGdCXPQgou
         FMSA==
X-Gm-Message-State: ACrzQf1zgP5LDccMrBP1FwYMBA6leUkP4f8MGHTxe1BovYAKb8+/khzv
        WJUKghPQPKzFILXXsZ0dheo=
X-Google-Smtp-Source: AMsMyM6xCTQGP7Bn0tF4RA2V+Q0sOWKRWGSdZ56CmGtzWmj6kI9Wgif2reU1GETwWupGLkHMZk1Xmg==
X-Received: by 2002:adf:d1ce:0:b0:22a:36d6:da05 with SMTP id b14-20020adfd1ce000000b0022a36d6da05mr2346489wrd.719.1663320685336;
        Fri, 16 Sep 2022 02:31:25 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b0022917d58603sm4563801wrz.32.2022.09.16.02.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 02:31:23 -0700 (PDT)
Date:   Fri, 16 Sep 2022 11:31:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/iova: Fix module config properly
Message-ID: <YyRCatyU+CWEcDkt@orome>
References: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
 <4740744e-2e12-520d-8598-188b8d2ebd6b@huawei.com>
 <38988c89-ec61-faa1-6b15-2fd3aa51eede@arm.com>
 <YyGjPoM6ooNeJKhT@orome>
 <bdb9abaf-2703-6d4c-9cab-f6e15e3e8b30@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EO05lQbmccPFJye3"
Content-Disposition: inline
In-Reply-To: <bdb9abaf-2703-6d4c-9cab-f6e15e3e8b30@huawei.com>
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


--EO05lQbmccPFJye3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2022 at 12:45:43PM +0100, John Garry wrote:
> On 14/09/2022 10:47, Thierry Reding wrote:
> > On Tue, Sep 13, 2022 at 03:15:18PM +0100, Robin Murphy wrote:
> > > On 2022-09-13 14:01, John Garry wrote:
> > > > On 13/09/2022 12:47, Robin Murphy wrote:
> > > > > IOMMU_IOVA is intended to be an optional library for users to sel=
ect as
> > > > > and when they desire. Since it can be a module now, this means th=
at
> > > > > built-in code which has chosen not to select it should not fail t=
o link
> > > > > if it happens to have selected as a module by someone else. Repla=
ce
> > > > > IS_ENABLED() with IS_REACHABLE() to do the right thing.
> > > >=20
> > > > Hi Robin,
> > > >=20
> > > > Recently you mentioned "I wonder if we couldn't replace the IS_ENAB=
LED()
> > > > with IS_REACHABLE() and restore some of the previously-conditional
> > > > selects", and pointed me to 84db889e6d82 as an example of when a
> > > > conditional select was made unconditional.
> > > >=20
> > > > So will you also restore some previously-conditional selects next?
> > >=20
> > > I figured I'd leave that up to Thierry (and/or anyone else with a ves=
ted
> > > interest), but having mulled it over since that previous thread, ther=
e's
> > > really no excuse for the API itself not to do the right thing either =
way, so
> > > I felt compelled to write up this much.
> >=20
> > On Tegra specifically, as the commit message says, we don't really care
> > about the conditional selection because practically we always want IOMMU
> > support enabled. So instead of adding back the conditional select it
> > would make more sense to select IOMMU_API instead and then get rid of
> > the handful of #ifdef blocks we have for that.
>=20
> Out of curiosity, does the same go to host1x, whose kconfig got the same
> treatment as tegra with regards to selecting IOMMU_IOVA? I mean, will you
> not go back to conditionally selecting IOMMU_IOVA, and instead select
> IOMMU_API and IOMMU_IOVA always?

Yeah, I suspect that that will happen eventually. People would still
have the option of disabling runtime IOMMU support by disabling the
IOMMU via DT, for example, so if they really care about that last bit
of performance, they do have that option.

Thierry

--EO05lQbmccPFJye3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMkQmcACgkQ3SOs138+
s6F5OxAAtBgmV3UDyFIftISWXzLM7gbl1xMc+WHXnZyvPqLz+71GoLB7mWJb3Kfj
jbzVh9zVaVQJKo8yczVfi2khmT/X07XU2c2vy7Juq/f2MnK5PH94nn5X+Iv4kAOr
pwSsdHv2EbW/dyFrbrlJLlkawhOCf8AZkT/vYq7X0hi9dO0h0IG0dve8iDFKqYR9
8W+6YKbb8lHnR49WMdO2h1KwYJmnv8cOVOD4+PNlgbq9DMt6wpLUPBMiWP0V1u5w
KjLpFKljGbPe7TwfVn9x/6TmY3oSNnQyAyMsde8zfqwnJE7K4Ct0hHFBSPJtqO3E
DMjM3JOugQeyQ8BzUgcMjthkM92VSZWYFdwgd43IcVqV3EI+7THK/AL/3Tb2FX11
XSRMc4LVCXz7o7866ZUIRlNT5y7LaDuS/CiiDwfDtRX1r20kKGbLxnK9PF+YQR/M
oj2fmYfAQeHc0I007Z6zqKDJMS6ixueiVEWM94anLyHtrYfuDhjkPl5nYdVKQyWJ
lE5ycAei5jBBXS2APcbmg8kmicLcPnbiS5/zGa9THiHXfa6z6i7ycQGdo6XVQ/lZ
Jw1SKTL0pbAtcTys1M2/9yFfsLFMF5gstO/A3AUKsetRl+l6TDTWWw0dV0ryNFy1
wXstMeqRgx1Tz+rBlxxwgWCtymoUw3op4D7kpemFuTHC1memw8A=
=qsBZ
-----END PGP SIGNATURE-----

--EO05lQbmccPFJye3--
