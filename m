Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5366B2661
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjCIOLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjCIOKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:10:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542B8F6391;
        Thu,  9 Mar 2023 06:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678370983; x=1709906983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sn3d9ayWr4FcVCBfsUBE4K+Kz06ZIcCZ4q/qz7Bmx3U=;
  b=c5TnIehnK5UDmzC1avI6sCd247xHNcEjH2WX+VqCXDVyvUwCC53PCNN+
   7cx8Q/ZkwPQ8Jgv5ODTuKl05Vp4H4Ap5uuYibaA2jui1d+152ExOCzPgu
   d4muZV+qPZAeQnpYIRH3htWZqG66OupKnZNzNKe29WKt8ewOyJ3b+fmd5
   Va4dqugJmVskmYjVyP9D62tSNG93kiYaQCsa3cTK24pRYR5Y6w5TvBRKf
   D8y7VkXLTJuaZGyHPpTBEb4fd0VZr/xXVY9Dzxik4EtXsmJWRmLeYCe0U
   8HWcOXZu+to8mQPWRWWUfE/an+Hkh1LMITPilllb0i5FjEPwJjshGmYjX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333922492"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="333922492"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:09:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="627358135"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="627358135"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2023 06:09:26 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paGxR-0002zp-2u;
        Thu, 09 Mar 2023 14:09:25 +0000
Date:   Thu, 9 Mar 2023 22:08:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bfoster@redhat.com, willy@infradead.org, arnd@arndb.de,
        linux-api@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v11 2/3] cachestat: implement cachestat syscall
Message-ID: <202303092111.mhDcYB71-lkp@intel.com>
References: <20230308032748.609510-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308032748.609510-3-nphamcs@gmail.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230308-112932
base:   1440f576022887004f719883acb094e7e0dd4944
patch link:    https://lore.kernel.org/r/20230308032748.609510-3-nphamcs%40gmail.com
patch subject: [PATCH v11 2/3] cachestat: implement cachestat syscall
config: arm-randconfig-r046-20230308 (https://download.01.org/0day-ci/archive/20230309/202303092111.mhDcYB71-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ca34a4daf11f6fbb9731205af7acd06fe620e447
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230308-112932
        git checkout ca34a4daf11f6fbb9731205af7acd06fe620e447
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/bpf/ mm/ prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303092111.mhDcYB71-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> <stdin>:1565:2: warning: #warning syscall cachestat not implemented [-Wcpp]
--
   In file included from include/linux/filter.h:11,
                    from include/linux/bpf_verifier.h:9,
                    from tools/lib/bpf/relo_core.c:8:
>> include/linux/compat.h:821:45: warning: 'struct cachestat' declared inside parameter list will not be visible outside of this definition or declaration
     821 |                 compat_arg_u64(off), struct cachestat __user *cstat,
         |                                             ^~~~~~~~~
--
   In file included from include/linux/filter.h:11,
                    from kernel/bpf/core.c:21:
>> include/linux/compat.h:821:45: warning: 'struct cachestat' declared inside parameter list will not be visible outside of this definition or declaration
     821 |                 compat_arg_u64(off), struct cachestat __user *cstat,
         |                                             ^~~~~~~~~
   kernel/bpf/core.c:1628:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1628 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:11,
                    from include/linux/bpf_verifier.h:9,
                    from kernel/bpf/btf.c:19:
>> include/linux/compat.h:821:45: warning: 'struct cachestat' declared inside parameter list will not be visible outside of this definition or declaration
     821 |                 compat_arg_u64(off), struct cachestat __user *cstat,
         |                                             ^~~~~~~~~
   kernel/bpf/btf.c: In function 'btf_seq_show':
   kernel/bpf/btf.c:6786:29: warning: function 'btf_seq_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    6786 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
         |                             ^~~~~~~~
   kernel/bpf/btf.c: In function 'btf_snprintf_show':
   kernel/bpf/btf.c:6823:9: warning: function 'btf_snprintf_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    6823 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
         |         ^~~
--
>> mm/filemap.c:4034:6: warning: no previous prototype for 'ksys_cachestat' [-Wmissing-prototypes]
    4034 | long ksys_cachestat(unsigned int fd, size_t len, loff_t off,
         |      ^~~~~~~~~~~~~~
--
>> <stdin>:1565:2: warning: #warning syscall cachestat not implemented [-Wcpp]
--
>> <stdin>:1565:2: warning: #warning syscall cachestat not implemented [-Wcpp]


vim +821 include/linux/compat.h

   809	
   810	/* net/socket.c */
   811	asmlinkage long compat_sys_recvfrom(int fd, void __user *buf, compat_size_t len,
   812				    unsigned flags, struct sockaddr __user *addr,
   813				    int __user *addrlen);
   814	asmlinkage long compat_sys_sendmsg(int fd, struct compat_msghdr __user *msg,
   815					   unsigned flags);
   816	asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
   817					   unsigned int flags);
   818	
   819	/* mm/filemap.c */
   820	asmlinkage long compat_sys_cachestat(unsigned int fd, size_t len,
 > 821			compat_arg_u64(off), struct cachestat __user *cstat,
   822			unsigned int flags);
   823	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
