Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FEF6962A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjBNLtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjBNLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:49:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B53C23858
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676375304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be80ZoWuaklp3ZzQGAhtuohVjBs8d2e/hxh/6X7AdKY=;
        b=YBc63lmdx0jwCMbGZ7x9Urbn/3wFeugj1WGC/+Y297OvVdzOhL68QeBwQrKgy5y6sSffAu
        47/7MqKJEjS18+1R2t6/OKz5QLtjMEsdbqGngr0RQcj9LHbOM95HO3Yd5NTnYwme/lYN0T
        UuGBjeLPUPe6BNu2BLq3DM2V++54+M4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-398-ZOUrCFdjPxajnyiHjFeFhg-1; Tue, 14 Feb 2023 06:48:22 -0500
X-MC-Unique: ZOUrCFdjPxajnyiHjFeFhg-1
Received: by mail-wm1-f71.google.com with SMTP id r14-20020a05600c35ce00b003e10bfcd160so8504423wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=be80ZoWuaklp3ZzQGAhtuohVjBs8d2e/hxh/6X7AdKY=;
        b=Fevh9A0NgrNp1lI1imX5lhRomlJxu00rGWiWlQiNT9rEN7KlrB0Z29aMNbMS1AgIaN
         kYN/aM39fuW+QyZfNEyG3ilthZ024N2Ete/VxDsEZk02G9P02mnS0OfMLavgZxuSrMYq
         VVslsaPhrrXmCrn8OrrvSvOqYMv90Ysvu5c+uxdjriHTodXIOEnVuDqjplbhp4rf/Adk
         7zjIu3p591hE4AhSi1VfvgMg6t5xjasoNCLXkPsVHicjcT4oXwZVnuFx3kkBowEAE0Vo
         UzNmig17tvjr7E3/Jf//wWPl8JurWjqE6eYd5+U2rvnWolCljkSkRc+p4wON9sD6nVBj
         t8EQ==
X-Gm-Message-State: AO0yUKUnJphBNGeoOxQTVw6SOA7aCOKZOCcoP+Yd+QyemHx0YobHpqM9
        1+B9YmGjEXxd/RuJfw1U4xT4Viy6755M5xpR9HaAv01U97VvfFaSPlfYUgST2LUS5eRmxRpedD4
        Uiomxmjkcpe5HjsDUp9vk4o6Q
X-Received: by 2002:a05:600c:2e87:b0:3dc:57e8:1d2f with SMTP id p7-20020a05600c2e8700b003dc57e81d2fmr1677309wmn.9.1676375301306;
        Tue, 14 Feb 2023 03:48:21 -0800 (PST)
X-Google-Smtp-Source: AK7set8XXhIQBpVYXdiJ+DtNnclCA+VVj5+4PdHf37RILLSy/PCu8jst2nXBwf2VYLoYVwBv4H2Lng==
X-Received: by 2002:a05:600c:2e87:b0:3dc:57e8:1d2f with SMTP id p7-20020a05600c2e8700b003dc57e81d2fmr1677291wmn.9.1676375301063;
        Tue, 14 Feb 2023 03:48:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b003dfe549da4fsm19625873wmi.18.2023.02.14.03.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:48:20 -0800 (PST)
Message-ID: <a7f8be91-32c1-bfbe-7e81-5b1e818ba01d@redhat.com>
Date:   Tue, 14 Feb 2023 12:48:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Qi Zheng <arch0.zheng@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
 <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
 <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
 <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
 <Y+tXrK/g1Nrd/q1h@kernel.org>
 <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
 <Y+t0Bhu7BCzH2Dp4@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y+t0Bhu7BCzH2Dp4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.23 12:44, Mike Rapoport wrote:
> (added x86 folks)
> 
> On Tue, Feb 14, 2023 at 12:29:42PM +0100, David Hildenbrand wrote:
>> On 14.02.23 12:26, Qi Zheng wrote:
>>> On 2023/2/14 19:22, David Hildenbrand wrote:
>>>>
>>>> TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a
>>>> pretty x86 specific thing.
>>>>
>>>> Are we sure we want to get NODE_MIN_SIZE involved?
>>>
>>> Maybe add an arch_xxx() to handle it?
>>
>> I still haven't figured out what we want to achieve with NODE_MIN_SIZE at
>> all. It smells like an arch-specific hack looking at
>>
>> "Don't confuse VM with a node that doesn't have the minimum amount of
>> memory"
>>
>> Why shouldn't mm-core deal with that?
> 
> Well, a node with <4M RAM is not very useful and bears all the overhead of
> an extra live node.

And totally not with 4.1M, haha.

I really like the "Might fix boot" in the commit description.

> 
> But, hey, why won't we just drop that '< NODE_MIN_SIZE' and let people with
> weird HW configurations just live with this?


;)

-- 
Thanks,

David / dhildenb

