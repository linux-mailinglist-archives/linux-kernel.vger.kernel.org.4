Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF23673434
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjASJQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASJQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B09A4694
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674119735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XQQ4lc6kheET5/oy3Xq4ktug8IhMfWQNxejYqaV7zw=;
        b=JOvQs9AeSQXko0Q7u7DXpRBv/IICw4nWvRwnvYRKoDpq+Jh/VpKOUx260Atfb3Cx1PEcDo
        TJtxq0aMtNBPAIwavgnuC6AoLtokm3tJIKXMqUmqvC6nF/oTjtLnH/yIX+09j/+24EQ8WE
        ko0SE3aqjWnTkIScorB0uAtieBdEMCM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-410-LrY7pXSKOP2Ry7mwkXxyNg-1; Thu, 19 Jan 2023 04:15:34 -0500
X-MC-Unique: LrY7pXSKOP2Ry7mwkXxyNg-1
Received: by mail-yb1-f200.google.com with SMTP id x83-20020a25e056000000b007eda066c56eso1588732ybg.17
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XQQ4lc6kheET5/oy3Xq4ktug8IhMfWQNxejYqaV7zw=;
        b=YwtlmozIysTuzm+tL5HG46I+3LKmLVpHQWnQwcgSlr9dZJJAVJO25FJ3BSlrBDJkTB
         yOgKgbHV8nw8ANRFmqyVvU5ek1LMN/vMrncW7+ubAY1EmrTGyVrJFUzp/uc2tx2vkr0e
         y8WaTyoeUUtzazv7jXIbC0mXIM/bgtO8IgkPvYJot8rDWU6k+N4yRb0sk7xhQTQh6qFF
         ToInvVW/0oj5zCfz6PVlO4F8MMpdCcf8l12YhZOvlq5EPC2e6e9A7UITYo8fYpLcW1HH
         M+4u9JYyO9FPaj1s+b4jI6r8+p8lOAUFXnWH0MhDRtUSMxXUhnIDd8irqEfLzJgNBo2L
         BjFw==
X-Gm-Message-State: AFqh2koQHFE6Lwcbokv+ADStccbphgo2qrz+AwBJcUQ8sxff9zPT8MNH
        w76e7XT7C5trm5y7gZXb9hDgkex7lEUZVc/PLgYfQicmpwUsdT7MBOoIMvtPgPSR8Q8HO1TJPNr
        cnzZLeE3kAN1SuMYllxjkH8piWsCWO0Q0UsoixM8t
X-Received: by 2002:a5b:a8d:0:b0:707:3f66:a611 with SMTP id h13-20020a5b0a8d000000b007073f66a611mr1717697ybq.216.1674119733530;
        Thu, 19 Jan 2023 01:15:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsWXdeCFPw+B8svXDvzeM/+cPw+hccr3oTrvXUepr9W8gS5NInIQWyDR2R8axJP/JJl8mOS663+Tgc1n6nGyjc=
X-Received: by 2002:a5b:a8d:0:b0:707:3f66:a611 with SMTP id
 h13-20020a5b0a8d000000b007073f66a611mr1717684ybq.216.1674119733342; Thu, 19
 Jan 2023 01:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com> <20230118164359.1523760-2-eperezma@redhat.com>
 <CACGkMEt=po+FMEikgj3OXC7_QC=yhRP2Sx0NU=2sFPGgQ4bujA@mail.gmail.com>
In-Reply-To: <CACGkMEt=po+FMEikgj3OXC7_QC=yhRP2Sx0NU=2sFPGgQ4bujA@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 19 Jan 2023 10:14:57 +0100
Message-ID: <CAJaqyWejkbiwKK4O0qOObdf294YrzMeSRTVoWNzv75yQCvkJqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa_sim: not reset state in vdpasim_queue_ready
To:     Jason Wang <jasowang@redhat.com>
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

On Thu, Jan 19, 2023 at 4:16 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jan 19, 2023 at 12:44 AM Eugenio P=C3=A9rez <eperezma@redhat.com>=
 wrote:
> >
> > vdpasim_queue_ready calls vringh_init_iotlb, which resets split indexes=
.
> > But it can be called after setting a ring base with
> > vdpasim_set_vq_state.
> >
> > Fix it by stashing them. They're still resetted in vdpasim_vq_reset.
> >
> > This was discovered and tested live migrating the vdpa_sim_net device.
> >
> > Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/v=
dpa_sim.c
> > index cb88891b44a8..8839232a3fcb 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -66,6 +66,7 @@ static void vdpasim_vq_notify(struct vringh *vring)
> >  static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int =
idx)
> >  {
> >         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> > +       uint16_t last_avail_idx =3D vq->vring.last_avail_idx;
> >
> >         vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false=
,
> >                           (struct vring_desc *)(uintptr_t)vq->desc_addr=
,
> > @@ -74,6 +75,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpas=
im, unsigned int idx)
> >                           (struct vring_used *)
> >                           (uintptr_t)vq->device_addr);
> >
> > +       vq->vring.last_avail_idx =3D last_avail_idx;
>
> Does this need to be serialized with the datapath?
>
> E.g in set_vq_state() we do:
>
> spin_lock(&vdpasim->lock);
> vrh->last_avail_idx =3D state->split.avail_index;
> spin_unlock(&vdpasim->lock);
>

vdpasim_queue_ready is called from vdpasim_set_vq_ready, which holds
these locks.

Maybe it's too much indirection and to embed vdpasim_queue_ready in
vdpasim_set_vq_ready would be clearer for the future?

Thanks!

