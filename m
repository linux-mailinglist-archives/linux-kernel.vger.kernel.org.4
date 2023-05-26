Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AD0712943
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243876AbjEZPU6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 May 2023 11:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbjEZPU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:20:56 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD66F7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:20:55 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-43932736509so531406137.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685114454; x=1687706454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+SOwkMnAYLUhEyDhUUgTK3i7OucfEXqIXWQlJcLoVU=;
        b=XB3ErZReV2GX4zZLuywx6MIZ6e/OdIa8CYFFHMJoN8FQe8c53mIqfGd2DgNXiO+WjA
         mkjX2fyu6a2vqts7RE32YayRmvh4Eg9p/uCsvPZi6FsJBoWfGJTCoxFgbT5Is0BDpP9I
         MQ74zt9aSzGH/epEX156Nh3gMdK/sVjlUWolekjcjAOHk4dO9hLrP/V9FK0Wvj5PbEtX
         h1nUUYQ2q5ear7SqAAZg+RgGzkT/jd+OLonkJxhxn/5o4hXj57Y4h0Erjsms9AqHlZm+
         rNwWQgcuZZWfy39oIwOraHO/4PWideYevlfda/henzEgf3vfxCd+IIWVhe10cKqLeqpQ
         t5yA==
X-Gm-Message-State: AC+VfDy5BPc7ZJnQuef+ssIlsnumaedNh91/LOGzNteJf8eCFGRIskTj
        d2ul20j87tAJPffxt1LSkfS+HRTJcs8NT0II7OI=
X-Google-Smtp-Source: ACHHUZ6ZlhFY7AADiHbWA1tNcXhU9OhjLGRqgcDbeU13+spfQOI9Yck0GdZSs3V5xPT9GKA0itjGIYseaGK56N8MAdk=
X-Received: by 2002:a67:fb0c:0:b0:436:c4a:bcc4 with SMTP id
 d12-20020a67fb0c000000b004360c4abcc4mr644960vsr.21.1685114454682; Fri, 26 May
 2023 08:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230526091052.2169044-1-kherbst@redhat.com>
In-Reply-To: <20230526091052.2169044-1-kherbst@redhat.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Fri, 26 May 2023 11:20:43 -0400
Message-ID: <CAKb7Uvha74HOvny25aqnwzvvRLpc7+DNQm6QEAk4oxfTa1urJg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v2] drm/nouveau: bring back blit subchannel for
 pre nv50 GPUs
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 5:11 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> 1ba6113a90a0 removed a lot of the kernel GPU channel, but method 0x128
> was important as otherwise the GPU spams us with `CACHE_ERROR` messages.
>
> We use the blit subchannel inside our vblank handling, so we should keep
> at least this part.
>
> v2: Only do it for NV11+ GPUs
>
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/201
> Fixes: 4a16dd9d18a0 ("drm/nouveau/kms: switch to drm fbdev helpers")
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_chan.c |  1 +
>  drivers/gpu/drm/nouveau/nouveau_chan.h |  1 +
>  drivers/gpu/drm/nouveau/nouveau_drm.c  | 20 +++++++++++++++++---
>  3 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
> index e648ecd0c1a0..3dfbc374478e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_chan.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
> @@ -90,6 +90,7 @@ nouveau_channel_del(struct nouveau_channel **pchan)
>                 if (cli)
>                         nouveau_svmm_part(chan->vmm->svmm, chan->inst);
>
> +               nvif_object_dtor(&chan->blit);
>                 nvif_object_dtor(&chan->nvsw);
>                 nvif_object_dtor(&chan->gart);
>                 nvif_object_dtor(&chan->vram);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/nouveau/nouveau_chan.h
> index e06a8ffed31a..bad7466bd0d5 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_chan.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
> @@ -53,6 +53,7 @@ struct nouveau_channel {
>         u32 user_put;
>
>         struct nvif_object user;
> +       struct nvif_object blit;
>
>         struct nvif_event kill;
>         atomic_t killed;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index cc7c5b4a05fd..9512f1c2f871 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -369,15 +369,29 @@ nouveau_accel_gr_init(struct nouveau_drm *drm)
>                 ret = nvif_object_ctor(&drm->channel->user, "drmNvsw",
>                                        NVDRM_NVSW, nouveau_abi16_swclass(drm),
>                                        NULL, 0, &drm->channel->nvsw);
> +
> +               if (ret == 0 && device->info.chipset >= 0x11) {

Can you double-check that this is needed on NV15? IIRC there's some
non-linearity of chipsets here which is why we had (some long time
ago, not sure if it's still there), a chip class which would simplify
such checks.

Cheers,

  -ilia
