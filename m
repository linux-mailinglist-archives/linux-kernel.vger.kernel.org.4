Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41764E671
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLPDoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 22:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiLPDoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36AB40463
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671162207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zfz+hZsu0mSAfvWAnAaAGFxMGv6r+4O1MrzGOXMUmB0=;
        b=OYOLlqLA3thT6abxI5LkqFhaqymNoT28YHyr8DeXX6VfcxQZEF0WD0chM/ZMkPo/nsObWn
        xF1PkxYMnCNLLE1PIJGcHOv3ayTCRDeQj/eXYR9zswBqR62GZ4qu4z0NOCIsfypncCxWac
        qyxzN7XvEhVo1NRPivthAiflwUGzcMI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-x_F2VRueMwaogdSH6T6TRQ-1; Thu, 15 Dec 2022 22:43:25 -0500
X-MC-Unique: x_F2VRueMwaogdSH6T6TRQ-1
Received: by mail-oo1-f71.google.com with SMTP id a9-20020a4a9b09000000b004a0bc0614fdso649128ook.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfz+hZsu0mSAfvWAnAaAGFxMGv6r+4O1MrzGOXMUmB0=;
        b=SXnAMr+lTXsf/PTSbSqssMbLQJnY1jswgO+451aKz/hISGy+z2tl+jmb5xnA3U2dK5
         Cl2eaqA0yu0H9Y859K+J8lU814VbxPkgWMGY/jarFe8DK5d19HWzFzMkpd0lprCvjh2Y
         YsmlLmwZPC+5xpshv80c6wKrm6iukTsSJqFkjSwXZ2vp7YPmPzUp7P407nQbiUs1liTH
         Cj7a/jmwixsSNX4c5Z+AlUoA4JrT/vkGdH9PeyL3ZkSuy0Uk0zemLNzpTVA8IMbLvh1n
         Nrr58Eaq+nbBgoR2tb9Qptpo1LdvhbKbAGeUxRNMv2XQchSPqmQB23CWaqg9RMVa6ey2
         /A+Q==
X-Gm-Message-State: ANoB5pk13NLgJBbBbJPqVymszo2XQBNh7L0FrACZDyDOuTZyzF0/lKDa
        A52PNHBMW1tUfC/b6jmaXy5PCuGELWHRZCgi2wAc6j4HCzwpA2dpfswykADV9v/oj+v0pXXcIxl
        MHhQ07I13vfEM5Dcg0NvTnqPIrsMusJmLVDfRVL3G
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id pu15-20020a0568709e8f00b00144a97b1ae2mr319389oab.35.1671162204861;
        Thu, 15 Dec 2022 19:43:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7OmOp/XpirrXRViBtMxKqtenidH9XAN95sX4U25/bIv5XYq0XBM55D6y7jxPwBaziM5LOxB28ONerqMfvW4eI=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr319384oab.35.1671162204619; Thu, 15
 Dec 2022 19:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20221215032719.72294-1-jasowang@redhat.com> <20221215034740-mutt-send-email-mst@kernel.org>
 <CACGkMEsLeCRDqyuyGzWw+kjYrTVDjUjOw6+xHESPT2D1p03=sQ@mail.gmail.com> <20221215042918-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221215042918-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 16 Dec 2022 11:43:13 +0800
Message-ID: <CACGkMEsbvTQrEp5dmQRHp58Mu=E7f433Xrvsbs4nZMA5R3B6mQ@mail.gmail.com>
Subject: Re: [PATCH net V2] virtio-net: correctly enable callback during start_xmit
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuanzhuo@linux.alibaba.com
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

On Thu, Dec 15, 2022 at 5:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Dec 15, 2022 at 05:15:43PM +0800, Jason Wang wrote:
> > On Thu, Dec 15, 2022 at 5:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Dec 15, 2022 at 11:27:19AM +0800, Jason Wang wrote:
> > > > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > > > virtqueue callback via the following statement:
> > > >
> > > >         do {
> > > >            ......
> > > >       } while (use_napi && kick &&
> > > >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > >
> > > > When NAPI is used and kick is false, the callback won't be enabled
> > > > here. And when the virtqueue is about to be full, the tx will be
> > > > disabled, but we still don't enable tx interrupt which will cause a TX
> > > > hang. This could be observed when using pktgen with burst enabled.
> > > >
> > > > Fixing this by trying to enable tx interrupt after we disable TX when
> > > > we're not using napi or kick is false.
> > > >
> > > > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > > The patch is needed for -stable.
> > > > Changes since V1:
> > > > - enable tx interrupt after we disable tx
> > > > ---
> > > >  drivers/net/virtio_net.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 86e52454b5b5..dcf3a536d78a 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -1873,7 +1873,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > >        */
> > > >       if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > >               netif_stop_subqueue(dev, qnum);
> > > > -             if (!use_napi &&
> > > > +             if ((!use_napi || !kick) &&
> > > >                   unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > > >                       /* More just got used, free them then recheck. */
> > > >                       free_old_xmit_skbs(sq, false);
> > >
> > > This will work but the following lines are:
> > >
> > >                        if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > >                                 netif_start_subqueue(dev, qnum);
> > >                                 virtqueue_disable_cb(sq->vq);
> > >                         }
> > >
> > >
> > > and I thought we are supposed to keep callbacks enabled with napi?
> >
> > This seems to be the opposite logic of commit a7766ef18b33 that
> > disables callbacks for NAPI.
> >
> > It said:
> >
> >     There are currently two cases where we poll TX vq not in response to a
> >     callback: start xmit and rx napi.  We currently do this with callbacks
> >     enabled which can cause extra interrupts from the card.  Used not to be
> >     a big issue as we run with interrupts disabled but that is no longer the
> >     case, and in some cases the rate of spurious interrupts is so high
> >     linux detects this and actually kills the interrupt.
> >
> > My undersatnding is that it tries to disable callbacks on TX.
>
> I think we want to disable callbacks while polling, yes. here we are not
> polling, and I think we want a callback because otherwise nothing will
> orphan skbs and a socket can be blocked, not transmitting anything - a
> deadlock.

I'm not sure how I got here, did you mean a partial revert of
a7766ef18b33 (the part that disables TX callbacks on start_xmit)?

Btw, I plan to remove non NAPI mode completely, since it was disabled
by default for years and we don't see any complaint, then we may have
modern features like BQL and better TCP performance. In that sense we
may simply keep tx callback open as most of modern NIC did.

>
> > > One of the ideas of napi is to free on napi callback, not here
> > > immediately.
> > >
> > > I think it is easier to just do a separate branch here. Along the
> > > lines of:
> > >
> > >                 if (use_napi) {
> > >                         if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > >                                 virtqueue_napi_schedule(napi, vq);
> >
> > This seems to be a new logic and it causes some delay in processing TX
> > (unnecessary NAPI).
>
> That's good, we overloaded the queue so we are already going
> too fast, deferring tx so queue has chance to drain
> will allow better batching in the qdisc.

I meant, compare to

1) schedule NAPI and poll TX

The current code did

2) poll TX immediately

2) seems faster?

Thanks

>
> > >                 } else {
> > >                         ... old code ...
> > >                 }
> > >
> > > also reduces chances of regressions on !napi (which is not well tested)
> > > and keeps callbacks off while we free skbs.
> >
> > I think my patch doesn't change the logic of !napi? (It checks !napi || kick).
> >
> > Thanks
>
> I agree it doesn't seem to as written.
>
> > >
> > > No?
> > >
> > >
> > > > --
> > > > 2.25.1
> > >
>

