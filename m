Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF0463715E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKXEGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKXEGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:06:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF609C7695
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669262706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JbHIrOAEJY2VHotkKviSX7yoTGs0jlKcUqZ6ox6ZroQ=;
        b=Nf6zbW7x3PmDyv/J7WKKAn0tMXec48QUIhFnhGs0N7km4dpM7TFepnmZcOEwn0LoilhUWo
        tdIjvBi5cRTKwozvFIVnxOyT0AKNCRDW4SrXb6XrKCQGGYjBMsGXQU/AInUtvJ85mPWDvX
        VdCSGGFmBjunlxu0+dZuuyZvrQKhGYI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-92--RFCR_T9Nym9KmFWsgNVDg-1; Wed, 23 Nov 2022 23:05:04 -0500
X-MC-Unique: -RFCR_T9Nym9KmFWsgNVDg-1
Received: by mail-oi1-f199.google.com with SMTP id a5-20020aca1a05000000b00359de30f06dso245295oia.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbHIrOAEJY2VHotkKviSX7yoTGs0jlKcUqZ6ox6ZroQ=;
        b=ssHWRvm0LCcb5RjmQWZVx5KnroPx/XCBA3SzmYYrkkhSyXSonbI9Siw5LXcKq61MX0
         HztSX6prY8soiMaFAkygaABvy7ppyvv8chgtAZo6Pi2nue9QGPhC1MfjQSKn5kNUlUGX
         shHXxHESvmC9EQGlgaaOuOjOvQNMuRIsdysUqR07nQ6SNy3+Bwruo6qKRP/L52uK2zsS
         /mo+0hPExdCGgzBG0I42dibPDJiuHIYDq2edPhXxJhZvwkSA44lr4nGVL0cR/UvFK/2S
         ll4VsS70njDcIJc/by1qCJVZJeJLxZjgJdA3AW1znMxc8pyfa3CoWUE63kVWFTzgLc7Y
         /lEw==
X-Gm-Message-State: ANoB5pkYSkwBD4WNZyeLU4I4C7Fkzb1OTyPTGx81YVZu1IUvgMMCkCBO
        IffRdAorsRv8rRhBw4iUansQJYvRkW2ovEeKb7JCDtzGz4pSsKV4WoRPBRPXyOp7lSsxD+gyvMD
        2i0arcJXtf/eLAQQ2A8xjWL22+co0aIr9yW1PQnY1
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id cm5-20020a056830650500b0066cfb5b4904mr15941030otb.237.1669262703982;
        Wed, 23 Nov 2022 20:05:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5sw+67nFb3qeCA+MdVXBVeUpPzXpCINULU+SJbaMSeLUQ671wqHEOfp3AX5XyxRAQKpk1UIFH17sHj9fcEP5U=
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr15941025otb.237.1669262703739; Wed, 23
 Nov 2022 20:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com> <20221113134442.152695-7-elic@nvidia.com>
 <CACGkMEt+7kKD8_q_OFKURbFR1W=YbJpcuwZq5bf5jC4qzE8PEA@mail.gmail.com>
 <DM8PR12MB54008F8D33409AFCA5878AAAAB059@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEuoMx2WbUh7KHQXLHuDxQHqhp5xEL8aW3s2wOmBZdv5cA@mail.gmail.com>
In-Reply-To: <CACGkMEuoMx2WbUh7KHQXLHuDxQHqhp5xEL8aW3s2wOmBZdv5cA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 24 Nov 2022 12:04:52 +0800
Message-ID: <CACGkMEsoWP2z=5sLeqXTB0RLxPW=S-UJNLKFpuPEQVDjX-Hatw@mail.gmail.com>
Subject: Re: [PATCH 6/7] vdpa/mlx5: Avoid using reslock in event_handler
To:     Eli Cohen <elic@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
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

On Wed, Nov 23, 2022 at 12:00 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Nov 14, 2022 at 4:58 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Monday, 14 November 2022 9:53
> > > To: Eli Cohen <elic@nvidia.com>
> > > Cc: mst@redhat.com; linux-kernel@vger.kernel.org; virtualization@lists.linux-
> > > foundation.org; si-wei.liu@oracle.com; eperezma@redhat.com;
> > > lulu@redhat.com
> > > Subject: Re: [PATCH 6/7] vdpa/mlx5: Avoid using reslock in event_handler
> > >
> > > On Sun, Nov 13, 2022 at 9:45 PM Eli Cohen <elic@nvidia.com> wrote:
> > > >
> > > > event_handler runs under atomic context and may not acquire reslock. We
> > > > can still guarantee that the handler won't be called after suspend by
> > > > clearing nb_registered, unregistering the handler and flushing the
> > > > workqueue.
> > > >
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > ---
> > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 14 +++-----------
> > > >  1 file changed, 3 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index 6e6490c85be2..bebfba530247 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -2872,8 +2872,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device
> > > *vdev)
> > > >         int i;
> > > >
> > > >         down_write(&ndev->reslock);
> > > > -       mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > > >         ndev->nb_registered = false;
> > > > +       mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > >
> > > I wonder why this can help anything.
> > I think you were concerned that async events will come when the device was suspended. Since we can't take reslock, I think this guarantees that we won't get any events after suspension.
> >
>
> Ok, I see.
>
> > > And if it does, we have simliar
> > > logic in mlx5_vdpa_dev_del() do we need to fix that as well?
> > >
> > We have the same construct there only that I set nb_registered = false after unregistering the notifier. So I probably need to move it before mlx5_notifier_unregister().
>
> Right.
>
> Thanks

So I'm fine with this patch.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> >
> > > Thanks
> > >
> > > >         flush_workqueue(ndev->mvdev.wq);
> > > >         for (i = 0; i < ndev->cur_num_vqs; i++) {
> > > >                 mvq = &ndev->vqs[i];
> > > > @@ -3051,7 +3051,7 @@ static void update_carrier(struct work_struct
> > > *work)
> > > >         else
> > > >                 ndev->config.status &= cpu_to_mlx5vdpa16(mvdev,
> > > ~VIRTIO_NET_S_LINK_UP);
> > > >
> > > > -       if (ndev->config_cb.callback)
> > > > +       if (ndev->nb_registered && ndev->config_cb.callback)
> > > >                 ndev->config_cb.callback(ndev->config_cb.private);
> > > >
> > > >         kfree(wqent);
> > > > @@ -3068,21 +3068,13 @@ static int event_handler(struct notifier_block
> > > *nb, unsigned long event, void *p
> > > >                 switch (eqe->sub_type) {
> > > >                 case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
> > > >                 case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> > > > -                       down_read(&ndev->reslock);
> > > > -                       if (!ndev->nb_registered) {
> > > > -                               up_read(&ndev->reslock);
> > > > -                               return NOTIFY_DONE;
> > > > -                       }
> > > >                         wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> > > > -                       if (!wqent) {
> > > > -                               up_read(&ndev->reslock);
> > > > +                       if (!wqent)
> > > >                                 return NOTIFY_DONE;
> > > > -                       }
> > > >
> > > >                         wqent->mvdev = &ndev->mvdev;
> > > >                         INIT_WORK(&wqent->work, update_carrier);
> > > >                         queue_work(ndev->mvdev.wq, &wqent->work);
> > > > -                       up_read(&ndev->reslock);
> > > >                         ret = NOTIFY_OK;
> > > >                         break;
> > > >                 default:
> > > > --
> > > > 2.38.1
> > > >
> >

