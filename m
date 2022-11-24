Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD3C637EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKXSD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKXSDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:03:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CFE82BDE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:03:23 -0800 (PST)
Received: from [192.168.2.208] (unknown [109.252.124.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D29B3660036F;
        Thu, 24 Nov 2022 18:03:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669313002;
        bh=EwHUrmwy5ipQouV+Tt1kdjbv3cz9wmKEesLxsLH6GjU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZL0676/HQh5CdIRyXJAjfrouY0L41CLs+l3vp8bpJw7HeJ0Ukm464FPmmVJN3NCmh
         BzmTNJq53Lm5ghmGRKO796soeLNLI0LGown9RfO/v9qVqUaClAXeu2U6Xov2s+yJHD
         +rFJT5ysoUAmbBAltvrrr6/PeWgt7jYyXmw9OolkUhpB00d/sEzFVlN32afdeZS2dW
         QNJ5SaLugfmnWabPvh1gj/R4unwaXfZcRx7+MKwKujOm9R6Oorl+njdYxiEoFCU+nA
         RaecLlUaRT3MMTRVebjyxoF9a2cAe8w+CR8z6wxgkdjCYF77EhpVMshFOzZv+DkKBQ
         joBdJqu+866IQ==
Message-ID: <a30bec0c-7471-a144-9a69-f59d952b8970@collabora.com>
Date:   Thu, 24 Nov 2022 21:03:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 01/11] misc: fastrpc: Assert held reservation lock for
 dma-buf mmapping
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        gregkh@linuxfoundation.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
References: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
 <20221124175125.418702-2-srinivas.kandagatla@linaro.org>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221124175125.418702-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 20:51, Srinivas Kandagatla wrote:
> From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> When userspace mmaps dma-buf's fd, the dma-buf reservation lock must be
> held. Add locking sanity check to the dma-buf mmaping callback to ensure
> that the locking assumption won't regress in the future.
> 
> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/misc/fastrpc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 80811e852d8f..c6b9ddaa698b 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -6,6 +6,7 @@
>  #include <linux/device.h>
>  #include <linux/dma-buf.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma-resv.h>
>  #include <linux/idr.h>
>  #include <linux/list.h>
>  #include <linux/miscdevice.h>
> @@ -692,6 +693,8 @@ static int fastrpc_mmap(struct dma_buf *dmabuf,
>  	struct fastrpc_buf *buf = dmabuf->priv;
>  	size_t size = vma->vm_end - vma->vm_start;
>  
> +	dma_resv_assert_held(dmabuf->resv);
> +
>  	return dma_mmap_coherent(buf->dev, vma, buf->virt,
>  				 FASTRPC_PHYS(buf->phys), size);
>  }

This patch was already applied to DRM tree together with the rest of
prerequisite dma-buf patches. IOW, it shouldn't be applied separately
via the misc tree.

-- 
Best regards,
Dmitry

