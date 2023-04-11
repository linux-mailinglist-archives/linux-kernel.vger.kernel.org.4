Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5A6DD81B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjDKKnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDKKnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:43:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF1F3C1F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:43:14 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f080fdb924so3211435e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681209793; x=1683801793;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdCFQImNcwIaC8ig2ueHYqJphNr8HsFPvfaTYHnuWiU=;
        b=D/hlliBmXRQ9agP9C9pp/JtXQiusdn0Q18slpFMWofSYerQS6n9TITMsy+InyDmtPr
         ZCSJX2JRObQx9Q/UHQJF42N6YrYuzb105H7HiX2RvoxwM1J42sIEhBckN+6WDe9yavBV
         BUltVSjAJK3e4O4zg7VzAmzdLdW+kKUYhxV5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209793; x=1683801793;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdCFQImNcwIaC8ig2ueHYqJphNr8HsFPvfaTYHnuWiU=;
        b=qm8xGgsgvDbvk3MpFm3z2GcMGWR//kPyInPeRwGmuSWN7i5Yr3lwEjayA1u3z5naA+
         bA5/Df89B3OwB5IRvCKjP2kA2iNr8QUXWsHn41C6nxKuTrY4ck8lhKzZAbXPdLPIsMCS
         IFlq4JQsM4FZttK3oa1SSh4CerS0R5LP6C1VWf+WnUsJtN0uJh9glVhqRK8j+RNdwjkJ
         NWsDqk9uSzXG6gbUj1TX1SyGkPxGw0WE8wBrsi45m9TiHTVbMQHoEu/12NGOSmfDSIJQ
         699vanRgb56T8CmdA2ZlIyNGH1ZtmeVOGgBD91GmEzgywhODd+REJqv711u/db5iwPht
         yOEw==
X-Gm-Message-State: AAQBX9e43Msb/XXzDONuAziPVB0qkBnc8m3gLlksijHaOIS4GTF+s7lV
        yIcSTd+VQ/riSxZAIJrVcAxHcA==
X-Google-Smtp-Source: AKy350YbGULpT1gZF8MvSg6CbB17/Bi8MvulFffq8JcFMUHC1QdvMvKX3mNFhYAkiv82evR9sUpkzA==
X-Received: by 2002:a5d:595a:0:b0:2e4:aa42:7872 with SMTP id e26-20020a5d595a000000b002e4aa427872mr5868131wri.4.1681209792784;
        Tue, 11 Apr 2023 03:43:12 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d4f0b000000b002f27dd92643sm2895514wru.99.2023.04.11.03.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 03:43:12 -0700 (PDT)
Date:   Tue, 11 Apr 2023 12:43:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] drm: Add fdinfo memory stats
Message-ID: <ZDU5vvc4V85E9hqP@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230410210608.1873968-1-robdclark@gmail.com>
 <20230410210608.1873968-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410210608.1873968-2-robdclark@gmail.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 02:06:06PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add a helper to dump memory stats to fdinfo.  For the things the drm
> core isn't aware of, use a callback.
> 
> v2: Fix typos, change size units to match docs, use div_u64
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

Uh can't we wire this up by default? Having this as a per-driver opt-in
sounds like we'll get maximally fragmented drm fd_info, and since that's
uapi I don't think that's any good at all.

I think it's time we have
- drm_fd_info
- rolled out to all drivers in their fops
- with feature checks as appropriate
- push the driver-specific things into a drm_driver callback

And I guess start peopling giving a hard time for making things needless
driver-specifict ... there's really no reason at all this is not
consistent across drivers.
-Daniel

