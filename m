Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8071E6376AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKXKoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:44:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20865D92E7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669286592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Y4Whve7954lqLzvpAWCYgQmo37A2Kkr5rk2IyTQcoE=;
        b=E8c+AgyYyG9Ls0069UTqbhwC3nU765LzUKXU6g5QqueFyM5COkubyD35SV52ooJK0tdLOO
        9HGryzP7LlAU9LurSrhk6qP6OB0KNa5gWcmD4eEftCJvP5B2FtgkcMubIMQHz60Vi4u/Xi
        dUh/J5vQuh+HAo+rGjcI7I4tA/Umk2A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-340-XgsFvMtwNmuvVYY9q237Gw-1; Thu, 24 Nov 2022 05:43:10 -0500
X-MC-Unique: XgsFvMtwNmuvVYY9q237Gw-1
Received: by mail-wm1-f69.google.com with SMTP id az40-20020a05600c602800b003cfa26c40easo2700549wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Y4Whve7954lqLzvpAWCYgQmo37A2Kkr5rk2IyTQcoE=;
        b=4I8ntd3iu2D+2y0F/99CHLbeOHDgHvOzj8x2pfgx+MOF7T7ABshNGSLeOP4xRe+NdG
         3KRwIN+nfGtM5dLB31y0nOaWzxyH/fakKFLdUi2xcMj6B36HYW5cstnkYHocCFWYYYtN
         ITETg9etAPxYCpK8v8vvBvYIZQDIL9freMd2avTlvp0Bhkiqi5++QLxKShQcs18zJEE/
         Iy8DdW3BJ2l1Pm9g//vAUgC4FlZKqPrZBuwva/0ElhBUoB/6N0F3B9YI6/KwghXFP+CO
         F0ExmAlLJM/iqHm8++QwKTxNh1Ju8icUgZBzs1WvCfczA2CDqyMuDVJAEWAtCB/CvDx9
         TiKw==
X-Gm-Message-State: ANoB5pmR9uUSRJvthvjjLrqKzLGU9OIvCHjC+xeo1Y3K2o/9g6ffaZr/
        uFVmhrNJzC5FGX4N0zMkZ9mSTDBhB7ExqzI857nloC/omy088MQsdmvwJm7qZHbMhL4kxFMfRZ7
        piNZA9gQP9Wfi0wwe7yGTHZ3C
X-Received: by 2002:a1c:7219:0:b0:3cf:77b7:61e6 with SMTP id n25-20020a1c7219000000b003cf77b761e6mr11909983wmc.162.1669286589466;
        Thu, 24 Nov 2022 02:43:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4yATwvqcAiRSd2ogA9zvNkwcQpJPUOYsq2REuxCRQmJ2yu8iducuNJCkm3pbdnmx9zR7q5cQ==
X-Received: by 2002:a1c:7219:0:b0:3cf:77b7:61e6 with SMTP id n25-20020a1c7219000000b003cf77b761e6mr11909958wmc.162.1669286589138;
        Thu, 24 Nov 2022 02:43:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:2200:bfcb:7212:1370:de13? (p200300cbc7042200bfcb72121370de13.dip0.t-ipconnect.de. [2003:cb:c704:2200:bfcb:7212:1370:de13])
        by smtp.gmail.com with ESMTPSA id q10-20020a05600c46ca00b003c6bd91caa5sm1397502wmo.17.2022.11.24.02.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 02:43:08 -0800 (PST)
Message-ID: <31bda0ab-a185-340d-b96b-b1cfed7c3910@redhat.com>
Date:   Thu, 24 Nov 2022 11:43:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, ziy@nvidia.com,
        kirill.shutemov@linux.intel.com, zhenyzha@redhat.com,
        apopple@nvidia.com, hughd@google.com, willy@infradead.org,
        shan.gavin@gmail.com
References: <20221124095523.31061-1-gshan@redhat.com>
 <3c584ce6-dc8c-e0e4-c78f-b59dfff1fc13@redhat.com>
 <22407f18-0406-6ede-ef1e-592f03d3699e@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm: migrate: Fix THP's mapcount on isolation
In-Reply-To: <22407f18-0406-6ede-ef1e-592f03d3699e@redhat.com>
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

On 24.11.22 11:21, Gavin Shan wrote:
> On 11/24/22 6:09 PM, David Hildenbrand wrote:
>> On 24.11.22 10:55, Gavin Shan wrote:
>>> The issue is reported when removing memory through virtio_mem device.
>>> The transparent huge page, experienced copy-on-write fault, is wrongly
>>> regarded as pinned. The transparent huge page is escaped from being
>>> isolated in isolate_migratepages_block(). The transparent huge page
>>> can't be migrated and the corresponding memory block can't be put
>>> into offline state.
>>>
>>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>>> the transparent huge page can be isolated and migrated, and the memory
>>> block can be put into offline state. Besides, The page's refcount is
>>> increased a bit earlier to avoid the page is released when the check
>>> is executed.
>>
>> Did you look into handling pages that are in the swapcache case as well?
>>
>> See is_refcount_suitable() in mm/khugepaged.c.
>>
>> Should be easy to reproduce, let me know if you need inspiration.
>>
> 
> Nope, I didn't look into the case. Please elaborate the details so that
> I can reproduce it firstly.


A simple reproducer would be (on a system with ordinary swap (not zram))

1) mmap a region (MAP_ANON|MAP_PRIVATE) that can hold a THP

2) Enable THP for that region (MADV_HUGEPAGE)

3) Populate a THP (e.g., write access)

4) PTE-map the THP, for example, using MADV_FREE on the last subpage

5) Trigger swapout of the THP, for example, using MADV_PAGEOUT

6) Read-access to some subpages to fault them in from the swapcache


Now you'd have a THP, which

1) Is partially PTE-mapped into the page table
2) Is in the swapcache (each subpage should have one reference from the 
swapache)


Now we could test, if alloc_contig_range() will still succeed (e.g., 
using virtio-mem).

-- 
Thanks,

David / dhildenb

