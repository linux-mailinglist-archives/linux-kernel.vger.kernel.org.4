Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E2747E53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjGEHdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGEHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8268D10FB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688542338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpXcof6e+BEvTuo7jhma98S398OVQl9+DVwfc6QCMT4=;
        b=f43qxRKQ89Yeo1RFDJEZqUFlAXN4r5HChT8td+Lgv6mslcB7f3V+B52VPJV8v694geAXR0
        v/khaL/0jyisJa7Av6jkLZ3eyqLLAoqjYyq1bNYlkNaEtOrbPCODtbUW4vIhxJWp34QCqA
        apC+vDkQI3dC7QowGVEIEUE3EbdJo3Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-DE0n7JIJNSqWSzVSqFstkQ-1; Wed, 05 Jul 2023 03:32:17 -0400
X-MC-Unique: DE0n7JIJNSqWSzVSqFstkQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b701e0bb10so75381fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 00:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688542336; x=1691134336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpXcof6e+BEvTuo7jhma98S398OVQl9+DVwfc6QCMT4=;
        b=jbELYvalq6CKIVgZvQWmBgYJ1jEgzHJeW/Orw5MaQpxvz70m1oZs5bQLtBZD+lCXAG
         HfHHJEdFEe8D64aEuuygZKV/lAJYJK8dPnskClioZwXYMtm7No9/BSDUKVf/Ovo9eHA8
         U6hcdbMrvg3h96uKyTWAbgaTl0yBbfQZS9BKF5XnHqGmuyfsF7X2eEt+plEK1+JVN9BN
         QznAzAV+/cfGas6D/ORLmtm8XoI83nggU2FhdS59L/EMz5Wo22rXQJMj6587crJPd6iN
         K3e6L4rcMzPfQJvJitbHSMPq9V0xKyHlkTJ1Vf59uYiavspXjbc8HZr36UuNIQ0u7TnB
         jRcA==
X-Gm-Message-State: ABy/qLaSFTJqSEEvxaeWehJyRKxOdGxS8hFyIenulrXIokt8K31l9bMM
        zb5V+S48zw0rFUatwMsGLA1PYsPwRpshIaB68Gu4RoB2w1oTLth/h6sIHdCdzQNoaI08eY+IVum
        hN/aQY13KASX5waxAnOmzvt/nsOcAfNer/5D3rNnA
X-Received: by 2002:a2e:8892:0:b0:2b1:b4e9:4c3 with SMTP id k18-20020a2e8892000000b002b1b4e904c3mr10723494lji.2.1688542335750;
        Wed, 05 Jul 2023 00:32:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGFPQCI0pR0rWAmR/5AnhlrGyPnyA739M1MIRYMOx+r3LB2JLgEwWudYvjCiBhK4EUn+0ZzigXYDg36Dp8q61A=
X-Received: by 2002:a2e:8892:0:b0:2b1:b4e9:4c3 with SMTP id
 k18-20020a2e8892000000b002b1b4e904c3mr10723481lji.2.1688542335448; Wed, 05
 Jul 2023 00:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142514.363256-1-eperezma@redhat.com> <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com> <20230704061356-mutt-send-email-mst@kernel.org>
 <CACGkMEtAfiODhHEMFDKkaVFVs1yjfUFsjfy_=p8Jtd6BXAE1xQ@mail.gmail.com>
 <20230705012917-mutt-send-email-mst@kernel.org> <CACGkMEtBjTmChSQX_E_n6yvTi9rxH5UrXgfAU5qZsFAF-RZQWw@mail.gmail.com>
 <20230705021447-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230705021447-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 5 Jul 2023 15:32:04 +0800
Message-ID: <CACGkMEswyCWbXnLnm-i5ydp27kmQDvxF3gEfHhU_t0HJ7g+4Wg@mail.gmail.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>,
        virtualization@lists.linux-foundation.org, leiyang@redhat.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 2:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Jul 05, 2023 at 01:47:44PM +0800, Jason Wang wrote:
> > On Wed, Jul 5, 2023 at 1:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Wed, Jul 05, 2023 at 01:11:37PM +0800, Jason Wang wrote:
> > > > On Tue, Jul 4, 2023 at 6:16=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Mon, Jul 03, 2023 at 05:26:02PM -0700, Si-Wei Liu wrote:
> > > > > >
> > > > > >
> > > > > > On 7/3/2023 8:46 AM, Michael S. Tsirkin wrote:
> > > > > > > On Mon, Jul 03, 2023 at 04:25:14PM +0200, Eugenio P=C3=A9rez =
wrote:
> > > > > > > > Offer this backend feature as mlx5 is compatible with it. I=
t allows it
> > > > > > > > to do live migration with CVQ, dynamically switching betwee=
n passthrough
> > > > > > > > and shadow virtqueue.
> > > > > > > >
> > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > Same comment.
> > > > > > to which?
> > > > > >
> > > > > > -Siwei
> > > > >
> > > > > VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is too narrow a use-case t=
o commit to it
> > > > > as a kernel/userspace ABI: what if one wants to start rings in so=
me
> > > > > other specific order?
> > > >
> > > > Just enable a queue by writing e.g 1 to queue_enable in a specific =
order?
> > >
> > >
> > > But then at driver ok time we don't know how many queues are there.
> >
> > There should be a device specific interface for this, for example,
> > num_queue_paris. So the device knows at most how many queues there
> > are. Or anything I miss?
>
> That's a device limitations. Does not tell the device how much is used.