> ---
>  Documentation/gpu/drm-usage-stats.rst | 21 +++++++
>  drivers/gpu/drm/drm_file.c            | 79 +++++++++++++++++++++++++++
>  include/drm/drm_file.h                | 10 ++++
>  3 files changed, 110 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index b46327356e80..b5e7802532ed 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -105,6 +105,27 @@ object belong to this client, in the respective memory region.
>  Default unit shall be bytes with optional unit specifiers of 'KiB' or 'MiB'
>  indicating kibi- or mebi-bytes.
>  
> +- drm-shared-memory: <uint> [KiB|MiB]
> +
> +The total size of buffers that are shared with another file (ie. have more
> +than a single handle).
> +
> +- drm-private-memory: <uint> [KiB|MiB]
> +
> +The total size of buffers that are not shared with another file.
> +
> +- drm-resident-memory: <uint> [KiB|MiB]
> +
> +The total size of buffers that are resident in system memory.
> +
> +- drm-purgeable-memory: <uint> [KiB|MiB]
> +
> +The total size of buffers that are purgeable.
> +
> +- drm-active-memory: <uint> [KiB|MiB]
> +
> +The total size of buffers that are active on one or more rings.
> +
>  - drm-cycles-<str> <uint>
>  
>  Engine identifier string must be the same as the one specified in the
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index a51ff8cee049..085b01842a87 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -42,6 +42,7 @@
>  #include <drm/drm_client.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> +#include <drm/drm_gem.h>
>  #include <drm/drm_print.h>
>  
>  #include "drm_crtc_internal.h"
> @@ -868,6 +869,84 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
>  }
>  EXPORT_SYMBOL(drm_send_event);
>  
> +static void print_size(struct drm_printer *p, const char *stat, size_t sz)
> +{
> +	const char *units[] = {"", " KiB", " MiB"};
> +	unsigned u;
> +
> +	for (u = 0; u < ARRAY_SIZE(units) - 1; u++) {
> +		if (sz < SZ_1K)
> +			break;
> +		sz = div_u64(sz, SZ_1K);
> +	}
> +
> +	drm_printf(p, "%s:\t%zu%s\n", stat, sz, units[u]);
> +}
> +
> +/**
> + * drm_print_memory_stats - Helper to print standard fdinfo memory stats
> + * @file: the DRM file
> + * @p: the printer to print output to
> + * @status: callback to get driver tracked object status
> + *
> + * Helper to iterate over GEM objects with a handle allocated in the specified
> + * file.  The optional status callback can return additional object state which
> + * determines which stats the object is counted against.  The callback is called
> + * under table_lock.  Racing against object status change is "harmless", and the
> + * callback can expect to not race against object destruction.
> + */
> +void drm_print_memory_stats(struct drm_file *file, struct drm_printer *p,
> +			    enum drm_gem_object_status (*status)(struct drm_gem_object *))
> +{
> +	struct drm_gem_object *obj;
> +	struct {
> +		size_t shared;
> +		size_t private;
> +		size_t resident;
> +		size_t purgeable;
> +		size_t active;
> +	} size = {0};
> +	int id;
> +
> +	spin_lock(&file->table_lock);
> +	idr_for_each_entry (&file->object_idr, obj, id) {
> +		enum drm_gem_object_status s = 0;
> +
> +		if (status)
> +			s = status(obj);
> +
> +		if (obj->handle_count > 1) {
> +			size.shared += obj->size;
> +		} else {
> +			size.private += obj->size;
> +		}
> +
> +		if (s & DRM_GEM_OBJECT_RESIDENT) {
> +			size.resident += obj->size;
> +			s &= ~DRM_GEM_OBJECT_PURGEABLE;
> +		}
> +
> +		if (s & DRM_GEM_OBJECT_ACTIVE) {
> +			size.active += obj->size;
> +			s &= ~DRM_GEM_OBJECT_PURGEABLE;
> +		}
> +
> +		if (s & DRM_GEM_OBJECT_PURGEABLE)
> +			size.purgeable += obj->size;
> +	}
> +	spin_unlock(&file->table_lock);
> +
> +	print_size(p, "drm-shared-memory", size.shared);
> +	print_size(p, "drm-private-memory", size.private);
> +
> +	if (status) {
> +		print_size(p, "drm-resident-memory", size.resident);
> +		print_size(p, "drm-purgeable-memory", size.purgeable);
> +		print_size(p, "drm-active-memory", size.active);
> +	}
> +}
> +EXPORT_SYMBOL(drm_print_memory_stats);
> +
>  /**
>   * mock_drm_getfile - Create a new struct file for the drm device
>   * @minor: drm minor to wrap (e.g. #drm_device.primary)
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 0d1f853092ab..7bd8a1374f39 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -41,6 +41,7 @@
>  struct dma_fence;
>  struct drm_file;
>  struct drm_device;
> +struct drm_printer;
>  struct device;
>  struct file;
>  
> @@ -438,6 +439,15 @@ void drm_send_event_timestamp_locked(struct drm_device *dev,
>  				     struct drm_pending_event *e,
>  				     ktime_t timestamp);
>  
> +enum drm_gem_object_status {
> +	DRM_GEM_OBJECT_RESIDENT  = BIT(0),
> +	DRM_GEM_OBJECT_PURGEABLE = BIT(1),
> +	DRM_GEM_OBJECT_ACTIVE    = BIT(2),
> +};
> +
> +void drm_print_memory_stats(struct drm_file *file, struct drm_printer *p,
> +			    enum drm_gem_object_status (*status)(struct drm_gem_object *));
> +
>  struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags);
>  
>  #endif /* _DRM_FILE_H_ */
> -- 
> 2.39.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
