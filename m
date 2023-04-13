Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0016E13C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDMRya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDMRy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:54:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4D54C2D;
        Thu, 13 Apr 2023 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681408465; x=1712944465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AkFkj67LgnRBg8erxQMFRclMRCTvqY5BoKQ0Q5utrtA=;
  b=FXvSAdficPbgN0kom7iGoNIinI3sVDXVl1zZNp7Ps7Pdj2Ixh/n9K/rC
   1uBy4Pv2Jo3mQJONBPT2lsxMBw4HltII79/yws7t6VJOpK0jOHdFUUKB/
   c2xeLHXi5fHixcyxqgeVytBxktkglcSHPJ1RE/Wri/810vh+Rrl1nSidC
   i0A6rUqo544YfmssQvMpzBbZHn6FDI5jFLtEDLiKlNVEZW5u/5mGXSvHg
   aQ4kWmkYQCOn3q+j3ZuKkpyo7MT4cf9mcoVgCY0gfkIwn5ANfWPnLA7pE
   nvgM4NmMyco1Ug34IOqGDMTQpi6/Wr31eY4WoMTZ/qM3MTWUxsRUzKuZ0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="323882771"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="323882771"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 10:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="778866782"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="778866782"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2023 10:53:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pn18w-000Yqz-12;
        Thu, 13 Apr 2023 17:53:58 +0000
Date:   Fri, 14 Apr 2023 01:53:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     sxwjean@me.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [PATCH 2/5] slub: Put objects_show() into CONFIG_SLUB_DEBUG
 enabled block
