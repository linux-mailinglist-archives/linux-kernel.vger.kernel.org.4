Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C615EFD85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiI2TA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiI2TAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F356E3CBC0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664478015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+3aJrIpSEB7VAOHzf/GVjSen+CP0rNaukCFkC+ZVZc=;
        b=Chhd10vT0cUk5b/6nBYdGB6s0/QSTVzjkuqCXMPfDPNPi7LS8oSvzdJBYKuvwZdLA3vLI6
        XlH/35ukVoz0obmN0/SYxJMcF8sIdb+fClNpuK+K+qovEP9yQ9GlCFLQ7X4SgkTo+oM3/f
        ZRp6VWoMx/yoIBnIBZ49/G+Q2xYwT0Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-ZIcJO-9xMFONyxWElb99Kw-1; Thu, 29 Sep 2022 15:00:13 -0400
X-MC-Unique: ZIcJO-9xMFONyxWElb99Kw-1
Received: by mail-wr1-f72.google.com with SMTP id i1-20020adfa501000000b0022cd1e1137bso841968wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=J+3aJrIpSEB7VAOHzf/GVjSen+CP0rNaukCFkC+ZVZc=;
        b=kjd68oqZ63d03vKJRU51iRrtMs7zwzQ28/cX39hDQyjwvZyCLes12jbENiKWYJdzMG
         1z5mpVjZZL69BsoiqL7VZ1tN4cEtvCvusCm8cXoqRrMp2gO1n87rtyr9wWO2+xpU0dVR
         vtJF8jedOhjZHezgReZtrnNsFr4BBajIqkW3zwawrg6ULmkGcooaYtxr3yFe35KFqLQu
         C+tYU1T4OyHZj24sU0Qcjh6h2/GeyN8UKu1hn999ZRcIsJrxPkrmDhqwULrw26HbP8sQ
         o5eESzpNVB1+qlKTZa5bk4A3RhPDKuskw17/akjcRc5H79SiUR8laHx/dJWKVhVbJ7Qf
         2Bfw==
X-Gm-Message-State: ACrzQf252Krv4X6THR7GmtbxvPkuowtgI52jUUZvuT2GS/4WZu76WinT
        sMoiNtu0PCoD+BrTZP3S8KBbWM0DTXzpXPcCM4MRRk5PHucsBSvEdJKdbEdQ4Yk+pEvVjmiraIm
        BHBhT3P/SJWn35ONGshyS97T9
X-Received: by 2002:adf:e192:0:b0:228:d066:a844 with SMTP id az18-20020adfe192000000b00228d066a844mr3695783wrb.54.1664478007865;
        Thu, 29 Sep 2022 12:00:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6i5KDsEdBe+Zglk/0fi94Adp4mMYTsyEF+rUs38HniJtSG+pStzCpqZi17H96xn0UGfpQOOQ==
X-Received: by 2002:adf:e192:0:b0:228:d066:a844 with SMTP id az18-20020adfe192000000b00228d066a844mr3695762wrb.54.1664478007499;
        Thu, 29 Sep 2022 12:00:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ce00:b5d:2b28:1eb5:9245? (p200300cbc705ce000b5d2b281eb59245.dip0.t-ipconnect.de. [2003:cb:c705:ce00:b5d:2b28:1eb5:9245])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d55cd000000b0022ae59d472esm73668wrw.112.2022.09.29.12.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 12:00:07 -0700 (PDT)
Message-ID: <3654e74b-8145-33bb-1eb7-fb5e2ffd2fba@redhat.com>
Date:   Thu, 29 Sep 2022 21:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
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
 <39c5ef18-1138-c879-2c6d-c013c79fa335@redhat.com>
 <YzXkDKr6plbJZgG4@strix-laptop>
 <834c258d-4c0e-1753-3608-8a7e28c14d07@redhat.com>
 <YzXqpN5bnG9HSGyI@strix-laptop>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YzXqpN5bnG9HSGyI@strix-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 20:57, Chih-En Lin wrote:
