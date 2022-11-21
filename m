Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C085632B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiKURrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiKURq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA174AF28
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669052761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZsWyTZbLbUwrYvkp8yOiWqpRLocI1SdRjfKrEd8kUBM=;
        b=ZABZBnWygQIzOrN2OsTCQYPoaTdjk1vk7y5NVh8d4bLFWRAh3Y/yVzWFeWNlmve2M2xjhL
        81w/cPeDE66KdoOFbaQ8spi5aSn4POVj2uuvKHCwPwfJEfUCXFjznwZ3KJpkZHX1bpQl2u
        gen3y8OEnDZhqUrbcxuK20MpV3vc4p8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-491-qNtwVSvfOJ2s7-W4bmxKRg-1; Mon, 21 Nov 2022 12:45:57 -0500
X-MC-Unique: qNtwVSvfOJ2s7-W4bmxKRg-1
Received: by mail-wm1-f70.google.com with SMTP id i133-20020a1c3b8b000000b003cffc0a69afso7229856wma.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsWyTZbLbUwrYvkp8yOiWqpRLocI1SdRjfKrEd8kUBM=;
        b=fXrRUOXC6sGHYaC0VL1WrBd5oBAaFJgo7Uow+SlHQ8BVWFmP5zu5Znlr4VcurDaWae
         pezAO7sQP0O7eLTlSlDtZtc3wiA527rfc4Gqsbdk2Cbf4sdkHW7YDLoYdEnWMIBI82YN
         1RAqGvuncAkqVmYp9HfePkmrj4tz2BkWeMJtJOAwYLLAN1C4B3rZ/urUyIKN/Zhn8RLm
         k3o6loOD/W8/Wa+tB9wMtRmtw5/d8k2LLn1n0vDBgDFuJkG5nFXXL8e6K+rgb5eVf0U3
         8J9lkuX5nBDQkb4zlAow5URJWVkRWNw7DUGrr68h/mg+EIAGm6fBAi3loYEMXVVOH0oO
         Wz6w==
X-Gm-Message-State: ANoB5pn6E0Zv/JX+lIxufRUvOEDKV+F+A2BAtRhc9M43UoGUh/n7zt9s
        u9BcdhZMZjMZUskXHb91fLZndrvx8uKsb0XOCRP14Ax7jub1tdS86vXHd6bv2mR+yt0tEzsnm5h
        XJbpT2VBSn4NFFZ70yAZ0P95r
X-Received: by 2002:a5d:6f0f:0:b0:236:5b81:1daa with SMTP id ay15-20020a5d6f0f000000b002365b811daamr2731138wrb.17.1669052756111;
        Mon, 21 Nov 2022 09:45:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf606hSl3n2BZu1EpWbRdyPFuVmG8FXTdeOoGCjgArVy0T55wZnFAwMi/mCKF2NG3Vmm9g7JDA==
X-Received: by 2002:a5d:6f0f:0:b0:236:5b81:1daa with SMTP id ay15-20020a5d6f0f000000b002365b811daamr2731121wrb.17.1669052755799;
        Mon, 21 Nov 2022 09:45:55 -0800 (PST)
Received: from redhat.com ([2.52.21.254])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d620a000000b002366dd0e030sm11871438wru.68.2022.11.21.09.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 09:45:55 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:45:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, rusty@rustcorp.com.au,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Fix probe failed when modprobe virtio_net
Message-ID: <20221121123438-mutt-send-email-mst@kernel.org>
References: <20221121132935.2032325-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121132935.2032325-1-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:29:35PM +0800, Li Zetao wrote:
> When doing the following test steps, an error was found:
>   step 1: modprobe virtio_net succeeded
>     # modprobe virtio_net        <-- OK
> 
>   step 2: fault injection in register_netdevice()
>     # modprobe -r virtio_net     <-- OK
>     # ...
>       FAULT_INJECTION: forcing a failure.
>       name failslab, interval 1, probability 0, space 0, times 0
>       CPU: 0 PID: 3521 Comm: modprobe
>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>       Call Trace:
>        <TASK>
>        ...
>        should_failslab+0xa/0x20
>        ...
>        dev_set_name+0xc0/0x100
>        netdev_register_kobject+0xc2/0x340
>        register_netdevice+0xbb9/0x1320
>        virtnet_probe+0x1d72/0x2658 [virtio_net]
>        ...
>        </TASK>
>       virtio_net: probe of virtio0 failed with error -22
> 
>   step 3: modprobe virtio_net failed
>     # modprobe virtio_net        <-- failed
>       virtio_net: probe of virtio0 failed with error -2
> 
> The root cause of the problem is that the queues are not
> disable on the error handling path when register_netdevice()
> fails in virtnet_probe(), resulting in an error "-ENOENT"
> returned in the next modprobe call in setup_vq().
> 
> virtio_pci_modern_device uses virtqueues to send or
> receive message, and "queue_enable" records whether the
> queues are available. In vp_modern_find_vqs(), all queues
> will be selected and activated, but once queues are enabled
> there is no way to go back except reset.
> 
> Fix it by reset virtio device on error handling path.
> 
> Fixes: 1fcf0512c9c8 ("virtio_pci: modern driver")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

I would add to this:

------

This makes error handling follow the same order as normal device cleanup
which does:

static void remove_vq_common(struct virtnet_info *vi)
{
        virtio_reset_device(vi->vdev);

        /* Free unused buffers in both send and recv, if any. */
        free_unused_bufs(vi);

        free_receive_bufs(vi);

        free_receive_page_frags(vi);

        virtnet_del_vqs(vi);
}

static void virtnet_remove(struct virtio_device *vdev)
{
        struct virtnet_info *vi = vdev->priv;

        virtnet_cpu_notif_remove(vi);

        /* Make sure no work handler is accessing the device. */
        flush_work(&vi->config_work);

        unregister_netdev(vi->dev);

        net_failover_destroy(vi->failover);

        remove_vq_common(vi);

        free_netdev(vi->dev);
}


So unregister, destroy failover, then reset - and that flow
is better tested than error handling so we can be reasonably
sure it works well.

-----


I would thus probably also include this tag instead:

Fixes: 0246555550 ("virtio_net: fix use after free on allocation failure")

this is what introduced the difference in cleanup order,
modern driver just added hardware support.


Besides extending the commit log

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/net/virtio_net.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7106932c6f88..86e52454b5b5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3949,12 +3949,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	return 0;
>  
>  free_unregister_netdev:
> -	virtio_reset_device(vdev);
> -
>  	unregister_netdev(dev);
>  free_failover:
>  	net_failover_destroy(vi->failover);
>  free_vqs:
> +	virtio_reset_device(vdev);
>  	cancel_delayed_work_sync(&vi->refill);
>  	free_receive_page_frags(vi);
>  	virtnet_del_vqs(vi);
> -- 
> 2.25.1

