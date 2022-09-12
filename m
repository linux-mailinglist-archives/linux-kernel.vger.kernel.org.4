Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6919F5B5878
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiILKbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiILKau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:30:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6D63AB0C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662978617; x=1694514617;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sJEYOR48olYIUwiQngpqfZYVkj4K0IWejtNVYlou12k=;
  b=f+IzHdavmI8iiJbRzL3hAK8NBvx0eN21/soaYMzlqDfM7euE1+hZqBKw
   EyPLFxL/RfWS5K3Aikedh8KusCazFw7eKAcISgbgl11uZ6WQYhKNoTqiM
   0CNLcSwRZU5QH/rpJzn8rDv2RT5w6dxF7M4zyQlp5Ppr6MKOEPrzD5YPC
   z73M1C2ZkzpXOD1oM+3u1c2DssTccWAPnRS1w4L6o8k/2jCCKtwE07No8
   YbwBfwfqu3c32IFn5u6xxdDt3n0ReveKZ4JTXNUl0DgAHgVsllfh7mga+
   AP+4zIzyAQo7orBUPhFUv+v3svmoLXOaly7qSZcbkKEqwJOOGwMcLI3as
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="324063668"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324063668"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:29:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="678031309"
Received: from abijaz-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:29:45 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, linux@rasmusvillemoes.dk,
        seanpaul@chromium.org, joe@perches.com
Subject: Re: [PATCH v7 2/9] drm: POC drm on dyndbg - use in core, 2 helpers,
 3 drivers.
In-Reply-To: <20220912052852.1123868-3-jim.cromie@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <20220912052852.1123868-3-jim.cromie@gmail.com>
Date:   Mon, 12 Sep 2022 13:29:42 +0300
Message-ID: <87pmg06g2x.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2022, Jim Cromie <jim.cromie@gmail.com> wrote:
> Use DECLARE_DYNDBG_CLASSMAP across DRM:
>
>  - in .c files, since macro defines/initializes a record
>
>  - in drivers, $mod_{drv,drm,param}.c
>    ie where param setup is done, since a classmap is param related
>
>  - in drm/drm_print.c
>    since existing __drm_debug param is defined there,
>    and we ifdef it, and provide an elaborated alternative.
>
>  - in drm_*_helper modules:
>    dp/drm_dp - 1st item in makefile target
>    drivers/gpu/drm/drm_crtc_helper.c - random pick iirc.
>
> Since these modules all use identical CLASSMAP declarations (ie: names
> and .class_id's) they will all respond together to "class DRM_UT_*"
> query-commands:
>
>   :#> echo class DRM_UT_KMS +p > /proc/dynamic_debug/control
>
> NOTES:
>
> This changes __drm_debug from int to ulong, so BIT() is usable on it.
>
> DRM's enum drm_debug_category values need to sync with the index of
> their respective class-names here.  Then .class_id == category, and
> dyndbg's class FOO mechanisms will enable drm_dbg(DRM_UT_KMS, ...).
>
> Though DRM needs consistent categories across all modules, thats not
> generally needed; modules X and Y could define FOO differently (ie a
> different NAME => class_id mapping), changes are made according to
> each module's private class-map.
>
> No callsites are actually selected by this patch, since none are
> class'd yet.

The commit message could start off by saying each module needs to define
DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, ...). That is, IIUC.

Where's DECLARE_DYNDBG_CLASSMAP defined? linux-next? What's it do? What
if multiple modules with that are actually builtin?

The duplication and requirement that they're identical seems like an
error prone combo.

Finally, the choice of placement in e.g. i915_params.c seems completely
arbitrary, and makes you wonder "what here requires this, nothing?".

BR,
Jani.