> On Thu, Sep 29, 2022 at 08:38:52PM +0200, David Hildenbrand wrote:
>> On 29.09.22 20:29, Chih-En Lin wrote:
>>> On Thu, Sep 29, 2022 at 07:24:31PM +0200, David Hildenbrand wrote:
>>>>>> IMHO, a relaxed form that focuses on only the memory consumption reduction
>>>>>> could *possibly* be accepted upstream if it's not too invasive or complex.
>>>>>> During fork(), we'd do exactly what we used to do to PTEs (increment
>>>>>> mapcount, refcount, trying to clear PageAnonExclusive, map the page R/O,
>>>>>> duplicate swap entries; all while holding the page table lock), however,
>>>>>> sharing the prepared page table with the child process using COW after we
>>>>>> prepared it.
>>>>>>
>>>>>> Any (most once we want to *optimize* rmap handling) modification attempts
>>>>>> require breaking COW -- copying the page table for the faulting process. But
>>>>>> at that point, the PTEs are already write-protected and properly accounted
>>>>>> (refcount/mapcount/PageAnonExclusive).
>>>>>>
>>>>>> Doing it that way might not require any questionable GUP hacks and swapping,
>>>>>> MMU notifiers etc. "might just work as expected" because the accounting
>>>>>> remains unchanged" -- we simply de-duplicate the page table itself we'd have
>>>>>> after fork and any modification attempts simply replace the mapped copy.
>>>>>
>>>>> Agree.
>>>>> However for GUP hacks, if we want to do the COW to page table, we still
>>>>> need the hacks in this patch (using the COW_PTE_OWN_EXCLUSIVE flag to
>>>>> check whether the PTE table is available or not before we do the COW to
>>>>> the table). Otherwise, it will be more complicated since it might need
>>>>> to handle situations like while preparing the COW work, it just figuring
>>>>> out that it needs to duplicate the whole table and roll back (recover
>>>>> the state and copy it to new table). Hopefully, I'm not wrong here.
>>>>
>>>> The nice thing is that GUP itself *usually* doesn't modify page tables. One
>>>> corner case is follow_pfn_pte(). All other modifications should happen in
>>>> the actual fault handler that has to deal with such kind of unsharing either
>>>> way when modifying the PTE.
>>>>
>>>> If the pages are already in a COW-ed pagetable in the desired "shared" state
>>>> (e.g., PageAnonExclusive cleared on an anonymous page), R/O pinning of such
>>>> pages will just work as expected and we shouldn't be surprised by another
>>>> set of GUP+COW CVEs.
>>>>
>>>> We'd really only deduplicate the page table and not play other tricks with
>>>> the actual page table content that differ from the existing way of handling
>>>> fork().
>>>>
>>>> I don't immediately see why we need COW_PTE_OWN_EXCLUSIVE in GUP code when
>>>> not modifying the page table. I think we only need "we have to unshare this
>>>> page table now" in follow_pfn_pte() and inside the fault handling when GUP
>>>> triggers a fault.
>>>>
>>>> I hope my assumption is correct, or am I missing something?
>>>>
>>>
>>> My consideration is when we pinned the page and did the COW to make the
>>> page table be shared. It might not allow mapping the pinned page to R/O)
>>> into both processes.
>>>
>>> So, if the fork is working on the shared state, it needs to recover the
>>> table and copy to a new one since that pinned page will need to copy
>>> immediately. We can hold the shared state after occurring such a
>>> situation. So we still need some trick to let the fork() know which page
>>> table already has the pinned page (or such page won't let us share)
>>> before going to duplicate.
>>>
>>> Am I wrong here?
>>
>> I think you might be overthinking this. Let's keep it simple:
>>
>> 1) Handle pinned anon pages just as I described below, falling back to the
>> "slow" path of page table copying.
>>
>> 2) Once we passed that stage, you can be sure that the COW-ed page table
>> cannot have actually pinned anon pages. All anon pages in such a page table
>> have PageAnonExclusive cleared and are "maybe shared". GUP cannot succeed in
>> pinning these pages anymore, because it will only pin exclusive anon pages!
>>
>> 3) If anybody wants to take a R/O pin on a shared anon page that is mapped
>> into a COW-ed page table, we trigger a fault with FAULT_FLAG_UNSHARE instead
>> of pinning the page. This has to break COW on the page table and properly
>> map an exclusive anon page into it, breaking COW.
>>
>> Do you see a problem with that?
>>
>>>
>>> After that, since we handled the accounting in fork(), we don't need
>>> ownership (pmd_t pointer) anymore. We have to find another way to mark
>>> the table to be exclusive. (Right now, COW_PTE_OWNER_EXCLUSIVE flag is
>>> stored at that space.)
>>>
>>>>>
>>>>>> But devil is in the detail (page table lock, TLB flushing).
>>>>>
>>>>> Sure, it might be an overhead in the page fault and needs to be handled
>>>>> carefully. ;)
>>>>>
>>>>>> "will make fork() even have more overhead" is not a good excuse for such
>>>>>> complexity/hacks -- sure, it will make your benchmark results look better in
>>>>>> comparison ;)
>>>>>
>>>>> ;);)
>>>>> I think that, even if we do the accounting with the COW page table, it
>>>>> still has a little bit improve.
>>>>
>>>> :)
>>>>
>>>> My gut feeling is that this is true. While we have to do a pass over the
>>>> parent page table during fork and wrprotect all PTEs etc., we don't have to
>>>> duplicate the page table content and allocate/free memory for that.
>>>>
>>>> One interesting case is when we cannot share an anon page with the child
>>>> process because it maybe pinned -- and we have to copy it via
>>>> copy_present_page(). In that case, the page table between the parent and the
>>>> child would differ and we'd not be able to share the page table.
>>>
>>> That is what I want to say above.
>>> The case might happen in the middle of the shared page table progress.
>>> It might cost more overhead to recover it. Therefore, if GUP wants to
>>> pin the mapped page we can mark the PTE table first, so fork() won't
>>> waste time doing the work for sharing.
>>
>> Having pinned pages is a corner case for most apps. No need to worry about
>> optimizing this corner case for now.
>>
>> I see what you are trying to optimize, but I don't think this is needed in a
>> first version, and probably never is needed.
>>
>>
>> Any attempts to mark page tables in a certain way from GUP
>> (COW_PTE_OWNER_EXCLUSIVE) is problematic either way: GUP-fast
>> (get_user_pages_fast) can race with pretty much anything, even with
>> concurrent fork. I suspect your current code might be really racy in that
>> regard.
> 
> I see.
> Now, I know why optimizing that corner case is not worth it.
> Thank you for explaining that.

Falling back after already processing some PTEs requires some care, 
though. I guess it's not too hard to get it right -- it might be harder 
to get it "clean". But we can talk about that detail later.

-- 
Thanks,

David / dhildenb

