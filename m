Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095EC74ECF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjGKLjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKLjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8D6E0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689075496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4lShu3YnxaIDGPIf6B9AQrZukxDqB/6TKJ5gYxYgPk=;
        b=FKBgOJz5G8rNKce1toTQ3KXvWn6bx3BjbDrmBUzPCYlE0WQ8EDnOjUd6KKGpUJBZ0pWGJc
        a8w9oNzuDCjWBFNA7BaY+u7mOfMKDX1tCe/8C+SqinIa6VayVGd0lXXCMOqZ7Pu++LX5ma
        VNOuHkEJQnDpeTAMABZFd7jasSS6vxM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-s0NCZFsgP7SwypigCwacpg-1; Tue, 11 Jul 2023 07:38:15 -0400
X-MC-Unique: s0NCZFsgP7SwypigCwacpg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fb9364b320so5026618e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689075494; x=1691667494;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4lShu3YnxaIDGPIf6B9AQrZukxDqB/6TKJ5gYxYgPk=;
        b=E9BYt5K5Z6FSEduK3djpO/uXhnHQ1gyQk2hkyHZa4iyrvUwKQdvvzSNy1Y4yPFKbpz
         3phyeKk2oOw2ukjf1ao9I4KvPammIdrplULDgWNS+jxhWOS2Xd7nlhT+JZjQppO1zqQO
         plOeKlkl8E+4zkz9RnfadjX0eWEggpVCCn8eFVcBtwLc7fE/GZ+PyGV9JIAiIEls5V3i
         PpoqC2gokg5Kcp7gvPn6yfUshtysEQBQGemtT0UyECp1aTEV9J8e/yzA0vVtv91X/5pH
         IRuXFfuqvxavhyxGI+mzcRMigm11T5jYgJlhRD/y/ow3Vs0MfQJuCwTqxAmfv7c9wga2
         ReLA==
X-Gm-Message-State: ABy/qLa6oo3eY6a+TB/UK5KgTJrnnINHZAKccpkdqZ/VCOWT79wdkB0j
        w5v1POn3rflEHsV1IgtUsmWVx1hxmfAm231DP9WihupEfh/spP4M8yeDywliAWSngZP4YotxAO5
        lZQbiuAoCHYh0YN/UnpSRr+zYUBqT4Dwh
X-Received: by 2002:a05:6512:1090:b0:4fb:74d6:6154 with SMTP id j16-20020a056512109000b004fb74d66154mr15031498lfg.37.1689075493753;
        Tue, 11 Jul 2023 04:38:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFvn23Gm82Z4IkNxxc3WPf8KDGAl3B01MTlzaouEW8vRTGxyN1gEu32SmXt4gyRICSlTY0HUQ==
X-Received: by 2002:a05:6512:1090:b0:4fb:74d6:6154 with SMTP id j16-20020a056512109000b004fb74d66154mr15031482lfg.37.1689075493297;
        Tue, 11 Jul 2023 04:38:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:4000:13ad:ed64:37e6:115d? (p200300cbc745400013aded6437e6115d.dip0.t-ipconnect.de. [2003:cb:c745:4000:13ad:ed64:37e6:115d])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c211200b003fbbe41fd78sm2333643wml.10.2023.07.11.04.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 04:38:12 -0700 (PDT)
Message-ID: <700c13ee-cf4c-69bb-7477-4f959d022b0d@redhat.com>
Date:   Tue, 11 Jul 2023 13:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     linux-mm@kvack.org, x86@kernel.org, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, seanjc@google.com,
        pbonzini@redhat.com, dan.j.williams@intel.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        reinette.chatre@intel.com, len.brown@intel.com, ak@linux.intel.com,
        isaku.yamahata@intel.com, ying.huang@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, nik.borisov@suse.com,
        bagasdotme@gmail.com, sagis@google.com, imammedo@redhat.com
References: <cover.1687784645.git.kai.huang@intel.com>
 <999b47f30fbe2535c37a5e8d602c6c27ac6212dd.1687784645.git.kai.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v12 09/22] x86/virt/tdx: Use all system memory when
 initializing TDX module as TDX memory
In-Reply-To: <999b47f30fbe2535c37a5e8d602c6c27ac6212dd.1687784645.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



