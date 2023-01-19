Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646DA673AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjASNp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjASNpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:45:52 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBA47A52C;
        Thu, 19 Jan 2023 05:45:48 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mp20so5764372ejc.7;
        Thu, 19 Jan 2023 05:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AYsyyY/tTtbV410BkfLlEnlTawZ8v4MFiO3+pHz02I=;
        b=Mxxw07UlKZf0aifaxk1ZH4NfieLsTWV64P/pIzniylzbvXrVBzsjU6UEF543Oqh2/Q
         FMAHJr+RM9QmcTpLM/2fv+ULutd+A/0IfZnDvX7V1mYvYm3KPCxcFl0Vof3TRMjtkHYV
         N+QVJiz/YHY9V/iKTpJtUz3w6uVgJpkdB6hYoyIMoayGCyc5RISH1bs4lUsm1k383WvG
         nej69RwMUBBMwHZipFxqw87fHW8LyvORHlZMOAs5qAUlRNmwjHK0lHd3Ro4Uttqa+Wg4
         8cETTxyE/0JUsDa4nmQ2djFBOvjmAlvYtZsjh+ZZ4dJeF9qrGn312ulOUSgzAzP5Mz8i
         Kmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AYsyyY/tTtbV410BkfLlEnlTawZ8v4MFiO3+pHz02I=;
        b=vzj+8s5y+8YsWZj6z8qUzct9nBnhu+KCuxRUpymlKUR7W6GnLYFeyZUpv9S1TbDd/3
         ZLxwZv5oUK/9SHrBS5NuaSpG3P/1pe1HSGmKETEsLJVGDOM4hgnoMe7IInXOJoqw1xci
         gi5NOVDXFmbWqmPcTK9Y5beEhIQ2FKo01BeAjMOzg6nSg/UEKFDrDrd9sWy6e/3a7J9/
         XiqL6Jj3LO9JNSzhtEqNr6VCN5v3SegQj4RA36U+0wTN117Q37dP3pKB5/djuOyFXOFQ
         Alh1G+CPKC9OnV9P6tBysxy5Cq1VFYFglkrf2juvnllY/TARmzHZn5YPh4Tf99JqJ8/9
         9Q9Q==
X-Gm-Message-State: AFqh2kqTr1G7I+9VoUssAt6lXYtMl3neQkuLLHbPy4lFHZOeA+K21ukm
        xXhZhJ0hINFrBGy7davIwDQ=
X-Google-Smtp-Source: AMrXdXvos/wXyZ2CoSxAkJFouc2vA6Lact0v2yrYYQhc8UwopLit/BTaJ0E24Ch34oPfe6HoPuy/BQ==
X-Received: by 2002:a17:906:6d9:b0:7c0:bbab:22e5 with SMTP id v25-20020a17090606d900b007c0bbab22e5mr10991529ejb.16.1674135947087;
        Thu, 19 Jan 2023 05:45:47 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709060c0c00b0086621d9d9b0sm9617880ejf.81.2023.01.19.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:45:46 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:45:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the phy-next tree
Message-ID: <Y8lJiJHHcUO7MXQY@orome>
References: <20230119153145.598885cf@canb.auug.org.au>
 <Y8jfW2TTnHd3J7R1@matsya>
 <Y8jpFw5mfvyRLX/C@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8tbvqgkqk2xV2UK"
Content-Disposition: inline
In-Reply-To: <Y8jpFw5mfvyRLX/C@kroah.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8tbvqgkqk2xV2UK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2023 at 07:54:15AM +0100, Greg KH wrote:
> On Thu, Jan 19, 2023 at 11:42:43AM +0530, Vinod Koul wrote:
> > On 19-01-23, 15:31, Stephen Rothwell wrote:
> > > Hi all,
> > >=20
> > > The following commits are also in the usb tree as different commits
> > > (but the same patches):
> > >=20
> > >   5c7f94f8bad8 ("phy: tegra: xusb: Add Tegra234 support")
> > >   e5f9124404d0 ("phy: tegra: xusb: Disable trk clk when not in use")
> > >=20
> > > they are commits
> > >=20
> > >   d8163a32ca95 ("phy: tegra: xusb: Add Tegra234 support")
> > >   71d9e899584e ("phy: tegra: xusb: Disable trk clk when not in use")
> >=20
> > Ah, ideally these should go thru phy tree!
>=20
> Yeah, but they were submitted as a larger set of patches with USB
> changes to me, so I took the whole series (it's hard to pick and choose
> from a series).

