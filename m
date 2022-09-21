Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7FE5BFBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiIUJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiIUJwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:52:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4028197B18;
        Wed, 21 Sep 2022 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663753766; x=1695289766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g+ycbsDZhHfXkdCOof/o/4T49/1Rwk3h7cJgpX3bUcY=;
  b=NRu8UJjSMN/YBDFeKYea5MUtGux3A73W58e6m6HmAQmqubqS6WPgGbek
   qqwSzWEuL3kdstMTZq5vZX/1Yij7/Qe51bK6QcEIN/0Kxd4VbxgS+FObK
   hi3OnlflU9arkWE7bXCo8upKBwxPnKGorqKKS4KcRNBeAgXiam7idoueX
   6uZn8cyQKclMLIDPpAedi73n2IZ6Tp93qDh1ROffC9ak0VKkWfIkda3eH
   LyFQSJ06pzvKqwAwoyislmtLqqWfXTZpW8vo8UOor3eG4H4RdS50+IuQO
   LNmNjSJSEl6WHh8R6HcN43upN0gh2FoHlPzzNYtqcQivJhZEyTdgiTHjx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="297554733"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="297554733"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 02:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="744890039"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Sep 2022 02:49:20 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oawLz-0003UN-0V;
        Wed, 21 Sep 2022 09:49:15 +0000
Date:   Wed, 21 Sep 2022 17:48:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jammy Huang <jammy_huang@aspeedtech.com>, eajames@linux.ibm.com,
        mchehab@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        nicolas.dufresne@collabora.com, stanimir.varbanov@linaro.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        ribalda@chromium.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v9 3/4] media: aspeed: Support aspeed mode to reduce
 compressed data
Message-ID: <202209211741.XHu8zd6f-lkp@intel.com>
References: <20220921025112.13150-4-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921025112.13150-4-jammy_huang@aspeedtech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jammy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on next-20220920]
[cannot apply to linus/master v6.0-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jammy-Huang/add-aspeed-jpeg-support-for-aspeed-video/20220921-105350
base:   git://linuxtv.org/media_tree.git master
config: arm-multi_v5_defconfig (https://download.01.org/0day-ci/archive/20220921/202209211741.XHu8zd6f-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/99c2bf6f1dccc310cb9b2d9916292766f00ffb4f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jammy-Huang/add-aspeed-jpeg-support-for-aspeed-video/20220921-105350
        git checkout 99c2bf6f1dccc310cb9b2d9916292766f00ffb4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/media/platform/aspeed/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/aspeed/aspeed-video.c:487:27: warning: unused variable 'compress_scheme_str' [-Wunused-const-variable]
   static const char * const compress_scheme_str[] = {"DCT Only",
                             ^
   In file included from drivers/media/platform/aspeed/aspeed-video.c:24:
   In file included from include/linux/videodev2.h:61:
   include/uapi/linux/videodev2.h:1776:2: warning: field  within 'struct v4l2_ext_control' is less aligned than 'union v4l2_ext_control::(anonymous at include/uapi/linux/videodev2.h:1776:2)' and is usually due to 'struct v4l2_ext_control' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   2 warnings generated.


vim +/compress_scheme_str +487 drivers/media/platform/aspeed/aspeed-video.c

   486	
 > 487	static const char * const compress_scheme_str[] = {"DCT Only",
   488		"DCT VQ mix 2-color", "DCT VQ mix 4-color"};
   489	static const char * const format_str[] = {"Standard JPEG",
   490		"Aspeed JPEG"};
   491	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
