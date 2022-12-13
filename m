Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9664B838
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiLMPSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiLMPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:18:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D684C205F5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670944653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IZp9KZbsF+uoWlLQ08ZmpXaPPHMCXsyv2ZzXhMuIWFQ=;
        b=c291ZijJXpC0BciZkzMG2p1/Jv1hNZT5WX06owXB20OSbSYHgQfwsVlfwGlQWxBB8/KFgn
        Eh+NlFe/x8S6Agl9QdEgJOrGbsP2M+V5i4t7P2252l8SumSRZtd1vqVeOLqEd3Ik3cnntR
        fdKMDq5/FsaihBlBRytjh07RK2FFTbw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-270-KM6kN15rO_yO_Y-5i5yrPA-1; Tue, 13 Dec 2022 10:17:30 -0500
X-MC-Unique: KM6kN15rO_yO_Y-5i5yrPA-1
Received: by mail-wm1-f71.google.com with SMTP id b47-20020a05600c4aaf00b003d031aeb1b6so5778244wmp.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZp9KZbsF+uoWlLQ08ZmpXaPPHMCXsyv2ZzXhMuIWFQ=;
        b=Nt2HGyHmQfezmdnPRuRHj/gcoMnR3h+fMMaB6jxylmHDZRISxSmkAPFXWcHLEm9ugu
         9SkKw0FUW461YPE07Qd5SHP4LkZ8aE2tOyIc/fZYHOt2AxPRsJNjO5YAqTWmxsy6mkdJ
         OXm+U5CjWs9Gyekxsh3ZMszemjLCfDriTnmCC3ttAmBfflqR3KZSk7U+U0PafzyaLTR0
         1XH7aZadgVrlxKpJFqdF0cfcF8wVv2YRSFKGYckzMnpC0AZ8hUmTbrnRWJ0f/LRQUYDw
         VY7+iGYP/WKJ0+0u1sr+/1i46/c4hfQhq+IsApOMXPuRoiohceHQ2KptQKSfHKT5tCni
         kFmA==
X-Gm-Message-State: ANoB5plWsuNUA8droR/Fc7SuYCNeSlhqkrelUTqwglWc05qdnLgYFY01
        ZQAQ+XTapJTKTdtczzC8Wu/kBhqh+cJLx+jztpMVToneNrgjvZ5hvUekGuPrcZXyHFFB4gthhzJ
        uHbarIOb3a7tDO3tzb990PuRd
X-Received: by 2002:a05:600c:1e8f:b0:3cf:f18b:327e with SMTP id be15-20020a05600c1e8f00b003cff18b327emr16094848wmb.4.1670944648695;
        Tue, 13 Dec 2022 07:17:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7U6WfvSTkZxDt9TI9ynmz6s/JFu5zvDh9L0Hru5E9BHzJ/Df/NSYbOJehvtVBlpnSfnwYy4Q==
X-Received: by 2002:a05:600c:1e8f:b0:3cf:f18b:327e with SMTP id be15-20020a05600c1e8f00b003cff18b327emr16094836wmb.4.1670944648451;
        Tue, 13 Dec 2022 07:17:28 -0800 (PST)
Received: from redhat.com ([2.52.138.183])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c3b9600b003cfd0bd8c0asm14630548wms.30.2022.12.13.07.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:17:28 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:17:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa: conditionally fill max max queue pair for stats
Message-ID: <20221213101649-mutt-send-email-mst@kernel.org>
References: <20220907060110.4511-1-jasowang@redhat.com>
 <DM8PR12MB540034620ADF0AE749C2D099AB419@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEvjgyxs3HX_ZzUbMticntqnUxDQJMrr2MqTBwuRB7jCdw@mail.gmail.com>
 <DM8PR12MB5400209468A07467499B19BDAB419@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEuXbs-2KB28Kft+5jjdQdmMtVTKgjJ26x_U3=tNHvThZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuXbs-2KB28Kft+5jjdQdmMtVTKgjJ26x_U3=tNHvThZw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 03:12:23PM +0800, Jason Wang wrote:
> On Wed, Sep 7, 2022 at 4:11 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Wednesday, 7 September 2022 9:53
> > > To: Eli Cohen <elic@nvidia.com>
> > > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH] vdpa: conditionally fill max max queue pair for stats
> > >
> > > On Wed, Sep 7, 2022 at 2:11 PM Eli Cohen <elic@nvidia.com> wrote:
> > > >
> > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > Sent: Wednesday, 7 September 2022 9:01
> > > > > To: mst@redhat.com; jasowang@redhat.com; Eli Cohen
> > > <elic@nvidia.com>;
> > > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > > > > Subject: [PATCH] vdpa: conditionally fill max max queue pair for stats
> > > > >
> > > > > For the device without multiqueue feature, we will read 0 as
> > > > > max_virtqueue_pairs from the config.
> > > > If this is the case for other vdpa vendor drivers, shouldn't we fix it there?
> > > After all,
> > > > config->max_virtqueue_pairs should always show valid values.
> > >
> > > Not for the case when the device doesn't offer MQ. According to the
> > > spec, the max_virtqueue_pairs doesn't exist in this case.
> > >
> > I see, thanks.
> >
> > > >
> > > > > So if we fill
> > > > > VDPA_ATTR_DEV_NET_CFG_MAX_VQP with the value we read from the
> > > > > config
> > > > > we will confuse the user.
> > > > >
> > > > > Fixing this by only filling the value when multiqueue is offered by
> > > > > the device so userspace can assume 1 when the attr is not provided.
> > > > >
> > > > > Fixes: 13b00b135665c("vdpa: Add support for querying vendor
> > > statistics")
> > > > > Cc: Eli Cohen <elic@nvidia.com>
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa.c | 9 ++++-----
> > > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > index c06c02704461..bc328197263f 100644
> > > > > --- a/drivers/vdpa/vdpa.c
> > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > @@ -894,7 +894,6 @@ static int vdpa_fill_stats_rec(struct vdpa_device
> > > > > *vdev, struct sk_buff *msg,
> > > > >  {
> > > > >       struct virtio_net_config config = {};
> > > > >       u64 features;
> > > > > -     u16 max_vqp;
> > > > >       u8 status;
> > > > >       int err;
> > > > >
> > > > > @@ -905,15 +904,15 @@ static int vdpa_fill_stats_rec(struct
> > > vdpa_device
> > > > > *vdev, struct sk_buff *msg,
> > > > >       }
> > > > >       vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> > > > >
> > > > > -     max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
> > > > > -     if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> > > > > max_vqp))
> > > > > -             return -EMSGSIZE;
> > > > > -
> > > > >       features = vdev->config->get_driver_features(vdev);
> > > > >       if (nla_put_u64_64bit(msg,
> > > > > VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
> > > > >                             features, VDPA_ATTR_PAD))
> > > > >               return -EMSGSIZE;
> > > > >
> > > > > +     err = vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > > > > +     if (err)
> > > > > +             return err;
> > > > > +
> > > >
> > > > So that means that you can't read statistics when MQ is not supported. Is
> > > this worth sacrificing?
> > >
> > > vdpa_dev_net_mq_config_fill() will return 0 in the case of !MQ, so it
> > > should still work.
> >
> > Right, missed that.
> >
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> 
> Michael, I don't see this is merged.
> 
> Any comments for this patch?
> 
> Thanks
> 

Will be in the pull. Working on it now, it's pretty big.

> >
> > >
> > > Thanks
> > >
> > >
> > > >
> > > > >       if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> > > > >               return -EMSGSIZE;
> > > > >
> > > > > --
> > > > > 2.25.1
> > > >
> >

