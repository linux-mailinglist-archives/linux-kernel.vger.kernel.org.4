Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722A769BFDD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBSJsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBSJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:48:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B32912BE4;
        Sun, 19 Feb 2023 01:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676800050; x=1708336050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q2GpKKG2V+P7JRXP/CGrjbt/Xfz0FyjBehJQcTf15ZY=;
  b=ei2OBtl0sMZFhkpa5z3CLldoplTE9ZYpExGeguNbUnwyIYsjj1WhUIOk
   NC2Xro/KnsRLj20iyUwHbeYzBNlEoZEwh8D7kOssTjlL1/ezFoVEZ9TBO
   rUq9a0fq+5Ty11aNu9o4/zjQhzKejuP8waOtJ0+ygclm2fqPFT1mtfSXk
   F93Vq917KEfVtthRwXoLzsMlMPDFi2GXkJRd+TOkhtMj7XiijKaXvgMb4
   hSURIDen/eNVCj2rjg3Unu4+buJ7tsNvaFmekBfYWoRHTDfDcWJxXeCGg
   u0CWqpQa92zYl8vTzMfStf3EJ3SO+mzMpHbosy0QspsEm2w49/I7pfyQ7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="311867281"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="311867281"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 01:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="759872250"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="759872250"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Feb 2023 01:45:34 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTgGD-000DEb-0f;
        Sun, 19 Feb 2023 09:45:33 +0000
Date:   Sun, 19 Feb 2023 17:45:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bfoster@redhat.com, willy@infradead.org, arnd@arndb.de,
        linux-api@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v10 2/3] cachestat: implement cachestat syscall
Message-ID: <202302191708.tLz0L0ZE-lkp@intel.com>
References: <20230219073318.366189-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219073318.366189-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 1440f576022887004f719883acb094e7e0dd4944]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230219-153500
base:   1440f576022887004f719883acb094e7e0dd4944
patch link:    https://lore.kernel.org/r/20230219073318.366189-3-nphamcs%40gmail.com
patch subject: [PATCH v10 2/3] cachestat: implement cachestat syscall
config: sparc-randconfig-r033-20230219 (https://download.01.org/0day-ci/archive/20230219/202302191708.tLz0L0ZE-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d691a3b4a696ab20c9c5fe86c624e9e36814523c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230219-153500
        git checkout d691a3b4a696ab20c9c5fe86c624e9e36814523c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302191708.tLz0L0ZE-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/filemap.c:4035:6: warning: no previous prototype for 'ksys_cachestat' [-Wmissing-prototypes]
    4035 | long ksys_cachestat(unsigned int fd, size_t len, loff_t off,
         |      ^~~~~~~~~~~~~~
>> mm/filemap.c:4102:34: error: expected ')' before 'unsigned'
    4102 | COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, size_t, len,
         |                                  ^~~~~~~~~
         |                                  )


vim +4102 mm/filemap.c

  4100	
  4101	#ifdef CONFIG_COMPAT
> 4102	COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, size_t, len,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
