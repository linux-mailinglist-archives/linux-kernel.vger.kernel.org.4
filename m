Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5802736230
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjFTDdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjFTDdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:33:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7793139;
        Mon, 19 Jun 2023 20:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687231977; x=1718767977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vz9Elmf3UeS0RL3UTjU7uNXgCY47ti7fqCDYGrkHqhs=;
  b=m9tobE2MoUEA6+xAN6tKuRg6pC29TlEust+Ya/vQLh8zFCy7h5Ov0a+k
   dnK/cCILG9kowFVDJIsIJMVu126+qtzxGYWxeztBdhOsyPWUR1xzXVpWY
   I4nevD/Ahas2SpikE0RihUsSgVayUbTOjj4Z038Yf6vkL3bYONatz3C3h
   O/mTTSD+bkp5Ueod1obFWkRr/GWwEM/tNCSwlYv9HF9/hpFvnWE6OvAdd
   iN6A1hUpDlb53yQ5CmtPD18ohDitiANmX25UBdqn3eD4E00/ZuHT4STCD
   KnvA/i7/5wlo3wZg5fJoMAwoaFKxLVR1NKZS1l+c/tngcEBH1PjAaTawh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359758202"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359758202"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 20:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="691279341"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="691279341"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2023 20:32:50 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBS6s-0005RH-0F;
        Tue, 20 Jun 2023 03:32:50 +0000
Date:   Tue, 20 Jun 2023 11:32:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, tzimmermann@suse.de, mripard@kernel.org,
        corbet@lwn.net, christian.koenig@amd.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH drm-next v5 03/14] drm: manager to keep track of GPUs VA
 mappings
Message-ID: <202306201123.4nvLB3cQ-lkp@intel.com>
References: <20230620004217.4700-4-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620004217.4700-4-dakr@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2222dcb0775d36de28992f56455ab3967b30d380]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-execution-context-for-GEM-buffers-v4/20230620-084448
base:   2222dcb0775d36de28992f56455ab3967b30d380
patch link:    https://lore.kernel.org/r/20230620004217.4700-4-dakr%40redhat.com
patch subject: [PATCH drm-next v5 03/14] drm: manager to keep track of GPUs VA mappings
config: hexagon-randconfig-r041-20230620 (https://download.01.org/0day-ci/archive/20230620/202306201123.4nvLB3cQ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306201123.4nvLB3cQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306201123.4nvLB3cQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_gpuva_mgr.c:676:7: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
     676 |         return WARN(check_add_overflow(addr, range, &end),
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     677 |                     "GPUVA address limited to %lu bytes, see Documentation.\n",
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                               %u
     678 |                     MTREE_INDEX_SIZE);
         |                     ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_gpuva_mgr.c:663:26: note: expanded from macro 'MTREE_INDEX_SIZE'
     663 | #define MTREE_INDEX_SIZE sizeof(MTREE_INDEX_TYPE)
         |                          ^
   include/asm-generic/bug.h:133:29: note: expanded from macro 'WARN'
     133 |                 __WARN_printf(TAINT_WARN, format);                      \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   include/asm-generic/bug.h:97:48: note: expanded from macro '__WARN_printf'
      97 |                 warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);      \
         |                                                              ^~~
   drivers/gpu/drm/drm_gpuva_mgr.c:1314:25: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    1314 |         struct drm_gpuva *va, *prev = NULL;
         |                                ^
   2 warnings generated.


vim +676 drivers/gpu/drm/drm_gpuva_mgr.c

   668	
   669	static inline bool
   670	drm_gpuva_check_overflow(u64 addr, u64 range)
   671	{
   672		MTREE_INDEX_TYPE end;
   673	
   674		return WARN(check_add_overflow(addr, range, &end),
   675			    "GPUVA address limited to %lu bytes, see Documentation.\n",
 > 676			    MTREE_INDEX_SIZE);
   677	}
   678	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
