Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AFD63A5DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiK1KP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiK1KPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:15:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE67140BD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669630489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBqAwBRWRjtW0ICmoI0uX4BeXltXbya2cc38sf5NvgE=;
        b=UNW9jbvctZslep5ZYKkRdI/4k66ebmJntyY43QtJa8imBhCB/v0x7KwK19KcYN14uCTqAn
        2QNkHfgIir5xWA8KdiPOJDJoprX2X3U2C0vGjlKSf5nhMrxGe+Lxwu6IhoivLBLnoYNkPR
        MqA5jr6DPPYXOpmKNsH0Iju0ksWNul4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-eq4aVmKKPwW771zqqLUCnA-1; Mon, 28 Nov 2022 05:14:45 -0500
X-MC-Unique: eq4aVmKKPwW771zqqLUCnA-1
Received: by mail-wr1-f70.google.com with SMTP id l8-20020adfc788000000b00241ef50e89eso1721953wrg.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBqAwBRWRjtW0ICmoI0uX4BeXltXbya2cc38sf5NvgE=;
        b=RjijPqKUG/FV1Px+pvXKy/7FMdDgH692YjHMWT0JYBat/j9TIoeapYT8VauC06SwcF
         +LBLihon4aZfb8zCcUxqcQp1sdrh4SbHJmQSnXaPwPsx9PoJxCJNrF9NZmnUogPDA4np
         2IhCBWhdGOWDToqzT64v+zxQXOfkkNFv+6Y/oPvn8sFT34fxqcv84ATzA10ezS0Tarix
         lAf/+7p2e1CV6WFiG3wBzgnr1Us8OXsuqpx0+EQ41a4B5Ww2xdNtGfQgRyAo2h3aR0/D
         KrK+qaD0yfY8fiFW1scivvFgy0InjGeOCTF0Cdp8009Kx3K5usy5i/0CJKGceQ9UEjHu
         5khA==
X-Gm-Message-State: ANoB5pm/8u5vlvUg5t+NvS5GE1nBOaP2XBU20Z+WBejdFMijRw3ZVklP
        LD6GzOJ6nLPoyMS1z8rOyDQxjp5J1wfPTPtqwT2wHfiz9n4a/WhFuHCO1/3lOUcNEFLMpLRt2dA
        7oL1/2aJQHx5TCJLls41A8BF3
X-Received: by 2002:adf:f302:0:b0:242:1dbc:2d29 with SMTP id i2-20020adff302000000b002421dbc2d29mr318247wro.609.1669630484334;
        Mon, 28 Nov 2022 02:14:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ewYVQblwq/AEaxJGpgSzFXdQ+34eT0h/HaNR6C/0BgeFYG90YGVYdSwR7BSPWiouADYG5SQ==
X-Received: by 2002:adf:f302:0:b0:242:1dbc:2d29 with SMTP id i2-20020adff302000000b002421dbc2d29mr318211wro.609.1669630484132;
        Mon, 28 Nov 2022 02:14:44 -0800 (PST)
Received: from redhat.com ([2.52.149.178])
        by smtp.gmail.com with ESMTPSA id a12-20020adfe5cc000000b0022cc3e67fc5sm10146135wrn.65.2022.11.28.02.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:14:43 -0800 (PST)
Date:   Mon, 28 Nov 2022 05:14:39 -0500
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
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
Message-ID: <20221128042945-mutt-send-email-mst@kernel.org>
References: <20221128021005.232105-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128021005.232105-1-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:10:01AM +0800, Li Zetao wrote:
> This patchset fixes similar issue, the root cause of the
> problem is that the virtqueues are not stopped on error
> handling path.

I've been thinking about this.
Almost all drivers are affected.

The reason really is that it used to be the right thing to do:
On legacy pci del_vqs writes 0
into vq index and this resets the device as a side effect
(we actually do this multiple times, what e.g. writes of MSI vector
 after the 1st reset do I have no idea).

mmio ccw and modern pci don't.

Given this has been with us for a while I am inlined to look for
a global solution rather than tweaking each driver.

Given many drivers are supposed to work on legacy too, we know del_vqs
includes a reset for many of them. So I think I see a better way to do
this:

Add virtio_reset_device_and_del_vqs()

and convert all drivers to that.

When doing this, we also need to/can fix a related problem (and related
to the hardening that Jason Wang was looking into):
virtio_reset_device is inherently racy: vq interrupts could
be in flight when we do reset. We need to prevent handlers from firing in
the window between reset and freeing the irq, so we should first
free irqs and only then start changing the state by e.g.
device reset.


Quite a lot of core work here. Jason are you still looking into
hardening?



> Li Zetao (4):
>   9p: Fix probe failed when modprobe 9pnet_virtio
>   virtio-mem: Fix probe failed when modprobe virtio_mem
>   virtio-input: Fix probe failed when modprobe virtio_input
>   virtio-blk: Fix probe failed when modprobe virtio_blk
> 
>  drivers/block/virtio_blk.c    | 1 +
>  drivers/virtio/virtio_input.c | 1 +
>  drivers/virtio/virtio_mem.c   | 1 +
>  net/9p/trans_virtio.c         | 1 +
>  4 files changed, 4 insertions(+)
> 
> -- 
> 2.25.1

