Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F0B62D36E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiKQG3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKQG3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:29:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF1EE022
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:29:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9886B81E98
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020CEC433D6;
        Thu, 17 Nov 2022 06:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668666543;
        bh=2lL2hzaia/cJFGMAWXRGKglaIEpZyNeP9+ahgQNP4kA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c249IZd66Tr+XAm2SsQCHdhz1pBIhYWCzc81bpqF0pv9NC/oJGCZ/1CwjofM/9N9U
         yZdZvpQinoxqQ7JUoKuHEGzZrLOlz7vufcjxKkzuKhENk52HDOrr/9ttoLvi6FJpPW
         rkWtdmUMnQsx26P43tugym2GArfJW2LQmgLG39y4=
Date:   Thu, 17 Nov 2022 07:29:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
Subject: Re: [PATCH 1/7] drm: mark drm.debug-on-dyndbg as BROKEN for now
Message-ID: <Y3XUrOGAV4I7bB3M@kroah.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <20221111221715.563020-1-jim.cromie@gmail.com>
 <20221111221715.563020-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111221715.563020-2-jim.cromie@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 03:17:09PM -0700, Jim Cromie wrote:
> drm.debug-on-dyndbg has a regression, due to a chicken-egg
> initialization problem:
> 
> 1- modprobe i915
>    i915 needs drm.ko, which is loaded 1st
> 
> 2- "modprobe drm drm.debug=0x1ff" (virtual/implied)
>    drm.debug is set post-initialization, from boot-args etc
> 
> 3- `modprobe i915` finishes
> 
> W/O drm.debug-on-dyndbg that just works, because all drm_dbg*
> callsites use drm_debug_enabled() to check __drm_debug & DEM_UT_<CAT>
> before printing.
> 
> But the whole point of drm.debug-on-dyndbg is to avoid that runtime
> test, by enabling (at post-modinit) a static-key at each callsite in
> the just-loaded module.
> 
> And since drm.ko is loaded before all dependent modules, none are
> "just-loaded", and no drm.debug callsites are present yet, except
> those in drm.ko itself.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  drivers/gpu/drm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 34f5a092c99e..0d1e59e6bb7e 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -54,6 +54,7 @@ config DRM_DEBUG_MM
>  config DRM_USE_DYNAMIC_DEBUG
>  	bool "use dynamic debug to implement drm.debug"
>  	default y
> +	depends on BROKEN	# chicken-egg initial enable problem
>  	depends on DRM
>  	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
>  	depends on JUMP_LABEL
> -- 
> 2.38.1

This should go through the drm tree now.  The rest probably should also
go that way and not through my tree as well.

thanks,

greg k-h
