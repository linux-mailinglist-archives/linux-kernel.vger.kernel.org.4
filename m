Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AC667E2CD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjA0LMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjA0LMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:12:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3395747EF9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674817918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DHdIigeHoqEjPUOvZqjrQoWLn5deR3YQuYptQY45zS0=;
        b=YX1kyrjUGB9CnVGZZrsAgZccqqGffNJdJDse3HVsdot5mRiABjrye8WmvNqCbZsCgo2QCr
        0iFCjF7eglcbBTTQDfv8C3/yzW9ojDq98XzzqJ5JknJgnAyDtVhjCilkzGg/lQ9GsPw5nH
        iiASuoaQ1uXoZR8qj8NAnxlUy/756Yw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-JhLJ0bg_O8S9kyMoJojaIg-1; Fri, 27 Jan 2023 06:11:57 -0500
X-MC-Unique: JhLJ0bg_O8S9kyMoJojaIg-1
Received: by mail-ej1-f70.google.com with SMTP id hq7-20020a1709073f0700b0086fe36ed3d0so3208527ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHdIigeHoqEjPUOvZqjrQoWLn5deR3YQuYptQY45zS0=;
        b=Ol1jqCPgZhUwVFZ3gJWgY5MjMp8RNsR02s8ita3sdRniNdQSSi2bfLazZcm+x0MCvb
         1nPyr/gGNj2+aHdikKETmaINzsQeJXd44iTT/r2tq3wub6xXn9xqlb/fOd662s+pUuhc
         SjQCpAuhyPa9mulx23aP8wGfC2Asmtdf9adOd+jNS07nV4DYXV5UIx3PLUDBAvBt/ncZ
         dVESpiiSZKzfQS7Vi+PZfXBmV+NQOc3T3AejwYJXTCIjdZm7qa/mA3aVzNwituQ7xJ/N
         57EP5gk8Hh05OzIIKTR9jVUAnofemNIewOMCLglSbMegUqoLgHZ8AMj4JQ3KBmZN6i9s
         yXcQ==
X-Gm-Message-State: AFqh2kpAELDWorihBzRt3k4mya6Zw9ZEDPJswYHFOuZFCVTWtLtQuN6f
        /Dnu2GFNZKIaz1XN0fLzUZuR1jUJQbYZMr2hdne1x3pj6zCioj9qtoBOtysBwm+w2P55T/ybbXh
        F9Z+rlUgdDSgYYwQHq1tsO2r1
X-Received: by 2002:a17:907:9a09:b0:85d:3771:18b7 with SMTP id kr9-20020a1709079a0900b0085d377118b7mr42740075ejc.70.1674817915955;
        Fri, 27 Jan 2023 03:11:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsScJCcghnX87V9jwJo9iQJunv09UWVsejj9/e/mmA0Ci2VvxS4YOTGCYGulNVAT6QXBdRv0w==
X-Received: by 2002:a17:907:9a09:b0:85d:3771:18b7 with SMTP id kr9-20020a1709079a0900b0085d377118b7mr42740046ejc.70.1674817915717;
        Fri, 27 Jan 2023 03:11:55 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090668ce00b0084d3bf4498csm2082705ejr.140.2023.01.27.03.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:11:55 -0800 (PST)
Date:   Fri, 27 Jan 2023 06:11:49 -0500
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
Message-ID: <20230127061055-mutt-send-email-mst@kernel.org>
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128042945-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128042945-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:14:44AM -0500, Michael S. Tsirkin wrote:
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
> into vq index and this resets the device as a side effect
> (we actually do this multiple times, what e.g. writes of MSI vector
>  after the 1st reset do I have no idea).
> 
> mmio ccw and modern pci don't.
> 
> Given this has been with us for a while I am inlined to look for
> a global solution rather than tweaking each driver.
> 
> Given many drivers are supposed to work on legacy too, we know del_vqs
> includes a reset for many of them. So I think I see a better way to do
> this:
> 
> Add virtio_reset_device_and_del_vqs()
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
> 
> 
> Quite a lot of core work here. Jason are you still looking into
> hardening?
> 

Li Zetao, Jason, any updates. You guys looking into this?


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

