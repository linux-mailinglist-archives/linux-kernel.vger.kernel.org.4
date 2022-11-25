Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007DE63842D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKYG6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYG6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:58:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2876201A0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 22:58:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id cl5so5373546wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 22:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfntQBLjs5GuIypGY650oZ6aKLoCHKiULv8nPzpSI5E=;
        b=LhOu0Wn87JXy86LwpIQw6ABmlIbMEje9/Kzdxxg713pb/OU10XGsIPsxky2SwrQKyK
         GLrJE8+jM4oePJaHrWigcSfTugh0KFYIyy0rASspC0K7CJ4oXK5++jj1nuMoUeaGK3op
         g3Map2dpscD7lnW6bmzjoU3/bpX74IZR9z2mv2wGBAPzSknlFQtWH0MWWej5IXpybx8N
         lVr7kKU06gy2/3oLwqCcOD6qwDSLvBwyItSoIi9bgDMGZhtdoNrdl89fdw8KZc9hDLrW
         rLHqjcEwz1DVCd2FPzDYGlzKbkXXpFXq+tHnQzOZgCGLJ63cUZpetOABggWsIPbdO+/s
         Blig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfntQBLjs5GuIypGY650oZ6aKLoCHKiULv8nPzpSI5E=;
        b=FrDC5DHpeBexwErqG5ehzRL36NTUGeNqLuSC5bZTPZiyrQfFoFwrnAxLSk+sQNTGXj
         XR/zHNi+oT9iM9WOK93WfHy7SrE52vGjhZuhdwZ0rgyxqdmbxEKRSuaYg1CKAdwYWjDy
         FfN0Kv87xUvjQLwxOpIhp0EnRIhi9XAlL6NZZcObkNSbd5sywCtBs3TiXdUQTldGofM7
         pIn0lYW/+bBUG0BTKNehkKdfzFm0AaTUSplrPSpLi5PewcR2PnCQEjAonFEyALSygdGR
         gZB+cnUk27xyvwprGGyIpeSm5NANJrCWVVA4txibkZRDYy8dUxtddRpDOCzPaV6vTD4j
         S/Ww==
X-Gm-Message-State: ANoB5pm5VgwwUrs+ehiciXXFBAAa+UDHQW2wUpM6LEG/rqiph/0QUoI5
        +gHho+bTSiNOmXo7TbFFB7lHiTfqyYp8UQ==
X-Google-Smtp-Source: AA0mqf6mRtxfN29ap7gXA9CGLNxQGIYGTQbK1zNnkspxzF3NaNKx8w+DrFwL2lAWAk56y+fP9/0IFg==
X-Received: by 2002:a5d:5290:0:b0:241:cdd4:6925 with SMTP id c16-20020a5d5290000000b00241cdd46925mr16073019wrv.525.1669359516138;
        Thu, 24 Nov 2022 22:58:36 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id n12-20020a05600c3b8c00b003cfbbd54178sm16564294wms.2.2022.11.24.22.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 22:58:35 -0800 (PST)
Message-ID: <24aaf108-0168-4a5c-57bb-cf24daefb990@linaro.org>
Date:   Fri, 25 Nov 2022 06:58:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/11] misc: fastrpc: Assert held reservation lock for
 dma-buf mmapping
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        gregkh@linuxfoundation.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
References: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
 <20221124175125.418702-2-srinivas.kandagatla@linaro.org>
 <a30bec0c-7471-a144-9a69-f59d952b8970@collabora.com>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <a30bec0c-7471-a144-9a69-f59d952b8970@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/11/2022 18:03, Dmitry Osipenko wrote:
> On 11/24/22 20:51, Srinivas Kandagatla wrote:
>> From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>
>> When userspace mmaps dma-buf's fd, the dma-buf reservation lock must be
>> held. Add locking sanity check to the dma-buf mmaping callback to ensure
>> that the locking assumption won't regress in the future.
>>
>> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/misc/fastrpc.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 80811e852d8f..c6b9ddaa698b 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/device.h>
>>   #include <linux/dma-buf.h>
>>   #include <linux/dma-mapping.h>
>> +#include <linux/dma-resv.h>
>>   #include <linux/idr.h>
>>   #include <linux/list.h>
>>   #include <linux/miscdevice.h>
>> @@ -692,6 +693,8 @@ static int fastrpc_mmap(struct dma_buf *dmabuf,
>>   	struct fastrpc_buf *buf = dmabuf->priv;
>>   	size_t size = vma->vm_end - vma->vm_start;
>>   
>> +	dma_resv_assert_held(dmabuf->resv);
>> +
>>   	return dma_mmap_coherent(buf->dev, vma, buf->virt,
>>   				 FASTRPC_PHYS(buf->phys), size);
>>   }
> 
> This patch was already applied to DRM tree together with the rest of
> prerequisite dma-buf patches. IOW, it shouldn't be applied separately
> via the misc tree.
thanks, that is true.



---srini

> 
