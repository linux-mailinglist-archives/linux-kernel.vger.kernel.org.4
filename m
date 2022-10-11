Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE125FB7CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJKP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJKP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:56:46 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0AA32B89
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:56:45 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id y20so5177987uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wH1Bl8itt96KxBsAlutBeKuPO2AccjwjUzu7pu+C0go=;
        b=cHQS7SWHH1gASscavrPWCc246E7BVCVrvaxgOLz953W9ZYcFihTNZv8KTxGIoPE6VO
         oxondL9qq+lJt4+IbHPqqpuaTIVC17a3n1VJ1GNQMzW5Pm1mS57FLx+5CAdHEkcfl7wu
         Wwm66Rp6rTnBPjtVSfACGBqcakSKTvYQ47tmUJBN0sqjUjgLWyAS3SJ/fPNfhEGngrt2
         0ZoJeZbPXX2MoCGE4SpvxUHGHv/Ovju656QRtnZJsqWpbYmlQ7pygRvr4N6pOUPceDQl
         dwHTSyp+zflFhfPwKszINz4PuTsGqtK2Jefl0RHElZbs7PwM+DjGcWnKFSSCX9OIqkfU
         4q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wH1Bl8itt96KxBsAlutBeKuPO2AccjwjUzu7pu+C0go=;
        b=bNTA5ov4IAGFD2Kdg6nZbKb7xwT3SpYUNUO+gV+aWvXcErQedI/08LIJuONR66+feB
         q1JWNDdy8UXqICZhv6YilkY4Zg6JRZNCYissOkRXE/9pZwLQPxFxKqiMh0zYUIgCfjsB
         iNoF1CxNRDpqt1D1ZSVodgk/ZIF6SnFXUBxGCJLF398jwGx3XPQa2slx9TToGp2BvaLr
         2ZlIjjW9aA4CFKIiIE8NvDreEgUTDtDgb9YAPTN8o8Q5+yQYfQ73L8+WiMUVSQZV+BhX
         Jn1Q/ZlftTsCkEQD/I6mkut+Pvmg2+neALbrHgj1wUG8Pj5Adq7A15JkIz4o0yF4nODD
         oAHA==
X-Gm-Message-State: ACrzQf2eVV2nICztLFcBcDN9DhBBgwbJpfk2UxfVQofgge4Zi/+uTMBE
        gSfiofp1IvINkqwwcWPRwNjH17yd9/vl15dhfUvnRQ==
X-Google-Smtp-Source: AMsMyM7hO86TNlZ7RU1O5BbKxgzcrBU9iEjAHsEU8uEo45EdTTocB+iB/ZslSLRzKUzF+PENEMSkZ/nzKg+/gEiZ/rg=
X-Received: by 2002:ab0:7a5b:0:b0:3b3:8eb9:5a25 with SMTP id
 a27-20020ab07a5b000000b003b38eb95a25mr11832841uat.55.1665503804335; Tue, 11
 Oct 2022 08:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221011075519.3111928-1-shraash@google.com>
In-Reply-To: <20221011075519.3111928-1-shraash@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 11 Oct 2022 08:56:33 -0700
Message-ID: <CABXOdTdum0q=2Fy3yM3OnGmHM9ZkNyEURx6C08879ND7ye=vxg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Remove redundant check for 'submit'
To:     Aashish Sharma <shraash@google.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:55 AM Aashish Sharma <shraash@google.com> wrote:
>
> Rectify the below smatch warning:
> drivers/gpu/drm/msm/msm_gem_submit.c:963 msm_ioctl_gem_submit() warn:
> variable dereferenced before check 'submit'
>
> 'submit' is normally error pointer or valid, so remove its NULL
> initializer as it's confusing and also remove a redundant check for it's
> value.
>
> Signed-off-by: Aashish Sharma <shraash@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/gpu/drm/msm/msm_gem_submit.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index 5599d93ec0d2..74fe1c56cd65 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -706,7 +706,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>         struct msm_drm_private *priv = dev->dev_private;
>         struct drm_msm_gem_submit *args = data;
>         struct msm_file_private *ctx = file->driver_priv;
> -       struct msm_gem_submit *submit = NULL;
> +       struct msm_gem_submit *submit;
>         struct msm_gpu *gpu = priv->gpu;
>         struct msm_gpu_submitqueue *queue;
>         struct msm_ringbuffer *ring;
> @@ -946,8 +946,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>                 put_unused_fd(out_fence_fd);
>         mutex_unlock(&queue->lock);
>  out_post_unlock:
> -       if (submit)
> -               msm_gem_submit_put(submit);
> +       msm_gem_submit_put(submit);
>         if (!IS_ERR_OR_NULL(post_deps)) {
>                 for (i = 0; i < args->nr_out_syncobjs; ++i) {
>                         kfree(post_deps[i].chain);
> --
> 2.38.0.rc2.412.g84df46c1b4-goog
>
