Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8083F667E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbjALSqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239902AbjALSqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:46:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5A18099C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673547563; x=1705083563;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=agEBJwFDyT+Gk+KNwyRfcZtOwjfGxVNcowtBC6hm3XA=;
  b=CTFfE4IZcmSvNzwHXqI6I+OOmt5TryFUg3uY1zCuxUpBJqdiExTwzyZM
   27UlEfvrND45YzeQjebM/wsvjdN1VVbva+B2E1qFCpkIKLx00ivFEgfmo
   fuXLyQ/t26pVZLhVB0U66nQ5vdqAcZn0Hp4QYcU8UgLEMtLW59VhUaFNz
   lz0Qzk7b5thqdmGJ8ZFYug7Lf9itUKWxN08w6KTirfua7/Vg1Faxi3+jM
   nN/fVoSBrrsV9tXJ6fvmllc5xeEPm9xDsBn3M/xI+UHybbn9f0m5dUlLB
   U7eCRDbaXF81qofR17lwNXWdyAyH1UPzCSISF0NKLBVcUVDJuE/Yu/3B0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="304164906"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="304164906"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:17:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="746637295"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="746637295"
Received: from mdarpino-mobl.amr.corp.intel.com (HELO [10.209.117.208]) ([10.209.117.208])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:17:11 -0800
Message-ID: <7e859e72-4624-73c7-8195-c252ace0a49d@intel.com>
Date:   Thu, 12 Jan 2023 10:17:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/7] x86/cpu: Enable LASS (Linear Address Space
 Separation)
Content-Language: en-US
To:     Yian Chen <yian.chen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-6-yian.chen@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230110055204.3227669-6-yian.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 21:52, Yian Chen wrote:
> +static __always_inline void setup_lass(struct cpuinfo_x86 *c)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> +		cr4_set_bits(X86_CR4_LASS);
> +	} else {
> +		/*
> +		 * only clear the feature and cr4 bits when hardware
> +		 * supports LASS, in case it was enabled in a previous
> +		 * boot (e.g., via kexec)
> +		 */
> +		if (cpu_has(c, X86_FEATURE_LASS)) {
> +			cr4_clear_bits(X86_CR4_LASS);
> +			clear_cpu_cap(c, X86_FEATURE_LASS);
> +		}
> +	}
> +}

Could you try testing this, please?

Please remember that there are three things in play here:
 1. disabled-features.h.  Makes cpu_feature_enabled(X86_FEATURE_LASS)==0
    when CONFIG_X86_LASS=n.
 2. The X86_FEATURE_LASS software feature bit itself.  clearcpuid=lass
    would clear it.
 3. The actual CPU enumeration of X86_FEATURE_LASS

The else{} is handling the case where X86_FEATURE_LASS is compiled out
but where the CPU supports LASS.  It doesn't do anything when the CPU
lacks LASS support *OR* when clearcpuid=lass is used.

In the end, want X86_CR4_LASS set when the kernel wants LASS and clear
in *ALL* other cases.  That would be simply:

	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
		cr4_set_bits(X86_CR4_LASS);
	} else {
		cr4_clear_bits(X86_CR4_LASS);
	}

The cr4_clear_bits(X86_CR4_LASS) should be safe regardless of CPU or
kernel support for LASS.

As for the:

	clear_cpu_cap(c, X86_FEATURE_LASS);

It really only matters for kernels where CONFIG_X86_LASS=n but where the
CPU supports it.  I'm not clear on what specifically you expect to gain
from it, though.

I'm also wondering if we even want a Kconfig option.  Is anyone
realistically going to be compiling this support out?
