Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFA66E1B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDNFFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNFFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E052A4683
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681448669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHWPakCwtQbCSxN4Uhgdu7WtDkUbvFkqv6/4+sfNM+E=;
        b=OoifY0Rtkl+GJ0BMjyPSqJbsZOEREJBwUsEcMB3DpEA1Zl2Stcm16QQLYNAxB1IYciBsN3
        bbn+DjeWAvxj5VBHzPiKtnEuGQMW6Mat80prWz8sx0KklnFL4wFiOcNFboUVBS7zU8Gb1R
        4D7nqt2jCUmjwYo4W9HRwCbkgzIWJy4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-V6NM3pz2N9eRL_BWwTAvYQ-1; Fri, 14 Apr 2023 01:04:27 -0400
X-MC-Unique: V6NM3pz2N9eRL_BWwTAvYQ-1
Received: by mail-oi1-f200.google.com with SMTP id w83-20020acadf56000000b0038c0db69f66so1512889oig.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681448667; x=1684040667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHWPakCwtQbCSxN4Uhgdu7WtDkUbvFkqv6/4+sfNM+E=;
        b=FUGfwhhA8fntLr445krxctIvIdqxv7N7vo/WZewNesRjeoB48ut69jnZag9Nwwf1Uz
         DZJ1Sh545Zvh9Evdwaz63AO/KxnUGp2l9NcJNHLH0skcKv5pyBMlDzctgy7v6xIvzlxP
         carYOg7BEjnmG2dcJaOPKv4cf+hmiIYuFcSKWW/j9TFDpszuovqo2DVO8IHPMqNReEQD
         6i2/BI3l3DDILnPhbjIHCiwoQVa090470k2cdVhEyZu1MVipUu/YtYF0zHeR47XFhGyV
         2TBOW5CMJ6zwqzzFBiKERrcDgmLDyNytYNLPJbRLK5ZMGGgFGIugkZDdNyWQFTQrphVt
         Hnyw==
X-Gm-Message-State: AAQBX9cFtwdwNTSzDpP0ab3RSkIxBUgVnpICVSDcr6SkLxeL/qITssLQ
        ZpCET4cKL6iONvV4cTNda2JlNjC5YcXNYSXZ/tiRL/4kWQqjLLpyYb2PxvDgEnrhP0bTZabUYpg
        SoygGNum99CRspb3QpcpN+g6p1IM27kKgi90MfupG
X-Received: by 2002:a05:6820:553:b0:542:4b21:c4c4 with SMTP id n19-20020a056820055300b005424b21c4c4mr226292ooj.0.1681448667166;
        Thu, 13 Apr 2023 22:04:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350b90rhPrgS3V4nSNw84IR2oNDusEQYO62xcFQrxm0BTmvVJUupkO3iHFt/2ZB+8v8wsr1RsafeYkA3acgG7LUs=
X-Received: by 2002:a05:6820:553:b0:542:4b21:c4c4 with SMTP id
 n19-20020a056820055300b005424b21c4c4mr226278ooj.0.1681448666861; Thu, 13 Apr
 2023 22:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com> <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230413121525-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 14 Apr 2023 13:04:15 +0800
Message-ID: <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, david.marchand@redhat.com,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forget to cc netdev, adding.

On Fri, Apr 14, 2023 at 12:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Apr 13, 2023 at 02:40:26PM +0800, Jason Wang wrote:
> > This patch convert rx mode setting to be done in a workqueue, this is
> > a must for allow to sleep when waiting for the cvq command to
> > response since current code is executed under addr spin lock.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> I don't like this frankly. This means that setting RX mode which would
> previously be reliable, now becomes unreliable.

It is "unreliable" by design:

      void                    (*ndo_set_rx_mode)(struct net_device *dev);

> - first of all configuration is no longer immediate

Is immediate a hard requirement? I can see a workqueue is used at least:

mlx5e, ipoib, efx, ...

>   and there is no way for driver to find out when
>   it actually took effect

But we know rx mode is best effort e.g it doesn't support vhost and we
survive from this for years.

> - second, if device fails command, this is also not
>   propagated to driver, again no way for driver to find out
>
> VDUSE needs to be fixed to do tricks to fix this
> without breaking normal drivers.

It's not specific to VDUSE. For example, when using virtio-net in the
UP environment with any software cvq (like mlx5 via vDPA or cma
transport).

Thanks

