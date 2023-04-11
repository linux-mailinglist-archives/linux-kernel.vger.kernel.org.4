Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CE36DD8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjDKLHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDKLHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:07:49 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3546AC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:07:28 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y186so7674996yby.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681211246; x=1683803246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QerpMJ/NA5o5HDiSA3h+P57cppudy/lyaLjUt/s72Nk=;
        b=P1p4uydIJpnDhwTMHvIiYwhOy9N/YHBO8setIkidVtg4qb9a0mSM/psFJQIemWKi8J
         d7dPv8CxCt3v16h0beXniLI/7KGGcPqhSydzWlU1d2V6la0nXYgnpWGgbrODvSReN5z7
         1R+yzYQUcSMTV9dOfKG+E38guJB6Ih/UeZGIGGlUzyA9qH73cZXPJQkqLMHbzQrz7lSJ
         glzqN9mcJvXbaz1zcH6zKJVHCE7MXxgMyzbONjEF74VrmK3eL0FctKKcbkyvsA3RgTls
         7b91qdzQIkSw3c6aqdrwRYFiDn3HFp8/qJFdqYaFwi5+tGHeLrMsEu3zWHxDWrpC7O5N
         hECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211246; x=1683803246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QerpMJ/NA5o5HDiSA3h+P57cppudy/lyaLjUt/s72Nk=;
        b=2okPA+1xCiYagq9Gznpq9QU44uAQdGopKGjcniAx5u8wwpw4xsbse0S6fZ4A1nJ27G
         k0lAY6CN62De41O5XtlNOyVX4caxOUN5whAxCSkMCWh9V31L2aFOZ3adEDw6Fxaig52W
         XnPHlDhXc8E6KPZohvp8bnHHdeVmY9BfySMNwPAH/uoz/sFhfoMUtfUM7aLO2Avk65eW
         B73wAcG1RD8ntcH3rSK9Su4pOuya5dz36l6vyyyRWrfF54pMCDeyeawpF99p3PdtU/uT
         GiRbR3sASGRxlocrQArBzkKRrhTayYA2yZhZSymfBDBCXTD0pHTy6BqbYwEehOh+B5Yh
         bJnQ==
X-Gm-Message-State: AAQBX9df+BuDHEs/+WFoY8JjM8dAXkkhH9PyzAdmRlJUCG0a0e3DJiYh
        OuLM2/VGFfwHT4ZZ+bJYiApINM2TrW9j5kHOQgA=
X-Google-Smtp-Source: AKy350Y6zyd2nTxF/toCmuH9AcTxR2J8JoVG19fu966k0sPHAcoGvI1pQPCv+IX45om9J/K+uwKIIXZ7WLfYB4XJqOA=
X-Received: by 2002:a25:be11:0:b0:b7d:4c96:de0 with SMTP id
 h17-20020a25be11000000b00b7d4c960de0mr4796447ybk.5.1681211246434; Tue, 11 Apr
 2023 04:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230409123957.29553-1-dmitry.osipenko@collabora.com> <20230409123957.29553-4-dmitry.osipenko@collabora.com>
In-Reply-To: <20230409123957.29553-4-dmitry.osipenko@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 11 Apr 2023 12:07:14 +0100
Message-ID: <CACvgo51719VsgNqiTO-RnZxXruRvtuMgJ1v5oaq4x5Lrniuaaw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] drm/virtio: Support sync objects
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Sun, 9 Apr 2023 at 13:40, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:

> +static void virtio_gpu_free_syncobjs(struct drm_syncobj **syncobjs,
> +                                    uint32_t nr_syncobjs)
> +{
> +       uint32_t i = nr_syncobjs;
> +
> +       while (i--) {
> +               if (syncobjs[i])
> +                       drm_syncobj_put(syncobjs[i]);
> +       }
> +
> +       kvfree(syncobjs);
> +}
> +

