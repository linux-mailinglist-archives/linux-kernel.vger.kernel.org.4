Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681FE741EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjF2DVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjF2DV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07372979
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688008833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C847EGUrdqxVrqfFw1LBCKXsSidk17jhy+GW2Xvh8nI=;
        b=NoGmjVOzH2oZ3WXDTiFppebu67rT7wCLNp/Edor1C+siBXRdmUigI+WuJSu3qASya7cTyu
        k2ESq7ClUPdQsLpXZ98BGHxTNBzEX74d7KXspPp+b64wZeIzbl0YUpivcA1BO/2sjHrpMv
        SEQfrnrD+peY7vJfLDO9w4XSNNsT8SI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-KKT9PiGTOXSYDPlK1HWeag-1; Wed, 28 Jun 2023 23:20:31 -0400
X-MC-Unique: KKT9PiGTOXSYDPlK1HWeag-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb736a7746so318014e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688008830; x=1690600830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C847EGUrdqxVrqfFw1LBCKXsSidk17jhy+GW2Xvh8nI=;
        b=B9PfKxJigxiHe+8zelcTPA6apSgCA1nZQUxtWfzxrF0UTc87YXv3OlOJJCD2ysEnlf
         MC9xkucXCdwyFtnPJL8Xzb/4AIW1qSXIcmiMopIqZ/XJoQwg7FGByoCCFOovkilx1lQN
         Z1XY5HdQT8Dwy/1iR1GuYkJkOd/kp/Ll0Ei8MVG3BsEkTwNkxFijnwwpKfY6kukL8bqk
         /AIro7/quP3DdLCKVt2Z20azWjcFAWBqx/P289YxQtrytXMKCa7/ISJrU7IyQQrWMEXE
         XKLdOcfNPX05oisPnHhObQsDg0G4CNpYyWEOgjFojAYHXNb7g9q+iDVj95iCjEs5XhzB
         bXDA==
X-Gm-Message-State: AC+VfDzwDtTBjByCJGnglZZqo1d80Fdu5xVOI+MxgKmzjy3rySnBezMi
        zb60c/wzwJGcnOEPUHnstp/rA56wZDEL1zLZSZ2JEjszrsP7vutuqJwycHHInvw9ZUQLHWT7DbW
        8NHnGBMHNVvYedND3OC2hdx60ZxACvmWql8fIelMF
X-Received: by 2002:a19:5f44:0:b0:4f6:2317:f387 with SMTP id a4-20020a195f44000000b004f62317f387mr19425140lfj.35.1688008830220;
        Wed, 28 Jun 2023 20:20:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7A4ns/TdSRlQkma0fVdfYjsBbD/XKG6hmD+EMizVgr6A9kvJ+XcgGTf234JNmcmpMJJYQg2Hz3YW+zckNXips=
X-Received: by 2002:a19:5f44:0:b0:4f6:2317:f387 with SMTP id
 a4-20020a195f44000000b004f62317f387mr19425133lfj.35.1688008829881; Wed, 28
 Jun 2023 20:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230524081842.3060-1-jasowang@redhat.com> <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org> <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
 <20230525033750-mutt-send-email-mst@kernel.org> <CACGkMEtCA0-NY=qq_FnGzoY+VXmixGmBV3y80nZWO=NmxdRWmw@mail.gmail.com>
 <20230528073139-mutt-send-email-mst@kernel.org> <CACGkMEvcjjGRfNYeZaG0hS8R2fnpve62QFv_ReRTXxCUKwf36w@mail.gmail.com>
 <CACGkMEtgZ_=L2noqdADgNTr_E7s3adw=etvcFt3G7ZERQq43_g@mail.gmail.com> <20230628093334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230628093334-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 29 Jun 2023 11:20:18 +0800
