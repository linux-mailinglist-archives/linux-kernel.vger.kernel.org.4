Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB395EFBED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiI2RZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbiI2RYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9119ABCAF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664472277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMdm/8lzO3SbFCWw6w3QJ0nOlwN2WhTe2Z9N6/LMI7Y=;
        b=htA6nai193iKv47Knprx1RpHWT9XpaaYdTV7YIUd32VTGcWNZeEvkIlXhgXR4kZVrAVuOA
        jBhpZB4q5obWJF0vJs0iAi0bajhVu7qSB5yNkv0y6X3W/l20NlgWsgNLzZ2MXhJjBFvkSF
        3712bm7I/JmbhCMExUCqXQSaANNSyl4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-PhdMrL3TMSycbK1dhvE4wg-1; Thu, 29 Sep 2022 13:24:35 -0400
X-MC-Unique: PhdMrL3TMSycbK1dhvE4wg-1
Received: by mail-wm1-f71.google.com with SMTP id c3-20020a7bc843000000b003b486fc6a40so672522wml.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=RMdm/8lzO3SbFCWw6w3QJ0nOlwN2WhTe2Z9N6/LMI7Y=;
        b=XZMSyN0sjLuMG1ge+XRMbKmm9k3TSmXfjirQULqL2kfow2GSqw2bQ3FtcEmTqaBwnM
         7BEHCWqwxbSptCl9ZMSL9hcof/+p/imhiRm7eY2ff7xjR+rpjBgF+OYr9x9kpL2sJOVC
         Sgis55nkR76mBrPoydKQkCvd4zkXYGt/88o93Ng5e8wEhypyvRnIRHUsPPMH8MYNv711
         5ni0lvG/Kd5qo6wXYsdCA37OP0BPisDUKwu54nP5CxhRY4+nxZMwjUgML5yT6OhzjUZg
         AzTkbN5EPdk4GM8uEOJ5BVAg3YXr61rMZAW0CSWsBKUcSqqTzPf3PRIoakisK0nsybd2
         FWTA==
X-Gm-Message-State: ACrzQf2dx2mwFvDJ0MoAhLCzVKL539AunOlHRVepd6+FmK1CZJIfmi6d
        ONRJnBiuNCtxtFnqI01E2YQQJfN+jw6/pFkGVNdwhYCqAnovrCd87B5Gu951vI1POUvcQIFvPIu
        cN9yZHHbLCRcwbY8RfLNH/13Q
X-Received: by 2002:a5d:5b19:0:b0:22b:237c:3de8 with SMTP id bx25-20020a5d5b19000000b0022b237c3de8mr3155255wrb.285.1664472274093;
        Thu, 29 Sep 2022 10:24:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7jg3zCwylEVADfXVvACXXTeWwKVjgvqqVLjnWuAf0dqqxpK1iV3Hyk/9m1gxNGAUKxdoCEEw==
X-Received: by 2002:a5d:5b19:0:b0:22b:237c:3de8 with SMTP id bx25-20020a5d5b19000000b0022b237c3de8mr3155232wrb.285.1664472273748;
        Thu, 29 Sep 2022 10:24:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ce00:b5d:2b28:1eb5:9245? (p200300cbc705ce000b5d2b281eb59245.dip0.t-ipconnect.de. [2003:cb:c705:ce00:b5d:2b28:1eb5:9245])
        by smtp.gmail.com with ESMTPSA id y15-20020adff14f000000b00224f7c1328dsm7058186wro.67.2022.09.29.10.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 10:24:33 -0700 (PDT)
Message-ID: <39c5ef18-1138-c879-2c6d-c013c79fa335@redhat.com>
Date:   Thu, 29 Sep 2022 19:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Chih-En Lin <shiyn.lin@gmail.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
 <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
 <YzNUwxU44mq+KnCm@strix-laptop>
 <c12f848d-cb54-2998-8650-2c2a5707932d@redhat.com>
 <YzWf7V5qzMjzMAk4@strix-laptop>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
In-Reply-To: <YzWf7V5qzMjzMAk4@strix-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> IMHO, a relaxed form that focuses on only the memory consumption reduction
>> could *possibly* be accepted upstream if it's not too invasive or complex.
>> During fork(), we'd do exactly what we used to do to PTEs (increment
>> mapcount, refcount, trying to clear PageAnonExclusive, map the page R/O,
>> duplicate swap entries; all while holding the page table lock), however,
>> sharing the prepared page table with the child process using COW after we
>> prepared it.
>>
>> Any (most once we want to *optimize* rmap handling) modification attempts
>> require breaking COW -- copying the page table for the faulting process. But
>> at that point, the PTEs are already write-protected and properly accounted
>> (refcount/mapcount/PageAnonExclusive).
>>
>> Doing it that way might not require any questionable GUP hacks and swapping,
>> MMU notifiers etc. "might just work as expected" because the accounting
>> remains unchanged" -- we simply de-duplicate the page table itself we'd have
>> after fork and any modification attempts simply replace the mapped copy.
> 
> Agree.
> However for GUP hacks, if we want to do the COW to page table, we still
> need the hacks in this patch (using the COW_PTE_OWN_EXCLUSIVE flag to
> check whether the PTE table is available or not before we do the COW to
> the table). Otherwise, it will be more complicated since it might need
> to handle situations like while preparing the COW work, it just figuring
> out that it needs to duplicate the whole table and roll back (recover
> the state and copy it to new table). Hopefully, I'm not wrong here.

The nice thing is that GUP itself *usually* doesn't modify page tables. 
One corner case is follow_pfn_pte(). All other modifications should 
happen in the actual fault handler that has to deal with such kind of 
unsharing either way when modifying the PTE.

If the pages are already in a COW-ed pagetable in the desired "shared" 
state (e.g., PageAnonExclusive cleared on an anonymous page), R/O 
pinning of such pages will just work as expected and we shouldn't be 
surprised by another set of GUP+COW CVEs.

We'd really only deduplicate the page table and not play other tricks 
with the actual page table content that differ from the existing way of 
handling fork().

I don't immediately see why we need COW_PTE_OWN_EXCLUSIVE in GUP code 
when not modifying the page table. I think we only need "we have to 
unshare this page table now" in follow_pfn_pte() and inside the fault 
handling when GUP triggers a fault.

I hope my assumption is correct, or am I missing something?

> 
>> But devil is in the detail (page table lock, TLB flushing).
> 
> Sure, it might be an overhead in the page fault and needs to be handled
> carefully. ;)
> 
>> "will make fork() even have more overhead" is not a good excuse for such
>> complexity/hacks -- sure, it will make your benchmark results look better in
>> comparison ;)
> 
> ;);)
> I think that, even if we do the accounting with the COW page table, it
> still has a little bit improve.

:)

My gut feeling is that this is true. While we have to do a pass over the 
parent page table during fork and wrprotect all PTEs etc., we don't have 
to duplicate the page table content and allocate/free memory for that.

One interesting case is when we cannot share an anon page with the child 
process because it maybe pinned -- and we have to copy it via 
copy_present_page(). In that case, the page table between the parent and 
the child would differ and we'd not be able to share the page table.

That case could be caught in copy_pte_range(): in case we'd have to 
allocate a page via page_copy_prealloc(), we'd have to fall back to the 
ordinary "separate page table for the child" way of doing things.

But that looks doable to me.

-- 
Thanks,

David / dhildenb

