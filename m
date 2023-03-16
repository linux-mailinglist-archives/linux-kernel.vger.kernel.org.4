Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40A6BD40F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjCPPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjCPPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:39:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10722C889C;
        Thu, 16 Mar 2023 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981092; x=1710517092;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lpeckZ811LPUH7GBNtBOnJgvZwwJw+EL6zHIrvG2K18=;
  b=amo8kypwZ9CNUU8HTDde+W2+tyheQ4j5OviZn1FukvcYVigmfrZCudzq
   Apben07ckUCCpDnfowcC8t9Rp/CPo4CHoGYcYJzyLXm7zc9o7E3biNDbD
   y09kLyUBVX+y0SUVkC3U24Z+fhQtdFihwSgMsSgLDFegB1zMr8z165PKC
   dmGgc6beD4a9U7HQfy4yBD+EGDFsYyKtFhS+BLftV1xPyXDiLgdqSc8gS
   x7iM89WHuflDoxJkoCtAdCjERK8jwVdYuyPE3EIHwEVIGG3zylng52klj
   serNPDQr04IvFPwrkZmTKn2NMNhkhsy/GR9DqAxA3Jwjn+d2z1aGNXlnI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="340399797"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="340399797"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="769002159"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="769002159"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2023 08:36:23 -0700
Received: from vahoang-mobl.amr.corp.intel.com (unknown [10.212.175.15])
        by linux.intel.com (Postfix) with ESMTP id B9325580C4C;
        Thu, 16 Mar 2023 08:36:22 -0700 (PDT)
Message-ID: <f8c8375921cbe1d16329b450ad264e8bb711a7dc.camel@linux.intel.com>
Subject: Re: [PATCH 00/11] Intel pmc_core: Enable telemetry
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>, irenic.rajneesh@gmail.com,
        markgross@kernel.org, andy.shevchenko@gmail.com,
        rajvi.jingar@linux.intel.com, xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Thu, 16 Mar 2023 08:36:22 -0700
In-Reply-To: <2d8d484d-55d6-446e-10af-49be3f2f0f7c@redhat.com>
References: <20230315183405.2465630-1-david.e.box@linux.intel.com>
         <2d8d484d-55d6-446e-10af-49be3f2f0f7c@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Thu, 2023-03-16 at 15:51 +0100, Hans de Goede wrote:
> Hi David,
>=20
> On 3/15/23 19:33, David E. Box wrote:
> > On Intel SoCs, registers for the Power Management Controller are availa=
ble
> > in the PCI BAR of the SSRAM device, 0000:14.2. On Meteor Lake, these
> > registers are structured in Intel PMT Telemetry regions which could be
> > handled by the pmt_telemetry driver. This series adds APIs to the
> > intel_vsec and pmt_telemetry drivers so that pmc_core driver can both
> > create the telemetry instance from the SSRAM device and register for a
> > handle to read the telemetry which contains the low power mode requirem=
ents
> > for the S0ix states supported by Meteor Lake. The series also adds some
> > fixes.
>=20
> Thank you for the series. I notice that none of these patches have a Revi=
ewed-
> by nor a Tested-by from some other Intel developers.
>=20
> It really helps if you can get someone other Intel kernel people to revie=
w and
> test your patches and then add their tags before posting a large(ish) ser=
ies
> like this upstream.

Sure. About 5 of these, though related, are small and can be sent separatel=
y.
I'll send those first and get Intel review for the others. Since this small=
er
batch won't be enabling telemetry, as in the cover letter title, I'll send =
as a
new series.

David

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
>=20
> >=20
> > David E. Box (6):
> > =C2=A0 platform/x86/intel/vsec: Explicitly enable capabilities
> > =C2=A0 platform/x86/intel/vsec: Add base address field
> > =C2=A0 platform/x86/intel/pmt: Add INTEL_PMT module namespace
> > =C2=A0 platform/x86/intel/pmt: telemetry: Add telemetry read functions
> > =C2=A0 platform/x86/intel/pmt/telemetry: Add driver version
> > =C2=A0 platform/x86/intel/pmc: Add Intel PMT support for MTL PMC
> >=20
> > Gayatri Kammela (1):
> > =C2=A0 platform/x86/intel/vsec: Add intel_vsec_register
> >=20
> > Rajvi Jingar (1):
> > =C2=A0 platform/x86/intel/pmc: Alder Lake slp_s0_residency fix
> >=20
> > Xi Pardee (3):
> > =C2=A0 platform/x86:intel/pmc: Combine core_init and core_configure fun=
ction
> > =C2=A0 platform/x86:intel/pmc: Move get_low_power_modes function
> > =C2=A0 platform/x86/intel/pmc/mtl: get LPM information using Intel PMT
> >=20
> > =C2=A0drivers/platform/x86/intel/pmc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> > =C2=A0drivers/platform/x86/intel/pmc/adl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 17 +-
> > =C2=A0drivers/platform/x86/intel/pmc/cnp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 17 +-
> > =C2=A0drivers/platform/x86/intel/pmc/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 71 +++++---
> > =C2=A0drivers/platform/x86/intel/pmc/core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 24 +--
> > =C2=A0drivers/platform/x86/intel/pmc/icl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 11 +-
> > =C2=A0drivers/platform/x86/intel/pmc/mtl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 187 ++++++++++++++++++-
> > =C2=A0drivers/platform/x86/intel/pmc/spt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 11 +-
> > =C2=A0drivers/platform/x86/intel/pmc/tgl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 17 +-
> > =C2=A0drivers/platform/x86/intel/pmt/class.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 48 +++--
> > =C2=A0drivers/platform/x86/intel/pmt/class.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 35 ++--
> > =C2=A0drivers/platform/x86/intel/pmt/crashlog.c=C2=A0 |=C2=A0=C2=A0 3 +=
-
> > =C2=A0drivers/platform/x86/intel/pmt/telemetry.c | 199 ++++++++++++++++=
++++-
> > =C2=A0drivers/platform/x86/intel/pmt/telemetry.h | 120 +++++++++++++
> > =C2=A0drivers/platform/x86/intel/vsec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 131 ++++++--------
> > =C2=A0drivers/platform/x86/intel/vsec.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 64 ++++++-
> > =C2=A016 files changed, 790 insertions(+), 166 deletions(-)
> > =C2=A0create mode 100644 drivers/platform/x86/intel/pmt/telemetry.h
> >=20
> >=20
> > base-commit: 02c464b73645404654359ad21f368a13735e2850
>=20

