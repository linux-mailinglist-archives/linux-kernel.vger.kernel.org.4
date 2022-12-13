Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A376664AE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiLMDor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiLMDoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:44:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFD4193EF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670903029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=256Ct247/EiVmrEdEn67dwnBON0/XMOLy97CHVgBe6k=;
        b=Vc6lLK8a+z+WlUFUabX1w1MrSDLlvjnp0C1eRAMnA6wwhmCPd2THr6yF+ancbtJoKFVCUP
        B4pQ4wwLyNU1POSGqinSuTU9FdT5K6LLTQhay07wF0fNkwBwJjImnSBUawyVKbdBZDCWph
        F3UYRGNTqN+qrtbnfB8QeUizZlRm828=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-VY0JqwBvPnuoeasAf2w0kg-1; Mon, 12 Dec 2022 22:43:47 -0500
X-MC-Unique: VY0JqwBvPnuoeasAf2w0kg-1
Received: by mail-ot1-f70.google.com with SMTP id l31-20020a9d1b22000000b0066c48e9249fso7930358otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=256Ct247/EiVmrEdEn67dwnBON0/XMOLy97CHVgBe6k=;
        b=J+xDpwXN0y/2aBq3zJejZTxi/2Z0Au0+g+gIlww/+nD8ZIBFbZ3O/nWipAVXblElpK
         Eywp7BKJ2KaXeOtMX+tshIs4FJ02wCbctCZ7p3pjHZR6Uwul0vt/iQpXVTFSanaZUFVW
         uD8m5sw8Y+v4bvqQfMulh+AQ2S/A/Veb+IXyEdxwyw/+AerofBrJvXNwvWQ4iXTxIeq7
         CTIqUqLoIeREzO3IV1ywv7CCexgc4+0LIib1fg+2qhxkTM6rN3wotuehIpw323AuZA0u
         4t/XiiN8fpIqBWPA2BTyhbtbpvKOc6zJE8+QMPPSQVm5UclHllCqwEv9MorLlvM2IMTw
         ysUA==
X-Gm-Message-State: ANoB5pmsQLh2GpA/ysYRQBMfRZHO9V+DzRZZQ/3ejC8E0zgShAvsIqo1
        ZhZQ65YBT6ML6oM10U75Cmn99cPZ8Lvs3H6Kk80k3jEKn+T5AYyOyNeU1S1A5/Wwct0Tx6rucpU
        clU7YAVNJUqd/NpI7RpfBjSpTilYzSd2MbbgO9Wyw
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id u12-20020a056808114c00b0035e7a427ab5mr78514oiu.280.1670903027122;
        Mon, 12 Dec 2022 19:43:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4i4kic2ykAAWbr0s266j2XeYnzV4cUv9APvGz4jsQq5Lkz/4gL5C2yVDhzy6BQW2tEKIdWrVGMCJkUIbL2Bvk=
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id
 u12-20020a056808114c00b0035e7a427ab5mr78511oiu.280.1670903026927; Mon, 12 Dec
 2022 19:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20221212091029.54390-1-jasowang@redhat.com> <20221212042144-mutt-send-email-mst@kernel.org>
 <1670902391.9610498-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1670902391.9610498-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 13 Dec 2022 11:43:36 +0800
Message-ID: <CACGkMEu=1CcoNvvV9M+QrG5sLUBoPYkZ3DvUe+pLc1fSvgLuHA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: correctly enable callback during start_xmit
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:38 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Mon, 12 Dec 2022 04:25:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Dec 12, 2022 at 05:10:29PM +0800, Jason Wang wrote:
> > > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > > virtqueue callback via the following statement:
> > >
> > >         do {
> > >            ......
> > >     } while (use_napi && kick &&
> > >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >
> > > This will cause a missing call to virtqueue_enable_cb_delayed() when
> > > kick is false. Fixing this by removing the checking of the kick from
> > > the condition to make sure callback is enabled correctly.
> > >
> > > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > The patch is needed for -stable.
> >
> > stable rules don't allow for theoretical fixes. Was a problem observed?

Yes, running a pktgen sample script can lead to a tx timeout.

> >
> > > ---
> > >  drivers/net/virtio_net.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 86e52454b5b5..44d7daf0267b 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1834,8 +1834,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > >
> > >             free_old_xmit_skbs(sq, false);
> > >
> > > -   } while (use_napi && kick &&
> > > -          unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > +   } while (use_napi &&
> > > +            unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >
> >
> > A bit more explanation pls.  kick simply means !netdev_xmit_more -
> > if it's false we know there will be another packet, then transmissing
> > that packet will invoke virtqueue_enable_cb_delayed. No?
>
> It's just that there may be a next packet, but in fact there may not be.
> For example, the vq is full, and the driver stops the queue.

Exactly, when the queue is about to be full we disable tx and wait for
the next tx interrupt to re-enable tx.

Thanks

>
> Thanks.
>
> >
> >
> >
> >
> >
> > >     /* timestamp packet in software */
> > >     skb_tx_timestamp(skb);
> > > --
> > > 2.25.1
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

