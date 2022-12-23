Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECC0654C80
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiLWGau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiLWGap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:30:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56545165B1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671776996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WiikjAKCvnHp1vgV1Kaih+JCYQ6gPd1e+8fFKg9J1Ac=;
        b=PcIeEK6upoqP38jhBXJSrKW/11SbeaTHWMPX7sQB/JrLbNAMMCBSQLKc4E+jlxHPwWj/sn
        FgvaShf1x24CXXpgHAs1PUu0i1kH4pnst2Pxc01jL4ZkkDF85PwSmid+M4l8KreeMipo+w
        Qm259/zFj9EpBLryw49lz1mkWkZL9LU=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-j54IhNHzPuu8n2s2jUt5Aw-1; Fri, 23 Dec 2022 01:29:55 -0500
X-MC-Unique: j54IhNHzPuu8n2s2jUt5Aw-1
Received: by mail-ot1-f69.google.com with SMTP id cj4-20020a056830640400b0066dee63bd77so2152639otb.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiikjAKCvnHp1vgV1Kaih+JCYQ6gPd1e+8fFKg9J1Ac=;
        b=JNpho32aMl6UJFrJLVmjfB/Op7ZHHrjbQ7ZFTSCGI5ZmlLk76AJxITiV8issdMa5QP
         SC4i558Rn3j6sTe0h9alRluHyihm3npHsBQbNwSnnbGk1/e35jSg/DOVZUV0TOBHhjgC
         SpYuTX1AfN2kvHyoRfz3+homHeyuNlpK732Azb2LzCtOT9m00pfLGfK8a2m/VUG8p3rh
         z5A6HXsh9kOaHP8DuP68/yn+3nlknFpMo1rSV2w1L8EbCK0Di39iMmL8aPEknMwq/aqt
         s4CnM/Y5bn035dD55vJ9nU8ii1jE/s3JIAuoRVHWm+SyECQnGERnbXE0+nwL87zlnwhX
         bjbA==
X-Gm-Message-State: AFqh2kp/4rf4Udtx88Lysu7ms0h6h4KBFyI0PcVvst0+ZkEPUxim+pJR
        i6HRWxdoG4ItE8ZcAv4sq/HsT7Auk6nr3yo0/fQFJCD9TXxDEHuXLxtR/dKhrzeubya0cgf1xLc
        jQLC3eN5vEenqhFn8CXxho198xcKZzOTESUMypUsJ
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id 17-20020aca1111000000b0035e7a427ab5mr431955oir.280.1671776994360;
        Thu, 22 Dec 2022 22:29:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvwAmVj4pYtzy/MEZCDVErGxTjIQ/hOw+CgSBao5LSUxKEJOkd++cRwrwP4isqzNYUGYGNhsdIslmcmRpir8RE=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr431949oir.280.1671776994092; Thu, 22 Dec
 2022 22:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20221215032719.72294-1-jasowang@redhat.com> <20221215034740-mutt-send-email-mst@kernel.org>
 <CACGkMEsLeCRDqyuyGzWw+kjYrTVDjUjOw6+xHESPT2D1p03=sQ@mail.gmail.com>
 <20221215042918-mutt-send-email-mst@kernel.org> <CACGkMEsbvTQrEp5dmQRHp58Mu=E7f433Xrvsbs4nZMA5R3B6mQ@mail.gmail.com>
In-Reply-To: <CACGkMEsbvTQrEp5dmQRHp58Mu=E7f433Xrvsbs4nZMA5R3B6mQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 23 Dec 2022 14:29:43 +0800
Message-ID: <CACGkMEsu_OFFs15d2dzNbfSjzAZfYXLn9CNcO3ELPbDqZsndzg@mail.gmail.com>
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

On Fri, Dec 16, 2022 at 11:43 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Dec 15, 2022 at 5:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Dec 15, 2022 at 05:15:43PM +0800, Jason Wang wrote:
> > > On Thu, Dec 15, 2022 at 5:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Dec 15, 2022 at 11:27:19AM +0800, Jason Wang wrote:
> > > > > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > > > > virtqueue callback via the following statement:
> > > > >
> > > > >         do {
> > > > >            ......
> > > > >       } while (use_napi && kick &&
> > > > >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > > >
> > > > > When NAPI is used and kick is false, the callback won't be enabled
> > > > > here. And when the virtqueue is about to be full, the tx will be
> > > > > disabled, but we still don't enable tx interrupt which will cause a TX
> > > > > hang. This could be observed when using pktgen with burst enabled.
> > > > >
> > > > > Fixing this by trying to enable tx interrupt after we disable TX when
> > > > > we're not using napi or kick is false.
> > > > >
> > > > > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > > The patch is needed for -stable.
> > > > > Changes since V1:
> > > > > - enable tx interrupt after we disable tx
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 86e52454b5b5..dcf3a536d78a 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -1873,7 +1873,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > > >        */
> > > > >       if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > > >               netif_stop_subqueue(dev, qnum);
> > > > > -             if (!use_napi &&
> > > > > +             if ((!use_napi || !kick) &&
> > > > >                   unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > > > >                       /* More just got used, free them then recheck. */
> > > > >                       free_old_xmit_skbs(sq, false);
> > > >
> > > > This will work but the following lines are:
> > > >
> > > >                        if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > > >                                 netif_start_subqueue(dev, qnum);
> > > >                                 virtqueue_disable_cb(sq->vq);
> > > >                         }
> > > >
> > > >
> > > > and I thought we are supposed to keep callbacks enabled with napi?
> > >
> > > This seems to be the opposite logic of commit a7766ef18b33 that
> > > disables callbacks for NAPI.
> > >
> > > It said:
> > >
> > >     There are currently two cases where we poll TX vq not in response to a
> > >     callback: start xmit and rx napi.  We currently do this with callbacks
> > >     enabled which can cause extra interrupts from the card.  Used not to be
> > >     a big issue as we run with interrupts disabled but that is no longer the
> > >     case, and in some cases the rate of spurious interrupts is so high
> > >     linux detects this and actually kills the interrupt.
> > >
> > > My undersatnding is that it tries to disable callbacks on TX.
> >
> > I think we want to disable callbacks while polling, yes. here we are not
> > polling, and I think we want a callback because otherwise nothing will
> > orphan skbs and a socket can be blocked, not transmitting anything - a
> > deadlock.
>
> I'm not sure how I got here, did you mean a partial revert of
> a7766ef18b33 (the part that disables TX callbacks on start_xmit)?

Michael, any idea on this?

Thanks

>
> Btw, I plan to remove non NAPI mode completely, since it was disabled
> by default for years and we don't see any complaint, then we may have
> modern features like BQL and better TCP performance. In that sense we
> may simply keep tx callback open as most of modern NIC did.
>
> >
> > > > One of the ideas of napi is to free on napi callback, not here
> > > > immediately.
> > > >
> > > > I think it is easier to just do a separate branch here. Along the
> > > > lines of:
> > > >
> > > >                 if (use_napi) {
> > > >                         if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > > >                                 virtqueue_napi_schedule(napi, vq);
> > >
> > > This seems to be a new logic and it causes some delay in processing TX
> > > (unnecessary NAPI).
> >
> > That's good, we overloaded the queue so we are already going
> > too fast, deferring tx so queue has chance to drain
> > will allow better batching in the qdisc.
>
> I meant, compare to
>
> 1) schedule NAPI and poll TX
>
> The current code did
>
> 2) poll TX immediately
>
> 2) seems faster?
>
> Thanks
>
> >
> > > >                 } else {
> > > >                         ... old code ...
> > > >                 }
> > > >
> > > > also reduces chances of regressions on !napi (which is not well tested)
> > > > and keeps callbacks off while we free skbs.
> > >
> > > I think my patch doesn't change the logic of !napi? (It checks !napi || kick).
> > >
> > > Thanks
> >
> > I agree it doesn't seem to as written.
> >
> > > >
> > > > No?
> > > >
> > > >
> > > > > --
> > > > > 2.25.1
> > > >
> >

