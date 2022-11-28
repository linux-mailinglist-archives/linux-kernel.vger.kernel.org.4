Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F331A63B497
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiK1WEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiK1WEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:04:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA7731363
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669673050; x=1701209050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1NX8/rrplpuBi+H/jJ7Dp/ujozhkTOqEtdjoz83dFXk=;
  b=UWsdhkO5HK7PSRTosY4pCMXUGR10m/Z8m1oU9wxRgfzH48GjpT2GUSyZ
   +njohY8DPwdcjAHPQ2rB34WolcrP4NHn39fu7XwvOJB9Usj/XZR0SGn2o
   cWFX2WbyZVcBiW0DSQH5LESqHvmIc9vX9R+s4BpmeISSxB4b6IqZRd8e0
   PPN0jMwbo0j0iKgPaX+CUQ0BzBULbuARTUDpU6JdENcDyt/PvjDM3IjRT
   UAQ5Lg1HaP9WuxQhRClr0/VfR2iPrjVSEDGUL6Ayh3/+BnHxLIvvuKShO
   FQGC17agWF0OEfjPXnXRKV+XL7fD+odJUiUNPcsjjwWc4AQRJMYCeL5Mq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="341874229"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="341874229"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 14:04:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="645657431"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="645657431"
Received: from gmeghash-mobl2.amr.corp.intel.com (HELO desk) ([10.209.19.254])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 14:04:01 -0800
Date:   Mon, 28 Nov 2022 14:03:58 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        jpoimboe@kernel.org, peterz@infradead.org, x86@kernel.org,
        cascardo@canonical.com, leit@meta.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <20221128220358.n5vk6youcdl2er35@desk>
References: <20221124104650.533427-1-leitao@debian.org>
 <Y4QD8o8kWb1V4osq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y4QD8o8kWb1V4osq@zn.tnic>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 01:42:26AM +0100, Borislav Petkov wrote:
>On Thu, Nov 24, 2022 at 02:46:50AM -0800, Breno Leitao wrote:
>> Currently x86_spec_ctrl_base is read at boot time, and speculative bits
>> are set if configs are enable, such as MSR[SPEC_CTRL_IBRS] is enabled if
>> CONFIG_CPU_IBRS_ENTRY is configured. These MSR bits are not cleared if
>> the mitigations are disabled.
>>
>> This is a problem when kexec-ing a kernel that has the mitigation
>> disabled, from a kernel that has the mitigation enabled. In this case,
>> the MSR bits are carried forward and not cleared at the boot of the new
>> kernel. This might have some performance degradation that is hard to
>> find.
>>
>> This problem does not happen if the machine is (hard) rebooted, because
>> the bit will be cleared by default.
>>
>> This patch also defines a SPEC_CTRL_MASK macro, so, we can easily track
>> and clear if eventually some new mitigation shows up.
>
>Just remove that sentence - the macro's function is kinda obvious from
>the diff itself.
>
>> Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>  arch/x86/include/asm/msr-index.h | 3 +++
>>  arch/x86/kernel/cpu/bugs.c       | 9 ++++++++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 4a2af82553e4..704f49580ee1 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -54,6 +54,9 @@
>>  #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
>>  #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
>>
>> +#define SPEC_CTRL_MASK			(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
>> +							| SPEC_CTRL_RRSBA_DIS_S)
>
>Call that SPEC_CTRL_MITIGATIONS_MASK or so to denote what it is - a
>mask of the SPEC_CTRL bits which the kernel toggles when controlling
>mitigations.
>
>A comment above it wouldn't hurt either.
>
>> +
>>  #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
>>  #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
>>
>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> index 3e3230cccaa7..88957da1029b 100644
>> --- a/arch/x86/kernel/cpu/bugs.c
>> +++ b/arch/x86/kernel/cpu/bugs.c
>> @@ -137,8 +137,15 @@ void __init check_bugs(void)
>>  	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
>>  	 * init code as it is not enumerated and depends on the family.
>>  	 */
>> -	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
>> +	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
>>  		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>> +		/*
>> +		 * Previously running software may have some controls turned ON.
>
>"Previously running software, like kexec for example, ..."
>
>> +		 * Clear them and let kernel decide which controls to use.
>
>"Clear them and let the mitigations setup below set them based on configuration."
>
>> +		 */
>> +		x86_spec_ctrl_base &= ~SPEC_CTRL_MASK;
>> +		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>
>So this WRMSR will happen on the BSP only but the SPEC_CTRL MSR is
>per-CPU. As is x86_spec_ctrl_current which tracks it.
>
>So I'd say you don't need that WRMSR here - the proper value will get
>replicated eventually everywhere...

This patch is particularly for the case when user intends to turn off
the mitigations like with mitigations=off. In that case we need the
WRMSR because mitigation selection will simply return without writing to
the MSR on BSP.

As part of AP init x86_spec_ctrl_setup_ap() writes to the MSR even
when the mitigation is turned off, so AP's should have been fine, but I
think there is a subtle bug there as well. For below call:

x86_spec_ctrl_setup_ap(void)
{
	write_spec_ctrl_current(x86_spec_ctrl_base, true);

When x86_spec_ctrl_base is 0 MSR won't be written because of a check in
write_spec_ctrl_current() that doesn't write the MSR when the new value
(0) is same as x86_spec_ctrl_current (initialized to 0).

Below should fix the problem with APs:

---
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3e3230cccaa7..cfc2ed2661fc 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -66,7 +66,7 @@ static DEFINE_MUTEX(spec_ctrl_mutex);
   */
  void write_spec_ctrl_current(u64 val, bool force)
  {
-	if (this_cpu_read(x86_spec_ctrl_current) == val)
+	if (!force && this_cpu_read(x86_spec_ctrl_current) == val)
  		return;
  
  	this_cpu_write(x86_spec_ctrl_current, val);
