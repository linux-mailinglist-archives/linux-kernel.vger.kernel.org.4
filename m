Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584EA6218E0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiKHP5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbiKHP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:57:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84BB13EB5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:56:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a13so23217520edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSoGsNNzwJCDbWzxRNBKjkhjgMTimL8twfEGhMdFli8=;
        b=Hd5dzIwqWy+aEd7oSwfljuxw0DtlNyX8BDpEiNGBL0+JenoJpAZZbmZAnvtEx4e+H0
         RtKDPUjKnkBFRnsC89h6K0Ko3DkDGrGAnSyWD9JIsdiG/5jYXquR94xk8rB3J0EUalTo
         Lm9XojIMHeRbC8Ff8RnuqG8YF8huwWlqTV7Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSoGsNNzwJCDbWzxRNBKjkhjgMTimL8twfEGhMdFli8=;
        b=fF0AmoS3qJGCoqs7NC8A30KhFtsuIX6ulGu9zgC9zDIKhoZt0xBdWLhxWi9u7w0Ock
         re8czoH4YWNU96h07wkiYejDBiKF1x+7c2umDuLulGDWrwhhSgKAYnd6BRYxpU4U6VwJ
         gcMu4j4BWO1Hh+83zxUymus7zwfXzN8wqCbrcZmXf+nzsJc34cXORkqMHPo9T7qIaZWO
         AwynFfniATp3euyXTU+fDbPNhj0Kkh5348roBFHTEkysIXNDeeFs7z62OlNZV+ZKIFeG
         KtXSgTnjbTVJe5hytS8YflNRvk8WyRc0tunfZER7fH5be3eRrl+CugVBJ8dGnuQX5Rsg
         /mMw==
X-Gm-Message-State: ACrzQf2CKaUkVt5yF3a+Ic6Tfu7idnQo5B0/7ZtMSbRaKWPO1fzD2yfJ
        wufZZQ3hib/dibGqRRXO4MSwGQ==
X-Google-Smtp-Source: AMsMyM4MjkhpuEnAbkQowdMbQZ9VTCKiUzTKDueLsa8+Gya1tpvEj70/wj3qF9DActgf3HlMlCHS6A==
X-Received: by 2002:aa7:c54b:0:b0:463:e966:d30c with SMTP id s11-20020aa7c54b000000b00463e966d30cmr37282931edr.222.1667923014412;
        Tue, 08 Nov 2022 07:56:54 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id m19-20020aa7c493000000b00458dc7e8ecasm5720737edq.72.2022.11.08.07.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:56:53 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:56:51 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc:     Melissa Wen <mwen@igalia.com>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        "Juan A . Suarez" <jasuarez@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/v3d: switch to drmm_mutex_init
Message-ID: <Y2p8QzOMH/nm4IM3@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        Melissa Wen <mwen@igalia.com>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@gmail.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        "Juan A . Suarez" <jasuarez@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221107224656.278135-1-mcanal@igalia.com>
 <20221107224656.278135-2-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107224656.278135-2-mcanal@igalia.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 07:46:55PM -0300, Maíra Canal wrote:
> mutex_init() is supposed to be balanced by a call to mutex_destroy(), but
> this is not currently happening on the v3d driver.
> 
> Considering the introduction of a DRM-managed mutex_init variant, switch
> to drmm_mutex_init.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index b8980440d137..96af1cb5202a 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -10,6 +10,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/uaccess.h>
>  
> +#include <drm/drm_managed.h>
>  #include <drm/drm_syncobj.h>
>  #include <uapi/drm/v3d_drm.h>
>  
> @@ -1075,10 +1076,18 @@ v3d_gem_init(struct drm_device *dev)
>  
>  	spin_lock_init(&v3d->mm_lock);
>  	spin_lock_init(&v3d->job_lock);
> -	mutex_init(&v3d->bo_lock);
> -	mutex_init(&v3d->reset_lock);
> -	mutex_init(&v3d->sched_lock);
> -	mutex_init(&v3d->cache_clean_lock);
> +	ret = drmm_mutex_init(dev, &v3d->bo_lock);
> +	if (ret)
> +		return ret;
> +	ret = drmm_mutex_init(dev, &v3d->reset_lock);
> +	if (ret)
> +		return ret;
> +	ret = drmm_mutex_init(dev, &v3d->sched_lock);
> +	if (ret)
> +		return ret;
> +	ret = drmm_mutex_init(dev, &v3d->cache_clean_lock);
> +	if (ret)
> +		return ret;
>  
>  	/* Note: We don't allocate address 0.  Various bits of HW
>  	 * treat 0 as special, such as the occlusion query counters
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
