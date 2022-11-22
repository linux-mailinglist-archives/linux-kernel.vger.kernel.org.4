Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1C634529
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiKVUHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiKVUHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:07:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0026CA6A0F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669147610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0xAdJctF6H+O/M4MLLhKCg5TO/+mCew7BZYqlNiSSIs=;
        b=RDRiia6HkKLAQTo4o6OjU/X6ZH0fl7VP5zvjG5KBbm0OJHRpK4NECDLQ4bCI64ICkR1xNs
        PGRz/g8Jan2BeOcGIIh2bDidH5YXLipRGmtBaP0Ta3I+vmlem0xlsGjkjFlDv7i7izc0BI
        5etxIO/2X3jK5I6OrdZDLbH0i3Mbymg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-283-7Ne7fpMXNnSiHk6gocynbw-1; Tue, 22 Nov 2022 15:06:48 -0500
X-MC-Unique: 7Ne7fpMXNnSiHk6gocynbw-1
Received: by mail-wm1-f71.google.com with SMTP id m17-20020a05600c3b1100b003cf9cc47da5so8554435wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xAdJctF6H+O/M4MLLhKCg5TO/+mCew7BZYqlNiSSIs=;
        b=gIxqpk/aFjpMGxGrW+q53rxbz7cPIMYXutjgWJn4s8Qx8x1gBPBB+/YYe5Ols4zSva
         RRenkkYvLZ1Z2qKEl18CWsDBdcrEghtruY2zhNatgA45DCuw3dF5mu+zsbwmeCmMIBWY
         T3rIcIY44lMVGmUKQPAKmPNBQeV0wpLR1Ucf8/MydrahIRDWAS4XPof1FuNgP+4SmHO/
         B1sacS/sKrgTLAWMRVVhDMkeQ4f2j/qlGik8GHhZu91iJdml0UzlLrLs+OGYw2u/186S
         cVgb0SefyJaRo8lfP/MeEjfgaJKhDXeGwrzGc+sjFvmBZjai0INh+fixpovBBoe4c0KQ
         eTOg==
X-Gm-Message-State: ANoB5pmVDO+cz+mg+ttLSWQ6u/wtEZ0nHR6SEIdYdH/CNa9R57XhayW8
        gT05cQhq3hk8kjh4YfzxsKoY6axTImuyM+ZepyIskAMsjKcyG2Gke0exG4BENnWLfOieldxgq9r
        0QWO6Pw7H4GcREWv6tZfMao19
X-Received: by 2002:a05:600c:19d1:b0:3cf:ca1a:332a with SMTP id u17-20020a05600c19d100b003cfca1a332amr21535837wmq.118.1669147607623;
        Tue, 22 Nov 2022 12:06:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YWFh65HU9KyRpvxonEkQl/n1raz9o7hhsaT5c6a6bnb78L5u0hylpoRzGwVF6Heua+k5RZA==
X-Received: by 2002:a05:600c:19d1:b0:3cf:ca1a:332a with SMTP id u17-20020a05600c19d100b003cfca1a332amr21535811wmq.118.1669147607355;
        Tue, 22 Nov 2022 12:06:47 -0800 (PST)
Received: from redhat.com ([2.52.16.74])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm25248305wmq.1.2022.11.22.12.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:06:46 -0800 (PST)
Date:   Tue, 22 Nov 2022 15:06:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, jasowang@redhat.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, rusty@rustcorp.com.au,
        cornelia.huck@de.ibm.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] virtio_net: Fix probe failed when modprobe virtio_net
Message-ID: <20221122150459-mutt-send-email-mst@kernel.org>
References: <20221121132935.2032325-1-lizetao1@huawei.com>
 <20221122150046.3910638-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122150046.3910638-1-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:00:46PM +0800, Li Zetao wrote:
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
> disable

if you need to resend it:

not disabled

but that's minor, ok to ignore

> on the error handling path when register_netdevice()
> fails in virtnet_probe(), resulting in an error "-ENOENT"
> returned in the next modprobe call in setup_vq().
> 
> virtio_pci_modern_device uses virtqueues to send or
> receive message, and "queue_enable" records whether the
> queues are available. In vp_modern_find_vqs(), all queues
> will be selected and activated, but once queues are enabled
> there is no way to go back except reset.
> 
> Fix it by reset virtio device on error handling path. This
> makes error handling follow the same order as normal device
> cleanup in virtnet_remove() which does: unregister, destroy
> failover, then reset. And that flow is better tested than
> error handling so we can be reasonably sure it works well.
> 
> Fixes: 024655555021 ("virtio_net: fix use after free on allocation failure")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks, LGTM, feel free to merge.



> ---
> v1 was posted at: https://lore.kernel.org/all/20221121132935.2032325-1-lizetao1@huawei.com/
> v1 -> v2: modify commit log and fixes tag
> 
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

