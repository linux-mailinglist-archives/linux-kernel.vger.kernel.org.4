Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4673B600E70
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJQMAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJQMAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FDF2BB0C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666008020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxoTaA3aAU+JEFWVUqidohd5Zr4kZ2taV7k83eKc06o=;
        b=LXsD8fxoTGjgGQ/+o8RWPzmikLH0D6danpYmV7altpZ6uNJDXsaNjTwL5tY8Hdab07xEeG
        g6DW+dwfAirs5CJSbnfFb5wm6ArQbwiXEFuMH986cQ7Ned37aoI1yxLclu7x9VDHSnf5M/
        X5p1B+SIbFZ+JU8zAcNAIuAn3Z8zD8Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-OPUeUVKTNOiNT6i-WCW5Tw-1; Mon, 17 Oct 2022 08:00:19 -0400
X-MC-Unique: OPUeUVKTNOiNT6i-WCW5Tw-1
Received: by mail-wm1-f72.google.com with SMTP id c130-20020a1c3588000000b003b56be513e1so7546792wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxoTaA3aAU+JEFWVUqidohd5Zr4kZ2taV7k83eKc06o=;
        b=EnXFXgmTov4IIM7pLi06uEsRbWocQWhN9q4XaDm8l8VLiME8yiJCmMNXocOzfD7KLU
         itYXeGV3fmqBCSTKp0BRSdqc2KgRNyr484xCR2GpJHilevuixnPQDMQ0pKSModMewgi8
         DBBY+q0dzC3ajyZGqxUNVADkfVyyEFDY2UKGOS+8Rzxl11rXHEk6CX0O7TWqvVlWaxH0
         5Tu5Sy0EW/8fUZNA8KROI6zZZ0WMOpK4Z4iI9Nkr1ZKq80JH9WF674GPUvjW1b6YHAKm
         Gk9Cr8h8OWmOf7PpkLWNQYy0VYMfYDGzouM3DKaP/gv5q3lX8d7S8Kdd7wzjJ3pe1Pau
         wmOA==
X-Gm-Message-State: ACrzQf31CedNWHTrBsA/xEK5R8T0XE8RUkd6nvYeyBJCtBfduNcrXew9
        /9VY9ksco0izbMyzQgMVxbMiPEWKKnXE4odCOeCwx64+3QM6ZXhwe0e6qFWf5DVnGNrZEMPlf1Q
        GvMSK35OjN3gOyHbFZsjhzusY
X-Received: by 2002:a05:600c:4f46:b0:3c6:fb4f:3e1b with SMTP id m6-20020a05600c4f4600b003c6fb4f3e1bmr954049wmq.159.1666008017722;
        Mon, 17 Oct 2022 05:00:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4jPZhzKuT9Xgg13Oq9eRn8xtKtH5nKGWOaDs8rN+27eJONFyIUXsIK9D8gg1aprd4F/eX3Yg==
X-Received: by 2002:a05:600c:4f46:b0:3c6:fb4f:3e1b with SMTP id m6-20020a05600c4f4600b003c6fb4f3e1bmr954026wmq.159.1666008017420;
        Mon, 17 Oct 2022 05:00:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:a00:37ed:519:6c33:4dc8? (p200300cbc70a0a0037ed05196c334dc8.dip0.t-ipconnect.de. [2003:cb:c70a:a00:37ed:519:6c33:4dc8])
        by smtp.gmail.com with ESMTPSA id o39-20020a05600c512700b003b4ff30e566sm27615771wms.3.2022.10.17.05.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 05:00:16 -0700 (PDT)
Message-ID: <03b90a2f-2854-6e19-6ccd-41f9933d8813@redhat.com>
Date:   Mon, 17 Oct 2022 14:00:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [External] Re: [PATCH] mm: hugetlb: support get/set_policy for
 hugetlb_vm_ops
Content-Language: en-US
To:     =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc:     songmuchun@bytedance.com, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221012081526.73067-1-huangjie.albert@bytedance.com>
 <2aaf2c3a-6e49-abb9-b9c8-19ce87404982@redhat.com>
 <CABKxMyOnxiS6RsJtQEQPrnzNn-cO0Z+OGJRCUpw1M4=WANx0Dw@mail.gmail.com>
 <2f41fc4c-68eb-ab7d-970b-fcb10f474fd4@redhat.com>
 <CABKxMyO4RvEx===iYr_m2dfB0mtUTqt8A3WEuJn4Dq7r_NNM3w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CABKxMyO4RvEx===iYr_m2dfB0mtUTqt8A3WEuJn4Dq7r_NNM3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.22 13:46, 黄杰 wrote:
> David Hildenbrand <david@redhat.com> 于2022年10月17日周一 19:33写道：
>>
>> On 17.10.22 11:48, 黄杰 wrote:
>>> David Hildenbrand <david@redhat.com> 于2022年10月17日周一 16:44写道：
>>>>
>>>> On 12.10.22 10:15, Albert Huang wrote:
>>>>> From: "huangjie.albert" <huangjie.albert@bytedance.com>
>>>>>
>>>>> implement these two functions so that we can set the mempolicy to
>>>>> the inode of the hugetlb file. This ensures that the mempolicy of
>>>>> all processes sharing this huge page file is consistent.
>>>>>
>>>>> In some scenarios where huge pages are shared:
>>>>> if we need to limit the memory usage of vm within node0, so I set qemu's
>>>>> mempilciy bind to node0, but if there is a process (such as virtiofsd)
>>>>> shared memory with the vm, in this case. If the page fault is triggered
>>>>> by virtiofsd, the allocated memory may go to node1 which  depends on
>>>>> virtiofsd.
>>>>>
>>>>
>>>> Any VM that uses hugetlb should be preallocating memory. For example,
>>>> this is the expected default under QEMU when using huge pages.
>>>>
>>>> Once preallocation does the right thing regarding NUMA policy, there is
>>>> no need to worry about it in other sub-processes.
>>>>
>>>
>>> Hi, David
>>> thanks for your reminder
>>>
>>> Yes, you are absolutely right, However, the pre-allocation mechanism
>>> does solve this problem.
>>> However, some scenarios do not like to use the pre-allocation mechanism, such as
>>> scenarios that are sensitive to virtual machine startup time, or
>>> scenarios that require
>>> high memory utilization. The on-demand allocation mechanism may be better,
>>> so the key point is to find a way support for shared policy。
>>
>> Using hugetlb -- with a fixed pool size -- without preallocation is like
>> playing with fire. Hugetlb reservation makes one believe that on-demand
>> allocation is going to work, but there are various scenarios where that
>> can go seriously wrong, and you can run out of huge pages.
>>
>> If you're using hugetlb as memory backend for a VM without
>> preallocation, you really have to be very careful. I can only advise
>> against doing that.
>>
>>
>> Also: why does another process read/write *first* to a guest physical
>> memory location before the OS running inside the VM even initialized
>> that memory? That sounds very wrong. What am I missing?
>>
> 
> for example : virtio ring buffer.
> For the avial descriptor, the guest kernel only gives an address to
> the backend,
> and does not actually access the memory.

Okay, thanks. So we're essentially providing uninitialized memory to a 
device? Hm, that implies that the device might have access to memory 
that was previously used by someone else ... not sure how to feel about 
that, but maybe this is just the way of doing things.

The "easy" user-space fix would be to simply similarly mbind() in  the 
other processes where we mmap(). Has that option been explored?

-- 
Thanks,

David / dhildenb

