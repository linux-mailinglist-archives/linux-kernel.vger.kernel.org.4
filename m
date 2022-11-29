Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE163B8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiK2DiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiK2DiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:38:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7414B75D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669693043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DjWTah+2EKxcXo7oWQgA5SpjVxywoPSBhBg+WInwWOQ=;
        b=fAR+ih4LaFve5EVJuQcB+JERdqInZtJqOXqN+UNFoQZnsZnL8uXXnDv+KVyn5qz5Y5tycP
        PNUux8LdaJzgxeoLehBqFd7+WaAx+dU6xpLNEtvJRlcmH1EOydIiJxXKmrJwYLt6fgnMkT
        0cwBHm8z7E9dvJbzYoqkepuzE/yAB8o=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-DpdcPESyMwec9L_l3TCHMw-1; Mon, 28 Nov 2022 22:37:21 -0500
X-MC-Unique: DpdcPESyMwec9L_l3TCHMw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-143c7a3da8aso1910714fac.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjWTah+2EKxcXo7oWQgA5SpjVxywoPSBhBg+WInwWOQ=;
        b=nDrMKAfAXYE+8bjbxLjmawOxPQpF6N68R9owF1WLIO0ZwV/PUDLxQy1wF7ZkFopHke
         ctyKN7SMeB/ATY1STJfU+gmziC0CJMaezocMI3QbttZVTbBLJb/H6UK2Uk94h9zBdB5P
         IKrCIexQmiKXkHD1fRYgXA8h5ZXalyuttp+mxTOqwj3CqBW11wyuD60nR4txjzd+2zxF
         1cxix9cNUkdGVzkmw1uCCp2uIQV+JblZNDptuEM2+v6Nz5lI13ZPzs2J6Zdwc6yoDTf/
         S7fRugzQ7SW4//0rceNx4h/n98Fp1j79njNEMvhe6jX/d73QQdoGw4vGPq4GQzS0PZqy
         l1+w==
X-Gm-Message-State: ANoB5plL5IM71uA7Kf6dw+CYIXmAL4iHavDTPebt5GiCXgrQRLoyfU7K
        ITn2t5S+6vjneP5R3NVshxx+Yo8UfTMiHwy8+oG10rmKsj3mEveNy9lBUX69GuClXoz8SE6GRXO
        9MErmxDvBDWlew5RZavmEVaS4YaFinNxcobU8uLYi
X-Received: by 2002:a9d:4f07:0:b0:66c:64d6:1bb4 with SMTP id d7-20020a9d4f07000000b0066c64d61bb4mr27085058otl.201.1669693040558;
        Mon, 28 Nov 2022 19:37:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6EmIDabO2AHcWjiaME3fUs69AGG9zkVypks4R3pv1UesNWwbFvYcjoNz9Z4Pyc98HwSff6j5CYa7YoG0PBT3E=
X-Received: by 2002:a9d:4f07:0:b0:66c:64d6:1bb4 with SMTP id
 d7-20020a9d4f07000000b0066c64d61bb4mr27085052otl.201.1669693040323; Mon, 28
 Nov 2022 19:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20221128021005.232105-1-lizetao1@huawei.com> <20221128042945-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221128042945-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 29 Nov 2022 11:37:09 +0800
Message-ID: <CACGkMEtuOk+wyCsvY0uayGAvy926G381PC-csoXVAwCfiKCZQw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Li Zetao <lizetao1@huawei.com>, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk, kraxel@redhat.com,
        david@redhat.com, ericvh@gmail.com, lucho@ionkov.net,
        asmadeus@codewreck.org, linux_oss@crudebyte.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, rusty@rustcorp.com.au,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 6:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Nov 28, 2022 at 10:10:01AM +0800, Li Zetao wrote:
> > This patchset fixes similar issue, the root cause of the
> > problem is that the virtqueues are not stopped on error
> > handling path.
>
> I've been thinking about this.
> Almost all drivers are affected.
>
> The reason really is that it used to be the right thing to do:
> On legacy pci del_vqs writes 0
> into vq index

into vq address actually?

> and this resets the device as a side effect

I think there's no guarantee for a device to do this.

> (we actually do this multiple times, what e.g. writes of MSI vector
>  after the 1st reset do I have no idea).
>
> mmio ccw and modern pci don't.
>
> Given this has been with us for a while I am inlined to look for
> a global solution rather than tweaking each driver.

But do we still need patches for -stable at least?

>
> Given many drivers are supposed to work on legacy too, we know del_vqs
> includes a reset for many of them. So I think I see a better way to do
> this:
>
> Add virtio_reset_device_and_del_vqs()

What's the difference with the current del_vqs method? Is this something like:

virtio_reset_device();
config->del_vqs();

>
> and convert all drivers to that.
>
> When doing this, we also need to/can fix a related problem (and related
> to the hardening that Jason Wang was looking into):
> virtio_reset_device is inherently racy: vq interrupts could
> be in flight when we do reset. We need to prevent handlers from firing in
> the window between reset and freeing the irq, so we should first
> free irqs and only then start changing the state by e.g.
> device reset.

Yes.

>
>
> Quite a lot of core work here. Jason are you still looking into
> hardening?

Yes, last time we've discussed a solution that depends on the first
kick to enable the interrupt handler. But after some thought, it seems
risky since there's no guarantee that the device work in this way.

One example is the current vhost_net, it doesn't wait for the kick to
process the rx packets. Any more thought on this?

Thanks


>
>
>
> > Li Zetao (4):
> >   9p: Fix probe failed when modprobe 9pnet_virtio
> >   virtio-mem: Fix probe failed when modprobe virtio_mem
> >   virtio-input: Fix probe failed when modprobe virtio_input
> >   virtio-blk: Fix probe failed when modprobe virtio_blk
> >
> >  drivers/block/virtio_blk.c    | 1 +
> >  drivers/virtio/virtio_input.c | 1 +
> >  drivers/virtio/virtio_mem.c   | 1 +
> >  net/9p/trans_virtio.c         | 1 +
> >  4 files changed, 4 insertions(+)
> >
> > --
> > 2.25.1
>

