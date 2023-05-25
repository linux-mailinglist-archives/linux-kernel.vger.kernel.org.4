Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F558710696
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjEYHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjEYHoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475891BD8
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685000516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLlszakwtl2NiocvGs5LQWEAprM6Y0QlYDNKUyv6EwY=;
        b=cOroiditd0MOexVSXuQga57C1bFPl83+FYQQFnOvQTPRcTla2igE/Ld4/x/uexc6nWL8ru
        knJcKMXWOajt+Sg7UL8T4xWnkdMLaRRZbc99rw0O887ekkNuSqonVkZJIr4FzjnZ+3Ne8+
        TCX4jTu/uc0IwMHIOW1pv2lydKRN/R8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-nJpeAktjNDOz8U2ZO_OhGA-1; Thu, 25 May 2023 03:41:55 -0400
X-MC-Unique: nJpeAktjNDOz8U2ZO_OhGA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6238295cc68so6933676d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685000514; x=1687592514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLlszakwtl2NiocvGs5LQWEAprM6Y0QlYDNKUyv6EwY=;
        b=Ce8NEjwFvMXwVW7OFF4C2iVQF0zunMpI3ulug8wRKslkYITFOA8ged311QG5uAiYDV
         6C+ekGVDv4SEEutsSuLxcTOFSzIHuhtdajtdD92dl98agNH+/7pO6GU6ftlTuXI33MHy
         IOoVgbCzH5eCdJ7tN4TztOOXvCTgCQn7WODGUZXdjnNxEAL6eCbsw7fs3asJh/x37scJ
         CCyCbbL+ldGRZC9vHrCh5q6qzMxe0ew9FZ2ZMe49yg9mBc2D04wIXALyVMvpSZfwwzlk
         tarPrsw6LBDXCnluOukXVI3jsCcRYhl0wgNK04/ORauJ79Io8NT1d4Vjbm/DPhcolS1S
         0HLA==
X-Gm-Message-State: AC+VfDxvruWxitihVKdO+KR/i2QxJ62PN9wl/Jmx4kVpegg7bwTb69kU
        pSHzTu54MQHzlafF7SakBCX1C0wjLZ/AMcUtBjWZnuDR9a2mxpvHFugT/fjYbeMumAbYKwlX+ME
        cb5iaMcRzPLz+8u8FsISDG5Z8
X-Received: by 2002:a05:6214:d4e:b0:56f:52ba:cce6 with SMTP id 14-20020a0562140d4e00b0056f52bacce6mr569107qvr.19.1685000514245;
        Thu, 25 May 2023 00:41:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qH+YWw5yHuyI4A93GN69Ss1hSLcoPsLz80aHg9NVN0huU1YrbOORiES+yuWNgP5FGs17w4g==
X-Received: by 2002:a05:6214:d4e:b0:56f:52ba:cce6 with SMTP id 14-20020a0562140d4e00b0056f52bacce6mr569095qvr.19.1685000513802;
        Thu, 25 May 2023 00:41:53 -0700 (PDT)
Received: from redhat.com ([191.101.160.247])
        by smtp.gmail.com with ESMTPSA id e14-20020a0cf74e000000b005dd8b9345besm214153qvo.86.2023.05.25.00.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 00:41:53 -0700 (PDT)
Date:   Thu, 25 May 2023 03:41:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     xuanzhuo@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230525033750-mutt-send-email-mst@kernel.org>
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org>
 <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 11:43:34AM +0800, Jason Wang wrote:
