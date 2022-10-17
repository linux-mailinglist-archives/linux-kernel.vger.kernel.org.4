Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5CD600DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJQLeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJQLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5251521A6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666006432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxo3rNBB2g+qJUv1f+R8vZ98yqB+DnhnvN71rozSIN4=;
        b=ahVkQTTzmXjTpSyYREQ95Zqe+Lh+DvMv7l9k7Y226wpSK0jGONtZwlQgrjlBVVTRo9gxP8
        vcGmmeH+DinvebL+DvM9MLkXhe40DwaiUG1sMBfRJY7febXdgnsMOJzGf+Iqp0HJOZ+DPG
        0LnR0hspQ9cXoYJFSokPclanUAK0vG0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-17-AMqYYtObNvanx1an_7_vow-1; Mon, 17 Oct 2022 07:33:51 -0400
X-MC-Unique: AMqYYtObNvanx1an_7_vow-1
Received: by mail-wm1-f70.google.com with SMTP id c130-20020a1c3588000000b003b56be513e1so7512192wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxo3rNBB2g+qJUv1f+R8vZ98yqB+DnhnvN71rozSIN4=;
        b=polb42fMBDbHC3tl7EAVm9CacliDeeqKzde0JESWjIbebdq8x/1Mo20gWvBIqJnVHw
         HiN4oencAlg9fnCkWDtK/ui/4FF189B6CcZUGtvFKcvUILUGRZRfb0WoGOLv/tEgfROx
         5M3jlV+xbZhW3rxzooOZX7GnKqR2EhHUVzLhlamxz4s3pcf1i2dZ9ZDPS0cN/GhDC1D/
         ouJLv77EOtyyO+M/Zl+MX2Go5bgZCn6j7+liNvucyvtD2W11M37JrGCBH/DaqMysWdqN
         iyPz1C70OzT0heZ7WyqUOUXN4JfSqiif/vply3qU3gX8s7rmOg0kcRbh3O+Ih1Z9Ngza
         3OcA==
X-Gm-Message-State: ACrzQf3RVc7FV97tUGeiIOywvGXtcGLlYvA/Pjyt2gEVgwyGcDCjYfMz
        /rkECQkM2dx22YSyVV1w7JLthcuLDC4v5p7gX+4beK+rYXBHm47X16fD0MZburKW0I4kVjwfnLf
        krJLZn14mEXYnx6CFtXUCGLKX
X-Received: by 2002:a05:600c:4ec7:b0:3c6:e3d4:d59d with SMTP id g7-20020a05600c4ec700b003c6e3d4d59dmr12361565wmq.181.1666006430063;
        Mon, 17 Oct 2022 04:33:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6hvjkUkFb07o/+xzSf9+kGc5Vh/SvfBfARe1ybwDa8bk8XHD/uaLLfrP4NbN8y4Nk4HFd4dg==
X-Received: by 2002:a05:600c:4ec7:b0:3c6:e3d4:d59d with SMTP id g7-20020a05600c4ec700b003c6e3d4d59dmr12361548wmq.181.1666006429787;
        Mon, 17 Oct 2022 04:33:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:a00:37ed:519:6c33:4dc8? (p200300cbc70a0a0037ed05196c334dc8.dip0.t-ipconnect.de. [2003:cb:c70a:a00:37ed:519:6c33:4dc8])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d52c6000000b00228dbf15072sm8122011wrv.62.2022.10.17.04.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 04:33:49 -0700 (PDT)
Message-ID: <2f41fc4c-68eb-ab7d-970b-fcb10f474fd4@redhat.com>
Date:   Mon, 17 Oct 2022 13:33:48 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CABKxMyOnxiS6RsJtQEQPrnzNn-cO0Z+OGJRCUpw1M4=WANx0Dw@mail.gmail.com>
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

On 17.10.22 11:48, 黄杰 wrote:
> David Hildenbrand <david@redhat.com> 于2022年10月17日周一 16:44写道：
>>
>> On 12.10.22 10:15, Albert Huang wrote:
>>> From: "huangjie.albert" <huangjie.albert@bytedance.com>
>>>
>>> implement these two functions so that we can set the mempolicy to
>>> the inode of the hugetlb file. This ensures that the mempolicy of
>>> all processes sharing this huge page file is consistent.
>>>
>>> In some scenarios where huge pages are shared:
>>> if we need to limit the memory usage of vm within node0, so I set qemu's
>>> mempilciy bind to node0, but if there is a process (such as virtiofsd)
>>> shared memory with the vm, in this case. If the page fault is triggered
>>> by virtiofsd, the allocated memory may go to node1 which  depends on
>>> virtiofsd.
>>>
>>
>> Any VM that uses hugetlb should be preallocating memory. For example,
>> this is the expected default under QEMU when using huge pages.
>>
>> Once preallocation does the right thing regarding NUMA policy, there is
>> no need to worry about it in other sub-processes.
>>
> 
> Hi, David
> thanks for your reminder
> 
> Yes, you are absolutely right, However, the pre-allocation mechanism
> does solve this problem.
> However, some scenarios do not like to use the pre-allocation mechanism, such as
> scenarios that are sensitive to virtual machine startup time, or
> scenarios that require
> high memory utilization. The on-demand allocation mechanism may be better,
> so the key point is to find a way support for shared policy。

Using hugetlb -- with a fixed pool size -- without preallocation is like 
playing with fire. Hugetlb reservation makes one believe that on-demand 
allocation is going to work, but there are various scenarios where that 
can go seriously wrong, and you can run out of huge pages.

If you're using hugetlb as memory backend for a VM without 
preallocation, you really have to be very careful. I can only advise 
against doing that.


Also: why does another process read/write *first* to a guest physical 
memory location before the OS running inside the VM even initialized 
that memory? That sounds very wrong. What am I missing?

-- 
Thanks,

David / dhildenb

