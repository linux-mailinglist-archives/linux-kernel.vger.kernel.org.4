Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC06A746B00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjGDHrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjGDHqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:46:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919DA1703
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:46:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55adfa61199so3900349a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688456787; x=1691048787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVJjknruJb91ILVpOuTcCRbdbnC4UY5wlBTxHKWCG44=;
        b=IiFnQ6k4jSqvVtGDd37kR9HS1IRREBh0LWHshQDJC0J8UoQ6OCjcMpnEs3y9vZBHcz
         RsTQVzP5dplWmuOHkwLoOnMkIABilANtpzn39ZeLtfHtIvtBZQuuUWD39eKjy5mvvfVw
         Ew73LL9qg+ZOAemXXv1xghzPTRoLttpAyt2ZOUAkRmXDfDysbX7+idCxaxjX57+pjUl5
         Gg+l+mkDLNF0khSu6m+l9PiIvnkNrwNpnW2rGUOaaCDbUz+iobgw9h6uEeOvzwwVBsBO
         YaRxIyweZ9WulbS00uvDzLDQ62z6gmyLAHMG4XxObCaPkGXFrotOOwFolgFKUGrfJ2Cf
         BeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688456787; x=1691048787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVJjknruJb91ILVpOuTcCRbdbnC4UY5wlBTxHKWCG44=;
        b=ZW4U3mLq5oxsi+aEBthwIfe1MkRA5SwBZzCpTOtD1mbCToPtQbyWhn+/eQQS/iQkse
         hVcJ436+qv2za5+19v3+Wkt4YJ1Hgqh573vYmgn+I9EoaqguAYrg30Y5VENGLZavUuVq
         d1EQXPiSK1P0Qb4ezP72DbVzpT8jssNASu5wPihAOkRNyzX/Yqu7xBA+fEvOQTWrFMIW
         kNes67HWl/E+ENyVDUossHoztXYU6l2RJzHJ4yO81VJ4FyEViSJeXcsZ8lTw9Wb/JBGL
         1egIYEXjvRETYiYoNLfe4W9eaZjXpmq2wUR4PJ2DiCsVc7xUwVQmJl7NecF39/HOgKOn
         66JA==
X-Gm-Message-State: ABy/qLbbONOWA6YfdazoTenBe+fzSKQovSAE5Zmiw07SJ6KluO9ahk/A
        GzqEEPxGvGdUWmDdQdZsVVjIGg==
X-Google-Smtp-Source: APBJJlF43xSytPxPqxmGeaHTubWssn8yi2AZhYVjZZJvdpJJKnSdgyJW/0FUJfHMqBm1tTkdsgm40w==
X-Received: by 2002:a17:90a:e54f:b0:262:f449:4497 with SMTP id ei15-20020a17090ae54f00b00262f4494497mr13001266pjb.2.1688456786888;
        Tue, 04 Jul 2023 00:46:26 -0700 (PDT)
Received: from [10.255.136.59] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090a68c900b0025bf1ea918asm16239528pjj.55.2023.07.04.00.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:46:26 -0700 (PDT)
Message-ID: <334e0fb2-f070-fa80-550c-bfd9d2886fa6@bytedance.com>
Date:   Tue, 4 Jul 2023 15:46:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        Joerg Roedel <jroedel@suse.de>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <20230704020935-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230704020935-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/23 14:21, Michael S. Tsirkin wrote:
> On Wed, May 10, 2023 at 10:54:37AM +0800, zhenwei pi wrote:
>> Both split ring and packed ring use 32bits to describe the length of
>> a descriptor: see struct vring_desc and struct vring_packed_desc.
>> This means the max segment size supported by virtio is U32_MAX.
>>
>> An example of virtio_max_dma_size in virtio_blk.c:
>>    u32 v, max_size;
>>
>>    max_size = virtio_max_dma_size(vdev);  -> implicit convert
>>    err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
>>                               struct virtio_blk_config, size_max, &v);
>>    max_size = min(max_size, v);
>>
>> There is a risk during implicit convert here, once virtio_max_dma_size
>> returns 4G, max_size becomes 0.
>>
>> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
>> Cc: Joerg Roedel <jroedel@suse.de>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/virtio/virtio_ring.c | 12 ++++++++----
>>   include/linux/virtio.h       |  2 +-
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index c5310eaf8b46..55cfecf030a1 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
>>   	return false;
>>   }
>>   
>> -size_t virtio_max_dma_size(const struct virtio_device *vdev)
>> +u32 virtio_max_dma_size(const struct virtio_device *vdev)
>>   {
>> -	size_t max_segment_size = SIZE_MAX;
>> +	u32 max_segment_size = U32_MAX;
>>   
>> -	if (vring_use_dma_api(vdev))
>> -		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
>> +	if (vring_use_dma_api(vdev)) {
>> +		size_t max_dma_size = dma_max_mapping_size(vdev->dev.parent);
>> +
>> +		if (max_dma_size < max_segment_size)
>> +			max_segment_size = max_dma_size;
>> +	}
>>   
>>   	return max_segment_size;
>>   }
> 
> Took a while for me to get this, it's confusing.  I think the issue is
> really in virtio blk, so I would just change max_size there to size_t
> and be done with it.
> 
> 

Fine.

> 
> 
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index b93238db94e3..1a605f408329 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
>>   #endif
>>   void virtio_reset_device(struct virtio_device *dev);
>>   
>> -size_t virtio_max_dma_size(const struct virtio_device *vdev);
>> +u32 virtio_max_dma_size(const struct virtio_device *vdev);
>>   
>>   #define virtio_device_for_each_vq(vdev, vq) \
>>   	list_for_each_entry(vq, &vdev->vqs, list)
>> -- 
>> 2.20.1
> 

-- 
zhenwei pi
