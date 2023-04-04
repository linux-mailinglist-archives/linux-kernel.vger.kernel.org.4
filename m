Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714086D6E45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbjDDUqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbjDDUqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:46:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7AE4C2C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:46:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so135829505edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680641163;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kT23cCkJUnon2KM97SgS7BPPzYe1mYrfR1mV8DBgJo=;
        b=V283pZn5eDouVPigXRqp2+Ek2GVPjy9jfNXP6NRCBPJ1KcCoR3hm40xoVn5sDvctTj
         k+FxbzIdum8MdCV9DwlBZiaxIyNGOJg7WBL7zvVslLVFwUV1JXvQTPMQZVVZrCo6bBNW
         o2yCZdHGMQzv8SooZkJJv5KGSZXBHiaTpA2n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680641163;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0kT23cCkJUnon2KM97SgS7BPPzYe1mYrfR1mV8DBgJo=;
        b=TMSybbE+Y226s0OkITgPJCuULcn0br8/IrDRPcal5NcuMIdmXmDynxFcw0gOV/5z3+
         UnNjH35IJuaP8wWaVBBpX+3xzJhqpLVAxuJqySh5c9WKXqNcGICffcVYPIQaSHWuqAIi
         jtoYPsvm6x8ai2zSBuUHQ9dNhqThMxXLlytt+YEV7aFwzeTU7CpsvWSzgyxvnrCKmUx6
         00iVmyqNNHuUf8Bh+k83pDfCZ3gjqJN/QFLO9aTgVBg491sweVDwB4DHwAhgpYGe7zkx
         V5XxCKPXErVZr9kSsCnYKnb6ZMh/gMqKUpgv78YSZZe4mkTylTS2wS2UROEnIoVXbmw9
         vrOg==
X-Gm-Message-State: AAQBX9eUC8crBcksfYfXbn5rmRMe/v73wAqFj/vhujng+YeDbFs5qg1J
        6X5YhLUOnDDH1rMwAn+FBbN9hw==
X-Google-Smtp-Source: AKy350buhut/rRziDOpqOTB/hCcfUaN6fYIb8Z3wScgzOrvxzehP9oATLJ3DZdG5AypSWSERpIpqTQ==
X-Received: by 2002:a17:906:2dd:b0:949:148d:82c0 with SMTP id 29-20020a17090602dd00b00949148d82c0mr3071078ejk.6.1680641162893;
        Tue, 04 Apr 2023 13:46:02 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id kx6-20020a170907774600b009310d4dece9sm6389443ejc.62.2023.04.04.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:46:02 -0700 (PDT)
Date:   Tue, 4 Apr 2023 22:46:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vblank: Simplify drm_dev_has_vblank()
Message-ID: <ZCyMiERvNHTP45o8@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230403160735.1211468-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403160735.1211468-1-robdclark@gmail.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 09:07:35AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> What does vblank have to do with num_crtcs?  Well, this was technically
> correct, but you'd have to go look at where num_crtcs is initialized to
> understand why.  Lets just replace it with the simpler and more obvious
> check.

If you want to fix this, then I think the right fix is to rename num_crtcs
to be something like num_vblank_crtcs. It's a historical accident back
when vblanks without kms was a thing.

Plan B is someone gets really busy and fixes up the entire vblank mess and
moves it into drm_crtc struct. Now that the dri1 drivers are gone we could
indeed do that.

Or maybe instead a patch to improve the kerneldoc for drm_dev->num_crtc?
-Daniel

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/drm_vblank.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 877e2067534f..ad34c235d853 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -575,7 +575,7 @@ EXPORT_SYMBOL(drm_vblank_init);
>   */
>  bool drm_dev_has_vblank(const struct drm_device *dev)
>  {
> -	return dev->num_crtcs != 0;
> +	return !!dev->vblank;
>  }
>  EXPORT_SYMBOL(drm_dev_has_vblank);
>  
> -- 
> 2.39.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
