Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF64A6DCD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDJWGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDJWGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:06:09 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D7A1BCF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:06:08 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id z3so151756qvs.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pjZar/MQ6b8qhGH+7PNrFyUqecvUssrkJbOR7pgMRKc=;
        b=AKjhpvE8a0FvmQzxH1oSCFwMlFKaSCrVrgg0QM/2yl87UEhKP7TdhrsHaOiQqAglRR
         tJQKz35Vz27LR72Y8GaYQ8hDq++AkfUTdJdNStkY3CkPdkWoKR2HAtMcUz3DFpRUI5dw
         lZ+nY+lm3TuDg9cX7+rBZa2823hR2Tc7BVvmiIAyLtCXkWiikUlV/hr3HbJTelbjfb5T
         3GfG5rhUCDByztzWW2+UUT7XZSqfje8/JQpcD8U2tbbrJMSut2QFtnCrPZXUFqVLTncR
         h9q8h4cSKGKp1+4s6yQG9eS7k2Z2yyk2GOmIdFr1q4bdqNjFy/gl8P6l8OnGI+P4Z1OT
         sB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjZar/MQ6b8qhGH+7PNrFyUqecvUssrkJbOR7pgMRKc=;
        b=MgSWl/fKXiuVwKA8HoM2w2v6zo6+Tac9Ohc/lswY/IoAx3EaQkcozZyqZDu/5NwGB+
         NNaZP6msNwQLycJ7U4v5ePfWcfpKPXPxpFVb/ns6RN21Jox6uRpbe2FvgioHj9TI/Ws+
         BJwLE7lvGOMirThlkROimeSwLPPUydxJeOAgoi1eNBQFQ7aOu4R+Nb16uRrdPMpR85Pd
         p8ETt9FjDAiQr+XpynuEpfa9EXN42BZN/qjYrrn1qnsC2pu0zb8djdWAyVWYOguvhmhl
         z6JbbuoLWsyEbLwo1/S8s50XJJyAyVih2IiMfERHn4Bi+wrRLt7mFewwaaJQ7NCrKZsU
         Vnuw==
X-Gm-Message-State: AAQBX9cUWeKSxj875jOA6svJTgIExRQd0yiO1o5GwrGUfiaaqFXabdjM
        fEcwMeb7duAeYoFvrJXABs2E5/14diuXmxwxV8/uYICr
X-Google-Smtp-Source: AKy350ZCO2ODxbxkhuEt1R/ncctGRfvUhnl8jBM9I1A4QEn77gjZc7dDt155ded3USH7Jve042Cl5hhNInj2Nt4O8CU=
X-Received: by 2002:a05:6214:560b:b0:56f:80e:701b with SMTP id
 mg11-20020a056214560b00b0056f080e701bmr2493952qvb.2.1681164367933; Mon, 10
 Apr 2023 15:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230405110455.1368428-1-kherbst@redhat.com>
In-Reply-To: <20230405110455.1368428-1-kherbst@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Tue, 11 Apr 2023 08:05:56 +1000
Message-ID: <CACAvsv6ODb++b3nZMJcv2__rUC7M0K1BDiZqoh9tLhNqtSxKzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/fb: add missing sysmen flush callbacks
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org
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

On Wed, 5 Apr 2023 at 21:05, Karol Herbst <kherbst@redhat.com> wrote:
>
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/203
> Fixes: 5728d064190e1 ("drm/nouveau/fb: handle sysmem flush page from common code")
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
Oops, that must've gotten lost in a rebase somehow.

Reviewed-by: Ben Skeggs <bskeggs@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c
> index 76678dd60f93f..c4c6f67af7ccc 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c
> @@ -31,6 +31,7 @@ gf108_fb = {
>         .init = gf100_fb_init,
>         .init_page = gf100_fb_init_page,
>         .intr = gf100_fb_intr,
> +       .sysmem.flush_page_init = gf100_fb_sysmem_flush_page_init,
>         .ram_new = gf108_ram_new,
>         .default_bigpage = 17,
>  };
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c
> index f73442ccb424b..433fa966ba231 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c
> @@ -77,6 +77,7 @@ gk104_fb = {
>         .init = gf100_fb_init,
>         .init_page = gf100_fb_init_page,
>         .intr = gf100_fb_intr,
> +       .sysmem.flush_page_init = gf100_fb_sysmem_flush_page_init,
>         .ram_new = gk104_ram_new,
>         .default_bigpage = 17,
>         .clkgate_pack = gk104_fb_clkgate_pack,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
> index 45d6cdffafeed..4dc283dedf8b5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
> @@ -59,6 +59,7 @@ gk110_fb = {
>         .init = gf100_fb_init,
>         .init_page = gf100_fb_init_page,
>         .intr = gf100_fb_intr,
> +       .sysmem.flush_page_init = gf100_fb_sysmem_flush_page_init,
>         .ram_new = gk104_ram_new,
>         .default_bigpage = 17,
>         .clkgate_pack = gk110_fb_clkgate_pack,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c
> index de52462a92bf0..90bfff616d35b 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c
> @@ -31,6 +31,7 @@ gm107_fb = {
>         .init = gf100_fb_init,
>         .init_page = gf100_fb_init_page,
>         .intr = gf100_fb_intr,
> +       .sysmem.flush_page_init = gf100_fb_sysmem_flush_page_init,
>         .ram_new = gm107_ram_new,
>         .default_bigpage = 17,
>  };
> --
> 2.39.2
>
