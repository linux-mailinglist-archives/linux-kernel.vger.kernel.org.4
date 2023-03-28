Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F006CB4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjC1DlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC1DlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7DA171E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679974813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oNVJgmEkoTZopYZga5Cz0iNJK6GM/Hw/6UWakhxQAvA=;
        b=UralZ/nqV3pNgA+x3DXucOrdhkKkab/Cj9VR6rmkhmyDx3/lVByujyNggskPOduk0eLhkE
        Lz+OSEJXcQEkKz2chvOR0SRKPfnnXbHt9Q4LIQK6MJX7c9l7Jhi/UvgOpQ++nupOtbtDpB
        Y2YBrmsf1V91A4FIJ/pig/UExmQO+fo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-12qt0k4zMfKdc2-xSoA17g-1; Mon, 27 Mar 2023 23:40:11 -0400
X-MC-Unique: 12qt0k4zMfKdc2-xSoA17g-1
Received: by mail-ot1-f71.google.com with SMTP id n30-20020a9d711e000000b006a11baeb49bso3701154otj.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679974810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNVJgmEkoTZopYZga5Cz0iNJK6GM/Hw/6UWakhxQAvA=;
        b=w3DVjaYugaljPcHA4wHdz6/sWfmX9t2Cacd3dxC8RQEj843nvm+EOVVkiCfycXfHIb
         KO+4/UPwJH8yF1nLrXsMLpuJahNAGD0Z5mODI/mM+1c9DLFcFK3o6QE/gYzIzFjNzaAZ
         9Yvh+TLTzUajPF5hJTfXv6Wub0mqdrv0Xs8lO4sy8mJiriCFLzpFCgDwnAqOE+WL58rb
         Sc8i17C0FGW+8TMa5gTdfyIepvkEQDZupj+XJhTZLN7Uc6aH9EGYJ5lA9rUIRArUy6gQ
         YcI4Klrz2Wb1Yxev1NuvE9opWl08OYQuChDSX0ixmwwj78KaTCFZPd56gd1ID9SWCTbm
         PPKA==
X-Gm-Message-State: AO0yUKWwumWE9mr1PZVyZPVILCuXL0wBmun/0rOK0ki56k10ETts+o70
        n9V3K5MS3Xng2ik0oqiZBWVTFPhyP6QMkE62ARNZ0nKvsQtAoYqNOl7o98BSS+BCaLJyVsQ2ZXh
        JEI/KuVUYhPBB5XQd/YcbhzDwS9mb8UiDoXqKFi06
X-Received: by 2002:a9d:6a5a:0:b0:69f:573:6113 with SMTP id h26-20020a9d6a5a000000b0069f05736113mr4509640otn.2.1679974810403;
        Mon, 27 Mar 2023 20:40:10 -0700 (PDT)
X-Google-Smtp-Source: AK7set+MVnEOYlzBRfKqBIlq0GCdw2BBCIIM/kcfb7CoJT4ApMpLrxCI39WXcqVOMZgKgObiNwyXFFmdGQe/YKXtEQY=
X-Received: by 2002:a9d:6a5a:0:b0:69f:573:6113 with SMTP id
 h26-20020a9d6a5a000000b0069f05736113mr4509638otn.2.1679974810136; Mon, 27 Mar
 2023 20:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org> <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
 <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com>
In-Reply-To: <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 28 Mar 2023 11:39:59 +0800
Message-ID: <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
Subject: Re: [External] Re: 9p regression (Was: [PATCH v2] virtio_ring: don't
 update event idx on get_buf)
To:     =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
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

