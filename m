Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2FC746680
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGDATF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGDAS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:18:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F32DE6D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 17:18:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55b5a3915f5so2360761a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688429903; x=1691021903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5o23Iu39e3OIONFSj282h74DwqacDMnB3TCrmdFJIM8=;
        b=Qyq4jbbcMmpPz5Cznk2Qkp4TqFzJoe8d7s695eDssZvcVyAD855oUv5+iU8u6fLwLX
         z90uoBJjpBDaIbdj5Y6hTqIf5+YN5MwRra8/zsqcQJ4M+AKh0e1KC46UcLhJYAsHzoFF
         pxkvPeOeHo7W/4ZIW+c45CcyvPhxgUvvY50VPOsuhmI+XNNhpydvPJXqcFDL4jdPI6An
         iJ3pr7M2QhZ4TcgcR75JFsF3t8Vah8dMXPJ8fP5yHRW6vaQ+kHOxPJXWXSUQ1eH/4mHv
         TgajaR2h+IkXbPmhmAQNumuQj0URFKaReFYDXFyZ7lXg9AHOiRqp1evHI3hQcVGrBbfT
         PXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688429903; x=1691021903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5o23Iu39e3OIONFSj282h74DwqacDMnB3TCrmdFJIM8=;
        b=lRsvQOCBckERCQpdw9VfsCOjBrCnQqbebsdG4avkNfZJim6YsmoTOrIiGlSLJct0Xg
         MjnqG0PuS/Pz/Wy0qxYzX8X+hZ2rinzAuQFt1oSruBCRtEVIjaeegXSE+Nzo21utHl+X
         cEGsdjM6gi1vcqgQ7KCJGded/Oph/l/6PkHDQxquKzG7S8xY+9JS9LCP9q51rHMA8W2d
         AqAAGZSnc0zB9HbDYS/zPXtZJ4D6eM9WIC6dGyfcndISfDQIoLrFVdSfp3vq2lI5TUA+
         +cE2K9QxQPbG2Wsbo3oLlNQ3lJZFVZiL9+Ui35cn0gcrTXmtxSVeo0HsbAYLptXVetK9
         4LgA==
X-Gm-Message-State: ABy/qLbFKq4KZxUTYb7T4uPCFbSDjC7oh5PYgemBIFhDQBXk4lZ7gztU
        wemMWYk/+G+gnib112GaW3LmiA==
X-Google-Smtp-Source: APBJJlF+wwZOEuuppIYrWhooY2UAhMT9iKvEGMeG1kAUzbvR5MEo6fFf8aQUZWSqrT/hu+nohX4ixA==
X-Received: by 2002:a05:6a20:a10b:b0:12e:641b:454a with SMTP id q11-20020a056a20a10b00b0012e641b454amr4752721pzk.30.1688429903455;
        Mon, 03 Jul 2023 17:18:23 -0700 (PDT)
Received: from [10.255.136.59] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001b893b689a0sm2741799plx.84.2023.07.03.17.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 17:18:22 -0700 (PDT)
Message-ID: <7a8f7a66-f454-a4af-b42e-29c2aab6d3a4@bytedance.com>
Date:   Tue, 4 Jul 2023 08:18:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: PING Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
 <20230509233907-mutt-send-email-mst@kernel.org>
 <CACGkMEujVhZrU2Wa3=-6DAgK5x8suC9EDxMxt5nN3Y1-LAVcUA@mail.gmail.com>
 <20230510000603-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230510000603-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

This seems to be ignored...

On 5/10/23 12:06, Michael S. Tsirkin wrote:
> On Wed, May 10, 2023 at 12:04:50PM +0800, Jason Wang wrote:
>> On Wed, May 10, 2023 at 11:44 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Wed, May 10, 2023 at 11:26:54AM +0800, Xuan Zhuo wrote:
>>>> On Wed, 10 May 2023 10:54:37 +0800, zhenwei pi <pizhenwei@bytedance.com> wrote:
>>>>> Both split ring and packed ring use 32bits to describe the length of
>>>>> a descriptor: see struct vring_desc and struct vring_packed_desc.
>>>>> This means the max segment size supported by virtio is U32_MAX.
>>>>>
>>>>> An example of virtio_max_dma_size in virtio_blk.c:
>>>>>    u32 v, max_size;
>>>>>
>>>>>    max_size = virtio_max_dma_size(vdev);  -> implicit convert
>>>>>    err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
>>>>>                               struct virtio_blk_config, size_max, &v);
>>>>>    max_size = min(max_size, v);
>>>>>
>>>>> There is a risk during implicit convert here, once virtio_max_dma_size
>>>>> returns 4G, max_size becomes 0.
>>>>>
>>>>> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
>>>>> Cc: Joerg Roedel <jroedel@suse.de>
>>>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>>>> ---
>>>>>   drivers/virtio/virtio_ring.c | 12 ++++++++----
>>>>>   include/linux/virtio.h       |  2 +-
>>>>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>>> index c5310eaf8b46..55cfecf030a1 100644
>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>> @@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
>>>>>      return false;
>>>>>   }
>>>>>
>>>>> -size_t virtio_max_dma_size(const struct virtio_device *vdev)
>>>>> +u32 virtio_max_dma_size(const struct virtio_device *vdev)
>>>>
>>>>
>>>> LGTM
>>>>
>>>> But, should we change the parameter to vq, then use the dma_dev?
>>>>
>>>> @Jason
>>>>
>>>> Thanks.
>>>>
>>>
>>>
>>> that would be an unrelated rework.
>>
>> Probably, but I think it's better to be done on top otherwise we may forget.
>>
>> Thanks
> 
> Just to make things clear I'm merging fixes for this
> release but cleanups belong in the next one.
> 
>>>
>>>>>   {
>>>>> -   size_t max_segment_size = SIZE_MAX;
>>>>> +   u32 max_segment_size = U32_MAX;
>>>>>
>>>>> -   if (vring_use_dma_api(vdev))
>>>>> -           max_segment_size = dma_max_mapping_size(vdev->dev.parent);
>>>>> +   if (vring_use_dma_api(vdev)) {
>>>>> +           size_t max_dma_size = dma_max_mapping_size(vdev->dev.parent);
>>>>> +
>>>>> +           if (max_dma_size < max_segment_size)
>>>>> +                   max_segment_size = max_dma_size;
>>>>> +   }
>>>>>
>>>>>      return max_segment_size;
>>>>>   }
>>>>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>>>>> index b93238db94e3..1a605f408329 100644
>>>>> --- a/include/linux/virtio.h
>>>>> +++ b/include/linux/virtio.h
>>>>> @@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
>>>>>   #endif
>>>>>   void virtio_reset_device(struct virtio_device *dev);
>>>>>
>>>>> -size_t virtio_max_dma_size(const struct virtio_device *vdev);
>>>>> +u32 virtio_max_dma_size(const struct virtio_device *vdev);
>>>>>
>>>>>   #define virtio_device_for_each_vq(vdev, vq) \
>>>>>      list_for_each_entry(vq, &vdev->vqs, list)
>>>>> --
>>>>> 2.20.1
>>>>>
>>>
> 

-- 
zhenwei pi
