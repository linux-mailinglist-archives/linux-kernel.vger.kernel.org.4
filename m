Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D846BC356
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCPBcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCPBcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:32:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C6087D87;
        Wed, 15 Mar 2023 18:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678930340; x=1710466340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S95cFCVhbVDe/hqBvRJWMaoCaqk2ZdtQHjd7uKx/XA0=;
  b=NfUQ9dv9P5aEcUEJb2i016o5dg12qWuHwP+JbRXYQGWtUZEuM0CU9WO8
   QqGI8r2ix1lFNO2pEivILcTzT5gcFfjgCUugA0zUFKLF4PRBxwZHkj+Fs
   D45tACzGPinHyzUKek83laJGL3JV0Ul0hmncZpAG7V966C1wzhCfzNWEh
   HfksZOdBAZwMVxP4OxJwAcFGvOuJN5KIOteNN7kcBtkMU0pcMZVl1iyLN
   00c6kvJKIapzu6ktv9FyNQF72AYHsh3wxIjDOKpZmVxFAA6rydLMw2HDy
   BVTatybPyOPy5HKufiBO2i7lkbJ0t0sSmmlOPN6gY4FN0Kl5vhvLBkGEt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="336552638"
X-IronPort-AV: E=Sophos;i="5.98,264,1673942400"; 
   d="scan'208";a="336552638"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 18:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="672954469"
X-IronPort-AV: E=Sophos;i="5.98,264,1673942400"; 
   d="scan'208";a="672954469"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2023 18:32:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pccTX-0008Cv-1B;
        Thu, 16 Mar 2023 01:32:15 +0000
Date:   Thu, 16 Mar 2023 09:32:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Desnes Nunes <desnesn@redhat.com>, iommu@lists.linux.dev,
        linux-scsi@vger.kernel.org, storagedev@microchip.com,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, hch@lst.de,
        martin.petersen@oracle.com, don.brace@microchip.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com, jejb@linux.ibm.com,
        jsnitsel@redhat.com, Desnes Nunes <desnesn@redhat.com>
Subject: Re: [PATCH 2/3] dma-debug: add cacheline to user/kernel space dump
 messages
Message-ID: <202303160927.dwt0jHFb-lkp@intel.com>
References: <20230315192130.970021-3-desnesn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315192130.970021-3-desnesn@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Desnes,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jejb-scsi/for-next]
[also build test WARNING on mkp-scsi/for-next linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Desnes-Nunes/dma-debug-small-dma_debug_entry-s-comment-and-variable-name-updates/20230316-032542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230315192130.970021-3-desnesn%40redhat.com
patch subject: [PATCH 2/3] dma-debug: add cacheline to user/kernel space dump messages
config: arm-randconfig-r046-20230312 (https://download.01.org/0day-ci/archive/20230316/202303160927.dwt0jHFb-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/ae3f8fdd17c54b837d476952733456723c472ed8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Desnes-Nunes/dma-debug-small-dma_debug_entry-s-comment-and-variable-name-updates/20230316-032542
        git checkout ae3f8fdd17c54b837d476952733456723c472ed8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160927.dwt0jHFb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/dma/debug.c:541:7: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                                            cln, dir2name[entry->direction],
                                            ^~~
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   kernel/dma/debug.c:574:8: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                                      cln, dir2name[entry->direction],
                                      ^~~
   2 warnings generated.


vim +541 kernel/dma/debug.c

   518	
   519	/*
   520	 * Dump mappings entries on kernel space for debugging purposes
   521	 */
   522	void debug_dma_dump_mappings(struct device *dev)
   523	{
   524		int idx;
   525		phys_addr_t cln;
   526	
   527		for (idx = 0; idx < HASH_SIZE; idx++) {
   528			struct hash_bucket *bucket = &dma_entry_hash[idx];
   529			struct dma_debug_entry *entry;
   530			unsigned long flags;
   531	
   532			spin_lock_irqsave(&bucket->lock, flags);
   533			list_for_each_entry(entry, &bucket->list, list) {
   534				if (!dev || dev == entry->dev) {
   535					cln = to_cacheline_number(entry);
   536					dev_info(entry->dev,
   537						 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
   538						 type2name[entry->type], idx,
   539						 phys_addr(entry), entry->pfn,
   540						 entry->dev_addr, entry->size,
 > 541						 cln, dir2name[entry->direction],
   542						 maperr2str[entry->map_err_type]);
   543				}
   544			}
   545			spin_unlock_irqrestore(&bucket->lock, flags);
   546	
   547			cond_resched();
   548		}
   549	}
   550	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
