Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3542710368
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjEYDok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEYDoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B06E2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 20:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684986229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4m2p+lm6+1Dh1af/W/L1B6pO/Ymz2+CVF2VL5CW0fg=;
        b=dVNhLxI1SOSt8UKtCj+9oeYWRyarfgPP3rQncTUvJUABbJ43ttcNirCm2ysKSY1q6pWtuQ
        uJi+zCvtKLo6QHJDaZ1EZfBUZiIstY2PeZZw258vYJ2W8BmWGge1e4z1Wd9JJGXv2F7481
        wnqk84L34HtJJOeAjk8mUcoXC72YUAs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-vC6ckF7wMs6yaMzmKd02rg-1; Wed, 24 May 2023 23:43:47 -0400
X-MC-Unique: vC6ckF7wMs6yaMzmKd02rg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2af25b667d5so433131fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 20:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684986226; x=1687578226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4m2p+lm6+1Dh1af/W/L1B6pO/Ymz2+CVF2VL5CW0fg=;
        b=cqObB3yGmLcRncnhNTAS8YtTQ70dB7qJZZr0tn62R0oNTj0NOSaTwRYgOkvMCMe2WS
         APEoFKHY+0GCOaHaSrBgdoHY4tSMs8pPONy7r0ei1u5RQFLBp04WvbGemxwf64BhxjHU
         brYjwMCHO0KJg9f1hvv2GHXOy+IpctLHib72ykWbDr4sDAr6gPeubk/rI4BswvVmAB8X
         rOha333kKrn/3XbrQIVLa5nlQI1KZnzzybMvInwWfMbQolFk8y7JglBygBZKHVGtJ67/
         9bXe7bYUGmjnVQAHo7CIRnm/dZZT8d8O7HUWjDdS+8D+fqHOL8NkUf9S0LNh8L+i+DOR
         78Iw==
X-Gm-Message-State: AC+VfDzapGRxMz0YqmemDKSZ0UgZZQG5VQEw8yInZGZNEyp5jB4LIMex
        D3QUa2wZpmwTdqqpax4ZrKxhestWgEFajyKCJo0IZxJNVZFiCgTrxnz6B+S7iPK0r4632mavJA5
        srGdIf395cLjNqi99qJ2q5M7Udz7I9ibyts93oHMT
X-Received: by 2002:a2e:b1c7:0:b0:2af:1fd4:9011 with SMTP id e7-20020a2eb1c7000000b002af1fd49011mr549051lja.34.1684986226504;
        Wed, 24 May 2023 20:43:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Nxno0CpX0KxVDu2aSi+nZY7wvCAw+00hD9PbzdyW/N6KVXC3Z9EBcXiECbwBPrWDt6zuPtKluPlPeL66TBWs=
X-Received: by 2002:a2e:b1c7:0:b0:2af:1fd4:9011 with SMTP id
 e7-20020a2eb1c7000000b002af1fd49011mr549044lja.34.1684986226178; Wed, 24 May
 2023 20:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230524081842.3060-1-jasowang@redhat.com> <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230524050604-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 25 May 2023 11:43:34 +0800
Message-ID: <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     xuanzhuo@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 5:15=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, May 24, 2023 at 04:18:41PM +0800, Jason Wang wrote:
> > This patch convert rx mode setting to be done in a workqueue, this is
> > a must for allow to sleep when waiting for the cvq command to
> > response since current code is executed under addr spin lock.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - use RTNL to synchronize rx mode worker
> > ---
> >  drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 52 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 56ca1d270304..5d2f1da4eaa0 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -265,6 +265,12 @@ struct virtnet_info {
> >       /* Work struct for config space updates */
> >       struct work_struct config_work;
> >
> > +     /* Work struct for config rx mode */
>
> With a bit less abbreviation maybe? setting rx mode?

That's fine.

>
> > +     struct work_struct rx_mode_work;
> > +
> > +     /* Is rx mode work enabled? */
>
> Ugh not a great comment.

Any suggestions for this. E.g we had:

        /* Is delayed refill enabled? */

>
> > +     bool rx_mode_work_enabled;
> > +
>
>
>
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
> > @@ -2341,9 +2361,11 @@ static int virtnet_close(struct net_device *dev)
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
> > @@ -2356,6 +2378,8 @@ static void virtnet_set_rx_mode(struct net_device=
 *dev)
> >       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
> >               return;
> >
> > +     rtnl_lock();
> > +
> >       vi->ctrl->promisc =3D ((dev->flags & IFF_PROMISC) !=3D 0);
> >       vi->ctrl->allmulti =3D ((dev->flags & IFF_ALLMULTI) !=3D 0);
> >
> > @@ -2373,14 +2397,19 @@ static void virtnet_set_rx_mode(struct net_devi=
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
> > @@ -2401,6 +2430,8 @@ static void virtnet_set_rx_mode(struct net_device=
 *dev)
> >       netdev_for_each_mc_addr(ha, dev)
> >               memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
> >
> > +     netif_addr_unlock_bh(dev);
> > +
> >       sg_set_buf(&sg[1], mac_data,
> >                  sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
> >
> > @@ -2408,9 +2439,19 @@ static void virtnet_set_rx_mode(struct net_devic=
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
>
> >  static int virtnet_vlan_rx_add_vid(struct net_device *dev,
> >                                  __be16 proto, u16 vid)
> >  {
> > @@ -3181,6 +3222,8 @@ static void virtnet_freeze_down(struct virtio_dev=
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
> Hmm so queued rx mode work will just get skipped
> and on restore we get a wrong rx mode.
> Any way to make this more robust?

It could be done by scheduling a work on restore.

Thanks

>
>
> > @@ -3203,6 +3246,7 @@ static int virtnet_restore_up(struct virtio_devic=
e *vdev)
> >       virtio_device_ready(vdev);
> >
> >       enable_delayed_refill(vi);
> > +     enable_rx_mode_work(vi);
> >
> >       if (netif_running(vi->dev)) {
> >               err =3D virtnet_open(vi->dev);
> > @@ -4002,6 +4046,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >       vdev->priv =3D vi;
> >
> >       INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > +     INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
> >       spin_lock_init(&vi->refill_lock);
> >
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
> > @@ -4110,6 +4155,8 @@ static int virtnet_probe(struct virtio_device *vd=
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
> > @@ -4207,6 +4254,8 @@ static void virtnet_remove(struct virtio_device *=
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

