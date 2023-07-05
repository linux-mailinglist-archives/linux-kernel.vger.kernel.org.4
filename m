Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F29748273
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjGEKqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjGEKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:46:00 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5F41721
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:45:54 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-765a1690003so563632185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688553953; x=1691145953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0D89LSkcvAIIcFxHzr4Q4hrd+iA/eWl5uaTIZwxshro=;
        b=j87jeYkXCzOnpUE7rJuG/F6GfxkuGK+ux9+JdahAUmPI0V6DGYxwhVSHMogPXaLsqR
         KXzeNz781sWhuDrzSAfc10x8QLjKRKtzYVAHOatUqvoK/jaH2doUF/fqg0pVcZLHpIPR
         /jxn+/DPKsouBLLtYKy1VoGjbVVPi55+JBBYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688553953; x=1691145953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0D89LSkcvAIIcFxHzr4Q4hrd+iA/eWl5uaTIZwxshro=;
        b=FCCkhmDPVwK4x5Iz5mGliDEgsKajQVBgdsICuHNhxOhU9Kr1U4pzHp0K9prxNmYCxN
         ocEOwCjVjEEVwRiYvPW2eD1BgX2VR3XDgcOZ0jSWt7mQwzfESmmRFono2mT3/AA/uqWD
         RyKM85iOmLmCzLafj/2bijBKDuM5P2yakumjo/sKlTFuEPS1yapLChTflel92ZrhT+Kl
         V5x49RfADOCKcEcYiU1TQfnPAhaLl5DO0x9K0WwgVW3YUSJjScdb+qStFWru4Y3zky57
         mnWuLL/Dt8DKa1gckFw3eSG8NfArqf5eiXnrc8YVRXGGr1zvZ/3kYz9uI1O2HF1vVIek
         lR4w==
X-Gm-Message-State: AC+VfDyGQ0cHYdBZbRlYk8tOp7msUHX3lg3Z73tlSi2icRUl0taljj1Q
        WA/cep4O8GcJ1h2VQVjHf1cd4YICS4Ue9HBmgPxfTg==
X-Google-Smtp-Source: ACHHUZ5QG6qV8j0K1NMZ4KRshq6wxf2VdRRRWDv0Fcgo12b4rckoETfjcVCX+gZFZ3HiM0tr5Xlidg==
X-Received: by 2002:a05:620a:3711:b0:765:40da:4444 with SMTP id de17-20020a05620a371100b0076540da4444mr19493818qkb.10.1688553953486;
        Wed, 05 Jul 2023 03:45:53 -0700 (PDT)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id c24-20020ae9e218000000b0076227222e49sm9267576qkc.6.2023.07.05.03.45.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 03:45:52 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-635e372679bso42533636d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:45:52 -0700 (PDT)
X-Received: by 2002:a05:6214:62d:b0:635:e2c1:99e9 with SMTP id
 a13-20020a056214062d00b00635e2c199e9mr11244711qvx.17.1688553952010; Wed, 05
 Jul 2023 03:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210302004624.31294-1-senozhatsky@chromium.org>
 <20210302004624.31294-9-senozhatsky@chromium.org> <08fa86bf-b4bf-408a-89f6-a0ebc222b253@synaptics.com>
In-Reply-To: <08fa86bf-b4bf-408a-89f6-a0ebc222b253@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 5 Jul 2023 19:45:41 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AW8ue4haSn9=yi7gSA6bw2pUtPFVSLpkZXrRu1HFZwsA@mail.gmail.com>
Message-ID: <CAAFQd5AW8ue4haSn9=yi7gSA6bw2pUtPFVSLpkZXrRu1HFZwsA@mail.gmail.com>
Subject: Re: [PATCH 8/8] videobuf2: handle non-contiguous DMA allocations
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 7:51=E2=80=AFPM Hsia-Jun Li <Randy.Li@synaptics.com>=
 wrote:
>
> Hello Sergey
>
> I known this patch have been merged for a long time. I am thinking
> whether we need this flag in the new v4l2_ext_buffer.
>
> On 3/2/21 08:46, Sergey Senozhatsky wrote:
> > This adds support for new noncontiguous DMA API, which
> > requires allocators to have two execution branches: one
> > for the current API, and one for the new one.
>
> There is no way we could allocate a coherent buffer in the platform
> except the x86.
>

