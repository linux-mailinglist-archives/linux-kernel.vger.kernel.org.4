Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDAE7120C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbjEZHSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEZHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:18:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343399
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:17:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so4477775e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685085477; x=1687677477;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ccYNkSB9yXNFc0pNcevL4BywfT3cjPwDcQMS5hYjY5A=;
        b=upk6XEp7pKdAdaE6HpwR/flUdXcgSnj7QESN26X5BQS21Ly7Tn2Kg6FF1+xUSO0DIg
         rnR6531U8ajhEcFTYhM5f3+bMqEj1vnygeCGpwJ++u8Zc1PBnixfyCACy2bSGhKQfuKX
         hv+7nhfex5xD9fOYnlV1YnyxizfBhcVaLB7/xtuNWR7+8baORFbvCZGenLg2+LzDRsm+
         zgXNe4qhCOpXSjmvvceSp2wsv6vdBEdCojgDcTkAAYSiE/iDaHbRVNJN2BaoSRxfW1TT
         ipP8Z+7wOKRzxYdwhUgkmuE8WsXZUe8MX3SvCnFQo143yaB7hGIOmJbDvNrtu1v27s6I
         Os+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685085477; x=1687677477;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccYNkSB9yXNFc0pNcevL4BywfT3cjPwDcQMS5hYjY5A=;
        b=QqrSJx/ZOo6ZZWzGA7FD6LAbouWWpvdZL2c8kD667vlw9FgBfeaQPwdu4pM32eF5mj
         F0ddiM8eJQ6TJnYPZO7feuWnJjVEIedKgGo3wDuEbDRATEr0aWbZ4tQIOkVWeSxEHvHZ
         JzyDIYOYBNcdeA0QPwwXraKHICcnM7DdXcAv5umoIrBRbcF9Vtorf5VeN4VHShLUgxlY
         PtEV9qQgPqHVeybdItLmPBhB5mxy1T/THBTQftxB56m3Mi7DP+LkwzoI6GTTyjuIWwm5
         VLXXSEg6Iy6FHuSs7q8mW8DrMYFFURXKBd3tRWytOJ0gOy6h4gXU2Uc3U/x36YvpmsQH
         BzXg==
X-Gm-Message-State: AC+VfDzmm7QduiG8JHVbT5Ow27y34jUyjAHiNRJbaV9X6Tf1nJ/3QRRL
        2IcekthBhYQzH3zqjtbvnBsgVQ==
X-Google-Smtp-Source: ACHHUZ7pZtbrAhMxd6iWleR200RM6mvanIpgkNTpR5s75pyuJh/4bcbqfdyd+rbo3dVfFEZazKD4jA==
X-Received: by 2002:a05:600c:2310:b0:3f6:a92:57e with SMTP id 16-20020a05600c231000b003f60a92057emr821751wmo.20.1685085476727;
        Fri, 26 May 2023 00:17:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d9:4dfb:95d6:f5a0? ([2a01:e0a:982:cbb0:15d9:4dfb:95d6:f5a0])
        by smtp.gmail.com with ESMTPSA id s26-20020a7bc39a000000b003f42328b5d9sm4239806wmj.39.2023.05.26.00.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 00:17:56 -0700 (PDT)
Message-ID: <a24cecc0-ade2-b438-f2bb-0b1ab830be01@linaro.org>
Date:   Fri, 26 May 2023 09:17:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/amdgpu: Remove duplicate fdinfo fields
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230525155227.560094-1-robdclark@gmail.com>
 <20230525155227.560094-2-robdclark@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230525155227.560094-2-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 25/05/2023 17:52, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Some of the fields that are handled by drm_show_fdinfo() crept back in
> when rebasing the patch.  Remove them again.
> 
> Fixes: 376c25f8ca47 ("drm/amdgpu: Switch to fdinfo helper")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index 13d7413d4ca3..a93e5627901a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -80,23 +80,20 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   
>   	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
>   
>   	/*
>   	 * ******************************************************************
>   	 * For text output format description please see drm-usage-stats.rst!
>   	 * ******************************************************************
>   	 */
>   
>   	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
> -	drm_printf(p, "drm-driver:\t%s\n", file->minor->dev->driver->name);
> -	drm_printf(p, "drm-pdev:\t%04x:%02x:%02x.%d\n", domain, bus, dev, fn);
> -	drm_printf(p, "drm-client-id:\t%Lu\n", vm->immediate.fence_context);
>   	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
>   	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
>   	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
>   	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
>   		   stats.visible_vram/1024UL);
>   	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
>   		   stats.evicted_vram/1024UL);
>   	drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
>   		   stats.evicted_visible_vram/1024UL);
>   	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",

I got:
drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c: In function ‘amdgpu_show_fdinfo’:
drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c:64:32: error: variable ‘domain’ set but not used [-Werror=unused-but-set-variable]
    64 |         uint32_t bus, dev, fn, domain;
       |                                ^~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c:64:28: error: variable ‘fn’ set but not used [-Werror=unused-but-set-variable]
    64 |         uint32_t bus, dev, fn, domain;
       |                            ^~
drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c:64:23: error: variable ‘dev’ set but not used [-Werror=unused-but-set-variable]
    64 |         uint32_t bus, dev, fn, domain;
       |                       ^~~
drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c:64:18: error: variable ‘bus’ set but not used [-Werror=unused-but-set-variable]
    64 |         uint32_t bus, dev, fn, domain;

after applying patch 2, can you fix it ? Seems you can keep the drm-pdev print line

I applied patch 1

Thanks,
Neil
