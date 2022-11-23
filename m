Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD7E635696
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiKWJdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbiKWJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E7E07
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669195872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0tP8BFuS7YQvcxcgs/n+rozp/L98Njww9kvIfR3QxA=;
        b=SdJZGyWxyTk2O987cqxfETxs/XyMtPppfjlERxhuu3ttWz+4hjFaf0yK+i+obuwdD+EeZS
        82Y3/7bFEM99vtDnD6V85hnMUMTLmGZaE0q44nnt7vYc/bhWaxx8AJK+5sCZfV88b0MuAn
        yCcS0+hBIRXYli/gkCRW8GoshJx8ao4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-hUTEx3QDOQGHIuguOKGPDg-1; Wed, 23 Nov 2022 04:31:11 -0500
X-MC-Unique: hUTEx3QDOQGHIuguOKGPDg-1
Received: by mail-wm1-f69.google.com with SMTP id m17-20020a05600c3b1100b003cf9cc47da5so9363211wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:31:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0tP8BFuS7YQvcxcgs/n+rozp/L98Njww9kvIfR3QxA=;
        b=URPWq46CctjTrimbDVT8cRC/HRR1GJR1GsRljaCzLn6VjFmXvna3XhALCWftGlhuW/
         RvoixzL+RqMB3jteSjXxHRRIrd6c2/7eQaWnT/ZvPKBEkojAgi9GM0QkzB9oiut0aR7j
         3obq72SeDtuI9FEJ4oyhc5fMxSDvu1GL2GLnn0O3UEks7Y4kA6K8n63Dq1xrv8XF3A1R
         1FUl+1/Zz+cHdngy4txlwvq+il+F9JDFfO7F5DGyZiR2sITiJ618jY8qZjni8fa1ap3d
         qrSoyX6XZ7Twidk7c3bwAsGIWPduWCoxlx5oh9aBGMgTlnXydYOiuosUfyKZauqSEx61
         YNOQ==
X-Gm-Message-State: ANoB5plVqKQIGNdZpcCzzfqRai7NAfqih/yhzKsQIwsLL8YbKDw0s4ZW
        hC2jaOWfjmeJF0UPx6Vgedkx7beYKgzygaTjTVjVnN65qeXkxe2o8qYZez0ncaMktS7O1cqmySg
        yUt4Xwp7epemRUvefwyCPn6ht
X-Received: by 2002:a5d:55c3:0:b0:236:c12b:6e29 with SMTP id i3-20020a5d55c3000000b00236c12b6e29mr16298576wrw.98.1669195870201;
        Wed, 23 Nov 2022 01:31:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5+n2f1R+lYaBlcXGLnnpXMwiiVUCt2fKTNKjwBUSh8bwjNoz60jwCXi9TJPFNrrSxeCO+2NQ==
X-Received: by 2002:a5d:55c3:0:b0:236:c12b:6e29 with SMTP id i3-20020a5d55c3000000b00236c12b6e29mr16298540wrw.98.1669195869803;
        Wed, 23 Nov 2022 01:31:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c44d300b003c6b70a4d69sm1474406wmo.42.2022.11.23.01.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 01:31:09 -0800 (PST)
