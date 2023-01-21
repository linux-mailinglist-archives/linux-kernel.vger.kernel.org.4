Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE9B67639D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 05:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjAUEB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 23:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjAUEBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 23:01:50 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2327687
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 20:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674273709; x=1705809709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vD/Ve1nwrwqAAg8Tpgetd8FB3iEsTZOQYNqwUJDbm80=;
  b=n7tNGnkSmsZeVP8RL0QRCd5UWIy2pLL2uQq/441Bsd/Mdtr0eFRwmtI4
   wT0YhHx4IbH7xg68030gOWISvy2nUTFo0NDu7I5ZOr+AbuNMedKgszCWv
   KgSIirqUMA6qxfKpdp3YQY7rkkQt5i7fo148rxRDd1uydErC+9LuHMr33
   khIQQXDTPuSRSb/bHWmroLZYKuHxR8rSOHKzoqYoPVBnWmKLN85g6jlC1
   BkxZMQZFnY9SQajDOkqFqhjTk697aU9XTpSkrU8KBJfUcK5rawbPHMfxc
   A+ptkYqDMk13Kk93LiztneRrmMLQuYgDMK7B8kaZiIWLqsDwhZpw194hz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="323444176"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="323444176"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 20:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="660824113"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="660824113"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Jan 2023 20:01:46 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ54c-0003O0-0X;
        Sat, 21 Jan 2023 04:01:46 +0000
Date:   Sat, 21 Jan 2023 12:00:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/fb-helper: Use a per-driver FB deferred I/O
 handler
Message-ID: <202301211139.vzFLFznY-lkp@intel.com>
References: <20230120120822.2536032-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120120822.2536032-4-javierm@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

I love your patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.2-rc4 next-20230120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Martinez-Canillas/fbdev-Remove-unused-struct-fb_deferred_io-first_io-field/20230120-201143
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230120120822.2536032-4-javierm%40redhat.com
patch subject: [PATCH 3/3] drm/fb-helper: Use a per-driver FB deferred I/O handler
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230121/202301211139.vzFLFznY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/21185713f8ccb3dc34c91fcecff9464c4a8790fa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Javier-Martinez-Canillas/fbdev-Remove-unused-struct-fb_deferred_io-first_io-field/20230120-201143
        git checkout 21185713f8ccb3dc34c91fcecff9464c4a8790fa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_modeset_helper.c:24:
>> include/drm/drm_fb_helper.h:215:31: error: field 'fbdefio' has incomplete type
     215 |         struct fb_deferred_io fbdefio;
         |                               ^~~~~~~


vim +/fbdefio +215 include/drm/drm_fb_helper.h

   103	
   104	/**
   105	 * struct drm_fb_helper - main structure to emulate fbdev on top of KMS
   106	 * @fb: Scanout framebuffer object
   107	 * @dev: DRM device
   108	 * @funcs: driver callbacks for fb helper
   109	 * @info: emulated fbdev device info struct
   110	 * @pseudo_palette: fake palette of 16 colors
   111	 * @damage_clip: clip rectangle used with deferred_io to accumulate damage to
   112	 *                the screen buffer
   113	 * @damage_lock: spinlock protecting @damage_clip
   114	 * @damage_work: worker used to flush the framebuffer
   115	 * @resume_work: worker used during resume if the console lock is already taken
   116	 *
   117	 * This is the main structure used by the fbdev helpers. Drivers supporting
   118	 * fbdev emulation should embedded this into their overall driver structure.
   119	 * Drivers must also fill out a &struct drm_fb_helper_funcs with a few
   120	 * operations.
   121	 */
   122	struct drm_fb_helper {
   123		/**
   124		 * @client:
   125		 *
   126		 * DRM client used by the generic fbdev emulation.
   127		 */
   128		struct drm_client_dev client;
   129	
   130		/**
   131		 * @buffer:
   132		 *
   133		 * Framebuffer used by the generic fbdev emulation.
   134		 */
   135		struct drm_client_buffer *buffer;
   136	
   137		struct drm_framebuffer *fb;
   138		struct drm_device *dev;
   139		const struct drm_fb_helper_funcs *funcs;
   140		struct fb_info *info;
   141		u32 pseudo_palette[17];
   142		struct drm_clip_rect damage_clip;
   143		spinlock_t damage_lock;
   144		struct work_struct damage_work;
   145		struct work_struct resume_work;
   146	
   147		/**
   148		 * @lock:
   149		 *
   150		 * Top-level FBDEV helper lock. This protects all internal data
   151		 * structures and lists, such as @connector_info and @crtc_info.
   152		 *
   153		 * FIXME: fbdev emulation locking is a mess and long term we want to
   154		 * protect all helper internal state with this lock as well as reduce
   155		 * core KMS locking as much as possible.
   156		 */
   157		struct mutex lock;
   158	
   159		/**
   160		 * @kernel_fb_list:
   161		 *
   162		 * Entry on the global kernel_fb_helper_list, used for kgdb entry/exit.
   163		 */
   164		struct list_head kernel_fb_list;
   165	
   166		/**
   167		 * @delayed_hotplug:
   168		 *
   169		 * A hotplug was received while fbdev wasn't in control of the DRM
   170		 * device, i.e. another KMS master was active. The output configuration
   171		 * needs to be reprobe when fbdev is in control again.
   172		 */
   173		bool delayed_hotplug;
   174	
   175		/**
   176		 * @deferred_setup:
   177		 *
   178		 * If no outputs are connected (disconnected or unknown) the FB helper
   179		 * code will defer setup until at least one of the outputs shows up.
   180		 * This field keeps track of the status so that setup can be retried
   181		 * at every hotplug event until it succeeds eventually.
   182		 *
   183		 * Protected by @lock.
   184		 */
   185		bool deferred_setup;
   186	
   187		/**
   188		 * @preferred_bpp:
   189		 *
   190		 * Temporary storage for the driver's preferred BPP setting passed to
   191		 * FB helper initialization. This needs to be tracked so that deferred
   192		 * FB helper setup can pass this on.
   193		 *
   194		 * See also: @deferred_setup
   195		 */
   196		int preferred_bpp;
   197	
   198		/**
   199		 * @hint_leak_smem_start:
   200		 *
   201		 * Hint to the fbdev emulation to store the framebuffer's physical
   202		 * address in struct &fb_info.fix.smem_start. If the hint is unset,
   203		 * the smem_start field should always be cleared to zero.
   204		 */
   205		bool hint_leak_smem_start;
   206	
   207		/**
   208		 * @fbdefio:
   209		 *
   210		 * Temporary storage for the driver's FB deferred I/O handler. If the
   211		 * driver uses the DRM fbdev emulation layer, this is set by the core
   212		 * to a generic deferred I/O handler if a driver is preferring to use
   213		 * a shadow buffer.
   214		 */
 > 215		struct fb_deferred_io fbdefio;
   216	};
   217	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
