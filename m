Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD96964B03C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiLMHNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiLMHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:13:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027A25E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670915556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rMebFWdEdtkJjFFWamjr+NWxVNJ3wKKuSE9Jjikeu1s=;
        b=TMLJT1Qk99ISEgCbu8CsBZ65p+HHMLIc/IhhjmS2kaViISGHJCyC4QNV+fWJ4aWbmmk1k4
        YMkjHDhEs8JKEFecyiurV26UTOJOmposYmolEm1wzpjZ1WgTqj4E4vO7sBJfpdOGjmJhv+
        CFbhj0fibXeDbeQFzE91kX3wK0L7Goo=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-185-NwjnbCekNDKlmlgHh43ffg-1; Tue, 13 Dec 2022 02:12:35 -0500
X-MC-Unique: NwjnbCekNDKlmlgHh43ffg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-144a21f5c25so3398609fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMebFWdEdtkJjFFWamjr+NWxVNJ3wKKuSE9Jjikeu1s=;
        b=MBhNdXL6GXwOVEJm08zqFXl2HeB/pDpxnO6a0IOuMlVcV9BwkLGdAHaIjMjSz2JqTE
         hR98pVyl2t5j9IIu/nIpTXWd5hRlZcy4kETO0kCaFZ/MT9e6e9M/g427s5LLFEnteusX
         851PaICsBlPh5vV3eXG+4ybRUCcyD0gXwmWiGHDTcgIti/DSL9tSzFNAw4Aq3SZywd3S
         2LnpmgDgJgSxtrf0/rw4ch5BFkxPBtPUTeCxrkIGA6xsQybeQrJgmq02QHyfjPAap5Na
         vS8WifKdJeYZTL8stUx2RRfWsfJD4JYZsIkYQIe7BqeyHY2H49ebGTYNXZW9Z0HiOl1z
         8+SQ==
X-Gm-Message-State: ANoB5pn3Ha+5rubA9wumdO4sR5P4oCNcIuPNl/eDB9rlWhPpmWY7Rm5Z
        coIGus+0EFoFiC/zvhIfmHrbWRYoDvbwEwI8Kv1O7fySt/Vq+rDHXPfvoTJlaDftPEmqTtg1JAf
        vA5LtJhkwfRb0ULIomaGTXywPo/h3BW92UecvSzmx
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id u12-20020a056808114c00b0035e7a427ab5mr101803oiu.280.1670915554328;
        Mon, 12 Dec 2022 23:12:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7bOxvXY5V4JuTJUsGbVhkXkh2+HEeWmtUf1eSQx3I5QF29ADy9ENjFVggDW3zwY3hcJPkL8/gGz7lS+U6DYgM=
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id
 u12-20020a056808114c00b0035e7a427ab5mr101800oiu.280.1670915554149; Mon, 12
 Dec 2022 23:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20220907060110.4511-1-jasowang@redhat.com> <DM8PR12MB540034620ADF0AE749C2D099AB419@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEvjgyxs3HX_ZzUbMticntqnUxDQJMrr2MqTBwuRB7jCdw@mail.gmail.com> <DM8PR12MB5400209468A07467499B19BDAB419@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400209468A07467499B19BDAB419@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 13 Dec 2022 15:12:23 +0800
Message-ID: <CACGkMEuXbs-2KB28Kft+5jjdQdmMtVTKgjJ26x_U3=tNHvThZw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: conditionally fill max max queue pair for stats
To:     Eli Cohen <elic@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, Sep 7, 2022 at 4:11 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, 7 September 2022 9:53
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH] vdpa: conditionally fill max max queue pair for stats
> >
> > On Wed, Sep 7, 2022 at 2:11 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Wednesday, 7 September 2022 9:01
> > > > To: mst@redhat.com; jasowang@redhat.com; Eli Cohen
> > <elic@nvidia.com>;
> > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > > > Subject: [PATCH] vdpa: conditionally fill max max queue pair for stats
> > > >
> > > > For the device without multiqueue feature, we will read 0 as
> > > > max_virtqueue_pairs from the config.
> > > If this is the case for other vdpa vendor drivers, shouldn't we fix it there?
> > After all,
> > > config->max_virtqueue_pairs should always show valid values.
> >
> > Not for the case when the device doesn't offer MQ. According to the
> > spec, the max_virtqueue_pairs doesn't exist in this case.
> >
> I see, thanks.
>
> > >
> > > > So if we fill
> > > > VDPA_ATTR_DEV_NET_CFG_MAX_VQP with the value we read from the
> > > > config
> > > > we will confuse the user.
> > > >
> > > > Fixing this by only filling the value when multiqueue is offered by
> > > > the device so userspace can assume 1 when the attr is not provided.
> > > >
> > > > Fixes: 13b00b135665c("vdpa: Add support for querying vendor
> > statistics")
> > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/vdpa/vdpa.c | 9 ++++-----
> > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > index c06c02704461..bc328197263f 100644
> > > > --- a/drivers/vdpa/vdpa.c
> > > > +++ b/drivers/vdpa/vdpa.c
> > > > @@ -894,7 +894,6 @@ static int vdpa_fill_stats_rec(struct vdpa_device
> > > > *vdev, struct sk_buff *msg,
> > > >  {
> > > >       struct virtio_net_config config = {};
> > > >       u64 features;
> > > > -     u16 max_vqp;
> > > >       u8 status;
> > > >       int err;
> > > >
> > > > @@ -905,15 +904,15 @@ static int vdpa_fill_stats_rec(struct
> > vdpa_device
> > > > *vdev, struct sk_buff *msg,
> > > >       }
> > > >       vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> > > >
> > > > -     max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
> > > > -     if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> > > > max_vqp))
> > > > -             return -EMSGSIZE;
> > > > -
> > > >       features = vdev->config->get_driver_features(vdev);
> > > >       if (nla_put_u64_64bit(msg,
> > > > VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
> > > >                             features, VDPA_ATTR_PAD))
> > > >               return -EMSGSIZE;
> > > >
> > > > +     err = vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > > > +     if (err)
> > > > +             return err;
> > > > +
> > >
> > > So that means that you can't read statistics when MQ is not supported. Is
> > this worth sacrificing?
> >
> > vdpa_dev_net_mq_config_fill() will return 0 in the case of !MQ, so it
> > should still work.
>
> Right, missed that.
>
> Reviewed-by: Eli Cohen <elic@nvidia.com>

Michael, I don't see this is merged.

Any comments for this patch?

Thanks


>
> >
> > Thanks
> >
> >
> > >
> > > >       if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> > > >               return -EMSGSIZE;
> > > >
> > > > --
> > > > 2.25.1
> > >
>

