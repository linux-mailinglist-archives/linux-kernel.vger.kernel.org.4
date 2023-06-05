Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0754F7229D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjFEOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjFEOwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:52:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB61A5;
        Mon,  5 Jun 2023 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685976752; x=1717512752;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FhIKj5hopuivdOQ/x6J+PFFfVaor+2CRZRn4OuX7eNw=;
  b=CSaRlHTxGcMvByZWj/TaHgHnAgId+etnyLn9GXBVGFdychsP9BVU0/eR
   YHb9N47pxitcGkkbkMdy/ThtGzw53bhznhZNEpukr2GI7kneWZoh60+Un
   Wo3iHxG+o/bEZO7XmH9+JHSsjntjfyAaZQk4NQ5eAArrpjO2UHaRzJM4P
   6oZ9ZNczbE2D9XO9iILaOGr6gUup/uivRA5T7c30cRIlHMykgFQIrpAPn
   vGvmRg8ZiNpHlf32xsCGlQPXVqeDt/D4B+zw/p8pIToClcUZqAAz76sQg
   p3Q9Z2I2Mbv8vPwGzZZypT0S/Ux6etoZR/rBX8CG3jsKE6gMbNrYgLXuD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="358835557"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="358835557"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 07:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="711829563"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="711829563"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2023 07:52:31 -0700
Received: from [10.54.75.144] (debox1-desk1.jf.intel.com [10.54.75.144])
        by linux.intel.com (Postfix) with ESMTP id 8991B580AD7;
        Mon,  5 Jun 2023 07:52:31 -0700 (PDT)
Message-ID: <2c109aabf846bda8a6e34cb2c4898b7e2c3ef90a.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86/intel/pmc/mtl: Put devices in D3
 during resume
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     irenic.rajneesh@gmail.com, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 05 Jun 2023 07:52:31 -0700
In-Reply-To: <9a45d987-6840-9c7a-b0b5-702cf3aba4f@linux.intel.com>
References: <20230602232142.278155-1-david.e.box@linux.intel.com>
         <20230602232142.278155-2-david.e.box@linux.intel.com>
         <9a45d987-6840-9c7a-b0b5-702cf3aba4f@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-05 at 14:59 +0300, Ilpo J=C3=A4rvinen wrote:
> On Fri, 2 Jun 2023, David E. Box wrote:
>=20
> > An earlier commit placed some driverless devices in D3 during boot so t=
hat
> > they don't block package cstate entry. Also place these devices in D3 a=
fter
> > resume from suspend.
> >=20
> > Fixes: 336ba968d3e3 ("platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devic=
es in
> > D3")
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > =C2=A0drivers/platform/x86/intel/pmc/mtl.c | 15 +++++++++++----
> > =C2=A01 file changed, 11 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/pmc/mtl.c
> > b/drivers/platform/x86/intel/pmc/mtl.c
> > index e8cc156412ce..d87c4597c6d4 100644
> > --- a/drivers/platform/x86/intel/pmc/mtl.c
> > +++ b/drivers/platform/x86/intel/pmc/mtl.c
> > @@ -68,11 +68,8 @@ static void mtl_set_device_d3(unsigned int device)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0}
> > =C2=A0
> > -void mtl_core_init(struct pmc_dev *pmcdev)
> > +static void mtl_fixup(void)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmcdev->map =3D &mtl_reg_map=
;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmcdev->core_configure =3D m=
tl_core_configure;
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Set power state of s=
elect devices that do not have drivers to D3
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so that they do not =
block Package C entry.
> > @@ -81,3 +78,13 @@ void mtl_core_init(struct pmc_dev *pmcdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtl_set_device_d3(MTL_I=
PU_PCI_DEV);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtl_set_device_d3(MTL_V=
PU_PCI_DEV);
>=20
> I'd prefer the function be called something related to d3 / power state /=
=20
> or some along those lines rather than something obscure such as=20
> mtl_fixup(). And you can move the comment to be a function comment now.

Okay.

>=20
> > =C2=A0}
> > +
> > +void mtl_core_init(struct pmc_dev *pmcdev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmcdev->map =3D &mtl_reg_map=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmcdev->core_configure =3D m=
tl_core_configure;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtl_fixup();
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmcdev->resume_fixup =3D mtl=
_fixup;
>=20
> I'm a bit on the edge here whether this is a good approach in long-term o=
r=20
> if it would be better to just provide a way for the platform file to=20
> replace entire .resume() (for this task it's obviously enough but it=20
> feels a bit hacky to hook into one fixed place on resume path).
>=20
> static __maybe_unused int pmc_core_resume(struct device *dev)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pmcdev->resume)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return pmcdev->resume();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return pmc_core_resume_common();
> }
>=20
> where pmc_core_resume_common() contains the current pmc_core_resume()=20
> contents.
>=20
> mtl_resume() would just call the d3 func and the common resume functions.

Yeah, makes sense. There are several conditional tasks in the current resum=
e
code, so trying to have a fixed place in there to call a platform specific
workaround may not be possible if we need to use this again for a different
reason.

David

>=20
>=20

