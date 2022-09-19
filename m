Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF55BD4F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiISSzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiISSzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:55:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED7527CF5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663613714; x=1695149714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i+aEGsVW1WXRn39/yQinuqupanGyjkup5oZc7L/h3Ts=;
  b=CF2t5fnQhA9wXD1VhBkbaMiYraB41xlL+0oT40ngC/yplZEzvudXXsgr
   FuoDsgRQojWRfHKcqwXK3D5E4e9HT6ToV58LyiqXrPXM+rbTjJcxGJB6Q
   UIACEthQAR0+oDGJsUABcKo5afCRJVbSxqjExc/Jv2Cev4s4sqcKAn6fn
   7rwyFiCRxOtjIZLA2qZGhtgAn3E+juM+oNftDOgLzRBHmeBnkoPozQkNI
   xp+0EVGwhpvQU7yqXejir2BdxToan2Wz+KuKcqjW3K6+uxf5IFmNS4i90
   FlSPSFDUzUTtfeitz90K0tgcwr09kReIp6zuOH8x5kIY2HpH9Hz127Wbn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="325786910"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="325786910"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 11:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="651797465"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Sep 2022 11:55:11 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaLvC-0002BB-0M;
        Mon, 19 Sep 2022 18:55:10 +0000
Date:   Tue, 20 Sep 2022 02:54:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 5/9] mm/mm_init.c: use hotplug_memory_notifier() directly
Message-ID: <202209200223.T0pXU4pA-lkp@intel.com>
References: <20220919083152.1824305-6-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919083152.1824305-6-liushixin2@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Shixin/mm-Use-hotplug_memory_notifier-instead-of-register_hotmemory_notifier/20220919-160043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: arm64-randconfig-r036-20220919 (https://download.01.org/0day-ci/archive/20220920/202209200223.T0pXU4pA-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/33c4e50ed97460db120701f262ae1814509ba982
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liu-Shixin/mm-Use-hotplug_memory_notifier-instead-of-register_hotmemory_notifier/20220919-160043
        git checkout 33c4e50ed97460db120701f262ae1814509ba982
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/mm_init.c:184:26: error: expected identifier or '('
           hotplug_memory_notifier(&mm_compute_batch_notifier, IPC_CALLBACK_PRI);
                                   ^
>> mm/mm_init.c:184:2: error: use of undeclared identifier 'mm_compute_batch_notifier_mem_nb'
           hotplug_memory_notifier(&mm_compute_batch_notifier, IPC_CALLBACK_PRI);
           ^
   include/linux/memory.h:167:28: note: expanded from macro 'hotplug_memory_notifier'
           register_memory_notifier(&fn##_mem_nb);                 \
                                     ^
   <scratch space>:31:1: note: expanded from here
   mm_compute_batch_notifier_mem_nb
   ^
   2 errors generated.


vim +184 mm/mm_init.c

   180	
   181	static int __init mm_compute_batch_init(void)
   182	{
   183		mm_compute_batch(sysctl_overcommit_memory);
 > 184		hotplug_memory_notifier(&mm_compute_batch_notifier, IPC_CALLBACK_PRI);
   185		return 0;
   186	}
   187	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
