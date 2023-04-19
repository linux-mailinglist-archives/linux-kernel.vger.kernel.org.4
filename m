Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954CB6E7133
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjDSCnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDSCna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:43:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD639619B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 19:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681872207; x=1713408207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ljxSHJURgT27vKhSROYonyITA0KaHaRnept4ArbLVcM=;
  b=Mo16PsWRgGbS8GFghd8Df4tGNnLu99AGzjbMPYw9nVRYecPP4Mp2auiY
   O0csniSeUIhUI7B3MpbrBgvMSuR4ZO9hebuaFr/7BReQt5fIx+DvI8iyj
   fAznODQsdCWDN1wGbeS2LumfT6Wz6PCZcmo6Bmy5k44d1DiFvlLpYc8wY
   Z8pzK+k6REdQYYcgJcWflwmNEJIldRPcCcQj3LN0pEjrRcmfULkqQHRwY
   V1PRMdOphPeHkjt9GcJEXjj/Gh+m8+/n7AGbU4GFMDN1hrgNUrCP5OA47
   sGEEaLtmCjOtMv6/xRgERDGUhS5pxWNS+VWSSTvFVFRAhyoUMyW2jjm0g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="345336312"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="345336312"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="835109330"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="835109330"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Apr 2023 19:43:24 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poxn1-000eOc-2z;
        Wed, 19 Apr 2023 02:43:23 +0000
