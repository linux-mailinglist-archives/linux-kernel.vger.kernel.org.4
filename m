Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E96C354D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCUPPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjCUPPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:15:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03598231F8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679411698; x=1710947698;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q4JVBJCRt24OxHmt4upWaAjS4Er9xOaDuw+KkK2GssQ=;
  b=bIf6HCiwi5DcgCcB3Xwsu2bKhNnlG2iRbsQa5ZmGNqA5r69TM9CAxm/p
   4OcFJqJHn18hQ/BD/K3psVYYnDfwKRze6LQPKj4FLsbgwB6DXB8fGsRLC
   VfrhYzOO193lFl3qOtaQ8mFSs2IF9xtm/vTJusYxIkE7zi36nkS5my1aa
   gh1o0eUnL/y4pJD+vr4l+8vYkJjZ9ass7Mf8QseG3YUNTkca6IRVU6Z2+
   6u7D91t/KcodAmtRFkEqRFx38Yi36A9wRqXNi7F6vaV9LjGB6Bte7ezh/
   uAp3bf43kVCJ/c9LN37fH1fRDPW0i4fJSLA0/FZ1tbvQ2ThsDeOwCl/is
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319358280"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="319358280"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 08:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="770675298"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="770675298"
Received: from jluqueti-mobl.ger.corp.intel.com ([10.252.63.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 08:14:51 -0700
Date:   Tue, 21 Mar 2023 17:14:49 +0200 (EET)
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
In-Reply-To: <20230320172620.18254-9-james.morse@arm.com>
Message-ID: <8f10581c-63ff-fef5-4f9e-d1ded096528@linux.intel.com>
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-9-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023, James Morse wrote:

> The limbo and overflow code picks a CPU to use from the domain's list
> of online CPUs. Work is then scheduled on these CPUs to maintain
> the limbo list and any counters that may overflow.
> 
> cpumask_any() may pick a CPU that is marked nohz_full, which will
> either penalise the work that CPU was dedicated to, or delay the
> processing of limbo list or counters that may overflow. Perhaps
> indefinitely. Delaying the overflow handling will skew the bandwidth
> values calculated by mba_sc, which expects to be called once a second.
> 
> Add cpumask_any_housekeeping() as a replacement for cpumask_any()
> that prefers housekeeping CPUs. This helper will still return
> a nohz_full CPU if that is the only option. The CPU to use is
> re-evaluated each time the limbo/overflow work runs. This ensures
> the work will move off a nohz_full CPU once a houskeeping CPU is

housekeeping

> available.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 23 +++++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 17 ++++++++++++-----
>  include/linux/tick.h                   |  3 ++-
>  3 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 87545e4beb70..0b5fd5a0cda2 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -7,6 +7,7 @@
>  #include <linux/kernfs.h>
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
> +#include <linux/tick.h>
>  #include <asm/resctrl.h>
>  
>  #define L3_QOS_CDP_ENABLE		0x01ULL
> @@ -55,6 +56,28 @@
>  /* Max event bits supported */
>  #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>  
> +/**
> + * cpumask_any_housekeeping() - Chose any cpu in @mask, preferring those that
> + *			        aren't marked nohz_full
> + * @mask:	The mask to pick a CPU from.
> + *
> + * Returns a CPU in @mask. If there are houskeeping CPUs that don't use
> + * nohz_full, these are preferred.
> + */
> +static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
> +{
> +	int cpu, hk_cpu;
> +
> +	cpu = cpumask_any(mask);
> +	if (tick_nohz_full_cpu(cpu)) {
> +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);

Why cpumask_nth_and() is not enough here? ..._andnot() seems to alter 
tick_nohz_full_mask which doesn't seem desirable?


-- 
 i.

