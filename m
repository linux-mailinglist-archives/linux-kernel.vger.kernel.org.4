Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8AC6F4700
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjEBPW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjEBPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2955030C8
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683040909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9Z1Hse3LEHo6GNdRhFKInTnulP4yrVR64MMu+/xyUM=;
        b=JhuWNpO7HzRjTQ2OhYykk6iw0jbhDmG3ZTAGxBg6DRH2k4linhGrY2KdaGC577Lg3EGQMS
        9shao2X3aP3sAImEB9ZAcYdans5z64JDOKwWFNixBDPaS2GvcnKSAL2ntNemcauS/+kAkG
        Rcbo4fKRmUzkJNxcfIc1WxYKBbv+U9E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-vv16szm_Mn2XZv37_rpP3g-1; Tue, 02 May 2023 11:21:47 -0400
X-MC-Unique: vv16szm_Mn2XZv37_rpP3g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f170a1fbe7so24055205e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 08:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683040906; x=1685632906;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9Z1Hse3LEHo6GNdRhFKInTnulP4yrVR64MMu+/xyUM=;
        b=Qf6x08jv4OS54Uf+rQmYxNYRDAHX5SdGhZJkNZAd1V8qb8pVemQV67S3luyaB2GCnQ
         sRqNpj0zYQiHejzDXZ+j90bmDfCtJB9lt7jFtVlKit3I9GFDENKdq3rr3Z9Gl28aKQYa
         jsF+mjIV10yDiD/JbjWTFPIaeSz/z+KBBgf/TGG5FaNNYkP52H2XC8EqoAHnhMAMxxgu
         bIMRtWgDCN0hYaCK5TJuDSGmia6IZN/5sxhvmTGoiTr09i2QgVQLNuHdfxSDcuGSjdh6
         CebtI3m8ubEBA1OXeDHoxVnTogeO9SCjrPBcEz8bAB9LRkYe7lUxF+qdeU+/YrGjqYSw
         uylg==
X-Gm-Message-State: AC+VfDyB8/yiT4WdlBsd76zKOEY+p50PjyRRx38ssItoD9bF9vmzO1I1
        4LHdJPItpwILd6QRJquNykgS6ctqWUM/ldlSzY1V9Q9E8WECeiTJZgO2rlc7+yugKwgrxpe2HC4
        PJ7+lCsLfEn7Bdrs2BsaJmZ9P
X-Received: by 2002:a5d:58e2:0:b0:2f5:67c1:d70e with SMTP id f2-20020a5d58e2000000b002f567c1d70emr12704127wrd.21.1683040906465;
        Tue, 02 May 2023 08:21:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FG2hz46+i5qcnyBvqbYomW8Kl7z/xxr8UOQ7Q5sI1kHXtADgPBuYxfoU5t+eUjouBrOMRVg==
X-Received: by 2002:a5d:58e2:0:b0:2f5:67c1:d70e with SMTP id f2-20020a5d58e2000000b002f567c1d70emr12704105wrd.21.1683040906115;
        Tue, 02 May 2023 08:21:46 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6ae5.dip0.t-ipconnect.de. [91.12.106.229])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d6b10000000b003062765bf1dsm8053514wrw.33.2023.05.02.08.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 08:21:45 -0700 (PDT)
Message-ID: <34138d9a-5439-5875-ea1b-6584b0c87a67@redhat.com>
Date:   Tue, 2 May 2023 17:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <ZD9qATZcdyW/UGgI@casper.infradead.org>
 <20230421161156.5jnipnfs4svwwzee@techsingularity.net>
 <ZELEgRG5DwmcMB/T@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 00/26] mm: reliable huge page allocator
In-Reply-To: <ZELEgRG5DwmcMB/T@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.23 19:14, Matthew Wilcox wrote:
> On Fri, Apr 21, 2023 at 05:11:56PM +0100, Mel Gorman wrote:
>> It was considered once upon a time and comes up every so often as variants
>> of a "sticky" pageblock pageblock bit that prevents mixing. The risks was
>> ending up in a context where memory within a suitable pageblock cannot
>> be freed and all of the available MOVABLE pageblocks have at least one
>> pinned page that cannot migrate from the allocating context. It can also
>> potentially hit a case where the majority of memory is UNMOVABLE pageblocks,
>> each of which has a single pagetable page that cannot be freed without an
>> OOM kill. Variants of issues like this would manifestas an OOM kill with
>> plenty of memory free bug or excessive CPu usage on reclaim or compaction.
>>
>> It doesn't kill the idea of the series at all but it puts a lot of emphasis
>> in splitting the series by low-risk and high-risk. Maybe to the extent where
>> the absolute protection against mixing can be broken in OOM situations,
>> kernel command line or sysctl.
> 
> Has a variant been previously considered where MOVABLE allocations are
> allowed to come from UNMOVABLE blocks?  After all, MOVABLE allocations
> are generally, well, movable.  So an UNMOVABLE allocation could try to
> migrate pages from a MIXED pageblock in order to turn the MIXED pageblock
> back into an UNMOVABLE pageblock.

I might be completely off, but my understanding was that movable 
allocations can be happily placed into unmovable blocks if required already?

IIRC, it's primarily the zone fallback rules that prevent e.g., ZONE_DMA 
to get filled immediately with movable data in your example. I might eb 
wrong, though.

I guess what you mean is serving movable allocations much earlier from 
these other zones.

Having memory hotunplug in mind ( as always ;) ), I'd expect that such 
fragmentation must be allowed to happen to guarantee that memory (esp. 
ZONE_MOVABLE) can be properly evacuated even if there are not sufficient 
MOVABLE pageblocks around to hold all that (movable) data.

-- 
Thanks,

David / dhildenb

