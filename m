Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1865EB00
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjAEMuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjAEMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:49:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A539F90
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:49:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z16so19523774wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3qMRF1GNRdJeDqkXuS2/nTO+iJTQuqw4vXy5aAbbK8=;
        b=X+2PEgw8rt7VT+EdaBphMOTic4+GLKrNo5BKPs7V4isiRAFuLwaAvBB6hEhMvsxkTp
         TfkDrSAUw0xWRoTQPLvLromGbOrePs0K7f+ta91kcazZvGWcblftX3Med5BuNdwvXdw1
         N0Uwmd5JJ+ifHeVx/lfVVXJJBgQUokhffq46c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3qMRF1GNRdJeDqkXuS2/nTO+iJTQuqw4vXy5aAbbK8=;
        b=yyUnq94HdFhLno0L6s46fdBfLy28GHtxuwZdtrjTPYwUuXjLtjbppo9YmpfWLJ+EmO
         OnEubu2GFZkn1BpAlfZDrtrZ3YN7i9wbga14/N6xyxoSdjd/vA4/yceccXgXGVtlz4Pu
         mlPcAw6Zp95jwhTnRTUVXQ+rj6xhoGJ3kLNtvyQrM7jP7jdZg+Yu6+fZGS+NOfBiTiUV
         l+HnIhlnTUKE4E+lT3XJ9GkUprIGAnTRMnO83K4S5Ej7TYDXXJf/OYWyqm78NzRua/8P
         qzySQIEO5TEn4DYCNzzSsoc2xcKgyY4C0io3qdglkWkVjfCXECOdxayb5M2MaNIVLW+d
         xhQA==
X-Gm-Message-State: AFqh2kp9Ar2QpvVLG9O0Ho3aU71gBnALHosz8Hy4WdXL/Gcq+4CtyRQw
        Q3kPhqg8JSGX2kt1kaHRhTFaDg==
X-Google-Smtp-Source: AMrXdXszzCjklGnfpRwtfSRuYLCAYmB6iRZ01GByyDPZYpy5kgOcT+REOcuLIRSEsB2bdG+WQDpvAw==
X-Received: by 2002:a5d:5965:0:b0:27f:1c70:58c3 with SMTP id e37-20020a5d5965000000b0027f1c7058c3mr22851191wri.24.1672922995942;
        Thu, 05 Jan 2023 04:49:55 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d4ccb000000b002b6bcc0b64dsm382668wrt.4.2023.01.05.04.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:49:55 -0800 (PST)
Date:   Thu, 5 Jan 2023 13:49:53 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Chia-I Wu <olvaffe@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: Add MSM_SUBMIT_BO_NO_IMPLICIT
Message-ID: <Y7bHcRAvk6GgMi5F@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Chia-I Wu <olvaffe@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20221206192123.661448-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206192123.661448-1-robdclark@gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 11:21:23AM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In cases where implicit sync is used, it is still useful (for things
> like sub-allocation, etc) to allow userspace to opt-out of implicit
> sync on per-BO basis.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_drv.c        |  3 ++-
>  drivers/gpu/drm/msm/msm_gem_submit.c | 11 +++++++++++
>  include/uapi/drm/msm_drm.h           |  4 +++-
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 017a512982a2..e0e1199a822f 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -45,9 +45,10 @@
>   * - 1.7.0 - Add MSM_PARAM_SUSPENDS to access suspend count
>   * - 1.8.0 - Add MSM_BO_CACHED_COHERENT for supported GPUs (a6xx)
>   * - 1.9.0 - Add MSM_SUBMIT_FENCE_SN_IN
> + * - 1.10.0 - Add MSM_SUBMIT_BO_NO_IMPLICIT
>   */
>  #define MSM_VERSION_MAJOR	1
> -#define MSM_VERSION_MINOR	9
> +#define MSM_VERSION_MINOR	10
>  #define MSM_VERSION_PATCHLEVEL	0
>  
>  static const struct drm_mode_config_funcs mode_config_funcs = {
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index eb3536e3d66a..8bad07a04f85 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -334,9 +334,20 @@ static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
>  		if (ret)
>  			return ret;
>  
> +		/* If userspace has determined that explicit fencing is
> +		 * used, it can disable implicit sync on the entire
> +		 * submit:
> +		 */
>  		if (no_implicit)
>  			continue;
>  
> +		/* Otherwise userspace can ask for implicit sync to be
> +		 * disabled on specific buffers.  This is useful for internal
> +		 * usermode driver managed buffers, suballocation, etc.
> +		 */
> +		if (submit->bos[i].flags & MSM_SUBMIT_BO_NO_IMPLICIT)
> +			continue;
> +
>  		ret = drm_sched_job_add_implicit_dependencies(&submit->base,

Won't this break shrinkers and fun stuff like that? It's why we added the
new USAGE_OTHER fence slot at least, and also why I wonder whether we
shouldn't push this into the helper to make the right call. Every driver
kinda needs the same wheel.
-Daniel

>  							      obj,
>  							      write);
> diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
> index f54b48ef6a2d..329100016e7c 100644
> --- a/include/uapi/drm/msm_drm.h
> +++ b/include/uapi/drm/msm_drm.h
> @@ -222,10 +222,12 @@ struct drm_msm_gem_submit_cmd {
>  #define MSM_SUBMIT_BO_READ             0x0001
>  #define MSM_SUBMIT_BO_WRITE            0x0002
>  #define MSM_SUBMIT_BO_DUMP             0x0004
> +#define MSM_SUBMIT_BO_NO_IMPLICIT      0x0008
>  
>  #define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | \
>  					MSM_SUBMIT_BO_WRITE | \
> -					MSM_SUBMIT_BO_DUMP)
> +					MSM_SUBMIT_BO_DUMP | \
> +					MSM_SUBMIT_BO_NO_IMPLICIT)
>  
>  struct drm_msm_gem_submit_bo {
>  	__u32 flags;          /* in, mask of MSM_SUBMIT_BO_x */
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
