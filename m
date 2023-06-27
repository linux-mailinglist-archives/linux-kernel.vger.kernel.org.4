Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7260773FC99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjF0NPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0NPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2294C171A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687871658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xr3MnWCaYQoh+mxzisQXAS9kK17MGURfaRMV8GgA6To=;
        b=a1e5m2VNhcEaOC5RJURohnOm0pVAi9ct8HSQy7aw6Uih/QZz0L6xUP5DqzNYVwwhFMLd4p
        Ko8FZStJHNYzlHVKnPjsU77OJGj4xMDTYIiYA/GXTttIaXLpp9c/dQDcfuqSse47HISZHM
        V5bYZtrgSJr6x32krzZOFpCih7SACl8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-uycb2uHENNGiD50FdMO1ag-1; Tue, 27 Jun 2023 09:14:15 -0400
X-MC-Unique: uycb2uHENNGiD50FdMO1ag-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbab56aac7so260585e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687871653; x=1690463653;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xr3MnWCaYQoh+mxzisQXAS9kK17MGURfaRMV8GgA6To=;
        b=NhrUUambRkuPHquFlqEA5ZbmGdT3NSIkYAXcAbj4Fz6T39FbvIEYAp8+g32Gx5PXJh
         T2YBbkihxobcYocLb3oTq4xgaYZ1SvYwn+9gLDIpBuUwLK195Xkl++kTXCsTtYxGIniT
         s/yVrAxpaCJSb7aFrkg2tGbedftxWxnwimYAfnJpBdyjjcyGUDpYvRMfkYK+gXj/B2En
         mkKmscMQeTcnIVq1+nhFVeCZFwXI+jzt7s2U6MjmOzA0W9Wjghs4in7RO4zQc1i9ijMy
         Y520QTa5PPcscYq1HjjX0FBlAnUYFzWOBCyQqpoYafW0G0f49NbeCTbWsgciVaYvLg4/
         x3vA==
X-Gm-Message-State: AC+VfDy7IxtgpxfGWbTy0B/WVE2qk9nbGFopLs5h/spjFyZC5H+HeKmS
        umx9u4KxgYSEhSPNCnuby2ynZUnlOJW/rvT7RJ3W6Z8oBGFNeS3Z+tL0WvR9CclQ8xi4R6NRoLd
        cIm4eGpj5+whH2B1MGhXA2MYR
X-Received: by 2002:a7b:c017:0:b0:3f7:aad8:4e05 with SMTP id c23-20020a7bc017000000b003f7aad84e05mr25894504wmb.11.1687871653449;
        Tue, 27 Jun 2023 06:14:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6jPe2n9lCZVjh6G47APR7hQm7cv3dmFUt5cTIyprmkTo8/GF2dG+yghkrXAmZXtcjVtznmIQ==
X-Received: by 2002:a7b:c017:0:b0:3f7:aad8:4e05 with SMTP id c23-20020a7bc017000000b003f7aad84e05mr25894478wmb.11.1687871653032;
        Tue, 27 Jun 2023 06:14:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b? (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de. [2003:cb:c737:4900:68b3:e93b:e07a:558b])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c378b00b003fa95f328afsm6173913wmr.29.2023.06.27.06.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 06:14:12 -0700 (PDT)
Message-ID: <74cbbdd3-5a05-25b1-3f81-2fd47e089ac3@redhat.com>
Date:   Tue, 27 Jun 2023 15:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230627112220.229240-1-david@redhat.com>
 <20230627112220.229240-4-david@redhat.com> <ZJrYv0JIcrNyf2py@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/5] mm/memory_hotplug: make
 offline_and_remove_memory() timeout instead of failing on fatal signals
