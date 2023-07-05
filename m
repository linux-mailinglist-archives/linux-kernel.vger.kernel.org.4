Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E390747CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjGEFs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjGEFs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE53B2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688536081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmroFXVskoyZWXutVUB2JGgpokOFhXT+2nZZqoGKkeE=;
        b=DF4XqnWoT0ZrZ0AQzmmEBSrAA2/FKs6Y82ZiPbNoDldKdCe3sbxhm4OcyDsCTZZZApRulJ
        B6c2fesrm2CS5UASq0chhbEBDia0islRanfq4Vwpth7ju2lquXC++F7pKkY1oLk/KBgWOY
        Lo+VkpRCzKbYXbdkG88hA4qP8WS+Jnw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-aROfJT6wOlqiitrR74gHDg-1; Wed, 05 Jul 2023 01:47:59 -0400
X-MC-Unique: aROfJT6wOlqiitrR74gHDg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6ff1520c4so2839031fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 22:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688536077; x=1691128077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmroFXVskoyZWXutVUB2JGgpokOFhXT+2nZZqoGKkeE=;
        b=jIY+uA1ezrH28B0o+36ZYz19cWI1o/2c/CtYKU4rBJhWE/HwqZCuo3Y6V92CyhUYfo
         d9bseTw3rxBqFkkHcySDkfgX4gUOo2K4V4NfCDiswOH1XuW2IKX14sDX7U7ecd1kD4n4
         0vwJ+X+oYMBAPOaQRTWr4Roo88izx09A90XqCol+ykPDOlsYF1Q9m9yNtw8qKjB3Ynfa
         TgZMDwf1haLGwenFdp6iwpOcTVatlN4dgss379VdT0Wl9D+GKtTIhIRAofSbUl8ElrjZ
         0oHsAv3K3hDtwfB+pBcw3VoeDGCdL91hi8DMXO9RKEN57ucL9yWZJAm5+n4vJ5cwMUIK
         Ratw==
X-Gm-Message-State: ABy/qLacrfWeCxZXW0nGpexS7ToAjY66AlcweTVAZjsTYtlR24a6+cT6
        lSZUxD0Nr+s554aoMLleKhsSoGGSdSEREyLS5KdsTMjj2cqmoLwtM6997ynylAFfQxAPgNXM1RG
        6a3DphpZS0aEK1j5jTms5lpbFM58nQnz1MP6qBnYvm1RW6ac6JZg=
X-Received: by 2002:a2e:3009:0:b0:2b6:cca1:9760 with SMTP id w9-20020a2e3009000000b002b6cca19760mr11268077ljw.27.1688536077505;
        Tue, 04 Jul 2023 22:47:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJbAcx5OnoQwwCDRsQy35e80ns53wHBT0+rOr5PDRG5BfxOWvyoxtkBwuXWvIM6RmL1kY1Ozn/caXk3lKPNRU=
X-Received: by 2002:a2e:3009:0:b0:2b6:cca1:9760 with SMTP id
 w9-20020a2e3009000000b002b6cca19760mr11268038ljw.27.1688536076088; Tue, 04
 Jul 2023 22:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142514.363256-1-eperezma@redhat.com> <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com> <20230704061356-mutt-send-email-mst@kernel.org>
 <CACGkMEtAfiODhHEMFDKkaVFVs1yjfUFsjfy_=p8Jtd6BXAE1xQ@mail.gmail.com> <20230705012917-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230705012917-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 5 Jul 2023 13:47:44 +0800
Message-ID: <CACGkMEtBjTmChSQX_E_n6yvTi9rxH5UrXgfAU5qZsFAF-RZQWw@mail.gmail.com>
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

