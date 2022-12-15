Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C12B64D865
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiLOJRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiLOJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:16:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B9B24BEE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671095758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lC0q2v1Ms1RwMBWk+EIJ5wdM8fzD9SD5v3dqY2kTOsc=;
        b=V9PZyhZm2PqE6UeNX9QVzoBlD0ROMyyDKXwHxYl8YYkWt1hdeJ4as2z/abHHyNkh0yrsk2
        pGOxEhvyaGNN/qcmoCFigm+1ZGfMJ7PETvgtIU9xgJhxo7QddECtknCq3myWJmh/kvtr00
        30cmPyiP3eT2lqbykJZ+sTv2Tf+O/IA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-168-zDepaKtjNqy_JBuYfYOt-Q-1; Thu, 15 Dec 2022 04:15:55 -0500
X-MC-Unique: zDepaKtjNqy_JBuYfYOt-Q-1
Received: by mail-ot1-f71.google.com with SMTP id v17-20020a9d7d11000000b0066c33c3e0easo3143757otn.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lC0q2v1Ms1RwMBWk+EIJ5wdM8fzD9SD5v3dqY2kTOsc=;
        b=2WjaJyB1RLKwEJbr4lrmtltUcGisnizvytXv4PmtNgoDn/cdg3Wjyv+xPG1hAq/4UA
         XtaQcoupCo0ttX6gwWsf0aLd6ZzQz8PV9aWQa93uiWnbtRpF12wfgrSPf57ft9n/epLR
         GCtYUi41HPRtoQ0bJ/35uqXeQUJw78KsOQhQmT+AUws/K7TaPXqBPksTN3blGwGpNUvS
         dqmM7ZPc9sj0HMfkAkw4aXS4ZpISQX4d7BpcfUW5fWM3XGiKsAxA6u8bE8jL5vFMtPKZ
         HhRKNSpR0F5HhlTbT3+ZnI2PGGoRU0wNNEYb3Kvm/MsWlXVzErrXJF16HqEEA6oC335Y
         FetA==
X-Gm-Message-State: ANoB5pkt9xXYFhsFUGSzJsMXFF/ro8fcN8io5yP/96lWGBj5EFU5ouX8
        qy3JbySiJE0XMQQDIgGQEwf5Iwv3IsF8swaItNBA28N53MCEADIWYW0QedCHBMk+m3oh3/TzTy1
        3tb/V5zOYSaWPW3fkFJnVjlJt1zBEpJp7vsFp2y2T
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id pu15-20020a0568709e8f00b00144a97b1ae2mr95005oab.35.1671095754729;
        Thu, 15 Dec 2022 01:15:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5EHbNOPkZfylg33J79++dPcOATXw0I6yodET6T4YfzW2bTB6xnRR0Mde8v49QFni7U7MDkwOsKmYmKzb3k5JU=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr95002oab.35.1671095754482; Thu, 15 Dec
 2022 01:15:54 -0800 (PST)
MIME-Version: 1.0
References: <20221215032719.72294-1-jasowang@redhat.com> <20221215034740-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221215034740-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 15 Dec 2022 17:15:43 +0800
Message-ID: <CACGkMEsLeCRDqyuyGzWw+kjYrTVDjUjOw6+xHESPT2D1p03=sQ@mail.gmail.com>
Subject: Re: [PATCH net V2] virtio-net: correctly enable callback during start_xmit
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuanzhuo@linux.alibaba.com
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

On Thu, Dec 15, 2022 at 5:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Dec 15, 2022 at 11:27:19AM +0800, Jason Wang wrote:
> > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > virtqueue callback via the following statement:
> >
> >         do {
> >            ......
> >       } while (use_napi && kick &&
> >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >
> > When NAPI is used and kick is false, the callback won't be enabled
> > here. And when the virtqueue is about to be full, the tx will be
> > disabled, but we still don't enable tx interrupt which will cause a TX
> > hang. This could be observed when using pktgen with burst enabled.
> >
> > Fixing this by trying to enable tx interrupt after we disable TX when
> > we're not using napi or kick is false.
> >
> > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > The patch is needed for -stable.
> > Changes since V1:
> > - enable tx interrupt after we disable tx
> > ---
> >  drivers/net/virtio_net.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 86e52454b5b5..dcf3a536d78a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1873,7 +1873,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >        */
> >       if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> >               netif_stop_subqueue(dev, qnum);
> > -             if (!use_napi &&
> > +             if ((!use_napi || !kick) &&
> >                   unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> >                       /* More just got used, free them then recheck. */
> >                       free_old_xmit_skbs(sq, false);
>
> This will work but the following lines are:
>
>                        if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>                                 netif_start_subqueue(dev, qnum);
>                                 virtqueue_disable_cb(sq->vq);
>                         }
>
>
> and I thought we are supposed to keep callbacks enabled with napi?

This seems to be the opposite logic of commit a7766ef18b33 that
disables callbacks for NAPI.

It said:

    There are currently two cases where we poll TX vq not in response to a
    callback: start xmit and rx napi.  We currently do this with callbacks
    enabled which can cause extra interrupts from the card.  Used not to be
    a big issue as we run with interrupts disabled but that is no longer the
    case, and in some cases the rate of spurious interrupts is so high
    linux detects this and actually kills the interrupt.

My undersatnding is that it tries to disable callbacks on TX.

> One of the ideas of napi is to free on napi callback, not here
> immediately.
>
> I think it is easier to just do a separate branch here. Along the
> lines of:
>
>                 if (use_napi) {
>                         if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>                                 virtqueue_napi_schedule(napi, vq);

This seems to be a new logic and it causes some delay in processing TX
(unnecessary NAPI).

>                 } else {
>                         ... old code ...
>                 }
>
> also reduces chances of regressions on !napi (which is not well tested)
> and keeps callbacks off while we free skbs.

I think my patch doesn't change the logic of !napi? (It checks !napi || kick).

Thanks

>
> No?
>
>
> > --
> > 2.25.1
>

