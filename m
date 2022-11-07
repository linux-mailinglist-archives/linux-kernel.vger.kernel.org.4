Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B5161EF3D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiKGJjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiKGJjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:39:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0375C13D3E;
        Mon,  7 Nov 2022 01:39:09 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k2so28487543ejr.2;
        Mon, 07 Nov 2022 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dize+abv97rNbY3TAqpTdlnftgTWyHy/jvZ6S8Ql6ME=;
        b=CHe9nCy0T305wZRAag/ljxosQD4VfvPc1rk8UNYzK0moMpRPyDIaFRkIhMpMc+Vyh+
         6jAxB7CG/tTRvzuDl7uoM6SrE0JLXfsT7WM4QKy7nMfig0mfYni1XuzNdcxtGNcdetsu
         t71fRJTsCW0UbL+t6VvoTFW6O86VUqkkgXhj2ruEAgbTh8KVzXILkaMkARVxnQTu+w9F
         c8nekxxl/bEsJzpnEG5bf65oQw5wjobN3AGgXHNkQXIOoO9LO2lLvPG1HU3cuLOJ0L1C
         ZtiFN3g0F4d3s8/oZou6kfmyY6iv4aTRayl6Z6iVXIaC1fWX9dnWB+c/9fgXPzBqVR83
         gNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dize+abv97rNbY3TAqpTdlnftgTWyHy/jvZ6S8Ql6ME=;
        b=YA0FzbzUZJKUzqdnQmvigFQhhnGh1MgCQ93Gztpk9KrjK6qRloReQm3W0lC4RQqJpY
         gGYJtRhwifXjkLbSf+zgJMCm++aGS34G1XNe2AS8IzMa3phnfhPhXaG0Fj2pbIxb342d
         EsImvqkYGWVDkzivGZLFNdgMmUstKWn1Ypp/cIQcgkKZdOGp64e+30gxiGOvjjPg58j6
         1awx/7l8pSagNGHQNp1S7LWqH9oPDG5T9BW219YhDo3xa6UqBCA8/uFBZP/IG5mUwdOh
         /Gzik3JGNsOUhI0QMTmCbU7vVQkAcxCLY5nNjhfdLefo2iggUX2MjY50yn6A7YqAVjCg
         h40w==
X-Gm-Message-State: ACrzQf2RkGyfy1Ww/psQIkBfcrOVEKYldVAXgsAeMvTSNEsCWFuyrAsk
        mPEDo8tYs6C2d48q9cI0a44=
X-Google-Smtp-Source: AMsMyM7/wlyDF/pbvh24/FfWMjpO7j1m2XiBDBYUfEr0+1b7pesFcaJk4Xmj8udGAP+uIiNVo/5KNg==
X-Received: by 2002:a17:907:80d:b0:73d:1e3f:3d83 with SMTP id wv13-20020a170907080d00b0073d1e3f3d83mr45438100ejb.372.1667813947285;
        Mon, 07 Nov 2022 01:39:07 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r18-20020aa7cb92000000b00458947539desm3925342edt.78.2022.11.07.01.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:39:06 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:39:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Prathamesh Shete <pshete@nvidia.com>, joro@8bytes.org,
        adrian.hunter@intel.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        will@kernel.org, iommu@lists.linux.dev, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
Message-ID: <Y2jSOOpiC+meyVND@orome>
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
 <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com>
 <Y2PJq27wkVwPg6rp@orome>
 <CAPDyKFq8szzryFBNkw20wFoPTbAa8YDy0wJnb57yckZ-HFTAMw@mail.gmail.com>
 <4cae5c8d-d6e9-79dc-670d-22ec9fda10a2@arm.com>
 <CAPDyKFqte70isq=x4afFO6Ys9=wXLkLwVRG6dhfOCunQeQ_DjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="66sIBaM0zKTYRjLG"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqte70isq=x4afFO6Ys9=wXLkLwVRG6dhfOCunQeQ_DjQ@mail.gmail.com>
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


