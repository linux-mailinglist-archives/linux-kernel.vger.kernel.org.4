Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E133A67FED2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 13:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjA2MMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 07:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2MML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 07:12:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A171713527;
        Sun, 29 Jan 2023 04:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674994330; x=1706530330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=In6EFK3n5kPcdfNi3Fdf65JlIPPEIT4F0GieQf6G1sI=;
  b=cqvtb697SoWSZCTPJxiJ/d5jhoBe/t3rU1m1PUjIWdBZJv0Tmyy+PzTB
   c7b/olL1AbaeUQNiEZR1CCYURqDwd9ayoYAVB6QyrBj4MQLgSoRC2pj+J
   0uRRDpRc+vEFR8BeUahvTe25ml+oyejeG0aAt08Ycgwb1C+SCZd6FdyUN
   nZv1Lkh4JlNsZnnyYqdk+9YPp/JWKAHk3Qov97rg0fZEKdfRSoShZd/8h
   AAlV3VxiAOn0c7y+R4pLD0tvpQCI+KwW2Dz0uZqRFclAu3L5dLLsLx0TN
   /idBnbscmUs9vAB6kpTkkx/BWCmqAzDKKPOLo5H3887aIoSjKsPMZuu3J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="413610273"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="413610273"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 04:12:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="752515787"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="752515787"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jan 2023 04:12:07 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pM6XW-0002n6-2B;
        Sun, 29 Jan 2023 12:12:06 +0000
Date:   Sun, 29 Jan 2023 20:11:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bfoster@redhat.com, willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v8 2/3] cachestat: implement cachestat syscall
Message-ID: <202301292044.JVAnbg9W-lkp@intel.com>
References: <20230126175356.1582123-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126175356.1582123-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 1440f576022887004f719883acb094e7e0dd4944]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230128-171134
base:   1440f576022887004f719883acb094e7e0dd4944
patch link:    https://lore.kernel.org/r/20230126175356.1582123-3-nphamcs%40gmail.com
patch subject: [PATCH v8 2/3] cachestat: implement cachestat syscall
config: s390-randconfig-s051-20230129 (https://download.01.org/0day-ci/archive/20230129/202301292044.JVAnbg9W-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a05ffdcecfe9ac147066fb8472e6fb75491d0eed
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230128-171134
        git checkout a05ffdcecfe9ac147066fb8472e6fb75491d0eed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> mm/filemap.c:4075:1: sparse: sparse: Using plain integer as NULL pointer
>> mm/filemap.c:4075:1: sparse: sparse: Using plain integer as NULL pointer
   mm/filemap.c:1416:17: sparse: sparse: context imbalance in 'migration_entry_wait_on_locked' - unexpected unlock

vim +4075 mm/filemap.c

  4037	
  4038	#ifdef CONFIG_CACHESTAT_SYSCALL
  4039	/*
  4040	 * The cachestat(5) system call.
  4041	 *
  4042	 * cachestat() returns the page cache statistics of a file in the
  4043	 * bytes range specified by `off` and `len`: number of cached pages,
  4044	 * number of dirty pages, number of pages marked for writeback,
  4045	 * number of evicted pages, and number of recently evicted pages.
  4046	 *
  4047	 * An evicted page is a page that is previously in the page cache
  4048	 * but has been evicted since. A page is recently evicted if its last
  4049	 * eviction was recent enough that its reentry to the cache would
  4050	 * indicate that it is actively being used by the system, and that
  4051	 * there is memory pressure on the system.
  4052	 *
  4053	 * `off` and `len` must be non-negative integers. If `len` > 0,
  4054	 * the queried range is [`off`, `off` + `len`]. If `len` == 0,
  4055	 * we will query in the range from `off` to the end of the file.
  4056	 *
  4057	 * `cstat_version` is an unsigned integer indicating the specific version
  4058	 * of the cachestat struct. It must be at least 1, and does not exceed the
  4059	 * latest version number (which is currently 1). For now, user should
  4060	 * just pass 1.
  4061	 *
  4062	 * The `flags` argument is unused for now, but is included for future
  4063	 * extensibility. User should pass 0 (i.e no flag specified).
  4064	 *
  4065	 * Because the status of a page can change after cachestat() checks it
  4066	 * but before it returns to the application, the returned values may
  4067	 * contain stale information.
  4068	 *
  4069	 * return values:
  4070	 *  zero    - success
  4071	 *  -EFAULT - cstat points to an illegal address
  4072	 *  -EINVAL - invalid arguments
  4073	 *  -EBADF	- invalid file descriptor
  4074	 */
> 4075	SYSCALL_DEFINE6(cachestat, unsigned int, fd, off_t, off, size_t, len,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