>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 +++++++++++++
>  drivers/gpu/drm/display/drm_dp_helper.c | 13 ++++++++++++
>  drivers/gpu/drm/drm_crtc_helper.c       | 13 ++++++++++++
>  drivers/gpu/drm/drm_print.c             | 27 +++++++++++++++++++++++--
>  drivers/gpu/drm/i915/i915_params.c      | 12 +++++++++++
>  drivers/gpu/drm/nouveau/nouveau_drm.c   | 13 ++++++++++++
>  include/drm/drm_print.h                 |  3 ++-
>  7 files changed, 92 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 429fcdf28836..5f091cb52de2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -38,6 +38,8 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/suspend.h>
>  #include <linux/cc_platform.h>
> +#include <linux/fb.h>
> +#include <linux/dynamic_debug.h>
>  
>  #include "amdgpu.h"
>  #include "amdgpu_irq.h"
> @@ -185,6 +187,18 @@ int amdgpu_vcnfw_log;
>  
>  static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
>  
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
>  struct amdgpu_mgpu_info mgpu_info = {
>  	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
>  	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index e5bab236b3ae..196dfb1e8d87 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -30,6 +30,7 @@
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
>  #include <linux/string_helpers.h>
> +#include <linux/dynamic_debug.h>
>  
>  #include <drm/display/drm_dp_helper.h>
>  #include <drm/display/drm_dp_mst_helper.h>
> @@ -40,6 +41,18 @@
>  
>  #include "drm_dp_helper_internal.h"
>  
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
>  struct dp_aux_backlight {
>  	struct backlight_device *base;
>  	struct drm_dp_aux *aux;
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> index 8a6d54515f92..a8cee6694cf6 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -32,6 +32,7 @@
>  #include <linux/export.h>
>  #include <linux/kernel.h>
>  #include <linux/moduleparam.h>
> +#include <linux/dynamic_debug.h>
>  
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> @@ -51,6 +52,18 @@
>  
>  #include "drm_crtc_helper_internal.h"
>  
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
>  /**
>   * DOC: overview
>   *
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index f783d4963d4b..ec32df35a3e3 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -40,7 +40,7 @@
>   * __drm_debug: Enable debug output.
>   * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
>   */
> -unsigned int __drm_debug;
> +unsigned long __drm_debug;
>  EXPORT_SYMBOL(__drm_debug);
>  
>  MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
> @@ -52,7 +52,30 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
>  "\t\tBit 5 (0x20)  will enable VBL messages (vblank code)\n"
>  "\t\tBit 7 (0x80)  will enable LEASE messages (leasing code)\n"
>  "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
> -module_param_named(debug, __drm_debug, int, 0600);
> +
> +#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
> +module_param_named(debug, __drm_debug, ulong, 0600);
> +#else
> +/* classnames must match vals of enum drm_debug_category */
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
> +static struct ddebug_class_param drm_debug_bitmap = {
> +	.bits = &__drm_debug,
> +	.flags = "p",
> +	.map = &drm_debug_classes,
> +};
> +module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
> +#endif
>  
>  void __drm_puts_coredump(struct drm_printer *p, const char *str)
>  {
> diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
> index 6fc475a5db61..d1e4d528cb17 100644
> --- a/drivers/gpu/drm/i915/i915_params.c
> +++ b/drivers/gpu/drm/i915/i915_params.c
> @@ -29,6 +29,18 @@
>  #include "i915_params.h"
>  #include "i915_drv.h"
>  
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
>  #define i915_param_named(name, T, perm, desc) \
>  	module_param_named(name, i915_modparams.name, T, perm); \
>  	MODULE_PARM_DESC(name, desc)
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 561309d447e0..fd99ec0f4257 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -28,6 +28,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/vga_switcheroo.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/dynamic_debug.h>
>  
>  #include <drm/drm_aperture.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -70,6 +71,18 @@
>  #include "nouveau_svm.h"
>  #include "nouveau_dmem.h"
>  
> +DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> +			"DRM_UT_CORE",
> +			"DRM_UT_DRIVER",
> +			"DRM_UT_KMS",
> +			"DRM_UT_PRIME",
> +			"DRM_UT_ATOMIC",
> +			"DRM_UT_VBL",
> +			"DRM_UT_STATE",
> +			"DRM_UT_LEASE",
> +			"DRM_UT_DP",
> +			"DRM_UT_DRMRES");
> +
>  MODULE_PARM_DESC(config, "option string to pass to driver core");
>  static char *nouveau_config;
>  module_param_named(config, nouveau_config, charp, 0400);
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index b3b470440e46..668273e36c2c 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -35,7 +35,7 @@
>  #include <drm/drm.h>
>  
>  /* Do *not* use outside of drm_print.[ch]! */
> -extern unsigned int __drm_debug;
> +extern unsigned long __drm_debug;
>  
>  /**
>   * DOC: print
> @@ -275,6 +275,7 @@ static inline struct drm_printer drm_err_printer(const char *prefix)
>   *
>   */
>  enum drm_debug_category {
> +	/* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
>  	/**
>  	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
>  	 * drm_memory.c, ...

-- 
Jani Nikula, Intel Open Source Graphics Center
