Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE2660F560
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiJ0KfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiJ0KfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:35:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBB2101F6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:35:01 -0700 (PDT)
Received: from [192.168.2.208] (109-252-112-196.nat.spd-mgts.ru [109.252.112.196])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B1A966028CF;
        Thu, 27 Oct 2022 11:34:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666866900;
        bh=B42Mjq5Xz6ezZDdiM34GBP0U3MZxhlYaL9Mqx4TnvWc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BMSNB4CyHeqKWHd1Vu4K+jL9R8vKCa8B9/8qfUi0oVBXR+M03p1Q4eYSv/QCfOmmk
         2bIwl4496z5xJxBDhYKpZUP6GEJIOEdr5k8RJD8ptzaIxE/IJzcm5hvpNwGhYfD2iW
         a9pS/QrBVAYJOW9T1Audi9jUDp1oDzGfZyxHDQh5LJSvHc6DTDNogxBh2D5yWvcjcG
         nzH0KhhEOGnIk64OEXHXVjrcMf9wmhtLUyZQaGKcR4VD2L6PQZca7YGACDhm1JWmKK
         u2nWFzOjqi5WkzjkQJivYBMQ4/VbTdPEgUUYVY8LPqzX+xiPn1iwsMpa5RuGHS1YkR
         l40SyhNQid90Q==
Message-ID: <46e22491-5891-cd24-850e-699fadb284ee@collabora.com>
Date:   Thu, 27 Oct 2022 13:34:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 1/2] dma-buf: Make locking consistent in
 dma_buf_detach()
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, noralf@tronnes.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221026224640.7542-1-dmitry.osipenko@collabora.com>
 <20221026224640.7542-2-dmitry.osipenko@collabora.com>
 <01f62e6c-a40b-42e4-6cb0-338bd268b0a5@amd.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <01f62e6c-a40b-42e4-6cb0-338bd268b0a5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 09:13, Christian König wrote:
> Am 27.10.22 um 00:46 schrieb Dmitry Osipenko:
>> The dma_buf_detach() locks attach->dmabuf->resv and then unlocks
>> dmabuf->resv, which could be a two different locks from a static
>> code checker perspective. In particular this triggers Smatch to
>> report the "double unlock" error. Make the locking pointers consistent.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Link: https://lore.kernel.org/dri-devel/Y1fLfsccW3AS%2Fo+%2F@kili/
>> Fixes: 809d9c72c2f8 ("dma-buf: Move dma_buf_attach() to dynamic
>> locking specification")
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> It would be even cleaner if we completely drop the dmabuf parameter for
> the function and just use the inside the attachment.
> 
> Anyway patch is Reviewed-by: Christian König <christian.koenig@amd.com>
> for now, wider cleanups can come later on.

I had the same thought about dropping the dmabuf parameter.

Looking at this patch again, perhaps a better dmabuf sanity-check will be:

- 	if (WARN_ON(!dmabuf || !attach))
+ 	if (WARN_ON(!dmabuf || !attach || dmabuf != attach->dmabuf))

I'll switch to this version in v2, if there are no objections.

> 
>> ---
>>   drivers/dma-buf/dma-buf.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index c40d72d318fd..6e33ef4fde34 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -998,9 +998,10 @@ void dma_buf_detach(struct dma_buf *dmabuf,
>> struct dma_buf_attachment *attach)
>>       if (WARN_ON(!dmabuf || !attach))
>>           return;
>>   -    dma_resv_lock(attach->dmabuf->resv, NULL);
>> +    dma_resv_lock(dmabuf->resv, NULL);
>>         if (attach->sgt) {
>> +        WARN_ON(dmabuf != attach->dmabuf);
>>             __unmap_dma_buf(attach, attach->sgt, attach->dir);
>>   
> 

-- 
Best regards,
Dmitry

