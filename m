Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C023962022C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiKGWOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiKGWN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:13:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44F20191
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667859234; x=1699395234;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wTFoYQh/CL22ztAqNuaBrPon8YAI9IJv18TxizlD190=;
  b=WDEOrx6mEKrQMd6/AKfCetvxiVxojyQdmETkRDs6RWoM3s+TJkzoBsiS
   bJ/vXYVIvZDRTAw7u9FuqYtOaBd32a1sckdn19D6E8DeRQKnNCrxzba9+
   HbByVzSHPDX3B8nOGQtDEHC4wPjxaiWVoqTkZjOYN+hoxeqUEZCX25GzO
   fTXyYbpdvs86atE/VWutu+X2OqmUvI+xMCSE89IRgcFMbpVs8z+Zqh/kg
   9DrSlxwOEc8raklT1Qx5io6FE3R7A9aqT59fduILtCM6HeN3X5a0dklED
   pQGr9h3mXtOKmCB/IfZ8C7udQf8cgCb145EPyW/6PUANinlR2UW/Slnbm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="337259522"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="337259522"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:13:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="881251508"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="881251508"
Received: from peggykes-mobl.amr.corp.intel.com (HELO [10.251.7.244]) ([10.251.7.244])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:13:53 -0800
Message-ID: <50b2113d-d6a8-ab36-028d-b78c41142c18@intel.com>
Date:   Mon, 7 Nov 2022 14:13:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/cpu: Start documenting what the X86_FEATURE_ flag
 testing macros do
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20221107211505.8572-1-bp@alien8.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221107211505.8572-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 13:15, Borislav Petkov wrote:
>  /*
> - * This macro is for detection of features which need kernel
> - * infrastructure to be used.  It may *not* directly test the CPU
> - * itself.  Use the cpu_has() family if you want true runtime
> - * testing of CPU features, like in hypervisor code where you are
> - * supporting a possible guest feature where host support for it
> - * is not relevant.
> + * This is the preferred macro to use when testing X86_FEATURE_ bits
> + * support without the need to test on a particular CPU but rather
> + * system-wide. It takes into account build-time disabled feature
> + * support too. All those macros mirror the kernel's idea of enabled
> + * CPU features and not necessarily what real, hardware CPUID bits are
> + * set or clear. For that use tools/arch/x86/kcpuid/ and/or potentially
> + * extend if it's feature list is lacking.
>   */
>  #define cpu_feature_enabled(bit)	\
>  	(__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))

Thanks for kicking this off!  It's sorely needed.

This also makes me wonder if we should update the
_static_cpu_has() comment:

 * Static testing of CPU features. Used the same as boot_cpu_has(). It
 * statically patches the target code for additional performance. Use
 * static_cpu_has() only in fast paths, where every cycle counts. Which
 * means that the boot_cpu_has() variant is already fast enough for the
 * majority of cases and you should stick to using it as it is generally
 * only two instructions: a RIP-relative MOV and a TEST.

It seems to be mildly warning against using _static_cpu_has()
indiscriminately.  Should we tone that down a bit if we're recommending
implicit use of static_cpu_has() via cpu_feature_enabled() everywhere?

I was also thinking that some longer-form stuff in Documentation/ might
be a good idea, along with some examples.  I'd be happy to follow this
up with another patch that added Documentation/ like:

--

New processor features often have specific Kconfig options as well as
enumeration in CPUID and/or and X86_FEATURE_* flags.  In most cases, the
feature must both be compiled in and have processor support, so checks
for the feature might take this form:

void enable_foo(void)
{
	if (!IS_ENABLED(CONFIG_X86_FOO))
		return;
	if (!static_cpu_has(X86_FEATURE_FOO))
		return;

	... do some enabling here
}

Or something equivalent with #ifdefs.  The preferred form is:

void enable_foo(void)
{
	if (!cpu_feature_enabled(X86_FEATURE_FOO))
		return;

	... do some enabling here
}

plus adding X86_FEATURE_FOO to arch/x86/include/asm/disabled-features.h,
like:

#ifdef CONFIG_X86_FOO
# define DISABLE_FOO   0
#else
# define DISABLE_FOO   (1<<(X86_FEATURE_FOO & 31))
#endif


That form has two "hidden" optimizations:
1. Compile-time optimization: If the Kconfig option is disabled,
   cpu_feature_enabled() will evaluate at compile-time to 0.  It can
   entirely replace an IS_ENABLED() check, or an #ifdef in most cases.
2. The conditional branch will be statically patched out using
   _static_cpu_has().  This allows the normal runtime code to execute
   without any conditional branches that might be mispredicted.
