Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE097208FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjFBSUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbjFBSUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:20:38 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB92610F4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:20:11 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5585f2f070bso1674321eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685729995; x=1688321995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruVVANUt1rkl2YltnY0VMnFPVn2MSLuHPa/KLfddOQI=;
        b=ng8Zqz9Z1hgelGexfypABP0OmFAOwn+FoLkBQJd5NubPZMrM6+uBJiBoyyxH4BOvos
         gXUAg+J0ixJRyACe9gc/XHgRTcbbWfpjreSweek+yLKHG82udvA4jS53ng3vPPCWF8cb
         2OfIRljPQApekAOT8I34NH4XTqPFUd6e6E5T8xcPtWFzh7UVhD+xQOgjurqNeqon9rI2
         Iedhm67TNOQxmGvOkuZzEuB/uLn7dHAn61ZCELCGpyZ10nVhPtnrW2+jBYP1DvMJJ3tZ
         0STizNX+zxJ6L/pz1Vuay0HpvBCbA30MautyELFz6Wuw8OcdP8fFvcobTW5fOrF1LB+O
         L1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685729995; x=1688321995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruVVANUt1rkl2YltnY0VMnFPVn2MSLuHPa/KLfddOQI=;
        b=R219ssyEJSh15iT77wKKZCG+i73GETw06hxEWZtOe502N5W5SYqdX1BWsHnOdKR+0h
         5lGhj/1bjNyrrIvZcu5X35J8kxCu3LKQtG3kF44GGLw5FAqmsJhre8bfChrq1VABFftB
         ipCHolatwlPVGxEJSbyOsaGIJoa/3T8tAzupwlADfaJmez7qytnggZbw9q0fLqqkFwn8
         X5l32u+QFveaTXlLv8KrkZIkmggrS0vDIAYYvLT+18B5k01/0OIfqMjQMxLU94NdGtQH
         2GS/etJbrFCxmQUx52dTOnJQplqYgcH08/al9544KM4IGL10gDypNOISoLABMq61Ze01
         P2Dg==
X-Gm-Message-State: AC+VfDxyUAZ3OKpWbj/UjGhzB5DZDkuG6xsVtYNnQlF0JUZgyrNpmRJu
        A3paVLSuBg31rBYmaVQGNa9preDVTUfeKHIpP8k=
X-Google-Smtp-Source: ACHHUZ7udrYG+H6UGxo37tXKpSQPyugKYQKqTppilBeQayTPvyvZhtfN9IhTZ+FTexkc9dCzuPanBmgoQnRmCXMNvjM=
X-Received: by 2002:a4a:45c7:0:b0:555:991b:b340 with SMTP id
 y190-20020a4a45c7000000b00555991bb340mr7608913ooa.6.1685729995619; Fri, 02
 Jun 2023 11:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230601214814.2329224-1-olvaffe@gmail.com>
In-Reply-To: <20230601214814.2329224-1-olvaffe@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 2 Jun 2023 14:19:43 -0400
Message-ID: <CADnq5_NQ2zgvRDZ8NWUsCm-8JO6PZSEmQ+WrbjYqjv3vTLfinw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix xclk freq on CHIP_STONEY
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Le Ma <le.ma@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jun 1, 2023 at 5:48=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wrote:
>
> According to Alex, most APUs from that time seem to have the same issue
> (vbios says 48Mhz, actual is 100Mhz).  I only have a CHIP_STONEY so I
> limit the fixup to CHIP_STONEY
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu=
/vi.c
> index 770f2d7a371fc..6a8494f98d3ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -542,8 +542,15 @@ static u32 vi_get_xclk(struct amdgpu_device *adev)
>         u32 reference_clock =3D adev->clock.spll.reference_freq;
>         u32 tmp;
>
> -       if (adev->flags & AMD_IS_APU)
> -               return reference_clock;
> +       if (adev->flags & AMD_IS_APU) {
> +               switch (adev->asic_type) {
> +               case CHIP_STONEY:
> +                       /* vbios says 48Mhz, but the actual freq is 100Mh=
z */
> +                       return 10000;
> +               default:
> +                       return reference_clock;
> +               }
> +       }
>
>         tmp =3D RREG32_SMC(ixCG_CLKPIN_CNTL_2);
>         if (REG_GET_FIELD(tmp, CG_CLKPIN_CNTL_2, MUX_TCLK_TO_XCLK))
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
