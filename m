Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295A0728E05
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbjFICba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjFICb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E3B184
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686277841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKgD86aH+Hk476sIqnZ+1f0IUBYFa81TWL41lgouwhA=;
        b=Z9rA8n3VsvlaY7nCrOxaN+zQxU7hadnaCvjdFwd03/SzHauPE0JK/rQ2EhfKWvO4soqOMs
        efCwrqjhRcfy3af6Wx02Es9CLFh0zjr9JsQbxWJqT5rJFWwcLg/QXYwZ8o2Di1GlPIO+dV
        cNoyd4vxfdhoA0gglVGMhRt0nWqsN+4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-nTyQyUKBMq6siZHHBOb_Kg-1; Thu, 08 Jun 2023 22:30:40 -0400
X-MC-Unique: nTyQyUKBMq6siZHHBOb_Kg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b1fa7c9f06so9411131fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277838; x=1688869838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKgD86aH+Hk476sIqnZ+1f0IUBYFa81TWL41lgouwhA=;
        b=EFu5Y51VVOk6RfDyqsC46ZZzIxTzeBW5sNDpazgrnqMBbMEKV6vMDvAZXpjFIURLQD
         7KtQKum+N2YYmArPcD7iA0WfEJlx7AQOXryWG2ywkHjE/PHYgSSwD2Xs66LuT35WtTJo
         oU1XLM1DkEW5oVBccZHvBfaFK73M9LaSD3j4BTo5BWWgqVEx80wPt8EEfIX/1s6eJP++
         bP9ZXKjyC+ribOVmXg/8HDn1AYXSFL/N5pFETZmpQoUGLFNNCCVX5mTsPzb09Eg0FmfH
         vHoINRcXgiuy82AtAcrMtRXDlXi+rK/mY/PSmMDIPnos9LiBDJHNrHOgJA8VVGcbFF3M
         kbaw==
X-Gm-Message-State: AC+VfDzFfTTQej7obXCsS6NcZj49Prl6JsZ3KVLeXEz+KxVE1aAvQ575
        dtlmsuxFqqLL2BfBwpeAoqakZd15D8S7E+ACNfD8oLZBf4NtUK/ARn7wzee0z5ZSKaGpSbprouw
        tViWzKefG8DMyzPV3tw42QXDJZstmMtV7mvW4WM62AwUzmraaQs0=
X-Received: by 2002:a2e:924d:0:b0:2b1:a89a:5f2b with SMTP id v13-20020a2e924d000000b002b1a89a5f2bmr183766ljg.2.1686277838355;
        Thu, 08 Jun 2023 19:30:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pevOrBrCsNb1IENdHqkhs641dGBpLXa2ghTiJTJJMM4HdgIkhAjxbOjka9rRk1NwS3K7oNe59vxPgtKSdQhA=
X-Received: by 2002:a2e:924d:0:b0:2b1:a89a:5f2b with SMTP id
 v13-20020a2e924d000000b002b1a89a5f2bmr183760ljg.2.1686277838060; Thu, 08 Jun
 2023 19:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com> <20230608154400-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608154400-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 9 Jun 2023 10:30:27 +0800
Message-ID: <CACGkMEuEXAioOvDAZkkkcKc+vkz5Py29jYrC+uTUVG-bahx8Lw@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from add_config
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Angus Chen <angus.chen@jaguarmicro.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Fri, Jun 9, 2023 at 3:45=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Jun 08, 2023 at 05:01:24PM +0800, Angus Chen wrote:
> > When add virtio_pci vdpa device,check the vqs number of device cap
> > and max_vq_pairs from add_config.
> > Simply starting from failing if the provisioned #qp is not
> > equal to the one that hardware has.

I think I kind of agree with Michael, I don't see any obvious
advantages to allow usersapce to configure max_vqp if it can't be
provisioned dynamically. What's wrong if we just stick the current
approach that doesn't accept max_vqp?

A better approach is to tweak the vdpa tool to display the legal
attributes that can be provisioned.

> >
> > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
>
> I am not sure about this one. How does userspace know
> which values are legal?

vdpa mgmtdev show can gives hints like:

max_supported_vqs 3

>
> If there's no way then maybe we should just cap the value
> to what device can support but otherwise keep the device
> working.

This seems conflict to how other drivers (like mlx5) did:

        if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
                if (add_config->net.max_vq_pairs > max_vqs / 2)
                        return -EINVAL;
                max_vqs =3D min_t(u32, max_vqs, 2 * add_config->net.max_vq_=
pairs);
        } else {
                max_vqs =3D 2;
        }

Thanks

>
> > ---
> > v1: Use max_vqs from add_config
> > v2: Just return fail if max_vqs from add_config is not same as device
> >       cap. Suggested by jason.
> >
> >  drivers/vdpa/virtio_pci/vp_vdpa.c | 35 ++++++++++++++++++-------------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pc=
i/vp_vdpa.c
> > index 281287fae89f..c1fb6963da12 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -480,32 +480,39 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
> >       u64 device_features;
> >       int ret, i;
> >
> > -     vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> > -                                 dev, &vp_vdpa_ops, 1, 1, name, false)=
;
> > -
> > -     if (IS_ERR(vp_vdpa)) {
> > -             dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\=
n");
> > -             return PTR_ERR(vp_vdpa);
> > +     if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> > +             if (add_config->net.max_vq_pairs !=3D (v_mdev->max_suppor=
ted_vqs / 2)) {
> > +                     dev_err(&pdev->dev, "max vqs 0x%x should be equal=
 to 0x%x which device has\n",
> > +                             add_config->net.max_vq_pairs*2, v_mdev->m=
ax_supported_vqs);
> > +                     return -EINVAL;
> > +             }
> >       }
> >
> > -     vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
> > -
> > -     vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> > -     vp_vdpa->queues =3D vp_modern_get_num_queues(mdev);
> > -     vp_vdpa->mdev =3D mdev;
> > -
> >       device_features =3D vp_modern_get_features(mdev);
> >       if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> >               if (add_config->device_features & ~device_features) {
> > -                     ret =3D -EINVAL;
> >                       dev_err(&pdev->dev, "Try to provision features "
> >                               "that are not supported by the device: "
> >                               "device_features 0x%llx provisioned 0x%ll=
x\n",
> >                               device_features, add_config->device_featu=
res);
> > -                     goto err;
> > +                     return -EINVAL;
> >               }
> >               device_features =3D add_config->device_features;
> >       }
> > +
> > +     vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> > +                                 dev, &vp_vdpa_ops, 1, 1, name, false)=
;
> > +
> > +     if (IS_ERR(vp_vdpa)) {
> > +             dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\=
n");
> > +             return PTR_ERR(vp_vdpa);
> > +     }
> > +
> > +     vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
> > +
> > +     vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> > +     vp_vdpa->queues =3D v_mdev->max_supported_vqs;
> > +     vp_vdpa->mdev =3D mdev;
> >       vp_vdpa->device_features =3D device_features;
> >
> >       ret =3D devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, p=
dev);
> > --
> > 2.25.1
>

