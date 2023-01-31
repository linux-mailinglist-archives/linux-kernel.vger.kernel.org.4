Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E762E6831C4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjAaPpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjAaPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:45:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3133401A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675179888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGjnTKQ6YYRBn7/7MbUUZQsLWkD289SreuAREfX+N2U=;
        b=Tejln2F3lM5Zx6abP5DpI3iuMw60tvLz1axI5cJKt3U9gZEswOKJP0fy4DmGWEzpDQMfrY
        1ealKKuAJtyMfshq4BYf6LNkSrXShYMXSYt7bA80vV7viqsFDov6QmjePIJ/B9E96B3orE
        xwX77cyCnUfT6YTwr7BrBfp6zTfsslE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669-TsxISaMEM3ummFpD8rGVpw-1; Tue, 31 Jan 2023 10:44:47 -0500
X-MC-Unique: TsxISaMEM3ummFpD8rGVpw-1
Received: by mail-ed1-f72.google.com with SMTP id j10-20020a05640211ca00b0049e385d5830so10992349edw.22
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGjnTKQ6YYRBn7/7MbUUZQsLWkD289SreuAREfX+N2U=;
        b=bZ6QWfJJv38waYxig19XiLMbvWHqCk1g1qWaZ7qzAp4GNi6Bsy9HBoUjdylKJ3Txx+
         bhjX1hzhJnQN6mRx7Fqt0TFSlTFWX1w/MLFLNehILzVh9+0ul09C24LmobENuQFAg05q
         euckGc+KDxvS94f2CdIMVkauY84zAwawStGgUEuMft1PYyYbw8XFBJgz5s3OZqI/dAUc
         zk0J/B0I/HKEf+fut0bzSJDt+PAOQsIm3QfgL6hSo3tpGYf4dKuKV2U3590s9sbUkHDP
         WKLA2v66rZNupp+8BjSlJ1tLSfpjKDNAtTMfY1bPwzymfXh00vXE2QQ09DFKxGc/0/aJ
         d75g==
X-Gm-Message-State: AO0yUKXng0SxbgfPPx/nvcoSJGwsgNo/KTB3opsZkEhI8mkTbpZnhDS+
        /2b+AwkWCZGA0YPzMZ9DeSUF+wsrPwFTDY+ZoYneEZ/tj+Vq6Az3bD4jlOr1cqO7Svb/70T2Zdk
        krLFLdQN45SArGKWGsbP5HYrWnTuBAsWRxH4JuH+l
X-Received: by 2002:aa7:db90:0:b0:4a0:a8d2:2291 with SMTP id u16-20020aa7db90000000b004a0a8d22291mr6757680edt.5.1675179885149;
        Tue, 31 Jan 2023 07:44:45 -0800 (PST)
X-Google-Smtp-Source: AK7set97DYQ16mIQRymCTp9rOhRub3yR0XszPmyDx6I/0bB3cMZfRhQczHYHLOr9KtjwA9EZdSAAwdz5ntkx3eD6oJ4=
X-Received: by 2002:aa7:db90:0:b0:4a0:a8d2:2291 with SMTP id
 u16-20020aa7db90000000b004a0a8d22291mr6757673edt.5.1675179884923; Tue, 31 Jan
 2023 07:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com> <20230118164359.1523760-2-eperezma@redhat.com>
 <CACGkMEt=po+FMEikgj3OXC7_QC=yhRP2Sx0NU=2sFPGgQ4bujA@mail.gmail.com>
 <CAJaqyWejkbiwKK4O0qOObdf294YrzMeSRTVoWNzv75yQCvkJqQ@mail.gmail.com> <1a1c8359-855d-7a05-686a-23935dcad5a9@redhat.com>
In-Reply-To: <1a1c8359-855d-7a05-686a-23935dcad5a9@redhat.com>
From:   Lei Yang <leiyang@redhat.com>
Date:   Tue, 31 Jan 2023 23:44:08 +0800
Message-ID: <CAPpAL=zh=0-0yN-kSynBphe2sat-B0zePckpZ8q7dtfYJxODzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa_sim: not reset state in vdpasim_queue_ready
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, mst@redhat.com,
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

The patch was tested by QE in a test environment and regression tested
using vdpa_sim device with virtio_vdpa and vhost_vdpa;There are no new
issues caused by this patch.

Tested-by: Lei Yang <leiyang@redhat.com>

Jason Wang <jasowang@redhat.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8829=E6=97=
=A5=E5=91=A8=E6=97=A5 13:56=E5=86=99=E9=81=93=EF=BC=9A
>
>
> =E5=9C=A8 2023/1/19 17:14, Eugenio Perez Martin =E5=86=99=E9=81=93:
> > On Thu, Jan 19, 2023 at 4:16 AM Jason Wang <jasowang@redhat.com> wrote:
> >> On Thu, Jan 19, 2023 at 12:44 AM Eugenio P=C3=A9rez <eperezma@redhat.c=
om> wrote:
> >>> vdpasim_queue_ready calls vringh_init_iotlb, which resets split index=
es.
> >>> But it can be called after setting a ring base with
> >>> vdpasim_set_vq_state.
> >>>
> >>> Fix it by stashing them. They're still resetted in vdpasim_vq_reset.
> >>>
> >>> This was discovered and tested live migrating the vdpa_sim_net device=
.
> >>>
> >>> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> >>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>> ---
> >>>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim.c
> >>> index cb88891b44a8..8839232a3fcb 100644
> >>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >>> @@ -66,6 +66,7 @@ static void vdpasim_vq_notify(struct vringh *vring)
> >>>   static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned i=
nt idx)
> >>>   {
> >>>          struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> >>> +       uint16_t last_avail_idx =3D vq->vring.last_avail_idx;
> >>>
> >>>          vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, fa=
lse,
> >>>                            (struct vring_desc *)(uintptr_t)vq->desc_a=
ddr,
> >>> @@ -74,6 +75,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdp=
asim, unsigned int idx)
> >>>                            (struct vring_used *)
> >>>                            (uintptr_t)vq->device_addr);
> >>>
> >>> +       vq->vring.last_avail_idx =3D last_avail_idx;
> >> Does this need to be serialized with the datapath?
> >>
> >> E.g in set_vq_state() we do:
> >>
> >> spin_lock(&vdpasim->lock);
> >> vrh->last_avail_idx =3D state->split.avail_index;
> >> spin_unlock(&vdpasim->lock);
> >>
> > vdpasim_queue_ready is called from vdpasim_set_vq_ready, which holds
> > these locks.
> >
> > Maybe it's too much indirection and to embed vdpasim_queue_ready in
> > vdpasim_set_vq_ready would be clearer for the future?
>
>
> Nope, I miss the caller.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>
> >
> > Thanks!
> >
>

