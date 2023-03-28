Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F4E6CB46D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjC1C7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjC1C7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6DA268A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679972342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVMGCykpINusC1X2o35RkpO4Jksn/8McHykOJK2uUY8=;
        b=PQ1IlJAGqrqiXhphVcw303FOFJjTA6sGlt8vMviI94qroqPDM7w8UWZHVKlgBiul+eYAxa
        /nReb5MkfEm1bRGqe8DREELLHA1qo+Eq0MF9S+CcJA5VXESakt83f0Ge67Pw4uR4VEBkS2
        EisPhMg57opuyx1yw2wdgWa6ppc8T7c=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-c0PQAr2qPyy61Fhw1fuxbg-1; Mon, 27 Mar 2023 22:59:00 -0400
X-MC-Unique: c0PQAr2qPyy61Fhw1fuxbg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-17a03f26ff8so6066494fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679972340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVMGCykpINusC1X2o35RkpO4Jksn/8McHykOJK2uUY8=;
        b=v+stw9GXza1iZqjM3n5iyMyOpc0pmlmaAXVX9aSVRA4Qk0760UQgj6hIHhZvzCAVpB
         9claJUshidY9fx/RKfCjVx4QFepNB+cW1yiuJBQYlHGSbA1+WvMYp3a67s+D+54gQPtB
         9zKYCcHVxjvLa84wJ6K1o8KbfF8HNHDHAcFCJMevN6qQceLWtXNKcpph/8z/yCd/6Lo+
         EkYN1pCtH0UTPOU7fRA7bXxxUW0k/A/i7ybvHv0Pi2sdyj8a4tj8iDbR5QZmpGomztbV
         6yuoDdNnSdg5HCsMv1e1rRQSdQ567frBTFF1jEIt+2InUqmIgpsmvIY967gU9KpHGsMz
         dH1g==
X-Gm-Message-State: AAQBX9cAHZ9I/SiiCUgzI7fksZiQH7gCnqrDb5jVDuGLBEMmxcoc70nH
        ZNrJkFd2N+EtM6fUHy5ApoOUxzeaQAXMrPPw0CqGsLy9yzr48DnGWXoznPPaIfBLJmJBrhcr6ak
        MFHL1IwF1zbBXS4nEFrLpH0pZFg2SKJLV2JAz0Sel
X-Received: by 2002:a05:6870:8310:b0:177:c2fb:8cec with SMTP id p16-20020a056870831000b00177c2fb8cecmr5393487oae.9.1679972340033;
        Mon, 27 Mar 2023 19:59:00 -0700 (PDT)
X-Google-Smtp-Source: AK7set9bmnFjMgjYohCBeL1d99Eg+sVv0sUJNJIXbQ4MkNune4yxD1oxJROTbptIQytupPC8Wk6CuoIKAAtkQZX3NQ4=
X-Received: by 2002:a05:6870:8310:b0:177:c2fb:8cec with SMTP id
 p16-20020a056870831000b00177c2fb8cecmr5393483oae.9.1679972339793; Mon, 27 Mar
 2023 19:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230325105633.58592-1-huangjie.albert@bytedance.com> <ZCJNTBQLZeyLBKKB@codewreck.org>
In-Reply-To: <ZCJNTBQLZeyLBKKB@codewreck.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 28 Mar 2023 10:58:48 +0800
Message-ID: <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
Subject: Re: 9p regression (Was: [PATCH v2] virtio_ring: don't update event
 idx on get_buf)
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:13=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Hi Michael, Albert,
>
> Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> > in virtio_net, if we disable the napi_tx, when we triger a tx interrupt=
,
> > the vq->event_triggered will be set to true. It will no longer be set t=
o
> > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > virtqueue_enable_cb_prepare.
>
> This patch (commited as 35395770f803 ("virtio_ring: don't update event
> idx on get_buf") in next-20230327 apparently breaks 9p, as reported by
> Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infradead.org
>
> I've just hit had a look at recent patches[1] and reverted this to test
> and I can mount again, so I'm pretty sure this is the culprit, but I
> didn't look at the content at all yet so cannot advise further.
> It might very well be that we need some extra handling for 9p
> specifically that can be added separately if required.
>
> [1] git log 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35..HEAD drivers/virtio=
/
>
>
> This can be reproduced with a simple mount, run qemu with some -virtfs
> argument and `mount -t 9p -o debug=3D65535 tag mountpoint` will hang afte=
r
> these messages:
> 9pnet: -- p9_virtio_request (83): 9p debug: virtio request
> 9pnet: -- p9_virtio_request (83): virtio request kicked
>
> So I suspect we're just not getting a callback.

I think so. The patch assumes the driver will call
virtqueue_disable/enable_cb() which is not the case of the 9p driver.

So after the first interrupt, event_triggered will be set to true forever.

Thanks

>
>
> I'll have a closer look after work, but any advice meanwhile will be
> appreciated!
> (I'm sure Luis would also like a temporary drop from -next until
> this is figured out, but I'll leave this up to you)
>
>
> >
> > If we disable the napi_tx, it will only be called when the tx ring
> > buffer is relatively small.
> >
> > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT =
or
> > VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > every time we call virtqueue_get_buf_ctx. This will bring more interrup=
tions.
> >
> > To summarize:
> > 1) event_triggered was set to true in vring_interrupt()
> > 2) after this nothing will happen for virtqueue_disable_cb() so
> >    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> >    then it tries to publish new event
> >
> > To fix, if event_triggered is set to true, do not update
> > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> >
> > Tested with iperf:
> > iperf3 tcp stream:
> > vm1 -----------------> vm2
> > vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> > there are many tx interrupts in vm2.
> > but without event_triggered there are just a few tx interrupts.
> >
> > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index cbeeea1b0439..1c36fa477966 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(struct vir=
tqueue *_vq,
> >       /* If we expect an interrupt for the next entry, tell host
> >        * by writing event index and flush out the write before
> >        * the read in the next get_buf call. */
> > -     if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> > +     if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_IN=
TERRUPT) &&
> > +                  !vq->event_triggered))
> >               virtio_store_mb(vq->weak_barriers,
> >                               &vring_used_event(&vq->split.vring),
> >                               cpu_to_virtio16(_vq->vdev, vq->last_used_=
idx));
> > @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(struct =
virtqueue *_vq,
> >        * by writing event index and flush out the write before
> >        * the read in the next get_buf call.
> >        */
> > -     if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLAG_=
DESC)
> > +     if (unlikely(vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EV=
ENT_FLAG_DESC &&
> > +                  !vq->event_triggered))
> >               virtio_store_mb(vq->weak_barriers,
> >                               &vq->packed.vring.driver->off_wrap,
> >                               cpu_to_le16(vq->last_used_idx));
>