Message-ID: <33cfb5ea-1253-430a-0ed9-a84174bc6fdd@redhat.com>
Date:   Wed, 23 Nov 2022 10:31:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] mm: introduce arch_has_hw_nonleaf_pmd_young()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Yu Zhao <yuzhao@google.com>
References: <20221123064510.16225-1-jgross@suse.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221123064510.16225-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.22 07:45, Juergen Gross wrote:
> When running as a Xen PV guests commit eed9a328aa1a ("mm: x86: add
> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG") can cause a protection violation
> in pmdp_test_and_clear_young():
> 
>   BUG: unable to handle page fault for address: ffff8880083374d0
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0003) - permissions violation
>   PGD 3026067 P4D 3026067 PUD 3027067 PMD 7fee5067 PTE 8010000008337065
>   Oops: 0003 [#1] PREEMPT SMP NOPTI
>   CPU: 7 PID: 158 Comm: kswapd0 Not tainted 6.1.0-rc5-20221118-doflr+ #1
>   RIP: e030:pmdp_test_and_clear_young+0x25/0x40
> 
> This happens because the Xen hypervisor can't emulate direct writes to
> page table entries other than PTEs.
> 
> This can easily be fixed by introducing arch_has_hw_nonleaf_pmd_young()
> similar to arch_has_hw_pte_young() and test that instead of
> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG.
> 
> Fixes: eed9a328aa1a ("mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG")
> Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
> ---
> V2:
> - correct function name in commit message to match patch
> ---
>   arch/x86/include/asm/pgtable.h |  8 ++++++++
>   include/linux/pgtable.h        | 11 +++++++++++
>   mm/vmscan.c                    | 10 +++++-----
>   3 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 5059799bebe3..c567a6ed17ce 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1438,6 +1438,14 @@ static inline bool arch_has_hw_pte_young(void)
>   	return true;
>   }
>   
> +#ifdef CONFIG_XEN_PV
> +#define arch_has_hw_nonleaf_pmd_young arch_has_hw_nonleaf_pmd_young
> +static inline bool arch_has_hw_nonleaf_pmd_young(void)
> +{
> +	return !cpu_feature_enabled(X86_FEATURE_XENPV);
> +}
> +#endif
> +
>   #ifdef CONFIG_PAGE_TABLE_CHECK
>   static inline bool pte_user_accessible_page(pte_t pte)
>   {
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index a108b60a6962..58fc7e2d9575 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -260,6 +260,17 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>   #endif
>   
> +#ifndef arch_has_hw_nonleaf_pmd_young
> +/*
> + * Return whether the accessed bit in non-leaf PMD entries is supported on the
> + * local CPU.
> + */
> +static inline bool arch_has_hw_nonleaf_pmd_young(void)
> +{
> +	return IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG);
> +}
> +#endif
> +
>   #ifndef arch_has_hw_pte_young
>   /*
>    * Return whether the accessed bit is supported on the local CPU.
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 04d8b88e5216..a04ac3b18326 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3975,7 +3975,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long next, struct vm_area
>   			goto next;
>   
>   		if (!pmd_trans_huge(pmd[i])) {
> -			if (IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG) &&
> +			if (arch_has_hw_nonleaf_pmd_young() &&
>   			    get_cap(LRU_GEN_NONLEAF_YOUNG))
>   				pmdp_test_and_clear_young(vma, addr, pmd + i);
>   			goto next;
> @@ -4073,14 +4073,14 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
>   #endif
>   		walk->mm_stats[MM_NONLEAF_TOTAL]++;
>   
> -#ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
> -		if (get_cap(LRU_GEN_NONLEAF_YOUNG)) {
> +		if (arch_has_hw_nonleaf_pmd_young() &&
> +		    get_cap(LRU_GEN_NONLEAF_YOUNG)) {
>   			if (!pmd_young(val))
>   				continue;
>   
>   			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &pos);
>   		}
> -#endif
> +
>   		if (!walk->force_scan && !test_bloom_filter(walk->lruvec, walk->max_seq, pmd + i))
>   			continue;
>   
> @@ -5354,7 +5354,7 @@ static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *attr, c
>   	if (arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))
>   		caps |= BIT(LRU_GEN_MM_WALK);
>   
> -	if (IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG) && get_cap(LRU_GEN_NONLEAF_YOUNG))
> +	if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG))
>   		caps |= BIT(LRU_GEN_NONLEAF_YOUNG);
>   
>   	return snprintf(buf, PAGE_SIZE, "0x%04x\n", caps);

Acked-by: David Hildenbrand <david@redhat.com> # core changes

-- 
Thanks,

David / dhildenb

