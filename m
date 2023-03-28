Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2D6CB70C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjC1GX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjC1GXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F2E2D5B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679984466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xsc7UO9YYazLYGSDUS0EJUCS68PHCQOhVmqaJ1ZEnhU=;
        b=LFnz14n5ErPqoil3Kx6wIoxs93EA/lcNyKnQw2tddarMj5uZ9MqikYi0ZrQXmpU+Kewwff
        kWtkQlnBHepUuvJwTSwdLDO0gaBVIvSFx3xYmdbFN5Dh2yFY2uxij4DMmrwyvHHYJlvllu
        CvA5J/7XUsgZ5pXAWx5+wGBffACeh5A=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-qurot-bXPa6PYUGUUBmLIg-1; Tue, 28 Mar 2023 02:17:56 -0400
X-MC-Unique: qurot-bXPa6PYUGUUBmLIg-1
Received: by mail-pl1-f200.google.com with SMTP id x4-20020a170902ec8400b001a1a5f6f272so7069335plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xsc7UO9YYazLYGSDUS0EJUCS68PHCQOhVmqaJ1ZEnhU=;
        b=AeZKvmlbF2kW6S3ek7y3QruCAFl7G98SbHxOWXBV3q3bCgEBx/9WnopgHXdwBq8pGk
         9wwTQ00vArOMsmxpSvvWUrCK2rXrLpUb73RurLeg8mxKwiBCkFjCfUu/IJaKuYTreEw2
         AsKIBMjtOhglVwLZgP5B3QniMBYWSpXMxjuJhRChsaVPxkna86u+0NWzEOkKpGysWUGv
         6uMt7uAgG44EKJROXM+Q8XKPbP09YwzNaCC3RmxKDyW4wWrolR0iq7UZSWaubk6gBkTc
         q9JDrOSD0QLKylLguicVfedqeE9YBp+mWduk3Wsk8XzNzmamJa946MPedYp2SurivSOY
         icwg==
X-Gm-Message-State: AAQBX9dhZI1yCXrun+j/nCWNMGDHcth9nU+oBN4VbkKZHMhGtZGVZq6S
        i0C8IJbAghSaxlZYcJLz9ye/91/9oDtzKKf7wG47AjVHO+EpL9+2+R8dD+lAiu3Q++BS55aLTdU
        2hcqPVgHaurZ9+LTQ+c9fx15ajwCuRUbNHeg=
X-Received: by 2002:a17:90b:1b49:b0:23f:9439:9a27 with SMTP id nv9-20020a17090b1b4900b0023f94399a27mr15305329pjb.20.1679984275133;
        Mon, 27 Mar 2023 23:17:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350YN1lfzRNqgj4QyndNByT6/a3apGRBTI3BMeCeEFa0Kwbx0ENst/W1oW8eI9H1IVDkkr9sSqg==
X-Received: by 2002:a17:90b:1b49:b0:23f:9439:9a27 with SMTP id nv9-20020a17090b1b4900b0023f94399a27mr15305316pjb.20.1679984274824;
        Mon, 27 Mar 2023 23:17:54 -0700 (PDT)
Received: from [10.72.13.204] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090aba0a00b0023f355a0bb5sm8478897pjr.14.2023.03.27.23.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:17:54 -0700 (PDT)
Message-ID: <e928b283-709d-c632-a294-c95b60d813ce@redhat.com>
Date:   Tue, 28 Mar 2023 14:17:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 08/11] vdpa: Add eventfd for the vdpa callback
Content-Language: en-US
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-9-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230323053043.35-9-xieyongji@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/23 13:30, Xie Yongji 写道:
> Add eventfd for the vdpa callback so that user
> can signal it directly instead of triggering the
> callback. It will be used for vhost-vdpa case.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>   drivers/vhost/vdpa.c         | 2 ++
>   drivers/virtio/virtio_vdpa.c | 1 +
>   include/linux/vdpa.h         | 6 ++++++
>   3 files changed, 9 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 7be9d9d8f01c..9cd878e25cff 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -599,9 +599,11 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>   		if (vq->call_ctx.ctx) {
>   			cb.callback = vhost_vdpa_virtqueue_cb;
>   			cb.private = vq;
> +			cb.trigger = vq->call_ctx.ctx;
>   		} else {
>   			cb.callback = NULL;
>   			cb.private = NULL;
> +			cb.trigger = NULL;
>   		}
>   		ops->set_vq_cb(vdpa, idx, &cb);
>   		vhost_vdpa_setup_vq_irq(v, idx);
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index f3826f42b704..2a095f37f26b 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -196,6 +196,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>   	/* Setup virtqueue callback */
>   	cb.callback = callback ? virtio_vdpa_virtqueue_cb : NULL;
>   	cb.private = info;
> +	cb.trigger = NULL;
>   	ops->set_vq_cb(vdpa, index, &cb);
>   	ops->set_vq_num(vdpa, index, virtqueue_get_vring_size(vq));
>   
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index e52c9a37999c..0372b2e3d38a 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -13,10 +13,16 @@
>    * struct vdpa_calllback - vDPA callback definition.
>    * @callback: interrupt callback function
>    * @private: the data passed to the callback function
> + * @trigger: the eventfd for the callback (Optional).
> + *           When it is set, the vDPA driver must guarantee that
> + *           signaling it is functional equivalent to triggering
> + *           the callback. Then vDPA parent can signal it directly
> + *           instead of triggering the callback.
>    */
>   struct vdpa_callback {
>   	irqreturn_t (*callback)(void *data);
>   	void *private;
> +	struct eventfd_ctx *trigger;
>   };
>   
>   /**

