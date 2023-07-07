Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E909B74B2CB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjGGOKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjGGOJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E7826A1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688738869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlC2iXIzLQA3lWZwQgQsQkPg2mfqo3LAJWALzfWOUOw=;
        b=FSOhCULsW1PoI8wt2luQAd936ggfa2iGBk/LUym4hEo6AU4lRUX0uWEzy9U/3FozfqPBwZ
        jGbki0t0yODQzaZPjRTGGULs3oXUd62mhYeDDlqzZGERxx5rbY39FxYwV4gz80Xa34jy4j
        OF6OcmVIgrBVfIREpWiKtfRMn2vCbL0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-eR8Kgra2OKS16E-aPA8L0w-1; Fri, 07 Jul 2023 10:07:48 -0400
X-MC-Unique: eR8Kgra2OKS16E-aPA8L0w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3faabd8fd33so11611555e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738867; x=1691330867;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlC2iXIzLQA3lWZwQgQsQkPg2mfqo3LAJWALzfWOUOw=;
        b=K3QMEAJNmT2SRSFWhJVm5ykBA3Hy3IS2YDLYlmiIFn9JbOEOwo5yT+EWbsCe3XC2g3
         gT4EK3ghU3qyxFvsQ3oBl+za3o9EV40F0HBE/tZhPQKoJZSODMmBeP7YzNYzmN3ZR18m
         KXr5BYbDJSXxxhNAvJlpWmc5h/gS+6QJbmod+8a4CoLxz1t8xiQwDI0C2T5yNZR+4gQZ
         lidiqjDom9ym3zT7LabHL4eMU7BGp/Z9iJV1UStkyHHfGoXrQLOSDdIX/M8K8t7gmh8q
         1wutOPK5y93cRjpTbJX88UrtTIsIXamTxzZl/fGainMk75B6gXQ8x/3ITM4QalRnoIui
         CNTw==
X-Gm-Message-State: ABy/qLYyZoI/NkRarv/AkQ7YqwS8ownHYDvxhF6A8xyA3QaF5wgpXqN8
        KcjZEuDLaeG+Vw9w+nYb04/Sghs8Mor1ndkOZD+0w97cYDZCk2xzF8Mx0mSEuhO7mxYWTY6BpNc
        8LXNjJTbdUnylNM/Y2tWlw6AV
X-Received: by 2002:a1c:4c09:0:b0:3f8:f1db:d206 with SMTP id z9-20020a1c4c09000000b003f8f1dbd206mr4038596wmf.25.1688738867022;
        Fri, 07 Jul 2023 07:07:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFyKYecEsefKx61xe08GTcuK37noRkMqXHT3eR9Z1Eg7QLfbEP9g0GcKdt4S/xrCRjDAxDhEg==
X-Received: by 2002:a1c:4c09:0:b0:3f8:f1db:d206 with SMTP id z9-20020a1c4c09000000b003f8f1dbd206mr4038581wmf.25.1688738866619;
        Fri, 07 Jul 2023 07:07:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003f819faff24sm2584225wmi.40.2023.07.07.07.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 07:07:46 -0700 (PDT)
Message-ID: <1e406f04-78ef-6573-e1f1-f0d0e0d5246a@redhat.com>
Date:   Fri, 7 Jul 2023 16:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <87edlkgnfa.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e60630-5e9d-c8df-ab79-cb0767de680e@arm.com>
 <524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com>
 <ZKgZrNuxuq4ACvIb@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
In-Reply-To: <ZKgZrNuxuq4ACvIb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.23 15:57, Matthew Wilcox wrote:
> On Fri, Jul 07, 2023 at 01:29:02PM +0200, David Hildenbrand wrote:
>> On 07.07.23 11:52, Ryan Roberts wrote:
>>> On 07/07/2023 09:01, Huang, Ying wrote:
>>>> Although we can use smaller page order for FLEXIBLE_THP, it's hard to
>>>> avoid internal fragmentation completely.  So, I think that finally we
>>>> will need to provide a mechanism for the users to opt out, e.g.,
>>>> something like "always madvise never" via
>>>> /sys/kernel/mm/transparent_hugepage/enabled.  I'm not sure whether it's
>>>> a good idea to reuse the existing interface of THP.
>>>
>>> I wouldn't want to tie this to the existing interface, simply because that
>>> implies that we would want to follow the "always" and "madvise" advice too; That
>>> means that on a thp=madvise system (which is certainly the case for android and
>>> other client systems) we would have to disable large anon folios for VMAs that
>>> haven't explicitly opted in. That breaks the intention that this should be an
>>> invisible performance boost. I think it's important to set the policy for use of
>>
>> It will never ever be a completely invisible performance boost, just like
>> ordinary THP.
>>
>> Using the exact same existing toggle is the right thing to do. If someone
>> specify "never" or "madvise", then do exactly that.
>>
>> It might make sense to have more modes or additional toggles, but
>> "madvise=never" means no memory waste.
> 
> I hate the existing mechanisms.  They are an abdication of our
> responsibility, and an attempt to blame the user (be it the sysadmin
> or the programmer) of our code for using it wrongly.  We should not
> replicate this mistake.

I don't agree regarding the programmer responsibility. In some cases the 
programmer really doesn't want to get more memory populated than 
requested -- and knows exactly why setting MADV_NOHUGEPAGE is the right 
thing to do.

Regarding the madvise=never/madvise/always (sys admin decision), memory 
waste (and nailing down bugs or working around them in customer setups) 
have been very good reasons to let the admin have a word.

> 
> Our code should be auto-tuning.  I posted a long, detailed outline here:
> https://lore.kernel.org/linux-mm/Y%2FU8bQd15aUO97vS@casper.infradead.org/
> 

Well, "auto-tuning" also should be perfect for everybody, but once 
reality strikes you know it isn't.

If people don't feel like using THP, let them have a word. The "madvise" 
config option is probably more controversial. But the "always vs. never" 
absolutely makes sense to me.

>> I remember I raised it already in the past, but you *absolutely* have to
>> respect the MADV_NOHUGEPAGE flag. There is user space out there (for
>> example, userfaultfd) that doesn't want the kernel to populate any
>> additional page tables. So if you have to respect that already, then also
>> respect MADV_HUGEPAGE, simple.
> 
> Possibly having uffd enabled on a VMA should disable using large folios,

There are cases where we enable uffd *after* already touching memory 
(postcopy live migration in QEMU being the famous example). That doesn't 
fly.

> I can get behind that.  But the notion that userspace knows what it's
> doing ... hahaha.  Just ignore the madvise flags.  Userspace doesn't
> know what it's doing.

If user space sets MADV_NOHUGEPAGE, it exactly knows what it is doing 
... in some cases. And these include cases I care about messing with 
sparse VM memory :)

I have strong opinions against populating more than required when user 
space set MADV_NOHUGEPAGE.

-- 
Cheers,

David / dhildenb

