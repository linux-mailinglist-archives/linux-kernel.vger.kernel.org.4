Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30039745A22
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjGCK2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:28:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5889FBE;
        Mon,  3 Jul 2023 03:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RdvSBzylMqzcgeZCbeq2y3LzSr6cTTZfwrxa9S1F0VI=; b=l1r8nJk/ekxSCVihjSWivo5+i8
        e9fu4b+qujtiOO1HcA00eg2WW2XD4aR9SsRCwszuEFh+NJUx9cpjiZOWVqhJ08TJEk3HnPAATKTSW
        XctUeu+cTQ4/5hb4aTCqSeQSLKvwWNIh+PqzWqs4PPjZ1wBVxd1LuuyEIYs2+08ZvxE1tMvYJHL0u
        jBKhkkCTuNZotMTh4xvdWLUHnvkvreZJmAIvLPzb47UvVuHuGTQWNa2GmZ7UM7QQkBETekTt2qqwM
        89TsDVd7OxqRPPiqrN23edONltxI3jFNWEsAOn7rp6k5Q62w50xdSr++vS8kMsRbyQnRaYbVdh730
        DAmIroQQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGGn2-00A3td-36;
        Mon, 03 Jul 2023 10:28:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A36630023F;
        Mon,  3 Jul 2023 12:28:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35189202A2A17; Mon,  3 Jul 2023 12:28:15 +0200 (CEST)
Date:   Mon, 3 Jul 2023 12:28:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v4 1/4] x86/speculation: Add __update_spec_ctrl() helper
Message-ID: <20230703102815.GD4253@hirez.programming.kicks-ass.net>
References: <20230628022554.1638318-1-longman@redhat.com>
 <20230628022554.1638318-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628022554.1638318-2-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:25:51PM -0400, Waiman Long wrote:
> Add a new __update_spec_ctrl() helper which is a variant of
> update_spec_ctrl() that can be used in a noinstr function.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/x86/include/asm/nospec-branch.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 55388c9f7601..1d363fcea207 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -9,7 +9,7 @@
>  
>  #include <asm/alternative.h>
>  #include <asm/cpufeatures.h>
> -#include <asm/msr-index.h>
> +#include <asm/msr.h>
>  #include <asm/unwind_hints.h>
>  #include <asm/percpu.h>
>  #include <asm/current.h>
> @@ -488,6 +488,15 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
>  extern void update_spec_ctrl_cond(u64 val);
>  extern u64 spec_ctrl_current(void);
>  
> +/*
> + * This can be used in noinstr function.
> + */
> +static __always_inline void __update_spec_ctrl(u64 val)
> +{
> +	__this_cpu_write(x86_spec_ctrl_current, val);
> +	native_wrmsrl(MSR_IA32_SPEC_CTRL, val);
> +}

Should we also use this to implement update_spec_ctrl() ?
