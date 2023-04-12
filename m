Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF76DED28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDLIB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:01:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AE765A5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:01:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f04eb5d1a7so5783535e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681286499; x=1683878499;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usxsIwPfR/jBzt5G755oCQZvTnpW/1OqLJBWqcv6Qrk=;
        b=OtKWUa6jI0KcBLBN3oD/q3av8J2pqFdx1JTLgdBG/HriWtRXeWNVb/JHI0KA+Z7a43
         8SRpNeETcy/f6jwiRngK3D+i/VqMZ6bPSuJBrSR28FH4ehBYbjVEcaMO+EFZkPQGBXRq
         PdUFY8fmukqBYaBeiHzQ03DzQdJ09koE4/SUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681286499; x=1683878499;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usxsIwPfR/jBzt5G755oCQZvTnpW/1OqLJBWqcv6Qrk=;
        b=txuYJkxb1YVlQEOugNBYw55YY1K6xcaOckj+NS+x9LOGXbMBzAtj8TMtEI0B6HEjgW
         v1h1Lfhec4ExAuXQy4DxzZYhAuWpyZIwF34m1IUKzSi03uKHKewUkMCk3ZK84koI6gEA
         eSBWvxlA3F9+jZM30JHscCF+VAHcpSPRZ0mg8ZAd+mUhbY1VGMk5fbhGFPErIZuXhqmr
         8hx8FrJpWksNhvGoVfhgx1JDE6XHeEF5M8UuHG3Ik54fJRSLCWHwL3nM2+d0URfX8goy
         ujFuvcfMKtsMGn+Bg7z9hFA5cDOmSw+TfQWMycatRSCYuPWxKW8Cz9yWGn1KvMhaDDP3
         scTg==
X-Gm-Message-State: AAQBX9f3OC0bYyeS1eoypC0tz39b/tf5T2ZE0AKA5ov4Xj40NXbCiueo
        IVhO93hm4nkoyStqwV9flB+Kwg==
X-Google-Smtp-Source: AKy350ZEQ50V1V6HKttuUaO/U1mjlGEseB0SYTVz6qfuzfynrOwUlXAMSCL53PHfomXoeTjzBcMvww==
X-Received: by 2002:a05:6000:1050:b0:2f0:843:fc0d with SMTP id c16-20020a056000105000b002f00843fc0dmr5705190wrx.5.1681286498852;
        Wed, 12 Apr 2023 01:01:38 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d5451000000b002f3fcb1869csm1862512wrv.64.2023.04.12.01.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 01:01:38 -0700 (PDT)
Date:   Wed, 12 Apr 2023 10:01:36 +0200
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
Subject: Re: [PATCH v3 6/7] drm: Add fdinfo memory stats
Message-ID: <ZDZlYNN/LEdUxZgP@phenom.ffwll.local>
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
References: <20230411225725.2032862-1-robdclark@gmail.com>
 <20230411225725.2032862-7-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411225725.2032862-7-robdclark@gmail.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:56:11PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add support to dump GEM stats to fdinfo.
> 
> v2: Fix typos, change size units to match docs, use div_u64
> v3: Do it in core
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> ---
>  Documentation/gpu/drm-usage-stats.rst | 21 ++++++++
>  drivers/gpu/drm/drm_file.c            | 76 +++++++++++++++++++++++++++
>  include/drm/drm_file.h                |  1 +
>  include/drm/drm_gem.h                 | 19 +++++++
>  4 files changed, 117 insertions(+)
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
> index 37dfaa6be560..46fdd843bb3a 100644
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
> @@ -871,6 +872,79 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
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
> +static void print_memory_stats(struct drm_printer *p, struct drm_file *file)
> +{
> +	struct drm_gem_object *obj;
> +	struct {
> +		size_t shared;
> +		size_t private;
> +		size_t resident;
> +		size_t purgeable;
> +		size_t active;
> +	} size = {0};
> +	bool has_status = false;
> +	int id;
> +
> +	spin_lock(&file->table_lock);
> +	idr_for_each_entry (&file->object_idr, obj, id) {
> +		enum drm_gem_object_status s = 0;
> +
> +		if (obj->funcs && obj->funcs->status) {
> +			s = obj->funcs->status(obj);
> +			has_status = true;
> +		}
> +
> +		if (obj->handle_count > 1) {
> +			size.shared += obj->size;
> +		} else {
> +			size.private += obj->size;
> +		}
> +
> +		if (s & DRM_GEM_OBJECT_RESIDENT) {
> +			size.resident += obj->size;
> +		} else {
> +			/* If already purged or not yet backed by pages, don't
> +			 * count it as purgeable:
> +			 */
> +			s &= ~DRM_GEM_OBJECT_PURGEABLE;
> +		}
> +
> +		if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(true))) {
> +			size.active += obj->size;
> +
> +			/* If still active, don't count as purgeable: */

Maybe mention this in the kerneldoc for DRM_GEM_OBJECT_PURGEABLE?

Otherwise looks tidy:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

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
> +	print_size(p, "drm-active-memory", size.active);
> +
> +	if (has_status) {
> +		print_size(p, "drm-resident-memory", size.resident);
> +		print_size(p, "drm-purgeable-memory", size.purgeable);
> +	}
> +}
> +
>  /**
>   * drm_fop_show_fdinfo - helper for drm file fops
>   * @seq_file: output stream
> @@ -904,6 +978,8 @@ void drm_fop_show_fdinfo(struct seq_file *m, struct file *f)
>  
>  	if (dev->driver->show_fdinfo)
>  		dev->driver->show_fdinfo(&p, file);
> +
> +	print_memory_stats(&p, file);
>  }
>  EXPORT_SYMBOL(drm_fop_show_fdinfo);
>  
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index dfa995b787e1..e5b40084538f 100644
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
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 189fd618ca65..213917bb6b11 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -42,6 +42,14 @@
>  struct iosys_map;
>  struct drm_gem_object;
>  
> +/**
> + * enum drm_gem_object_status - bitmask of object state for fdinfo reporting
> + */
> +enum drm_gem_object_status {
> +	DRM_GEM_OBJECT_RESIDENT  = BIT(0),
> +	DRM_GEM_OBJECT_PURGEABLE = BIT(1),
> +};
> +
>  /**
>   * struct drm_gem_object_funcs - GEM object functions
>   */
> @@ -174,6 +182,17 @@ struct drm_gem_object_funcs {
>  	 */
>  	int (*evict)(struct drm_gem_object *obj);
>  
> +	/**
> +	 * @status:
> +	 *
> +	 * The optional status callback can return additional object state
> +	 * which determines which stats the object is counted against.  The
> +	 * callback is called under table_lock.  Racing against object status
> +	 * change is "harmless", and the callback can expect to not race
> +	 * against object destruction.
> +	 */
> +	enum drm_gem_object_status (*status)(struct drm_gem_object *obj);
> +
>  	/**
>  	 * @vm_ops:
>  	 *
> -- 
> 2.39.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
