Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48090686AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjBAPtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjBAPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:48:31 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97FB68133
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:48:13 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id k13so4440180iob.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0/nyhBk1uOsA1XtH9biqxBSFqS1i1uBqehOG4r1+rrk=;
        b=QAh/alzSMUbrP5wWliBdWn2kgG9OcxsCCn8tqvcHvowDVvFzzvZS8KoFL5JD9RU6bp
         i9lf1qw45Htg1Kmp5W4oqo7iZ4sMEqpG+ZDUJGYE6Bj/KDWxvoSpkZ/eehlU+2CcY6ke
         F4LRv7U4hMh5jX4N0nfcgT7yuCFpfRVcEkNM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/nyhBk1uOsA1XtH9biqxBSFqS1i1uBqehOG4r1+rrk=;
        b=HI9OgAsQRmhrx/YSl+kVLfAiQZ7ykR+kksu4+mxrkVVkHLz6C2nTSJyhJc2R7NHJDm
         MFKb2NbydKnY29iIpfYX2OaPCNLg7UHewivaF0Gg2jUmRQT8lVlMVj4T8VLn4en4eNXc
         1wb4jEefSTUAzHcUFpBOm45/W+bu9YN/YRDPHD+UubeOqICoogFQXrg2CCdrV6SoHmDb
         +Pbkdt/8laxV0ZODzVZbKYItlKPDVDMfJVQ+1OQTtGjvHfj46JEdb/jRRt6ROa0OOxFI
         ItHGIO7MQVuLZa4N5MyfD1BqQFelqz+w9Ag9IUQLi6VAA22TfV1ci3XDypZIkGQxtVhJ
         BUSg==
X-Gm-Message-State: AO0yUKUg+vhyQwLT9YaQxFg5L0YZ8XaaB7Nntax7tPbTPIMjg4/gbzBp
        /yNVXpHP/EtEl6DqMNMg1iqm1AIQ/Me7j/3lprrB4g==
X-Google-Smtp-Source: AK7set/F3VMGseYlu8zVbfJ1ajGRHTFHKE+1AiIPu8gs1RdZDgpyaPurXyum0GX6DS8jbFkyZ0tTDXIFWINKX3VRPas=
X-Received: by 2002:a02:856e:0:b0:3a9:5aa1:3477 with SMTP id
 g101-20020a02856e000000b003a95aa13477mr602873jai.18.1675266492402; Wed, 01
 Feb 2023 07:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20230126225815.1518839-1-ryanneph@chromium.org> <dee14d1b-fc28-e867-b425-ab11c31d799d@collabora.com>
In-Reply-To: <dee14d1b-fc28-e867-b425-ab11c31d799d@collabora.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Wed, 1 Feb 2023 07:48:11 -0800
Message-ID: <CAJs_Fx4w-a0t9ekHvV55Ys6dYuTsKMa=az9E3UZcsej5AYNdGQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: exbuf->fence_fd unmodified on interrupted wait
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Ryan Neph <ryanneph@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yiwei Zhang <zzyiwei@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 5:28 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 1/27/23 01:58, Ryan Neph wrote:
> > An interrupted dma_fence_wait() becomes an -ERESTARTSYS returned
> > to userspace ioctl(DRM_IOCTL_VIRTGPU_EXECBUFFER) calls, prompting to
> > retry the ioctl(), but the passed exbuf->fence_fd has been reset to -1,
> > making the retry attempt fail at sync_file_get_fence().
> >
> > The uapi for DRM_IOCTL_VIRTGPU_EXECBUFFER is changed to retain the
> > passed value for exbuf->fence_fd when returning ERESTARTSYS or EINTR.
> >
> > Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
> > Signed-off-by: Ryan Neph <ryanneph@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 9 ++++++---
> >  include/uapi/drm/virtgpu_drm.h         | 3 +++
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > index 9f4a90493aea..ffce4e2a409a 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > @@ -132,6 +132,8 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> >       uint64_t fence_ctx;
> >       uint32_t ring_idx;
> >
> > +     exbuf->fence_fd = -1;
> > +
> >       fence_ctx = vgdev->fence_drv.context;
> >       ring_idx = 0;
> >
> > @@ -152,8 +154,6 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> >               ring_idx = exbuf->ring_idx;
> >       }
> >
> > -     exbuf->fence_fd = -1;
>
> Is there any userspace relying on this -1 behaviour? Wouldn't be better
> to remove this offending assignment?

Looking at current mesa, removing the assignment should be ok (and
more consistent with other drivers).  But I can't say if this was
always true, or that there aren't other non-mesa users, so I can see
the argument for the more conservative uabi change that this patch
went with.

BR,
-R
