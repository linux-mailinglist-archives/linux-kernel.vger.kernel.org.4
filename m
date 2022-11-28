Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E5563A517
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiK1Jao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiK1Jal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:30:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006AE18E2B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669627784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXe5/Gs5NMc9hqQvF6Q+od4uwWeU4d6k98E6eiWSSHg=;
        b=AVqVd6TGQeIDyPh68Ta5EVvrDu7aWB0Uc43D7fsE+8ng1jms2/x3RcTQ7bTA6sX25s+aHY
        PxQS9kUTp1kuNGrt5IgElq4US1mOOLQf3+KBcok8hpNins5ywXNVjOKsu+6chNTDp3mDEq
        H8Isv9VsC62KeCFjc5V/X4JqZNzAM14=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-JQWUwaBDMGK3QHh4PHH92g-1; Mon, 28 Nov 2022 04:29:42 -0500
X-MC-Unique: JQWUwaBDMGK3QHh4PHH92g-1
Received: by mail-wr1-f71.google.com with SMTP id g14-20020adfa48e000000b00241f94bcd54so1697625wrb.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXe5/Gs5NMc9hqQvF6Q+od4uwWeU4d6k98E6eiWSSHg=;
        b=h2bKyymhXtsHUE1IFjDkjf2iADvRX/k/avQg3/n8n/5DQeIxkJUJaYOgTKGDF6l4+A
         RPwOg5E0z5DS6retGJZ+lirz5ZPXzDQ0EEeKh8AnziWOWRcgc71IJhiyFVmrTna2kZDT
         ogGw9v4V/rjscB14uKgtXsPCCfvtMk23Und5KunGsyEUcRTavWICS1bMQ3UwUl+LdYcx
         zJNeDEsVI9JnBhsbCdwqkzPvLLoMebllv9oRt7dqgXmOJuzulSDJF+6UakRZkgYgKpkC
         bjP2XlHYwGe59WzCCOGmYCcCE2ykhEkEgP2OXMajKRjhkpa+H5ThiKH6iVcDYKaBlFt+
         5JZg==
X-Gm-Message-State: ANoB5pl1mnQujzVcI3XjDHrAaB7HId4ZkdeFOPxkNw3N1XVEyOf4ZwEq
        FYXNWxnu9L3C1MzuJgRzAELxB0ciq2YrGOjK35uTTcscgVq/cAcQi713de403KVT/YR6lCZbO9a
        1FSRkWlmTWlhZ03LymtsMEkv/
X-Received: by 2002:adf:ebc6:0:b0:241:c6d8:be83 with SMTP id v6-20020adfebc6000000b00241c6d8be83mr22842215wrn.454.1669627781399;
        Mon, 28 Nov 2022 01:29:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5NNWLiFYkS/4BWx2K5W3KIsae1W7cB7QkH/0YG2DaPbKUxNFXJ8iBUflEeJZH3AcNSktTgUw==
X-Received: by 2002:adf:ebc6:0:b0:241:c6d8:be83 with SMTP id v6-20020adfebc6000000b00241c6d8be83mr22842182wrn.454.1669627781095;
        Mon, 28 Nov 2022 01:29:41 -0800 (PST)
Received: from redhat.com ([2.52.149.178])
        by smtp.gmail.com with ESMTPSA id z14-20020a7bc7ce000000b003cf78aafdd7sm14055513wmk.39.2022.11.28.01.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 01:29:40 -0800 (PST)
Date:   Mon, 28 Nov 2022 04:29:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk, kraxel@redhat.com, david@redhat.com,
        ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, rusty@rustcorp.com.au,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH 3/4] virtio-input: Fix probe failed when modprobe
 virtio_input
Message-ID: <20221128042649-mutt-send-email-mst@kernel.org>
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128021005.232105-4-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128021005.232105-4-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:10:04AM +0800, Li Zetao wrote:
> When doing the following test steps, an error was found:
>   step 1: modprobe virtio_input succeeded
>     # modprobe virtio_input      <-- OK
> 
>   step 2: fault injection in input_allocate_device()
>     # modprobe -r virtio_input   <-- OK
>     # ...
>       CPU: 0 PID: 4260 Comm: modprobe Tainted: G        W
>       6.1.0-rc6-00285-g6a1e40c4b995-dirty #109
>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>       Call Trace:
>        <TASK>
>        should_fail.cold+0x5/0x1f
>        ...
>        kmalloc_trace+0x27/0xa0
>        input_allocate_device+0x43/0x280
>        virtinput_probe+0x23b/0x1648 [virtio_input]
>        ...
>        </TASK>
>       virtio_input: probe of virtio5 failed with error -12
> 
>   step 3: modprobe virtio_net failed
>     # modprobe virtio_input       <-- failed
>       virtio_input: probe of virtio1 failed with error -2
> 
> The root cause of the problem is that the virtqueues are not
> stopped on the error handling path when input_allocate_device()
> fails in virtinput_probe(), resulting in an error "-ENOENT"
> returned in the next modprobe call in setup_vq().
> 
> virtio_pci_modern_device uses virtqueues to send or
> receive message, and "queue_enable" records whether the
> queues are available. In vp_modern_find_vqs(), all queues
> will be selected and activated, but once queues are enabled
> there is no way to go back except reset.
> 
> Fix it by reset virtio device on error handling path. After
> virtinput_init_vqs() succeeded, all virtqueues should be
> stopped on error handling path.
> 
> Fixes: 1fcf0512c9c8 ("virtio_pci: modern driver")

Probably 271c865161c57cfabca45b93eaa712b19da365bc


> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/virtio/virtio_input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index 3aa46703872d..f638f1cd3531 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -330,6 +330,7 @@ static int virtinput_probe(struct virtio_device *vdev)
>  err_mt_init_slots:
>  	input_free_device(vi->idev);
>  err_input_alloc:
> +	virtio_reset_device(vdev);
>  	vdev->config->del_vqs(vdev);
>  err_init_vq:
>  	kfree(vi);
> -- 
> 2.25.1

