Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099127294A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbjFIJSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbjFIJSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:18:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871894C1F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686302002; x=1717838002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YMSJQYLZcFlQidja6+TL7FQW+z4zUcAIo2OjQ8VSXfQ=;
  b=KkTigiKwQu25xAod9XSEqn4Qyr1U8A9d9BlQp5NQrIo5ZXDXfQi1Tegv
   rxtu0jCT/jo0NKtPX5FKwsSa4zQxPRVeeMP9qml9rbW0Sq7OWSw5AZoAF
   MMkEbpgbtQL9L4FusfxX/kYjSqgGSuVm/eYcGfXI7YfKFXwLqYMRd0h6r
   AQwaSQypQCnjlXJ4bXNdoUQ9UAHfmgv2qDnO8xQh2O3oensh30XL6bHmN
   2ZYiXJBcfAuWD3rmZ7hWXqmkEgzTfk+6yCB8GVJU2lf2Fz/JEirYrCtRN
   u8KFeSOmKhBtsCtBO2VD58+o0Z+JSwEXP/pAFPoKDksRE3ZpFmvGMh/C+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342231073"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342231073"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:13:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="1040434678"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="1040434678"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2023 02:13:00 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7YB1-0008si-1n;
        Fri, 09 Jun 2023 09:12:59 +0000
Date:   Fri, 9 Jun 2023 17:12:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lu Hongfei <luhongfei@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: Re: [PATCH] mm/vmalloc: Replace the ternary conditional operator
 with min()
Message-ID: <202306091704.nUl4tysX-lkp@intel.com>
References: <20230609061309.42453-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609061309.42453-1-luhongfei@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lu-Hongfei/mm-vmalloc-Replace-the-ternary-conditional-operator-with-min/20230609-141417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230609061309.42453-1-luhongfei%40vivo.com
patch subject: [PATCH] mm/vmalloc: Replace the ternary conditional operator with min()
config: arc-randconfig-s032-20230609 (https://download.01.org/0day-ci/archive/20230609/202306091704.nUl4tysX-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a85ea29b355934c588aeb97faf6846b76d512a6d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lu-Hongfei/mm-vmalloc-Replace-the-ternary-conditional-operator-with-min/20230609-141417
        git checkout a85ea29b355934c588aeb97faf6846b76d512a6d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306091704.nUl4tysX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/vmalloc.c:3574:23: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> mm/vmalloc.c:3574:23: sparse:    unsigned int *
>> mm/vmalloc.c:3574:23: sparse:    unsigned long *
   mm/vmalloc.c:4291:13: sparse: sparse: context imbalance in 's_start' - wrong count at exit
   mm/vmalloc.c:4306:13: sparse: sparse: context imbalance in 's_stop' - wrong count at exit

vim +3574 mm/vmalloc.c

  3561	
  3562	/*
  3563	 * Atomically zero bytes in the iterator.
  3564	 *
  3565	 * Returns the number of zeroed bytes.
  3566	 */
  3567	static size_t zero_iter(struct iov_iter *iter, size_t count)
  3568	{
  3569		size_t remains = count;
  3570	
  3571		while (remains > 0) {
  3572			size_t num, copied;
  3573	
> 3574			num = min(remains, PAGE_SIZE);
  3575			copied = copy_page_to_iter_nofault(ZERO_PAGE(0), 0, num, iter);
  3576			remains -= copied;
  3577	
  3578			if (copied < num)
  3579				break;
  3580		}
  3581	
  3582		return count - remains;
  3583	}
  3584	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
