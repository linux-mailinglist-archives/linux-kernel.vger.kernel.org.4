Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B976BCABC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCPJ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjCPJ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA53CB7890
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678958740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+6mrc9lcRETyQg/w4ndpwijr7SMvLTIz9AM+IjnlgM=;
        b=jLjwgD7n8xiiAzFmd1StR3gzFkALmt0pW9hApD8l6NxYgB/jzDZwhWLaO2hvIc9nBzJZCA
        4pFW5SwKo/6tMU16KZWrnzBRL97py86gOU4XruMgG9j2c4fhs+MGh5iyiVP+SJelzsQ3gk
        1NsRwBxE5gy7YIFzsaETzj3qMG57LF4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-hXVuaLeGMlaIbhZdoFGqRQ-1; Thu, 16 Mar 2023 05:25:39 -0400
X-MC-Unique: hXVuaLeGMlaIbhZdoFGqRQ-1
Received: by mail-pl1-f197.google.com with SMTP id z9-20020a170902708900b0019f271f33aeso679112plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678958738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+6mrc9lcRETyQg/w4ndpwijr7SMvLTIz9AM+IjnlgM=;
        b=U54HmKYUoCSfrSYuI+NwIk3IKTis5oYI5/1NS30eGU160vlezSymG7q2viTypDJ1OM
         ytlqiUJgJ2OGL7Vy19uwNST27pijt9PW70RZ8NbOqjdLrm8py9MzmpybHwpzN6mm5YzL
         EEA/PYFimsgLuuzrmwKiX6FBxyqfjfCIKX60dn2Jqv+hqKIZafZf+AI/m40qiS6OdIu7
         waJO+ND09iXhSgGY/j3lRriLnR9h0d1Ff2/nnqZ8kJ07SRferdBUFjmq8XBLTlpMrZ8R
         u3v8o+/t6TP8kDhvzeKpslW0Ye2cHONE829gixFVnMCOAfZjdQU+4fsWrlJZVM/B72BZ
         lmSw==
X-Gm-Message-State: AO0yUKVORuXsIvZwqdxH++Ow3oettL+Gf6++1cxIcQTats7wCbtnXiDc
        ktutoTntxaUUEg+/9gPeJkCG9SQQO6n3MUHyXGPEqDCfifr8KXluz7oHpO7gBqc5DCzZq9r/dYI
        FDoZc9NPixpFtvFi2K/kkbiGD
X-Received: by 2002:a05:6a20:6a9e:b0:cc:4118:7609 with SMTP id bi30-20020a056a206a9e00b000cc41187609mr2565268pzb.37.1678958738547;
        Thu, 16 Mar 2023 02:25:38 -0700 (PDT)
X-Google-Smtp-Source: AK7set/8ZIHUolDDxHyTi2C1eWuj/ZBB/IpACATprS/zOASEkDwrXA7eKsOTvDqvAFgzJ/3Sf9Rvqw==
X-Received: by 2002:a05:6a20:6a9e:b0:cc:4118:7609 with SMTP id bi30-20020a056a206a9e00b000cc41187609mr2565255pzb.37.1678958738283;
        Thu, 16 Mar 2023 02:25:38 -0700 (PDT)
Received: from [10.72.13.123] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z13-20020aa785cd000000b005a852875590sm4996746pfn.113.2023.03.16.02.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 02:25:37 -0700 (PDT)
Message-ID: <f7f30935-afc6-4864-6663-21007524a377@redhat.com>
Date:   Thu, 16 Mar 2023 17:25:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 08/11] vdpa: Add eventfd for the vdpa callback
Content-Language: en-US
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-9-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230228094110.37-9-xieyongji@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/28 17:41, Xie Yongji 写道:
> Add eventfd for the vdpa callback so that user
> can signal it directly instead of running the
> callback. It will be used for vhost-vdpa case.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/vhost/vdpa.c         | 2 ++
>   drivers/virtio/virtio_vdpa.c | 1 +
>   include/linux/vdpa.h         | 3 +++
>   3 files changed, 6 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index dc12dbd5b43b..ae89c0ccc2bb 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -599,9 +599,11 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>   		if (vq->call_ctx.ctx) {
>   			cb.callback = vhost_vdpa_virtqueue_cb;
>   			cb.private = vq;
> +			cb.irq_ctx = vq->call_ctx.ctx;
>   		} else {
>   			cb.callback = NULL;
>   			cb.private = NULL;
> +			cb.irq_ctx = NULL;
>   		}
>   		ops->set_vq_cb(vdpa, idx, &cb);
>   		vhost_vdpa_setup_vq_irq(v, idx);
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 9eee8afabda8..a5cecafbc2d1 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -195,6 +195,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>   	/* Setup virtqueue callback */
>   	cb.callback = callback ? virtio_vdpa_virtqueue_cb : NULL;
>   	cb.private = info;
> +	cb.irq_ctx = NULL;
>   	ops->set_vq_cb(vdpa, index, &cb);
>   	ops->set_vq_num(vdpa, index, virtqueue_get_vring_size(vq));
>   
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 10bd22387276..94a7ec49583a 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -13,10 +13,13 @@
>    * struct vdpa_calllback - vDPA callback definition.
>    * @callback: interrupt callback function
>    * @private: the data passed to the callback function
> + * @irq_ctx: the eventfd for the callback, user can signal
> + *           it directly instead of running the callback


I'd suggest to do more tweaks to mention:

1) irq_ctx is optional
2) that when the irq_ctx is set, the vDPA driver must guarantee that 
signaling it is functional equivalent to triggering the callback. When 
set, vDPA parent can signal it directly instead of triggering the callback.

>    */
>   struct vdpa_callback {
>   	irqreturn_t (*callback)(void *data);
>   	void *private;
> +	struct eventfd_ctx *irq_ctx;


There's no IRQ concept at the virtual vDPA bus level, so it's probably 
better to rename it as "trigger".

Btw, should we select EVENTFD for vDPA?

Thanks


>   };
>   
>   /**

