Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3704602878
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJRJfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJRJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136F71C901
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666085720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9aL/XJR8EJ0pRD4xfXjlEdra6nq4SqKP4CXxDvLcpoE=;
        b=IYsjjU/t6e0BlUB8f3Wq/31rE2a32aoZVrzFcjqKPMLGH/hIgek4kN8ImY8dD4l1o43BnH
        YA80pJ2T0nduV7RlvUkWGjFfUyJewf92jisgPYIbhQ5DvUDzlJAyC4D3NRSLkYifgGmwop
        hvMf2ZHuupMz8VewKVF4jhBQYYcMHAE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-z7ljy5NNNGCug0uMxvGm3w-1; Tue, 18 Oct 2022 05:35:18 -0400
X-MC-Unique: z7ljy5NNNGCug0uMxvGm3w-1
Received: by mail-wr1-f72.google.com with SMTP id q28-20020adfab1c000000b0022e0399964dso4362155wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aL/XJR8EJ0pRD4xfXjlEdra6nq4SqKP4CXxDvLcpoE=;
        b=h9MoCf1tx8+pK3b+4FUVX9z+j2wSnz+UC/nmsIM5DpKN3kzrz/qLBU7fzyX5t+4ry3
         7XQleQExiXMPQIXHYffP6jH4p9tb4PhzJFYrbG/EQyDrX4uZfugLd09le/gaf9Incs3s
         BCk6eaCaBE0gX1Nfsgcl0y+xF5nrpzA8seOd0cyIAr5q5i60cq8l8Su9y82JSN+gJhqt
         /Rb6Dixei5HfwYzObBJTP3lwyeUGOQlAFw/WIleyb3koF5LTI9rV6EtdRD1LEUqON+xi
         Ml9coR0xbeb+bybbl03QHq1U0coH7V6DtO06xiRa6Bt/FH3ASSfEa8Iez+cLLCrkA5Yb
         gZKw==
X-Gm-Message-State: ACrzQf2yoL1ap7IhE2pULBAgxeobP1csueFFH6TSsYakueTmEsrEGTNq
        AZcN+j2p9zAFXFCkUSTlpF06ST15hTSfrzyHbu3KF1C2FoRi9/V8D+v1h9aRLroHQSpnllM2hwu
        h/hE8LvuiVXohcwsU9HNZ5wY7
X-Received: by 2002:a5d:5a8f:0:b0:22f:9396:4908 with SMTP id bp15-20020a5d5a8f000000b0022f93964908mr1270918wrb.273.1666085717555;
        Tue, 18 Oct 2022 02:35:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4UetMEzeww9mLgSKaEV1jjxk2feDBeaPeSqoLYUq6qo+4vH8HgLMrTveLBWXoVXoX0Tyi+Ng==
X-Received: by 2002:a5d:5a8f:0:b0:22f:9396:4908 with SMTP id bp15-20020a5d5a8f000000b0022f93964908mr1270910wrb.273.1666085717227;
        Tue, 18 Oct 2022 02:35:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:8900:d1f:5430:86b1:31ba? (p200300cbc70589000d1f543086b131ba.dip0.t-ipconnect.de. [2003:cb:c705:8900:d1f:5430:86b1:31ba])
        by smtp.gmail.com with ESMTPSA id g33-20020a05600c4ca100b003bfaba19a8fsm12375896wmp.35.2022.10.18.02.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 02:35:16 -0700 (PDT)
Message-ID: <c7839d65-1f07-02bf-19b4-aea3a6640227@redhat.com>
Date:   Tue, 18 Oct 2022 11:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
Content-Language: en-US
To:     =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20221012081526.73067-1-huangjie.albert@bytedance.com>
 <2aaf2c3a-6e49-abb9-b9c8-19ce87404982@redhat.com>
 <CABKxMyOnxiS6RsJtQEQPrnzNn-cO0Z+OGJRCUpw1M4=WANx0Dw@mail.gmail.com>
 <2f41fc4c-68eb-ab7d-970b-fcb10f474fd4@redhat.com>
 <CABKxMyO4RvEx===iYr_m2dfB0mtUTqt8A3WEuJn4Dq7r_NNM3w@mail.gmail.com>
 <03b90a2f-2854-6e19-6ccd-41f9933d8813@redhat.com>
 <CABKxMyO21rF+f2vpS+t++DAFHiy_MeWDBjB-AvupysKnDHRJfA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CABKxMyO21rF+f2vpS+t++DAFHiy_MeWDBjB-AvupysKnDHRJfA@mail.gmail.com>
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

