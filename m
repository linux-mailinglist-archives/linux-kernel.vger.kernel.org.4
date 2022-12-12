Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E6264A72B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiLLSfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiLLSfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:35:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B7BE4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670870064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pDGctlA6FBkgWMLkITLfZfzWU3+Yey50wL/wNklqNXc=;
        b=P/G48JUgb9i7OKQw3R9RxpfdgGnAnCI3U9jVkKqQXIIl8Nl5X3jfZO/5iIiWTnIKyx5fkz
        IWZrG4nLEtWw7GD0xvjcTrtoAnvrvL9n7Xl1uuV1NJ4b89ipPBju2fWrnc6Qpf2GHhpbPN
        GIuld4ovNNfblpe+tdY0P9DvLfkyQWA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-lrd-xUnLNh2rl2yIzC2iTw-1; Mon, 12 Dec 2022 13:34:23 -0500
X-MC-Unique: lrd-xUnLNh2rl2yIzC2iTw-1
Received: by mail-wm1-f69.google.com with SMTP id c126-20020a1c3584000000b003cfffcf7c1aso4544544wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDGctlA6FBkgWMLkITLfZfzWU3+Yey50wL/wNklqNXc=;
        b=fEc7BdVjvQk4WPzO2dnMJr3HKR7+MQtJpbxFaJl+1/t125lgm+MSIm7ztW/NLcS8NI
         qZIsV2zqsF4jYr2OXANsYyVwbm8JIoL1fCKwMzsDF7ihYMd0nM2t2iNf71+CFk2AQgm2
         p7Nz2L45T5JUeJIwqjnDv1usfQcmlJ1TkhcAqAAjv7XF6Zk7SchnNM6vCADiSl0IZRP7
         HqkYa+7VqgnNEZsZIo+gT8amNNuAx9r/TvzFfZtSINtVg7Qu+grGiyxldCrSTeTl0nOm
         HP4CIlmoFZabYuhxlgmmY3XlGoowknWuTS47VL6da0paeIDWjTkAX4Aw1JB5p8Wrd1M3
         BFUg==
X-Gm-Message-State: ANoB5pnJtVS2PqIh7VTv44+BGSxtMSO+KiAJMokF7N0siZHs9+DsG6Fb
        Vo01SHa0CuNXVFxQTrD1wgnT8CSb1B7iwZGFXioL8uChkKovqgAAubtbgIRpD2MMUeVo6lir0ud
        ug87v+2txZm60vsOUSiOdjdT1
X-Received: by 2002:a05:600c:3483:b0:3cf:67ad:6284 with SMTP id a3-20020a05600c348300b003cf67ad6284mr12901724wmq.4.1670870062025;
        Mon, 12 Dec 2022 10:34:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6u7mTJ2un+LUnIKCNOp5TZN9mo/tby5UEpyKHgWfr8EgIQ8M1vGadcuirInMTrfooLFEDn3w==
X-Received: by 2002:a05:600c:3483:b0:3cf:67ad:6284 with SMTP id a3-20020a05600c348300b003cf67ad6284mr12901713wmq.4.1670870061760;
        Mon, 12 Dec 2022 10:34:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:7200:bb8f:4362:97b4:df85? (p200300cbc7017200bb8f436297b4df85.dip0.t-ipconnect.de. [2003:cb:c701:7200:bb8f:4362:97b4:df85])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003d22528decesm6224169wms.43.2022.12.12.10.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 10:34:21 -0800 (PST)
Message-ID: <a6776188-056e-3a36-4f92-d83b3bfcee38@redhat.com>
Date:   Mon, 12 Dec 2022 19:34:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
 <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev> <Y5ALigw0kUO/B3z2@monkey>
 <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev>
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

