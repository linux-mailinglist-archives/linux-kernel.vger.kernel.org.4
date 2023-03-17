Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1751A6BE1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjCQG5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCQG5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:57:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16DFC4E91
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:57:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so16602755ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679036254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTAXyESsd8a33xSfPHs4lys6tsf8cQwPlYOymuXf5Dk=;
        b=iRDPK4C464u3WcyaDxmHdcZcpKYGiNs0sSOn5f0nXmtjzPHT1qEYO3HLezwzrAVKks
         9f5iUDVBIUfNe5mkU5loxZUlePqzDqyHieTSf4gwZ94Tgtij2nhHQTLHMGoPuZGCdU4n
         5/A5nYq2ViRZAxivwUyKdzyGks1ZogppyeVp2zyIAMbuppFYSYWxSHIbzdRXkHNCCekB
         Dz/Bdjy0rAmixMJfh6vYQ6elmu5SXdHGuIVFj4u+uvSDTnjkz3eb3ji2uRM30ez+bsSH
         OBay10O//+2SE08q3dNifbxL3v7Cn8NJJ5Ne4mlY6Vevq9ETQmBGIuC7ag/H12VFdz+C
         S1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679036254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTAXyESsd8a33xSfPHs4lys6tsf8cQwPlYOymuXf5Dk=;
        b=Qt+9DeVkiYCIgOf6/Q+Pm1qyoGky1M3mzKiwNdd37M3qsbywwmvaqiik3bbnZfcJKq
         GhmCq0nGCGE3ILrW7ckYnFGCYXi+aN9tagbrrKYAqUOP0VSodfEbUVZQQ79FswToe9nC
         dkdL7mHP0nKs71PajgGR6fTPslILVNlXwuxsUwFyS3R6Q4tSqA+TktellMG3wvQqsmGb
         +Ng/zcDbe3MqhvPeQmvbKAXlSjjVkQCt9PyBs0M7fzbWbxckXWDMHjc/xOj1ONjp1aWl
         vvnTZK7T0JbbMlTh2ucy33rqzkyng+2aBXWwu81eyBqxjge+FAJl4JqAlEiPoCywa4Jd
         peJw==
X-Gm-Message-State: AO0yUKVxCvqzfzpvyVqkzjlOoV7qa+nN8PD/Yb9kR1fUrxygaYOyI4w3
        gys3cNdnN+nshLUv24yS+nkqiQvmvd5T1fhYkVWFqqigz66K+5U=
X-Google-Smtp-Source: AK7set8QdF+OLdHBeIAjIMMcJC930vbyIUTzGWxQojyV/pxLBdixxzu0e6p+Hg7yTvWX+jr078ZHpNAmMtxcV0N7x24=
X-Received: by 2002:a17:907:36e:b0:877:747d:4a85 with SMTP id
 rs14-20020a170907036e00b00877747d4a85mr6862865ejb.3.1679036254328; Thu, 16
 Mar 2023 23:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230228094110.37-9-xieyongji@bytedance.com>
 <f7f30935-afc6-4864-6663-21007524a377@redhat.com>
In-Reply-To: <f7f30935-afc6-4864-6663-21007524a377@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 17 Mar 2023 14:57:23 +0800
Message-ID: <CACycT3tjAf4Rq4L0iYQZqCCZZyUf68f6FgCaym_j5BXpudZ5sw@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] vdpa: Add eventfd for the vdpa callback
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 5:26=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
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

OK, I will add more comments for it.

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

LGTM.

Thanks,
Yongji
