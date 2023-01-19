Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82477673A09
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjASNYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjASNY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:24:29 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3B583;
        Thu, 19 Jan 2023 05:24:27 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mp20so5608673ejc.7;
        Thu, 19 Jan 2023 05:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1SIQxm46KagVF7RVfUwWLVwz0S5gteWcqhBkL3jKnU=;
        b=jQdy4WcIm2Zm44gysBR+Ry4H1VRDTaeLU9vupT4JRbPVDZb2Vqh2GTA5gzHiCFO6Gg
         9+6T+W//ayPpHoGR+DeH/BzxWb3cN1WATt0wuzQuhDkUmKrop+iGStYppWHewc5jr4YZ
         03WjVE0OHzz/Q6OB9BSFfZIGch/M4IOnjAmcCsLeoBzQaIkz6y0pmVmOi4e1BH1SdjKr
         TVcqRhRaBoZLxWu+gXOAy7m1YNiTHUZvCD59cxZiTtlwfkKTCs8Y5kXzEAA3IHxzVxsp
         HgXcJHJoCx6ItHMa+WsDIGeh4p4PwbPcsSPRSqtKvh3LpqwR0zC9rPUx03NWQRn08bqr
         +h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1SIQxm46KagVF7RVfUwWLVwz0S5gteWcqhBkL3jKnU=;
        b=3YP6Q5JsrCbi3ZfRxOx7obue265a4rXNFIYJ95H0Y+vi7Hq7krEUvg/rBPmh/5Fvuq
         4r8d02plnrmDSe9YpSjaMe0qAmGioOmuh73V5edAH/nhVvnqUs/4JNexzPUtN4xP+ySB
         SvrF6VzQY08RH3xrGJpKg7/OBBr0GHtuhhyGsAYgMldNXxUgVMBcMf08t+JgW8Wcm3a8
         P5Nl4R2M5uTv+G5ZnwbaoVIhafVOAobPGHaKOfDkgwKDYvSVsGQMqIRYhzeu6OEzY+4F
         VzkpeFlu/afwerRVxzA1d5Ow8xKNY4EnFlVJWqb96BAtF3ApHqAL6Zh+AuOm0Z6AW0Qn
         Nqew==
X-Gm-Message-State: AFqh2krqrmNxCsVGTLpjbhf+/jr0ddeyGt9KWQqwuQCKZUFCuuUcfjCj
        ArB0zR3FSRnQWmEgAUw+Ptk=
X-Google-Smtp-Source: AMrXdXt0v4iAGFbvfkQuvhAgwcN04ztIANV+XuCD57IPbrZyDqZV5EdgB9b+kbUxKGuN9UeRKk6gSw==
X-Received: by 2002:a17:906:2288:b0:872:23b8:d6ed with SMTP id p8-20020a170906228800b0087223b8d6edmr11341894eja.20.1674134665739;
        Thu, 19 Jan 2023 05:24:25 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007aee7ca1199sm16454883ejc.10.2023.01.19.05.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:24:25 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:24:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the usb tree
Message-ID: <Y8lEhwT3VWEn9w+R@orome>
References: <20230119152605.03588e9b@canb.auug.org.au>
 <Y8kyJcSYW0IOMuzU@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KC+8cmX4u8WytxQE"
Content-Disposition: inline
In-Reply-To: <Y8kyJcSYW0IOMuzU@kroah.com>
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


--KC+8cmX4u8WytxQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2023 at 01:05:57PM +0100, Greg KH wrote:
> On Thu, Jan 19, 2023 at 03:26:05PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > The following commit is also in the tegra tree as a different commit
> > (but the same patch):
> >=20
> >   2648f68bd0ac ("dt-bindings: usb: Add NVIDIA Tegra234 XUSB host contro=
ller binding")
> >=20
> > this is commit
> >=20
> >   20cdc1607ea0 ("dt-bindings: usb: Add NVIDIA Tegra234 XUSB host contro=
ller binding")
> >=20
> > in the tegra tree.
>=20
> Is that going to be a problem?  Git should handle merging that just
> fine, right?

This one shouldn't be a problem. I can also back this out of the Tegra
tree. However, I also carry

	6e505dd6804f ("arm64: tegra: Enable XUSB host function on Jetson AGX Orin")

which you picked up as

	1b17df99730a ("arm64: tegra: Enable XUSB host function on Jetson AGX Orin")

That one is a bit problematic because I had to manually apply it on top
of the Tegra tree because of some rework of the DTS files. I think this
managed to thoroughly confuse everyone and the version in linux-next is
now not what it should be.

Is there any chance you could drop it? If not I could back out the DTS
rework and schedule that for the next release. I'd rather not since I've
been trying to get that in for a while now, but it's not worth a revert
in your tree.

Thierry

--KC+8cmX4u8WytxQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPJRIUACgkQ3SOs138+
s6GB+w/+Lm945NsZdQZhiJ6VuwmjzjYdBgC4qViOO5ybPmsQ4J5z7gXqSVDvuOtu
sI8R3O9xmQoPBbw5OyWgJ1o6phSHjInacElkUz5BrBzYYkRFs57RjYTKcLOEXMdQ
Ei+6srh3Ec3SfxxSaKPoPtt/oNgel9coZaNm2oz4+EdzUoDmSoKTxr8g8eDVQf4P
lRT4BcXjdR3UA2//HZ8YZRvZYAm9L4RtIp5A/QUJm/arkulk23ErFrsIBkfLPsGM
YKe6K+9LOkq9+tkuDy7oky1RMVAr4gcnHdGfNkqYF05DO3M89klHUMQ/VE8G7w58
7izC1SH7f4lA60XSpzUJUKKqvP1gEhmSARtTRazvVxtazsJfWB0W6xG45hT/Wboz
+e9QDQrmXLK5nTHXOZeDu9lxy118YOOkXygTHtVVlKUxaT8F5PDtsVl7PVffbZ3e
5A3ABhyyyBy4HqkaFCJnrSh8BfXd7n8vxQRA9JMYWZ86IJ9SlmIvE3EsC97rL620
94bESD5Fy1OolPeVMBFB6UDhZX/R/lW97ecT3guzwLwNZfNaoRdFUbORJR0vUONZ
3jsoThhyNvT3j5T89HdC0Z5bPtAmN1Vc8+FyAs0x6qdl7FLTlKdjCi+6U7dTh9yc
hZxanORZoj3nOtBkAjLZD8+md/M7eQc32cEBjCURmeCbK2gahRI=
=ackf
-----END PGP SIGNATURE-----

--KC+8cmX4u8WytxQE--
