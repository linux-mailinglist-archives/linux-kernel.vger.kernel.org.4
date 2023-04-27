Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973366F0789
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbjD0Odf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbjD0Odd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:33:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6140C3A9A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682605992; x=1714141992;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Ghjj7/pAI2Lt48bZ+H1mHPWog9TtCCxOuQJ9w6IEJos=;
  b=MolSDQWCVXElzfdxVDb6IbXGjPlfZ7d3y16+AuFU58HeFXVanXynCD/H
   GX3fM+Lzkh7K/V7rDmcZDn8IV218j5LFoNRwESMmMz4LqLGLgkHz5gqy/
   xDCr4D4Ze8rG7cX9zJ6TuO4bISXQGmMvuyyKoA+C01pakshtRKUMLORVn
   RngV/Pzq+GN8j7s8tQtFWJBAN2JvWyTZl6sfAxwd8IGPDMPBLwoWQfBUY
   eM1x1dFBcAYF+D6Wu7PdJG91u7HlUNDjPnTPA8L3c58rNhP2qjnmNjQTF
   rZafbI3UmDL/4UdanbztG2zMjIAgCj0G1KY45bjNyYTBbfghp7ketO1mq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="331734465"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="331734465"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 07:26:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="688457558"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="688457558"
Received: from mmaiores-mobl.ger.corp.intel.com ([10.251.215.69])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 07:25:57 -0700
Date:   Thu, 27 Apr 2023 17:25:55 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     James Morse <james.morse@arm.com>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
Subject: Re: [PATCH v3 08/19] x86/resctrl: Add cpumask_any_housekeeping()
 for limbo/overflow
In-Reply-To: <01e0704c-6d69-07ca-8a3b-c2cff498c972@arm.com>
Message-ID: <b7af42dd-2169-5013-93d8-24eb5c37f5bf@linux.intel.com>
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-9-james.morse@arm.com> <8f10581c-63ff-fef5-4f9e-d1ded096528@linux.intel.com> <01e0704c-6d69-07ca-8a3b-c2cff498c972@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1398859792-1682605245=:1971"
Content-ID: <15901d80-47cc-c224-ed2c-740bf4d25aa@linux.intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1398859792-1682605245=:1971
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <a95c9f68-1947-1d2a-b7d8-35679b5b7bb0@linux.intel.com>

On Thu, 27 Apr 2023, James Morse wrote:

> Hi Ilpo,
> 
> On 21/03/2023 15:14, Ilpo Järvinen wrote:
> > On Mon, 20 Mar 2023, James Morse wrote:
> > 
> >> The limbo and overflow code picks a CPU to use from the domain's list
> >> of online CPUs. Work is then scheduled on these CPUs to maintain
> >> the limbo list and any counters that may overflow.
> >>
> >> cpumask_any() may pick a CPU that is marked nohz_full, which will
> >> either penalise the work that CPU was dedicated to, or delay the
> >> processing of limbo list or counters that may overflow. Perhaps
> >> indefinitely. Delaying the overflow handling will skew the bandwidth
> >> values calculated by mba_sc, which expects to be called once a second.
> >>
> >> Add cpumask_any_housekeeping() as a replacement for cpumask_any()
> >> that prefers housekeeping CPUs. This helper will still return
> >> a nohz_full CPU if that is the only option. The CPU to use is
> >> re-evaluated each time the limbo/overflow work runs. This ensures
> >> the work will move off a nohz_full CPU once a houskeeping CPU is
> > 
> > housekeeping
> > 
> >> available.
> 
> >> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> >> index 87545e4beb70..0b5fd5a0cda2 100644
> >> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> >> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> 
> >> +/**
> >> + * cpumask_any_housekeeping() - Chose any cpu in @mask, preferring those that
> >> + *			        aren't marked nohz_full
> >> + * @mask:	The mask to pick a CPU from.
> >> + *
> >> + * Returns a CPU in @mask. If there are houskeeping CPUs that don't use
> >> + * nohz_full, these are preferred.
> >> + */
> >> +static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
> >> +{
> >> +	int cpu, hk_cpu;
> >> +
> >> +	cpu = cpumask_any(mask);
> >> +	if (tick_nohz_full_cpu(cpu)) {
> >> +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> > 
> > Why cpumask_nth_and() is not enough here? ..._andnot() seems to alter 
> > tick_nohz_full_mask which doesn't seem desirable?
> 
> tick_nohz_full_mask is the list of CPUs we should avoid. This wants to find the first cpu
> set in the domain mask, and clear in tick_nohz_full_mask.
> 
> Where does cpumask_nth_andnot() modify its arguments? Its arguments are const.

Ah, it doesn't, I'm sorry about that.

I think I was trapped by ambiguous English:
 * cpumask_nth_andnot - get the first cpu set in 1st cpumask, and clear in 2nd.
...which can be understood as it clearing it in 2nd.


-- 
 i.
--8323329-1398859792-1682605245=:1971--
