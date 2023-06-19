Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1307F734CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjFSH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFSH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B4AA7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687161407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/fHK6hLvkLbFWjRtnXUJu1BfimbtAFaIRjWPmhQcup8=;
        b=WRnHSCbCDV/loEYGvGcGqPf02PMIebSTTsU0/GeBOBLDoHy3nZh6wBiNpA/6tMMV1OXaNG
        GGMPFnDgXMWU5uebaiygIlWGP4m88Hn9TmzymVAq6k5IslS9hOyJW5fljX8tJzi/6gZ5EB
        j9X+tXiftIHh9SAyaMc3iTnhQahFGcg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-zyIsQkZfN4iy35pB_-J8jQ-1; Mon, 19 Jun 2023 03:56:45 -0400
X-MC-Unique: zyIsQkZfN4iy35pB_-J8jQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f9b12b55cfso3913205e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687161404; x=1689753404;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fHK6hLvkLbFWjRtnXUJu1BfimbtAFaIRjWPmhQcup8=;
        b=j+fNSVVqn45UFWYnc3I9WZJbkS33+JcX9XRXnQ1VlPOcr6VtA3oWO7JGbtUbPtrLVK
         k3/XVQVzwheZ2JjoPFzm2ZjPgsPI67hdlrGXcYI/eAXFhtw+bi1hHHhPn/cvMTY/wVkH
         nVeKSLiFKowFIPp8+km0fcvN8nsechHeVZ4JnKUsFaVeAiZP/+pgUCzgTcrgMdYivIjJ
         /w2byNQTII51d0gOxWKePRsA+oSZL0N9WfOpWSxUo3PlB5KtoIZV92cODTOgAgEHN8HR
         3g5nCRZjJOX9A9jmUJurHKlBQCytQy0CRYunflMzpXT7DHAHUhqgT0yu0wRYjDN8/WG9
         cKgg==
X-Gm-Message-State: AC+VfDy1qZxnnX7cvb7XEqqg7Q/HP9aRP1ogaPEqNuC0TB9N2+rDGUxg
        qfNwrKg0au9PXIudHHUwaU1DmzTUwUO0u8/kZT7ZgfXMOSq+jfIFye6UNgjV8+LEWCiVujHQQRW
        COfL/RUSjW1VGUyZ7IAWwlyFl
X-Received: by 2002:a1c:e909:0:b0:3f6:a65:6ff3 with SMTP id q9-20020a1ce909000000b003f60a656ff3mr7853489wmc.32.1687161403913;
        Mon, 19 Jun 2023 00:56:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pKONDQSVPAi+bDBIMNTn8k/5gibdpHqj+h2uW3r5E0zsloGf7syvk7GOh8jAWSN+3oJoDXA==
X-Received: by 2002:a1c:e909:0:b0:3f6:a65:6ff3 with SMTP id q9-20020a1ce909000000b003f60a656ff3mr7853464wmc.32.1687161403541;
        Mon, 19 Jun 2023 00:56:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:7100:cede:6433:a77b:41e9? (p200300cbc72f7100cede6433a77b41e9.dip0.t-ipconnect.de. [2003:cb:c72f:7100:cede:6433:a77b:41e9])
        by smtp.gmail.com with ESMTPSA id g18-20020a7bc4d2000000b003f8d0308604sm9942206wmk.9.2023.06.19.00.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 00:56:43 -0700 (PDT)
Message-ID: <9f53b80e-7083-705a-88d3-7f3f33dd9c4b@redhat.com>
Date:   Mon, 19 Jun 2023 09:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230618065824.1365750-1-yosryahmed@google.com>
 <87ilbk8b89.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAJD7tkaiMWVHfam-j8v2i+0c8+BqKT=h=hv16-Ngz3u+7qJmaA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 5/5] Revert "mm/migrate: __unmap_and_move() push good
 newpage to LRU"
In-Reply-To: <CAJD7tkaiMWVHfam-j8v2i+0c8+BqKT=h=hv16-Ngz3u+7qJmaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.23 05:59, Yosry Ahmed wrote:
> On Sun, Jun 18, 2023 at 7:00 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Hi, Yosry,
>>
>> Yosry Ahmed <yosryahmed@google.com> writes:
>>
>>> This reverts commit c3096e6782b733158bf34f6bbb4567808d4e0740.
>>>
>>> That commit made sure we immediately add the new page to the LRU before
>>> remove_migration_ptes() is called in migrate_move_folio() (used to be
>>> __unmap_and_move() back then), such that the rmap walk will rebuild the
>>> correct mlock_count for the page again. This was needed because the
>>> mlock_count was lost when the page is isolated. This is no longer the
>>> case since mlock_count no longer overlays page->lru.
>>>
>>> Revert the commit (the code was foliated afterward the commit, so the
>>> revert is updated as such).
>>>
>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>>> ---
>>>   mm/migrate.c | 24 +++++++++---------------
>>>   1 file changed, 9 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 01cac26a3127..68f693731865 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1279,19 +1279,6 @@ static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
>>>        if (unlikely(!is_lru))
>>>                goto out_unlock_both;
>>
>> The patch itself looks good to me!  Thanks!
>>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> 
> Thanks for taking a look!
> 
>>
>> And, it seems that we can remove the above 2 lines and "out_unlock_both"
>> label now.  That can make the code simpler a little.  Right?
> 
> I am not familiar with this code. If we remove the above condition
> then pages that have is_lru == 0 (i.e __PageMovable(src) is true) and
> page_was_mapped == 1 will call remove_migration_ptes(). This wouldn't
> happen without removing the above 2 lines. If this combination is
> impossible (is_lru == 0 && page_was_mapped == 1), then yeah we can
> remove the above condition.
> 
> It looks like __SetPageMovable() is only called by zsmalloc, z3fold,
> and balloon_page_insert(). The former 2 will never have those pages
> mapped into userspace. I am not familiar with balloon_page_insert(),
> but my gut feeling is that those are pages used by the driver and are
> also not mapped into userspace.

On XEN, there is xen_alloc_ballooned_pages(), which ends up mapping 
balloon-inflated pages into user space (for something like MMIO IIRC). 
But the XEN balloon does not use the balloon compaction framework, so 
__SetPageMovable() does not apply.

The other balloon_page_insert() users (VMware balloon, CMM, 
virtio-balloon) shouldn't be doing something like that.

-- 
Cheers,

David / dhildenb

