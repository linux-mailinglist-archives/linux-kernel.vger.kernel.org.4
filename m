Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C790863C687
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiK2Rl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiK2RlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:41:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C786E4A9F0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669743683; x=1701279683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J7gCu+1SrmrHI57BwVRgl2hbCnIM1xt4olQEL+Kb8VE=;
  b=WQhrZ/rMdqC6RkLsCZ6cfVSH02Pz3fUKnr7qD5vLvU0ktc/3h0piYDl9
   nF2/xiunihrdTP3/kQL7tcyJV3sf1O/FUATEEAIshNpBN5hej+jy7+ru5
   2pEtslgvgJ7WKuHBGQyOXEFJqyHpOX7QCxIbmsgLUBCNzoigQStiLkGPu
   5utl8hkBTnFIP9lXE1S4HT/GRY9Cx5APG2PqCeWo56ZweOM5kgC4qdQQT
   iTCQlnK5S3mRSCCz4doYLw0Li1+oU40LnJD8t4y/Np3edsjphyirjB3mp
   KICOZnnOFchXPd7FLwuumYh0iI1t826TcQTl3K8HrOLviT+aN3SXnQge8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342102349"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="342102349"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:41:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="818303084"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="818303084"
Received: from cwchambe-mobl.amr.corp.intel.com (HELO [10.254.65.85]) ([10.254.65.85])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:41:22 -0800
Message-ID: <9f6491f7-b9c1-1450-7c2b-1b890567b21f@linux.intel.com>
Date:   Tue, 29 Nov 2022 10:41:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/cpu: Remove redundant extern x86_read_arch_cap_msr()
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>, X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20221128172451.792595-1-ashok.raj@intel.com>
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20221128172451.792595-1-ashok.raj@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 10:24, Ashok Raj wrote:
> x86_read_arch_cap_msr() has now moved to arch/x86/include/asm/cpu.h.
> Kill the redundant one in arch/x86/kernel/cpu.h
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  arch/x86/kernel/cpu/cpu.h  | 2 --
>  arch/x86/kernel/cpu/bugs.c | 1 +
>  arch/x86/kernel/cpu/tsx.c  | 1 +
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
> index a142b8d543a3..727ef3268ffb 100644
> --- a/arch/x86/kernel/cpu/cpu.h
> +++ b/arch/x86/kernel/cpu/cpu.h
> @@ -82,6 +82,4 @@ unsigned int aperfmperf_get_khz(int cpu);
>  extern void x86_spec_ctrl_setup_ap(void);
>  extern void update_srbds_msr(void);
>  
> -extern u64 x86_read_arch_cap_msr(void);
> -
>  #endif /* ARCH_X86_CPU_H */
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 3e3230cccaa7..a632fa07e93a 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -33,6 +33,7 @@
>  #include <asm/e820/api.h>
>  #include <asm/hypervisor.h>
>  #include <asm/tlbflush.h>
> +#include <asm/cpu.h>
>  
>  #include "cpu.h"
>  
> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> index ec7bbac3a9f2..667b25936818 100644
> --- a/arch/x86/kernel/cpu/tsx.c
> +++ b/arch/x86/kernel/cpu/tsx.c
> @@ -11,6 +11,7 @@
>  #include <linux/cpufeature.h>
>  
>  #include <asm/cmdline.h>
> +#include <asm/cpu.h>
>  
>  #include "cpu.h"
>  

Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
