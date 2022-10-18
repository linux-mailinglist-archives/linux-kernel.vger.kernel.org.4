Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDD8603353
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJRT1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJRT1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBAE6D56A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666121236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxL/Bf6SKLrPegywa5mvZbcg0E3DOZjONDs0erbS/Hc=;
        b=OK4Q6lcz465NpkqC7Orrex8uWrZbs9NLwQfWU4oSDlix3q0BQPSSRiFwtdDn3wLjHLv5CE
        PJsiD6OerzhTG/Utu1/Nfi72cj897rsff/AtFjq1rraFQjGMBV17gDNGBLvb4iEv3hg0tO
        OmIwjn5jIhAy2VcY9cqHy4fCZETCla8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-577-R_mGlvpFOVCQh6d07qfFSQ-1; Tue, 18 Oct 2022 15:27:14 -0400
X-MC-Unique: R_mGlvpFOVCQh6d07qfFSQ-1
Received: by mail-wr1-f71.google.com with SMTP id g27-20020adfa49b000000b0022cd5476cc7so4898725wrb.17
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxL/Bf6SKLrPegywa5mvZbcg0E3DOZjONDs0erbS/Hc=;
        b=op3xGXQhlPpUT32a+2rxjqs8/jFRZiWG1GYNig871xdbvP8LhheALDyr2dUL6xOi9C
         i9tM+VWUGIinAh/J5hjvXkLBI0cMzQmutPLgeEiPfepry0z3R8AC3KFt4HjW1qWBh+W/
         VGgLBIy2iebDihaiPKr4TnZ40yC/pO1SR38NmxqRnzkSjkQEGGjq+hvYk4tR1N3taV6G
         BJ99aKc/UsfmrIbFU3d2Pl+xRtc6AUAuWgK76Xqzi521NkBunnJ8Y55UT0E6npTTHYsA
         /KNh3ne26Xi/EZCKCTVqmLMGDdoYnkpRJ1KgDkdAA/ibGHU/0V82fUFm1zK2L2zt3CEl
         JiyA==
X-Gm-Message-State: ACrzQf0nagbKdw9HmyjI2BAPM5xPvQi6XhSu95TBDRpJjqHsakwu5fOy
        ABrwAsIki+mSJVHDBEtG6heAvEGTjLdH+BDkX670GCnoWncAcquBDxA/89fdy4ix038zXNDeazT
        qQGWrhpIPKA9/vk8BRWuF5M/I
X-Received: by 2002:a05:6000:4c:b0:22e:48e0:1a0b with SMTP id k12-20020a056000004c00b0022e48e01a0bmr2942722wrx.618.1666121233643;
        Tue, 18 Oct 2022 12:27:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7mSDG/naAfJSJ0Df9p2KGCONJVOnJqCKiClyICizisHUwGeukLCbSuy2fmrf7+95kcJ8RoxQ==
X-Received: by 2002:a05:6000:4c:b0:22e:48e0:1a0b with SMTP id k12-20020a056000004c00b0022e48e01a0bmr2942713wrx.618.1666121233339;
        Tue, 18 Oct 2022 12:27:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:8900:d1f:5430:86b1:31ba? (p200300cbc70589000d1f543086b131ba.dip0.t-ipconnect.de. [2003:cb:c705:8900:d1f:5430:86b1:31ba])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6912000000b00226dedf1ab7sm11489114wru.76.2022.10.18.12.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 12:27:12 -0700 (PDT)
Message-ID: <3da4244a-5a1b-cf34-bf5c-22c199b15cb6@redhat.com>
Date:   Tue, 18 Oct 2022 21:27:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mm/mmap: Fix MAP_FIXED address return on VMA merge
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Liu Zixian <liuzixian4@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221018191613.4133459-1-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221018191613.4133459-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.22 21:17, Liam Howlett wrote:
> mmap should return the start address of newly mapped area when
> successful.  On a successful merge of a VMA, the return address was
> changed and thus was violating that expectation from userspace.
> 

Just wondering, do we have a simple user space reproducer / test?

Do we want to add some more tests for such scenarios?

> This is a restoration of functionality provided by 309d08d9b3a3
> (mm/mmap.c: fix mmap return value when vma is merged after call_mmap()).
> For completeness of fixing MAP_FIXED, implement the comments from the
> previous discussion to never update the address and fail if the address
> changes.  Leaving the error as a WARN_ON() to avoid crashing the kernel.
> 
> Cc: Liu Zixian <liuzixian4@huawei.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Link: https://lore.kernel.org/all/Y06yk66SKxlrwwfb@lakrids/
> Link: https://lore.kernel.org/all/20201203085350.22624-1-liuzixian4@huawei.com/
> Fixes: 4dd1b84140c1 (mm/mmap: use advanced maple tree API for mmap_region())
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   mm/mmap.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 42cd2c260898..22010e13f1a1 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2625,14 +2625,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>   		if (error)
>   			goto unmap_and_free_vma;
>   
> -		/* Can addr have changed??
> -		 *
> -		 * Answer: Yes, several device drivers can do it in their
> -		 *         f_op->mmap method. -DaveM
> +		/*
> +		 * Expansion is handled above, merging is handled below.
> +		 * Drivers should not alter the address of the VMA.
>   		 */
> -		WARN_ON_ONCE(addr != vma->vm_start);
> -
> -		addr = vma->vm_start;
> +		if (WARN_ON((addr != vma->vm_start))) {
> +			error = -EINVAL;
> +			goto close_and_free_vma;
> +		}

If this is something that user space can trigger, WARN_* is the wrong 
choice. But what I understand from the comment change is that this must 
not happen at that point unless there is a real issue.

Why not "if (WARN_ON_ONCE)" ?

-- 
Thanks,

David / dhildenb

