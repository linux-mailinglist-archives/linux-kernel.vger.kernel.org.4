Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315B17141A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 03:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjE2BW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 21:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjE2BWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 21:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC610BB
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685323296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRboE5I0SRRDrF1SEw1w2ie0hUe/SapzMbi4K8/lSwo=;
        b=BGGBbhnMcLafk38cEXaM9cvvIcJBJGTUetK+kHa01wpmQ0nPZgEVd3zTmoZ/vMqvLfsnq+
        K5XoB36AZbe4S+ztsQuZb/Bn30Ca5xOt20nt6nvWeGnc6BTOkTmqNAMd9mQ4qzFGPQ4fwu
        uBktZOO5vX7zadYcarsD73P3WoYJdgs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-eKbuInOlPPSutKF9J1OTaw-1; Sun, 28 May 2023 21:21:35 -0400
X-MC-Unique: eKbuInOlPPSutKF9J1OTaw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b05714a774so11404131fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685323294; x=1687915294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRboE5I0SRRDrF1SEw1w2ie0hUe/SapzMbi4K8/lSwo=;
        b=dQd+gFNRVo0D62CTx9HPTowUMqLfK5iQQbWtSwGCB2uXEVbVZaafCWyU7zL6SWmvct
         uhdjjz30bdCP+1zp9jANbmd5JYwWh4/HwUE+Q+/becweFKVtwq7yiZNx4YZs906kZYJ5
         zebsfXSH0gG85zVGiFUMz1cLaPjLp1m5CxoqhFBrklHNOs7KQxPiIcp1woFeW/XoMsSb
         RFy9lW6S86zcyHMLw5/+ndSnOJibIU2l6BsR88FWM47KQ6UDAUKgPee+vU8AkLFh7ZfB
         ggTjOsFa5s57tyksG2hyKZE4iA5+5wzWRaHW/S+sqnlYA1x8lcrQUVUu7PblHkpGTJ3p
         BzHw==
X-Gm-Message-State: AC+VfDzpeI7+rSLEg06xdWnG65d/puI0lRCF/Vy+lyUCQkb20GTO1vum
        2ZzZl/vcybvgy6zzRRd/9u3AuoTjnstV4SDThx+Gonmg3gV4nVtNWo25zIYbr0yWpda/7QstGwH
        C5J9crthSYDQmVIXCTfr1pga/cuqpICSAkmt6wDXV
X-Received: by 2002:a05:651c:103b:b0:2af:2088:2548 with SMTP id w27-20020a05651c103b00b002af20882548mr3351416ljm.21.1685323294043;
        Sun, 28 May 2023 18:21:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Kg07odPok1mdzPXs0HAFAv23D18/pYqhOKE9PgjFglnQ61GcVmzx9bqJteIa9LDbtm572mPL52Am1k7VDScA=
X-Received: by 2002:a05:651c:103b:b0:2af:2088:2548 with SMTP id
 w27-20020a05651c103b00b002af20882548mr3351413ljm.21.1685323293731; Sun, 28
 May 2023 18:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230524081842.3060-1-jasowang@redhat.com> <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org> <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
 <20230525033750-mutt-send-email-mst@kernel.org> <CACGkMEtCA0-NY=qq_FnGzoY+VXmixGmBV3y80nZWO=NmxdRWmw@mail.gmail.com>
 <20230528073139-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230528073139-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 29 May 2023 09:21:21 +0800
