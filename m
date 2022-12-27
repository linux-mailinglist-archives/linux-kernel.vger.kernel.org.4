Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F3665672D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 04:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiL0DwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 22:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiL0DwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 22:52:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF9F31B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 19:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672113075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjSoArX5HY6uv1LNJcQFkVTx4PMTjeA2EWxVBFBuH60=;
        b=YiaFGhB9p2icQJkiHBBo2GbtVzG9DTKw7BQHy17Y3+J+6vJPGvkJ4Fj1ZqYEv6U/isAUht
        9Xo16Fm5mLb9hUww+IxTFffW1ylVwax2FYFIxeYRhvGRCZZe342t80khtybIYUTu7meYjQ
        28xbTz40gF4mWbLY6yl5TILdmo9OrHE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-e33c6rMDMPeIcSvnPC1zcg-1; Mon, 26 Dec 2022 22:51:14 -0500
X-MC-Unique: e33c6rMDMPeIcSvnPC1zcg-1
Received: by mail-oo1-f71.google.com with SMTP id i3-20020a4a9283000000b004a05ad0a3e7so5613107ooh.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 19:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjSoArX5HY6uv1LNJcQFkVTx4PMTjeA2EWxVBFBuH60=;
        b=hExn17dUN37x3ApTf2iWSFSL4tpqz8QaILXAGljw4PtaE1kk0Tb3QIrFvZHvHkHxsL
         sTivAAb2DuG+gUdGYQFnQ1LPgfIEqtG5BVoEJ+kZ6HiT8AbboIblSTtjsCZhV7aPqlu9
         dLbunBlsIEBfTtNv4MDP1CfwT4+WIe3xjjQLZQxt8iFBxAfRqy1AQWUV/G+WInhS2Fh1
         HoDIFAcwIWDINDdWe9iAW2nCSQZgOzu4jMI+bwZXLNjooAQ5nEZc7xCos+LHdEupvhlw
         E/T+jqKrCYAgPqfEwbby+QtvRXkzFeu7E/aAz26gQGlMlm+/JYLdea6WBaOMlEPvx3+D
         ArVA==
X-Gm-Message-State: AFqh2kqkebJkIYsa6DTANHrKYVbybt1N0k/f+S9u3MY+T87Uh3bGEoUR
        /pksi6/+etoW807+EF2eAc3WqbU96rLWc4EVBlKgj8ZHe+JASxyClZ2ue4TBTQ4xxV+nvNT3vF/
        XmoelqNknYFq0hAwdvb5v3cNLdh1gWr1DdDo4PSCy
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id c9-20020a544e89000000b0035c303dfe37mr721893oiy.35.1672113073642;
        Mon, 26 Dec 2022 19:51:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsCulI1T5cwjq8wWoaycCdKJLT0V8hvvOPAQssypU3+1Le5l09BrAre+/+QUnsIsGezI46+6cqY0LXGqi1asRg=
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id
 c9-20020a544e89000000b0035c303dfe37mr721883oiy.35.1672113073448; Mon, 26 Dec
 2022 19:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com> <20221226074908.8154-3-jasowang@redhat.com>
 <20221226183604-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221226183604-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 27 Dec 2022 11:51:02 +0800
Message-ID: <CACGkMEuv9+o4anxnE8xewEaFj5Sc+bn4OFDrHYR6jyxb+3ApGw@mail.gmail.com>
Subject: Re: [PATCH 2/4] virtio_ring: switch to use BAD_RING()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com, alvaro.karsz@solid-run.com,
        eperezma@redhat.com
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

On Tue, Dec 27, 2022 at 7:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 26, 2022 at 03:49:06PM +0800, Jason Wang wrote:
> > Switch to reuse BAD_RING() to allow common logic to be implemented in
> > BAD_RING().
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - switch to use BAD_RING in virtio_break_device()
> > ---
> >  drivers/virtio/virtio_ring.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 2e7689bb933b..5cfb2fa8abee 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -58,7 +58,8 @@
> >       do {                                                    \
> >               dev_err(&_vq->vq.vdev->dev,                     \
> >                       "%s:"fmt, (_vq)->vq.name, ##args);      \
> > -             (_vq)->broken = true;                           \
> > +             /* Pairs with READ_ONCE() in virtqueue_is_broken(). */ \
>
> I don't think WRITE_ONCE/READ_ONCE pair as such. Can you point
> me at documentation of such pairing?

Introduced by:

commit 60f0779862e4ab943810187752c462e85f5fa371
Author: Parav Pandit <parav@nvidia.com>
Date:   Wed Jul 21 17:26:45 2021 +0300

    virtio: Improve vq->broken access to avoid any compiler optimization

I think it might still apply here since virtqueue_is_broken() is still
put into a loop inside wait_event().

Thanks

>
> > +             WRITE_ONCE((_vq)->broken, true);                       \
> >       } while (0)
> >  #define START_USE(vq)
> >  #define END_USE(vq)
> > @@ -2237,7 +2238,7 @@ bool virtqueue_notify(struct virtqueue *_vq)
> >
> >       /* Prod other side to tell it about changes. */
> >       if (!vq->notify(_vq)) {
> > -             vq->broken = true;
> > +             BAD_RING(vq, "vq %d is broken\n", vq->vq.index);
> >               return false;
> >       }
> >       return true;
> > @@ -2786,8 +2787,7 @@ void virtio_break_device(struct virtio_device *dev)
> >       list_for_each_entry(_vq, &dev->vqs, list) {
> >               struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > -             /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > -             WRITE_ONCE(vq->broken, true);
> > +             BAD_RING(vq, "Device break vq %d", _vq->index);
> >       }
> >       spin_unlock(&dev->vqs_list_lock);
> >  }
> > --
> > 2.25.1
>