> +static void virtio_gpu_reset_syncobjs(struct drm_syncobj **syncobjs,
> +                                     uint32_t nr_syncobjs)
> +{
> +       uint32_t i;
> +
> +       for (i = 0; i < nr_syncobjs; i++) {
> +               if (syncobjs[i])
> +                       drm_syncobj_replace_fence(syncobjs[i], NULL);
> +       }
> +}
> +

Can I bribe you (with cookies) about dropping the NULL checks above?
They're dead code and rather misleading IMHO.


> +static void
> +virtio_gpu_free_post_deps(struct virtio_gpu_submit_post_dep *post_deps,
> +                         uint32_t nr_syncobjs)
> +{
> +       uint32_t i = nr_syncobjs;
> +
> +       while (i--) {
> +               kfree(post_deps[i].chain);
> +               drm_syncobj_put(post_deps[i].syncobj);
> +       }
> +
> +       kvfree(post_deps);
> +}
> +
> +static int virtio_gpu_parse_post_deps(struct virtio_gpu_submit *submit)
> +{
> +       struct drm_virtgpu_execbuffer *exbuf = submit->exbuf;
> +       struct drm_virtgpu_execbuffer_syncobj syncobj_desc;
> +       struct virtio_gpu_submit_post_dep *post_deps;
> +       u32 num_out_syncobjs = exbuf->num_out_syncobjs;
> +       size_t syncobj_stride = exbuf->syncobj_stride;
> +       int ret = 0, i;
> +
> +       if (!num_out_syncobjs)
> +               return 0;
> +
> +       post_deps = kvcalloc(num_out_syncobjs, sizeof(*post_deps), GFP_KERNEL);
> +       if (!post_deps)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < num_out_syncobjs; i++) {
> +               uint64_t address = exbuf->out_syncobjs + i * syncobj_stride;
> +

For my own education: what's the specifics/requirements behind the
stride? is there a use-case for the stride to vary across in/out
syncobj?

Off the top of my head: userspace could have an array of larger
structs, each embedding an syncobj. Thus passing the stride, the
kernel will fetch/update them in-place w/o caring about the other
data.
Or perhaps there is another trick that userspace utilises the stride for?


> +               if (copy_from_user(&syncobj_desc,
> +                                  u64_to_user_ptr(address),
> +                                  min(syncobj_stride, sizeof(syncobj_desc)))) {
> +                       ret = -EFAULT;
> +                       break;
> +               }
> +

We seem to be parsing garbage(?) stack data in the syncobj_stride <
sizeof(syncobj_desc) case.

Zeroing/reseting the syncobj_desc on each iteration is one approach -
be that fully or in part. Alternatively we could error out on
syncobj_stride < sizeof(syncobj_desc).


> +               post_deps[i].point = syncobj_desc.point;
> +
> +               if (syncobj_desc.flags) {
> +                       ret = -EINVAL;
> +                       break;
> +               }
> +
> +               if (syncobj_desc.point) {
> +                       post_deps[i].chain = dma_fence_chain_alloc();
> +                       if (!post_deps[i].chain) {
> +                               ret = -ENOMEM;
> +                               break;
> +                       }
> +               }
> +
> +               post_deps[i].syncobj = drm_syncobj_find(submit->file,
> +                                                       syncobj_desc.handle);
> +               if (!post_deps[i].syncobj) {
> +                       ret = -EINVAL;

I think we want a kfree(chain) here. Otherwise we'll leak it, right?


> +                       break;
> +               }
> +       }
> +
> +       if (ret) {
> +               virtio_gpu_free_post_deps(post_deps, i);
> +               return ret;
> +       }
> +
> +       submit->num_out_syncobjs = num_out_syncobjs;
> +       submit->post_deps = post_deps;
> +
> +       return 0;
> +}
> +


With the two issues in virtio_gpu_parse_post_deps() addressed, the series is:
Reviewed-by; Emil Velikov <emil.velikov@collabora.com>


HTH
Emil