--66sIBaM0zKTYRjLG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2022 at 03:35:32PM +0100, Ulf Hansson wrote:
> On Thu, 3 Nov 2022 at 18:35, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2022-11-03 14:55, Ulf Hansson wrote:
> > > On Thu, 3 Nov 2022 at 15:01, Thierry Reding <thierry.reding@gmail.com=
> wrote:
> > >>
> > >> On Thu, Nov 03, 2022 at 12:23:20PM +0000, Robin Murphy wrote:
> > >>> On 2022-11-03 04:38, Prathamesh Shete wrote:
> > >>>> In order to fully make use of the !IOMMU_API stub functions, make =
the
> > >>>> struct iommu_fwspec always available so that users of the stubs ca=
n keep
> > >>>> using the structure's internals without causing compile failures.
> > >>>
> > >>> I'm really in two minds about this... fwspecs are an internal detai=
l of the
> > >>> IOMMU API that are meant to be private between individual drivers a=
nd
> > >>> firmware code, so anything poking at them arguably does and should =
depend on
> > >>> CONFIG_IOMMU_API. It looks like the stub for dev_iommu_fwspec_get()=
 was only
> > >>> added for the sake of one driver that was misusing it where it real=
ly wanted
> > >>> device_iommu_mapped(), and has since been fixed, so if anything my
> > >>> preference would be to remove that stub :/
> > >>
> > >> Tegra has been using this type of weak dependency on IOMMU_API mainl=
y in
> > >> order to allow building without the IOMMU support on some old platfo=
rms
> > >> where people may actually care about the kernel size (Tegra20 systems
> > >> were sometimes severely constrained and don't have anything that we'd
> > >> call an IOMMU today).
> > >>
> > >> We have similar stubs in place for most other major subsystems in or=
der
> > >> to allow code to simply compile out if the subsystem is disabled, wh=
ich
> > >> is quite convenient for sharing code between platforms that may want=
 a
> > >> given feature and other platforms that may not want it, without caus=
ing
> > >> too much of a hassle with compile-testing.
> > >
> > > I agree with the above.
> > >
> > > Moreover, the stubs make the code more portable/scalable and so it
> > > becomes easier to maintain.
> >
> > Are you suggesting that having the same thing open-coded slightly
> > differently (with bugs) in 8 different places is somehow more
> > maintainable than abstracting it into a single centralised implementati=
on?
> >
> > Is it "easier to maintain" when already seemingly every thing I try to
> > clean up or refactor in the IOMMU API at the moment is stymied by
> > finding Tegra drivers doing unexpected (and often questionable) things?
> > Is it "more scalable" to make it even easier for people to copy
> > questionable code without a second thought, leaving API maintainers to
> > play an ever-expanding game of whack-a-mole to clean it up? No. No it
> > chuffing well isn't :(
>=20
> Ohh, I wasn't aware of these kinds of issues for the IOMMU interface.
>=20
> Abusing interfaces is an orthogonal problem to what I was suggesting
> to solve here. The main problem I was trying to address was to prevent
> sprinkling subsystems/drivers with "#ifdefs" all over the place, as
> that doesn't scale.
>=20
> >
> > >>> I don't technically have much objection to this patch in isolation,=
 but what
> > >>> I don't like is the direction of travel it implies. I see the anti-=
pattern
> > >>> is only spread across Tegra drivers, making Tegra-specific assumpti=
ons, so
> > >>> in my view the best answer would be to abstract that fwpsec depende=
ncy into
> > >>> a single Tegra-specific helper, which would better represent the na=
ture of
> > >>> what's really going on here.
> > >>
> > >> I don't see how this is an anti-pattern. It might not be common for
> > >> drivers to need to reach into iommu_fwspec, so that might indeed be
> > >> specific to Tegra (for whatever reason our IP seems to want extra
> > >> flexibility), but the general pattern of using stubs is wide-spread,
> > >> so I don't see why IOMMU_API would need to be special.
> > >
> > > Again, I agree.
> >
> > The anti-pattern is reaching into some other driver's private data
> > assuming a particular format, with zero indication of the huge degree of
> > assumption involved, and half the time not even checking that what's
> > being dereferenced is valid.
>=20
> I see.
>=20
> >
> > > Moreover, a "git grep CONFIG_IOMMU_API" indicates that the problem
> > > isn't specific to Tegra. The "#ifdef CONFIG_IOMMU_API" seems to be
> > > sprinkled across the kernel. I think it would be nice if we could
> > > improve the situation. So far, using stubs along with what the
> > > $subject patch proposes, seems to me to be the best approach.
> >
> > Yes, there is plenty of code through the tree that is only relevant to
> > the IOMMU API and would be a complete waste of space without it, that is
> > not the point in question here. Grep for dev_iommu_fwspec_get; outside
> > drivers/iommu, the only users are IOMMU-API-specific parts of ACPI code,
> > as intended, plus 8 random Tegra drivers.
> >
> > Now, there does happen to be a tacit contract between the ACPI IORT code
> > and the Arm SMMU drivers for how SMMU StreamIDs are encoded in their
> > respective fwspecs, but it was never intended for wider consumption. If
> > Tegra drivers want to have a special relationship with arm-smmu then
> > fair enough, but they can do the same as MSM and formalise it somewhere
> > that the SMMU driver maintainers are at least aware of, rather than
> > holding the whole generic IOMMU API hostage.
>=20
> Thanks for clarifying this. I certainly understand your concern better no=
w.
>=20
> >
> > Since apparently it wasn't clear, what I was proposing is a driver
> > helper at least something like this:
> >
> > int tegra_arm_smmu_streamid(struct device *dev)
> > {
> > #ifdef CONFIG_IOMMU_API
> >         struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev)
> >
> >         if (fwspec && fwspec->num_ids =3D=3D 1)
> >                 return fwspec->ids[0] & 0xffff;
> > #endif
> >         return -EINVAL;
> > }
> >
> > Now THAT is scalable and maintainable; any number of random drivers can
> > call it without any preconditions, it's a lot clearer what's going on,
> > and I won't have to swear profusely while herding patches through half a
> > dozen different trees if, when my ops rework gets to the point of
> > refactoring iommu_fwspec with dev_iommu, it ends up changing anything
> > significant.
>=20
> It sure sounds like we need another level of abstraction for iommus,
> to avoid the interface from being abused. Perhaps something along the
> lines of what we have for clocks (providers and consumers use
> different interfaces).

