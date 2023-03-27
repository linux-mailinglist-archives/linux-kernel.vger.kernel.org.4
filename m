Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56256CA793
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjC0O2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjC0O15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:27:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBB344AC;
        Mon, 27 Mar 2023 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679927237; x=1711463237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1MXFA7b+qpjUvdowUV3HUCrOHcVQ/STW7k81imYGgDE=;
  b=cMnxglVcmfH2PxbwDjzE7Z3E0Ia0/7GpCw+9raCMBxQrvNvXNclnx/rz
   brFOKPZLaRk974xo2qUW+TJc32qRWlbg/8FP7DFTYvNiquG/cc3RJhmpz
   P9/bUFLltAatrn1vTbSAWqGc4ZQfYncw93X+QmeAB+q+QhWU/vI0cX70d
   PZPIGXjO5nU5JJQze/6qsK/t8WtRUODfFhzahwRY4EsVtmF5/G0R5f9nQ
   5GZZnU6PI9DNx8QHFdMF7w2MPXsJeu79clf/JztTnNJqToIIGFVY97J1c
   hUudWlXZmXPq+eVxirvsfKPImqnHFsidzvKZwTnPGctujivK8BirvHtfX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="341851359"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="341851359"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 07:27:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="633616358"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="633616358"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2023 07:27:14 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgnoX-000HlX-2W;
        Mon, 27 Mar 2023 14:27:13 +0000
Date:   Mon, 27 Mar 2023 22:26:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     oe-kbuild-all@lists.linux.dev,
        Palmer Dabbelt <palmer@rivosinc.com>, linux-sh@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3] sh: Use generic GCC library routines
Message-ID: <202303272214.RxzpA6bP-lkp@intel.com>
References: <74dbe68dc8e2ffb6180092f73723fe21ab692c7a.1679566500.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74dbe68dc8e2ffb6180092f73723fe21ab692c7a.1679566500.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc4 next-20230327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geert-Uytterhoeven/sh-Use-generic-GCC-library-routines/20230323-181932
patch link:    https://lore.kernel.org/r/74dbe68dc8e2ffb6180092f73723fe21ab692c7a.1679566500.git.geert%2Brenesas%40glider.be
patch subject: [PATCH v3] sh: Use generic GCC library routines
config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20230327/202303272214.RxzpA6bP-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f81d82f320398d37e233429781ed14069e3eaf53
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Geert-Uytterhoeven/sh-Use-generic-GCC-library-routines/20230323-181932
        git checkout f81d82f320398d37e233429781ed14069e3eaf53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303272214.RxzpA6bP-lkp@intel.com/

Note: functions only called from assembly code should be annotated with the asmlinkage attribute
All warnings (new ones prefixed by >>):

   In file included from arch/sh/boot/compressed/ashldi3.c:2:
>> arch/sh/boot/compressed/../../../../lib/ashldi3.c:9:19: warning: no previous prototype for '__ashldi3' [-Wmissing-prototypes]
       9 | long long notrace __ashldi3(long long u, word_type b)
         |                   ^~~~~~~~~


vim +/__ashldi3 +9 arch/sh/boot/compressed/../../../../lib/ashldi3.c

b35cd9884fa5d8 Palmer Dabbelt 2017-05-23  8  
b35cd9884fa5d8 Palmer Dabbelt 2017-05-23 @9  long long notrace __ashldi3(long long u, word_type b)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
