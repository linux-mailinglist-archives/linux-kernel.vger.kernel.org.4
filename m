Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D668634200
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiKVQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiKVQ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:58:18 -0500
Received: from server.eikelenboom.it (server.eikelenboom.it [91.121.65.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9341F2C8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H6t2vr3/228MGqi5OTqaW5cnhOLcZTruHIsBGnxyGhY=; b=EGT6r8Tw0ldjoY/OA7z2dj++Jt
        RLwO+w+J0DbJBP2Yzy0PFGyCfdvFrhuvqbYOdxnNr3nWxOybp1czj1YTbXJVMRnIIoV6K1ihb7ReZ
        6Tltqdk7RErFvd0ZYKCMOtI4toGGXymprPJ6yXh8euSE+a7IRaZQd66zp/tU3VjsQwME=;
Received: from 131-195-250-62.ftth.glasoperator.nl ([62.250.195.131]:53692 helo=[172.16.1.50])
        by server.eikelenboom.it with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linux@eikelenboom.it>)
        id 1oxWbf-00033s-1p; Tue, 22 Nov 2022 17:58:47 +0100
Message-ID: <e059ef42-62c1-0f54-4b2d-722243efd66b@eikelenboom.it>
Date:   Tue, 22 Nov 2022 17:57:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] mm: introduce arch_has_hw_pmd_young()
Content-Language: nl-NL
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org
Cc:     yuzhao@google.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221121093245.4587-1-jgross@suse.com>
 <40c58b1b-9b90-ccd8-1387-362de236af2a@suse.com>
From:   Sander Eikelenboom <linux@eikelenboom.it>
In-Reply-To: <40c58b1b-9b90-ccd8-1387-362de236af2a@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 10:50, Juergen Gross wrote:
> On 21.11.22 10:32, Juergen Gross wrote:
>> When running as a Xen PV guests commit eed9a328aa1a ("mm: x86: add
>> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG") can cause a protection violation
>> in pmdp_test_and_clear_young():
>>
>>    BUG: unable to handle page fault for address: ffff8880083374d0
>>    #PF: supervisor write access in kernel mode
>>    #PF: error_code(0x0003) - permissions violation
>>    PGD 3026067 P4D 3026067 PUD 3027067 PMD 7fee5067 PTE 8010000008337065
>>    Oops: 0003 [#1] PREEMPT SMP NOPTI
>>    CPU: 7 PID: 158 Comm: kswapd0 Not tainted 6.1.0-rc5-20221118-doflr+ #1
>>    RIP: e030:pmdp_test_and_clear_young+0x25/0x40
>>
>> This happens because the Xen hypervisor can't emulate direct writes to
>> page table entries other than PTEs.
>>
>> This can easily be fixed by introducing arch_has_hw_pmd_young()
>> similar to arch_has_hw_pte_young() and test that instead of
>> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG.
> 
> I just spotted that I missed to update my commit message to match the
> patch:
> 
> s/arch_has_hw_pmd_young/arch_has_hw_nonleaf_pmd_young/
> 
> I'll wait with a resend in order to get some feedback first.
> 
> 
> Juergen

Hi Juergen,

Thanks for the patch, had it running overnight and did some kernel 
compiles. No crashes with this patch so far, so it seems to work for me.

--
Sander


>>
>> Fixes: eed9a328aa1a ("mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG")
>> Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>    arch/x86/include/asm/pgtable.h |  8 ++++++++
>>    include/linux/pgtable.h        | 11 +++++++++++
>>    mm/vmscan.c                    | 10 +++++-----
>>    3 files changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index 5059799bebe3..c567a6ed17ce 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1438,6 +1438,14 @@ static inline bool arch_has_hw_pte_young(void)
>>    	return true;
>>    }
>>    
>> +#ifdef CONFIG_XEN_PV
>> +#define arch_has_hw_nonleaf_pmd_young arch_has_hw_nonleaf_pmd_young
>> +static inline bool arch_has_hw_nonleaf_pmd_young(void)
>> +{
>> +	return !cpu_feature_enabled(X86_FEATURE_XENPV);
>> +}
>> +#endif
>> +
>>    #ifdef CONFIG_PAGE_TABLE_CHECK
>>    static inline bool pte_user_accessible_page(pte_t pte)
>>    {
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index a108b60a6962..58fc7e2d9575 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -260,6 +260,17 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
>>    #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>    #endif
>>    
>> +#ifndef arch_has_hw_nonleaf_pmd_young
>> +/*
>> + * Return whether the accessed bit in non-leaf PMD entries is supported on the
>> + * local CPU.
>> + */
>> +static inline bool arch_has_hw_nonleaf_pmd_young(void)
>> +{
>> +	return IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG);
>> +}
>> +#endif
>> +
>>    #ifndef arch_has_hw_pte_young
>>    /*
>>     * Return whether the accessed bit is supported on the local CPU.
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 04d8b88e5216..a04ac3b18326 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -3975,7 +3975,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long next, struct vm_area
>>    			goto next;
>>    
>>    		if (!pmd_trans_huge(pmd[i])) {
>> -			if (IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG) &&
>> +			if (arch_has_hw_nonleaf_pmd_young() &&
>>    			    get_cap(LRU_GEN_NONLEAF_YOUNG))
>>    				pmdp_test_and_clear_young(vma, addr, pmd + i);
>>    			goto next;
>> @@ -4073,14 +4073,14 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
>>    #endif
>>    		walk->mm_stats[MM_NONLEAF_TOTAL]++;
>>    
>> -#ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
>> -		if (get_cap(LRU_GEN_NONLEAF_YOUNG)) {
>> +		if (arch_has_hw_nonleaf_pmd_young() &&
>> +		    get_cap(LRU_GEN_NONLEAF_YOUNG)) {
>>    			if (!pmd_young(val))
>>    				continue;
>>    
>>    			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &pos);
>>    		}
>> -#endif
>> +
>>    		if (!walk->force_scan && !test_bloom_filter(walk->lruvec, walk->max_seq, pmd + i))
>>    			continue;
>>    
>> @@ -5354,7 +5354,7 @@ static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *attr, c
>>    	if (arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))
>>    		caps |= BIT(LRU_GEN_MM_WALK);
>>    
>> -	if (IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG) && get_cap(LRU_GEN_NONLEAF_YOUNG))
>> +	if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG))
>>    		caps |= BIT(LRU_GEN_NONLEAF_YOUNG);
>>    
>>    	return snprintf(buf, PAGE_SIZE, "0x%04x\n", caps);
> 

