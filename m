Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF44619A4B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKDOkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiKDOkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:40:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EA63207E;
        Fri,  4 Nov 2022 07:39:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ud5so13836297ejc.4;
        Fri, 04 Nov 2022 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfeCae03hj8TJWurGJ2gV5aCuzV24EMjUZQG3ONIz6o=;
        b=M4aevNjhkyVF1FJSXbNl80nza1VQFGO4HMGDIGfrpBYukavQT5/Z2kMEw1v4YJMeDY
         z/ZT/00LagsQ2LN3VPx7LN11FgZt5ck5YfvODwErwFFaooc+1TKxS3CM9AJPFt8/tjt7
         Pd2RpXpA9sYBAHYwwIjsr82Knnf0Br3tETh34ton9lLY84nHTgAY+/iW6RQinFwzVO+N
         N3jq+fj93HG/LNpQ0MWI1rjHQcVoMSykjj5NFbK+rpWRrvSiDJoiXtVfUVGLozQzgS7k
         LWrF2QV9dd7Io2y5abEh2lcCAvJDOQIg3mbBZ+gB16GWuhIc1j7WBqizu08NnR/97Htu
         WzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfeCae03hj8TJWurGJ2gV5aCuzV24EMjUZQG3ONIz6o=;
        b=wItIDUpb4GfIUMX1qLWQ2UAUmWBWnH2xUy/cLHmplyISwQaSrwO5mAQkVPy58HIdg1
         e4n/Wpm9RL4TUvB54idY4V/08xy7q/OcEuRwJUvsQskayslLLjzr8teHY0DKFLZN6cbB
         p0Mb684BZCnTk0hA/VfW8CLZkdpH5HAQ6eRVw4ARd13DNIq4i8xRM2OODS7rGPU7vwB0
         h6QcfJu0uPXuxhZyU44mzvPwu66wHHxS0XDcFgXpGOxiI1EFN7UUBTdYiWedRGS1BSMp
         wGIRwNBnagacruLIut3NRn+oOVuN9QjaofqJhYhJ1v7u21c0GeChmN1w1vB9tqjTdzy+
         WFMA==
X-Gm-Message-State: ACrzQf1QrZCLiMI04nTFZy8si17WR7b7VZtvdZ1iT6PWs7KhArtUBfN0
        QdjBJmx3V1UhPYlUYUy4X54=
X-Google-Smtp-Source: AMsMyM5N9H4yorV3UcHnqhcDYaujVlMTrcshptR+uhjEkRYhptI8/k2K5N9PODc8Bs9KcTPeMnDB5A==
X-Received: by 2002:a17:906:fe46:b0:73d:939a:ec99 with SMTP id wz6-20020a170906fe4600b0073d939aec99mr35162288ejb.169.1667572739109;
        Fri, 04 Nov 2022 07:38:59 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906305100b0073d7b876621sm1833348ejd.205.2022.11.04.07.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:38:58 -0700 (PDT)
Date:   Fri, 4 Nov 2022 15:38:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Prathamesh Shete <pshete@nvidia.com>, joro@8bytes.org,
        adrian.hunter@intel.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        will@kernel.org, iommu@lists.linux.dev, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
Message-ID: <Y2UkAKfHefdYW59A@orome>
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
 <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com>
 <Y2PJq27wkVwPg6rp@orome>
 <CAPDyKFq8szzryFBNkw20wFoPTbAa8YDy0wJnb57yckZ-HFTAMw@mail.gmail.com>
 <4cae5c8d-d6e9-79dc-670d-22ec9fda10a2@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TwEZgldODBz9znwY"
Content-Disposition: inline
In-Reply-To: <4cae5c8d-d6e9-79dc-670d-22ec9fda10a2@arm.com>
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


--TwEZgldODBz9znwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 05:35:19PM +0000, Robin Murphy wrote:
> On 2022-11-03 14:55, Ulf Hansson wrote:
> > On Thu, 3 Nov 2022 at 15:01, Thierry Reding <thierry.reding@gmail.com> =
wrote:
> > >=20
> > > On Thu, Nov 03, 2022 at 12:23:20PM +0000, Robin Murphy wrote:
> > > > On 2022-11-03 04:38, Prathamesh Shete wrote:
> > > > > In order to fully make use of the !IOMMU_API stub functions, make=
 the
