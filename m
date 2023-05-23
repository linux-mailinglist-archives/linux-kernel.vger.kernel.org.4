Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7792270DC61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbjEWMUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjEWMUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:20:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE1188;
        Tue, 23 May 2023 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684844393; x=1716380393;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=cSEOYPfunSW4a7ojtMkq0xtAYcLulVEFqRdgLDwJDLY=;
  b=C8hZZnj632TlsabSA8whPbRPC+TQrZkBduGRwHnGOi98OZ8FhQQd/61J
   OOgbhBekv9lG5BRLSCGSr8DmGZwifS+IP7PMb4LoCei4xCtx70Jl3+B2Q
   eehMaAor9V+9Q5sVbQnzTqmdWaZy2OkaIzZZOJmLP41Alpi9P6L2Z9WL2
   O2+Qd3Vu9DZdNMg7Mi6VQQBIEj2YlGDX3XhWFtxi2sQmmEfZrD35GdDia
   W736uPi//97yo1cIQH1v2HO/oD3OZOwnhd1GqkAKeBnNMBZfSa8Rn9ZKp
   1XrDHAYhMnoiky2fX4yoNRVcbIykhCYLPurKR59vfy94kP+o1QH8P3C4T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="342679858"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="342679858"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 05:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="848248129"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="848248129"
Received: from hverma-mobl1.amr.corp.intel.com ([10.212.7.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 05:19:52 -0700
Message-ID: <b5e35f904174905d8f90df3f49944b22389126c7.camel@linux.intel.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Avoid initializing variables
 prematurely
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Fieah Lim <kweifat@gmail.com>
Cc:     lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 May 2023 05:19:49 -0700
In-Reply-To: <CAJZ5v0ifp1088wY7o=7pnBVBm=_3H0M4sfq6=gmyChZD6R9g1g@mail.gmail.com>
References: <20230523085045.29391-1-kweifat@gmail.com>
         <CAJZ5v0ifp1088wY7o=7pnBVBm=_3H0M4sfq6=gmyChZD6R9g1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-23 at 13:08 +0200, Rafael J. Wysocki wrote:
> On Tue, May 23, 2023 at 10:51=E2=80=AFAM Fieah Lim <kweifat@gmail.com> wr=
ote:
> >=20
> > We should avoid initializing some rather expensive data
> > when the function has a chance to bail out earlier
> > before actually using it.
> > This applies to the following initializations:
> >=20
> > =C2=A0- cpudata *cpu =3D all_cpu_data; (in everywhere)
> > =C2=A0- this_cpu =3D smp_processor_id(); (in notify_hwp_interrupt)
> > =C2=A0- hwp_cap =3D READ_ONCE(cpu->hwp_cap_cached); (in
> > intel_pstate_hwp_boost_up)
> >=20
> > These initializations are premature because there is a chance
> > that the function will bail out before actually using the data.
> > I think this qualifies as a micro-optimization,
> > especially in such a hot path.
> >=20
> > While at it, tidy up how and when we initialize
> > all of the cpu_data pointers, for the sake of consistency.
> >=20
> > A side note on the intel_pstate_cpu_online change:
> > we simply don't have to initialize cpudata just
> > for the pr_debug, while policy->cpu is being there.
> >=20
> > Signed-off-by: Fieah Lim <kweifat@gmail.com>
> > ---
> > V1 -> V2: Rewrite changelog for better explanation.
> >=20

[...]

> > =C2=A0void notify_hwp_interrupt(void)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int this_cpu =3D smp_pro=
cessor_id();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int this_cpu;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpudata *cpudata;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 value;
> > @@ -1591,6 +1593,8 @@ void notify_hwp_interrupt(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(value & 0x01))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this_cpu =3D smp_processor_id();
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&hwp_notif=
y_lock, flags);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpumask_test_cpu(this_c=
pu, &hwp_intr_enable_mask))
>=20
> This is a place where it may really matter for performance, but how
> much?=C2=A0 Can you actually estimate this?

If DEBUG_PREEMPT is defined
~12 instructions (most of them with latency =3D 1 in dependency chain)

Thanks,
Srinivas=20



>=20
> > @@ -2024,8 +2028,8 @@ static int hwp_boost_hold_time_ns =3D 3 *
> > NSEC_PER_MSEC;
> >=20
> > =C2=A0static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
> > =C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 hwp_cap;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 hwp_req =3D READ_ONCE(cp=
u->hwp_req_cached);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 hwp_cap =3D READ_ONCE(cpu->hw=
p_cap_cached);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 max_limit =3D (hwp_req &=
 0xff00) >> 8;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 min_limit =3D (hwp_req &=
 0xff);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 boost_level1;
> > @@ -2052,6 +2056,7 @@ static inline void
> > intel_pstate_hwp_boost_up(struct cpudata *cpu)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cpu->hwp_boost_min =3D min_limit;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* level at half way mark be=
tween min and guranteed */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwp_cap =3D READ_ONCE(cpu->hwp_ca=
p_cached);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boost_level1 =3D (HWP_GUARAN=
TEED_PERF(hwp_cap) + min_limit)
> > >> 1;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu->hwp_boost_min < boo=
st_level1)
>=20
> For clarity, the original code is much better than the new one and
> the
> only case where hwp_cap is not used is when that single read doesn't
> matter.=C2=A0 Moreover, the compiler is free to optimize it too.
>=20
> > @@ -2389,9 +2394,7 @@ static const struct x86_cpu_id
> > intel_pstate_cpu_ee_disable_ids[] =3D {
> >=20
> > =C2=A0static int intel_pstate_init_cpu(unsigned int cpunum)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpudata *cpu;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu =3D all_cpu_data[cpunum];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpudata *cpu =3D all_cpu_d=
ata[cpunum];
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpu) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cpu =3D kzalloc(sizeof(*cpu), GFP_KERNEL);
> > @@ -2431,11 +2434,13 @@ static int intel_pstate_init_cpu(unsigned
> > int cpunum)
> >=20
> > =C2=A0static void intel_pstate_set_update_util_hook(unsigned int
> > cpu_num)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpudata *cpu =3D all_cpu_d=
ata[cpu_num];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpudata *cpu;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hwp_active && !hwp_boost=
)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu =3D all_cpu_data[cpu_num];
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu->update_util_set)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> >=20
>=20
> This isn't a hot path.
>=20
> > @@ -2638,9 +2643,7 @@ static int intel_cpufreq_cpu_offline(struct
> > cpufreq_policy *policy)
> >=20
> > =C2=A0static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpudata *cpu =3D all_cpu_d=
ata[policy->cpu];
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("CPU %d going online\n",=
 cpu->cpu);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("CPU %d going online\n",=
 policy->cpu);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 intel_pstate_init_acpi_perf_=
limits(policy);
> >=20
> > @@ -2649,6 +2652,8 @@ static int intel_pstate_cpu_online(struct
> > cpufreq_policy *policy)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Re-enable HWP and clear the "suspended" flag =
to
> > let "resume"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * know that it need not do that.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct cpudata *cpu =3D all_cpu_data[policy->cpu];
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 intel_pstate_hwp_reenable(cpu);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cpu->suspended =3D false;
>=20
> Same here and I don't see why the change matters.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > --
>=20
> There is one piece in this patch that may be regarded as useful.
> Please send it separately.