[...]

> +/* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
> +static LIST_HEAD(tdx_memlist);
> +
>   /*
>    * Wrapper of __seamcall() to convert SEAMCALL leaf function error code
>    * to kernel error code.  @seamcall_ret and @out contain the SEAMCALL
> @@ -204,6 +214,79 @@ static int tdx_get_sysinfo(struct tdsysinfo_struct *sysinfo,
>   	return 0;
>   }
>   
> +/*
> + * Add a memory region as a TDX memory block.  The caller must make sure
> + * all memory regions are added in address ascending order and don't
> + * overlap.
> + */
> +static int add_tdx_memblock(struct list_head *tmb_list, unsigned long start_pfn,
> +			    unsigned long end_pfn)
> +{
> +	struct tdx_memblock *tmb;
> +
> +	tmb = kmalloc(sizeof(*tmb), GFP_KERNEL);
> +	if (!tmb)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&tmb->list);
> +	tmb->start_pfn = start_pfn;
> +	tmb->end_pfn = end_pfn;
> +
> +	/* @tmb_list is protected by mem_hotplug_lock */

If the list is static and independent of memory hotplug, why does it 
have to be protected?

I assume because the memory notifier might currently trigger before 
building the list.

Not sure if that is the right approach. See below.

> +	list_add_tail(&tmb->list, tmb_list);
> +	return 0;
> +}
> +
> +static void free_tdx_memlist(struct list_head *tmb_list)
> +{
> +	/* @tmb_list is protected by mem_hotplug_lock */
> +	while (!list_empty(tmb_list)) {
> +		struct tdx_memblock *tmb = list_first_entry(tmb_list,
> +				struct tdx_memblock, list);
> +
> +		list_del(&tmb->list);
> +		kfree(tmb);
> +	}
> +}
> +
> +/*
> + * Ensure that all memblock memory regions are convertible to TDX
> + * memory.  Once this has been established, stash the memblock
> + * ranges off in a secondary structure because memblock is modified
> + * in memory hotplug while TDX memory regions are fixed.
> + */
> +static int build_tdx_memlist(struct list_head *tmb_list)
> +{
> +	unsigned long start_pfn, end_pfn;
> +	int i, ret;
> +
> +	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
> +		/*
> +		 * The first 1MB is not reported as TDX convertible memory.
> +		 * Although the first 1MB is always reserved and won't end up
> +		 * to the page allocator, it is still in memblock's memory
> +		 * regions.  Skip them manually to exclude them as TDX memory.
> +		 */
> +		start_pfn = max(start_pfn, PHYS_PFN(SZ_1M));
> +		if (start_pfn >= end_pfn)
> +			continue;
> +
> +		/*
> +		 * Add the memory regions as TDX memory.  The regions in
> +		 * memblock has already guaranteed they are in address
> +		 * ascending order and don't overlap.
> +		 */
> +		ret = add_tdx_memblock(tmb_list, start_pfn, end_pfn);
> +		if (ret)
> +			goto err;
> +	}

So at the time init_tdx_module() is called, you simply go over all 
memblocks.

But how can you be sure that they are TDX-capable?

While the memory notifier will deny onlining new memory blocks, 
add_memory() already happened and added a new memory block to the system 
(and to memblock). See add_memory_resource().

It might be cleaner to build the list once during module init (before 
any memory hotplug can happen and before we tear down memblock) and not 
require ARCH_KEEP_MEMBLOCK. Essentially, before registering the 
notifier. So the list is really static.

But maybe I am missing something.

> +
> +	return 0;
> +err:
> +	free_tdx_memlist(tmb_list);
> +	return ret;
> +}
> +
>   static int init_tdx_module(void)
>   {
>   	struct tdsysinfo_struct *sysinfo;
> @@ -230,10 +313,25 @@ static int init_tdx_module(void)
>   	if (ret)
>   		goto out;

[...]

>   
> +struct tdx_memblock {
> +	struct list_head list;
> +	unsigned long start_pfn;
> +	unsigned long end_pfn;
> +};

If it's never consumed by someone else, maybe keep it local to the c file?

> +
>   struct tdx_module_output;
>   u64 __seamcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>   	       struct tdx_module_output *out);

-- 
Cheers,

David / dhildenb