I think I miss something, how kick differs from queue_enable in this way?

>
> > >
> > > > > As was discussed on list, a better promise is not to access ring
> > > > > until the 1st kick. vdpa can then do a kick when it wants
> > > > > the device to start accessing rings.
> > > >
> > > > Rethink about the ACCESS_AFTER_KICK, it sounds functional equivalen=
t
> > > > to allow queue_enable after DRIVER_OK, but it seems to have
> > > > distanvages:
> > > >
> > > > A busy polling software device may disable notifications and never
> > > > respond to register to any kick notifiers. ACCESS_AFTER_KICK will
> > > > introduce overhead to those implementations.
> > > >
> > > > Thanks
> > >
> > > It's just the 1st kick, then you can disable. No?
> >
> > Yes, but:
> >
> > 1) adding hooks for queue_enable
> > 2) adding new codes to register event notifier and toggle the notifier
> >
> > 1) seems much easier? Or for most devices, it already behaves like this=
.
> >
> > Thanks
>
> Well libvhostuser checks enabled queues at DRIVER_OK, does it not?

Probably, but I meant:

1) This behaviour has been supported by some device (e.g MLX)
2) This is the current behaviour of Qemu for vhost-net devices:

static void virtio_net_queue_enable(VirtIODevice *vdev, uint32_t queue_inde=
x)
{
    VirtIONet *n =3D VIRTIO_NET(vdev);
    NetClientState *nc;
    int r;

    ....

    if (get_vhost_net(nc->peer) &&
        nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_TAP) {
        r =3D vhost_net_virtqueue_restart(vdev, nc, queue_index);
        if (r < 0) {
            error_report("unable to restart vhost net virtqueue: %d, "
                            "when resetting the queue", queue_index);
        }
    }
}

Thanks

>
> > >
> > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
> > > > > > > >   1 file changed, 7 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vd=
pa/mlx5/net/mlx5_vnet.c
> > > > > > > > index 9138ef2fb2c8..5f309a16b9dc 100644
> > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > @@ -7,6 +7,7 @@
> > > > > > > >   #include <uapi/linux/virtio_net.h>
> > > > > > > >   #include <uapi/linux/virtio_ids.h>
> > > > > > > >   #include <uapi/linux/vdpa.h>
> > > > > > > > +#include <uapi/linux/vhost_types.h>
> > > > > > > >   #include <linux/virtio_config.h>
> > > > > > > >   #include <linux/auxiliary_bus.h>
> > > > > > > >   #include <linux/mlx5/cq.h>
> > > > > > > > @@ -2499,6 +2500,11 @@ static void unregister_link_notifier=
(struct mlx5_vdpa_net *ndev)
> > > > > > > >                   flush_workqueue(ndev->mvdev.wq);
> > > > > > > >   }
> > > > > > > > +static u64 mlx5_vdpa_get_backend_features(const struct vdp=
a_device *vdpa)
> > > > > > > > +{
> > > > > > > > + return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >   static int mlx5_vdpa_set_driver_features(struct vdpa_devi=
ce *vdev, u64 features)
> > > > > > > >   {
> > > > > > > >           struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > > > > > > > @@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops m=
lx5_vdpa_ops =3D {
> > > > > > > >           .get_vq_align =3D mlx5_vdpa_get_vq_align,
> > > > > > > >           .get_vq_group =3D mlx5_vdpa_get_vq_group,
> > > > > > > >           .get_device_features =3D mlx5_vdpa_get_device_fea=
tures,
> > > > > > > > + .get_backend_features =3D mlx5_vdpa_get_backend_features,
> > > > > > > >           .set_driver_features =3D mlx5_vdpa_set_driver_fea=
tures,
> > > > > > > >           .get_driver_features =3D mlx5_vdpa_get_driver_fea=
tures,
> > > > > > > >           .set_config_cb =3D mlx5_vdpa_set_config_cb,
> > > > > > > > --
> > > > > > > > 2.39.3
> > > > >
> > >
>

