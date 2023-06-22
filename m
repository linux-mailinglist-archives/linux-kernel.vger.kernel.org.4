Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0462F739539
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjFVCG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFVCGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:06:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55455211F;
        Wed, 21 Jun 2023 19:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9Q+RVMxQTnESFWq3dEuCfX1ILCA2ks3wZlSRkHE8toQ=; b=cMxr7XNoPaiJJVIfeeYi7V+9mM
        Mcfkz00jliVgU9VtZ3zSjatxeu5qxG6fkv4ORn3P8I6yBqgAGo6sK6rQSvg2VWw18rcDtXEW+dh8m
        1EpbpqKb9IEAV1H8h/ryX8IS3kRXKCD1WqxZ7TzfJtaF3arGqwNskSb6J3oN3xhIZDJvgfr8AXY3f
        Zp+TqdvqJgI5/b9yUptfSlsLXO2cauPK+jj0vGSkZVo1ZLkoecwCXf1eOBCJieQu0Rw7PI//1/ZKP
        I03lcVAZnHqJugrYJDc9o4T/fk+9A67jM5AjeQt0P+msn1UQ52TpEiVqltUmYpcG8IZrUtuepsE9w
        6zmxmPdQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qC9hf-00GVVa-2b;
        Thu, 22 Jun 2023 02:05:43 +0000
Message-ID: <8a1ba9cd-426f-dd59-bb2a-67a0f1af6de8@infradead.org>
Date:   Wed, 21 Jun 2023 19:05:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/3] x86/idle: Disable IBRS when cpu is offline
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Robin Jarry <rjarry@redhat.com>,
        Joe Mario <jmario@redhat.com>
References: <20230622003603.1188364-1-longman@redhat.com>
 <20230622003603.1188364-2-longman@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230622003603.1188364-2-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 17:36, Waiman Long wrote:
> Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
> disables IBRS when the CPU enters long idle. However, when a CPU
> becomes offline, the IBRS bit is still set when X86_FEATURE_KERNEL_IBRS
> is enabled. That will impact the performance of a sibling CPU. Mitigate
> this performance impact by clearing all the mitigation bits in SPEC_CTRL
> MSR when offline. When the CPU is online again, it will be re-initialized
> and so restoring the SPEC_CTRL value isn't needed.
> 
> Add a comment to say that native_play_dead() is a __noreturn function,
> but it can't be marked as such to avoid confusion about the missing
> MSR restoration code.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/x86/kernel/smpboot.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 352f0ce1ece4..7bc33885518c 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -84,6 +84,7 @@
>  #include <asm/hw_irq.h>
>  #include <asm/stackprotector.h>
>  #include <asm/sev.h>
> +#include <asm/nospec-branch.h>
>  
>  /* representing HT siblings of each logical CPU */
>  DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
> @@ -1836,8 +1837,17 @@ void __noreturn hlt_play_dead(void)
>  	}
>  }
>  
> +/*
> + * naitve_play_dead() is essentially a __noreturn function, but it can't

typo: native_play_dead()

> + * be marked as such as the compiler may complain about it.
> + */
>  void native_play_dead(void)
>  {
> +	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
> +		this_cpu_write(x86_spec_ctrl_current, 0);
> +		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> +	}
> +
>  	play_dead_common();
>  	tboot_shutdown(TB_SHUTDOWN_WFS);
>  

-- 
~Randy
