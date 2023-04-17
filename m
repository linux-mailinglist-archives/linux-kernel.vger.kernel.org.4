Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF06E3FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDQGhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjDQGhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:37:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7620268F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:37:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f09b4a1527so12639405e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681713458; x=1684305458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7IXIP7q/s1xix6CTRGLAY4yDYB3r1AK2dwz7D/b9OT0=;
        b=dU1FwO7dhUaHNXn6RGmIbU/rngaNzlYPu7YNHW0tTruXITT07QwXjMwPLBNoMoBPTa
         RvsuAHrjxupSsytA/xqHSP4Dkyq4K4YrR8E7aZZH1nEm11lj1wIxIHiY1cw3vOC51yJs
         bXa3kTfwsNkzYptmjqR122WE4nLMnIm+MRw7uBt7Uu6F8VWPvv/551ZtFGbb9LLcVjdt
         80wkACwwMu6h99Li/A2BcG0IL8IMaFaYqWer8wSj139lZl8lMdyHua6ZTvRHGcc7Yu1Z
         FmXCGp0aRgo0Er2EC8n4AxpgcX6xYKvIvY8NR6gXVufDVJDdFnbHn6dc11Xs40tCtVpF
         6Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681713458; x=1684305458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IXIP7q/s1xix6CTRGLAY4yDYB3r1AK2dwz7D/b9OT0=;
        b=UY5oTJVG3pUGP6iWPzYLMYbkNcmSB1hpjNjBmVCZLNupmgmJ/gKCm7ilLdEl7RGSX9
         1eNZfS5O+Jr3oQP5ALxX/TcidIj9vgxaHaFGtj6dNJB2r0gwqUEaER7uJ/Q5x6p2mYUb
         vbVG19z1e8sJRY7o9U+Bx7oajFTMLK+iITHRFt32vuDkgbLNubwOgFmoVDDEj082lRwT
         NlyCGqyfLFcdyhUDwgpQcLNUHD9NicUgVHbNfU2hTsPo2ZJSonoGo8JAt1SeVgxp9u0Y
         NJJkeX16z3e5w48HoqBokfCgYbIXqoJhOO93Y5Vi2bMHFuorrTkYVxjoRQwPnOZDtu+S
         4iCA==
X-Gm-Message-State: AAQBX9frs5dJKkLWaZKQS8k8DjhTJNzSvfii5YP0Y1dMuSy4PqIsC8Mv
        rkkYOKeTf6YWVaeewn4HUExAt1m8eDM=
X-Google-Smtp-Source: AKy350buWo2VHVVEq6fdepidS1aRuqjnGpTyGaTCE7dHduAojZjroCT/mevfzJK86i3SFDde2xa5mQ==
X-Received: by 2002:a5d:6ac7:0:b0:2f0:2cfb:e90e with SMTP id u7-20020a5d6ac7000000b002f02cfbe90emr5218591wrw.17.1681713458143;
        Sun, 16 Apr 2023 23:37:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b002c3f81c51b6sm9595428wrv.90.2023.04.16.23.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 23:37:37 -0700 (PDT)
Date:   Mon, 17 Apr 2023 09:37:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Hongqi Chen <U202112190@hust.edu.cn>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: gma500: psb_drv: add missing unwind goto
Message-ID: <be7cfdac-29bf-47ee-8efa-4a5d06faf165@kili.mountain>
References: <20230417060105.16411-1-U202112190@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417060105.16411-1-U202112190@hust.edu.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 02:01:05PM +0800, Hongqi Chen wrote:
> Smatch reports that missing unwind goto in psb_driver_load().
> drivers/gpu/drm/gma500/psb_drv.c:350 psb_driver_load() warn: missing
> unwind goto?
> 
> psb_driver_unload() and psb_driver_load() exist in correspondence, 
> and psb_driver_unload() should be executed when the psb_do_init() 
> fails to initialize.
> 
> Fixes: 5c49fd3aa0ab ("gma500: Add the core DRM files and headers")
> Signed-off-by: Hongqi Chen <U202112190@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  drivers/gpu/drm/gma500/psb_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> index cd9c73f5a64a..b5a276342129 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -347,7 +347,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
>  
>  	ret = psb_do_init(dev);
>  	if (ret)
> -		return ret;
> +		goto out_err;

This kind of error handling is called One Magical Cleanup Function.
These functions are always buggy.  My instinct is that it's better to
just return directly and leak resources instead of doing whatever
horrible thing psb_driver_unload() does.

Update:  I started to look at the psb_driver_unload() and the first line
is gma_backlight_exit() which will lead to a crash if
backlight_device_register() fails.

Reviewing One Magical Cleanup Function is a waste of time, easier to
just re-write it.

The problem as well is that in olden days if the probe() function failed
you were screwed and so no one cared about error handling and cleanup.
Who cares about the details when the result is the same (dead system).
But these days we return -EPROBE_DEFER which is not a fatal error and
we're supposed to recover from that without crashing.  So on modern
drivers changing the error path from a leak to a crash has a huge
negative impact.

regards,
dan carpenter