> > > > > struct iommu_fwspec always available so that users of the stubs c=
an keep
> > > > > using the structure's internals without causing compile failures.
> > > >=20
> > > > I'm really in two minds about this... fwspecs are an internal detai=
l of the
> > > > IOMMU API that are meant to be private between individual drivers a=
nd
> > > > firmware code, so anything poking at them arguably does and should =
depend on
> > > > CONFIG_IOMMU_API. It looks like the stub for dev_iommu_fwspec_get()=
 was only
> > > > added for the sake of one driver that was misusing it where it real=
ly wanted
> > > > device_iommu_mapped(), and has since been fixed, so if anything my
> > > > preference would be to remove that stub :/
> > >=20
> > > Tegra has been using this type of weak dependency on IOMMU_API mainly=
 in
> > > order to allow building without the IOMMU support on some old platfor=
ms
> > > where people may actually care about the kernel size (Tegra20 systems
> > > were sometimes severely constrained and don't have anything that we'd
> > > call an IOMMU today).
> > >=20
> > > We have similar stubs in place for most other major subsystems in ord=
er
> > > to allow code to simply compile out if the subsystem is disabled, whi=
ch
> > > is quite convenient for sharing code between platforms that may want a
> > > given feature and other platforms that may not want it, without causi=
ng
> > > too much of a hassle with compile-testing.
> >=20
> > I agree with the above.
> >=20
> > Moreover, the stubs make the code more portable/scalable and so it
> > becomes easier to maintain.
>=20
> Are you suggesting that having the same thing open-coded slightly
> differently (with bugs) in 8 different places is somehow more maintainable
> than abstracting it into a single centralised implementation?
>=20
> Is it "easier to maintain" when already seemingly every thing I try to cl=
ean
> up or refactor in the IOMMU API at the moment is stymied by finding Tegra
> drivers doing unexpected (and often questionable) things? Is it "more
> scalable" to make it even easier for people to copy questionable code
> without a second thought, leaving API maintainers to play an ever-expandi=
ng
> game of whack-a-mole to clean it up? No. No it chuffing well isn't :(
>=20
> > > > I don't technically have much objection to this patch in isolation,=
 but what
> > > > I don't like is the direction of travel it implies. I see the anti-=
pattern
> > > > is only spread across Tegra drivers, making Tegra-specific assumpti=
ons, so
> > > > in my view the best answer would be to abstract that fwpsec depende=
ncy into
> > > > a single Tegra-specific helper, which would better represent the na=
ture of
> > > > what's really going on here.
> > >=20
> > > I don't see how this is an anti-pattern. It might not be common for
> > > drivers to need to reach into iommu_fwspec, so that might indeed be
> > > specific to Tegra (for whatever reason our IP seems to want extra
> > > flexibility), but the general pattern of using stubs is wide-spread,
> > > so I don't see why IOMMU_API would need to be special.
> >=20
> > Again, I agree.
>=20
> The anti-pattern is reaching into some other driver's private data assumi=
ng
> a particular format, with zero indication of the huge degree of assumption
> involved, and half the time not even checking that what's being dereferen=
ced
> is valid.

If this is really driver private data that nobody else should be
accessing, then this certainly is lacking documentation. And quite
frankly, perhaps it should really be hidden from other drivers in
that case.

Remember the reason why we want to make this change is because we can
already get access to all this data if we depend on IOMMU_API, while all
the rest is also already available for !IOMMU_API configurations. This
change removes that inconsistency.