The flag is for requesting the kernel to try allocating *non*-coherent
buffers if possible. If the flag is not given, it's up to the kernel
to choose the right mapping type, which for vb2-dma-contig is
coherent. For compatibility reasons, we need the user space to pass
the flag to change the allocation behavior to avoid UAPI breakages.

I don't get what you mean that there is no way to allocate a coherent
buffer on a platform other than x86. Most of the platforms implement
dma_alloc_coherent() by remapping the allocated memory in
uncached/write-combine mode. x86 is an exception because it usually
has the DMAs coherent with the CPU caches and no special handling is
necessary, so dma_alloc_coherent() is just a simple pass-through
allocator.

> Should we make this flag a platform compiling time fixed value?

This is not a platform-specific flag. There are use cases which
perform better with coherent buffers (i.e. when there is no CPU access
happening to the buffers or just a linear memcpy) and some perform
better when the mapping is non-coherent (i.e. non-linear access from
the CPU, e.g. a software video encoder).

>
> And I didn't see Gstreamer nor FFmpeg uses it, it is obvious that they
> are running in many(almost all) embedded devices which are ARM.
>

It's likely that those generic frameworks don't have any specific
advanced use cases which would benefit from the performance gains of
this flag. FWIW, ChromeOS uses it in the camera and video stack
whenever complex CPU access to the buffers is needed.

Best regards,
Tomasz

> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > [hch: untested conversion to the ne API]
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   .../common/videobuf2/videobuf2-dma-contig.c   | 141 +++++++++++++++--=
-
> >   1 file changed, 117 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/dr=
ivers/media/common/videobuf2/videobuf2-dma-contig.c
> > index 1e218bc440c6..d6a9f7b682f3 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/sched.h>
> >   #include <linux/slab.h>
> >   #include <linux/dma-mapping.h>
> > +#include <linux/highmem.h>
> >
> >   #include <media/videobuf2-v4l2.h>
> >   #include <media/videobuf2-dma-contig.h>
> > @@ -42,8 +43,14 @@ struct vb2_dc_buf {
> >       struct dma_buf_attachment       *db_attach;
> >
> >       struct vb2_buffer               *vb;
> > +     unsigned int                    non_coherent_mem:1;
> >   };
> >
> > +static bool vb2_dc_is_coherent(struct vb2_dc_buf *buf)
> > +{
> > +     return !buf->non_coherent_mem;
> > +}
> > +
> >   /*********************************************/
> >   /*        scatterlist table functions        */
> >   /*********************************************/
> > @@ -78,12 +85,21 @@ static void *vb2_dc_cookie(struct vb2_buffer *vb, v=
oid *buf_priv)
> >   static void *vb2_dc_vaddr(struct vb2_buffer *vb, void *buf_priv)
> >   {
> >       struct vb2_dc_buf *buf =3D buf_priv;
> > -     struct dma_buf_map map;
> > -     int ret;
> >
> > -     if (!buf->vaddr && buf->db_attach) {
> > -             ret =3D dma_buf_vmap(buf->db_attach->dmabuf, &map);
> > -             buf->vaddr =3D ret ? NULL : map.vaddr;
> > +     if (buf->vaddr)
> > +             return buf->vaddr;
> > +
> > +     if (buf->db_attach) {
> > +             struct dma_buf_map map;
> > +
> > +             if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
> > +                     buf->vaddr =3D map.vaddr;
> > +     }
> > +
> > +     if (!vb2_dc_is_coherent(buf)) {
> > +             buf->vaddr =3D dma_vmap_noncontiguous(buf->dev,
> > +                                                 buf->size,
> > +                                                 buf->dma_sgt);
> >       }
> >
> >       return buf->vaddr;
> > @@ -101,13 +117,26 @@ static void vb2_dc_prepare(void *buf_priv)
> >       struct vb2_dc_buf *buf =3D buf_priv;
> >       struct sg_table *sgt =3D buf->dma_sgt;
> >
> > +     /* This takes care of DMABUF and user-enforced cache sync hint */
> >       if (buf->vb->skip_cache_sync_on_prepare)
> >               return;
> >
> > +     /*
> > +      * Coherent MMAP buffers do not need to be synced, unlike coheren=
t
> > +      * USERPTR and non-coherent MMAP buffers.
> > +      */
> > +     if (buf->vb->memory =3D=3D V4L2_MEMORY_MMAP && vb2_dc_is_coherent=
(buf))
> > +             return;
> > +
> >       if (!sgt)
> >               return;
> >
> > +     /* For both USERPTR and non-coherent MMAP */
> >       dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
> > +
> > +     /* Non-coherrent MMAP only */
> > +     if (!vb2_dc_is_coherent(buf) && buf->vaddr)
> > +             flush_kernel_vmap_range(buf->vaddr, buf->size);
> >   }
> >
> >   static void vb2_dc_finish(void *buf_priv)
> > @@ -115,19 +144,46 @@ static void vb2_dc_finish(void *buf_priv)
> >       struct vb2_dc_buf *buf =3D buf_priv;
> >       struct sg_table *sgt =3D buf->dma_sgt;
> >
> > +     /* This takes care of DMABUF and user-enforced cache sync hint */
> >       if (buf->vb->skip_cache_sync_on_finish)
> >               return;
> >
> > +     /*
> > +      * Coherent MMAP buffers do not need to be synced, unlike coheren=
t
> > +      * USERPTR and non-coherent MMAP buffers.
> > +      */
> > +     if (buf->vb->memory =3D=3D V4L2_MEMORY_MMAP && vb2_dc_is_coherent=
(buf))
> > +             return;
> > +
> >       if (!sgt)
> >               return;
> >
> > +     /* For both USERPTR and non-coherent MMAP */
> >       dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
> > +
> > +     /* Non-coherrent MMAP only */
> > +     if (!vb2_dc_is_coherent(buf) && buf->vaddr)
> > +             invalidate_kernel_vmap_range(buf->vaddr, buf->size);
> >   }
> >
> >   /*********************************************/
> >   /*        callbacks for MMAP buffers         */
> >   /*********************************************/
> >
> > +static void __vb2_dc_put(struct vb2_dc_buf *buf)
> > +{
> > +     if (vb2_dc_is_coherent(buf)) {
> > +             dma_free_attrs(buf->dev, buf->size, buf->cookie,
> > +                            buf->dma_addr, buf->attrs);
> > +             return;
> > +     }
> > +
> > +     if (buf->vaddr)
> > +             dma_vunmap_noncontiguous(buf->dev, buf->vaddr);
> > +     dma_free_noncontiguous(buf->dev, buf->size,
> > +                            buf->dma_sgt, buf->dma_addr);
> > +}
> > +
> >   static void vb2_dc_put(void *buf_priv)
> >   {
> >       struct vb2_dc_buf *buf =3D buf_priv;
> > @@ -139,17 +195,47 @@ static void vb2_dc_put(void *buf_priv)
> >               sg_free_table(buf->sgt_base);
> >               kfree(buf->sgt_base);
> >       }
> > -     dma_free_attrs(buf->dev, buf->size, buf->cookie, buf->dma_addr,
> > -                    buf->attrs);
> > +     __vb2_dc_put(buf);
> >       put_device(buf->dev);
> >       kfree(buf);
> >   }
> >
> > +static int vb2_dc_alloc_coherent(struct vb2_dc_buf *buf)
> > +{
> > +     struct vb2_queue *q =3D buf->vb->vb2_queue;
> > +
> > +     buf->cookie =3D dma_alloc_attrs(buf->dev,
> > +                                   buf->size,
> > +                                   &buf->dma_addr,
> > +                                   GFP_KERNEL | q->gfp_flags,
> > +                                   buf->attrs);
> > +     if (!buf->cookie)
> > +             return -ENOMEM;
> > +     if ((q->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING) =3D=3D 0)
> > +             buf->vaddr =3D buf->cookie;
> > +     return 0;
> > +}
> > +
> > +static int vb2_dc_alloc_non_coherent(struct vb2_dc_buf *buf)
> > +{
> > +     struct vb2_queue *q =3D buf->vb->vb2_queue;
> > +
> > +     buf->dma_sgt =3D dma_alloc_noncontiguous(buf->dev,
> > +                                            buf->size,
> > +                                            buf->dma_dir,
> > +                                            GFP_KERNEL | q->gfp_flags,
> > +                                            buf->attrs);
> > +     if (!buf->dma_sgt)
> > +             return -ENOMEM;
> > +     return 0;
> > +}
> > +
> >   static void *vb2_dc_alloc(struct vb2_buffer *vb,
> >                         struct device *dev,
> >                         unsigned long size)
> >   {
> >       struct vb2_dc_buf *buf;
> > +     int ret;
> >
> >       if (WARN_ON(!dev))
> >               return ERR_PTR(-EINVAL);
> > @@ -159,27 +245,28 @@ static void *vb2_dc_alloc(struct vb2_buffer *vb,
> >               return ERR_PTR(-ENOMEM);
> >
> >       buf->attrs =3D vb->vb2_queue->dma_attrs;
> > -     buf->cookie =3D dma_alloc_attrs(dev, size, &buf->dma_addr,
> > -                                   GFP_KERNEL | vb->vb2_queue->gfp_fla=
gs,
> > -                                   buf->attrs);
> > -     if (!buf->cookie) {
> > -             dev_err(dev, "dma_alloc_coherent of size %ld failed\n", s=
ize);
> > -             kfree(buf);
> > -             return ERR_PTR(-ENOMEM);
> > -     }
> > -
> > -     if ((buf->attrs & DMA_ATTR_NO_KERNEL_MAPPING) =3D=3D 0)
> > -             buf->vaddr =3D buf->cookie;
> > +     buf->dma_dir =3D vb->vb2_queue->dma_dir;
> > +     buf->vb =3D vb;
> > +     buf->non_coherent_mem =3D vb->vb2_queue->non_coherent_mem;
> >
> > +     buf->size =3D size;
> >       /* Prevent the device from being released while the buffer is use=
d */
> >       buf->dev =3D get_device(dev);
> > -     buf->size =3D size;
> > -     buf->dma_dir =3D vb->vb2_queue->dma_dir;
> > +
> > +     if (vb2_dc_is_coherent(buf))
> > +             ret =3D vb2_dc_alloc_coherent(buf);
> > +     else
> > +             ret =3D vb2_dc_alloc_non_coherent(buf);
> > +
> > +     if (ret) {
> > +             dev_err(dev, "dma alloc of size %ld failed\n", size);
> > +             kfree(buf);
> > +             return ERR_PTR(-ENOMEM);
> > +     }
> >
> >       buf->handler.refcount =3D &buf->refcount;
> >       buf->handler.put =3D vb2_dc_put;
> >       buf->handler.arg =3D buf;
> > -     buf->vb =3D vb;
> >
> >       refcount_set(&buf->refcount, 1);
> >
> > @@ -196,9 +283,12 @@ static int vb2_dc_mmap(void *buf_priv, struct vm_a=
rea_struct *vma)
> >               return -EINVAL;
> >       }
> >
> > -     ret =3D dma_mmap_attrs(buf->dev, vma, buf->cookie,
> > -             buf->dma_addr, buf->size, buf->attrs);
> > -
> > +     if (vb2_dc_is_coherent(buf))
> > +             ret =3D dma_mmap_attrs(buf->dev, vma, buf->cookie, buf->d=
ma_addr,
> > +                                  buf->size, buf->attrs);
> > +     else
> > +             ret =3D dma_mmap_noncontiguous(buf->dev, vma, buf->size,
> > +                                          buf->dma_sgt);
> >       if (ret) {
> >               pr_err("Remapping memory failed, error: %d\n", ret);
> >               return ret;
> > @@ -390,6 +480,9 @@ static struct sg_table *vb2_dc_get_base_sgt(struct =
vb2_dc_buf *buf)
> >       int ret;
> >       struct sg_table *sgt;
> >
> > +     if (!vb2_dc_is_coherent(buf))
> > +             return buf->dma_sgt;
> > +
> >       sgt =3D kmalloc(sizeof(*sgt), GFP_KERNEL);
> >       if (!sgt) {
> >               dev_err(buf->dev, "failed to alloc sg table\n");
>
> --
> Hsia-Jun(Randy) Li
>
