Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CAA74482F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 11:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGAJRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 05:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGAJRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 05:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E83B7
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688203017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5P8+oZe2nmTOWnWCkmaHcGjW4ddEKWX+zP9ge5Dhnp4=;
        b=JS9WJ7Wc8yk8XUq1XkgsibRT5lcGa6sxBeVWCKZTUOzuCO6TLDMKdAdQKxYav7zl38gTdt
        HuD1zFMTFp6fv3zwdlaxwb3bQ1bIV72PKWrjsnJ7L2EQCn7BT2i8bPHZbxSZJ7swhI5ETZ
        2naRY1end8XM2XL6lAZueHsfyRj6vFg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-b-c4uW22PIKSCJOJUKQb5g-1; Sat, 01 Jul 2023 05:16:56 -0400
X-MC-Unique: b-c4uW22PIKSCJOJUKQb5g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3142d0ddc58so142862f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 02:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688203015; x=1690795015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P8+oZe2nmTOWnWCkmaHcGjW4ddEKWX+zP9ge5Dhnp4=;
        b=EJ6jgpTpGLA2xrtdUV5YLQ3ja8n2ld6sxhsHzQEHBjvHPyMMWwUUewL/sSnTPMgvGt
         MzdirEX+dl/coREvlKOO4gIasxDC4LEkSn5Olr9dwZyLqOmunXBKYKrY9Be2Ba57V15s
         j70B39Mxr+28YxOYUwIA0RBDwNOTzvOdeKw0g0hgBqgxWIBMKZYCkdEme0uhCuMcv0DE
         DIHSDt523njqoux1/9MdhtzM+H60WNsrIKj/vTbS54UwOKBGK+bFHOCChmQn8iQn7TSY
         PXg3dNLpPagOVriVWE0w/ZNKi+XPiS++EQIM3iOtu5aQCUe3ubyWRNvX1dwTW4wUl8A9
         AWMQ==
X-Gm-Message-State: ABy/qLbB6VVWyyN4XGJsvjlEatjfgwb9jqeNUyGlFEs7ZmGwwQQhsqTf
        u//fQm2e7aZRtRXn+OAz3Jzn62vAD4o9AmK846vEAeQKam8PJ8+oHDwxysUKdy2JgR6phvA/fP8
        nqYZpXozmTQqvH0QKAzANBd7nlOyxAgzuEIpU7x/E
X-Received: by 2002:a5d:6852:0:b0:314:415:cbf5 with SMTP id o18-20020a5d6852000000b003140415cbf5mr3287989wrw.51.1688203015241;
        Sat, 01 Jul 2023 02:16:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFP3EMRENIi4DQ20/IEBTU2KVd2ubnsbHO86eBAPDozHrZF1MK7rYVDNEdoWWEJqptXlwjlPPkCIWy6yF4bzDg=
X-Received: by 2002:a5d:6852:0:b0:314:415:cbf5 with SMTP id
 o18-20020a5d6852000000b003140415cbf5mr3287980wrw.51.1688203014977; Sat, 01
 Jul 2023 02:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com> <20230628065919.54042-4-lulu@redhat.com>
 <CACGkMEs2V2gqGOv1jd-ZrT-9HHnSU6dhC=1zUojHRDGCeG2E7w@mail.gmail.com>
In-Reply-To: <CACGkMEs2V2gqGOv1jd-ZrT-9HHnSU6dhC=1zUojHRDGCeG2E7w@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Sat, 1 Jul 2023 17:16:14 +0800
Message-ID: <CACLfguXFWEs6QLf5Ba65Y_a-i9bQTc-SLvdGfYMAJ+u6BYaLPg@mail.gmail.com>
Subject: Re: [RFC 3/4] vduse: Add the function for get/free the mapp pages
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, maxime.coquelin@redhat.com,
        xieyongji@bytedance.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 4:11=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jun 28, 2023 at 2:59=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > From: Your Name <you@example.com>
> >
> > Add the function for get/free pages, ad this info
> > will saved in dev->reconnect_info
>
> I think this should be squashed to patch 2 otherwise it fixes a bug
> that is introduced in patch 2?
>
sure will do
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 35 ++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 1b833bf0ae37..3df1256eccb4 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1313,6 +1313,35 @@ static struct vduse_dev *vduse_dev_get_from_mino=
r(int minor)
> >         return dev;
> >  }
> >
> > +int vduse_get_vq_reconnnect(struct vduse_dev *dev, u16 idx)
> > +{
> > +       struct vdpa_reconnect_info *area;
> > +       void *addr =3D (void *)get_zeroed_page(GFP_KERNEL);
> > +
> > +       area =3D &dev->reconnect_info[idx];
> > +
> > +       area->addr =3D virt_to_phys(addr);
> > +       area->vaddr =3D (unsigned long)addr;
> > +       area->size =3D PAGE_SIZE;
> > +       area->index =3D idx;
> > +
> > +       return 0;
> > +}
> > +
> > +int vduse_free_vq_reconnnect(struct vduse_dev *dev, u16 idx)
> > +{
> > +       struct vdpa_reconnect_info *area;
> > +
> > +       area =3D &dev->reconnect_info[idx];
> > +       if ((area->size =3D=3D PAGE_SIZE) && (area->addr !=3D NULL)) {
> > +               free_page(area->vaddr);
> > +               area->size =3D 0;
> > +               area->addr =3D 0;
> > +               area->vaddr =3D 0;
> > +       }
> > +
> > +       return 0;
> > +}
> >
> >  static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
> >  {
> > @@ -1446,6 +1475,10 @@ static int vduse_destroy_dev(char *name)
> >                 mutex_unlock(&dev->lock);
> >                 return -EBUSY;
> >         }
> > +       for (int i =3D 0; i < dev->vq_num; i++) {
> > +
> > +               vduse_free_vq_reconnnect(dev, i);
> > +       }
> >         dev->connected =3D true;
> >         mutex_unlock(&dev->lock);
> >
> > @@ -1583,6 +1616,8 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >                 INIT_WORK(&dev->vqs[i].kick, vduse_vq_kick_work);
> >                 spin_lock_init(&dev->vqs[i].kick_lock);
> >                 spin_lock_init(&dev->vqs[i].irq_lock);
> > +
> > +               vduse_get_vq_reconnnect(dev, i);
>
> Can we delay the allocated until fault?
>
sure will do
> Thanks
>
> >         }
> >
> >         ret =3D idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL=
);
> > --
> > 2.34.3
> >
>

