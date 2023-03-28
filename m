Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3057B6CC9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjC1Rz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjC1Rz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:55:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1448BE3B1;
        Tue, 28 Mar 2023 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680026122; x=1711562122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2VwTQJIr4BTFvryXJU5QaWYWC5ASSVnz8DiJqX6T0i8=;
  b=GnM5rVll0VeUkxAjxhtfsrG/yvmwple2JP5F6K0wD+D/FD4V8dPUOeeH
   ikEN3zm8JO/F/X+vz/0rM+93nEuOtP6+B0TcsKnALVumSfDuhJXQ5v7Se
   wJtBjyPEssE2Z1XTj7hVPLKayY9aqfiH5S6W33GZHiF0UnGGnNCjyWHRo
   AByCMhQAUPiLykwXcrLCmSzVEykN9h8gu4tcHj9skNfrgBOwnLNoM8Bjx
   vipIey0FKg830pvmHWUjZTtd8tc8r4AC64Gy8Bb+gz6ZKmZVaUmpkFiuS
   yqoFR9WjTw/VSRh9jMdiiv7D8EHfCQ5Yk5F3L2rPytCt4vaelVfBUnwJ5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="342235632"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342235632"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 10:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="677459329"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="677459329"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2023 10:55:17 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phDXP-000Iml-0d;
        Tue, 28 Mar 2023 17:55:15 +0000
Date:   Wed, 29 Mar 2023 01:54:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Chen <harperchen1110@gmail.com>, tiffany.lin@mediatek.com
Cc:     oe-kbuild-all@lists.linux.dev, andrew-ct.chen@mediatek.com,
        yunfei.dong@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Wei Chen <harperchen1110@gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Fix potential array
 out-of-bounds in decoder queue_setup
Message-ID: <202303290137.F9lOyCT4-lkp@intel.com>
References: <20230328100951.536955-1-harperchen1110@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328100951.536955-1-harperchen1110@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v6.3-rc4 next-20230328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Chen/media-mediatek-vcodec-Fix-potential-array-out-of-bounds-in-decoder-queue_setup/20230328-181142
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230328100951.536955-1-harperchen1110%40gmail.com
patch subject: [PATCH] media: mediatek: vcodec: Fix potential array out-of-bounds in decoder queue_setup
config: csky-randconfig-r013-20230327 (https://download.01.org/0day-ci/archive/20230329/202303290137.F9lOyCT4-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/caa43627286fb5f3b0b3af7e01e1baeca5c5f9cc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wei-Chen/media-mediatek-vcodec-Fix-potential-array-out-of-bounds-in-decoder-queue_setup/20230328-181142
        git checkout caa43627286fb5f3b0b3af7e01e1baeca5c5f9cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/media/platform/mediatek/vcodec/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303290137.F9lOyCT4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/div64.h:27,
                    from ./arch/csky/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/videodev2.h:59,
                    from include/media/v4l2-event.h:16,
                    from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c:8:
   drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c: In function 'vb2ops_vdec_queue_setup':
>> include/linux/compiler.h:56:26: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                          ^
   drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c:756:17: note: in expansion of macro 'if'
     756 |                 if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
         |                 ^~


vim +/else +56 include/linux/compiler.h

2bcd521a684cc9 Steven Rostedt 2008-11-21  50  
2bcd521a684cc9 Steven Rostedt 2008-11-21  51  #ifdef CONFIG_PROFILE_ALL_BRANCHES
2bcd521a684cc9 Steven Rostedt 2008-11-21  52  /*
2bcd521a684cc9 Steven Rostedt 2008-11-21  53   * "Define 'is'", Bill Clinton
2bcd521a684cc9 Steven Rostedt 2008-11-21  54   * "Define 'if'", Steven Rostedt
2bcd521a684cc9 Steven Rostedt 2008-11-21  55   */
a15fd609ad53a6 Linus Torvalds 2019-03-20 @56  #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
a15fd609ad53a6 Linus Torvalds 2019-03-20  57  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
