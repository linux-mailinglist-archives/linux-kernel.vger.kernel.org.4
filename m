Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6246C406D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCVChk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCVChi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F1302A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679452610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZswUpIaZmBcMPoqevve8ROOrxF8yB084rqzIQZF6EMs=;
        b=iAU6UfeEHFMWa6S+34zQ67Rx3wGHyAVDY1/m8XsFkRpRVeWGpB2hCq5iVPG2uCqr0qhCm6
        yj8cxHWgLPdPthSyhkDK15tcQ03ASMr7oPcrd1pRos8GRmJ8Tl3cMdnAqJkCHaE+6XTe8u
        986K26eRIyU2oy6Zczom95wFn9Lgt/Q=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-Z6TRU4I3OUmbJG4-XF9itA-1; Tue, 21 Mar 2023 22:36:49 -0400
X-MC-Unique: Z6TRU4I3OUmbJG4-XF9itA-1
Received: by mail-oi1-f199.google.com with SMTP id a2-20020a544e02000000b003873410ce73so407411oiy.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679452608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZswUpIaZmBcMPoqevve8ROOrxF8yB084rqzIQZF6EMs=;
        b=BPm/Q22B0EEAL+LSx2Y/P3J6Qav9Jvp22N7TaIFj2DO0S9W9eAvHj/PWOTqBnhg90G
         Zg3a8pmEWJ+BG/d25GCbzH/d631GBjBlYzrly/CF4jy7r0fErPNr1qWly5pVXorSsgha
         zg1HbRT3cdcPwhR2WW8i11jmWCmV0PIWExGh69doxrqa/xD/A3I1sOR/xwBa9XXXwWQa
         gZxogUuPoLS9pIki03cyRyw/9O7N3TlajDg9An2wqYu6qYiWM3qpJ4JbA58lMsBDQBiG
         H58ZhOZDbPs0KZy7K938GZChJy8amBI9ZbJKksVPpmuPBvCIYjcXm4EY0WO3ZtTQ1F4e
         TaHA==
X-Gm-Message-State: AO0yUKW1d1oAdjYvmD2IiZ6bovaQ8tooMUYJrqOP3aVRYUlIM7O/G7ir
        0rbPMxhGBjaHSg47IZZXDysprvCm8SARjfowhVbxNEKw9/l13y9bXSFhaagSmf+X7RTsncECQi3
        jViMTTIKaYI0FzvLyQaLWm28fD/dhpW2iKYctkQaK4y+mHYwQErtuJg==
X-Received: by 2002:a05:6808:5ca:b0:386:9bb5:a786 with SMTP id d10-20020a05680805ca00b003869bb5a786mr461808oij.9.1679452608212;
        Tue, 21 Mar 2023 19:36:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Euo9xnX2EzZK6rq+8uzOIdBXb/npOzMT77cuKFmRJ6ZuOmV/eKi1ENLGwuGb+rqnFeE8pxZI4r58Kkes5j/k=
X-Received: by 2002:a05:6808:5ca:b0:386:9bb5:a786 with SMTP id
 d10-20020a05680805ca00b003869bb5a786mr461799oij.9.1679452607976; Tue, 21 Mar
 2023 19:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
In-Reply-To: <20230321085953.24949-1-huangjie.albert@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 22 Mar 2023 10:36:36 +0800
Message-ID: <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: Suppress tx interrupt when napi_tx disable
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 5:00=E2=80=AFPM Albert Huang
<huangjie.albert@bytedance.com> wrote:
>
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
>
> fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
>
> if we disable the napi_tx. when we triger a tx interrupt, the

typo should be "trigger"

> vq->event_triggered will be set to true. It will no longer be
> set to false. Unless we explicitly call virtqueue_enable_cb_delayed
> or virtqueue_enable_cb_prepare
>
> if we disable the napi_tx, It will only be called when the tx ring
> buffer is relatively small:
> virtio_net->start_xmit:
>         if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>                 netif_stop_subqueue(dev, qnum);
>                 if (!use_napi &&
>                     unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>                         /* More just got used, free them then recheck. */
>                         free_old_xmit_skbs(sq, false);
>                         if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
>                                 netif_start_subqueue(dev, qnum);
>                                 virtqueue_disable_cb(sq->vq);
>                         }

The code example here is out of date, make sure your tree has this:

commit d71ebe8114b4bf622804b810f5e274069060a174
Author: Jason Wang <jasowang@redhat.com>
Date:   Tue Jan 17 11:47:07 2023 +0800

    virtio-net: correctly enable callback during start_xmit

>                 }
>         }
> Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx.This will bring more interruptio=
ns.

Can you please post how to test with the performance numbers?

>
> if event_triggered is set to true, do not update vring_used_event(&vq->sp=
lit.vring)
> or vq->packed.vring.driver->off_wrap
>
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> ---
>  drivers/virtio/virtio_ring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 307e139cb11d..f486cccadbeb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtq=
ueue *_vq,
>         /* If we expect an interrupt for the next entry, tell host
>          * by writing event index and flush out the write before
>          * the read in the next get_buf call. */
> -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)
> +                       && (vq->event_triggered =3D=3D false))

I'm not sure this can work, when event_triggered is true it means
we've got an interrupt, in this case if we want another interrupt for
the next entry, we should update used_event otherwise we will lose
that interrupt?

Thanks

>                 virtio_store_mb(vq->weak_barriers,
>                                 &vring_used_event(&vq->split.vring),
>                                 cpu_to_virtio16(_vq->vdev, vq->last_used_=
idx));
> @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(struct vi=
rtqueue *_vq,
>          * by writing event index and flush out the write before
>          * the read in the next get_buf call.
>          */
> -       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLAG_=
DESC)
> +       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLAG_=
DESC
> +                       && (vq->event_triggered =3D=3D false))
>                 virtio_store_mb(vq->weak_barriers,
>                                 &vq->packed.vring.driver->off_wrap,
>                                 cpu_to_le16(vq->last_used_idx));
> --
> 2.31.1
>

