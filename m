Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DDB67E9DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjA0PpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjA0Pot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:44:49 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC3183958
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:44:30 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-142b72a728fso6900207fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L5WWz9fhXxpXg6EmN48bNkcnM7o/dG+N+CVzIWey7Ow=;
        b=kB3eWzbBuevretKVLNQIc6LnDaUJHg5dX47XzvPpviB+kLJMTkhi9hl2bFF0hxzGc3
         1bmSwTNoKR8A+Z6O5ncrKR7CxOx7fXA75d3uTgdaCsreaoy//RN8rK0DyYDVGqmY6LLt
         2y/4h4bK8kJRWJYGcCig26s7uh0mZE/pdqy0ewstsusrnvnbrfiBYZr8IMxGJEMdYHzc
         M8lj0oIw3aH87LgaDDhE600YKPSJuZ3DWbAOKOMnNgnxlvpgh3tA7/4TZlDV8iWk7HAB
         +x6U3xQnbA/mApF+QruzLba0Dk/H/cWlrGCJ3tWceCwlFNM/X6mKz9KmRccQb5RxqJQo
         i47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5WWz9fhXxpXg6EmN48bNkcnM7o/dG+N+CVzIWey7Ow=;
        b=EWr8Mm7aA6sIcMEv5UYNOSfA5QGus4FQSasVOA+FDr8PZrlJUFbx3+UR4PZb6TNSg8
         4r+Cb9Jp7gVPC27VNaoLDpibt+RpEfbj22mkPI9DNK1KIn1LTFdjJyQ5JDBwRfQRwcAF
         qEK8moRpsxJyL648aM+b4NztSEBXwlfS55Xse2Z982sgX+KgIVMSmYml4XIdNePEcHHR
         L7pIhTQ+7NYgIe8J8NUNF6Ws/0ga/eVnz6PzQB89YtFPGECAFGeJg0F5OEAunfBA54+j
         WTluZzJBse21l5jxn5/6idrZ/BCeGguST3UgzcAFGWOz8V2s6BFxcXPPcfYVCwsuBfvU
         ACYg==
X-Gm-Message-State: AFqh2kqvfByhqwygLMW7SdXjCOf+YFP0ddm519jSvfaHpOmIy8EyzvwS
        kc1FFjU3TeZjRFsCaEPrbRX7eQaV76o0lgeBL10=
X-Google-Smtp-Source: AMrXdXup/oiP7Q12YFafrFfdB69dMqfoWyegvyVl2UR664bFNRQnR7IiR+R5erW+114UUEr4FAe2K42dz+pOGsd06QE=
X-Received: by 2002:a05:6870:44d0:b0:15b:96b8:e2be with SMTP id
 t16-20020a05687044d000b0015b96b8e2bemr2505559oai.38.1674834269272; Fri, 27
 Jan 2023 07:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20230126225815.1518839-1-ryanneph@chromium.org>
In-Reply-To: <20230126225815.1518839-1-ryanneph@chromium.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 27 Jan 2023 07:44:17 -0800
Message-ID: <CAF6AEGtQ1nsHZtigJs4ABe=3ibqbWJgWXzfPjypBcQZ8vgZekg@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: exbuf->fence_fd unmodified on interrupted wait
To:     Ryan Neph <ryanneph@chromium.org>
Cc:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Robert Foss <robert.foss@collabora.com>,
        Yiwei Zhang <zzyiwei@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:31 AM Ryan Neph <ryanneph@chromium.org> wrote:
>
> An interrupted dma_fence_wait() becomes an -ERESTARTSYS returned
> to userspace ioctl(DRM_IOCTL_VIRTGPU_EXECBUFFER) calls, prompting to
> retry the ioctl(), but the passed exbuf->fence_fd has been reset to -1,
> making the retry attempt fail at sync_file_get_fence().
>
> The uapi for DRM_IOCTL_VIRTGPU_EXECBUFFER is changed to retain the
> passed value for exbuf->fence_fd when returning ERESTARTSYS or EINTR.
>
> Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
> Signed-off-by: Ryan Neph <ryanneph@chromium.org>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 9 ++++++---
>  include/uapi/drm/virtgpu_drm.h         | 3 +++
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 9f4a90493aea..ffce4e2a409a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -132,6 +132,8 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         uint64_t fence_ctx;
>         uint32_t ring_idx;
>
> +       exbuf->fence_fd = -1;
> +
>         fence_ctx = vgdev->fence_drv.context;
>         ring_idx = 0;
>
> @@ -152,8 +154,6 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                 ring_idx = exbuf->ring_idx;
>         }
>
> -       exbuf->fence_fd = -1;
> -
>         virtio_gpu_create_context(dev, file);
>         if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
>                 struct dma_fence *in_fence;
> @@ -173,7 +173,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>
>                 dma_fence_put(in_fence);
>                 if (ret)
> -                       return ret;
> +                       goto out_err;
>         }
>
>         if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
> @@ -259,6 +259,9 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>
>         if (out_fence_fd >= 0)
>                 put_unused_fd(out_fence_fd);
> +out_err:
> +       if (ret == -EINTR || ret == -ERESTARTSYS)
> +               exbuf->fence_fd = in_fence_fd;
>
>         return ret;
>  }
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 0512fde5e697..ac8d1eed12ab 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -64,6 +64,9 @@ struct drm_virtgpu_map {
>         __u32 pad;
>  };
>
> +/* For ioctl() returning ERESTARTSYS or EINTR, fence_fd is unmodified.
> + * For all other errors it is set to -1.
> + */
>  struct drm_virtgpu_execbuffer {
>         __u32 flags;
>         __u32 size;
> --
> 2.39.1.456.gfc5497dd1b-goog
>
