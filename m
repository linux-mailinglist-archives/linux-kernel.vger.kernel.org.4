Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F760FD40
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiJ0Qhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiJ0Qhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:37:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0C918F0CF;
        Thu, 27 Oct 2022 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666888667; x=1698424667;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/bDgqOzVVsJUOBkelcoR0s1rsT8mVJ/fXVFXACV4Xhs=;
  b=VlqZKLKflkoUuLPABKy/pW+UChmSRpAWbbicJkOjozevhPKxy5BlTqDr
   +u/PN0ZPf43yhpMTHmPeLhHpl6QNmAbi4xeFlI+rdxbbVTbNyP0HkTVCM
   16yd3kpI+RqEG+vkYAOZaWPMCUpXSYUuqzstfD9bBciZP41eLa9xGq7m4
   Vn1M0frCr3Z1x/ZWWT1S6tEGaEd/24+qPxxs/dyh2kRYrR5zgt6UTl1HD
   MWjtDXXoZPqyeOY1GLh7ZimhI0tCvt0ErZGJaeEi9LI+M2aW/kCwaPMki
   5Aeo83j3iXsWz7DHomAS8aJGyf61jinDN5OZ1mqGW5JWv/Pko31PI7yga
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="370340905"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="370340905"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 09:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="877645362"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="877645362"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 27 Oct 2022 09:37:45 -0700
Received: from [10.54.75.144] (debox1-desk1.jf.intel.com [10.54.75.144])
        by linux.intel.com (Postfix) with ESMTP id D1915580AE2;
        Thu, 27 Oct 2022 09:37:45 -0700 (PDT)
Message-ID: <9b49ea5aeb6c54fd86bf3c02668bf21dd880fd12.camel@linux.intel.com>
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     platform-driver-x86@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Thu, 27 Oct 2022 09:37:45 -0700
In-Reply-To: <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com>
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
         <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-27 at 17:40 +0200, Hans de Goede wrote:
> Hi,
>=20
> On 10/27/22 17:19, Sven van Ashbrook wrote:
> > The "failure to enter S0ix" warning is critically important for monitor=
ing
> > and debugging power regressions, both in the field and in the test lab.
> >=20
> > Promote from lower-case warn() to upper-case WARN() so that it becomes
> > more prominent, and gets picked up as part of existing monitoring
> > infrastructure, which typically focuses on WARN() and ignores warn()
> > type log messages.
> >=20
> > Signed-off-by: Sven van Ashbrook <svenva@chromium.org>
>=20
> WARN() is really only intended for internal kernel bugs and not for
> hw misbehaving, so I'm not a fan of the change you are suggesting here.
>=20
> Intel folks, do you have an opinion on this ?

I agree that not entering s0ix is a critical failure, but this is a hardwar=
e
suspend failure. How we treat this should be akin to how we treat failure t=
o
enter S3 or deeper. S0ix support is indicated by the S0 Low Power Idle bit =
in
the ACPI FADT table. It's better IMO to create some framework in the suspen=
d or
ACPI core that allows platforms to report whether they have achieved the
hardware state indicated by having this bit set. Rafael, your thoughts?

David

>=20
> Regards,
>=20
> Hans
>=20
>=20
> > ---
> > Against v6.1-rc2
> >=20
> > =C2=A0drivers/platform/x86/intel/pmc/core.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/pmc/core.c
> > b/drivers/platform/x86/intel/pmc/core.c
> > index a1fe1e0dcf4a5..834f0352c0edf 100644
> > --- a/drivers/platform/x86/intel/pmc/core.c
> > +++ b/drivers/platform/x86/intel/pmc/core.c
> > @@ -2125,7 +2125,7 @@ static __maybe_unused int pmc_core_resume(struct
> > device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* The real interesting=
 case - S0ix failed - lets ask PMC why. */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_warn(dev, "CPU did not e=
nter SLP_S0!!! (S0ix cnt=3D%llu)\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_WARN(dev, "CPU did not e=
nter SLP_S0!!! (S0ix cnt=3D%llu)\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 pmcdev->s0ix_counter);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pmcdev->map->slps0_=
dbg_maps)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pmc_core_slps0_display(pmcdev, dev, NULL);
>=20

