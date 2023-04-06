Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DF16D94BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjDFLLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDFLLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:11:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD5972A0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:11:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-502208f7cb3so123922a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680779493;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvTlgXTtg2muM6L0bWnwM1nd3k3pfGEtq3SLskOcEH4=;
        b=Q7sbebb1085YqmJMre2lc3cnUIyqmALLCXpED1jXpDlet+AKsLNF++if93FQRKmy0o
         DiUYN18JR3m53dV51E6FzIskatHt8r9nUI9TANyhpyf2BZNRpU6Ff7FOhiwNMCdEou7w
         QDXgKfRjYOFyCloYSJ44VM5YQvngC+yvInI0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680779493;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvTlgXTtg2muM6L0bWnwM1nd3k3pfGEtq3SLskOcEH4=;
        b=HUk1Auzd2hvkfLDqHZmyK8NdYsujChnILcqtYN+Ad5HWnCxMxCg3mEuGWjJgjA61eJ
         5PcnsOSliKX49UWFIRVOOUYDXv1GQmqyk7uPOrKnmIcO3i9HrRMeOJsiicNgSphVyxO/
         6++OEaWSjrXF1MrQKsDO+YeKgQ4bDwOxsazcB5IPH3G1XxTzf5EvPbC2rJQgwE/g0JtY
         BnL6lNxz094dC3LZPygn/RfjrBsGZKyEZS43rwAscjkNDFM69GFomaNvSuebVNKspIJ7
         dSvehcUVg4+KYEEana7zRK9aYDpW8lDv4eWtI2WUHs53LqRf2HI0jM3gO2UlzId5noqu
         juig==
X-Gm-Message-State: AAQBX9fSQ8E2StMDR8ejX0PaNNHfHg2342mu3GERaEi31NwkiMo0gPrD
        5oaj4ST/sHpgSqBcsTPU6rEjHQ==
X-Google-Smtp-Source: AKy350auhtgCzPObUrGlRmtHRAgcyfLCC/RuuO9vsiy2uaAlw7Q65OjzJxcLE9tG5F5SmSt+4fIuMA==
X-Received: by 2002:a17:906:2d7:b0:949:148d:82c0 with SMTP id 23-20020a17090602d700b00949148d82c0mr3456530ejk.6.1680779492975;
        Thu, 06 Apr 2023 04:11:32 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id mm25-20020a170906cc5900b0093e9fb91837sm680541ejb.76.2023.04.06.04.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:11:32 -0700 (PDT)
Date:   Thu, 6 Apr 2023 13:11:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        Marius Vlad <marius.vlad@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/vkms: Drop vkms_connector_destroy() wrapper
Message-ID: <ZC6o4l7tzSIwFTKw@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        Marius Vlad <marius.vlad@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20230406110235.3092055-1-javierm@redhat.com>
 <20230406110235.3092055-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406110235.3092055-2-javierm@redhat.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 01:02:34PM +0200, Javier Martinez Canillas wrote:
> This helper is just a wrapper that calls drm_connector_cleanup(), there's
> no need to have another level of indirection.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

On both patches:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Aside, would be a nice cleanup to move vkms output stuff (crtc and
connector) over to the drmm_ stuff. The plane already does that.

That should also simplify the multi-output work.
-Daniel

> ---
> 
>  drivers/gpu/drm/vkms/vkms_output.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 991857125bb4..4de6f8ae38be 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -6,14 +6,9 @@
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
>  
> -static void vkms_connector_destroy(struct drm_connector *connector)
> -{
> -	drm_connector_cleanup(connector);
> -}
> -
>  static const struct drm_connector_funcs vkms_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.destroy = vkms_connector_destroy,
> +	.destroy = drm_connector_cleanup,
>  	.reset = drm_atomic_helper_connector_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> -- 
> 2.40.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