On Wed, Jul 5, 2023 at 1:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Jul 05, 2023 at 01:11:37PM +0800, Jason Wang wrote:
> > On Tue, Jul 4, 2023 at 6:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Mon, Jul 03, 2023 at 05:26:02PM -0700, Si-Wei Liu wrote:
> > > >
> > > >
> > > > On 7/3/2023 8:46 AM, Michael S. Tsirkin wrote:
> > > > > On Mon, Jul 03, 2023 at 04:25:14PM +0200, Eugenio P=C3=A9rez wrot=
e:
> > > > > > Offer this backend feature as mlx5 is compatible with it. It al=
lows it
> > > > > > to do live migration with CVQ, dynamically switching between pa=
ssthrough
> > > > > > and shadow virtqueue.
> > > > > >
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > Same comment.
> > > > to which?
> > > >
> > > > -Siwei
> > >
> > > VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is too narrow a use-case to co=
mmit to it
> > > as a kernel/userspace ABI: what if one wants to start rings in some
> > > other specific order?
> >
> > Just enable a queue by writing e.g 1 to queue_enable in a specific orde=
r?
>
>
> But then at driver ok time we don't know how many queues are there.

There should be a device specific interface for this, for example,
num_queue_paris. So the device knows at most how many queues there
are. Or anything I miss?

>
> > > As was discussed on list, a better promise is not to access ring
> > > until the 1st kick. vdpa can then do a kick when it wants
> > > the device to start accessing rings.
> >
> > Rethink about the ACCESS_AFTER_KICK, it sounds functional equivalent
> > to allow queue_enable after DRIVER_OK, but it seems to have
> > distanvages:
> >
> > A busy polling software device may disable notifications and never
> > respond to register to any kick notifiers. ACCESS_AFTER_KICK will
> > introduce overhead to those implementations.
> >
> > Thanks
>
> It's just the 1st kick, then you can disable. No?

Yes, but:

1) adding hooks for queue_enable
2) adding new codes to register event notifier and toggle the notifier

1) seems much easier? Or for most devices, it already behaves like this.

Thanks

>
> > >
> > > > >
> > > > > > ---
> > > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
> > > > > >   1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/m=
lx5/net/mlx5_vnet.c
> > > > > > index 9138ef2fb2c8..5f309a16b9dc 100644
> > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > @@ -7,6 +7,7 @@
> > > > > >   #include <uapi/linux/virtio_net.h>
> > > > > >   #include <uapi/linux/virtio_ids.h>
> > > > > >   #include <uapi/linux/vdpa.h>
> > > > > > +#include <uapi/linux/vhost_types.h>
> > > > > >   #include <linux/virtio_config.h>
> > > > > >   #include <linux/auxiliary_bus.h>
> > > > > >   #include <linux/mlx5/cq.h>
> > > > > > @@ -2499,6 +2500,11 @@ static void unregister_link_notifier(str=
uct mlx5_vdpa_net *ndev)
> > > > > >                   flush_workqueue(ndev->mvdev.wq);
> > > > > >   }
> > > > > > +static u64 mlx5_vdpa_get_backend_features(const struct vdpa_de=
vice *vdpa)
> > > > > > +{
> > > > > > + return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> > > > > > +}
> > > > > > +
> > > > > >   static int mlx5_vdpa_set_driver_features(struct vdpa_device *=
vdev, u64 features)
> > > > > >   {
> > > > > >           struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > > > > > @@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops mlx5_=
vdpa_ops =3D {
> > > > > >           .get_vq_align =3D mlx5_vdpa_get_vq_align,
> > > > > >           .get_vq_group =3D mlx5_vdpa_get_vq_group,
> > > > > >           .get_device_features =3D mlx5_vdpa_get_device_feature=
s,
> > > > > > + .get_backend_features =3D mlx5_vdpa_get_backend_features,
> > > > > >           .set_driver_features =3D mlx5_vdpa_set_driver_feature=
s,
> > > > > >           .get_driver_features =3D mlx5_vdpa_get_driver_feature=
s,
> > > > > >           .set_config_cb =3D mlx5_vdpa_set_config_cb,
> > > > > > --
> > > > > > 2.39.3
> > >
>

