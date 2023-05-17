Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A70705E68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjEQDxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEQDxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:53:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED226A6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:53:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6438d95f447so163757b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684295587; x=1686887587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itmdkIN8S/Snq7UqRVM4GC+PuwMWErICpyh8a55mXY0=;
        b=JvDtQ4Mv53NXAi15Kn4d8PbpCm0JVoxRijfGdjmQg4Vnlv2d2aVx8H9ZE0z2dyy7JQ
         6tA642v883StlQN/OizoG+K4jTVTwsT2E9H62rF44Uq9O/2ZRHjTg8IvvbI6m0Jfkyde
         2/BKmzJ4W9XNUVohiWxIqcX4CX86oK5FxLmBzupFhmx5tCcTSIagXhf4vaxbTZ43DmSz
         AS+tSPe1qkUBHM6ACsLBBvYApFiwLax29pIeIWbbhJxHM38W8g1ovzYA0ED2a0dTEL8P
         BbisGGY7pxzRU88h9vocIjsFL6Ulnz0Itl9PIxMh0uhZxHdhOZLiNXiRk5IyrCwJtUF3
         eCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684295587; x=1686887587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itmdkIN8S/Snq7UqRVM4GC+PuwMWErICpyh8a55mXY0=;
        b=SDXEcEovT4hbjELUXyi4v3E1DoSK0/o27qa8WRWTIs4/QSmsEtA4FQ0ehECWZyzRjI
         8845RD7KYlei7EmkQPlB7VPP7e3rybMYZAuVVynAfxJOEQIa8VSUPZ/9xSv9r2bm30W8
         /AHpWqC4xStKyPuQuiGkHqDCP11s+/rKM7j0VnRdY7sHQrowV/yDvBOl13J3FPA72TTZ
         pb8lkG78cUQeviH0ZRJyGG7fv2qQAFna3vS+Q2WcUFzFR5Rqu5vVYSfj1G8fsX6uVU5q
         j/8g8txi0yNZK5BiXsXyDn6YuL5zMkL/KIT2lHp6TKsIIRr6gD+LOvm7AcneWFZ5YQU8
         F8KA==
X-Gm-Message-State: AC+VfDzRAS5CycE9NX9Z/0PRiA2ARaWAKXFzY3GYu33vRhBNe6WE8OAi
        4aIgIWbpQoBp3PSvu2n5DTi9sA==
X-Google-Smtp-Source: ACHHUZ7G3yKUqEwQVvWagTG2cW3EWp9bjOD5mDuiwvReZYIy6wcWQoesa1xNr8SuIUlqnp9ZFX34CA==
X-Received: by 2002:a05:6a20:9153:b0:105:dafa:fec2 with SMTP id x19-20020a056a20915300b00105dafafec2mr12018255pzc.53.1684295587683;
        Tue, 16 May 2023 20:53:07 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id n24-20020a17090ac69800b0024499d4b72esm384115pjt.51.2023.05.16.20.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 20:53:07 -0700 (PDT)
Message-ID: <8f3ca136-0276-49ca-d703-715c83cff557@bytedance.com>
Date:   Wed, 17 May 2023 11:51:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH v2 0/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230516234444-mutt-send-email-mst@kernel.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230516234444-mutt-send-email-mst@kernel.org>
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



On 5/17/23 11:46, Michael S. Tsirkin wrote:
> On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
>> v1 -> v2:
>> - Suggested by MST, use fast path for vring based performance
>> sensitive API.
>> - Reduce changes in tools/virtio.
>>
>> Add test result(no obvious change):
>> Before:
>> time ./vringh_test --parallel
>> Using CPUS 0 and 191
>> Guest: notified 10036893, pinged 68278
>> Host: notified 68278, pinged 3093532
>>
>> real	0m14.463s
>> user	0m6.437s
>> sys	0m8.010s
>>
>> After:
>> time ./vringh_test --parallel
>> Using CPUS 0 and 191
>> Guest: notified 10036709, pinged 68347
>> Host: notified 68347, pinged 3085292
>>
>> real	0m14.196s
>> user	0m6.289s
>> sys	0m7.885s
>>
>> v1:
>> Hi,
>>
>> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
>> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
>>
>> Jason and Stefan pointed out that a non-vring based virtqueue has a
>> chance to overwrite virtqueue instead of using vring virtqueue.
>>
>> Then I try to abstract virtqueue related methods in this series, the
>> details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
>>
>> Something is still remained:
>> - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
>>    virtio core, I'd like to rename them to vring_virtqueue_break
>>    /vring_virtqueue_unbreak. Is this reasonable?
> 
> Why? These just set a flag?
> 

Rename '__virtqueue_break' to 'vring_virtqueue_break', to make symbols 
exported from virtio_ring.ko have unified prefix 'vring_virtqueue_xxx'.

>> - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
>>    /virtqueue_get_vring is vring specific, I'd like to rename them like
>>    vring_virtqueue_get_desc_addr. Is this reasonable?
>> - there are still some functions in virtio_ring.c with prefix *virtqueue*,
>>    for example 'virtqueue_add_split', just keep it or rename it to
>>    'vring_virtqueue_add_split'?
>> zhenwei pi (2):
>>    virtio: abstract virtqueue related methods
>>    tools/virtio: implement virtqueue in test
>>
>>   drivers/virtio/virtio_ring.c | 285 +++++-----------------
>>   include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
>>   include/linux/virtio_ring.h  |  26 +++
>>   tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
>>   4 files changed, 807 insertions(+), 300 deletions(-)
>>
>> -- 
>> 2.20.1
> 

-- 
zhenwei pi