Yeah, I was thinking along the same lines. It seems a bit odd to me that
Tegra would be the only chip that ever needs access to the stream IDs
outside of the IOMMU driver), so a generic function that would allow a
device to retrieve its stream ID seems like it would be useful.

We have a few cases where a device can have multiple stream IDs where we
currently force them all to be the same for simplicity. One case where
this can happen is when a device is both a DMA engine and a DMA-capable
microcontroller in one, where the microcontroller can then use a stream
ID separate from that of the DMA engine.

We have another case where a device has multiple contexts for isolation
where things are a bit trickier, but we already have an implementation
using multiple logical devices and iommu-map to take care of that, so it
basically boils down to the above use-case.

> Anyway, to simplify future potential rework in this direction, I can
> agree and understand your points.
>=20
> What you propose above, with one or a few Tegra specific helper
> functions, seems like the best we can do for now.

If this is really a Tegra-specific need, I guess we can start with a
Tegra-specific helper. We could always generalize from that at a later
point.

Thierry

--66sIBaM0zKTYRjLG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNo0jYACgkQ3SOs138+
s6H0/BAAohxny+OhPcizD2vl1pYUCUY1239Vyw6HGGYeeVPDYFXIUPQ6OXowQw/E
sCxKNqB8vrKGbAVzROLd9W6YCt3nAgWAhI8UsTehUm55gQYY94tpWRtcD7IKhhgR
oqRFEhetT9Ub0U/4YbWoyWLp6V6rrygiGz3UPg/2hNHzI5tgTHQep4wg3CX+iMp5
mTonIdSlrGijZG7BlRRxNnnZhhUS4dNCVQKoj2OKkVHkanULVacUFvrenTH/WDpo
ejV11LnjVHPeUtECfVCO10nQ+AJMgjphwbYuFm9QZIQekLZUcLJelbGjSzhUAt9j
efocB9mNbGmLUWrVStQgRZV9WJiU4D+jMK8QhSebVvtHFqC12lnmiBsUXah/aIPx
FEDuaAegFoT/+Q5quwoRrU84VmGF2biIHS+wQt+pMMpQOOtv35kpOshEH6w+NkZA
1iB5biA9x5JUTQOrrGaWNEAznAXavoHbZoNVZWG6J23SYpb0MB6ZQiZmx4ImpL2r
t3qH3R3IuXychDPPY52CogDWTaZm9qLUEsSlbMcRLI+yFKTwJGRTGhpoD6yG8fU3
j0L4Pl+2ILWCtK2KGEERg9fUpjF4V4J7boH+9jzMFHe3549D1MFj6r4YImmhP/4+
z+8G3t6mN6bkSkXoGSNkbrZunZyl0xEECFgA+SqNQpscl3uVrTs=
=yvxn
-----END PGP SIGNATURE-----

--66sIBaM0zKTYRjLG--
