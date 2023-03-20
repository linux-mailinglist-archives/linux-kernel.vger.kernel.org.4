Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54266C1F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCTSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCTSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739F033CE4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679335773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0M2onYRimpS4fQHcg/GJxOJ+N2LxWQ9gB2aulwOb8zU=;
        b=QfWl1zOudNbUttxjnHP/SR58etmcyXRJHJyfLR06tVVRj9b8j249WeZNWcRAZWPx7Kzr7S
        UbtIDR4RyjYebvo0yDTHYOBgRH0qaA6pEIvlXeo4Giyf+uUMeZOCw8IK4z5h+Y/P1gA9k1
        76Ar38fwa9ZVt/Wtrbzo23C3nN7CMDc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-bx6jFcOUP0-gNgVfI74T2A-1; Mon, 20 Mar 2023 13:52:36 -0400
X-MC-Unique: bx6jFcOUP0-gNgVfI74T2A-1
Received: by mail-lf1-f72.google.com with SMTP id i16-20020ac25b50000000b004b565e69540so4716309lfp.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334755;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0M2onYRimpS4fQHcg/GJxOJ+N2LxWQ9gB2aulwOb8zU=;
        b=nGJ6+oU1xOkm0USPUo8FJCFoAyzeJ0TR2Ey2vNmhMmF5+lNVdpiFy1lYhKPhW7XayQ
         v33TL9K2B0B3pXXLW+1oKoFpNJolzXY0EKt2G+TQyfaMOyFAKFTssfbZDptnuH5oPTvB
         tqyoPe73btpBf7slXo+cc8amxLeW+fqd5rKcchUj7kkY9c8m88W1eRx7FjZvckyo8KA9
         p5ykQRt0tjmeBMGg9RduiVuAwq0iND+8UE6J92C+G8+UMzkp+jr5QtNINIWAzs5mhjlU
         eAa7UhlXnaiHp4zP/J+/QfuQG+z82D2jblLIiwFO7vnj9RhJrwSX5bM1roxYflkLXKI6
         ookA==
X-Gm-Message-State: AO0yUKVdgha8XGO0epcsJPcyFVS3zBEz6kKvvPbt5abtfK/lsv7dPYIA
        7nk81tocBY1YWgwPRWw07t3ml4KIPVgGySXLHGdBEnoFY34vh+MTl0gENGj3xB+Pv/9L63iIZH+
        K8VnMKRYOCOH9RJJJU9V01zh2
X-Received: by 2002:ac2:53aa:0:b0:4db:1b97:13 with SMTP id j10-20020ac253aa000000b004db1b970013mr234557lfh.54.1679334755336;
        Mon, 20 Mar 2023 10:52:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set/U9afes6kp2FQn3o+j3mAfQ6V4UcAbA0HnKvvF8tIfZ+eOE36u6nPlkKIZrUlBi6C8am7hyA==
X-Received: by 2002:ac2:53aa:0:b0:4db:1b97:13 with SMTP id j10-20020ac253aa000000b004db1b970013mr234551lfh.54.1679334754978;
        Mon, 20 Mar 2023 10:52:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id g5-20020a2e9385000000b002959d2cc975sm1844472ljh.37.2023.03.20.10.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:52:34 -0700 (PDT)
Message-ID: <0d0fb7be-a886-bd05-b14a-a15633f60908@redhat.com>
Date:   Mon, 20 Mar 2023 18:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: THP backed thread stacks
Content-Language: en-US
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230306235730.GA31451@monkey>
 <ZBSo+mLUOsKvy3rC@casper.infradead.org> <20230317184632.GA69459@monkey>
 <655ca9fd-ddc3-0bfa-b442-fc60cda02baa@redhat.com>
 <4A61B05E-62C6-4BC1-9301-CF12FC5A252F@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4A61B05E-62C6-4BC1-9301-CF12FC5A252F@oracle.com>
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

On 20.03.23 18:46, William Kucharski wrote:
> 
> 
>> On Mar 20, 2023, at 05:12, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 17.03.23 19:46, Mike Kravetz wrote:
>>> On 03/17/23 17:52, Matthew Wilcox wrote:
>>>> On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
>>>>> One of our product teams recently experienced 'memory bloat' in their
>>>>> environment.  The application in this environment is the JVM which
>>>>> creates hundreds of threads.  Threads are ultimately created via
>>>>> pthread_create which also creates the thread stacks.  pthread attributes
>>>>> are modified so that stacks are 2MB in size.  It just so happens that
>>>>> due to allocation patterns, all their stacks are at 2MB boundaries.  The
>>>>> system has THP always set, so a huge page is allocated at the first
>>>>> (write) fault when libpthread initializes the stack.
>>>>
>>>> Do you happen to have an strace (or similar) so we can understand what
>>>> the application is doing?
>>>>
>>>> My understanding is that for a normal app (like, say, 'cat'), we'll
>>>> allow up to an 8MB stack, but we only create a VMA that is 4kB in size
>>>> and set the VM_GROWSDOWN flag on it (to allow it to magically grow).
>>>> Therefore we won't create a 2MB page because the VMA is too small.
>>>>
>>>> It sounds like the pthread library is maybe creating a 2MB stack as
>>>> a 2MB VMA, and that's why we're seeing this behaviour?
>>> Yes, pthread stacks create a VMA equal to stack size which is different
>>> than 'main thread' stack.  The 2MB size for pthread stacks created by
>>> JVM is actually them explicitly requesting the size (8MB default).
>>> We have a good understanding of what is happening.  Behavior actually
>>> changed a bit with glibc versions in OL7 vs OL8.  Do note that THP usage
>>> is somewhat out of the control of an application IF they rely on
>>> glibc/pthread to allocate stacks.  Only way for application to make sure
>>> pthread stacks do not use THP would be for them to allocate themselves.
>>> Then, they would need to set up the guard page themselves.  They would
>>> also need to monitor the status of all threads to determine when stacks
>>> could be deleted.  A bunch of extra code that glibc/pthread already does
>>> for free.
>>> Oracle glibc team is also involved, and it 'looks' like they may have
>>> upstream buy in to add a flag to explicitly enable or disable hugepages
>>> on pthread stacks.
>>> It seems like concensus from mm community is that we should not
>>> treat stacks any differently than any other mappings WRT THP.  That is
>>> OK, just wanted to throw it out there.
>>
>> I wonder if this might we one of the cases where we don't want to allocate a THP on first access to fill holes we don't know if they are all going to get used. But we might want to let khugepaged place a THP if all PTEs are already populated. Hm.
>>
>> -- 
>> Thanks,
>>
>> David / dhildenb
> 
> Unless we do decide to start honoring MAP_STACK, we would be setting an interesting precedent here in that stacks would be the only THP allocation that would be denied a large page until it first proved it was actually going to use all the individual PAGESIZE pages comprising one. Should mapping a text page using a THP be likewise deferred until each PAGESIZE page comprising it had been accessed?

IMHO, it's a bit different, because text pages are not anon pages.

I suspect is_stack_mapping() -> VM_STACK -> VM_GROWSUP/VM_GROWSDOWN is 
not always reliable?

-- 
Thanks,

David / dhildenb

