Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A463859A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKYIzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYIzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:55:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4AF29809
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669366457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1XtvVH6LEhrFZxx7ZWj/yZwCZe7eSY1F/ViQDa6RlP0=;
        b=POhVU4YNG0UXV5g3IxpYlzWNIrprOBXRptSNyjt7ChvgC3v/V+RcDQ41ean65JyXT7T5WJ
        tocY9Pnxy7gNW6P905PXck0qJoUgtH/d5ai6ymm7kKg4A+UGEyWmVG3XGX8QKIZcIM0rb/
        uR6DBDFr6L5vWPnIGFZumTCiSvSIPII=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-266-iMZdf5VlN4eqfiKmAJVsKQ-1; Fri, 25 Nov 2022 03:54:16 -0500
X-MC-Unique: iMZdf5VlN4eqfiKmAJVsKQ-1
Received: by mail-wm1-f70.google.com with SMTP id h9-20020a1c2109000000b003cfd37aec58so2134499wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XtvVH6LEhrFZxx7ZWj/yZwCZe7eSY1F/ViQDa6RlP0=;
        b=n5tI8XN783huJBw4cRq+RP0J+EzEbANYt4U1MFZlG8YahNZ3bPkabh+ge/Tdj1AmYH
         0tF9aOx/6lIUf8tQMdPcNunrcBaeQl/pwC2iqLgJV+z5vk6LhuIS6xUf8VQoYfzmkyjR
         yCuQ/KcGipXPH2FAvn08GuaSnrBpRRv/VZh64ZSN9COwA1ox34OlzkSzIDth0CFkFvHz
         uA85y3YvlyQ8DZ7Bvy6epJTKrp+glrajm+baFzQQQ0JMTqbDeDEgVLtbKu9OrD4seAzi
         YfEzUzr0S1DLH/jj6HhHs/t5Oh5RjBqENA/zNR67VxXM4n7rwG/BwJ+EoAD8gjCLWREU
         fypQ==
X-Gm-Message-State: ANoB5pn3gDgo6UbjOIv5OCembB7eKE58QbBYtGS2aX5egqlxVvehYbJh
        5tNxnDMB81i/GCQtgZj5r9CmcwToM66HcciWD1XgRAg86IqPDH/XZJ0/u/iR9lxGlMSr2FJgk9U
        wp4mfTMMHQC40eK1t7GsddmGj
X-Received: by 2002:adf:decc:0:b0:241:dd7b:f7d1 with SMTP id i12-20020adfdecc000000b00241dd7bf7d1mr12325359wrn.400.1669366454728;
        Fri, 25 Nov 2022 00:54:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7UX+ks/uq1sWlIKueUHaJf+nOMPwYsjuUMs27bQ6wIizOpOJLf74hddzXJoM3lUp5VIbH09Q==
X-Received: by 2002:adf:decc:0:b0:241:dd7b:f7d1 with SMTP id i12-20020adfdecc000000b00241dd7bf7d1mr12325322wrn.400.1669366454271;
        Fri, 25 Nov 2022 00:54:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08? (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de. [2003:cb:c704:d800:887:cbec:f31f:a08])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b003cfaae07f68sm5597626wmo.17.2022.11.25.00.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:54:13 -0800 (PST)
Message-ID: <2541344f-61d8-96d1-10e9-ba7e1743a299@redhat.com>
Date:   Fri, 25 Nov 2022 09:54:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Gavin Shan <gshan@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com
References: <20221123005752.161003-1-gshan@redhat.com>
 <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
 <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com> <871qptrvsw.fsf@nvidia.com>
 <Y37mC1+LQscJaOk4@casper.infradead.org>
 <51ffd399-7fa3-b2f2-b6e5-61a8b609e350@redhat.com> <87o7svreq0.fsf@nvidia.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
In-Reply-To: <87o7svreq0.fsf@nvidia.com>
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

