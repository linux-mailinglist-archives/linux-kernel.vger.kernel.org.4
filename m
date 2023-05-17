Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EC9705F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjEQFAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjEQFAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:00:41 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E81835A0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:00:15 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5304913530fso254719a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684299614; x=1686891614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0ayuQD1yG3R2Gd1MnzlrpUhS5iphVyxpsIrxm7q4sE=;
        b=Y52AyCLsbM4D/d67PD1bGzQZQoDlM3aHciAN1wrkyvnxm+Dn/vJhGSM1m1NJ8EZDdK
         sow8BXGsaLRPY50OiP8OBKQA3e0pB236P+5WExJr9yAJGZezvwKGm0lvVyt6G3Gjk4At
         FJRp5WjvDIjpeBi2ZSVC8gjxR9I2KrvqN6shK4SjY4tCvUtCKAL84GsNvVAkZ0r5rtcg
         605IaqoC07Wp4/mMDGp/U5LsjWQlwuCuJalwAw4GjgaXptnzyN2S+I5Z2Pk2OPtRdemu
         vk0YWUSAOmbJAgf9uE8LkzdKkEh1dWFgXABpbJqxcAV/2wLV9fmRQBvDF0A33Awl/uQ2
         b3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684299614; x=1686891614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0ayuQD1yG3R2Gd1MnzlrpUhS5iphVyxpsIrxm7q4sE=;
        b=kR4ciM+IMugY1tDJozsF5ElEy1VINGG4mIUE8ZphJzD49O95mcuF90h8nIwbtepWxW
         vQk7smzIOr4mVyzFjuPKf8uVDOD05BFzblFufkFvRb6Bk6ZxdKeFGhlb1/TVEuQNZa9f
         nhCxJh7y6NcMthABIoRgguVKshpUPqUuXRh312xBl9FfbbRcR3VThya8hsM61hbf5DX1
         9QXUAZSWDYfgu1+LUWRcOJEwKvA1k4AjRLFBxfTEnLB9llsSKEF7wm7OM36l8rpBHG2W
         rApyOerue169d6Y05ecmUd+n1uNmml0MWIuKpRTx+ndiya0Ep2ZW/FJBUEE/BfmWO6ok
         yujw==
X-Gm-Message-State: AC+VfDxG+mBrUCq2lT+Vxmm5kuY7hOmTWeMO94gReY0Ul2rSOpLbQ5sR
        tKdvG66hcxueILc7lJRiI903ig==
X-Google-Smtp-Source: ACHHUZ6UYgglmLRIeq+ymAQ0bT5ay0/DQJupZCh6QNbX/GBM1JVcTKNYewM68/CWfoTimBrPnuwinA==
X-Received: by 2002:a17:903:124f:b0:1ac:451d:34a with SMTP id u15-20020a170903124f00b001ac451d034amr52262835plh.33.1684299614560;
        Tue, 16 May 2023 22:00:14 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id b20-20020a17090a8c9400b0024e1172c1d3sm524407pjo.32.2023.05.16.22.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 22:00:14 -0700 (PDT)
Message-ID: <949dd4db-89ea-4331-5fa7-700f96874ab3@bytedance.com>
Date:   Wed, 17 May 2023 12:58:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: Re: [PATCH v2 0/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230516234444-mutt-send-email-mst@kernel.org>
 <8f3ca136-0276-49ca-d703-715c83cff557@bytedance.com>
 <20230516235541-mutt-send-email-mst@kernel.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230516235541-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 11:57, Michael S. Tsirkin wrote:
> On Wed, May 17, 2023 at 11:51:03AM +0800, zhenwei pi wrote:
>>
>>
>> On 5/17/23 11:46, Michael S. Tsirkin wrote:
>>> On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
>>>> v1 -> v2:
>>>> - Suggested by MST, use fast path for vring based performance
>>>> sensitive API.
>>>> - Reduce changes in tools/virtio.
>>>>
>>>> Add test result(no obvious change):
>>>> Before:
>>>> time ./vringh_test --parallel
>>>> Using CPUS 0 and 191
>>>> Guest: notified 10036893, pinged 68278
>>>> Host: notified 68278, pinged 3093532
>>>>
>>>> real	0m14.463s
>>>> user	0m6.437s
>>>> sys	0m8.010s
>>>>
>>>> After:
>>>> time ./vringh_test --parallel
>>>> Using CPUS 0 and 191
>>>> Guest: notified 10036709, pinged 68347
>>>> Host: notified 68347, pinged 3085292
>>>>
>>>> real	0m14.196s
>>>> user	0m6.289s
>>>> sys	0m7.885s
>>>>
>>>> v1:
>>>> Hi,
>>>>
>>>> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
>>>> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
>>>>
>>>> Jason and Stefan pointed out that a non-vring based virtqueue has a
>>>> chance to overwrite virtqueue instead of using vring virtqueue.
>>>>
>>>> Then I try to abstract virtqueue related methods in this series, the
>>>> details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
>>>>
>>>> Something is still remained:
>>>> - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
>>>>     virtio core, I'd like to rename them to vring_virtqueue_break
>>>>     /vring_virtqueue_unbreak. Is this reasonable?
>>>
>>> Why? These just set a flag?
>>>
>>
>> Rename '__virtqueue_break' to 'vring_virtqueue_break', to make symbols
>> exported from virtio_ring.ko have unified prefix 'vring_virtqueue_xxx'.
> 
> I just do not see why you need these callbacks at all.
> 

I use these callbacks for break/unbreak device like:
static inline void virtio_break_device(struct virtio_device *dev)
{
	struct virtqueue *vq;

	spin_lock(&dev->vqs_list_lock);
	list_for_each_entry(vq, &dev->vqs, list) {
		vq->__break(vq);
	}
	spin_unlock(&dev->vqs_list_lock);
}

>>>> - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
>>>>     /virtqueue_get_vring is vring specific, I'd like to rename them like
>>>>     vring_virtqueue_get_desc_addr. Is this reasonable?
>>>> - there are still some functions in virtio_ring.c with prefix *virtqueue*,
>>>>     for example 'virtqueue_add_split', just keep it or rename it to
>>>>     'vring_virtqueue_add_split'?
>>>> zhenwei pi (2):
>>>>     virtio: abstract virtqueue related methods
>>>>     tools/virtio: implement virtqueue in test
>>>>
>>>>    drivers/virtio/virtio_ring.c | 285 +++++-----------------
>>>>    include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
>>>>    include/linux/virtio_ring.h  |  26 +++
>>>>    tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
>>>>    4 files changed, 807 insertions(+), 300 deletions(-)
>>>>
>>>> -- 
>>>> 2.20.1
>>>
>>
>> -- 
>> zhenwei pi
> 

-- 
zhenwei pi
