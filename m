Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D186E786A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjDSLTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjDSLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24E14F42
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681903020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6VEVKA1Vl6VhcJKmRR8Lc5Oh25keqB43HXXf18w/R70=;
        b=fIUMR8ucjTlKkJjyLgEE+u2vTugK6PImALv+lAnqvTDmuccU5HDcz0D7tqapXcBLPATXJy
        ztudo1AtMHWGBTMFb/0zoPb4j9jJQmwyONBaVxWMOfkzwE+8CFM86cernfWeUwD4lryPAj
        wZWKAvlh0wz09MR/tZdYW6A8g8nPQYU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-cVaoE7esMga9mMqqTUDoDw-1; Wed, 19 Apr 2023 07:10:30 -0400
X-MC-Unique: cVaoE7esMga9mMqqTUDoDw-1
Received: by mail-wr1-f71.google.com with SMTP id t30-20020adfa2de000000b002f575ad4a7cso2674354wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902629; x=1684494629;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VEVKA1Vl6VhcJKmRR8Lc5Oh25keqB43HXXf18w/R70=;
        b=cRwoJ5uaBgBTBaeLmzTFcCbnnzyqBCei3n/PAabddthIKsfAXioB+8dz1N5u6TZ+/P
         CKmaLPV28rrBwTLPeYSYPS5wrVrlrOWPIrnhPXL/w/+XS8jL1Me4VQ0MWl64hrF2cVpP
         ER/xcoscc1wOcYLJ59zvnZ9KQi4tWwxxYNGNwtJpNes+dlv5Hg/9CTW1kT6qZbYYrYy0
         c8h2QKtxjM6+GRI4Yf6me/vLX8zgca4T+jdEfpkzZ1Osn7/ERt1Rw/IdGwJ3OCzevZ71
         XuRjuoArTUZDl1hKvZ1jWBlkl/JILZHHJfa9DA7AgyPAQ/XoSQXW6jeS0ZSTzxHUheMV
         HpMA==
X-Gm-Message-State: AAQBX9fEcskrCB1QF+VGQdpIFwfLoQRLqCApbli92xkYoUyyxOxTo8Ug
        R35F61/V9/jjxIDqAGMGgtp4o/yoOEzWRfZkDygtoAkvwQx4kXIKDOe1J4ojcv1is0Z/7LD2wC2
        9T39HQ1xUBcjFHNukptX37l6HuQcNU7do
X-Received: by 2002:a7b:c7cb:0:b0:3f1:72e2:5d13 with SMTP id z11-20020a7bc7cb000000b003f172e25d13mr8046133wmk.16.1681902629029;
        Wed, 19 Apr 2023 04:10:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350avLXd/CBQHwiuF4d7hR9iQ9uS5lpaVU09xA6pxIBcVZ6qLDKiB+l8V9gjwW1zCzN3JrjTycg==
X-Received: by 2002:a7b:c7cb:0:b0:3f1:72e2:5d13 with SMTP id z11-20020a7bc7cb000000b003f172e25d13mr8046114wmk.16.1681902628741;
        Wed, 19 Apr 2023 04:10:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:7b00:7c52:a5fa:8004:96fd? (p200300cbc70b7b007c52a5fa800496fd.dip0.t-ipconnect.de. [2003:cb:c70b:7b00:7c52:a5fa:8004:96fd])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b003f17e37ce60sm1836550wmo.47.2023.04.19.04.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:10:28 -0700 (PDT)
Message-ID: <103fea0a-8a5e-a8ec-e956-a4341906218e@redhat.com>
Date:   Wed, 19 Apr 2023 13:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 03/26] mm: make pageblock_order 2M per default
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-4-hannes@cmpxchg.org>
 <20230419000105.matz43p6ihrqmado@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230419000105.matz43p6ihrqmado@box.shutemov.name>
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

On 19.04.23 02:01, Kirill A. Shutemov wrote:
> On Tue, Apr 18, 2023 at 03:12:50PM -0400, Johannes Weiner wrote:
>> pageblock_order can be of various sizes, depending on configuration,
>> but the default is MAX_ORDER-1.
> 
> Note that MAX_ORDER got redefined in -mm tree recently.
> 
>> Given 4k pages, that comes out to
>> 4M. This is a large chunk for the allocator/reclaim/compaction to try
>> to keep grouped per migratetype. It's also unnecessary as the majority
>> of higher order allocations - THP and slab - are smaller than that.
> 
> This seems way to x86-specific. Other arches have larger THP sizes. I
> believe 16M is common.
> 

arm64 with 64k pages has ... 512 MiB IIRC :/ It's the weird one.

> Maybe define it as min(MAX_ORDER, PMD_ORDER)?

Sounds good to me.

-- 
Thanks,

David / dhildenb