This has been a recurring theme, so I'm trying to get a better
understanding of what people expect here. Some maintainers want to see
a whole series for a single feature (in this case it was Tegra234 USB
support) even if it crosses multiple subsystems/trees. This has the
advantage that patches can be arranged such that all dependencies are
resolved. Other maintainers like things to be split up so that patches
are easier to pick up.

Submitters can spell out in the cover letter how they think things
should be picked up, but they're not always aware of what else is going
on in the respective trees, so they may get it wrong.

I personally prefer to pick up DT bindings into the platform tree since
we're getting into a place where device trees can be properly validated
and keeping bindings and DTS files in the same tree helps with that.

But I know that DT maintainers prefer bindings to go through subsystem
trees because it can help reduce conflicts and that outweighs the DT
validation benefits, which some platforms may still be far away from
being able to use.

DTS changes on the other hand are a different thing. In my opinion it is
much better for them to be applied through platform trees because of the
greater potential for conflicts. In any given cycle there are often
multiple patches touching the same DTS files and currently a lot of
clean up is going on for validation.

So I wonder if we should just move away from the current process of how
we submit series. Maybe a less confusing way would be to strictly
separate driver and DTS changes into two series. That way maintainers
would better understand what patches to pick. It also has its own set of
disadvantages (can't validate DTS changes against DT bindings, and it
may not even be clear where certain DTS changes are documented).

The only other alternative I can think of would be for maintainers to
default to picking up driver (and perhaps DT binding) changes from
bigger series.

Is it worth codifying this in our process documentation?

Thierry

--a8tbvqgkqk2xV2UK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPJSYUACgkQ3SOs138+
s6Fj/w/+PMOd1uYJ3vic1eEINBvUdsaHvOBmxtUFGNRd5gnuh9HD30If+kQnff+Q
mpcng88OyTbx8s7KQZ+FPOJ0ZhS5YYSqIBeQrAvZo/nc3jh39SQmtlRvzGW3cRLz
KDnEl1gQU9mP8eMy1kKcA/nfyu6P+Mf4sx5k3MlcuFFoDzQKBwKto8zDLP7BXb2j
FzgTehrrtx48YBe0RkHHvAn1cIwPs6S/iQw0F552fC1WiThn5QjhceEWuynQHvSN
94RbhkI1SoXGeEKirHaXfqVsdf3B86QOzzKd6T+SHWdESVWIj+b7ZMa1/Qz9xjqv
PDOipmzS2a9PvPZD976MAnVyks/IO13EsEmdD+xM2VluW2xEYqRlE5LZiyz40mVG
EgfcIbd64sGE8Q5u1/AZuaoDjyEBqrAQ1yR02tQb/vu2Xp7N4OIg8VR0odIccojK
ZrV4YBo8DAUV+IMkL9P/gBdZKgrQSGdsu+Xlx1fq3m3IjmG9kZvKWICe1/SAetUd
WztSrrqB6V3wDcvjFnFPLCyxdzS9gGqjE1GRXei+rcXxtA3Us1sMjR6RRtjrqTBJ
7PfX8BHB9tv+I3snsq7jT9F6COcxOcW6Y1aCA3A6TKkAU/9pf2oSvjFtIXJ+iSRK
ageAmhrhZ6pTSk/rCL6ciDnVExeqZ31TR7rTzCf2yJagPhJwoXg=
=4myi
-----END PGP SIGNATURE-----

--a8tbvqgkqk2xV2UK--