>
>
> > ---
> > Changes since V1:
> > - use RTNL to synchronize rx mode worker
> > ---
> >  drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 52 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index e2560b6f7980..2e56bbf86894 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -265,6 +265,12 @@ struct virtnet_info {
> >       /* Work struct for config space updates */
> >       struct work_struct config_work;
> >
> > +     /* Work struct for config rx mode */
> > +     struct work_struct rx_mode_work;
> > +
> > +     /* Is rx mode work enabled? */
> > +     bool rx_mode_work_enabled;
> > +
> >       /* Does the affinity hint is set for virtqueues? */
> >       bool affinity_hint_set;
> >
> > @@ -388,6 +394,20 @@ static void disable_delayed_refill(struct virtnet_=
info *vi)
> >       spin_unlock_bh(&vi->refill_lock);
> >  }
> >
> > +static void enable_rx_mode_work(struct virtnet_info *vi)
> > +{
> > +     rtnl_lock();
> > +     vi->rx_mode_work_enabled =3D true;
> > +     rtnl_unlock();
> > +}
> > +
> > +static void disable_rx_mode_work(struct virtnet_info *vi)
> > +{
> > +     rtnl_lock();
> > +     vi->rx_mode_work_enabled =3D false;
> > +     rtnl_unlock();
> > +}
> > +
> >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> >                                   struct virtqueue *vq)
> >  {
> > @@ -2310,9 +2330,11 @@ static int virtnet_close(struct net_device *dev)
> >       return 0;
> >  }
> >
> > -static void virtnet_set_rx_mode(struct net_device *dev)
> > +static void virtnet_rx_mode_work(struct work_struct *work)
> >  {
> > -     struct virtnet_info *vi =3D netdev_priv(dev);
> > +     struct virtnet_info *vi =3D
> > +             container_of(work, struct virtnet_info, rx_mode_work);
> > +     struct net_device *dev =3D vi->dev;
> >       struct scatterlist sg[2];
> >       struct virtio_net_ctrl_mac *mac_data;
> >       struct netdev_hw_addr *ha;
> > @@ -2325,6 +2347,8 @@ static void virtnet_set_rx_mode(struct net_device=
 *dev)
> >       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
> >               return;
> >
> > +     rtnl_lock();
> > +
> >       vi->ctrl->promisc =3D ((dev->flags & IFF_PROMISC) !=3D 0);
> >       vi->ctrl->allmulti =3D ((dev->flags & IFF_ALLMULTI) !=3D 0);
> >
> > @@ -2342,14 +2366,19 @@ static void virtnet_set_rx_mode(struct net_devi=
ce *dev)
> >               dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
> >                        vi->ctrl->allmulti ? "en" : "dis");
> >
> > +     netif_addr_lock_bh(dev);
> > +
> >       uc_count =3D netdev_uc_count(dev);
> >       mc_count =3D netdev_mc_count(dev);
> >       /* MAC filter - use one buffer for both lists */
> >       buf =3D kzalloc(((uc_count + mc_count) * ETH_ALEN) +
> >                     (2 * sizeof(mac_data->entries)), GFP_ATOMIC);
> >       mac_data =3D buf;
> > -     if (!buf)
> > +     if (!buf) {
> > +             netif_addr_unlock_bh(dev);
> > +             rtnl_unlock();
> >               return;
> > +     }
> >
> >       sg_init_table(sg, 2);
> >
> > @@ -2370,6 +2399,8 @@ static void virtnet_set_rx_mode(struct net_device=
 *dev)
> >       netdev_for_each_mc_addr(ha, dev)
> >               memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
> >
> > +     netif_addr_unlock_bh(dev);
> > +
> >       sg_set_buf(&sg[1], mac_data,
> >                  sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
> >
> > @@ -2377,9 +2408,19 @@ static void virtnet_set_rx_mode(struct net_devic=
e *dev)
> >                                 VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
> >               dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
> >
> > +     rtnl_unlock();
> > +
> >       kfree(buf);
> >  }
> >
> > +static void virtnet_set_rx_mode(struct net_device *dev)
> > +{
> > +     struct virtnet_info *vi =3D netdev_priv(dev);
> > +
> > +     if (vi->rx_mode_work_enabled)
> > +             schedule_work(&vi->rx_mode_work);
> > +}
> > +
> >  static int virtnet_vlan_rx_add_vid(struct net_device *dev,
> >                                  __be16 proto, u16 vid)
> >  {
> > @@ -3150,6 +3191,8 @@ static void virtnet_freeze_down(struct virtio_dev=
ice *vdev)
> >
> >       /* Make sure no work handler is accessing the device */
> >       flush_work(&vi->config_work);
> > +     disable_rx_mode_work(vi);
> > +     flush_work(&vi->rx_mode_work);
> >
> >       netif_tx_lock_bh(vi->dev);
> >       netif_device_detach(vi->dev);
>
> So now configuration is not propagated to device.
> Won't device later wake up in wrong state?
>
>
> > @@ -3172,6 +3215,7 @@ static int virtnet_restore_up(struct virtio_devic=
e *vdev)
> >       virtio_device_ready(vdev);
> >
> >       enable_delayed_refill(vi);
> > +     enable_rx_mode_work(vi);
> >
> >       if (netif_running(vi->dev)) {
> >               err =3D virtnet_open(vi->dev);
> > @@ -3969,6 +4013,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >       vdev->priv =3D vi;
> >
> >       INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > +     INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
> >       spin_lock_init(&vi->refill_lock);
> >
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
> > @@ -4077,6 +4122,8 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >       if (vi->has_rss || vi->has_rss_hash_report)
> >               virtnet_init_default_rss(vi);
> >
> > +     enable_rx_mode_work(vi);
> > +
> >       /* serialize netdev register + virtio_device_ready() with ndo_ope=
n() */
> >       rtnl_lock();
> >
> > @@ -4174,6 +4221,8 @@ static void virtnet_remove(struct virtio_device *=
vdev)
> >
> >       /* Make sure no work handler is accessing the device. */
> >       flush_work(&vi->config_work);
> > +     disable_rx_mode_work(vi);
> > +     flush_work(&vi->rx_mode_work);
> >
> >       unregister_netdev(vi->dev);
> >
> > --
> > 2.25.1
>

