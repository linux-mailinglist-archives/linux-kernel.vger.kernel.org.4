Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501D16BF262
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCQUZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCQUZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:25:34 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680A85CEED;
        Fri, 17 Mar 2023 13:25:33 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17aeb49429eso6634345fac.6;
        Fri, 17 Mar 2023 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679084732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7N/5SkdFbLDourlYidVecmvge10Le3raMprhkQ2YpI=;
        b=VKYuDQH8nPi9ya7zgAwmREN+GuwmAVAcLFUdKcKuppWfo4W1MxXwgAh5TxIE3ipYph
         qulB8Lq8oF57cs5SxV6TT4pei+7u7mjWdIYCZOEtWKyyuXAyvtfup5QV0LDM+CIZfzQa
         6DC3uhGNaOQyb8LnT79dM9pB4w0lJVJsin/Ti8XMn7meublIWqtWVRNUbJaDuR1mmJV8
         NJfhF5e5Ggj5lN8kXRTnRbrWuhBlyQyZnHh9USnlZvt0FLmtwdOxBEwZRHit0OyhbOFJ
         p6q9HXnsIX4LRuq9SeUEe86+qtI17axfn1AMvmA7hgaY718cXErGmJYNb+eDqfAv230b
         mwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679084732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7N/5SkdFbLDourlYidVecmvge10Le3raMprhkQ2YpI=;
        b=wy3Gbw+lqGOzghw8CGXoUIYeWrHB6D6HW0pA2hWx+wXYyz//wk3QgOd5LL35buXxlI
         dJPltgAgs5FcRtTaZD9Fln11g6x2CDwp2QaHSCL+M5jUd7ScsMNWaP85Kzz4KiZGQXdx
         +ix5CnkMdRsuaj4W/6rzVe8inNlYRihink5X57ij2Q4h22o6iDzwdQSHm9woM1kUHBc0
         EohyYVOv3HtuT+mqOuYEXEp0dufU2KhgNZWTiMBfLTugVwwX+MWzPEEGv4VxQe72p1q+
         7W88gGrEiBYdVW24ZDeDA8YXM7pJ8Vu6ozo2vVbCN+MYUsd6sfe+tAQ1rGJ2U7HMGf9s
         gzaQ==
X-Gm-Message-State: AO0yUKXWaNi91bUeooUOVyDnrOT8R4xoMFiGeSa7MTjyraszYj9yl+dw
        g29wie9tvoomCCXEdUzzZXIZXLlDUTJOmDCNlOA=
X-Google-Smtp-Source: AK7set+MWzHjggCWfkotzjv7c10QgriF3tPYiWRYjwRgLeeQB4ULOcZL6eJCrv4r5X2TND/7KeognxUSoxZqL1EgdHg=
X-Received: by 2002:a05:6870:1099:b0:17c:29d8:61ee with SMTP id
 25-20020a056870109900b0017c29d861eemr7614oaq.3.1679084732788; Fri, 17 Mar
 2023 13:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-18-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-18-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:25:21 -0400
Message-ID: <CADnq5_PTVrzPanSQznXLGWnnpKoRCjugBsExixkqEri+8i3r=Q@mail.gmail.com>
Subject: Re: [PATCH 17/37] drm/amd/amdgpu/amdgpu_mes: Ensure
 amdgpu_bo_create_kernel()'s return value is checked
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, Jack Xiao <Jack.Xiao@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linaro-mm-sig@lists.linaro.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-media@vger.kernel.org, David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function =E2=80=98amdgpu_mes=
_ctx_alloc_meta_data=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1099:13: warning: variable =E2=
=80=98r=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Jack Xiao <Jack.Xiao@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 82e27bd4f0383..30cd72ca1eefd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1104,6 +1104,11 @@ int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_d=
evice *adev,
>                             &ctx_data->meta_data_obj,
>                             &ctx_data->meta_data_mc_addr,
>                             &ctx_data->meta_data_ptr);
> +       if (r) {
> +               dev_warn(adev->dev, "(%d) create CTX bo failed\n", r);
> +               return r;
> +       }
> +
>         if (!ctx_data->meta_data_obj)
>                 return -ENOMEM;
>
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