Date:   Wed, 19 Apr 2023 10:42:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pierre Asselin <pa@panix.com>, dri-devel@lists.freedesktop.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Pierre Asselin <pa@panix.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] firmware/sysfb: Fix VESA format selection
Message-ID: <202304191058.FrwRGYyD-lkp@intel.com>
References: <20230418183325.2327-1-pa@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418183325.2327-1-pa@panix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-tip/drm-tip]
[also build test WARNING on drm-misc/drm-misc-next linus/master v6.3-rc7 next-20230418]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pierre-Asselin/firmware-sysfb-Fix-VESA-format-selection/20230419-023522
base:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
patch link:    https://lore.kernel.org/r/20230418183325.2327-1-pa%40panix.com
patch subject: [PATCH] firmware/sysfb: Fix VESA format selection
config: x86_64-randconfig-a014-20230417 (https://download.01.org/0day-ci/archive/20230419/202304191058.FrwRGYyD-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/294e6879474c9528bcd0f652056d29ca3d1d473f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pierre-Asselin/firmware-sysfb-Fix-VESA-format-selection/20230419-023522
        git checkout 294e6879474c9528bcd0f652056d29ca3d1d473f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/firmware/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304191058.FrwRGYyD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/sysfb_simplefb.c:60:20: warning: comparison of distinct pointer types ('typeof ((typeof (__builtin_choose_expr(((!!(sizeof ((typeof ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) *)1 == (typeof (si->blue_size + si->blue_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->blue_size + si->blue_pos) * 0L)) : (int *)8))))), (((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) > (si->blue_size + si->blue_pos) ? ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) : (si->blue_size + si->blue_pos)), ({
       typeof ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) __UNIQUE_ID___x285 = ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
           typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
           typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
           ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
       })));
       typeof (si->blue_size + si->blue_pos) __UNIQUE_ID___y286 = (si->blue_size + si->blue_pos);
       ((__UNIQUE_ID___x285) > (__UNIQUE_ID___y286) ? (__UNIQUE_ID___x285) : (__UNIQUE_ID___y286));
   }))))__builtin_choose_expr(((!!(sizeof ((typeof (__builtin_choose_expr(((!!(sizeof ((typeof ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) *)1 == (typeof (si->blue_size + si->blue_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->blue_size + si->blue_pos) * 0L)) : (int *)8))))), (((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) > (si->blue_size + si->blue_pos) ? ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) : (si->blue_size + si->blue_pos)), ({
       typeof ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) __UNIQUE_ID___x285 = ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
           typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
           typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
           ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
       })));
       typeof (si->blue_size + si->blue_pos) __UNIQUE_ID___y286 = (si->blue_size + si->blue_pos);
       ((__UNIQUE_ID___x285) > (__UNIQUE_ID___y286) ? (__UNIQUE_ID___x285) : (__UNIQUE_ID___y286));
   }))) *)1 == (typeof (si->rsvd_size + si->rsvd_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(__builtin_choose_expr(((!!(sizeof ((typeof ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) *)1 == (typeof (si->blue_size + si->blue_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->blue_size + si->blue_pos) * 0L)) : (int *)8))))), (((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) > (si->blue_size + si->blue_pos) ? ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) : (si->blue_size + si->blue_pos)), ({
       typeof ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) __UNIQUE_ID___x285 = ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
           typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
           typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
           ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
       })));
       typeof (si->blue_size + si->blue_pos) __UNIQUE_ID___y286 = (si->blue_size + si->blue_pos);
       ((__UNIQUE_ID___x285) > (__UNIQUE_ID___y286) ? (__UNIQUE_ID___x285) : (__UNIQUE_ID___y286));
   }))) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->rsvd_size + si->rsvd_pos) * 0L)) : (int *)8))))), ((__builtin_choose_expr(((!!(sizeof ((typeof ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) *)1 == (typeof (si->blue_size + si->blue_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->blue_size + si->blue_pos) * 0L)) : (int *)8))))), (((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) > (si->blue_size + si->blue_pos) ? ((typeof (si->red_size + si->red_pos))__builtin_choose_expr(((!!(sizeof ((typeof (si->red_size + si->red_pos) *)1 == (typeof (si->green_size + si->green_pos) *)1))) && ((sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->red_size + si->red_pos) * 0L)) : (int *)8))) && (sizeof(int) == sizeof (*(8 ? ((void *)((long)(si->green_size + si->green_pos) * 0L)) : (int *)8))))), ((si->red_size + si->red_pos) > (si->green_size + si->green_pos) ? (si->red_size + si->red_pos) : (si->green_size + si->green_pos)), ({
       typeof (si->red_size + si->red_pos) __UNIQUE_ID___x283 = (si->red_size + si->red_pos);
       typeof (si->green_size + si->green_pos) __UNIQUE_ID___y284 = (si->green_size + si->green_pos);
       ((__UNIQUE_ID___x283) > (__UNIQUE_ID___y284) ? (__UNIQUE_ID___x283) : (__UNIQUE_ID___y284));
   }))) : (si->blue_size + si->blue_pos)), ({


vim +60 drivers/firmware/sysfb_simplefb.c

    25	
    26	/* try parsing screen_info into a simple-framebuffer mode struct */
    27	__init bool sysfb_parse_mode(const struct screen_info *si,
    28				     struct simplefb_platform_data *mode)
    29	{
    30		__u8 type;
    31		u32 bits_per_pixel;
    32		unsigned int i;
    33	
    34		type = si->orig_video_isVGA;
    35		if (type != VIDEO_TYPE_VLFB && type != VIDEO_TYPE_EFI)
    36			return false;
    37	
    38		/*
    39		 * The meaning of depth and bpp for direct-color formats is
    40		 * inconsistent:
    41		 *
    42		 *  - DRM format info specifies depth as the number of color
    43		 *    bits; including alpha, but not including filler bits.
    44		 *  - Linux' EFI platform code computes lfb_depth from the
    45		 *    individual color channels, including the reserved bits.
    46		 *  - VBE 1.1 defines lfb_depth for XRGB1555 as 16, but later
    47		 *    versions use 15.
    48		 *  - On the kernel command line, 'bpp' of 32 is usually
    49		 *    XRGB8888 including the filler bits, but 15 is XRGB1555
    50		 *    not including the filler bit.
    51		 *
    52		 * It's not easily possible to fix this in struct screen_info,
    53		 * as this could break UAPI. The best solution is to compute
    54		 * bits_per_pixel from the color bits, reserved bits and
    55		 * reported lfb_depth, whichever is highest.  In the loop below,
    56		 * ignore simplefb formats with alpha bits, as EFI and VESA
    57		 * don't specify alpha channels.
    58		 */
    59		if (si->lfb_depth > 8) {
  > 60			bits_per_pixel = max3(max3(si->red_size + si->red_pos,
    61						  si->green_size + si->green_pos,
    62						  si->blue_size + si->blue_pos),
    63					     si->rsvd_size + si->rsvd_pos,
    64					     si->lfb_depth);
    65		} else {
    66			bits_per_pixel = si->lfb_depth;
    67		}
    68	
    69		for (i = 0; i < ARRAY_SIZE(formats); ++i) {
    70			const struct simplefb_format *f = &formats[i];
    71	
    72			if (f->transp.length)
    73				continue; /* transparent formats are unsupported by VESA/EFI */
    74	
    75			if (bits_per_pixel == f->bits_per_pixel &&
    76			    si->red_size == f->red.length &&
    77			    si->red_pos == f->red.offset &&
    78			    si->green_size == f->green.length &&
    79			    si->green_pos == f->green.offset &&
    80			    si->blue_size == f->blue.length &&
    81			    si->blue_pos == f->blue.offset) {
    82				mode->format = f->name;
    83				mode->width = si->lfb_width;
    84				mode->height = si->lfb_height;
    85				mode->stride = si->lfb_linelength;
    86				return true;
    87			}
    88		}
    89	
    90		return false;
    91	}
    92	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