On Tue, Mar 28, 2023 at 11:09=E2=80=AFAM =E9=BB=84=E6=9D=B0 <huangjie.alber=
t@bytedance.com> wrote:
>
> Jason Wang <jasowang@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=8C 10:59=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Mar 28, 2023 at 10:13=E2=80=AFAM Dominique Martinet
> > <asmadeus@codewreck.org> wrote:
> > >
> > > Hi Michael, Albert,
> > >
> > > Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> > > > in virtio_net, if we disable the napi_tx, when we triger a tx inter=
rupt,
> > > > the vq->event_triggered will be set to true. It will no longer be s=
et to
> > > > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > > > virtqueue_enable_cb_prepare.
> > >
> > > This patch (commited as 35395770f803 ("virtio_ring: don't update even=
t
> > > idx on get_buf") in next-20230327 apparently breaks 9p, as reported b=
y
> > > Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infradead=
.org
> > >
> > > I've just hit had a look at recent patches[1] and reverted this to te=
st
> > > and I can mount again, so I'm pretty sure this is the culprit, but I
> > > didn't look at the content at all yet so cannot advise further.
> > > It might very well be that we need some extra handling for 9p
> > > specifically that can be added separately if required.
> > >
> > > [1] git log 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35..HEAD drivers/vi=
rtio/
> > >
> > >
> > > This can be reproduced with a simple mount, run qemu with some -virtf=
s
> > > argument and `mount -t 9p -o debug=3D65535 tag mountpoint` will hang =
after
> > > these messages:
> > > 9pnet: -- p9_virtio_request (83): 9p debug: virtio request
> > > 9pnet: -- p9_virtio_request (83): virtio request kicked
> > >
> > > So I suspect we're just not getting a callback.
> >
> > I think so. The patch assumes the driver will call
> > virtqueue_disable/enable_cb() which is not the case of the 9p driver.
> >
> > So after the first interrupt, event_triggered will be set to true forev=
er.
> >
> > Thanks
> >
>
> Hi: Wang
>
> Yes,  This patch assumes that all virtio-related drivers will call
> virtqueue_disable/enable_cb().
> Thank you for raising this issue.
>
> It seems that napi_tx is only related to virtue_net. I'm thinking if
> we need to refactor
> napi_tx instead of implementing it inside virtio_ring.

We can hear from others.

I think it's better not to workaround virtio_ring issues in a specific
driver. It might just add more hacks. We should correctly set
VRING_AVAIL_F_NO_INTERRUPT,

Do you think the following might work (not even a compile test)?

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 41144b5246a8..12f4efb6dc54 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -852,16 +852,16 @@ static void virtqueue_disable_cb_split(struct
virtqueue *_vq)
 {
        struct vring_virtqueue *vq =3D to_vvq(_vq);

-       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
-               vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERRUP=
T;
-               if (vq->event)
-                       /* TODO: this is a hack. Figure out a cleaner
value to write. */
-                       vring_used_event(&vq->split.vring) =3D 0x0;
-               else
-                       vq->split.vring.avail->flags =3D
-                               cpu_to_virtio16(_vq->vdev,
-                                               vq->split.avail_flags_shado=
w);
-       }
+       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
+               vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERRUP=
T;
+
+       if (vq->event && !vq->event_triggered)
+               /* TODO: this is a hack. Figure out a cleaner value to writ=
e. */
+               vring_used_event(&vq->split.vring) =3D 0x0;
+       else
+               vq->split.vring.avail->flags =3D
+                       cpu_to_virtio16(_vq->vdev,
+                                       vq->split.avail_flags_shadow);
 }

 static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_v=
q)
@@ -1697,8 +1697,10 @@ static void virtqueue_disable_cb_packed(struct
virtqueue *_vq)
 {
        struct vring_virtqueue *vq =3D to_vvq(_vq);

-       if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLAG_DISA=
BLE) {
+       if (!(vq->packed.event_flags_shadow & VRING_PACKED_EVENT_FLAG_DISAB=
LE))
                vq->packed.event_flags_shadow =3D VRING_PACKED_EVENT_FLAG_D=
ISABLE;
+
+       if (vq->event_triggered)
                vq->packed.vring.driver->flags =3D
                        cpu_to_le16(vq->packed.event_flags_shadow);
        }
@@ -2330,12 +2332,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
        struct vring_virtqueue *vq =3D to_vvq(_vq);

-       /* If device triggered an event already it won't trigger one again:
-        * no need to disable.
-        */
-       if (vq->event_triggered)
-               return;
-
        if (vq->packed_ring)
                virtqueue_disable_cb_packed(_vq);
        else

Thanks

>
> Thanks
>
> > >
> > >
> > > I'll have a closer look after work, but any advice meanwhile will be
> > > appreciated!
> > > (I'm sure Luis would also like a temporary drop from -next until
> > > this is figured out, but I'll leave this up to you)
> > >
> > >
> > > >
> > > > If we disable the napi_tx, it will only be called when the tx ring
> > > > buffer is relatively small.
> > > >
> > > > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERR=
UPT or
> > > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_=
wrap
> > > > every time we call virtqueue_get_buf_ctx. This will bring more inte=
rruptions.
> > > >
> > > > To summarize:
> > > > 1) event_triggered was set to true in vring_interrupt()
> > > > 2) after this nothing will happen for virtqueue_disable_cb() so
> > > >    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > > > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> > > >    then it tries to publish new event
> > > >
> > > > To fix, if event_triggered is set to true, do not update
> > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_=
wrap
> > > >
> > > > Tested with iperf:
> > > > iperf3 tcp stream:
> > > > vm1 -----------------> vm2
> > > > vm2 just receives tcp data stream from vm1, and sends the ack to vm=
1,
> > > > there are many tx interrupts in vm2.
> > > > but without event_triggered there are just a few tx interrupts.
> > > >
> > > > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index cbeeea1b0439..1c36fa477966 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(struct=
 virtqueue *_vq,
> > > >       /* If we expect an interrupt for the next entry, tell host
> > > >        * by writing event index and flush out the write before
> > > >        * the read in the next get_buf call. */
> > > > -     if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRU=
PT))
> > > > +     if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F_N=
O_INTERRUPT) &&
> > > > +                  !vq->event_triggered))
> > > >               virtio_store_mb(vq->weak_barriers,
> > > >                               &vring_used_event(&vq->split.vring),
> > > >                               cpu_to_virtio16(_vq->vdev, vq->last_u=
sed_idx));
> > > > @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(str=
uct virtqueue *_vq,
> > > >        * by writing event index and flush out the write before
> > > >        * the read in the next get_buf call.
> > > >        */
> > > > -     if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_F=
LAG_DESC)
> > > > +     if (unlikely(vq->packed.event_flags_shadow =3D=3D VRING_PACKE=
D_EVENT_FLAG_DESC &&
> > > > +                  !vq->event_triggered))
> > > >               virtio_store_mb(vq->weak_barriers,
> > > >                               &vq->packed.vring.driver->off_wrap,
> > > >                               cpu_to_le16(vq->last_used_idx));
> > >
> >
>

