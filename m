Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6E468A492
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjBCVTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjBCVTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:19:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4969E9D4;
        Fri,  3 Feb 2023 13:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675459160; x=1706995160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UVUv3/mnRTJNvTbZvw+X59IaeR9LcLY7UWZ7TcVejDE=;
  b=m6R0FBNngOb8qh0euQQOkR9nxgjlfirXgN33pPaZVNHIA3u/tD8JG8zR
   bmzhQW7Mei5gTWNq8IQ8iLghbTrUHrrs4cVQemcPlwei8oREL7imFQrX5
   +bilNgKOAtxODQmBcOwIUldcZAwP4k+NqFlOKOfReNnTTPQCuqvtNtUV5
   30bPz6hEHz+xiafDpHEXrT1h3Q0ywZlQcRHkZ7k2bPjWNGxYqjYFtHrfK
   1rZhOf4AQJ5K3lpZSeunB3k7/qt2iN1lXw8MDtBnu/XRkwbzh17Dgwqzv
   ySWtLxSfrSVq5GF+AAm47Ab9p0Vdh6wbCfAEc9LvfJKVC53JBuV6UNMeE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="327493829"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="327493829"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 13:19:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="698205082"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="698205082"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2023 13:19:17 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pO3Sm-0000lb-20;
        Fri, 03 Feb 2023 21:19:16 +0000
Date:   Sat, 4 Feb 2023 05:19:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Victor Hassan <victor@allwinnertech.com>, keescook@chromium.org
Cc:     oe-kbuild-all@lists.linux.dev, tony.luck@intel.com,
        gpiccoli@igalia.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: Export a method to implemente panic_write()
Message-ID: <202302040515.tdCoWcUS-lkp@intel.com>
References: <20230203113515.93540-1-victor@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203113515.93540-1-victor@allwinnertech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Victor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on kees/for-next/kspp linus/master v6.2-rc6 next-20230203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Victor-Hassan/pstore-blk-Export-a-method-to-implemente-panic_write/20230203-193548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/20230203113515.93540-1-victor%40allwinnertech.com
patch subject: [PATCH] pstore/blk: Export a method to implemente panic_write()
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20230204/202302040515.tdCoWcUS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/368e42ba015da6c7bdd201b8fdb669e936307cbb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Victor-Hassan/pstore-blk-Export-a-method-to-implemente-panic_write/20230203-193548
        git checkout 368e42ba015da6c7bdd201b8fdb669e936307cbb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/ fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/mtd/mtdpstore.c:7:
>> include/linux/pstore_blk.h:32:41: error: unknown type name 'pstore_blk_notifier_type'
      32 | typedef int (*pstore_blk_notifier_fn_t)(pstore_blk_notifier_type type,
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/pstore_blk.h:37:9: error: unknown type name 'pstore_blk_notifier_fn_t'
      37 |         pstore_blk_notifier_fn_t notifier_call;
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from fs/pstore/blk.c:16:
>> include/linux/pstore_blk.h:32:41: error: unknown type name 'pstore_blk_notifier_type'
      32 | typedef int (*pstore_blk_notifier_fn_t)(pstore_blk_notifier_type type,
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/pstore_blk.h:37:9: error: unknown type name 'pstore_blk_notifier_fn_t'
      37 |         pstore_blk_notifier_fn_t notifier_call;
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/pstore/blk.c: In function 'pstore_blk_panic_notifier_call':
>> fs/pstore/blk.c:114:23: error: called object is not a function or function pointer
     114 |                 ret = pbn->notifier_call(action, data);
         |                       ^~~


vim +/pstore_blk_notifier_type +32 include/linux/pstore_blk.h

    31	
  > 32	typedef	int (*pstore_blk_notifier_fn_t)(pstore_blk_notifier_type type,
    33			struct pstore_device_info *dev);
    34	
    35	struct pstore_blk_notifier {
    36		struct notifier_block nb;
  > 37		pstore_blk_notifier_fn_t notifier_call;
    38	};
    39	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
