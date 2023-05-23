Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896D770DE61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbjEWOCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEWOCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:02:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DB0CA;
        Tue, 23 May 2023 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684850550; x=1716386550;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WLNhzR90A7tJzYCLLb9hmz+gz4puSaamVCLyH9bdbTM=;
  b=Uu7fRLqmMZBvL15fS3vtBFpDqNr7alS16ooWPOLg8JtiMEsbIX88Wzl4
   fJeDoCO7ARbXGEqYzLSsKoXDgTg1yZJYMKLF4Dg2syHDRXTutYZMT0yeq
   G7WhBP4osC+rVCn+0fNXhjhuMdS+XF1H/ltbmcPWhx4bqPmzqJC1sg7lt
   +HjRS4P1LBBX3aEZWrkjiSBPg6yaLyCbZO+0hjPAlpmIDr5bj5KWGjK3C
   YNwjhGPAtfNBSjGyzRpCj7PJzLyhG92niRHH7ed9iTD1jTF0xcFBxLBP+
   399t1qTL7q0P3lnAd7ZWQANWZoXRZVC9kvXLAuSPaJuwJAjM0Wz4EwDF5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="332856169"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="332856169"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 07:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="878220406"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="878220406"
Received: from pkgolcon-mobl2.amr.corp.intel.com ([10.209.168.218])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 07:02:27 -0700
Message-ID: <96d81ba4c501134c77869a08b843b39fc1bf7526.camel@linux.intel.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Avoid initializing variables
 prematurely
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Fieah Lim <kweifat@gmail.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 May 2023 07:02:26 -0700
In-Reply-To: <CAJZ5v0ioQm95ZQ5LCCoDtVNX1TVQN_=sgzB_RRe5SAOOucpWJg@mail.gmail.com>
References: <20230523085045.29391-1-kweifat@gmail.com>
         <CAJZ5v0ifp1088wY7o=7pnBVBm=_3H0M4sfq6=gmyChZD6R9g1g@mail.gmail.com>
         <b5e35f904174905d8f90df3f49944b22389126c7.camel@linux.intel.com>
         <CAJZ5v0ioQm95ZQ5LCCoDtVNX1TVQN_=sgzB_RRe5SAOOucpWJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-23 at 15:37 +0200, Rafael J. Wysocki wrote:
> On Tue, May 23, 2023 at 2:20=E2=80=AFPM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Tue, 2023-05-23 at 13:08 +0200, Rafael J. Wysocki wrote:
> > > On Tue, May 23, 2023 at 10:51=E2=80=AFAM Fieah Lim <kweifat@gmail.com=
>
> > > wrote:
> > > >=20
> > > > We should avoid initializing some rather expensive data
> > > > when the function has a chance to bail out earlier
> > > > before actually using it.
> > > > This applies to the following initializations:
> > > >=20
> > > > =C2=A0- cpudata *cpu =3D all_cpu_data; (in everywhere)
> > > > =C2=A0- this_cpu =3D smp_processor_id(); (in notify_hwp_interrupt)
> > > > =C2=A0- hwp_cap =3D READ_ONCE(cpu->hwp_cap_cached); (in
> > > > intel_pstate_hwp_boost_up)
> > > >=20
> > > > These initializations are premature because there is a chance
> > > > that the function will bail out before actually using the data.
> > > > I think this qualifies as a micro-optimization,
> > > > especially in such a hot path.
> > > >=20
> > > > While at it, tidy up how and when we initialize
> > > > all of the cpu_data pointers, for the sake of consistency.
> > > >=20
> > > > A side note on the intel_pstate_cpu_online change:
> > > > we simply don't have to initialize cpudata just
> > > > for the pr_debug, while policy->cpu is being there.
> > > >=20
> > > > Signed-off-by: Fieah Lim <kweifat@gmail.com>
> > > > ---
> > > > V1 -> V2: Rewrite changelog for better explanation.
> > > >=20
> >=20
> > [...]
> >=20
> > > > =C2=A0void notify_hwp_interrupt(void)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int this_cpu =3D smp=
_processor_id();
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int this_cpu;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpudata *cpudata;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 value;
> > > > @@ -1591,6 +1593,8 @@ void notify_hwp_interrupt(void)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(value & 0x01))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this_cpu =3D smp_processor_id=
();
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&hwp_n=
otify_lock, flags);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpumask_test_cpu(th=
is_cpu, &hwp_intr_enable_mask))
> > >=20
> > > This is a place where it may really matter for performance, but
> > > how
> > > much?=C2=A0 Can you actually estimate this?
> >=20
> > If DEBUG_PREEMPT is defined
> > ~12 instructions (most of them with latency =3D 1 in dependency
> > chain)
>=20
> I really meant "estimate the effect of this change on performance",
> because I'm not sure if it is going to be visible in any test.
>=20
> But yes, skipping it if not needed at least makes some sense.
It will have neglible effect. I can measure it, but may be next week.

Thanks,
Srinivas
