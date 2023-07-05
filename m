Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E134747C44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGEFMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGEFMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFBE10E3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 22:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688533912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tO3P2mQX6+9ZgDhiDUsWuq97gou5mJ4BQnOKdZt/xjA=;
        b=jCqPV3KQS84kngkXQg1F4r2aIHd8MT0BR2C8OSdntRzwC04xtdm3pm3vWZiRUErAkpd1N6
        1+s7NxRBBQaYj3EyCygXaauSW0i6AkhrHz5JfppVAlfU/3ra5o2ASe2eXIrnc8NX4JbN02
        AG+B2KzFA4Mwv0z6BGuSgfYfL1AAtPw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-HDgFt1CYOqO_D9UIyuisgA-1; Wed, 05 Jul 2023 01:11:51 -0400
X-MC-Unique: HDgFt1CYOqO_D9UIyuisgA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6a2a5f08aso61467301fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 22:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688533909; x=1691125909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tO3P2mQX6+9ZgDhiDUsWuq97gou5mJ4BQnOKdZt/xjA=;
        b=DPXT8oWgyUJNxNUbThqFLofxdvLdAwLRhEZaEpyevzb78tRyQqOIMOuNUkXqEvIbUc
         qynNxgfIOaj4Q4coRqj2ZkLvhtTS4PdDi87u56jXrkrtRqRwezvGFcJI75qirAnPI826
         /O620Niu0wCAUmgfDeO3v8VpMbcM76qmx5nfSLEiPu2UtIog5bdYxii4uZefpE+B4l1b
         RBvlhpx4TwrVjLVvtOb0iBcEg4rkcSwXnR820XC8eYlyAzw0yzb5Wx+0U7d8scBrwuVW
         hEv16G6AmvRxxAdMgXsh5sTvR6nDKOVMtMBsllsJKdat6+3sRqAdniFgRXPc24psysHW
         kqyQ==
X-Gm-Message-State: ABy/qLYMEBwP4VqAPTxTpFDNO0beTuMTmChVa4lwSPXjL7r+wxri0WFA
        nWF0tTRVgZ6Q8jbhUnMvTnqCOj6c8JfeBoTadDeVVpZ316YP4YWNAAllGYGrV1s0NveuxQ4CYGp
        UQ+gC3xlf0lV01kP60b0NKt3GQh0BN+trWlXD5/V8
X-Received: by 2002:a2e:9104:0:b0:2b6:9c1d:dea3 with SMTP id m4-20020a2e9104000000b002b69c1ddea3mr11475461ljg.2.1688533909764;
        Tue, 04 Jul 2023 22:11:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGu7A2d5AY6kY3vs5pzspcaW+PcHAazZkUtZptPO44mksXuaFuecbTqN1XahcBVBOOfWpRErBWvTYqQ13Rbu38=
X-Received: by 2002:a2e:9104:0:b0:2b6:9c1d:dea3 with SMTP id
 m4-20020a2e9104000000b002b69c1ddea3mr11475446ljg.2.1688533909459; Tue, 04 Jul
 2023 22:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142514.363256-1-eperezma@redhat.com> <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com> <20230704061356-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704061356-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 5 Jul 2023 13:11:37 +0800
Message-ID: <CACGkMEtAfiODhHEMFDKkaVFVs1yjfUFsjfy_=p8Jtd6BXAE1xQ@mail.gmail.com>
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

On Tue, Jul 4, 2023 at 6:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Jul 03, 2023 at 05:26:02PM -0700, Si-Wei Liu wrote:
> >
> >
> > On 7/3/2023 8:46 AM, Michael S. Tsirkin wrote:
> > > On Mon, Jul 03, 2023 at 04:25:14PM +0200, Eugenio P=C3=A9rez wrote:
> > > > Offer this backend feature as mlx5 is compatible with it. It allows=
 it
> > > > to do live migration with CVQ, dynamically switching between passth=
rough
> > > > and shadow virtqueue.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > Same comment.
> > to which?
> >
> > -Siwei
>
> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is too narrow a use-case to commit=
 to it
> as a kernel/userspace ABI: what if one wants to start rings in some
> other specific order?

Just enable a queue by writing e.g 1 to queue_enable in a specific order?

> As was discussed on list, a better promise is not to access ring
> until the 1st kick. vdpa can then do a kick when it wants
> the device to start accessing rings.

Rethink about the ACCESS_AFTER_KICK, it sounds functional equivalent
to allow queue_enable after DRIVER_OK, but it seems to have
distanvages:

A busy polling software device may disable notifications and never
respond to register to any kick notifiers. ACCESS_AFTER_KICK will
introduce overhead to those implementations.

Thanks

>
> > >
> > > > ---
> > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
> > > >   1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/=
net/mlx5_vnet.c
> > > > index 9138ef2fb2c8..5f309a16b9dc 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -7,6 +7,7 @@
> > > >   #include <uapi/linux/virtio_net.h>
> > > >   #include <uapi/linux/virtio_ids.h>
> > > >   #include <uapi/linux/vdpa.h>
> > > > +#include <uapi/linux/vhost_types.h>
> > > >   #include <linux/virtio_config.h>
> > > >   #include <linux/auxiliary_bus.h>
> > > >   #include <linux/mlx5/cq.h>
> > > > @@ -2499,6 +2500,11 @@ static void unregister_link_notifier(struct =
mlx5_vdpa_net *ndev)
> > > >                   flush_workqueue(ndev->mvdev.wq);
> > > >   }
> > > > +static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device=
 *vdpa)
> > > > +{
> > > > + return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> > > > +}
> > > > +
> > > >   static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev=
, u64 features)
> > > >   {
> > > >           struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > > > @@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops mlx5_vdpa=
_ops =3D {
> > > >           .get_vq_align =3D mlx5_vdpa_get_vq_align,
> > > >           .get_vq_group =3D mlx5_vdpa_get_vq_group,
> > > >           .get_device_features =3D mlx5_vdpa_get_device_features,
> > > > + .get_backend_features =3D mlx5_vdpa_get_backend_features,
> > > >           .set_driver_features =3D mlx5_vdpa_set_driver_features,
> > > >           .get_driver_features =3D mlx5_vdpa_get_driver_features,
> > > >           .set_config_cb =3D mlx5_vdpa_set_config_cb,
> > > > --
> > > > 2.39.3
>

