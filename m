Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92793625E88
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiKKPmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiKKPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:42:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E85C7C8F0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668181271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uN6wTTa506SkxCujAOyPtXwdqOBElP2lQFtFf0Vat6I=;
        b=dRkltKl+DBeW6m5VwvJBv9cXc0h2HcjfIFBGU4BKmHKGRqF2jm5jRD2m3H1Lnj7DQjZVCC
        9xtPMGAr9JAsXFkiXlIw/ou4fjasSptJKnqdfccNX7CoFBFFfJw5IidZLjXXMMcpOBVvI+
        il4MTrcCqHEj8vVQgB+bW91PkocKauY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-450-bFEUO5ExOdi9p5xpDE5jMg-1; Fri, 11 Nov 2022 10:41:10 -0500
X-MC-Unique: bFEUO5ExOdi9p5xpDE5jMg-1
Received: by mail-pf1-f197.google.com with SMTP id u3-20020a056a00124300b0056d4ab0c7cbso2908929pfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN6wTTa506SkxCujAOyPtXwdqOBElP2lQFtFf0Vat6I=;
        b=oSJuxkpDMMuo9YnMEASmZSKXeWg4pBBFRs1EvmKGaMST9pvXOYvzipi6d7i2LfyCJt
         LpZaCNp8AvPlY4UWc8s9Kch3cNTeDw81ujFgRtOCz/rDLrD4WfxAkkN7r4marUw9xcPB
         7wrVDYNG6XmgPvqvAWnhYU6cxZhrbqXi1bY1GpxRwPhKA7ufuvMlY5TXHa7ysU4ovY0G
         BIhk6Qz8nglDW8nAENnqU+5aHl7GsZUHO98kwTYGbEXhcFP02XgWWJYUuM8NUWPo7bIX
         Ytpi+I78ncmYjVipgdpD6CLCaLSkWyD8gUURiiu0xe31dHUehtGZvvks0ilZTyrqV46s
         h2IQ==
X-Gm-Message-State: ANoB5pnIsISCTQCbOd6HDqbBBfjjo76YzWGBKKE4h6he8TO9BBQTIzOv
        NkIOz9VFejlEhLXLZC+DyW/GK7O0yK0gF1YQzzAlMwiKP8qE4d6q/0XrI8uHYo8tx8OCmealqAg
        tZgDpnOcReA+R/+3BJGhWGazuiowaF2FDCHKUpZvx
X-Received: by 2002:aa7:8813:0:b0:56b:f64b:b385 with SMTP id c19-20020aa78813000000b0056bf64bb385mr3113704pfo.68.1668181269570;
        Fri, 11 Nov 2022 07:41:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5/Ztr9o/kP4Ss2zsVaXZHukHwd2KWXub+hNuBAJl7E4TaWIK4ZrWUCEAj4wp0DzhTTEkf6a+n8ohFql/DY7JQ=
X-Received: by 2002:aa7:8813:0:b0:56b:f64b:b385 with SMTP id
 c19-20020aa78813000000b0056bf64bb385mr3113688pfo.68.1668181269320; Fri, 11
 Nov 2022 07:41:09 -0800 (PST)
MIME-Version: 1.0
References: <20221110141335.62171-1-sgarzare@redhat.com>
In-Reply-To: <20221110141335.62171-1-sgarzare@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 11 Nov 2022 16:40:33 +0100
Message-ID: <CAJaqyWdvdy2QxuuyPRtfBKtuObrMg_kX_R9hdui+Oh72XtJ7Qw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: fix vringh initialization in vdpasim_queue_ready()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
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

On Thu, Nov 10, 2022 at 3:13 PM Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
>
> When we initialize vringh, we should pass the features and the
> number of elements in the virtqueue negotiated with the driver,
> otherwise operations with vringh may fail.
>
> This was discovered in a case where the driver sets a number of
> elements in the virtqueue different from the value returned by
> .get_vq_num_max().
>
> In vdpasim_vq_reset() is safe to initialize the vringh with
> default values, since the virtqueue will not be used until
> vdpasim_queue_ready() is called again.
>
> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index b071f0d842fb..b20689f8fe89 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -67,8 +67,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim=
, unsigned int idx)
>  {
>         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
>
> -       vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_feature=
s,
> -                         VDPASIM_QUEUE_MAX, false,
> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>                           (struct vring_avail *)
>                           (uintptr_t)vq->driver_addr,
> --
> 2.38.1
>

I think this is definitely an improvement, but I'd say we should go a
step further and rename VDPASIM_QUEUE_MAX to VDPASIM_QUEUE_DEFAULT. As
you point out in the patch message it is not a max anymore.

Another thing to note is that we don't have a way to report that
userspace indicated a bad value for queue length. With the current
code vringh will not initialize at all if I'm not wrong, so we should
prevent userspace to put a bad num.

Ideally, we should repeat the tests of vring_init_kern at
vdpasim_set_vq_num. We could either call it with NULL vring addresses
to check for -EINVAL, or simply repeat the conditional (!num || num >
0xffff || (num & (num - 1))). I'd say the first one is better to not
go out of sync.

All of that can be done on top anyway, so for this patch:

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

