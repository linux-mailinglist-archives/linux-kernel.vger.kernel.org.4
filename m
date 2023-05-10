Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570D46FD489
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjEJDob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEJDo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:44:28 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583B45FD0
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:43:25 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-52caed90d17so3794398a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 20:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683690204; x=1686282204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Up0qD8aWokjqXRs5dcKMaGJ5ZKCh0P7UibkRsSUf25A=;
        b=Ljp10SFZSoIcIMmGN3S6gsuIw9oiS0RjsKs4Mq4Q/YHzB4dZYPp4wjtmp430rj/XcN
         4JrODj8PrQe3JbS6B+L7Y54ab0Qwur7AY8UV4MeyLuVNK6zUVjxuZpFIiEmRpPqs4C3X
         JZKTVJLHO7NWb6m19jQ2mBOWdoxDesDkFP5fzg8xYMfnoq7I1HMaLElPG1pE6cojflzI
         tpDRyjnpRlG0UyRGiKTJ1YuN0ZKhA5bSi9P1sFxZ1ChR6AdDGH5LWBBXRipU/VdFPMTe
         2RpEaB2sCudM8NgIW5mqSMghS5uhypI75vmyW6K1kgnU//MYz5wkRjFEAYuI1L/SjYhP
         xSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683690204; x=1686282204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Up0qD8aWokjqXRs5dcKMaGJ5ZKCh0P7UibkRsSUf25A=;
        b=V8nlETddJAkN6kaWGEBntDuZKNSSLob4x9/xYbmPuiCLMSCGAnnByOlITfjer0U7H2
         PsHmMu7BWV0SJctnagEfrPVIj2fFECaKgQ0hJ3gBIO7qn/DAK3jMua68ggW1bjGRs7X3
         9SGog6JWZIMlYU6OlAFZHrnMvu6VLI3oeDcXdV9d8lsqmoX5OBsBIdjenl0O7SuH9qN7
         aJxlOYRjcTfPKaBDazquKKWyaiOzixEALWyUaqsfN969H8rR3zAyHvfybSyXoeFK7C91
         PDjhz+jMpYcEaNBVFfwXczZjISlcPY3wRyLPkzk6GLto1DIjSHCt+RzxaPt/veSw6c6S
         AiOQ==
X-Gm-Message-State: AC+VfDwLisIMQyLDjBO9+QBhHIFgFtLUfa+Cg8cHnSODVPDDXdxU+1WS
        txtH5QiHCA8wlXbSed1uxKc5ow==
X-Google-Smtp-Source: ACHHUZ501WiLNY+LiAVPIAA+oM18qukCTdb4p29DQu3Yjjsw9E6IL06ZzNEDHtEly8N/ktugz5amDQ==
X-Received: by 2002:a17:90a:5e45:b0:24b:af7d:201d with SMTP id u5-20020a17090a5e4500b0024baf7d201dmr16930570pji.24.1683690204061;
        Tue, 09 May 2023 20:43:24 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ac08600b00250ad795d72sm2193584pjs.44.2023.05.09.20.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 20:43:23 -0700 (PDT)
Message-ID: <a19c3853-a152-253b-7ee4-de9506a22eaa@bytedance.com>
Date:   Wed, 10 May 2023 11:41:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        Joerg Roedel <jroedel@suse.de>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <20230509233929-mutt-send-email-mst@kernel.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230509233929-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/23 11:39, Michael S. Tsirkin wrote:
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
> 
> 
> is this a theoretical concern or do you manage to trigger this
> somehow?
> 

I never hit any issue about this, I notice here during diving into the 
symbols exported by virtio_ring.ko.

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
