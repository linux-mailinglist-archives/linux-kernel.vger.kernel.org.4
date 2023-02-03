Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA3868A1FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjBCS0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjBCS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:26:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626268C1E3;
        Fri,  3 Feb 2023 10:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675448812; x=1706984812;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o7iXVgypVhVDm2Y42Qj83EPr1rJZUQX2KVOGDIIjZu0=;
  b=B5VcYN8bfiuRVQr97D37RT6RzPUxQKnoy+t6Fxlzds7UFPElm9etsMha
   xtr/R5BBE1Vw8vKS3JqQrxNczV0po/PiwZWe7FeOaj+1FPYTttm4scsnP
   I1jfIlx6B5yO4zdsKYlOH3/9DXHg8kWd6c+MvoBkHRaQeTIvKgD6OrGek
   ptUe+Jo6gmuz6ne5Od+eBAcjc1/vhpgwctC/ohHLIidm2MTTlT8gHyhuW
   1Uo0ByUvIHGn3M4wPtPJdW332xoecd3s7XPZxMss07Y+PBuDi+Ir43VUg
   O0vIOmt8NEq+ojta6tnPB7aAN5xInakMH25mDGUDZYUBTDsMo4OxvFEHv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="309153085"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="309153085"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 10:26:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="667729007"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="667729007"
Received: from hheck-mobl.amr.corp.intel.com (HELO [10.212.230.180]) ([10.212.230.180])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 10:25:57 -0800
Message-ID: <fbf8d93e-2426-67f7-33c6-fe7d1a1a15b2@intel.com>
Date:   Fri, 3 Feb 2023 10:25:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Roxana Bradescu <roxabee@chromium.org>,
        Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Pawan Kumar Gupta <pawan.kumar.gupta@intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>
References: <20230125012801.362496-1-ebiggers@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230125012801.362496-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, I'm basically moving forward assuming that we're going to apply
this patch in _some_ form.  I'm going to make some changes, but I'll
discuss them in this thread to make sure we're all on the same page first.

On 1/24/23 17:28, Eric Biggers wrote:
> +Affected CPUs
> +-------------
> +
> +This vulnerability affects Intel Core family processors based on the Ice Lake
> +and later microarchitectures, and Intel Atom family processors based on the
> +Gracemont and later microarchitectures.  For more information, see Intel's
> +documentation [1]_.

I had a hard time following the docs in this area.

But I'm not sure this statement is correct.  The docs actually say:

	For Intel® Core™ family processors based on microarchitectures
	before Ice Lake and Intel Atom® family processors based on
	microarchitectures before Gracemont that do not enumerate
	IA32_UARCH_MISC_CTL, developers may assume that the instructions
	listed here operate as if DOITM is enabled.

A processor needs to be before "Ice Lake" and friends *AND* not
enumerate IA32_UARCH_MISC_CTL to be unaffected.

There's also another tweak that's needed because:

	Processors that do not enumerate IA32_ARCH_CAPABILITIES[DOITM]
	when the latest microcode is applied do not need to set
	IA32_UARCH_MISC_CTL [DOITM] in order to have the behavior
	described in this document...

First, we need to mention the "latest microcode" thing in the kernel
docs.  I also _think_ the whole "microarchitectures before" stuff is
rather irrelevant and we can simplify this down to:

	This vulnerability affects all Intel processors that support
	MSR_IA32_ARCH_CAPABILITIES and set MSR_IA32_ARCH_CAPABILITIES[DOITM]
	when the latest microcode is applied.

Which reminds me.  This:

> +void update_doitm_msr(void)
> +{
> +	u64 msr;
> +
> +	if (doitm_off)
> +		return;
> +
> +	rdmsrl(MSR_IA32_UARCH_MISC_CTL, msr);
> +	wrmsrl(MSR_IA32_UARCH_MISC_CTL, msr | UARCH_MISC_DOITM);
> +}

should probably be:

void update_doitm_msr(void)
{
	u64 msr;

	/*
	 * All processors that enumerate support for DOIT
	 * are affected *and* have the mitigation available.
	 */
	if (!boot_cpu_has_bug(X86_BUG_DODT))
		return;

	rdmsrl(MSR_IA32_UARCH_MISC_CTL, msr);
	if (doitm_off)
		msr &= ~UARCH_MISC_DOITM;
	else
		msr |= UARCH_MISC_DOITM;
	wrmsrl(MSR_IA32_UARCH_MISC_CTL, msr);
}

in case the CPU isn't actually coming out of reset, like if kexec() left
DOITM=1.