On 07.12.22 05:11, Muchun Song wrote:
> 
> 
>> On Dec 7, 2022, at 11:42, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 12/07/22 11:34, Muchun Song wrote:
>>>
>>>
>>>> On Nov 30, 2022, at 06:50, Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
>>>>
>>>> Add folio equivalents for set_compound_order() and set_compound_page_dtor().
>>>>
>>>> Also remove extra new-lines introduced by mm/hugetlb: convert
>>>> move_hugetlb_state() to folios and mm/hugetlb_cgroup: convert
>>>> hugetlb_cgroup_uncharge_page() to folios.
>>>>
>>>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>> Suggested-by: Muchun Song <songmuchun@bytedance.com>
>>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>>> ---
>>>> include/linux/mm.h | 16 ++++++++++++++++
>>>> mm/hugetlb.c       |  4 +---
>>>> 2 files changed, 17 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index a48c5ad16a5e..2bdef8a5298a 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -972,6 +972,13 @@ static inline void set_compound_page_dtor(struct page *page,
>>>> page[1].compound_dtor = compound_dtor;
>>>> }
>>>>
>>>> +static inline void folio_set_compound_dtor(struct folio *folio,
>>>> + enum compound_dtor_id compound_dtor)
>>>> +{
>>>> + VM_BUG_ON_FOLIO(compound_dtor >= NR_COMPOUND_DTORS, folio);
>>>> + folio->_folio_dtor = compound_dtor;
>>>> +}
>>>> +
>>>> void destroy_large_folio(struct folio *folio);
>>>>
>>>> static inline int head_compound_pincount(struct page *head)
>>>> @@ -987,6 +994,15 @@ static inline void set_compound_order(struct page *page, unsigned int order)
>>>> #endif
>>>> }
>>>>
>>>> +static inline void folio_set_compound_order(struct folio *folio,
>>>> + unsigned int order)
>>>> +{
>>>> + folio->_folio_order = order;
>>>> +#ifdef CONFIG_64BIT
>>>> + folio->_folio_nr_pages = order ? 1U << order : 0;
>>>
>>> It seems that you think the user could pass 0 to order. However,
>>> ->_folio_nr_pages and ->_folio_order fields are invalid for order-0 pages.
>>> You should not touch it. So this should be:
>>>
>>> static inline void folio_set_compound_order(struct folio *folio,
>>>      unsigned int order)
>>> {
>>> 	if (!folio_test_large(folio))
>>> 		return;
>>>
>>> 	folio->_folio_order = order;
>>> #ifdef CONFIG_64BIT
>>> 	folio->_folio_nr_pages = 1U << order;
>>> #endif
>>> }
>>
>> I believe this was changed to accommodate the code in
>> __destroy_compound_gigantic_page().  It is used in a subsequent patch.
>> Here is the v6.0 version of the routine.
> 
> Thanks for your clarification.
> 
>>
>> static void __destroy_compound_gigantic_page(struct page *page,
>> unsigned int order, bool demote)
>> {
>> 	int i;
>> 	int nr_pages = 1 << order;
>> 	struct page *p = page + 1;
>>
>> 	atomic_set(compound_mapcount_ptr(page), 0);
>> 	atomic_set(compound_pincount_ptr(page), 0);
>>
>> 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>> 		p->mapping = NULL;
>> 		clear_compound_head(p);
>> 		if (!demote)
>> 			set_page_refcounted(p);
>> 	}
>>
>> 	set_compound_order(page, 0);
>> #ifdef CONFIG_64BIT
>> 	page[1].compound_nr = 0;
>> #endif
>> 	__ClearPageHead(page);
>> }
>>
>>
>> Might have been better to change this set_compound_order call to
>> folio_set_compound_order in this patch.
>>
> 
> Agree. It has confused me a lot. I suggest changing the code to the
> followings. The folio_test_large() check is still to avoid unexpected
> users for OOB.
> 
> static inline void folio_set_compound_order(struct folio *folio,
> 					    unsigned int order)
> {
> 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> 	// or
> 	// if (!folio_test_large(folio))
> 	// 	return;
> 
> 	folio->_folio_order = order;
> #ifdef CONFIG_64BIT
> 	folio->_folio_nr_pages = order ? 1U << order : 0;
> #endif
> }
> 
> Thanks.

On mm-stable, dynamically allocating gigantic pages gives me:

[   23.625105] page:00000000ae27bd2a refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1800
[   23.635117] flags: 0x17fffc00000000(node=0|zone=2|lastcpupid=0x1ffff)
[   23.641969] raw: 0017fffc00000000 ffffa4edc489bb58 fffff784c6000048 0000000000000000
[   23.650141] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   23.657907] page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
[   23.663955] ------------[ cut here ]------------
[   23.667680] kernel BUG at include/linux/mm.h:1030!
[   23.673378] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   23.681610] CPU: 3 PID: 1220 Comm: bash Not tainted 6.1.0-rc4+ #13
[   23.690281] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-1.fc36 04/01/2014
[   23.699837] RIP: 0010:__prep_compound_gigantic_folio+0x115/0x120
[   23.706587] Code: c7 44 24 5c 00 00 00 00 5b 44 89 d0 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 48 83 e8 09
[   23.725954] RSP: 0018:ffffa4edc489bc90 EFLAGS: 00010296
[   23.731001] RAX: 000000000000003e RBX: ffffffffae39a720 RCX: 0000000000000000
[   23.736065] RDX: 0000000000000001 RSI: ffffffffad522c25 RDI: 00000000ffffffff
[   23.740866] RBP: 0000000000040000 R08: 0000000000000000 R09: ffffa4edc489bb58
[   23.745385] R10: 0000000000000003 R11: ffff926d7ff4b028 R12: fffff784c6000000
[   23.749464] R13: 0000000000040000 R14: fffff784c6000000 R15: ffff9266039fb900
[   23.753176] FS:  00007f69a9703740(0000) GS:ffff92696f8c0000(0000) knlGS:0000000000000000
[   23.758299] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.761275] CR2: 0000556789080640 CR3: 0000000105568005 CR4: 0000000000770ee0
[   23.764929] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   23.768572] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   23.772221] PKRU: 55555554
[   23.773696] Call Trace:
[   23.776170]  <TASK>
[   23.777258]  alloc_fresh_hugetlb_folio+0x14b/0x220
[   23.779406]  alloc_pool_huge_page+0x7c/0x110
[   23.781273]  __nr_hugepages_store_common+0x191/0x400
[   23.783369]  ? __mod_memcg_lruvec_state+0x93/0x110
[   23.785343]  ? __mod_lruvec_page_state+0xa6/0x1a0
[   23.787223]  ? _copy_from_iter+0x8c/0x540
[   23.788788]  ? __kmem_cache_alloc_node+0x13b/0x2a0
[   23.790577]  ? kernfs_fop_write_iter+0x174/0x1f0
[   23.792313]  nr_hugepages_store+0x57/0x70
[   23.793754]  kernfs_fop_write_iter+0x11b/0x1f0
[   23.795337]  vfs_write+0x1e1/0x3a0
[   23.796531]  ksys_write+0x53/0xd0
[   23.797690]  do_syscall_64+0x37/0x90
[   23.798947]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   23.800602] RIP: 0033:0x7f69a9501977
[   23.801798] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 14
[   23.807322] RSP: 002b:00007ffce87f3338 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   23.809460] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f69a9501977
[   23.811485] RDX: 0000000000000002 RSI: 00005652a970e5e0 RDI: 0000000000000001
[   23.813443] RBP: 00005652a970e5e0 R08: 0000000000000000 R09: 0000000000000073
[   23.815385] R10: 0000000000001000 R11: 0000000000000246 R12: 0000000000000002
[   23.817289] R13: 00007f69a95f9780 R14: 0000000000000002 R15: 00007f69a95f49e0
[   23.819176]  </TASK>
[   23.819792] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency_common isst_ir
[   23.829056] ---[ end trace 0000000000000000 ]---
[   23.830413] RIP: 0010:__prep_compound_gigantic_folio+0x115/0x120
[   23.832390] Code: c7 44 24 5c 00 00 00 00 5b 44 89 d0 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 48 83 e8 09
[   23.836787] RSP: 0018:ffffa4edc489bc90 EFLAGS: 00010296
[   23.838083] RAX: 000000000000003e RBX: ffffffffae39a720 RCX: 0000000000000000
[   23.839764] RDX: 0000000000000001 RSI: ffffffffad522c25 RDI: 00000000ffffffff
[   23.841456] RBP: 0000000000040000 R08: 0000000000000000 R09: ffffa4edc489bb58
[   23.843150] R10: 0000000000000003 R11: ffff926d7ff4b028 R12: fffff784c6000000
[   23.844836] R13: 0000000000040000 R14: fffff784c6000000 R15: ffff9266039fb900
[   23.846521] FS:  00007f69a9703740(0000) GS:ffff92696f8c0000(0000) knlGS:0000000000000000
[   23.848417] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.849797] CR2: 0000556789080640 CR3: 0000000105568005 CR4: 0000000000770ee0
[   23.851491] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   23.853181] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   23.854861] PKRU: 55555554


Something's broken.

-- 
Thanks,

David / dhildenb

