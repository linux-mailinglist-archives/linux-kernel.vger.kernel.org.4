Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937F86BCB34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCPJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCPJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF424BC1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678959645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZXIavcup9moQEJGr6LwMTUSPH1Mz9ROwd5wEWBmINU=;
        b=SIq9sHXv3OC40RCPwowdeCabI/XEieWENOi3Domc1FS2YShE151cjmvGNPw7WXg6gDm06Z
        0809Ql7TT2JRuWM4GLJavQDsg24/lGtVab9Q7QqYDv+Fs67C4uGqRnIlj5GDA835NsfLOV
        +kMvyeBy1hTKL3UiF/0ydQPDyOx4a2k=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-j584cUceO0iomb48NlJnIg-1; Thu, 16 Mar 2023 05:40:43 -0400
X-MC-Unique: j584cUceO0iomb48NlJnIg-1
Received: by mail-oo1-f70.google.com with SMTP id c21-20020a4a3815000000b00533f143dc81so219832ooa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678959643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZXIavcup9moQEJGr6LwMTUSPH1Mz9ROwd5wEWBmINU=;
        b=CGxMtqLYn5z6yh6UgqUgdXc0AG/pO5Sc8GZ5bUSfv83yMR80LdMbsqlVTuW4Lz7vPq
         n6cbrFdPN/RWJlZ40Isuo1mvAAMKldfJlcDnfU8ThhZLimMO9iT8vtPdaAuKYnU77eaj
         5IhuG9xtGuy5+w+tG5/gmXGoPF0/L7TUOX9WgHFc9u8FAKwAup67VXOchoT0X0Sqk8jt
         GmvUMccr/pDyX7lwRvNmOuju/TcCxgNkH6GhVi1n3lZmoKNJG7DaMORzfQ9uLwump413
         73ysdpOoL6AUX3rwIPZRy+EMtQZcJZmSMbDKo87HSUT2ejYPO92ebQet01Nja3uYeZ8i
         WROg==
X-Gm-Message-State: AO0yUKWpOUM+iQCQOKLHiNBj7kwPZUop3lv7c7EguQ20cOy0tpQ8OF73
        QVqGaiMYS0YKE/CLCNdwpUEwyGJO+tDR0fBhdcptiomVobKweScpv6BVMlA+fzS9koV0Lg3Ec3n
        e3s0XyjyFun5oN36zb3FoIZamGtrAsehziOnBiTEfVtCl23MTk9I=
X-Received: by 2002:a9d:16e:0:b0:69d:23ff:3316 with SMTP id 101-20020a9d016e000000b0069d23ff3316mr415019otu.2.1678959642828;
        Thu, 16 Mar 2023 02:40:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set+3P629b9UC4jPBqIK+YY0u7gx3q6xj2A/iPz+xIIJzq2NeXDREDht+EkjELcwvBp5P4Z+NxdttfczVci2LSbg=
X-Received: by 2002:a9d:16e:0:b0:69d:23ff:3316 with SMTP id
 101-20020a9d016e000000b0069d23ff3316mr415018otu.2.1678959642622; Thu, 16 Mar
 2023 02:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230228094110.37-9-xieyongji@bytedance.com>
 <f7f30935-afc6-4864-6663-21007524a377@redhat.com>
In-Reply-To: <f7f30935-afc6-4864-6663-21007524a377@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 16 Mar 2023 17:40:31 +0800
Message-ID: <CACGkMEtx5EyBPdKjJdj9SrBj7fSud+QPsg8j2CYoeh+Rs0P-sg@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] vdpa: Add eventfd for the vdpa callback
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Thu, Mar 16, 2023 at 5:25=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
>
> =E5=9C=A8 2023/2/28 17:41, Xie Yongji =E5=86=99=E9=81=93:
> > Add eventfd for the vdpa callback so that user
> > can signal it directly instead of running the
> > callback. It will be used for vhost-vdpa case.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/vhost/vdpa.c         | 2 ++
> >   drivers/virtio/virtio_vdpa.c | 1 +
> >   include/linux/vdpa.h         | 3 +++
> >   3 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index dc12dbd5b43b..ae89c0ccc2bb 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -599,9 +599,11 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vd=
pa *v, unsigned int cmd,
> >               if (vq->call_ctx.ctx) {
> >                       cb.callback =3D vhost_vdpa_virtqueue_cb;
> >                       cb.private =3D vq;
> > +                     cb.irq_ctx =3D vq->call_ctx.ctx;
> >               } else {
> >                       cb.callback =3D NULL;
> >                       cb.private =3D NULL;
> > +                     cb.irq_ctx =3D NULL;
> >               }
> >               ops->set_vq_cb(vdpa, idx, &cb);
> >               vhost_vdpa_setup_vq_irq(v, idx);
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.=
c
> > index 9eee8afabda8..a5cecafbc2d1 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -195,6 +195,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, un=
signed int index,
> >       /* Setup virtqueue callback */
> >       cb.callback =3D callback ? virtio_vdpa_virtqueue_cb : NULL;
> >       cb.private =3D info;
> > +     cb.irq_ctx =3D NULL;
> >       ops->set_vq_cb(vdpa, index, &cb);
> >       ops->set_vq_num(vdpa, index, virtqueue_get_vring_size(vq));
> >
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 10bd22387276..94a7ec49583a 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -13,10 +13,13 @@
> >    * struct vdpa_calllback - vDPA callback definition.
> >    * @callback: interrupt callback function
> >    * @private: the data passed to the callback function
> > + * @irq_ctx: the eventfd for the callback, user can signal
> > + *           it directly instead of running the callback
>
>
> I'd suggest to do more tweaks to mention:
>
> 1) irq_ctx is optional
> 2) that when the irq_ctx is set, the vDPA driver must guarantee that
> signaling it is functional equivalent to triggering the callback. When
> set, vDPA parent can signal it directly instead of triggering the callbac=
k.
>
> >    */
> >   struct vdpa_callback {
> >       irqreturn_t (*callback)(void *data);
> >       void *private;
> > +     struct eventfd_ctx *irq_ctx;
>
>
> There's no IRQ concept at the virtual vDPA bus level, so it's probably
> better to rename it as "trigger".
>
> Btw, should we select EVENTFD for vDPA?

Looks like we are fine here since we only use the pointer to the eventfd_ct=
x.

Thanks

>
> Thanks
>
>
> >   };
> >
> >   /**