In-Reply-To: <ZJrYv0JIcrNyf2py@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.23 14:40, Michal Hocko wrote:
> On Tue 27-06-23 13:22:18, David Hildenbrand wrote:
>> John Hubbard writes [1]:
>>
>>          Some device drivers add memory to the system via memory hotplug.
>>          When the driver is unloaded, that memory is hot-unplugged.
>>
>>          However, memory hot unplug can fail. And these days, it fails a
>>          little too easily, with respect to the above case. Specifically, if
>>          a signal is pending on the process, hot unplug fails.
>>
>>          [...]
>>
>>          So in this case, other things (unmovable pages, un-splittable huge
>>          pages) can also cause the above problem. However, those are
>>          demonstrably less common than simply having a pending signal. I've
>>          got bug reports from users who can trivially reproduce this by
>>          killing their process with a "kill -9", for example.
> 
> This looks like a bug of the said driver no? If the tear down process is
> killed it could very well happen right before offlining so you end up in
> the very same state. Or what am I missing?

IIUC (John can correct me if I am wrong):

1) The process holds the device node open
2) The process gets killed or quits
3) As the process gets torn down, it closes the device node
4) Closing the device node results in the driver removing the device and
    calling offline_and_remove_memory()

So it's not a "tear down process" that triggers that offlining_removal 
somehow explicitly, it's just a side-product of it letting go of the 
device node as the process gets torn down.

>   
>> Especially with ZONE_MOVABLE, offlining is supposed to work in most
>> cases when offlining actually hotplugged (not boot) memory, and only fail
>> in rare corner cases (e.g., some driver holds a reference to a page in
>> ZONE_MOVABLE, turning it unmovable).
>>
>> In these corner cases we really don't want to be stuck forever in
>> offline_and_remove_memory(). But in the general cases, we really want to
>> do our best to make memory offlining succeed -- in a reasonable
>> timeframe.
>>
>> Reliably failing in the described case when there is a fatal signal pending
>> is sub-optimal. The pending signal check is mostly only relevant when user
>> space explicitly triggers offlining of memory using sysfs device attributes
>> ("state" or "online" attribute), but not when coming via
>> offline_and_remove_memory().
>>
>> So let's use a timer instead and ignore fatal signals, because they are
>> not really expressive for offline_and_remove_memory() users. Let's default
>> to 30 seconds if no timeout was specified, and limit the timeout to 120
>> seconds.
> 
> I really hate having timeouts back. They just proven to be hard to get
> right and it is essentially a policy implemented in the kernel. They
> simply do not belong to the kernel space IMHO.

As much as I agree with you in terms of offlining triggered from user 
space (e.g., write "state" or "online" attribute) where user-space is 
actually in charge  and can do something reasonable (timeout, retry, 
whatever), in these the offline_and_remove_memory() case it's the driver 
that wants a best-effort memory offlining+removal.

If it times out, virtio-mem will simply try another block or retry 
later. Right now, it could get stuck forever in 
offline_and_remove_memory(), which is obviously "not great". 
Fortunately, for virtio-mem it's configurable and we use the 
alloc_contig_range()-method for now as default.

If it would time out for John's driver, we most certainly don't want to 
be stuck in offline_and_remove_memory(), blocking device/driver 
unloading (and even a reboot IIRC) possibly forever.


I much rather have offline_and_remove_memory() indicate "timeout" to a 
in-kernel user a bit earlier than getting stuck in there forever. The 
timeout parameter allows for giving the in-kernel users a bit of 
flexibility, which I showcases for virtio-mem that unplugs smaller 
blocks and rather wants to fail fast and retry later.


Sure, we could make the timeout configurable to optimize for some corner 
cases, but that's not really what offline_and_remove_memory() users want 
and I doubt anybody would fine-tune that: they want a best-effort 
attempt. And that's IMHO not really a policy, it's an implementation 
detail of these drivers.

For example, the driver from John could simply never call 
offline_and_remove_memory() and always require a reboot when wanting to 
reuse a device. But that's definitely what users want.

virtio-mem could simply never call offline_and_remove_memory() and 
indicate "I don't support unplug of these online memory blocks". But 
that's *definitely* not what users want.


I'm very open for alternatives regarding offline_and_remove_memory(), so 
far this was the only reasonable thing I could come up with that 
actually achieves what we want for these users: not get stuck in there 
forever but rather fail earlier than later.

And most importantly, not somehow try to involve user space that isn't 
even in charge of the offlining operation.

-- 
Cheers,

David / dhildenb

