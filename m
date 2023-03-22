Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE096C58C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCVV0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCVV0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:26:04 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E738A26CCC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:26:02 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id bf30so8191109oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679520362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNx7tci9A3q2MLbvJYU0qSGbT+qcXYDv3V6D8edG8zo=;
        b=JWF/P5mCephmPbkkT2wRNVUQwwX0o7bJhZT3SUpNI7Ew++Ymw3wdv4sw6MZ3P07dvq
         HJYHC3eTyoPt6o+OEB/KRe+33dnc8zxRlQw/GFQnu5KACsFhWgpRsSQm31dhH7xMcBWY
         nNgLZmeCAcB5cOKosZLRqArZfKU9Bmzo5+DaN8/XzcfB9jn1biGX8SGUjdEpu4HVGn0u
         X8vYwTdjKhbbAXowEK6WNJvWGpk3yxWouMw7dZUNHpR5w9avIUCeqkdOr9dNAtmN2QLY
         t6tRg9B8V7amQkTyrXI97XIq2IVnJ8ZXW1sC1ThbCBhzS++1BxWn2JfMYmJWWyBN5UUl
         POMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679520362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNx7tci9A3q2MLbvJYU0qSGbT+qcXYDv3V6D8edG8zo=;
        b=AAXWd1pCcha8PPwr245Htt9qYgM6FBdv8piW/mb0kytSewmR2oK5juEiE4pHo3uAdH
         DpJjxpr++9688He1T2/DULvVQiLDTiQ6JwluVGZLSNs8RdQbt9a0zEuTsfBTvYzbuH1j
         eXXegJkm4yKDgJ0FoAzDC/W7GLYie7cVWRB2xrnPCS7wwmw1CvUiwRA9L6jhu5WPwSQ3
         3Ngsq7dfFAwgTi4j/jMaoZk9FaGtrOf6i81/lrk4JSP5GH+UU0JhfhX9+R4Sb7bveET5
         gzs4liSh8O4JA5EGYTSzWyaTyctWCRXf+fMZxCiU+V70A9cwapluzWVISrKlhF1bOETc
         zBgg==
X-Gm-Message-State: AO0yUKWOMw5X3mjez1GL3BgPNWEld41tVtsyplAD7fSHZqbznkRRpSou
        HZTGVEgACNlyVoDxIUUwycDZBc7aVCT529yZln4=
X-Google-Smtp-Source: AK7set+6wUXM2HRUe8lDzkFWHS7zp5pUhPc1pkjAXSCQz8A0WujM7Y2fI3v8Eg4hNuhNJeXyM+ccnk0fW7E8hIwTkcM=
X-Received: by 2002:a54:4618:0:b0:384:1e6a:bf10 with SMTP id
 p24-20020a544618000000b003841e6abf10mr1463968oip.5.1679520361980; Wed, 22 Mar
 2023 14:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230319160802.3297643-1-dmitry.osipenko@collabora.com> <20230319160802.3297643-2-dmitry.osipenko@collabora.com>
In-Reply-To: <20230319160802.3297643-2-dmitry.osipenko@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 22 Mar 2023 14:25:51 -0700
Message-ID: <CAF6AEGu0WNgX+T2sjrA_-sgvO35wNjz39p6hc9zh02goPrkExQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/virtio: Refactor job submission code path
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 9:11=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Move virtio_gpu_execbuffer_ioctl() into separate virtgpu_submit.c file
> and refactor the code along the way to ease addition of new features to
> the ioctl.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/Makefile         |   2 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |   4 +
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 182 ---------------
>  drivers/gpu/drm/virtio/virtgpu_submit.c | 298 ++++++++++++++++++++++++
>  4 files changed, 303 insertions(+), 183 deletions(-)
>  create mode 100644 drivers/gpu/drm/virtio/virtgpu_submit.c
>

<snip all the deletes>

> diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/vi=
rtio/virtgpu_submit.c
> new file mode 100644
> index 000000000000..a96f9d3285c7
> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright (C) 2015 Red Hat, Inc.
> + * All Rights Reserved.
> + *
> + * Authors:
> + *    Dave Airlie
> + *    Alon Levy
> + */
> +
> +#include <linux/file.h>
> +#include <linux/sync_file.h>
> +#include <linux/uaccess.h>
> +
> +#include <drm/drm_file.h>
> +#include <drm/virtgpu_drm.h>
> +
> +#include "virtgpu_drv.h"
> +
> +struct virtio_gpu_submit {
> +       struct virtio_gpu_object_array *buflist;
> +       struct drm_virtgpu_execbuffer *exbuf;
> +       struct virtio_gpu_fence *out_fence;
> +       struct virtio_gpu_fpriv *vfpriv;
> +       struct virtio_gpu_device *vgdev;
> +       struct drm_file *file;
> +       uint64_t fence_ctx;
> +       uint32_t ring_idx;
> +       int out_fence_fd;
> +       void *buf;
> +};
> +
> +static int virtio_gpu_do_fence_wait(struct virtio_gpu_submit *submit,
> +                                   struct dma_fence *dma_fence)
> +{
> +       uint32_t context =3D submit->fence_ctx + submit->ring_idx;
> +
> +       if (dma_fence_match_context(dma_fence, context))
> +               return 0;
> +
> +       return dma_fence_wait(dma_fence, true);
> +}
> +
> +static int virtio_gpu_dma_fence_wait(struct virtio_gpu_submit *submit,
> +                                    struct dma_fence *fence)
> +{
> +       struct dma_fence *itr;
> +       int idx, err;
> +
> +       dma_fence_array_for_each(itr, idx, fence) {

I guess unwrapping is for the later step of host waits?

At any rate, I think you should use dma_fence_unwrap_for_each() to
handle the fence-chain case as well?

> +               err =3D virtio_gpu_do_fence_wait(submit, itr);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int virtio_gpu_fence_event_create(struct drm_device *dev,
> +                                        struct drm_file *file,
> +                                        struct virtio_gpu_fence *fence,
> +                                        uint32_t ring_idx)
> +{
> +       struct virtio_gpu_fpriv *vfpriv =3D file->driver_priv;
> +       struct virtio_gpu_fence_event *e =3D NULL;
> +       int ret;
> +
> +       if (!(vfpriv->ring_idx_mask & BIT_ULL(ring_idx)))
> +               return 0;
> +
> +       e =3D kzalloc(sizeof(*e), GFP_KERNEL);
> +       if (!e)
> +               return -ENOMEM;
> +
> +       e->event.type =3D VIRTGPU_EVENT_FENCE_SIGNALED;
> +       e->event.length =3D sizeof(e->event);
> +
> +       ret =3D drm_event_reserve_init(dev, file, &e->base, &e->event);
> +       if (ret) {
> +               kfree(e);
> +               return ret;
> +       }
> +
> +       fence->e =3D e;
> +
> +       return 0;
> +}
> +
> +static int virtio_gpu_init_submit_buflist(struct virtio_gpu_submit *subm=
it)
> +{
> +       struct drm_virtgpu_execbuffer *exbuf =3D submit->exbuf;
> +       uint32_t *bo_handles;
> +
> +       if (!exbuf->num_bo_handles)
> +               return 0;
> +
> +       bo_handles =3D kvmalloc_array(exbuf->num_bo_handles, sizeof(uint3=
2_t),
> +                                   GFP_KERNEL);
> +       if (!bo_handles)
> +               return -ENOMEM;
> +
> +       if (copy_from_user(bo_handles, u64_to_user_ptr(exbuf->bo_handles)=
,
> +                          exbuf->num_bo_handles * sizeof(uint32_t))) {
> +               kvfree(bo_handles);
> +               return -EFAULT;
> +       }
> +
> +       submit->buflist =3D virtio_gpu_array_from_handles(submit->file, b=
o_handles,
> +                                                       exbuf->num_bo_han=
dles);
> +       if (!submit->buflist) {
> +               kvfree(bo_handles);
> +               return -ENOENT;
> +       }
> +
> +       kvfree(bo_handles);
> +
> +       return 0;
> +}
> +
> +static void virtio_gpu_cleanup_submit(struct virtio_gpu_submit *submit)
> +{
> +       if (!IS_ERR(submit->buf))
> +               kvfree(submit->buf);
> +
> +       if (submit->buflist)
> +               virtio_gpu_array_put_free(submit->buflist);
> +
> +       if (submit->out_fence_fd >=3D 0)
> +               put_unused_fd(submit->out_fence_fd);
> +}
> +
> +static void virtio_gpu_submit(struct virtio_gpu_submit *submit)
> +{
> +       virtio_gpu_cmd_submit(submit->vgdev, submit->buf, submit->exbuf->=
size,
> +                             submit->vfpriv->ctx_id, submit->buflist,
> +                             submit->out_fence);
> +       virtio_gpu_notify(submit->vgdev);
> +
> +       submit->buf =3D NULL;
> +       submit->buflist =3D NULL;
> +       submit->out_fence_fd =3D -1;
> +}
> +
> +static int virtio_gpu_init_submit(struct virtio_gpu_submit *submit,
> +                                 struct drm_virtgpu_execbuffer *exbuf,
> +                                 struct drm_device *dev,
> +                                 struct drm_file *file,
> +                                 uint64_t fence_ctx, uint32_t ring_idx)
> +{
> +       struct virtio_gpu_fpriv *vfpriv =3D file->driver_priv;
> +       struct virtio_gpu_device *vgdev =3D dev->dev_private;
> +       struct virtio_gpu_fence *out_fence;
> +       int err;
> +
> +       memset(submit, 0, sizeof(*submit));
> +
> +       out_fence =3D virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
> +       if (!out_fence)
> +               return -ENOMEM;
> +
> +       err =3D virtio_gpu_fence_event_create(dev, file, out_fence, ring_=
idx);
> +       if (err) {
> +               dma_fence_put(&out_fence->f);
> +               return err;
> +       }

If we fail at any point after here, where is the out_fence referenced dropp=
ed?

> +
> +       submit->out_fence =3D out_fence;
> +       submit->fence_ctx =3D fence_ctx;
> +       submit->ring_idx =3D ring_idx;
> +       submit->out_fence_fd =3D -1;
> +       submit->vfpriv =3D vfpriv;
> +       submit->vgdev =3D vgdev;
> +       submit->exbuf =3D exbuf;
> +       submit->file =3D file;
> +
> +       err =3D virtio_gpu_init_submit_buflist(submit);
> +       if (err)
> +               return err;
> +
> +       submit->buf =3D vmemdup_user(u64_to_user_ptr(exbuf->command), exb=
uf->size);
> +       if (IS_ERR(submit->buf))
> +               return PTR_ERR(submit->buf);
> +
> +       if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
> +               err =3D get_unused_fd_flags(O_CLOEXEC);
> +               if (err < 0)
> +                       return err;
> +
> +               submit->out_fence_fd =3D err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int virtio_gpu_wait_in_fence(struct virtio_gpu_submit *submit)
> +{
> +       int ret =3D 0;
> +
> +       if (submit->exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
> +               struct dma_fence *in_fence =3D
> +                               sync_file_get_fence(submit->exbuf->fence_=
fd);
> +               if (!in_fence)
> +                       return -EINVAL;
> +
> +               /*
> +                * Wait if the fence is from a foreign context, or if the=
 fence
> +                * array contains any fence from a foreign context.
> +                */
> +               ret =3D virtio_gpu_dma_fence_wait(submit, in_fence);
> +
> +               dma_fence_put(in_fence);
> +       }
> +
> +       return ret;
> +}
> +
> +static int virtio_gpu_install_out_fence_fd(struct virtio_gpu_submit *sub=
mit)
> +{
> +       if (submit->out_fence_fd >=3D 0) {
> +               struct sync_file *sync_file =3D
> +                                       sync_file_create(&submit->out_fen=
ce->f);
> +               if (!sync_file)
> +                       return -ENOMEM;
> +
> +               submit->exbuf->fence_fd =3D submit->out_fence_fd;
> +               fd_install(submit->out_fence_fd, sync_file->file);
> +       }
> +
> +       return 0;
> +}
> +
> +static int virtio_gpu_lock_buflist(struct virtio_gpu_submit *submit)
> +{
> +       if (submit->buflist)
> +               return virtio_gpu_array_lock_resv(submit->buflist);
> +
> +       return 0;
> +}
> +
> +/*
> + * Usage of execbuffer:
> + * Relocations need to take into account the full VIRTIO_GPUDrawable siz=
e.
> + * However, the command as passed from user space must *not* contain the=
 initial
> + * VIRTIO_GPUReleaseInfo struct (first XXX bytes)
> + */

I know this is just getting moved from the old location, but I'm not
even sure what this comment means ;-)

At least it doesn't make any sense for non-virgl contexts.. I haven't
looked too closely at virgl protocol itself

BR,
-R

> +int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> +                               struct drm_file *file)
> +{
> +       struct virtio_gpu_device *vgdev =3D dev->dev_private;
> +       struct virtio_gpu_fpriv *vfpriv =3D file->driver_priv;
> +       uint64_t fence_ctx =3D vgdev->fence_drv.context;
> +       struct drm_virtgpu_execbuffer *exbuf =3D data;
> +       struct virtio_gpu_submit submit;
> +       uint32_t ring_idx =3D 0;
> +       int ret =3D -EINVAL;
> +
> +       if (vgdev->has_virgl_3d =3D=3D false)
> +               return -ENOSYS;
> +
> +       if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
> +               return ret;
> +
> +       if ((exbuf->flags & VIRTGPU_EXECBUF_RING_IDX)) {
> +               if (exbuf->ring_idx >=3D vfpriv->num_rings)
> +                       return ret;
> +
> +               if (!vfpriv->base_fence_ctx)
> +                       return ret;
> +
> +               fence_ctx =3D vfpriv->base_fence_ctx;
> +               ring_idx =3D exbuf->ring_idx;
> +       }
> +
> +       virtio_gpu_create_context(dev, file);
> +
> +       ret =3D virtio_gpu_init_submit(&submit, exbuf, dev, file,
> +                                    fence_ctx, ring_idx);
> +       if (ret)
> +               goto cleanup;
> +
> +       ret =3D virtio_gpu_wait_in_fence(&submit);
> +       if (ret)
> +               goto cleanup;
> +
> +       ret =3D virtio_gpu_install_out_fence_fd(&submit);
> +       if (ret)
> +               goto cleanup;
> +
> +       ret =3D virtio_gpu_lock_buflist(&submit);
> +       if (ret)
> +               goto cleanup;
> +
> +       virtio_gpu_submit(&submit);
> +cleanup:
> +       virtio_gpu_cleanup_submit(&submit);
> +
> +       return ret;
> +}
> --
> 2.39.2
>
