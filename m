Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9A46E782B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjDSLKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjDSLKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E176AB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681902579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YV5OB9rG8lp5OcWfrZNdy9yvgts3yK9FX8FnjFmPjWg=;
        b=OFTJTyQu6uE/lAtR1Sp7tGSN4m6UV3wCruD8X7bhbctpuc7gBFdnwaKzupEqlCB+A4tf8I
        WMRWSomkjO6yqFe/757xE0yUtkV5GfkwAf/IzdkcKUh03RKw7E7iRwVEQF0dBhfrQ4MRLn
        +y85mPAI17Z/0SmEYuYB0ih2lIdcGxM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-Of6ILhoJMvueq71sTilh3g-1; Wed, 19 Apr 2023 07:09:38 -0400
X-MC-Unique: Of6ILhoJMvueq71sTilh3g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f175a24fd1so11820975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902578; x=1684494578;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YV5OB9rG8lp5OcWfrZNdy9yvgts3yK9FX8FnjFmPjWg=;
        b=Bdf6fc3LvPnykEIX0WFqD06MM0x3uO1VZMw+Jp+2QtEW5KN2m4XBijWPvK0BKpZrRJ
         fJNfNMsTDgVP7Oj6RVKgygSQcRkAE9hRNDU+HUGW5nVEqMy7cD0dwTYFr3Cla1LkTDBC
         /uIsG1Md8m/nbUHFCebcWndDB2cF3KHY2at6gw4BcAEvypS85hJYwS6h/zHLAFOrVaXu
         co7KTO1yqjNqGsPlYiXTo3pETy9CAxZ56XxhI2k59Jtfp+IbiKrq0fxKqzor5eMWNs8h
         aMAm40t0930W4PJd6XEyMgDFHQTUVYu8nRJqzSt/JRwnMHiTdvJnp9az0RZ8fIWnnKzi
         eE6Q==
X-Gm-Message-State: AAQBX9dD7DHQeLtmrXugZzG2jw0WlF+4glKPm9K1e15tqyw5mPK6IhKL
        kVEPDuV9l4GDyexxVi4OU/KyRl5Fe/66PZOTlkA+TeJYKdZfgyGTefQDSN0Q+hwO/6PTNt0eZ9X
        m9fiF9CYFqPKxh9XjxW5LKFPURXTNoKvA
X-Received: by 2002:a05:6000:12c1:b0:2f8:8e65:7339 with SMTP id l1-20020a05600012c100b002f88e657339mr3927499wrx.18.1681902577752;
        Wed, 19 Apr 2023 04:09:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z5UqGF+kDzxsEsbHzcqvYywHJ8z4OQ5MJvsFN8upfUtD+nqZOFahcpHTVcLpYHfAr1A2holQ==
X-Received: by 2002:a05:6000:12c1:b0:2f8:8e65:7339 with SMTP id l1-20020a05600012c100b002f88e657339mr3927485wrx.18.1681902577426;
        Wed, 19 Apr 2023 04:09:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:7b00:7c52:a5fa:8004:96fd? (p200300cbc70b7b007c52a5fa800496fd.dip0.t-ipconnect.de. [2003:cb:c70b:7b00:7c52:a5fa:8004:96fd])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d4e0d000000b002f4cf72fce6sm15563321wrt.46.2023.04.19.04.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:09:37 -0700 (PDT)
Message-ID: <54f24909-91b8-01cc-5a1f-6146ebc9297c@redhat.com>
Date:   Wed, 19 Apr 2023 13:09:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 03/26] mm: make pageblock_order 2M per default
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-4-hannes@cmpxchg.org>
 <804dd674-6078-7455-8dda-1bd921bed828@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <804dd674-6078-7455-8dda-1bd921bed828@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.23 12:36, Vlastimil Babka wrote:
> On 4/18/23 21:12, Johannes Weiner wrote:
>> pageblock_order can be of various sizes, depending on configuration,
>> but the default is MAX_ORDER-1. Given 4k pages, that comes out to
>> 4M. This is a large chunk for the allocator/reclaim/compaction to try
>> to keep grouped per migratetype. It's also unnecessary as the majority
>> of higher order allocations - THP and slab - are smaller than that.
> 
> Well in my experience the kernel usually has hugetlbfs config-enabled so it
> uses 2MB pageblocks (on x86) even if hugetlbfs is unused at runtime and THP
> is used instead. But sure, we can set a better default that's not tied to
> hugetlbfs.

As virtio-mem really wants small pageblocks (hot(un)plug granularity), 
I've seen reports from users without HUGETLB configured complaining 
about this (on x86, we'd get 4M instead of 2M).

So having a better default (PMD_SIZE) sounds like a good idea to me (and 
I even recall suggesting to change the !hugetlb default).

-- 
Thanks,

David / dhildenb

