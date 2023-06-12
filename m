Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB92572CD68
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbjFLSCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjFLSCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:02:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B83FE63;
        Mon, 12 Jun 2023 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686592967; x=1718128967;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oe8Ey0rLI5aMtfcU82JWfELso1XEdXyzqck9HhvkkjY=;
  b=KgnhfTtR7Qs1JBeeql73/gFMIVmlPr0WWbryRzalES4+doqMWBjEP6F9
   lKHFxkuZR190/f2CTRWG00+aKqDBhxOreefMrTj8JF/Qb3bFZsIUHbHw6
   DeygMzm2Pj2TRwnCFQ2kwEK/7DxRs2587gQTwPgeinX1dPnsFx2xLbRS3
   cPXZ7AHRWaS0bwhNPvJxpLHcblcsv5KUv7qDmz/YuS+7qLuxSVQrbOHoG
   kSVNVG0uSY5L7iF8Sw6/6Bm+8BGPLIJZ3egf2fRtSFbBn4JDODy9Ibi3b
   MmL71dSK0zX7y9tLyMTdz+EaXLgrWp5l0nAD049PYUJL8zucsaBe5YfDb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="360604070"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="360604070"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 11:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824055755"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="824055755"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2023 11:02:38 -0700
Received: from [10.54.75.144] (debox1-desk1.jf.intel.com [10.54.75.144])
        by linux.intel.com (Postfix) with ESMTP id 437E6580D43;
        Mon, 12 Jun 2023 11:02:38 -0700 (PDT)
Message-ID: <fa84b0098551123f34a68b3c0d9c7aa12f592bbf.camel@linux.intel.com>
Subject: Re: [PATCH V2 2/2] platform/x86/intel/pmc/mtl: Put devices in D3
 during resume
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     markgross@kernel.org, irenic.rajneesh@gmail.com,
        ilpo.jarvinen@linux.intel.com, xi.pardee@intel.com,
        rajvi.jingar@linux.intel.com
Date:   Mon, 12 Jun 2023 11:02:38 -0700
In-Reply-To: <e5fce103-fbb6-0eb6-f6ff-4bfeadd89c90@redhat.com>
References: <20230607233849.239047-1-david.e.box@linux.intel.com>
         <20230607233849.239047-2-david.e.box@linux.intel.com>
         <e5fce103-fbb6-0eb6-f6ff-4bfeadd89c90@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
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

Hi Hans,

On Mon, 2023-06-12 at 11:42 +0200, Hans de Goede wrote:
> Hi David,
>=20
> On 6/8/23 01:38, David E. Box wrote:
> > An earlier commit placed some driverless devices in D3 during boot so t=
hat
> > they don't block package cstate entry on Meteor Lake. Also place these
> > devices in D3 after resume from suspend.
> >=20
> > Fixes: 336ba968d3e3 ("platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devic=
es in
> > D3")
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>=20
> Thank you for your patch.
>=20
> There is one thing which has me worried here:
>=20
> What about when real proper drivers show up for these blocks?
>=20
> I know that at least some people will likely be using the out of tree IPU=
6
> driver with the IPU block.
>=20
> And having 2 different drivers poke at the hw state seems like a bad idea=
 to
> me.
>=20
> Maybe we can add a check if no driver is bound and only set the state to =
D3 if
> no driver is bound?

This check exists but is not shown in the patch. mtl_set_device_d3() gets t=
he
device lock and checks to see if dev.driver is NULL before putting in D3. T=
his
was checked with the GNA driver installed.

David

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
> > ---
> >=20
> > V2 - rename mtl_fixup to mtl_d3_fixup. Call it from new mtl_resume
> > =C2=A0=C2=A0=C2=A0=C2=A0 function, followed by the common resume. Sugge=
sted by Ilpo.
> >=20
> > =C2=A0drivers/platform/x86/intel/pmc/mtl.c | 29 ++++++++++++++++++++---=
-----
> > =C2=A01 file changed, 21 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/pmc/mtl.c
> > b/drivers/platform/x86/intel/pmc/mtl.c
> > index e8cc156412ce..2b00ad9da621 100644
> > --- a/drivers/platform/x86/intel/pmc/mtl.c
> > +++ b/drivers/platform/x86/intel/pmc/mtl.c
> > @@ -68,16 +68,29 @@ static void mtl_set_device_d3(unsigned int device)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0}
> > =C2=A0
> > -void mtl_core_init(struct pmc_dev *pmcdev)
> > +/*
> > + * Set power state of select devices that do not have drivers to D3
> > + * so that they do not block Package C entry.
> > + */
> > +static void mtl_d3_fixup(void)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmcdev->map =3D &mtl_reg_map=
;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmcdev->core_configure =3D m=
tl_core_configure;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Set power state of select=
 devices that do not have drivers to D3
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so that they do not block=
 Package C entry.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtl_set_device_d3(MTL_G=
NA_PCI_DEV);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtl_set_device_d3(MTL_I=
PU_PCI_DEV);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtl_set_device_d3(MTL_V=
PU_PCI_DEV);
> > =C2=A0}
> > +
> > +static int mtl_resume(struct pmc_dev *pmcdev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtl_d3_fixup();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return pmc_core_resume_commo=
n(pmcdev);
> > +}
> > +
> > +void mtl_core_init(struct pmc_dev *pmcdev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmcdev->map =3D &mtl_reg_map=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmcdev->core_configure =3D m=
tl_core_configure;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtl_d3_fixup();
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmcdev->resume =3D mtl_resum=
e;
> > +}
>=20

