Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3CB6FF914
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbjEKR7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbjEKR7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:59:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497FA7695
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683827951; x=1715363951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ceUwzLiQMdfmtaqxzxRObxz8s+lQ+tU3XOylmnSHbCw=;
  b=mvV01ybPm4DFf+V9eWcvM305Cf5UAKfgfxwK2xbbo3t5HwhwlTCXpIGu
   PIaC1gNHcN3W6LEX84Oc2NwVu4cLgWH4Zwcmt3G+NuH2vm4lheH00vrvZ
   BRav5MJ1Ui/uSmgOWPVMZlft3ZyN1idDO8zs0bPQjK6P5r0jWaTiY/AV6
   WMWoqn7KtGpJUMSRbewjO9IS8o/E4z5ReyNtUYXYUChV6NmFtLwpEaaeI
   2GIOV13TXH7sVZBVt5CISo0t833Q4ahKUUJofE3VLlcbeGSpIT8TFGjhM
   E+6bcJhLRmKehuX9jcvlvIoSNxm2qWZgCtC7rFArWXsjZWN0fbDiwa9fi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="349422969"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="349422969"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:59:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730470814"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="730470814"
Received: from ambujamp-mobl1.amr.corp.intel.com (HELO [10.212.238.119]) ([10.212.238.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:59:09 -0700
Message-ID: <9f6ed500-fa60-c898-69fd-41ae4a401eb4@intel.com>
Date:   Thu, 11 May 2023 10:59:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] fpu: xstate: Keep xfd_state always in-sync with IA32_XFD
 MSR
Content-Language: en-US
To:     Adamos Ttofari <attofari@amazon.de>
Cc:     abusse@amazon.de, dwmw@amazon.co.uk, hborghor@amazon.de,
        sironi@amazon.de, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org
References: <20230511152818.13839-1-attofari@amazon.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230511152818.13839-1-attofari@amazon.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 08:28, Adamos Ttofari wrote:
> @@ -179,8 +179,14 @@ void fpu__init_cpu_xstate(void)
>  	 * key as that does not work on the boot CPU. This also ensures
>  	 * that any stale state is wiped out from XFD.
>  	 */
> -	if (cpu_feature_enabled(X86_FEATURE_XFD))
> -		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
> +	if (cpu_feature_enabled(X86_FEATURE_XFD)) {
> +		u64 xfd;
> +
> +		rdmsrl(MSR_IA32_XFD, xfd);
> +		__this_cpu_write(xfd_state, xfd);
> +
> +		xfd_update_state(&init_fpstate);
> +	}

The above comment didn't _quite_ make it into the context, so I'll paste
it here for your convenience:

>         /*
>          * Must happen after CR4 setup and before xsetbv() to allow KVM
>          * lazy passthrough.  Write independent of the dynamic state static
>          * key as that does not work on the boot CPU. This also ensures
>          * that any stale state is wiped out from XFD.
>          */

Translating there, "the dynamic state static key" means
'__fpu_state_size_dynamic' which is used here:

> static __always_inline __pure bool fpu_state_size_dynamic(void)
> {
>         return static_branch_unlikely(&__fpu_state_size_dynamic);
> }

You might recognize fpu_state_size_dynamic() from the first line of
xfd_update_state(), the function that you added to the above hunk.

Which brings me to ask what the point of calling xfd_update_state() is
in the first place if you're getting away with it not working on the
boot CPU.

Why not just short-circuit the (non-working) xfd_update_state() and do
this directly:

	wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
        __this_cpu_write(xfd_state, init_fpstate.xfd);

I don't think you even need to *READ* the MSR.  You're going to blow it
away anyway.

>  	/*
>  	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
> @@ -915,7 +921,7 @@ void fpu__resume_cpu(void)
>  	}
>  
>  	if (fpu_state_size_dynamic())
> -		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
> +		xfd_update_state(&init_fpstate);
>  }
>  
>  /*

