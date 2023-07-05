Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3300A747C71
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjGEFco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGEFcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF8FE3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 22:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688535114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VaBreXALaiDujCG9FpTlZRCjnSGLXKmm/+3QKpTX21g=;
        b=FynJX4xLStbpVVZlON2XliXz0Ft9W4iEVXtt+ry4kJwFNIWao+5c81uAvqaHkyPnHRArD9
        NILRtXBYNT2oSxVNg4Yt/9BhcSnaquUgOo+6on9VqNc4HpMi7Bv5EJ8RSETOajzh13Oj/Z
        pcdNkQRtALnFd9MKqk4aUUcvhFE2KqA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-kFGW-zouNOSVBUlZ9UASdA-1; Wed, 05 Jul 2023 01:31:53 -0400
X-MC-Unique: kFGW-zouNOSVBUlZ9UASdA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-314326f6e23so1750200f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 22:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688535112; x=1691127112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaBreXALaiDujCG9FpTlZRCjnSGLXKmm/+3QKpTX21g=;
        b=h98HfIU+LxFqCrp/PdmIlC1umkcaqI00pd2plz+i4/2sO/DlGFYD+wQggNKcAmXawC
         82JJbqxiKxraD10U/cDhimIDdfYxMGFd9eyZFilIUs/sXS59QEiIKPJ0EoheuyasFvE1
         6t//wuGyiznCCt1ARrjs+ujxUflUsB+TVGNkY9cq8YPi7QMJxCSdoEHjRqc/gS7OQNmd
         ONHr57mE+CDlLqLUvFq9DI34r9shBq9PNb0P9JKpv3g6FoIKdOeLMUKdkEUfor+EcYuf
         X5OJKPj286TZA4HKfrKoSZOVLWl6+h7y3TIXHvMYvVqRy+GAOXu9+0mpMI1v8OnT7ghn
         beEg==
X-Gm-Message-State: ABy/qLaB0s5nL66rZ9rf3AUNLlxYzcH7KiVbi6I5oSzt/aCyyt67dJNM
        8RDq3e/BPkNzcfTT7I/3qvT9U+adzd7N25YbLJSpMLbJ2OXtTL+xSkOdA35nJQMqX3mTzceWSqK
        xiG+v8bRGGz+5lmFBzSq3Uazr
X-Received: by 2002:adf:fec4:0:b0:313:eeb0:224f with SMTP id q4-20020adffec4000000b00313eeb0224fmr11879221wrs.58.1688535112725;
        Tue, 04 Jul 2023 22:31:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFAHNwYr2J9ytwEjWAVzIq67JC/TN9B1i6Wr8FDpQd+zcJTvAZBQ6jJ6R+cPaiD9XqYHfLqog==
X-Received: by 2002:adf:fec4:0:b0:313:eeb0:224f with SMTP id q4-20020adffec4000000b00313eeb0224fmr11879203wrs.58.1688535112210;
        Tue, 04 Jul 2023 22:31:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f8:91bf:2a8a:e512:df36:67d3])
        by smtp.gmail.com with ESMTPSA id k9-20020adff5c9000000b0031411b7087dsm17025358wrp.20.2023.07.04.22.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 22:31:51 -0700 (PDT)
Date:   Wed, 5 Jul 2023 01:31:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>,
        virtualization@lists.linux-foundation.org, leiyang@redhat.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Message-ID: <20230705012917-mutt-send-email-mst@kernel.org>
References: <20230703142514.363256-1-eperezma@redhat.com>
 <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
 <20230704061356-mutt-send-email-mst@kernel.org>
 <CACGkMEtAfiODhHEMFDKkaVFVs1yjfUFsjfy_=p8Jtd6BXAE1xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtAfiODhHEMFDKkaVFVs1yjfUFsjfy_=p8Jtd6BXAE1xQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 01:11:37PM +0800, Jason Wang wrote:
> On Tue, Jul 4, 2023 at 6:16 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 03, 2023 at 05:26:02PM -0700, Si-Wei Liu wrote:
> > >
> > >
> > > On 7/3/2023 8:46 AM, Michael S. Tsirkin wrote:
> > > > On Mon, Jul 03, 2023 at 04:25:14PM +0200, Eugenio Pérez wrote:
> > > > > Offer this backend feature as mlx5 is compatible with it. It allows it
> > > > > to do live migration with CVQ, dynamically switching between passthrough
> > > > > and shadow virtqueue.
> > > > >
> > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > Same comment.
> > > to which?
> > >
> > > -Siwei
> >
> > VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is too narrow a use-case to commit to it
> > as a kernel/userspace ABI: what if one wants to start rings in some
> > other specific order?
> 
> Just enable a queue by writing e.g 1 to queue_enable in a specific order?


But then at driver ok time we don't know how many queues are there.

> > As was discussed on list, a better promise is not to access ring
> > until the 1st kick. vdpa can then do a kick when it wants
> > the device to start accessing rings.
> 
> Rethink about the ACCESS_AFTER_KICK, it sounds functional equivalent
> to allow queue_enable after DRIVER_OK, but it seems to have
> distanvages:
> 
> A busy polling software device may disable notifications and never
> respond to register to any kick notifiers. ACCESS_AFTER_KICK will
> introduce overhead to those implementations.
> 
> Thanks

It's just the 1st kick, then you can disable. No?

> >
> > > >
> > > > > ---
> > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
> > > > >   1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 9138ef2fb2c8..5f309a16b9dc 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -7,6 +7,7 @@
> > > > >   #include <uapi/linux/virtio_net.h>
> > > > >   #include <uapi/linux/virtio_ids.h>
> > > > >   #include <uapi/linux/vdpa.h>
> > > > > +#include <uapi/linux/vhost_types.h>
> > > > >   #include <linux/virtio_config.h>
> > > > >   #include <linux/auxiliary_bus.h>
> > > > >   #include <linux/mlx5/cq.h>
> > > > > @@ -2499,6 +2500,11 @@ static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
> > > > >                   flush_workqueue(ndev->mvdev.wq);
> > > > >   }
> > > > > +static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa)
> > > > > +{
> > > > > + return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> > > > > +}
> > > > > +
> > > > >   static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> > > > >   {
> > > > >           struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > > @@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > >           .get_vq_align = mlx5_vdpa_get_vq_align,
> > > > >           .get_vq_group = mlx5_vdpa_get_vq_group,
> > > > >           .get_device_features = mlx5_vdpa_get_device_features,
> > > > > + .get_backend_features = mlx5_vdpa_get_backend_features,
> > > > >           .set_driver_features = mlx5_vdpa_set_driver_features,
> > > > >           .get_driver_features = mlx5_vdpa_get_driver_features,
> > > > >           .set_config_cb = mlx5_vdpa_set_config_cb,
> > > > > --
> > > > > 2.39.3
> >

