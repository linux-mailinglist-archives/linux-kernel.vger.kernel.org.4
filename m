Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B0C6CB489
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjC1DJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjC1DJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:09:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3662128
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:09:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h11so7049222lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679972956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wFMI7wyzON7qQEKzyS0NRyT4cs3j+7YyQRzdMmYse8=;
        b=eCcsmc50QWKG8stkOYjl2OgehhyIcadK09DQQ7V+5BEUmTHk/Bg06AYQwiv9aeOroZ
         iid2HJuVO5f0xpeCaMYqxgb/zjMOUnJeRiF8zTzAEvGnzI2CZifNyXx9LA4QPBlhxhQa
         8cLhNpI5NQOxHfrN7eQSJGsvV5sGNUB8xLozhLli/gadNfdmWbCzfBLNhNIAEOHA6Ndk
         g++qVX4T1OIB1ZALlwCVb4R+G+TjkgwNWtxTa5pVRy9rH2+JSBpGiCjFx/VTa7XYBVFH
         7pRBQNZEB83XLYkf1egxJ2gg4k6vtwi135rs0iKG2jvKMYoEi6f5nTYHc3Q9oC43kB0P
         JQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679972956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wFMI7wyzON7qQEKzyS0NRyT4cs3j+7YyQRzdMmYse8=;
        b=chx2DZGyEroPY9Y8HmpJjaU7HCuTzhRmz0fzAwuopB4r92+r2D0+3AhcH1K4nnRhnN
         zqq43sLlM6lAKQerOw8mZwW0oCQti8PLCYkZ3Xolwk1vbL/Jro2OI0F7JmOz05Y1J5aH
         4zzfiHIandcLutM6sw0Ow9utrTKljM30fTJJyOYtzXwQMx5B3IbeQvhaQK/yy+8Sj3pU
         /y2i2/U3/56WW+22gVenT1LBb+8o/de7MHusS/f8dwpH0t5wuxGE6mOdWvh/BgTTZJRu
         cIeCSs87ESlJ5JIn8zPnHXXMH363kvkEXhcN15BxHMF/y1wbc7YHRPw5wBqMbUSHwzJY
         QvMg==
X-Gm-Message-State: AO0yUKVYjIWGtKzSBnGowPsIIop5r/4ChIY25dkQXF3QT+pC6A/V/04r
        60qW6xyhgnwgJFNn4YrqzsxQ6RNu+hc43zhj6AZaUw==
X-Google-Smtp-Source: AK7set+nSXDFj/ni8SPspFk0PDp6/pK7vWqo6D8JhfKupKqCJgdk0C/cT34nyndDPBnKZqpg9eqMz/66FwOPzo1feJ0=
X-Received: by 2002:a05:6512:b8a:b0:4e8:4409:bb76 with SMTP id
 b10-20020a0565120b8a00b004e84409bb76mr11090446lfv.2.1679972955902; Mon, 27
 Mar 2023 20:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org> <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
In-Reply-To: <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Tue, 28 Mar 2023 11:09:04 +0800
Message-ID: <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com>
Subject: Re: [External] Re: 9p regression (Was: [PATCH v2] virtio_ring: don't
 update event idx on get_buf)
To:     Jason Wang <jasowang@redhat.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Wang <jasowang@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=8C 10:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Mar 28, 2023 at 10:13=E2=80=AFAM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> >
> > Hi Michael, Albert,
> >
> > Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> > > in virtio_net, if we disable the napi_tx, when we triger a tx interru=
pt,
> > > the vq->event_triggered will be set to true. It will no longer be set=
 to
> > > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > > virtqueue_enable_cb_prepare.
> >
> > This patch (commited as 35395770f803 ("virtio_ring: don't update event
> > idx on get_buf") in next-20230327 apparently breaks 9p, as reported by
> > Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infradead.o=
rg
> >
> > I've just hit had a look at recent patches[1] and reverted this to test
> > and I can mount again, so I'm pretty sure this is the culprit, but I
> > didn't look at the content at all yet so cannot advise further.
> > It might very well be that we need some extra handling for 9p
> > specifically that can be added separately if required.
> >
> > [1] git log 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35..HEAD drivers/virt=
io/
> >
> >
> > This can be reproduced with a simple mount, run qemu with some -virtfs
> > argument and `mount -t 9p -o debug=3D65535 tag mountpoint` will hang af=
ter
> > these messages:
> > 9pnet: -- p9_virtio_request (83): 9p debug: virtio request
> > 9pnet: -- p9_virtio_request (83): virtio request kicked
> >
> > So I suspect we're just not getting a callback.
>
> I think so. The patch assumes the driver will call
> virtqueue_disable/enable_cb() which is not the case of the 9p driver.
>
> So after the first interrupt, event_triggered will be set to true forever=
.
>
> Thanks
>

Hi: Wang

Yes,  This patch assumes that all virtio-related drivers will call
virtqueue_disable/enable_cb().
Thank you for raising this issue.

It seems that napi_tx is only related to virtue_net. I'm thinking if
we need to refactor
napi_tx instead of implementing it inside virtio_ring.

Thanks

> >
> >
> > I'll have a closer look after work, but any advice meanwhile will be
> > appreciated!
> > (I'm sure Luis would also like a temporary drop from -next until
> > this is figured out, but I'll leave this up to you)
> >
> >
> > >
> > > If we disable the napi_tx, it will only be called when the tx ring
> > > buffer is relatively small.
> > >
> > > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUP=
T or
> > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wr=
ap
> > > every time we call virtqueue_get_buf_ctx. This will bring more interr=
uptions.
> > >
> > > To summarize:
> > > 1) event_triggered was set to true in vring_interrupt()
> > > 2) after this nothing will happen for virtqueue_disable_cb() so
> > >    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> > >    then it tries to publish new event
> > >
> > > To fix, if event_triggered is set to true, do not update
> > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wr=
ap
> > >
> > > Tested with iperf:
> > > iperf3 tcp stream:
> > > vm1 -----------------> vm2
> > > vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> > > there are many tx interrupts in vm2.
> > > but without event_triggered there are just a few tx interrupts.
> > >
> > > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index cbeeea1b0439..1c36fa477966 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(struct v=
irtqueue *_vq,
> > >       /* If we expect an interrupt for the next entry, tell host
> > >        * by writing event index and flush out the write before
> > >        * the read in the next get_buf call. */
> > > -     if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT=
))
> > > +     if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_=
INTERRUPT) &&
> > > +                  !vq->event_triggered))
> > >               virtio_store_mb(vq->weak_barriers,
> > >                               &vring_used_event(&vq->split.vring),
> > >                               cpu_to_virtio16(_vq->vdev, vq->last_use=
d_idx));
> > > @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(struc=
t virtqueue *_vq,
> > >        * by writing event index and flush out the write before
> > >        * the read in the next get_buf call.
> > >        */
> > > -     if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLA=
G_DESC)
> > > +     if (unlikely(vq->packed.event_flags_shadow =3D=3D VRING_PACKED_=
EVENT_FLAG_DESC &&
> > > +                  !vq->event_triggered))
> > >               virtio_store_mb(vq->weak_barriers,
> > >                               &vq->packed.vring.driver->off_wrap,
> > >                               cpu_to_le16(vq->last_used_idx));
> >
>