Message-ID: <CACGkMEvcjjGRfNYeZaG0hS8R2fnpve62QFv_ReRTXxCUKwf36w@mail.gmail.com>
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     xuanzhuo@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 7:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, May 26, 2023 at 09:31:34AM +0800, Jason Wang wrote:
> > On Thu, May 25, 2023 at 3:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, May 25, 2023 at 11:43:34AM +0800, Jason Wang wrote:
> > > > On Wed, May 24, 2023 at 5:15=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, May 24, 2023 at 04:18:41PM +0800, Jason Wang wrote:
> > > > > > This patch convert rx mode setting to be done in a workqueue, t=
his is
> > > > > > a must for allow to sleep when waiting for the cvq command to
> > > > > > response since current code is executed under addr spin lock.
> > > > > >
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > > Changes since V1:
> > > > > > - use RTNL to synchronize rx mode worker
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 55 ++++++++++++++++++++++++++++++++=
+++++---
> > > > > >  1 file changed, 52 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.=
c
> > > > > > index 56ca1d270304..5d2f1da4eaa0 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -265,6 +265,12 @@ struct virtnet_info {
> > > > > >       /* Work struct for config space updates */
> > > > > >       struct work_struct config_work;
> > > > > >
> > > > > > +     /* Work struct for config rx mode */
> > > > >
> > > > > With a bit less abbreviation maybe? setting rx mode?
> > > >
> > > > That's fine.
> > > >
> > > > >
> > > > > > +     struct work_struct rx_mode_work;
> > > > > > +
> > > > > > +     /* Is rx mode work enabled? */
> > > > >
> > > > > Ugh not a great comment.
> > > >
> > > > Any suggestions for this. E.g we had:
> > > >
> > > >         /* Is delayed refill enabled? */
> > >
> > > /* OK to queue work setting RX mode? */
> >
> > Ok.
> >
> > >
> > >
> > > > >
> > > > > > +     bool rx_mode_work_enabled;
> > > > > > +
> > > > >
> > > > >
> > > > >
> > > > > >       /* Does the affinity hint is set for virtqueues? */
> > > > > >       bool affinity_hint_set;
> > > > > >
> > > > > > @@ -388,6 +394,20 @@ static void disable_delayed_refill(struct =
virtnet_info *vi)
> > > > > >       spin_unlock_bh(&vi->refill_lock);
> > > > > >  }
> > > > > >
> > > > > > +static void enable_rx_mode_work(struct virtnet_info *vi)
> > > > > > +{
> > > > > > +     rtnl_lock();
> > > > > > +     vi->rx_mode_work_enabled =3D true;
> > > > > > +     rtnl_unlock();
> > > > > > +}
> > > > > > +
> > > > > > +static void disable_rx_mode_work(struct virtnet_info *vi)
> > > > > > +{
> > > > > > +     rtnl_lock();
> > > > > > +     vi->rx_mode_work_enabled =3D false;
> > > > > > +     rtnl_unlock();
> > > > > > +}
> > > > > > +
> > > > > >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> > > > > >                                   struct virtqueue *vq)
> > > > > >  {
> > > > > > @@ -2341,9 +2361,11 @@ static int virtnet_close(struct net_devi=
ce *dev)
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > -static void virtnet_set_rx_mode(struct net_device *dev)
> > > > > > +static void virtnet_rx_mode_work(struct work_struct *work)
> > > > > >  {
> > > > > > -     struct virtnet_info *vi =3D netdev_priv(dev);
> > > > > > +     struct virtnet_info *vi =3D
> > > > > > +             container_of(work, struct virtnet_info, rx_mode_w=
ork);
> > > > > > +     struct net_device *dev =3D vi->dev;
> > > > > >       struct scatterlist sg[2];
> > > > > >       struct virtio_net_ctrl_mac *mac_data;
> > > > > >       struct netdev_hw_addr *ha;
> > > > > > @@ -2356,6 +2378,8 @@ static void virtnet_set_rx_mode(struct ne=
t_device *dev)
> > > > > >       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
> > > > > >               return;
> > > > > >
> > > > > > +     rtnl_lock();
> > > > > > +
> > > > > >       vi->ctrl->promisc =3D ((dev->flags & IFF_PROMISC) !=3D 0)=
;
> > > > > >       vi->ctrl->allmulti =3D ((dev->flags & IFF_ALLMULTI) !=3D =
0);
> > > > > >
> > > > > > @@ -2373,14 +2397,19 @@ static void virtnet_set_rx_mode(struct =
net_device *dev)
> > > > > >               dev_warn(&dev->dev, "Failed to %sable allmulti mo=
de.\n",
> > > > > >                        vi->ctrl->allmulti ? "en" : "dis");
> > > > > >
> > > > > > +     netif_addr_lock_bh(dev);
> > > > > > +
> > > > > >       uc_count =3D netdev_uc_count(dev);
> > > > > >       mc_count =3D netdev_mc_count(dev);
> > > > > >       /* MAC filter - use one buffer for both lists */
> > > > > >       buf =3D kzalloc(((uc_count + mc_count) * ETH_ALEN) +
> > > > > >                     (2 * sizeof(mac_data->entries)), GFP_ATOMIC=
);
> > > > > >       mac_data =3D buf;
> > > > > > -     if (!buf)
> > > > > > +     if (!buf) {
> > > > > > +             netif_addr_unlock_bh(dev);
> > > > > > +             rtnl_unlock();
> > > > > >               return;
> > > > > > +     }
> > > > > >
> > > > > >       sg_init_table(sg, 2);
> > > > > >
> > > > > > @@ -2401,6 +2430,8 @@ static void virtnet_set_rx_mode(struct ne=
t_device *dev)
> > > > > >       netdev_for_each_mc_addr(ha, dev)
> > > > > >               memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALE=
N);
> > > > > >
> > > > > > +     netif_addr_unlock_bh(dev);
> > > > > > +
> > > > > >       sg_set_buf(&sg[1], mac_data,
> > > > > >                  sizeof(mac_data->entries) + (mc_count * ETH_AL=
EN));
> > > > > >
> > > > > > @@ -2408,9 +2439,19 @@ static void virtnet_set_rx_mode(struct n=
et_device *dev)
> > > > > >                                 VIRTIO_NET_CTRL_MAC_TABLE_SET, =
sg))
> > > > > >               dev_warn(&dev->dev, "Failed to set MAC filter tab=
le.\n");
> > > > > >
> > > > > > +     rtnl_unlock();
> > > > > > +
> > > > > >       kfree(buf);
> > > > > >  }
> > > > > >
> > > > > > +static void virtnet_set_rx_mode(struct net_device *dev)
> > > > > > +{
> > > > > > +     struct virtnet_info *vi =3D netdev_priv(dev);
> > > > > > +
> > > > > > +     if (vi->rx_mode_work_enabled)
> > > > > > +             schedule_work(&vi->rx_mode_work);
> > > > > > +}
> > > > > > +
> > > > >
> > > > > >  static int virtnet_vlan_rx_add_vid(struct net_device *dev,
> > > > > >                                  __be16 proto, u16 vid)
> > > > > >  {
> > > > > > @@ -3181,6 +3222,8 @@ static void virtnet_freeze_down(struct vi=
rtio_device *vdev)
> > > > > >
> > > > > >       /* Make sure no work handler is accessing the device */
> > > > > >       flush_work(&vi->config_work);
> > > > > > +     disable_rx_mode_work(vi);
> > > > > > +     flush_work(&vi->rx_mode_work);
> > > > > >
> > > > > >       netif_tx_lock_bh(vi->dev);
> > > > > >       netif_device_detach(vi->dev);
> > > > >
> > > > > Hmm so queued rx mode work will just get skipped
> > > > > and on restore we get a wrong rx mode.
> > > > > Any way to make this more robust?
> > > >
> > > > It could be done by scheduling a work on restore.
> >
> > Rethink this, I think we don't need to care about this case since the
> > user processes should have been frozened.
>
> Yes but not the workqueue. Want to switch to system_freezable_wq?

Yes, I will do it in v2.

Thanks

>
> > And that the reason we don't
> > even need to hold RTNL here.
> >
> > Thanks
> >
> > > >
> > > > Thanks
> > >
> > >
> > > > >
> > > > >
> > > > > > @@ -3203,6 +3246,7 @@ static int virtnet_restore_up(struct virt=
io_device *vdev)
> > > > > >       virtio_device_ready(vdev);
> > > > > >
> > > > > >       enable_delayed_refill(vi);
> > > > > > +     enable_rx_mode_work(vi);
> > > > > >
> > > > > >       if (netif_running(vi->dev)) {
> > > > > >               err =3D virtnet_open(vi->dev);
> > > > > > @@ -4002,6 +4046,7 @@ static int virtnet_probe(struct virtio_de=
vice *vdev)
> > > > > >       vdev->priv =3D vi;
> > > > > >
> > > > > >       INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > > > > > +     INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
> > > > > >       spin_lock_init(&vi->refill_lock);
> > > > > >
> > > > > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
> > > > > > @@ -4110,6 +4155,8 @@ static int virtnet_probe(struct virtio_de=
vice *vdev)
> > > > > >       if (vi->has_rss || vi->has_rss_hash_report)
> > > > > >               virtnet_init_default_rss(vi);
> > > > > >
> > > > > > +     enable_rx_mode_work(vi);
> > > > > > +
> > > > > >       /* serialize netdev register + virtio_device_ready() with=
 ndo_open() */
> > > > > >       rtnl_lock();
> > > > > >
> > > > > > @@ -4207,6 +4254,8 @@ static void virtnet_remove(struct virtio_=
device *vdev)
> > > > > >
> > > > > >       /* Make sure no work handler is accessing the device. */
> > > > > >       flush_work(&vi->config_work);
> > > > > > +     disable_rx_mode_work(vi);
> > > > > > +     flush_work(&vi->rx_mode_work);
> > > > > >
> > > > > >       unregister_netdev(vi->dev);
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > >
> > >
>

