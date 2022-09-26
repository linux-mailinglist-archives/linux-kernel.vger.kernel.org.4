Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FFD5E9B60
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiIZIA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiIZH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A25586
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664178965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNpVlSHHhQ4kCT3FWu+P2c73h8U3yWzRZ1M3sl93EFM=;
        b=OR1Q52pmAOXyGwN2hBrYXgxZRUvKhNzmTaqJ02FjaGipK57gVHVzTkqZg1PwHxvN8ojN/l
        tKuaEqlxMxsnuEkc2gmtP9xcm26i2a+3k/f+p8cXtWx7oTtEgIWT/+vh7+b5uddTtklsth
        tVI+DdenRsMXTobJIfwpMtRg4C1gD7Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-490-bBaKGoaZOMShu-d9c7vqCQ-1; Mon, 26 Sep 2022 03:56:00 -0400
X-MC-Unique: bBaKGoaZOMShu-d9c7vqCQ-1
Received: by mail-wm1-f70.google.com with SMTP id t14-20020a1c770e000000b003b4856a6ecaso1567194wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=sNpVlSHHhQ4kCT3FWu+P2c73h8U3yWzRZ1M3sl93EFM=;
        b=2VbNqKDElODO2Cqa61584Agnbkv5nHP/yVsfnrzyvpreSm+xCcWuI9PVRUjH63/jzF
         g/tFk5IwtrE/Ym4zmAV4HKH1NhAuvpBHzKAkYVzefIo64k9/dMkVXBRsHE5HW3GVEDXC
         5LpGidm8SdvtcLBNkfrp4v5bifak7cp1y/2Z+jKPqxRGaw0RT/cxLZR1mrz+27xQ9SEi
         D2HSYDxuIgZgOLTGSkD/Z26ZU/WzEQt0u6aXqS6uVEF22v+jCHK8zj+1+IY4i1NOORqe
         CMjFU7vKachWevcGtrPT/c2hHwKyBt/q+OajlqReZw/WQxSWfouXWGH+4CFOfj4mW8iL
         Swew==
X-Gm-Message-State: ACrzQf3h++8IqbUgXt+CfFaZ0OIUOLRWRKKL7EfSWHZfVWOxzCBrrf5K
        kmOj43xCF/1c27CQN36yGZYI/gwdMknKO9tuA6xOp/YliGQnJUPI4506HAMIS43QKoUhZGYhimU
        oBZ8zjXscrHq/GQ2PGKiCSEFb
X-Received: by 2002:adf:dc92:0:b0:22a:415f:8dd7 with SMTP id r18-20020adfdc92000000b0022a415f8dd7mr12030909wrj.708.1664178959736;
        Mon, 26 Sep 2022 00:55:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6hrjlRKqp9WjazYMTtET1ZpVFwi8jfzKYfo5KkYz8jXi67TzVQ8JFYpB2o2DIVHFudVF88Zw==
X-Received: by 2002:adf:dc92:0:b0:22a:415f:8dd7 with SMTP id r18-20020adfdc92000000b0022a415f8dd7mr12030895wrj.708.1664178959442;
        Mon, 26 Sep 2022 00:55:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7? (p200300cbc7034b00e0907fa6b7d6d4a7.dip0.t-ipconnect.de. [2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d6d0a000000b002205a5de337sm14967285wrq.102.2022.09.26.00.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 00:55:58 -0700 (PDT)
Message-ID: <de365211-57b2-c1d6-d2cc-49af4dd1d3c4@redhat.com>
Date:   Mon, 26 Sep 2022 09:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>
References: <20220919125708.276864-1-42.hyeyoo@gmail.com>
 <Yy+NCJ525S+HzP4k@casper.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: move PG_slab flag to page_type
In-Reply-To: <Yy+NCJ525S+HzP4k@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.22 01:04, Matthew Wilcox wrote:
> On Mon, Sep 19, 2022 at 09:57:08PM +0900, Hyeonggon Yoo wrote:
>> For now, only SLAB uses _mapcount field as a number of active objects in
>> a slab, and other slab allocators do not use it. As 16 bits are enough
>> for that, use remaining 16 bits of _mapcount as page_type even when
>> SLAB is used. And then move PG_slab flag to page_type!
>>
>> Note that page_type is always placed in upper 16 bits of _mapcount to
>> avoid confusing normal _mapcount as page_type. As underflow (actually
>> I mean, yeah, overflow) is not a concern anymore, use more lower bits
>> except bit zero.
>>
>> Add more folio helpers for PAGE_TYPE_OPS() not to break existing
>> slab implementations.
>>
>> Remove PG_slab check from PAGE_FLAGS_CHECK_AT_FREE. buddy will still
>> check if _mapcount is properly set at free.
>>
>> Exclude PG_slab from hwpoison and show_page_flags() for now.
>>
>> Note that with this patch, page_mapped() and folio_mapped() always return
>> false for slab page.
> 
> This is an interesting approach.  It raises some questions.
> 
> First, you say that folio_mapped() returns false for slab pages.  That's
> only true for order-0 slab pages.  For larger pages,
> 
>          if (!folio_test_large(folio))
>                  return atomic_read(&folio->_mapcount) >= 0;
>          if (atomic_read(folio_mapcount_ptr(folio)) >= 0)
>                  return true;
> 
> so that's going to depend what folio_mapcount_ptr() aliases with.
> 
> Second, this patch changes the behaviour of PageSlab() when applied to
> tail pages.  Which raises the further question of what PageBuddy(),
> PageTable(), PageGuard() and PageIsolated() should do for multi-page
> folios, if that is even possible.

IIRC, these flags never apply on real compound pages so far. For 
example, PageBuddy() is only set on the first page of a (budy-aligned) 
free chunk of memory, and all "remaining" (tail) pages have a refcount 
of zero and don't have the flag set.

There are page tables on some systems (e.g., s390x) that span multiple 
pages (pmd_alloc_one()). I think the behavior is similar -- no compound 
page, and only the first page has the flag set.

-- 
Thanks,

David / dhildenb

