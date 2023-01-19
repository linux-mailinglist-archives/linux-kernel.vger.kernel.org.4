Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C8673120
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjASFX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjASFXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:23:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F16CCE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674105781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UEAyeHzgkAupgJMwknbiDqBEC1GYYBnvH2SxqDruG38=;
        b=Xj9cjDrSdEWWLWKSm2i4lxcbFlGS2ADU/eARFyRtC1Vxr/zcQmWhj7FqnPj1Qrvivmqkce
        mUvp/o44V1LMTPU/wsSrwoIqKvGANo0fSBpzGBki+aVgHSbmjWqWRYbKGeCMHk+vajpGDQ
        FaTmqFS3VFzS1j5+KL/V7XrEfqXtZwA=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-ayKChKJxMHmY9xXWgJBIsw-1; Wed, 18 Jan 2023 22:16:25 -0500
X-MC-Unique: ayKChKJxMHmY9xXWgJBIsw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-15f8ddf4db1so475237fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEAyeHzgkAupgJMwknbiDqBEC1GYYBnvH2SxqDruG38=;
        b=urk3LgI+FYz7XfSVXte9Ch01/wzIXqNeujo4X1y5H9S5LirsXHZp20TyFy1LLe4D6q
         DzWNBBpzw4uZuUslV+XIHH0FoNVTHJKMFRKm5nIn9orV0dfvYpY9xCk11XIoShQmDgTS
         9d0Q/gTbdCqazvw4o2Rg5SwmZmZJl1iZadXrjgUHnPvEc1VzG2gmj2Rw8sy1T3KesybM
         X8bCfgLtmWU9WkMvFdtFqjl/iCDjG4fMmqRUpX60FwA7kFIBn19fsnUfU2OobKSZA+wI
         08ovD0h2aS5hVoeUJgnSWI+0m29WkPgEk5vOKP/l32/ykrd0ftz/Z1Y4fGoebpL+OFHd
         86LQ==
X-Gm-Message-State: AFqh2kqY1Rx3ZGzAjwOM/+r6Ee+ooEUZHOG9Iha5Ea7TUkiaoGC9TAUp
        jYXzqkxcBpqLydrJleNq12LYik4X9WqflkzNbrNYHTUFMOOjgzsN7JDaMMIhYVLeiVvUJ9RcUfd
        cEGvXsdz3SNxuo1jWkjyqJ6dKzHh0opc+iShscaGO
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id y14-20020a056871010e00b0015b96b59916mr809545oab.280.1674098184615;
        Wed, 18 Jan 2023 19:16:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtw1xnPLkvtcoMtHxPiTCTrubYN1NT29GYArw3LFI7S8h3cfpKtpx8ZzRduNDS5CMtlOt33jyUeuiK0rXs9Yww=
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr809544oab.280.1674098184424; Wed, 18
 Jan 2023 19:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com> <20230118164359.1523760-2-eperezma@redhat.com>
In-Reply-To: <20230118164359.1523760-2-eperezma@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 19 Jan 2023 11:16:13 +0800
Message-ID: <CACGkMEt=po+FMEikgj3OXC7_QC=yhRP2Sx0NU=2sFPGgQ4bujA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa_sim: not reset state in vdpasim_queue_ready
To:     =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc:     mst@redhat.com, leiyang@redhat.com,
        Laurent Vivier <lvivier@redhat.com>, sgarzare@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org, lulu@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, alvaro.karsz@solid-run.com
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

On Thu, Jan 19, 2023 at 12:44 AM Eugenio P=C3=A9rez <eperezma@redhat.com> w=
rote:
>
> vdpasim_queue_ready calls vringh_init_iotlb, which resets split indexes.
> But it can be called after setting a ring base with
> vdpasim_set_vq_state.
>
> Fix it by stashing them. They're still resetted in vdpasim_vq_reset.
>
> This was discovered and tested live migrating the vdpa_sim_net device.
>
> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index cb88891b44a8..8839232a3fcb 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -66,6 +66,7 @@ static void vdpasim_vq_notify(struct vringh *vring)
>  static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int id=
x)
>  {
>         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> +       uint16_t last_avail_idx =3D vq->vring.last_avail_idx;
>
>         vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
> @@ -74,6 +75,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim=
, unsigned int idx)
>                           (struct vring_used *)
>                           (uintptr_t)vq->device_addr);
>
> +       vq->vring.last_avail_idx =3D last_avail_idx;

Does this need to be serialized with the datapath?

E.g in set_vq_state() we do:

spin_lock(&vdpasim->lock);
vrh->last_avail_idx =3D state->split.avail_index;
spin_unlock(&vdpasim->lock);

Thanks

>         vq->vring.notify =3D vdpasim_vq_notify;
>  }
>
> --
> 2.31.1
>

