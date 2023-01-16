Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D07E66BC07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjAPKn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAPKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643D61969B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673865626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QFBkEdvWf9cNypMAIWf4qYzs+8ZZg6csxUkawLRiG4=;
        b=GM1Q+faXbqsZcRWhocJPHRqxVjVhKKSBXB6OVGvUqoltqvq9s47SMa0Qud+CmTOChwB451
        aMETmbnk9/f3Uu/l/B6W/TlvxHswwydyn0hJU5GUx0aZElt0fcMhgQii9p1vVn5lWmoC2v
        7OAc4fZdgjr3aSkIaCxlZa6um4QXJl8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-j5_UWf89MgC1c2G-1gcp1w-1; Mon, 16 Jan 2023 05:40:24 -0500
X-MC-Unique: j5_UWf89MgC1c2G-1gcp1w-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-4dedc46e2d5so83225527b3.21
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QFBkEdvWf9cNypMAIWf4qYzs+8ZZg6csxUkawLRiG4=;
        b=XjOrf6UYvmDQb39XEk5032Qd1cbmfAZ5QUhaUMcpAi/lfMqsNxQF9iifBiq91xI41v
         j6SQWXLPJYvAuh2Kp5c8pJPhcEvkHtIdsXhkffgkqjp4gSB+WizWwOWIQ/3HXMsbP9nk
         0x2vgtULeyl1uXH0VlN5lLNuTlE2aS63fEZ5rVDxRvAQUMG+NRv0iAiJg7xeWofeB3wM
         Eb0aLodxkVKsKjvXS2NVadAdAUk0LcpHH1avosJuRhfnrwPDUwBVxJxaPA5nk1k1OWWp
         mEq4EZNLwSJQNg11cvI0hcvK0TvfAu7g5xJOAxKWoxQqGa/lHaeg3cuhQsCSOcMJc2BZ
         lbVg==
X-Gm-Message-State: AFqh2koCV5q78mDF+enCarHhec0stmEh4mDvrEN4XwvRVbROXABCWuGt
        Cth9zotSO6OwXfEhDb7WC+AWMhFHJ2PfG7xvKYtSVMMCK3DjRwVJyczdF0t+pUx/g9mMQ+v9San
        HuVKNtXQOR8+llHde9Q+JWPkjR2f+8W2kxCjROUGn
X-Received: by 2002:a25:81d0:0:b0:7d2:891e:ee59 with SMTP id n16-20020a2581d0000000b007d2891eee59mr1119879ybm.152.1673865624066;
        Mon, 16 Jan 2023 02:40:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtTeKQueytBHJsdTA0TtFA28IlDVOY0VUzlujVZOI1l/gLDniG75dLkHCpOQYtorOEuTnKjSSGfH3iJCGtFYY8=
X-Received: by 2002:a25:81d0:0:b0:7d2:891e:ee59 with SMTP id
 n16-20020a2581d0000000b007d2891eee59mr1119870ybm.152.1673865623865; Mon, 16
 Jan 2023 02:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20230112142218.725622-1-eperezma@redhat.com> <20230112142218.725622-4-eperezma@redhat.com>
 <DM8PR12MB54000ADBE1A0717362433C1FABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54000ADBE1A0717362433C1FABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 16 Jan 2023 11:39:47 +0100
Message-ID: <CAJaqyWdrg1nkBSdOmZU=+Nns8UEqoyX7C+wqyk+dOPtv8UW22Q@mail.gmail.com>
Subject: Re: [RFC 3/3] vdpa/mlx5: take iommu_lock at dup_iotlb
To:     Eli Cohen <elic@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
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

On Mon, Jan 16, 2023 at 8:13 AM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Sent: Thursday, 12 January 2023 16:22
> > To: mst@redhat.com; Eli Cohen <elic@nvidia.com>
> > Cc: linux-kernel@vger.kernel.org; Parav Pandit <parav@nvidia.com>;
> > lulu@redhat.com; jasowang@redhat.com; virtualization@lists.linux-
> > foundation.org; sgarzare@redhat.com; si-wei.liu@oracle.com
> > Subject: [RFC 3/3] vdpa/mlx5: take iommu_lock at dup_iotlb
> >
> > Both iommu changes and lookup are protected by mlx5_vdpa_net->reslock a=
t
> > this moment, but:
> > * These iotlb changes / queries are not in the fast data path.
> > * reslock belongs to netdev, while dup_iotlb seems generic.
> > * It's located in a different file than the lock it needs to hold
> >
> > Justifies the lock acquisition.
> >
>
> Following this reasoning we should take the spinlock wherever we referenc=
e an iotlb.

vring.c:iotlb_translate takes it.

> Question if it make sense that the iotlb could change while it is being r=
eferenced.
> Can you identify a specific case for this?
>

Not at this moment, because both are protected by
mlx5_vdpa_net->reslock before access or change iotlb. So this would
require changes to be exploitable, that's true.

However, to take the lock is the expected usage for vringh, so future
changes to either mlx or vringh could miss it.

Thanks!

> > Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC
> > setting")
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/core/mr.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> > index 878ee94efa78..e9c8a7f8ee1d 100644
> > --- a/drivers/vdpa/mlx5/core/mr.c
> > +++ b/drivers/vdpa/mlx5/core/mr.c
> > @@ -454,13 +454,15 @@ static int dup_iotlb(struct mlx5_vdpa_dev *mvdev,
> > struct vhost_iotlb *src)
> >  {
> >       struct vhost_iotlb_map *map;
> >       u64 start =3D 0, last =3D ULLONG_MAX;
> > -     int err;
> > +     int err =3D 0;
> > +
> > +     spin_lock(&mvdev->cvq.iommu_lock);
> >
> >       vhost_iotlb_reset(mvdev->cvq.iotlb);
> >
> >       if (!src) {
> >               err =3D vhost_iotlb_add_range(mvdev->cvq.iotlb, start, la=
st,
> > start, VHOST_ACCESS_RW);
> > -             return err;
> > +             goto out;
> >       }
> >
> >       for (map =3D vhost_iotlb_itree_first(src, start, last); map;
> > @@ -468,9 +470,12 @@ static int dup_iotlb(struct mlx5_vdpa_dev *mvdev,
> > struct vhost_iotlb *src)
> >               err =3D vhost_iotlb_add_range(mvdev->cvq.iotlb, map->star=
t,
> > map->last,
> >                                           map->addr, map->perm);
> >               if (err)
> > -                     return err;
> > +                     goto out;
> >       }
> > -     return 0;
> > +
> > +out:
> > +     spin_unlock(&mvdev->cvq.iommu_lock);
> > +     return err;
> >  }
> >
> >  static void prune_iotlb(struct mlx5_vdpa_dev *mvdev)
> > --
> > 2.31.1
>