Message-ID: <CACGkMEvR71nDWLyGoxVR1vsAqP+t93Pdv5ixFY4dXowWNBrzEQ@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 9:34=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, May 31, 2023 at 09:07:25AM +0800, Jason Wang wrote:
> > On Mon, May 29, 2023 at 9:21=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Sun, May 28, 2023 at 7:39=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Fri, May 26, 2023 at 09:31:34AM +0800, Jason Wang wrote:
> > > > > On Thu, May 25, 2023 at 3:41=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Thu, May 25, 2023 at 11:43:34AM +0800, Jason Wang wrote:
> > > > > > > On Wed, May 24, 2023 at 5:15=E2=80=AFPM Michael S. Tsirkin <m=
st@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, May 24, 2023 at 04:18:41PM +0800, Jason Wang wrote:
> > > > > > > > > This patch convert rx mode setting to be done in a workqu=
eue, this is
> > > > > > > > > a must for allow to sleep when waiting for the cvq comman=
d to
> > > > > > > > > response since current code is executed under addr spin l=
ock.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > ---
> > > > > > > > > Changes since V1:
> > > > > > > > > - use RTNL to synchronize rx mode worker
> > > > > > > > > ---
> > > > > > > > >  drivers/net/virtio_net.c | 55 ++++++++++++++++++++++++++=
+++++++++++---
> > > > > > > > >  1 file changed, 52 insertions(+), 3 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virti=
o_net.c
> > > > > > > > > index 56ca1d270304..5d2f1da4eaa0 100644
> > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > @@ -265,6 +265,12 @@ struct virtnet_info {
> > > > > > > > >       /* Work struct for config space updates */
> > > > > > > > >       struct work_struct config_work;
> > > > > > > > >
> > > > > > > > > +     /* Work struct for config rx mode */
> > > > > > > >
> > > > > > > > With a bit less abbreviation maybe? setting rx mode?
> > > > > > >
> > > > > > > That's fine.
> > > > > > >
> > > > > > > >
> > > > > > > > > +     struct work_struct rx_mode_work;
> > > > > > > > > +
> > > > > > > > > +     /* Is rx mode work enabled? */
> > > > > > > >
> > > > > > > > Ugh not a great comment.
> > > > > > >
> > > > > > > Any suggestions for this. E.g we had:
> > > > > > >
> > > > > > >         /* Is delayed refill enabled? */
> > > > > >
> > > > > > /* OK to queue work setting RX mode? */
> > > > >
> > > > > Ok.
> > > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > > > +     bool rx_mode_work_enabled;
> > > > > > > > > +
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > >       /* Does the affinity hint is set for virtqueues? */
> > > > > > > > >       bool affinity_hint_set;
> > > > > > > > >
> > > > > > > > > @@ -388,6 +394,20 @@ static void disable_delayed_refill(s=
truct virtnet_info *vi)
> > > > > > > > >       spin_unlock_bh(&vi->refill_lock);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static void enable_rx_mode_work(struct virtnet_info *vi)
> > > > > > > > > +{
> > > > > > > > > +     rtnl_lock();
> > > > > > > > > +     vi->rx_mode_work_enabled =3D true;
> > > > > > > > > +     rtnl_unlock();
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void disable_rx_mode_work(struct virtnet_info *vi=
)
> > > > > > > > > +{
> > > > > > > > > +     rtnl_lock();
> > > > > > > > > +     vi->rx_mode_work_enabled =3D false;
> > > > > > > > > +     rtnl_unlock();
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static void virtqueue_napi_schedule(struct napi_struct *=
napi,
> > > > > > > > >                                   struct virtqueue *vq)
> > > > > > > > >  {
> > > > > > > > > @@ -2341,9 +2361,11 @@ static int virtnet_close(struct ne=
t_device *dev)
> > > > > > > > >       return 0;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > -static void virtnet_set_rx_mode(struct net_device *dev)
> > > > > > > > > +static void virtnet_rx_mode_work(struct work_struct *wor=
k)
> > > > > > > > >  {
> > > > > > > > > -     struct virtnet_info *vi =3D netdev_priv(dev);
> > > > > > > > > +     struct virtnet_info *vi =3D
> > > > > > > > > +             container_of(work, struct virtnet_info, rx_=
mode_work);
> > > > > > > > > +     struct net_device *dev =3D vi->dev;
> > > > > > > > >       struct scatterlist sg[2];
> > > > > > > > >       struct virtio_net_ctrl_mac *mac_data;
> > > > > > > > >       struct netdev_hw_addr *ha;
> > > > > > > > > @@ -2356,6 +2378,8 @@ static void virtnet_set_rx_mode(str=
uct net_device *dev)
> > > > > > > > >       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL=
_RX))
> > > > > > > > >               return;
> > > > > > > > >
> > > > > > > > > +     rtnl_lock();
> > > > > > > > > +
> > > > > > > > >       vi->ctrl->promisc =3D ((dev->flags & IFF_PROMISC) !=
=3D 0);
> > > > > > > > >       vi->ctrl->allmulti =3D ((dev->flags & IFF_ALLMULTI)=
 !=3D 0);
> > > > > > > > >
> > > > > > > > > @@ -2373,14 +2397,19 @@ static void virtnet_set_rx_mode(s=
truct net_device *dev)
> > > > > > > > >               dev_warn(&dev->dev, "Failed to %sable allmu=
lti mode.\n",
> > > > > > > > >                        vi->ctrl->allmulti ? "en" : "dis")=
;
> > > > > > > > >
> > > > > > > > > +     netif_addr_lock_bh(dev);
> > > > > > > > > +
> > > > > > > > >       uc_count =3D netdev_uc_count(dev);
> > > > > > > > >       mc_count =3D netdev_mc_count(dev);
> > > > > > > > >       /* MAC filter - use one buffer for both lists */
> > > > > > > > >       buf =3D kzalloc(((uc_count + mc_count) * ETH_ALEN) =
+
> > > > > > > > >                     (2 * sizeof(mac_data->entries)), GFP_=
ATOMIC);
> > > > > > > > >       mac_data =3D buf;
> > > > > > > > > -     if (!buf)
> > > > > > > > > +     if (!buf) {
> > > > > > > > > +             netif_addr_unlock_bh(dev);
> > > > > > > > > +             rtnl_unlock();
> > > > > > > > >               return;
> > > > > > > > > +     }
> > > > > > > > >
> > > > > > > > >       sg_init_table(sg, 2);
> > > > > > > > >
> > > > > > > > > @@ -2401,6 +2430,8 @@ static void virtnet_set_rx_mode(str=
uct net_device *dev)
> > > > > > > > >       netdev_for_each_mc_addr(ha, dev)
> > > > > > > > >               memcpy(&mac_data->macs[i++][0], ha->addr, E=
TH_ALEN);
> > > > > > > > >
> > > > > > > > > +     netif_addr_unlock_bh(dev);
> > > > > > > > > +
> > > > > > > > >       sg_set_buf(&sg[1], mac_data,
> > > > > > > > >                  sizeof(mac_data->entries) + (mc_count * =
ETH_ALEN));
> > > > > > > > >
> > > > > > > > > @@ -2408,9 +2439,19 @@ static void virtnet_set_rx_mode(st=
ruct net_device *dev)
> > > > > > > > >                                 VIRTIO_NET_CTRL_MAC_TABLE=
_SET, sg))
> > > > > > > > >               dev_warn(&dev->dev, "Failed to set MAC filt=
er table.\n");
> > > > > > > > >
> > > > > > > > > +     rtnl_unlock();
> > > > > > > > > +
> > > > > > > > >       kfree(buf);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static void virtnet_set_rx_mode(struct net_device *dev)
> > > > > > > > > +{
> > > > > > > > > +     struct virtnet_info *vi =3D netdev_priv(dev);
> > > > > > > > > +
> > > > > > > > > +     if (vi->rx_mode_work_enabled)
> > > > > > > > > +             schedule_work(&vi->rx_mode_work);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > >
> > > > > > > > >  static int virtnet_vlan_rx_add_vid(struct net_device *de=
v,
> > > > > > > > >                                  __be16 proto, u16 vid)
> > > > > > > > >  {
> > > > > > > > > @@ -3181,6 +3222,8 @@ static void virtnet_freeze_down(str=
uct virtio_device *vdev)
> > > > > > > > >
> > > > > > > > >       /* Make sure no work handler is accessing the devic=
e */
> > > > > > > > >       flush_work(&vi->config_work);
> > > > > > > > > +     disable_rx_mode_work(vi);
> > > > > > > > > +     flush_work(&vi->rx_mode_work);
> > > > > > > > >
> > > > > > > > >       netif_tx_lock_bh(vi->dev);
> > > > > > > > >       netif_device_detach(vi->dev);
> > > > > > > >
> > > > > > > > Hmm so queued rx mode work will just get skipped
> > > > > > > > and on restore we get a wrong rx mode.
> > > > > > > > Any way to make this more robust?
> > > > > > >
> > > > > > > It could be done by scheduling a work on restore.
> > > > >
> > > > > Rethink this, I think we don't need to care about this case since=
 the
> > > > > user processes should have been frozened.
> > > >
> > > > Yes but not the workqueue. Want to switch to system_freezable_wq?
> > >
> > > Yes, I will do it in v2.
> >
> > Actually, this doesn't work. Freezable workqueue can only guarantee
> > when being freezed the new work will be queued and not scheduled until
> > thaw. So the ktrhead that is executing the workqueue is not freezable.
> > The busy loop (even with cond_resched()) will force suspend in this
> > case.
> >
> > I wonder if we should switch to using a dedicated kthread for
> > virtio-net then we can allow it to be frozen.
> >
> > Thanks
> >
>
> So what's the plan then?

I plan to send a new version that doesn't take special care to freeze.
And address the freeze on top, probably with a dedicated kthread that
can be frozen and respond to things like SIGKILL (which is somehow
similar to what we want to solve for vhost).

Thanks

>
> > >
> > > Thanks
> > >
> > > >
> > > > > And that the reason we don't
> > > > > even need to hold RTNL here.
> > > > >
> > > > > Thanks
> > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > @@ -3203,6 +3246,7 @@ static int virtnet_restore_up(struc=
t virtio_device *vdev)
> > > > > > > > >       virtio_device_ready(vdev);
> > > > > > > > >
> > > > > > > > >       enable_delayed_refill(vi);
> > > > > > > > > +     enable_rx_mode_work(vi);
> > > > > > > > >
> > > > > > > > >       if (netif_running(vi->dev)) {
> > > > > > > > >               err =3D virtnet_open(vi->dev);
> > > > > > > > > @@ -4002,6 +4046,7 @@ static int virtnet_probe(struct vir=
tio_device *vdev)
> > > > > > > > >       vdev->priv =3D vi;
> > > > > > > > >
> > > > > > > > >       INIT_WORK(&vi->config_work, virtnet_config_changed_=
work);
> > > > > > > > > +     INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
> > > > > > > > >       spin_lock_init(&vi->refill_lock);
> > > > > > > > >
> > > > > > > > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF=
)) {
> > > > > > > > > @@ -4110,6 +4155,8 @@ static int virtnet_probe(struct vir=
tio_device *vdev)
> > > > > > > > >       if (vi->has_rss || vi->has_rss_hash_report)
> > > > > > > > >               virtnet_init_default_rss(vi);
> > > > > > > > >
> > > > > > > > > +     enable_rx_mode_work(vi);
> > > > > > > > > +
> > > > > > > > >       /* serialize netdev register + virtio_device_ready(=
) with ndo_open() */
> > > > > > > > >       rtnl_lock();
> > > > > > > > >
> > > > > > > > > @@ -4207,6 +4254,8 @@ static void virtnet_remove(struct v=
irtio_device *vdev)
> > > > > > > > >
> > > > > > > > >       /* Make sure no work handler is accessing the devic=
e. */
> > > > > > > > >       flush_work(&vi->config_work);
> > > > > > > > > +     disable_rx_mode_work(vi);
> > > > > > > > > +     flush_work(&vi->rx_mode_work);
> > > > > > > > >
> > > > > > > > >       unregister_netdev(vi->dev);
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > > >
> > > > > >
> > > >
>

