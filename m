Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8FF6DD4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDKHyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjDKHyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:54:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584B2A4;
        Tue, 11 Apr 2023 00:54:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5068466031E2;
        Tue, 11 Apr 2023 08:54:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681199676;
        bh=X5FXAGQ1m/4RCqH9j/r3vyunBli9jNcGliIagj4A9cs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U+yVRMwKKR3Vkq9p6ta2qsvpVTxDrdCDJ0n7K6B/z+mLWszol+ZnKjaauz3VmYAca
         NcnI4+5mmVN9Dz8DOGpALGePw98NqqlsKGMdui5PYjT06spn8j9MrmVm/rZhGIKhQj
         hlwrrkGFyJygHwJVP1shyY553W8hJMV4rzsjSVmXkba95Mw7In6EEupaMWiyalt4b4
         NmAGla243GyIgIAHJ4QFddVMQWzvvVRPLRVSCm2YJuxxeSVghD7p5uppnq2k1kdBWa
         GHdvPAbIV6XFyGiuwmBU0slzxEvYF0Ji1BaZj+0yhpz0dglNfDyY9BtbSMUBSUCchc
         c8rZP56V4KyCg==
Date:   Tue, 11 Apr 2023 09:54:33 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC 1/2] drm: Add fdinfo memory stats
Message-ID: <20230411095433.243a256c@collabora.com>
In-Reply-To: <20230406215917.1475704-2-robdclark@gmail.com>
References: <20230406215917.1475704-1-robdclark@gmail.com>
 <20230406215917.1475704-2-robdclark@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu,  6 Apr 2023 14:59:16 -0700
Rob Clark <robdclark@gmail.com> wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> Add a helper to dump memory stats to fdinfo.  For the things the drm
> core isn't aware of, use a callback.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  Documentation/gpu/drm-usage-stats.rst | 21 +++++++
>  drivers/gpu/drm/drm_file.c            | 79 +++++++++++++++++++++++++++
>  include/drm/drm_file.h                | 10 ++++
>  3 files changed, 110 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index b46327356e80..56e3c95b6e0a 100644
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
> +The total size of buffers that are purgable.
> +
> +- drm-active-memory: <uint> [KiB|MiB]
> +
> +The total size of buffers that are active on one or more rings.
> +
>  - drm-cycles-<str> <uint>
>  
>  Engine identifier string must be the same as the one specified in the
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index a51ff8cee049..21911d6ff38d 100644
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
> +	const char *units[] = {"B", "KiB", "MiB", "GiB"};
> +	unsigned u;
> +
> +	for (u = 0; u < ARRAY_SIZE(units) - 1; u++) {
> +		if (sz < SZ_1K)
> +			break;
> +		sz /= SZ_1K;
> +	}
> +
> +	drm_printf(p, "%s:\t%lu %s\n", stat, sz, units[u]);
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
> + * callback can expect to not race against object destroy.
> + */
> +void drm_print_memory_stats(struct drm_file *file, struct drm_printer *p,
> +			    enum drm_gem_object_status (*status)(struct drm_gem_object *))

Nit: status() returning an 'enum drm_gem_object_status' makes it look
like it can only return one of the DRM_GEM_OBJECT_* flag, when it can
actually be a combination of flags. Should we make it return an u32
instead? At the very least this should be clarified in the function doc.

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

Should we assume that all users of this drm_print_memory_stats() helper
support tracking all these non-standard stats as soon as they provide a
status callback? If not, we should probably not print the
`drm-xxx-memory` line when the driver is not tracking this state (can
be done with a 'supported_status' mask passed to
drm_print_memory_stats()).

Other than these 2 minor things, I think it's a perfect match for
panfrost mem-tracking, and I certainly intend to use this helper in
panfrost.

Thanks,

Boris
