Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B733D6F0203
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbjD0Hp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243115AbjD0Hoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:44:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35650173E;
        Thu, 27 Apr 2023 00:44:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so12525577a12.1;
        Thu, 27 Apr 2023 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682581491; x=1685173491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN4Wi6us9tqsW8wES8TfgapwiSQM5W3hLxG1tm9HFuk=;
        b=Z/MeeZiHBqR8BxiSLLgHCC/EH/QJKBpmBB+s+TiEbkHjNHGfQk8bgl3fEdk6cTAb8s
         i5Rgr7ATOP4iz9wyQn6Aecx1h53Y7H/iWCEF3Xs1jE6x40FOT7R87qeSkCvdCDsnX3oM
         o7J6sMW/R47q/Q95xro8n92wplp3kDXiWD2xJr75vZTJrwQUwzjwYHPZkolBOMlHwZC6
         LeTwzxCIf4xH76inLIaInXPJhcTfXWNcXkwUyGxuN7+aEVNRnjZhgEnXr73M0Vyo7AoP
         XYXo7mO5TFHAHW606Dt5BMF5OXx3j7KHPy0Q5SU2Njjve624+FyCJcm5dvnNRJ2HorOy
         4yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682581491; x=1685173491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yN4Wi6us9tqsW8wES8TfgapwiSQM5W3hLxG1tm9HFuk=;
        b=Xs0o8jtl5gc0o6pMBEJ9q1DaDsXlqHVsm2r+HsQulerMOJiI6KD+SDrb4MASIfynDr
         N4Dm3vDZjNB35e3zyxTQ9TRmKsZeYisaZj+iw2/g11G24Y2NC/08NWmJ7HxeHC/RNiEI
         Cp9Py60EjYiAHV9yZ+RjQ1bQrCuQvWIYS4uF1UCXF8VFVaCkmHzKgyNWIduRFMHRe9tC
         v2nmXUKvzU+QafCrZTNSYUQHNwG6UQerqM3dQrartyT2JuDqxBnxF7nU4kxK8hBQfiyL
         x6oxp1l8j84sVzrmsPeuTgQn0rTKWan+EXaCcvPt3sxyE5RHjo+ooFFT/NxJ6NIjNEk0
         Tb1Q==
X-Gm-Message-State: AC+VfDzQ8B8vn+VUITdNB+OxJYbrLWkCCYjv2O+P/0AETUXCjqHdFso2
        4NP/BvrSspqzjZDR+eO1RIqoNlJKWxYW+EiS/S+gsoJIE4u0Fg==
X-Google-Smtp-Source: ACHHUZ7Ivm3w6KJmjlpirXR7ZF+N4Jh+ldZEPc5yzcTHChvJ2LMc/imtrzBOL4rDvKcbf9E6AyOGILa+jzdbdHALb4Q=
X-Received: by 2002:a17:907:961b:b0:94e:6a24:9463 with SMTP id
 gb27-20020a170907961b00b0094e6a249463mr909190ejc.28.1682581491617; Thu, 27
 Apr 2023 00:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230419122233.3440-1-hackyzh002@gmail.com>
In-Reply-To: <20230419122233.3440-1-hackyzh002@gmail.com>
From:   whitehat002 whitehat002 <hackyzh002@gmail.com>
Date:   Thu, 27 Apr 2023 15:44:39 +0800
Message-ID: <CAF6NKda1Jy_wfxaVqWt-o75f1BO-o4JXHY9HS9_JtJ2FHztMmQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello
What is the current status of this patch, has it been applied?


hackyzh002 <hackyzh002@gmail.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=B8=89 20:23=E5=86=99=E9=81=93=EF=BC=9A
>
> The type of size is unsigned int, if size is 0x40000000, there will
> be an integer overflow, size will be zero after size *=3D sizeof(uint32_t=
),
> will cause uninitialized memory to be referenced later.
>
> Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 08eced097..89bcacc65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -192,7 +192,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p=
,
>         uint64_t *chunk_array_user;
>         uint64_t *chunk_array;
>         uint32_t uf_offset =3D 0;
> -       unsigned int size;
> +       size_t size;
>         int ret;
>         int i;
>
> --
> 2.34.1
>