>>>> I think you're right. Without a page reference I don't think it is even
>>>> safe to look at struct page, at least not without synchronisation
>>>> against memory hot unplug which could remove the struct page. From a
>>>> quick glance I didn't see anything here that obviously did that though.
>>> Memory hotplug is the offending party here.  It has to make sure
>>> that
>>> everything else is definitely quiescent before removing the struct pages.
>>> Otherwise you can't even try_get a refcount.
> 
> Sure, I might be missing something but how can memory hotplug possibly
> synchronise against some process (eg. try_to_compact_pages) doing
> try_get(pfn_to_page(random_pfn)) without that process either informing
> memory hotplug that it needs pages to remain valid long enough to get a
> reference or detecting that memory hotplug is in the process of
> offlining pages?

It currently doesn't, and it's been mostly a known theoretical problem 
so far. We've been ignoring these kind of problems because they are not 
easy to sort out and so far never popped up in practice.

First, the correct approach is using pfn_to_online_page() instead of 
pfn_to_page() when in doubt whether the page might already be offline. 
While we're using pfn_to_online_page() already in quite some PFN 
walkers, changes are good that we're still missing some.

Second, essentially anybody (PFN walker) doing a pfn_to_online_page() is 
prone to races with memory offlining. I've discussed this in the past 
with Michal and Dan and one idea was to use RCU to synchronize PFN 
walkers and pfn_to_online_page(), essentially synchronizing clearing of 
the SECTION_IS_ONLINE flag.

Nobody worked on that so far because we've never had actual BUG reports. 
These kind of races are rare, but they are theoretically possible.

> 
>> At least alloc_contig_range() and memory offlining are mutually
>> exclusive due to MIGRATE_ISOLTAE. I recall that ordinary memory
>> compaction similarly deals with isolated pageblocks (or some other
>> mechanism I forgot) to not race with memory offlining. Wouldn't worry
>> about that for now.
> 
> Sorry, agree - to be clear this discussion isn't relevant for this patch
> but reviewing it got me thinking about how this works. I still don't see
> how alloc_contig_range() is totally safe against memory offlining
> though. From what I can see we have the following call path to set
> MIGRATE_ISOLATE:
> 
> alloc_contig_range(pfn) -> start_isolate_page_range(pfn) ->
> isolate_single_pageblock(pfn) -> page_zone(pfn_to_page(pfn))
> 
> There's nothing in that call stack that prevent offlining of the page,
> hence the struct page may be freed by this point. Am I missing something
> else here?

Good point. I even had at some point a patch that converted some 
pfn_to_online_page() calls in there, but discarded it.

IIRC, two alloc_contig_range() users are safe because:

1) virtio-mem synchonizes against memory offlining using the memory 
notifier. While memory offlining is in progress, it won't call 
alloc_contig_range().

2) CMA regions will always fail to offline because they have MIGRATE_CMA 
set.

What remains is alloc_contig_pages(), for example, used for memtrace on 
ppc, kfence, and allocation of gigantic pages. That might indeed be 
racy. At least from kfence_init_late() it's unlikely (impossible?) that 
we'll have concurrent memory offlining.

> 
> try_to_compact_pages() has a similar issue which is what I noticed
> reviewing this patch:

Yes, I can spot pfn_to_online_page() in __reset_isolation_pfn(), but of 
course, are likely missing proper synchronization and checks later. I 
wonder if we could use the memory notifier to temporarily pause any 
running compaction and to restart it once memory offlining succeeded.

> 
> try_to_compact_pages() -> compact_zone_order() -> compact_zone() ->
> isolate_migratepages() -> isolate_migratepages_block() ->
> PageHuge(pfn_to_page(pfn))
> 
> Again I couldn't see anything in that path that would hold the page
> stable long enough to safely perform the pfn_to_page() and get a
> reference. And after a bit of fiddling I was able to trigger the below
> oops running the compaction_test selftest whilst offlining memory so I
> don't think it is safe:

Thanks for finding a reproducer. This is exactly the kind of BUG that we 
speculated about in the past but that we haven't seen in practice yet.


Having that said, I'd be very happy if someone would have time to work 
on proper synchronization and I'd be happy to help 
brainstorming/reviewing :)

-- 
Thanks,

David / dhildenb