> > Moreover, a "git grep CONFIG_IOMMU_API" indicates that the problem
> > isn't specific to Tegra. The "#ifdef CONFIG_IOMMU_API" seems to be
> > sprinkled across the kernel. I think it would be nice if we could
> > improve the situation. So far, using stubs along with what the
> > $subject patch proposes, seems to me to be the best approach.
>=20
> Yes, there is plenty of code through the tree that is only relevant to the
> IOMMU API and would be a complete waste of space without it, that is not =
the
> point in question here. Grep for dev_iommu_fwspec_get; outside
> drivers/iommu, the only users are IOMMU-API-specific parts of ACPI code, =
as
> intended, plus 8 random Tegra drivers.
>=20
> Now, there does happen to be a tacit contract between the ACPI IORT code =
and
> the Arm SMMU drivers for how SMMU StreamIDs are encoded in their respecti=
ve
> fwspecs, but it was never intended for wider consumption.

Again, if iommu_fwspec and its accessors were somehow hidden, or if it
was documented that this was not meant for wider consumption, then
perhaps we wouldn't have started using it in the first place.

>                                                           If Tegra drivers
> want to have a special relationship with arm-smmu then fair enough, but t=
hey
> can do the same as MSM and formalise it somewhere that the SMMU driver
> maintainers are at least aware of, rather than holding the whole generic
> IOMMU API hostage.
>=20
> Since apparently it wasn't clear, what I was proposing is a driver helper=
 at
> least something like this:
>=20
> int tegra_arm_smmu_streamid(struct device *dev)
> {
> #ifdef CONFIG_IOMMU_API
> 	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev)
>=20
> 	if (fwspec && fwspec->num_ids =3D=3D 1)
> 		return fwspec->ids[0] & 0xffff;
> #endif
> 	return -EINVAL;
> }
>=20
> Now THAT is scalable and maintainable; any number of random drivers can c=
all
> it without any preconditions, it's a lot clearer what's going on, and I
> won't have to swear profusely while herding patches through half a dozen
> different trees if, when my ops rework gets to the point of refactoring
> iommu_fwspec with dev_iommu, it ends up changing anything significant.

I don't have any objection to making that change. It's not like we're
doing all of this just for fun. We need to do this in order for the
hardware to work correctly. If the above is an acceptable way to do this
and preferable to using the more generic API then we can move ahead with
that.

In order to keep things moving, do we want to merge the change as-is for
now and then subsequently do a pass over all Tegra drivers and use a
common function for stream ID access? Or do you want me to make that
change prior to getting the SDHCI series merged?

Thierry

--TwEZgldODBz9znwY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNlI/4ACgkQ3SOs138+
s6FaAw/+KoWc++Csbrpi0RdJRUx7lDY2tNWsxViwtFHNjz379KichZ/eQcVPBWQ4
3Q4mFIe5tAKlJqbej5ibCsaXce5eyujLKkjpkUG/UxYrLMEG6CwyhxMydqR3aEPm
bRTAlYeFVvyB3cukRsM36XiFAxULogyQfUDu2wL4j0WN+23C2PHgmiPc1+6QPS6+
Rf1p5jmRg1OuvKpk6Ki4lIq5pOKQmk5Vp5MwRovZGBB7bzCYYFV7Gz05Dd8TCQLK
xssVdJhOU59b3IpCJY8LKe4M/k7HNSNZSXbK0M1A4Eep9uF8n2HiR1b8qAUFAE+A
RHv8Kt9ecSHeB3JOKeF0xiIqdWCMiRtRnymSSAlssz/eQB2zjlr8tLdozrR73TSi
a4c3g/vvoSGkGu6UseY7UPzZA7QnyV4GYkKo48YIjO6JEci4WlJyjbsybOtf0Ah3
/RdjBVU0QvfNrPkr9D+UNk5Cqj1RFduaRGJxTpgej210OJlXsJVOvwXOq5yzJkPl
+88GBS/XH7tyoo+p6VlpjXXF5GIU2dp9pFwENqs5+BO+bhdoSsdbIgTTEP9IEBcY
JwMG2w5vGEa1Vw3WvGN+dIxD/+5rPUSDDyEJEAAZN+7Okmy4mf8IDWMo9/4zPRFG
o76zjBqiDAITA/IwAIkaKzx9lonoJ0LhGD/0K+hPU6SIOGnW8v8=
=lumi
-----END PGP SIGNATURE-----

--TwEZgldODBz9znwY--