On 18.10.22 11:27, 黄杰 wrote:
> David Hildenbrand <david@redhat.com> 于2022年10月17日周一 20:00写道：
>>
>> On 17.10.22 13:46, 黄杰 wrote:
>>> David Hildenbrand <david@redhat.com> 于2022年10月17日周一 19:33写道：
>>>>
>>>> On 17.10.22 11:48, 黄杰 wrote:
>>>>> David Hildenbrand <david@redhat.com> 于2022年10月17日周一 16:44写道：
>>>>>>
>>>>>> On 12.10.22 10:15, Albert Huang wrote:
>>>>>>> From: "huangjie.albert" <huangjie.albert@bytedance.com>
>>>>>>>
>>>>>>> implement these two functions so that we can set the mempolicy to
>>>>>>> the inode of the hugetlb file. This ensures that the mempolicy of
>>>>>>> all processes sharing this huge page file is consistent.
>>>>>>>
>>>>>>> In some scenarios where huge pages are shared:
>>>>>>> if we need to limit the memory usage of vm within node0, so I set qemu's
>>>>>>> mempilciy bind to node0, but if there is a process (such as virtiofsd)
>>>>>>> shared memory with the vm, in this case. If the page fault is triggered
>>>>>>> by virtiofsd, the allocated memory may go to node1 which  depends on
>>>>>>> virtiofsd.
>>>>>>>
>>>>>>
>>>>>> Any VM that uses hugetlb should be preallocating memory. For example,
>>>>>> this is the expected default under QEMU when using huge pages.
>>>>>>
>>>>>> Once preallocation does the right thing regarding NUMA policy, there is
>>>>>> no need to worry about it in other sub-processes.
>>>>>>
>>>>>
>>>>> Hi, David
>>>>> thanks for your reminder
>>>>>
>>>>> Yes, you are absolutely right, However, the pre-allocation mechanism
>>>>> does solve this problem.
>>>>> However, some scenarios do not like to use the pre-allocation mechanism, such as
>>>>> scenarios that are sensitive to virtual machine startup time, or
>>>>> scenarios that require
>>>>> high memory utilization. The on-demand allocation mechanism may be better,
>>>>> so the key point is to find a way support for shared policy。
>>>>
>>>> Using hugetlb -- with a fixed pool size -- without preallocation is like
>>>> playing with fire. Hugetlb reservation makes one believe that on-demand
>>>> allocation is going to work, but there are various scenarios where that
>>>> can go seriously wrong, and you can run out of huge pages.
>>>>
>>>> If you're using hugetlb as memory backend for a VM without
>>>> preallocation, you really have to be very careful. I can only advise
>>>> against doing that.
>>>>
>>>>
>>>> Also: why does another process read/write *first* to a guest physical
>>>> memory location before the OS running inside the VM even initialized
>>>> that memory? That sounds very wrong. What am I missing?
>>>>
>>>
>>> for example : virtio ring buffer.
>>> For the avial descriptor, the guest kernel only gives an address to
>>> the backend,
>>> and does not actually access the memory.
>>
>> Okay, thanks. So we're essentially providing uninitialized memory to a
>> device? Hm, that implies that the device might have access to memory
>> that was previously used by someone else ... not sure how to feel about
>> that, but maybe this is just the way of doing things.
>>
>> The "easy" user-space fix would be to simply similarly mbind() in  the
>> other processes where we mmap(). Has that option been explored?
> 
> This can also solve the problem temporarily, but we need to change all
> processes that share memory with it, so it can't be done once and for
> all

How many process that really care are we walking about? Usually, 
extending the vhost-user protocol and relevant libraries should be good 
enough.

-- 
Thanks,

David / dhildenb

