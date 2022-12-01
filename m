Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4648163F5C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLAQ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiLAQ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:58:15 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E690D1A064
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:58:14 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 62so2150334pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CcbLtYfJOUPv9hfp+Y14KjDL6nnYgGwjjKw594bKLHA=;
        b=M7Cy/EGD/LO/JhRD3VFjxVgnlzZBSlIpWZurKAOV4ywrSpW3BkU+d8f9iD0IT7hiOF
         S8Sj5iB7vAGpqvxgcz3x7K+IYUatpvfwK19hR64X5gGXCtlhz3DpU7q3WkfgJBBRhXoU
         M4QGPq9IPVAlmcWPmI1Brr1MoCz9OxLy4FbIjLVUhuueYlCAjXTFsG7WVC7rlYOTCY8Q
         mjXtv3KBNnaPLEVvmY1W1rT4zlJnvwmI4yMHdV+G2oXOkEVM/qOd2TYDCNmqSYjweSk7
         0zjdlIKCN+vOkRtSErgKZbL9FajfcaKblWDV2awqCIYbvyOe/6114Qt0Xmc8S0MeEgZf
         QdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcbLtYfJOUPv9hfp+Y14KjDL6nnYgGwjjKw594bKLHA=;
        b=EKz1VjGiG0whycPx/1EvCtVbii8vFtw/hb3bHTwfzqLA4N9qbDVlfLY/E7TGJ+lqCg
         wkTjAqsq9Hc/k4pcT3usQXO568thlUewSJwow0ZFwysxl19OKnllUYEvOoVARQWz1z2V
         SrEG0Md0e2BdweXX39OzspLq0j84WygM/43mfAISmsMrImpGjGQ0OUV/JFrfYPNPGLOU
         HdZxo0jyCZsLlBnvMUA28kNbw848tAqvzhFwxQoJ8U7o78Clm1H0DrzXJ4gUSgwrmxLX
         Q+9AABZZcoYDW7cUhOyhV62hvUJqMXGXUAsm81720FwpTMIx85Oj6t7GwbfOoigitbYl
         eeow==
X-Gm-Message-State: ANoB5plSANBKg6LcVEtOmgcgr19QLJnD0jHh67pE/BWL4mATAKQBol0u
        iF7GqRIo3okAyMCXvc/wGHoFSA==
X-Google-Smtp-Source: AA0mqf4jVHKnm8+YROUPUEPkzh3iZM+56tYPVHv8rpwSyePE4ge2p7ShbFEX2c9J+9P9fcWJOqWuzg==
X-Received: by 2002:a63:4c63:0:b0:477:103:d1c4 with SMTP id m35-20020a634c63000000b004770103d1c4mr40951530pgl.369.1669913894315;
        Thu, 01 Dec 2022 08:58:14 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b0017f5ad327casm3850241plb.103.2022.12.01.08.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:58:13 -0800 (PST)
Date:   Thu, 1 Dec 2022 16:58:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michael Sterritt <sterritt@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH kernel 1/3] x86/amd/dr_addr_mask: Cache values in percpu
 variables
Message-ID: <Y4jdIl1elcnL8JUU@google.com>
References: <20221201021948.9259-1-aik@amd.com>
 <20221201021948.9259-2-aik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201021948.9259-2-aik@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022, Alexey Kardashevskiy wrote:
> Reading DR[0-3]_ADDR_MASK MSRs takes about 250 cycles which is going to
> be noticeable when the AMD KVM SEV-ES's DebugSwap feature is enabled and
> KVM needs to store these before switching to a guest; the DebugSwitch
> hardware support restores them as type B swap.
>
> This stores MSR values from set_dr_addr_mask() in percpu values and
> returns them via new get_dr_addr_mask(). The gain here is about 10x.
>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>  arch/x86/include/asm/debugreg.h |  1 +
>  arch/x86/kernel/cpu/amd.c       | 32 ++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> index cfdf307ddc01..c4324d0205b5 100644
> --- a/arch/x86/include/asm/debugreg.h
> +++ b/arch/x86/include/asm/debugreg.h
> @@ -127,6 +127,7 @@ static __always_inline void local_db_restore(unsigned long dr7)
>  
>  #ifdef CONFIG_CPU_SUP_AMD
>  extern void set_dr_addr_mask(unsigned long mask, int dr);
> +extern unsigned long get_dr_addr_mask(int dr);
>  #else
>  static inline void set_dr_addr_mask(unsigned long mask, int dr) { }

KVM_AMD doesn't depend on CPU_SUP_AMD, i.e. this needs a stub.  Or we need to add
a dependency.

> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index c75d75b9f11a..ec7efcef4e14 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1158,6 +1158,11 @@ static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
>  	return false;
>  }
>  
> +DEFINE_PER_CPU_READ_MOSTLY(unsigned long, dr0_addr_mask);
> +DEFINE_PER_CPU_READ_MOSTLY(unsigned long, dr1_addr_mask);
> +DEFINE_PER_CPU_READ_MOSTLY(unsigned long, dr2_addr_mask);
> +DEFINE_PER_CPU_READ_MOSTLY(unsigned long, dr3_addr_mask);
> +
>  void set_dr_addr_mask(unsigned long mask, int dr)
>  {
>  	if (!boot_cpu_has(X86_FEATURE_BPEXT))
> @@ -1166,17 +1171,44 @@ void set_dr_addr_mask(unsigned long mask, int dr)
>  	switch (dr) {
>  	case 0:
>  		wrmsr(MSR_F16H_DR0_ADDR_MASK, mask, 0);

LOL, I'd love to hear how MSR_F16H_DR0_ADDR_MASK ended up with a completely
different MSR index.

> +		per_cpu(dr0_addr_mask, smp_processor_id()) = mask;

Use an array to avoid the copy+paste?  And if you're going to add a cache, might
as well use it to avoid unnecessary writes.

>  		break;
>  	case 1:
