Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA136567CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiL0HWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiL0HWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:22:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF83212
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672125696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mEGiwEleRJj+ufJewl6x7iIcOZ+c/dqTegBY8jJTLFw=;
        b=NnLBodXPyk8gYJnvFHijXSowwPqqqLtUSOS82avVLwWrPEV9/N0Idwk5jwPcoFa1dsn4cN
        Yk+tXvJe9bDPIqjXpR2r3x2F3wlev/y5K7K0K5+gYyyE7oVKU/YvtMUuSDPSTdtstclsYq
        PdVXGEJ9RUgh8GUpWSAlsvPXszaGEl8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-518QzxZcMU2AA4TyjHH--A-1; Tue, 27 Dec 2022 02:21:35 -0500
X-MC-Unique: 518QzxZcMU2AA4TyjHH--A-1
Received: by mail-wm1-f69.google.com with SMTP id a6-20020a05600c224600b003d1f3ed49adso3002184wmm.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEGiwEleRJj+ufJewl6x7iIcOZ+c/dqTegBY8jJTLFw=;
        b=l0qqxuLadITgb/d6nkDThzfDkzhujtK9dM6W56PwWtKUSRcbCBGuRiu2j8/IhUGjcA
         SIOqk+nLXhb7atrdvS6A9i40rAhJF7PR4g0vA4TJsOqUR1M/jKQqz9MxV+dPEBiFLS+9
         tOaQ43QcnecbTKC9cDyDes4F4ngnJ5nn8KewMbiAtM00FCPm7ujCJmi/xTFc6lqMqEui
         +pXnL+qPoW6KF0lbJa7R94ZxAn4MMXXRdzdUVKbGhP7NDcxTPtL/7qYSNno8UGi1Weyk
         JUI/N9LcBUBs+lzTglM6vH7bVbkm1GcCaWhG1wk/9JcVBuqbx/zhwEQlTPOZwW8bUgIh
         aLww==
X-Gm-Message-State: AFqh2kr4rdU6nc2mhlvPODHgN51OJBKKZuvCAUMKFLN7ofntgjHOQ+wf
        1eJmDAm5Slc1OZkFff65yyQMNi/4RJgNCfrcJJucElZxlgbDBDx57Lo0/ajL9+7emzddPUmoIu+
        YVnCXiIOOIiG6gurVLrnvIWPf
X-Received: by 2002:adf:f590:0:b0:242:5cf0:2039 with SMTP id f16-20020adff590000000b002425cf02039mr12492837wro.65.1672125694464;
        Mon, 26 Dec 2022 23:21:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuzh/P3fMBgyffaJ+4YZm0UK7XcBjHgCs292arRQNyOfui9FBsi2J7c84AHLr0LcmbmmOOkNQ==
X-Received: by 2002:adf:f590:0:b0:242:5cf0:2039 with SMTP id f16-20020adff590000000b002425cf02039mr12492831wro.65.1672125694253;
        Mon, 26 Dec 2022 23:21:34 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d534f000000b002365254ea42sm12143624wrv.1.2022.12.26.23.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 23:21:33 -0800 (PST)
Date:   Tue, 27 Dec 2022 02:21:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com, alvaro.karsz@solid-run.com,
        eperezma@redhat.com
Subject: Re: [PATCH 2/4] virtio_ring: switch to use BAD_RING()
Message-ID: <20221227022023-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-3-jasowang@redhat.com>
 <20221226183604-mutt-send-email-mst@kernel.org>
 <CACGkMEuv9+o4anxnE8xewEaFj5Sc+bn4OFDrHYR6jyxb+3ApGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuv9+o4anxnE8xewEaFj5Sc+bn4OFDrHYR6jyxb+3ApGw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 11:51:02AM +0800, Jason Wang wrote:
> On Tue, Dec 27, 2022 at 7:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 26, 2022 at 03:49:06PM +0800, Jason Wang wrote:
> > > Switch to reuse BAD_RING() to allow common logic to be implemented in
> > > BAD_RING().
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes since V1:
> > > - switch to use BAD_RING in virtio_break_device()
> > > ---
> > >  drivers/virtio/virtio_ring.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 2e7689bb933b..5cfb2fa8abee 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -58,7 +58,8 @@
> > >       do {                                                    \
> > >               dev_err(&_vq->vq.vdev->dev,                     \
> > >                       "%s:"fmt, (_vq)->vq.name, ##args);      \
> > > -             (_vq)->broken = true;                           \
> > > +             /* Pairs with READ_ONCE() in virtqueue_is_broken(). */ \
> >
> > I don't think WRITE_ONCE/READ_ONCE pair as such. Can you point
> > me at documentation of such pairing?
> 
> Introduced by:
> 
> commit 60f0779862e4ab943810187752c462e85f5fa371
> Author: Parav Pandit <parav@nvidia.com>
> Date:   Wed Jul 21 17:26:45 2021 +0300
> 
>     virtio: Improve vq->broken access to avoid any compiler optimization
> 
> I think it might still apply here since virtqueue_is_broken() is still
> put into a loop inside wait_event().
> 
> Thanks

Oh I see. Maybe it's a response to some discussion we had at the time,
at this point I can no longer say what it meant.
But you are doing right not changing it here of course.

> >
> > > +             WRITE_ONCE((_vq)->broken, true);                       \
> > >       } while (0)
> > >  #define START_USE(vq)
> > >  #define END_USE(vq)
> > > @@ -2237,7 +2238,7 @@ bool virtqueue_notify(struct virtqueue *_vq)
> > >
> > >       /* Prod other side to tell it about changes. */
> > >       if (!vq->notify(_vq)) {
> > > -             vq->broken = true;
> > > +             BAD_RING(vq, "vq %d is broken\n", vq->vq.index);
> > >               return false;
> > >       }
> > >       return true;
> > > @@ -2786,8 +2787,7 @@ void virtio_break_device(struct virtio_device *dev)
> > >       list_for_each_entry(_vq, &dev->vqs, list) {
> > >               struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -             /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > > -             WRITE_ONCE(vq->broken, true);
> > > +             BAD_RING(vq, "Device break vq %d", _vq->index);
> > >       }
> > >       spin_unlock(&dev->vqs_list_lock);
> > >  }
> > > --
> > > 2.25.1
> >

