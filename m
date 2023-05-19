Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619B4709416
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjESJvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjESJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883139C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684489864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvDyxmxzm7Q9OzR/miu9z+fW0LmnPZ8pBxAPJO77LOE=;
        b=NTEdYy0fj54rKNMToyY6ysZWhBGu4HzUqf6mxxezA7+hJY9ln6I3g/757np2TRh3NyH/Iz
        kx4YCyR1OnCnVRQyLfE9naaSo/s7uKUFk8o1sLwp7RzVsDiu4EI0n+wXNnM/VleB2/dYgE
        rlG1b+F5j6p9/rt2G6iSBAbzO5AqBic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-CK_Vb4yzNJavxSMKDsrUZg-1; Fri, 19 May 2023 05:51:03 -0400
X-MC-Unique: CK_Vb4yzNJavxSMKDsrUZg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f422dc5ee5so17602835e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684489862; x=1687081862;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvDyxmxzm7Q9OzR/miu9z+fW0LmnPZ8pBxAPJO77LOE=;
        b=Vbf1Zgv3pOVfCNnj7V1t/+7FYO2YOpksanIbRjo29qw8kbzvfoc9CblKKWBrX8XDOI
         /wCifhb2jiGBJOiGmIO4JnMButZAonQpUymmxvO3kbHD8djXuwj1qjvyYvmIULUGXlFi
         J6X96UhpthS04srPnvZo23aingLJefJGl2B9ettjB4lDHyt325EN/PtNFSwQykH7NH1o
         QRxU5fLszoF0FXmhERYkk8s6TR7RLGPC+KR8FytZTf+UW55rVMs+LY6vUi1kQoY7YnAN
         cP6SzxFk7WCAzlmOpxf4GZGa8LK2K6zqmqQotZ7NerJ+KSLYhiI7MfCTrrTj7ulzLiEL
         SC2A==
X-Gm-Message-State: AC+VfDypYWo/fqKwmOB8lyhxg2Sid3nNJ6e8Y2xwc5r29Xqr3EKyixr7
        I5WFJd6fVriQHAB4ZT5xH2ZIfv/kRjRvXUuZlUwtniqRMsFiYsAX8h4DAZSMu8ftRLf7azqtfrR
        FVdO0G8qs6FjZAdt1Vv8Ufj8NMip7+t2q
X-Received: by 2002:a1c:4b08:0:b0:3f5:bc8:e398 with SMTP id y8-20020a1c4b08000000b003f50bc8e398mr928365wma.13.1684489862094;
        Fri, 19 May 2023 02:51:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BckUfM2oCeZBj/Cs0gFTDkmhAZR9BmyMzz4SFPPpusbscCj6Hil+D1Tm7wqS2NYKyhfNKPg==
X-Received: by 2002:a1c:4b08:0:b0:3f5:bc8:e398 with SMTP id y8-20020a1c4b08000000b003f50bc8e398mr928346wma.13.1684489861674;
        Fri, 19 May 2023 02:51:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c722:9d00:7421:54d8:9227:a3e8? (p200300cbc7229d00742154d89227a3e8.dip0.t-ipconnect.de. [2003:cb:c722:9d00:7421:54d8:9227:a3e8])
        by smtp.gmail.com with ESMTPSA id c18-20020a7bc852000000b003f4fb5532a1sm1790450wml.43.2023.05.19.02.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 02:51:01 -0700 (PDT)
Message-ID: <5f43a17c-94a0-4bff-b451-e5014de36ed9@redhat.com>
Date:   Fri, 19 May 2023 11:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] mm, compaction: Skip all non-migratable pages during
 scan
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        willy@infradead.org, steven.sistare@oracle.com,
        mgorman@techsingularity.net, khalid@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230517161555.84776-1-khalid.aziz@oracle.com>
 <c34e3768-8a01-d155-1970-8eada8c80ba7@redhat.com>
 <87sfbubg3j.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87sfbubg3j.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.23 03:09, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 17.05.23 18:15, Khalid Aziz wrote:
>>> Pages pinned in memory through extra refcounts can not be migrated.
>>> Currently as isolate_migratepages_block() scans pages for
>>> compaction, it skips any pinned anonymous pages. All non-migratable
>>> pages should be skipped and not just the anonymous pinned pages.
>>> This patch adds a check for extra refcounts on a page to determine
>>> if the page can be migrated.  This was seen as a real issue on a
>>> customer workload where a large number of pages were pinned by vfio
>>> on the host and any attempts to allocate hugepages resulted in
>>> significant amount of cpu time spent in either direct compaction or
>>> in kcompactd scanning vfio pinned pages over and over again that can
>>> not be migrated.
>>
>> How will this change affect alloc_contig_range(), such as used for CMA
>> allocations or virtio-mem? alloc_contig_range() ends up calling
>> isolate_migratepages_range() -> isolate_migratepages_block().
> 
> IIUC, cc->alloc_contig can be used to distinguish contiguous allocation
> and compaction.  And, from the original commit which introduced
> anonymous pages skipping (commit 119d6d59dcc0 ("mm, compaction: avoid
> isolating pinned pages ")) and this patch, large number of migration
> failure during compaction causes real issue too.  So, I suggest to use
> cc->alloc_contig here.

Agreed. I further wonder if we want to special-case the !alloc_contig 
case also for MIGRATE_CMA and ZONE_MOVABLE, where we cannot have 
longterm page pinnings (e.g., vfio pinned pages).

-- 
Thanks,

David / dhildenb

