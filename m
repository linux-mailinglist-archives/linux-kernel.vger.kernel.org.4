Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AD460F363
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbiJ0JNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbiJ0JMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:12:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B318516EA0B;
        Thu, 27 Oct 2022 02:11:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m15so1562928edb.13;
        Thu, 27 Oct 2022 02:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xthR7hB3kKLruuTcFbR1YysN8z3ovY1NUbF6DHK+Xg=;
        b=ISeBsdRWo/8o3QohdUiKOGMoe1FxmOsFK/eTCX4gD4oKKE1zwSYGIYz+vhx4BDGBam
         LdOGGaJChSY63d6aKLzivrpa6Sab2BSyaDpLcZU2qchUUNV9djhPkulZMPGDWSQsxdbq
         1xmOQd97TBVP80cMTF76gzIXmJxQvEbXjefOeNxbZow2wcq1ZzeNYQklsg9verCdfqsI
         vxmImTyL9cgjV51et0faljDJlni9cQyYP38slG3WdBTSeWw4Srn2duILUuavJ3S1CG4m
         MOPBBZcQLwbSp0hADrCb82z1gZlV7w5jTX/1laZEKe24lcnCd8B1JFKkxLmk54u8YPa4
         mqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xthR7hB3kKLruuTcFbR1YysN8z3ovY1NUbF6DHK+Xg=;
        b=XPwtnPZyxDOzpB2mTNcEyM45KrGa19pDIiVBQ88pxa8eYDuruloNh/8sin+G2i+ZK4
         HI3iilcy/Nszi2ZePOlIaeuf4hTBne6H0TicTQ2sECHE293EN1AgzjGdi2fIyHVRZbrp
         Mm4+tYhMiQFVDHJ4jMCdznVj88sEJb8RXCkWJlx59E9r8l8/dE2EgcQ1GsgHWpD+fHmb
         3UaH4ERZhyHzaJXbzn3SevqsUP56LMplBzucwsdHIatW1LaH3BlUJHSYE52FJB1lbQy1
         pdgFwE0p0x5Q2wKzCkV3xDXHLkMTjugbbh/anVJWDM+PEB2jjRtKUHO49QHHwJwFnIK4
         dvRQ==
X-Gm-Message-State: ACrzQf3Ks4qu+oILTkg+TAnB/UttCWVLoqrF9x7vvLDvhTnS69jCcyuR
        YvB8xrjP3nlQnsF0FL/4GTI=
X-Google-Smtp-Source: AMsMyM5F0ir2W9XAtcxtdFqezqdYd1sOksNsF8XVQQkaDMgCmjnZy4WvQICVtLKo3tA7l+1TPjudAA==
X-Received: by 2002:aa7:c054:0:b0:453:98c6:f6c4 with SMTP id k20-20020aa7c054000000b0045398c6f6c4mr44381847edo.2.1666861888005;
        Thu, 27 Oct 2022 02:11:28 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o12-20020a50c90c000000b0044bfdbd8a33sm617276edh.88.2022.10.27.02.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 02:11:26 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:11:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Prathamesh Shete <pshete@nvidia.com>, iommu@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Always define struct iommu_fwspec
Message-ID: <Y1pLPHER+Pq+cRvc@orome>
References: <20221018105149.820062-1-thierry.reding@gmail.com>
 <CAPDyKFopppohLJ7ptnQxpBHzMLh2SZObarQRC0bJyTwE=nky4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e3c57vVo3DT2FWCa"
Content-Disposition: inline
In-Reply-To: <CAPDyKFopppohLJ7ptnQxpBHzMLh2SZObarQRC0bJyTwE=nky4w@mail.gmail.com>
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


--e3c57vVo3DT2FWCa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 01:32:41PM +0200, Ulf Hansson wrote:
> On Tue, 18 Oct 2022 at 12:51, Thierry Reding <thierry.reding@gmail.com> w=
rote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > In order to fully make use of the !IOMMU_API stub functions, make the
> > struct iommu_fwspec always available so that users of the stubs can keep
> > using the structure's internals without causing compile failures.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> > ---
> > Hi Joerg,
> >
> > this is a rebased patch extracted from an ancient series that never
> > ended up getting applied:
> >
> >         https://lore.kernel.org/all/20191209120005.2254786-3-thierry.re=
ding@gmail.com/
> >
> > You had already acked this particular patch, so maybe you can pick this
> > up. I've seen at least two discussions where this was brought up again,
> > so I figured it'd be worth sending this out again because it can help
> > remove a number of #ifdef blocks throughout the kernel.
>=20
> Yes, this would certainly help to improve the code. To me, it looks
> like the current stub functions, like dev_iommu_fwspec_get() for
> example, aren't really useful without $subject patch.
>=20
> Note that, I have a pending patch for mmc that would benefit from
> this. To prevent me from delaying that, an easy way forward, assuming
> there are no objections of course, would be to send this for 6.1-rc.