> On Wed, May 24, 2023 at 5:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, May 24, 2023 at 04:18:41PM +0800, Jason Wang wrote:
> > > This patch convert rx mode setting to be done in a workqueue, this is
> > > a must for allow to sleep when waiting for the cvq command to
> > > response since current code is executed under addr spin lock.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes since V1:
> > > - use RTNL to synchronize rx mode worker
> > > ---
> > >  drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 52 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 56ca1d270304..5d2f1da4eaa0 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -265,6 +265,12 @@ struct virtnet_info {
> > >       /* Work struct for config space updates */
> > >       struct work_struct config_work;
> > >
> > > +     /* Work struct for config rx mode */
> >
> > With a bit less abbreviation maybe? setting rx mode?
> 
> That's fine.
> 
> >
> > > +     struct work_struct rx_mode_work;
> > > +
> > > +     /* Is rx mode work enabled? */
> >
> > Ugh not a great comment.
> 
> Any suggestions for this. E.g we had:
> 
>         /* Is delayed refill enabled? */

/* OK to queue work setting RX mode? */


> >
> > > +     bool rx_mode_work_enabled;
> > > +
> >
> >
> >
> > >       /* Does the affinity hint is set for virtqueues? */
> > >       bool affinity_hint_set;
> > >
> > > @@ -388,6 +394,20 @@ static void disable_delayed_refill(struct virtnet_info *vi)
> > >       spin_unlock_bh(&vi->refill_lock);
> > >  }
> > >
> > > +static void enable_rx_mode_work(struct virtnet_info *vi)
> > > +{
> > > +     rtnl_lock();
> > > +     vi->rx_mode_work_enabled = true;
> > > +     rtnl_unlock();
> > > +}
> > > +
> > > +static void disable_rx_mode_work(struct virtnet_info *vi)
> > > +{
> > > +     rtnl_lock();
> > > +     vi->rx_mode_work_enabled = false;
> > > +     rtnl_unlock();
> > > +}
> > > +
> > >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> > >                                   struct virtqueue *vq)
> > >  {
> > > @@ -2341,9 +2361,11 @@ static int virtnet_close(struct net_device *dev)
> > >       return 0;
> > >  }
> > >
> > > -static void virtnet_set_rx_mode(struct net_device *dev)
> > > +static void virtnet_rx_mode_work(struct work_struct *work)
> > >  {
> > > -     struct virtnet_info *vi = netdev_priv(dev);
> > > +     struct virtnet_info *vi =
> > > +             container_of(work, struct virtnet_info, rx_mode_work);
> > > +     struct net_device *dev = vi->dev;
> > >       struct scatterlist sg[2];
> > >       struct virtio_net_ctrl_mac *mac_data;
> > >       struct netdev_hw_addr *ha;
> > > @@ -2356,6 +2378,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
> > >       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
> > >               return;
> > >
> > > +     rtnl_lock();
> > > +
> > >       vi->ctrl->promisc = ((dev->flags & IFF_PROMISC) != 0);
> > >       vi->ctrl->allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
> > >
> > > @@ -2373,14 +2397,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
> > >               dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
> > >                        vi->ctrl->allmulti ? "en" : "dis");
> > >
> > > +     netif_addr_lock_bh(dev);
> > > +
> > >       uc_count = netdev_uc_count(dev);
> > >       mc_count = netdev_mc_count(dev);
> > >       /* MAC filter - use one buffer for both lists */
> > >       buf = kzalloc(((uc_count + mc_count) * ETH_ALEN) +
> > >                     (2 * sizeof(mac_data->entries)), GFP_ATOMIC);
> > >       mac_data = buf;
> > > -     if (!buf)
> > > +     if (!buf) {
> > > +             netif_addr_unlock_bh(dev);
> > > +             rtnl_unlock();
> > >               return;
> > > +     }
> > >
> > >       sg_init_table(sg, 2);
> > >
> > > @@ -2401,6 +2430,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
> > >       netdev_for_each_mc_addr(ha, dev)
> > >               memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
> > >
> > > +     netif_addr_unlock_bh(dev);
> > > +
> > >       sg_set_buf(&sg[1], mac_data,
> > >                  sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
> > >
> > > @@ -2408,9 +2439,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
> > >                                 VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
> > >               dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
> > >
> > > +     rtnl_unlock();
> > > +
> > >       kfree(buf);
> > >  }
> > >
> > > +static void virtnet_set_rx_mode(struct net_device *dev)
> > > +{
> > > +     struct virtnet_info *vi = netdev_priv(dev);
> > > +
> > > +     if (vi->rx_mode_work_enabled)
> > > +             schedule_work(&vi->rx_mode_work);
> > > +}
> > > +
> >
> > >  static int virtnet_vlan_rx_add_vid(struct net_device *dev,
> > >                                  __be16 proto, u16 vid)
> > >  {
> > > @@ -3181,6 +3222,8 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
> > >
> > >       /* Make sure no work handler is accessing the device */
> > >       flush_work(&vi->config_work);
> > > +     disable_rx_mode_work(vi);
> > > +     flush_work(&vi->rx_mode_work);
> > >
> > >       netif_tx_lock_bh(vi->dev);
> > >       netif_device_detach(vi->dev);
> >
> > Hmm so queued rx mode work will just get skipped
> > and on restore we get a wrong rx mode.
> > Any way to make this more robust?
> 
> It could be done by scheduling a work on restore.
> 
> Thanks


> >
> >
> > > @@ -3203,6 +3246,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
> > >       virtio_device_ready(vdev);
> > >
> > >       enable_delayed_refill(vi);
> > > +     enable_rx_mode_work(vi);
> > >
> > >       if (netif_running(vi->dev)) {
> > >               err = virtnet_open(vi->dev);
> > > @@ -4002,6 +4046,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >       vdev->priv = vi;
> > >
> > >       INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > > +     INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
> > >       spin_lock_init(&vi->refill_lock);
> > >
> > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
> > > @@ -4110,6 +4155,8 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >       if (vi->has_rss || vi->has_rss_hash_report)
> > >               virtnet_init_default_rss(vi);
> > >
> > > +     enable_rx_mode_work(vi);
> > > +
> > >       /* serialize netdev register + virtio_device_ready() with ndo_open() */
> > >       rtnl_lock();
> > >
> > > @@ -4207,6 +4254,8 @@ static void virtnet_remove(struct virtio_device *vdev)
> > >
> > >       /* Make sure no work handler is accessing the device. */
> > >       flush_work(&vi->config_work);
> > > +     disable_rx_mode_work(vi);
> > > +     flush_work(&vi->rx_mode_work);
> > >
> > >       unregister_netdev(vi->dev);
> > >
> > > --
> > > 2.25.1
> >

