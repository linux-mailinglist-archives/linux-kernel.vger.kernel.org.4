Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610976222DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiKIDyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiKIDyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:54:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06101743D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:54:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 224846187D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D6DC433D6;
        Wed,  9 Nov 2022 03:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667966088;
        bh=S8pWdgOR4rgQDJEViUkztQ4JOnFYoyoZ1YvkqP2E6ck=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XC1176GMX+onGjvVsBZjQ48A0CtsihKje05ARr/k6lkUTDWKrwUzXRgyoXjfKMlwO
         TTz8d0+y5B5YkjmJiFCCD4geYrQLanHqBzKJzu7Znm5z1NUmGTwVylqwx4tSzETZpr
         H86rqo703xqz9lXQRxej1copWFrkhMHcPrqG0Bc/koLYK0DfK2X76zAQMbSGabiM4L
         QGKjn8Gm8WeCaSdgXX/5QkO4Ada5JawGsDZ+eY4ku1VNThgJdRzWz7t53Jx4TMo+jB
         YQ/4D9BXEHQJ+RV75f9fB38Z/v0QhuwQhk9r2o9Q7OgqOsxKR5QwqQUiN0/EEhbf7T
         I0WqK+hc+0yYQ==
Message-ID: <6782d309-5e4b-580c-fbbb-4388bda69bf3@kernel.org>
Date:   Tue, 8 Nov 2022 19:54:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCHv11.1 04/16] x86/mm: Handle LAM on context switch
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@intel.com
Cc:     ak@linux.intel.com, andreyknvl@gmail.com, ashok.raj@intel.com,
        bharata@amd.com, dave.hansen@linux.intel.com, dvyukov@google.com,
        glider@google.com, hjl.tools@gmail.com,
        jacob.jun.pan@linux.intel.com, kcc@google.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, peterz@infradead.org,
        rick.p.edgecombe@intel.com, ryabinin.a.a@gmail.com,
        tarasmadan@google.com, x86@kernel.org
References: <b778fcdd-5c20-e897-9d17-1a884172a826@intel.com>
 <20221107213558.27807-1-kirill.shutemov@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20221107213558.27807-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 13:35, Kirill A. Shutemov wrote:
> Linear Address Masking mode for userspace pointers encoded in CR3 bits.
> The mode is selected per-process and stored in mm_context_t.
> 
> switch_mm_irqs_off() now respects selected LAM mode and constructs CR3
> accordingly.
> 
> The active LAM mode gets recorded in the tlb_state.
> 

> +static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
> +{
> +	return mm->context.lam_cr3_mask;

READ_ONCE -- otherwise this has a data race and might generate sanitizer 
complaints.

> +}

> @@ -491,6 +496,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>   {
>   	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
>   	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> +	unsigned long prev_lam = tlbstate_lam_cr3_mask();
> +	unsigned long new_lam = mm_lam_cr3_mask(next);

So I'm reading this again after drinking a cup of coffee.  new_lam is 
next's LAM mask according to mm_struct (and thus can change 
asynchronously due to a remote CPU).  prev_lam is based on tlbstate and 
can't change asynchronously, at least not with IRQs off.


>   	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
>   	unsigned cpu = smp_processor_id();
>   	u64 next_tlb_gen;
> @@ -520,7 +527,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>   	 * isn't free.
>   	 */
>   #ifdef CONFIG_DEBUG_VM
> -	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid))) {
> +	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid, prev_lam))) {

So is the only purpose of tlbstate_lam_cr3_mask() to enable this warning 
to work?

>   		/*
>   		 * If we were to BUG here, we'd be very likely to kill
>   		 * the system so hard that we don't see the call trace.
> @@ -552,9 +559,15 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>   	 * instruction.
>   	 */
>   	if (real_prev == next) {
> +		/* Not actually switching mm's */
>   		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
>   			   next->context.ctx_id);
>   
> +		/*
> +		 * If this races with another thread that enables lam, 'new_lam'
> +		 * might not match 'prev_lam'.
> +		 */
> +

Indeed.

>   		/*
>   		 * Even in lazy TLB mode, the CPU should stay set in the
>   		 * mm_cpumask. The TLB shootdown code can figure out from
> @@ -622,15 +635,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>   		barrier();
>   	}

> @@ -691,6 +705,10 @@ void initialize_tlbstate_and_flush(void)
>   	/* Assert that CR3 already references the right mm. */
>   	WARN_ON((cr3 & CR3_ADDR_MASK) != __pa(mm->pgd));
>   
> +	/* LAM expected to be disabled in CR3 and init_mm */
> +	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
> +	WARN_ON(mm_lam_cr3_mask(&init_mm));
> +

I think the callers all have init_mm selected, but the rest of this 
function is not really written with this assumption.  (But it does force 
ASID 0, which is at least a bizarre thing to do for non-init-mm.)

What's the purpose of this warning?  I'm okay with keeping it, but maybe 
also add a warning that fires if mm != &init_mm.

