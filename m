Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3E601402
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJQQxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJQQxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:53:36 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A7F031
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:53:35 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x188so12788861oig.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJwuB0qtkB8zoE2oWU877oWOsBKFsfQDlsz6gYRn+Os=;
        b=YkgFn7Efk/acBxL1O4vJb+KLmVn/txovq8xX417fqtOTBuvCOTJmRX4avXm8uyGJp+
         ESib3VAvEh9SGWNvhy3ZoFPgrb9MabP0mdX/QXdfit5hpTbVV0YXusIin+V+L2KSX34H
         MCvsUaI4UI/hhdEDJmSHFarZF6IPk/V2iEw3oOL8jph5HjRbfL4vNc8Ha0jPi997T1Q3
         zeJXP4Nrcmf4MwssTlNI964xFhyPz9bbHxOsDkjQbNGrA5ge22LYi+uda+FIFiu0RY4+
         t4t2pBhMzaze1yvSQQIjjDi2LPcw/nHbjzUkvoTRi2DgYLNmakJT20qficrA5oD2Ypx2
         M8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJwuB0qtkB8zoE2oWU877oWOsBKFsfQDlsz6gYRn+Os=;
        b=Ksp+Lq+zYkiCbOWN0frM9jQAWLDDgK/l58Ha6Leq+rt7vD9FN1EqrOCbHHpAvEMCnd
         P+qMJ4jndezxJuX/wUolwNGn6g0cmh5rbQ1/OBV8YYAcSQAJBs/tV/dfhHZZZrWOAIYJ
         tiaEZFUERzVkwb+gBRAAEctYkq7v4c/PQo8MTJtdvLvnZNLgiAc+10n2PcyZvibgrdMK
         UVkdcLcnyFJF+bqVCMlTyYW+iW/F7ZfOqA3ZfBQlLcD5hVVAxSa7gxhzX4leJg5Gi/Z9
         KR7f7A/6/CpRRhzWmNrxx/xLjLoNumwBQu/l18UN9HWJQIWwm+3e6PQf11YMaK45Oshc
         kmtg==
X-Gm-Message-State: ACrzQf0wPiAhQk/8Z4NJzmZ21lvl4niLFJcyrSfnBVewPD6NEAYpcy9z
        PTpvVjphu3l/DYZZly5kEfFL6pAjMPY6e7GEigk=
X-Google-Smtp-Source: AMsMyM5kqmCxFtwMwnMlU7bBP6InC/uujc+BhkaB/RHdfHwBB6yez3xtkRgTx5RyL1ujVP1sAhHfvQ1xxnT5Kif2Dww=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr5580056oiw.96.1666025615182; Mon, 17
 Oct 2022 09:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221016174158.16638-1-fmdefrancesco@gmail.com>
In-Reply-To: <20221016174158.16638-1-fmdefrancesco@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 Oct 2022 12:53:24 -0400
Message-ID: <CADnq5_MDp6WUYTUO+Lo=XMSLdaYcwu5i2MWid9u1U2hKiyqoYg@mail.gmail.com>
Subject: Re: [RESEND PATCH] drm/amd/amdgpu: Replace kmap() with kmap_local_page()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
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

On Sun, Oct 16, 2022 at 1:42 PM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> kmap() is being deprecated in favor of kmap_local_page().
>
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and are still valid.
>
> Since its use in amdgpu/amdgpu_ttm.c is safe, it should be preferred.
>
> Therefore, replace kmap() with kmap_local_page() in amdgpu/amdgpu_ttm.c.
>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>
> I'm resending because I suspect that this patch might have been lost. In
> the meantime I added an "Acked-by" tag from Christian K.. Obviviously,
> there are no further changes in the code.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 3b4c19412625..c11657b5915f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2301,9 +2301,9 @@ static ssize_t amdgpu_iomem_read(struct file *f, ch=
ar __user *buf,
>                 if (p->mapping !=3D adev->mman.bdev.dev_mapping)
>                         return -EPERM;
>
> -               ptr =3D kmap(p);
> +               ptr =3D kmap_local_page(p);
>                 r =3D copy_to_user(buf, ptr + off, bytes);
> -               kunmap(p);
> +               kunmap_local(ptr);
>                 if (r)
>                         return -EFAULT;
>
> @@ -2352,9 +2352,9 @@ static ssize_t amdgpu_iomem_write(struct file *f, c=
onst char __user *buf,
>                 if (p->mapping !=3D adev->mman.bdev.dev_mapping)
>                         return -EPERM;
>
> -               ptr =3D kmap(p);
> +               ptr =3D kmap_local_page(p);
>                 r =3D copy_from_user(ptr + off, buf, bytes);
> -               kunmap(p);
> +               kunmap_local(ptr);
>                 if (r)
>                         return -EFAULT;
>
> --
> 2.37.1
>
