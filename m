Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169E86C0F98
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCTKsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjCTKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CD218B1D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26nymbdY5u8lbHR6tGhq6iWNHbEegWrEQrrqMsFd9eI=;
        b=g8Sdqcp4vdpI4W4YoFAEG9UQlbEQJiDem2jvYW3PZ+qJtLuTGKT0Sk7k/IytTJRjE4FPt4
        EG06ww9TDZ7zOnvdKAbpmbYeMBVOhFuCIbklKS7gFz4+Juo9HdGtUMf007c4I9EymETElV
        Rhw98cyMqzWYBdBnjN/50TDbVM0pOsg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-UDfjaUkyMfyuKnHjzRBFnw-1; Mon, 20 Mar 2023 06:39:32 -0400
X-MC-Unique: UDfjaUkyMfyuKnHjzRBFnw-1
Received: by mail-wm1-f72.google.com with SMTP id j10-20020a05600c190a00b003eda80e8086so2650279wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308771;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26nymbdY5u8lbHR6tGhq6iWNHbEegWrEQrrqMsFd9eI=;
        b=24CjURl/Ubq311bxngxYul/OH+6+ePzZOzMn9X5TjKn2Bwh1FQE1UBPth+J9h7ck0x
         iq9afGGlybC4tGjyKJVSqDcCHrdb9gYZy9KM1pKjaKlCS0dazyBuNsCxBA1ArgWPvbQQ
         C2dO3Jw8aQmIEbwOsnf1O2hV1T8GwQwOEWq1Gc8rEDT/PTqM4AeUSxK8TRabe8yyNK/D
         nnMU2KX7aaF90ZQcSQG6ZCzABQEekBVt6RPz7KCvXWV5dayqHMEhbd22ODTIkZGTigCd
         UJZstQzd1AcPeN9QYLWI4PGKuSDPqkV+Qm6i5XpQZ60gYz2tcO+DlyuDrJZU6PjjDl2b
         kCYQ==
X-Gm-Message-State: AO0yUKXN/sp13AgLkALVsF91fhCJpzp6vog24bzgiwDCz7CT9VBQUEGs
        U6Ybyf7Vuzx252RdZBJ9NRnLL0mhIpqymaAGvM1zGBvcZv8HPQE5wa+cEagYx0RyKMFwwC7i0mH
        QZiKxMTnb3GVKEY/DHlFz4+5c
X-Received: by 2002:a05:600c:3ca2:b0:3eb:3104:efec with SMTP id bg34-20020a05600c3ca200b003eb3104efecmr33198198wmb.16.1679308770990;
        Mon, 20 Mar 2023 03:39:30 -0700 (PDT)
X-Google-Smtp-Source: AK7set9NBj44qlarRe5btSusjcRWML7XEeQG/k8kSYzk0ECsow+UousrzVViL3IUmOf4g4r58+RnIQ==
X-Received: by 2002:a05:600c:3ca2:b0:3eb:3104:efec with SMTP id bg34-20020a05600c3ca200b003eb3104efecmr33198180wmb.16.1679308770675;
        Mon, 20 Mar 2023 03:39:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003ed1f111fdesm10006176wme.20.2023.03.20.03.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:39:30 -0700 (PDT)
Message-ID: <496d8ba6-dea6-159e-3e98-75d8dee58a12@redhat.com>
Date:   Mon, 20 Mar 2023 11:39:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 10/15] mm: move init_mem_debugging_and_hardening() to
 mm/mm_init.c
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-11-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-11-rppt@kernel.org>
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

On 19.03.23 23:00, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> init_mem_debugging_and_hardening() is only called from mm_core_init().
> 

While at it, maybe rename it to ..._init() like most other such 
functions in there?

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