Adding Prathamesh for visibility. Another alternative would be to
prepend this to Prathamesh's series with an Acked-by from Joerg.

Joerg, any preference on how to move forward with this?

Thierry

>=20
> >
> >  include/linux/iommu.h | 39 +++++++++++++++++++--------------------
> >  1 file changed, 19 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index a325532aeab5..e3295c45d18f 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -173,6 +173,25 @@ enum iommu_dev_features {
> >
> >  #define IOMMU_PASID_INVALID    (-1U)
> >
> > +/**
> > + * struct iommu_fwspec - per-device IOMMU instance data
> > + * @ops: ops for this device's IOMMU
> > + * @iommu_fwnode: firmware handle for this device's IOMMU
> > + * @flags: IOMMU_FWSPEC_* flags
> > + * @num_ids: number of associated device IDs
> > + * @ids: IDs which this device may present to the IOMMU
> > + */
> > +struct iommu_fwspec {
> > +       const struct iommu_ops  *ops;
> > +       struct fwnode_handle    *iommu_fwnode;
> > +       u32                     flags;
> > +       unsigned int            num_ids;
> > +       u32                     ids[];
> > +};
> > +
> > +/* ATS is supported */
> > +#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> > +
> >  #ifdef CONFIG_IOMMU_API
> >
> >  /**
> > @@ -598,25 +617,6 @@ extern struct iommu_group *generic_device_group(st=
ruct device *dev);
> >  /* FSL-MC device grouping function */
> >  struct iommu_group *fsl_mc_device_group(struct device *dev);
> >
> > -/**
> > - * struct iommu_fwspec - per-device IOMMU instance data
> > - * @ops: ops for this device's IOMMU
> > - * @iommu_fwnode: firmware handle for this device's IOMMU
> > - * @flags: IOMMU_FWSPEC_* flags
> > - * @num_ids: number of associated device IDs
> > - * @ids: IDs which this device may present to the IOMMU
> > - */
> > -struct iommu_fwspec {
> > -       const struct iommu_ops  *ops;
> > -       struct fwnode_handle    *iommu_fwnode;
> > -       u32                     flags;
> > -       unsigned int            num_ids;
> > -       u32                     ids[];
> > -};
> > -
> > -/* ATS is supported */
> > -#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> > -
> >  /**
> >   * struct iommu_sva - handle to a device-mm bond
> >   */
> > @@ -680,7 +680,6 @@ bool iommu_group_dma_owner_claimed(struct iommu_gro=
up *group);
> >
> >  struct iommu_ops {};
> >  struct iommu_group {};
> > -struct iommu_fwspec {};
> >  struct iommu_device {};
> >  struct iommu_fault_param {};
> >  struct iommu_iotlb_gather {};
> > --
> > 2.37.3
> >
>=20
> Kind regards
> Uffe

--e3c57vVo3DT2FWCa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNaSzkACgkQ3SOs138+
s6FOpg/+J4Dp7U85QdWkE9egyBiaNU6fizWwIQM/Zivy6ZrcPCcr6hqi4k7kSz+4
7pmMS4BxAi/cVxvHKhVYptnK15+9fDJsp5Y5STE7idEjOCWENvUFi4/DlwtZ0Q/e
Uq6oU8t5LpvXoM7jg/PIJ0s/sBjzHMEhLNutCkq4stC7aj28k5OqX4c+/t6j+kbx
TUFuu2g4ypjKzhxNxsnWC3iRPXNovrjfoS0dLo4hAwgpZWsiutEaEim9DxWtSELe
ASf8Z02vSxbvn9ikgu6hMAUvL1KW5P1j6Kklji2ZkYqX3a3sTYATnXsHEe+BFvhw
biBuzYLJ07fDsMqMdwGZEgbqeaKGUw9S9YzxAXtvK3yfSgTk+zS0u1hz6hmsYIiQ
8cIaYciPVvEKbMgCQzMoPYymf49+8fASPJBnw59NT5SDlq+j6o+e5Bji7VgsOqDl
4Mrwb/VPJguFYFozt0KQQDXtp2fHSZCYjkPJxvRy01NUMbaIVNB+eRX5lBcyeFqy
w5PPZrJZjFN0znMpwSOTjCinwFxlrFFL9k0CMk6xgPihsxbDnGUKimL/cKFAWeXG
FvpSqRRyV/QaI9rKKB4wvN4DOUqFQbEKy7/P70h5T2nxYIUhktqxWKsZKQ/hTvps
yEF8pEPDbEilgNkz4RKy0b3lUhA+d+KptH6nv4HdgnrBzsG7smA=
=rRso
-----END PGP SIGNATURE-----

--e3c57vVo3DT2FWCa--
