Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5B6E5206
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjDQUpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDQUpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:45:21 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799F7449E;
        Mon, 17 Apr 2023 13:45:20 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-187dc84637aso6325430fac.2;
        Mon, 17 Apr 2023 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764319; x=1684356319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fpw6Zw0s5R3Qp1iH0xXMY6crGqEVCslknpiblwPum4=;
        b=PbL9RlrcEvNtSBq5aFF1K+XHDmkI1FDrcYfuJUZi/GpvIqLh3TS1ne611uq7ZetEs7
         wTsy6p5MIs1/M1NQGID3U8sN6mdCiFAqtLNe+1MlksdnJ4Q2BoVi9N4G4Wi32A2mcoIS
         CRtbvVrcsxf8IStYHnSXI2//mFbzdQQNb976ojo0B/ZPO7rHgUXtzBClLCH3CrBP7Ivp
         BB6UxkCNPc31gU5iVLET6tA2Dfznsf4FlRy49CqleR2cFoqqvVg7fFCUXHw/KFQi9MmZ
         cchHkgfPOma52nHjRoG4lvsUSnl5tcgdf5u9T6N1pdIsMfaUHlJeeblnSdNkg7WW4wGY
         vojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764319; x=1684356319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fpw6Zw0s5R3Qp1iH0xXMY6crGqEVCslknpiblwPum4=;
        b=UMdvJSOOchZ27Jdr1vjlshzH8Cwb1omwIMkOSemuyNKpDEFPx81qo0/o/TB8mHBT7R
         5VGxQM5GW5ukBodw5H3JvtlwE4d64B96gGbtifFySrr+hdR1Y3rR/m5QJtsmtI7Ve+u6
         ncIGo4yAh0ovNax/WIp4xon/uNl1O9Fhc6Zy6eQOkiofoYpa7/Zzk4KK44L2ibPGLphz
         oXmxGaxTDqw60Q+wBqeZhEDRR+G9iRx0+vd6Mp8kLw46436GWKNWm7l05Mv34csWZpdT
         DPJsgTSzTHBln3YnwYFyIhN0CsP8cZXeLCwApcKXAStJZpuZnTZrDsNlU/P4uqfXZQWa
         kHhA==
X-Gm-Message-State: AAQBX9ch/RBAEPhvjecR921jrtSr3TuJ5uyfDOQN44N3pN5gRsw9SwiB
        DqEhnPPtoubUQ00uknlD0DmBTJrq7NE5x+O5Kgg=
X-Google-Smtp-Source: AKy350YGawNtt/qIBtEhaGmjXWvU97vjeDYCYWAWwSsngIuB8jSH/zqF+G8k9jUHx6+c7HnX9gmC/4usZ8HmOXt9ftk=
X-Received: by 2002:a05:6870:34b:b0:187:8ee8:5f5b with SMTP id
 n11-20020a056870034b00b001878ee85f5bmr7174102oaf.5.1681764319699; Mon, 17 Apr
 2023 13:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230417201215.448099-1-robdclark@gmail.com>
In-Reply-To: <20230417201215.448099-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 17 Apr 2023 13:45:08 -0700
Message-ID: <CAF6AEGumgsJJQXojapPAJOjmFo=MZ31DNmp9T+SErQ2GBKBLFg@mail.gmail.com>
Subject: Re: [RFC 0/3] drm: Add comm/cmdline fdinfo fields
To:     dri-devel@lists.freedesktop.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
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

On Mon, Apr 17, 2023 at 1:12=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> From: Rob Clark <robdclark@chromium.org>
>
> When many of the things using the GPU are processes in a VM guest, the
> actual client process is just a proxy.  The msm driver has a way to let
> the proxy tell the kernel the actual VM client process's executable name
> and command-line, which has until now been used simply for GPU crash
> devcore dumps.  Lets also expose this via fdinfo so that tools can
> expose who the actual user of the GPU is.

I should have also mentioned, in the VM/proxy scenario we have a
single process with separate drm_file's for each guest VM process.  So
it isn't an option to just change the proxy process's name to match
the client.

> Rob Clark (3):
>   drm/doc: Relax fdinfo string constraints
>   drm/msm: Rework get_comm_cmdline() helper
>   drm/msm: Add comm/cmdline fields
>
>  Documentation/gpu/drm-usage-stats.rst   | 37 +++++++++++++++----------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 +--
>  drivers/gpu/drm/msm/msm_drv.c           |  2 ++
>  drivers/gpu/drm/msm/msm_gpu.c           | 27 +++++++++++++-----
>  drivers/gpu/drm/msm/msm_gpu.h           | 12 ++++++--
>  drivers/gpu/drm/msm/msm_submitqueue.c   |  1 +
>  6 files changed, 58 insertions(+), 25 deletions(-)
>
> --
> 2.39.2
>
