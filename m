Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8247B63B576
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiK1XC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiK1XCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:02:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CAD1C10D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669676544; x=1701212544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iiqUjAHCO+LQ+rR+96mD8ATucD1rodYYrVb/pJ5LDbM=;
  b=ePv5iSkxvnrSfFqK1rN8aNVPdegBiyKjAxkeq/P4LOxSP9GkeyHkii5E
   gKE5dwmTaRcUfd73i5PLIgfmVUEmCEHMb8CirJnj4CQ64pEZGV0XkSsco
   WK1i6m7OUlP+kKdWwmAkDWWsUk6/e0e4RzuBov+8nT6qzihK1NzLEAAkc
   OiNsM/4mJD1SmyyqYKqvW6VyQ3vxf8nekQGo2MrEr8Sy8hZb9vlaF/AqJ
   FEnYuU06vSGk1APFKdCmUzAqNvXx7svGLewLmVdJ5S+etuT4Rr82aEJKr
   vPDOd0cImdNf7Hz5SxBvunswa4ljaMI4fQ7pQRDCKC4NbruhQ+zxPfydn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313672943"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="313672943"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 15:02:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="676216763"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="676216763"
Received: from gmeghash-mobl2.amr.corp.intel.com (HELO desk) ([10.209.19.254])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 15:02:21 -0800
Date:   Mon, 28 Nov 2022 15:02:19 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        jpoimboe@kernel.org, peterz@infradead.org, x86@kernel.org,
        cascardo@canonical.com, leit@meta.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <20221128230219.urqiol42rikdhy2u@desk>
References: <20221124104650.533427-1-leitao@debian.org>
 <Y4QD8o8kWb1V4osq@zn.tnic>
 <20221128220358.n5vk6youcdl2er35@desk>
 <Y4U40wKoSF/ze1Ud@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y4U40wKoSF/ze1Ud@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:40:19PM +0100, Borislav Petkov wrote:
>On Mon, Nov 28, 2022 at 02:03:58PM -0800, Pawan Gupta wrote:
>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> index 3e3230cccaa7..cfc2ed2661fc 100644
>> --- a/arch/x86/kernel/cpu/bugs.c
>> +++ b/arch/x86/kernel/cpu/bugs.c
>> @@ -66,7 +66,7 @@ static DEFINE_MUTEX(spec_ctrl_mutex);
>>   */
>>  void write_spec_ctrl_current(u64 val, bool force)
>>  {
>> -	if (this_cpu_read(x86_spec_ctrl_current) == val)
>> +	if (!force && this_cpu_read(x86_spec_ctrl_current) == val)
>>  		return;
>>  	this_cpu_write(x86_spec_ctrl_current, val);
>
>Still looks hacky to me.
>
>I think it would be a lot cleaner if MSR_IA32_SPEC_CTRL gets cleaned of
>the speculation bits in init_speculation_control() which gets run on
>*every* CPU.
>
>So by the time check_bugs() gets to setup stuff, the MSR will be ready
>to go regardless.
>
>I.e., something like this (not supposed to work - just to show what I
>mean):
>
>diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>index 73cc546e024d..367732c92942 100644
>--- a/arch/x86/kernel/cpu/common.c
>+++ b/arch/x86/kernel/cpu/common.c
>@@ -993,9 +993,19 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
> 	 * Intel CPUs, for finer-grained selection of what's available.
> 	 */
> 	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
>+		u64 msr;
>+
> 		set_cpu_cap(c, X86_FEATURE_IBRS);
> 		set_cpu_cap(c, X86_FEATURE_IBPB);
> 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>+
>+		/*
>+		 * Clear speculation control settings from a previous kernel
>+		 * run, i.e., kexec.
>+		 */
>+		rdmsrl(MSR_IA32_SPEC_CTRL, msr);
>+		if (msr & SPEC_CTRL_MASK)
>+			wrmsr (MSR_IA32_SPEC_CTRL, msr & ~SPEC_CTRL_MASK);

Yes thats a cleaner approach, except that the late microcode load will
ruin the MSR:

microcode_reload_late()
   microcode_check()
     get_cpu_cap()
       init_speculation_control()
