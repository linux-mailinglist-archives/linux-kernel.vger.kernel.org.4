Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46A563B606
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiK1XiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiK1XiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:38:03 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4743414D20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669678681; x=1701214681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9kk6qGhgFeOe6cFwnPq1cjclCYQX66efsWsltSbytwA=;
  b=WruU8oxTA+B99lk/RJBiA8deAQicbWOzoE8zyARFVrus99BRWLF4TBX2
   aFkccDIo3onJwQbEodlmDRuJsoYrR1x8K0Z6Jd8mT/0S2zgwlEZ2teQxm
   /P77FgxXs1BRsVVwq56CIq5oFY1f6KwCRVD0W1/1sI0Wq/Ss6+6A32ON8
   VlTcYWH0KIyLJ0RMlW+iAzDL40FvzrfnRQf559aH5DW5kZCzOt4cCJlJp
   k0ZNTXaxKHKc9D6eKuf0XygX1PRRuR8BiwrrItrHcXMlkkEPtzNjio+nM
   xtOJxbEILxzQ5czJAyYCQtpKETrgv0WVYwSyp07DiwdxIHgNQsEUd4RcP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="377120885"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="377120885"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 15:37:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="888625766"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="888625766"
Received: from gmeghash-mobl2.amr.corp.intel.com (HELO desk) ([10.209.19.254])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 15:37:41 -0800
Date:   Mon, 28 Nov 2022 15:37:39 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        jpoimboe@kernel.org, peterz@infradead.org, x86@kernel.org,
        cascardo@canonical.com, leit@meta.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <20221128233739.dd3dzx6qkermsfri@desk>
References: <20221124104650.533427-1-leitao@debian.org>
 <Y4QD8o8kWb1V4osq@zn.tnic>
 <20221128220358.n5vk6youcdl2er35@desk>
 <Y4U40wKoSF/ze1Ud@zn.tnic>
 <20221128230219.urqiol42rikdhy2u@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221128230219.urqiol42rikdhy2u@desk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 03:02:21PM -0800, Pawan Gupta wrote:
>On Mon, Nov 28, 2022 at 11:40:19PM +0100, Borislav Petkov wrote:
>>On Mon, Nov 28, 2022 at 02:03:58PM -0800, Pawan Gupta wrote:
>>>diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>>>index 3e3230cccaa7..cfc2ed2661fc 100644
>>>--- a/arch/x86/kernel/cpu/bugs.c
>>>+++ b/arch/x86/kernel/cpu/bugs.c
>>>@@ -66,7 +66,7 @@ static DEFINE_MUTEX(spec_ctrl_mutex);
>>>  */
>>> void write_spec_ctrl_current(u64 val, bool force)
>>> {
>>>-	if (this_cpu_read(x86_spec_ctrl_current) == val)
>>>+	if (!force && this_cpu_read(x86_spec_ctrl_current) == val)
>>> 		return;
>>> 	this_cpu_write(x86_spec_ctrl_current, val);
>>
>>Still looks hacky to me.
>>
>>I think it would be a lot cleaner if MSR_IA32_SPEC_CTRL gets cleaned of
>>the speculation bits in init_speculation_control() which gets run on
>>*every* CPU.
>>
>>So by the time check_bugs() gets to setup stuff, the MSR will be ready
>>to go regardless.
>>
>>I.e., something like this (not supposed to work - just to show what I
>>mean):
>>
>>diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>>index 73cc546e024d..367732c92942 100644
>>--- a/arch/x86/kernel/cpu/common.c
>>+++ b/arch/x86/kernel/cpu/common.c
>>@@ -993,9 +993,19 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
>>	 * Intel CPUs, for finer-grained selection of what's available.
>>	 */
>>	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
>>+		u64 msr;
>>+
>>		set_cpu_cap(c, X86_FEATURE_IBRS);
>>		set_cpu_cap(c, X86_FEATURE_IBPB);
>>		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>>+
>>+		/*
>>+		 * Clear speculation control settings from a previous kernel
>>+		 * run, i.e., kexec.
>>+		 */
>>+		rdmsrl(MSR_IA32_SPEC_CTRL, msr);
>>+		if (msr & SPEC_CTRL_MASK)
>>+			wrmsr (MSR_IA32_SPEC_CTRL, msr & ~SPEC_CTRL_MASK);
>
>Yes thats a cleaner approach, except that the late microcode load will
>ruin the MSR:

Root of the original problem is x86_spec_ctrl_current is not the current
value of MSR at bootup.

How about we update x86_spec_ctrl_current before any writes to the MSR?:

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3e3230cccaa7..68ed52394fd9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -137,8 +137,18 @@ void __init check_bugs(void)
  	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
  	 * init code as it is not enumerated and depends on the family.
  	 */
-	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
  		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		/*
+		 * Previously running software, like kexec for example, may
+		 * have some controls turned ON.
+		 * Clear them and let the mitigations setup below set them
+		 * based on configuration.
+		 */
+		this_cpu_write(x86_spec_ctrl_current, x86_spec_ctrl_base);
+		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
+		write_spec_ctrl_current(x86_spec_ctrl_base, true);
+	}
  
  	/* Select the proper CPU mitigations before patching alternatives: */
  	spectre_v1_select_mitigation();
@@ -2047,8 +2057,13 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
  
  void x86_spec_ctrl_setup_ap(void)
  {
-	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
+		u64 msr;
+
+		rdmsrl(MSR_IA32_SPEC_CTRL, msr);
+		this_cpu_write(x86_spec_ctrl_current, msr);
  		write_spec_ctrl_current(x86_spec_ctrl_base, true);
+	}
  
  	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
  		x86_amd_ssb_disable();