Message-ID: <202304140110.lzjsYh25-lkp@intel.com>
References: <20230413143452.211250-3-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413143452.211250-3-sxwjean@me.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on vbabka-slab/for-next]
[also build test ERROR on linus/master v6.3-rc6 next-20230412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sxwjean-me-com/slub-Correct-the-error-code-when-slab_kset-is-NULL/20230413-223743
base:   git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git for-next
patch link:    https://lore.kernel.org/r/20230413143452.211250-3-sxwjean%40me.com
patch subject: [PATCH 2/5] slub: Put objects_show() into CONFIG_SLUB_DEBUG enabled block
config: i386-randconfig-a012-20230410 (https://download.01.org/0day-ci/archive/20230414/202304140110.lzjsYh25-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/356157a450e3905cdc07fd0e77c4ac42974706c7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review sxwjean-me-com/slub-Correct-the-error-code-when-slab_kset-is-NULL/20230413-223743
        git checkout 356157a450e3905cdc07fd0e77c4ac42974706c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304140110.lzjsYh25-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/slub.c:5947:10: error: 'objects_attr' undeclared here (not in a function); did you mean 'object_size_attr'?
    5947 |         &objects_attr.attr,
         |          ^~~~~~~~~~~~
         |          object_size_attr


vim +5947 mm/slub.c

b84e04f1baeebe6 Imran Khan        2022-08-15  5939  
81819f0fc8285a2 Christoph Lameter 2007-05-06  5940  static struct attribute *slab_attrs[] = {
81819f0fc8285a2 Christoph Lameter 2007-05-06  5941  	&slab_size_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5942  	&object_size_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5943  	&objs_per_slab_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5944  	&order_attr.attr,
73d342b169db700 David Rientjes    2009-02-22  5945  	&min_partial_attr.attr,
49e2258586b4236 Christoph Lameter 2011-08-09  5946  	&cpu_partial_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06 @5947  	&objects_attr.attr,
205ab99dd103e3d Christoph Lameter 2008-04-14  5948  	&objects_partial_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5949  	&partial_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5950  	&cpu_slabs_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5951  	&ctor_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5952  	&aliases_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5953  	&align_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5954  	&hwcache_align_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5955  	&reclaim_account_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5956  	&destroy_by_rcu_attr.attr,
a5a84755c590041 Christoph Lameter 2010-10-05  5957  	&shrink_attr.attr,
49e2258586b4236 Christoph Lameter 2011-08-09  5958  	&slabs_cpu_partial_attr.attr,
ab4d5ed5eeda4f5 Christoph Lameter 2010-10-05  5959  #ifdef CONFIG_SLUB_DEBUG
a5a84755c590041 Christoph Lameter 2010-10-05  5960  	&total_objects_attr.attr,
a5a84755c590041 Christoph Lameter 2010-10-05  5961  	&slabs_attr.attr,
a5a84755c590041 Christoph Lameter 2010-10-05  5962  	&sanity_checks_attr.attr,
a5a84755c590041 Christoph Lameter 2010-10-05  5963  	&trace_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5964  	&red_zone_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5965  	&poison_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5966  	&store_user_attr.attr,
53e15af03be4fda Christoph Lameter 2007-05-06  5967  	&validate_attr.attr,
ab4d5ed5eeda4f5 Christoph Lameter 2010-10-05  5968  #endif
81819f0fc8285a2 Christoph Lameter 2007-05-06  5969  #ifdef CONFIG_ZONE_DMA
81819f0fc8285a2 Christoph Lameter 2007-05-06  5970  	&cache_dma_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  5971  #endif
81819f0fc8285a2 Christoph Lameter 2007-05-06  5972  #ifdef CONFIG_NUMA
9824601ead957a2 Christoph Lameter 2008-01-07  5973  	&remote_node_defrag_ratio_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5974  #endif
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5975  #ifdef CONFIG_SLUB_STATS
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5976  	&alloc_fastpath_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5977  	&alloc_slowpath_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5978  	&free_fastpath_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5979  	&free_slowpath_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5980  	&free_frozen_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5981  	&free_add_partial_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5982  	&free_remove_partial_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5983  	&alloc_from_partial_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5984  	&alloc_slab_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5985  	&alloc_refill_attr.attr,
e36a2652d7d1ad9 Christoph Lameter 2011-06-01  5986  	&alloc_node_mismatch_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5987  	&free_slab_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5988  	&cpuslab_flush_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5989  	&deactivate_full_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5990  	&deactivate_empty_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5991  	&deactivate_to_head_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5992  	&deactivate_to_tail_attr.attr,
8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5993  	&deactivate_remote_frees_attr.attr,
03e404af26dc2ea Christoph Lameter 2011-06-01  5994  	&deactivate_bypass_attr.attr,
65c3376aaca96c6 Christoph Lameter 2008-04-14  5995  	&order_fallback_attr.attr,
b789ef518b2a723 Christoph Lameter 2011-06-01  5996  	&cmpxchg_double_fail_attr.attr,
b789ef518b2a723 Christoph Lameter 2011-06-01  5997  	&cmpxchg_double_cpu_fail_attr.attr,
49e2258586b4236 Christoph Lameter 2011-08-09  5998  	&cpu_partial_alloc_attr.attr,
49e2258586b4236 Christoph Lameter 2011-08-09  5999  	&cpu_partial_free_attr.attr,
8028dcea8abbbd5 Alex Shi          2012-02-03  6000  	&cpu_partial_node_attr.attr,
8028dcea8abbbd5 Alex Shi          2012-02-03  6001  	&cpu_partial_drain_attr.attr,
81819f0fc8285a2 Christoph Lameter 2007-05-06  6002  #endif
4c13dd3b48fcb6f Dmitry Monakhov   2010-02-26  6003  #ifdef CONFIG_FAILSLAB
4c13dd3b48fcb6f Dmitry Monakhov   2010-02-26  6004  	&failslab_attr.attr,
4c13dd3b48fcb6f Dmitry Monakhov   2010-02-26  6005  #endif
346907ceb9d11b9 Vlastimil Babka   2022-11-16  6006  #ifdef CONFIG_HARDENED_USERCOPY
8eb8284b4129061 David Windsor     2017-06-10  6007  	&usersize_attr.attr,
346907ceb9d11b9 Vlastimil Babka   2022-11-16  6008  #endif
b84e04f1baeebe6 Imran Khan        2022-08-15  6009  #ifdef CONFIG_KFENCE
b84e04f1baeebe6 Imran Khan        2022-08-15  6010  	&skip_kfence_attr.attr,
b84e04f1baeebe6 Imran Khan        2022-08-15  6011  #endif
4c13dd3b48fcb6f Dmitry Monakhov   2010-02-26  6012  
81819f0fc8285a2 Christoph Lameter 2007-05-06  6013  	NULL
81819f0fc8285a2 Christoph Lameter 2007-05-06  6014  };
81819f0fc8285a2 Christoph Lameter 2007-05-06  6015  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
