Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0266CEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjAPSbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjAPSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:31:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DB1442D6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673893016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RndVneLxltFQQNDMgD1ceuftx5JF76I+LiBvNh/m1Ic=;
        b=aXuf5Mj9d7yM+r0nNSFUBF3rbclijBuNJhRGGMXtx8fpcGT3kUp5BRh6WH9yPHbLBjstPK
        H7nFdz7tdJQmRju6op2tyc1rCzQmcp2IESxJ8TzFtXlwKr4p5ws5fu2VAF7aUEgIK7bYqU
        xYKlNBK0rLG8xnBNFMCM7OfkvRl09qs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-312-ySQ_wewIOmq6hi-PYLW1iQ-1; Mon, 16 Jan 2023 13:16:52 -0500
X-MC-Unique: ySQ_wewIOmq6hi-PYLW1iQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-4e62022894dso46797467b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RndVneLxltFQQNDMgD1ceuftx5JF76I+LiBvNh/m1Ic=;
        b=pBA/nRDcyOIvA7i1aGzt9DC4k4soRyBO/R0ti5vMf6Fm4jeFk/FOZSvyDhNo/h14Ni
         Tz1rxaPiaRfUsN7q0yKgHekDC1w+v2IGGv6NFTiTPqtPia3GYZUrUbeusT9tdd47oDE8
         hcdIS3M308f7lX5NzGjYI//86Nnhr7CkmrtQpdzEbFlDCd0EbxfAFuvE45FGhEUa0pll
         +WBAMEhbv3BDcBiFwnRoSDHKmYqa6m2A7otNUw9SUynBUKJTJCywMUommlgF+csk7cKb
         XHpi8FW/ixexrfL+mqTKoHt41LEeq9HC5f0wiQe2rwYO25Uo302H1i3k7kesMIYH65c7
         AONg==
X-Gm-Message-State: AFqh2kograLWPC+lgOLg6KnvCFeXFEpL3YGpHSzgZ9xXTkLj5lMMb0Tt
        EaWPsNZkrEIiZOf4G4QtJwkEX3LUrLl8MyZv1Ve0eb254Yvak4Pa7Kme4p7k0VqCRlWsqCUKOlm
        EIduUkl+T8dVpgynZc2EJki4X2xD/5Ao1Y2Ocg8tx
X-Received: by 2002:a0d:fc86:0:b0:4db:3ac0:78a3 with SMTP id m128-20020a0dfc86000000b004db3ac078a3mr28229ywf.266.1673893012122;
        Mon, 16 Jan 2023 10:16:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuqQMVzxUNJJRcR6yw+ex0cxw5m9eWckdmuAFZaSlKFM0GapCktflp7U+CCg8Xqj1gVn8s3jqkiDsMEU5Ze/14=
X-Received: by 2002:a0d:fc86:0:b0:4db:3ac0:78a3 with SMTP id
 m128-20020a0dfc86000000b004db3ac078a3mr28222ywf.266.1673893011933; Mon, 16
 Jan 2023 10:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20230112142218.725622-1-eperezma@redhat.com> <20230112142218.725622-2-eperezma@redhat.com>
 <DM8PR12MB5400550E8664315306F04DFAABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400550E8664315306F04DFAABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 16 Jan 2023 19:16:15 +0100
Message-ID: <CAJaqyWeUrpc_YnPzkW+PDV+W85Hn_AMTu_CUN9NsSsDtcOHDmw@mail.gmail.com>
Subject: Re: [RFC 1/3] vdpa/mlx5: reset iotlb at dup_iotlb
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

On Mon, Jan 16, 2023 at 7:32 AM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Sent: Thursday, 12 January 2023 16:22
> > To: mst@redhat.com; Eli Cohen <elic@nvidia.com>
> > Cc: linux-kernel@vger.kernel.org; Parav Pandit <parav@nvidia.com>;
> > lulu@redhat.com; jasowang@redhat.com; virtualization@lists.linux-
> > foundation.org; sgarzare@redhat.com; si-wei.liu@oracle.com
> > Subject: [RFC 1/3] vdpa/mlx5: reset iotlb at dup_iotlb
> >
> > Regular memory region changes already reset cvq iotlb at set_map.
> > However this is not true if CVQ and data VQs are in different ASID.
> >
> > Clean the CVQ iotlb every time we hit dup_iotlb.
> >
> > Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for
> > control and data")
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/core/mr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> > index 0a1e0b0dc37e..ae34dcac9a3f 100644
> > --- a/drivers/vdpa/mlx5/core/mr.c
> > +++ b/drivers/vdpa/mlx5/core/mr.c
> > @@ -456,6 +456,8 @@ static int dup_iotlb(struct mlx5_vdpa_dev *mvdev,
> > struct vhost_iotlb *src)
> >       u64 start =3D 0, last =3D ULLONG_MAX;
> >       int err;
> >
> > +     vhost_iotlb_reset(mvdev->cvq.iotlb);
> > +
>
> As far as I can see, mlx5_vdpa_destroy_mr() is called independently of th=
e asid
> and it will calls prune_iotlb() which resets the cvq iotlb. Am I missing =
something?
>

Sorry, my fault. It is not obvious from the patch but this prepares the cod=
e for
the next patch in the series.

With the next patch applied, prune_iotlb is not called in all
contexts. This patch may be dropped in future series.

Thanks!


> >       if (!src) {
> >               err =3D vhost_iotlb_add_range(mvdev->cvq.iotlb, start, la=
st,
> > start, VHOST_ACCESS_RW);
> >               return err;
> > --
> > 2.31.1
>

