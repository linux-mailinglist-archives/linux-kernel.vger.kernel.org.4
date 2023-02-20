Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC8469CBFC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjBTNXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjBTNXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:23:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EF98690
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676899401; x=1708435401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A6LhRpr42B3nwFfoj1JoUbQMjjWOTcLN6oT7PjbxPc8=;
  b=YHqSlq2JG9mQFcwZylzKSTYFu862jdSi3WmU1GfI1SrlN4W/owb8Z3+u
   Nr6BJfTnfpYcj2XSle4zQCTez2zUbtMYv5Up5yVanQaOZooF7eL7QB9m1
   ZB753Hrx0YIUMztLhex+C3Mx13IizMQkqMjGCYHiRZzzyDDYhMMwmyT+X
   MgmbpIxgQPliuRebOZ7FpYYrUuU3BG+qr/B2GK8onayyNkLnrYUF8l380
   de9IjoFlpeGogo+2iDM312b1cC9oxakvWkWSkCyFCiJ0n3pzDehD+5/Bs
   AlGwizJwiYMZeJy3N0bwK63hxxBFqVPIW4QcKIzRstoMHCpVZICS5NykX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="330112820"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="330112820"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 05:23:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="673361962"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="673361962"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Feb 2023 05:23:17 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pU68S-000Dw1-2K;
        Mon, 20 Feb 2023 13:23:16 +0000
Date:   Mon, 20 Feb 2023 21:22:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, tkhai@ya.ru,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 3/5] mm: shrinkers: make count and scan in shrinker
 debugfs lockless
Message-ID: <202302202134.OFjSh3rl-lkp@intel.com>
References: <20230220091637.64865-4-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220091637.64865-4-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20230220]
[cannot apply to device-mapper-dm/for-next linus/master v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/mm-vmscan-make-global-slab-shrink-lockless/20230220-171954
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230220091637.64865-4-zhengqi.arch%40bytedance.com
patch subject: [PATCH 3/5] mm: shrinkers: make count and scan in shrinker debugfs lockless
config: riscv-randconfig-r036-20230219 (https://download.01.org/0day-ci/archive/20230220/202302202134.OFjSh3rl-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/b5b7259339a7a5cfae5a120356750c5a9e151d12
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qi-Zheng/mm-vmscan-make-global-slab-shrink-lockless/20230220-171954
        git checkout b5b7259339a7a5cfae5a120356750c5a9e151d12
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302202134.OFjSh3rl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/shrinker_debug.c:88:11: warning: variable 'ret' is used uninitialized whenever 'do' loop exits because its condition is false [-Wsometimes-uninitialized]
           } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/shrinker_debug.c:93:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   mm/shrinker_debug.c:88:11: note: remove the condition if it is always true
           } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    1
>> mm/shrinker_debug.c:78:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (!memcg_aware) {
                       ^~~~~~~~~~~~
   mm/shrinker_debug.c:93:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   mm/shrinker_debug.c:78:3: note: remove the 'if' if its condition is always false
                   if (!memcg_aware) {
                   ^~~~~~~~~~~~~~~~~~~
   mm/shrinker_debug.c:53:9: note: initialize the variable 'ret' to silence this warning
           int ret, nid, srcu_idx;
                  ^
                   = 0
   2 warnings generated.


vim +88 mm/shrinker_debug.c

5035ebc644aec9 Roman Gushchin 2022-05-31  45  
5035ebc644aec9 Roman Gushchin 2022-05-31  46  static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
5035ebc644aec9 Roman Gushchin 2022-05-31  47  {
5035ebc644aec9 Roman Gushchin 2022-05-31  48  	struct shrinker *shrinker = m->private;
5035ebc644aec9 Roman Gushchin 2022-05-31  49  	unsigned long *count_per_node;
5035ebc644aec9 Roman Gushchin 2022-05-31  50  	struct mem_cgroup *memcg;
5035ebc644aec9 Roman Gushchin 2022-05-31  51  	unsigned long total;
5035ebc644aec9 Roman Gushchin 2022-05-31  52  	bool memcg_aware;
b5b7259339a7a5 Qi Zheng       2023-02-20  53  	int ret, nid, srcu_idx;
5035ebc644aec9 Roman Gushchin 2022-05-31  54  
5035ebc644aec9 Roman Gushchin 2022-05-31  55  	count_per_node = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
5035ebc644aec9 Roman Gushchin 2022-05-31  56  	if (!count_per_node)
5035ebc644aec9 Roman Gushchin 2022-05-31  57  		return -ENOMEM;
5035ebc644aec9 Roman Gushchin 2022-05-31  58  
b5b7259339a7a5 Qi Zheng       2023-02-20  59  	srcu_idx = srcu_read_lock(&shrinker_srcu);
5035ebc644aec9 Roman Gushchin 2022-05-31  60  
5035ebc644aec9 Roman Gushchin 2022-05-31  61  	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
5035ebc644aec9 Roman Gushchin 2022-05-31  62  
5035ebc644aec9 Roman Gushchin 2022-05-31  63  	memcg = mem_cgroup_iter(NULL, NULL, NULL);
5035ebc644aec9 Roman Gushchin 2022-05-31  64  	do {
5035ebc644aec9 Roman Gushchin 2022-05-31  65  		if (memcg && !mem_cgroup_online(memcg))
5035ebc644aec9 Roman Gushchin 2022-05-31  66  			continue;
5035ebc644aec9 Roman Gushchin 2022-05-31  67  
5035ebc644aec9 Roman Gushchin 2022-05-31  68  		total = shrinker_count_objects(shrinker,
5035ebc644aec9 Roman Gushchin 2022-05-31  69  					       memcg_aware ? memcg : NULL,
5035ebc644aec9 Roman Gushchin 2022-05-31  70  					       count_per_node);
5035ebc644aec9 Roman Gushchin 2022-05-31  71  		if (total) {
5035ebc644aec9 Roman Gushchin 2022-05-31  72  			seq_printf(m, "%lu", mem_cgroup_ino(memcg));
5035ebc644aec9 Roman Gushchin 2022-05-31  73  			for_each_node(nid)
5035ebc644aec9 Roman Gushchin 2022-05-31  74  				seq_printf(m, " %lu", count_per_node[nid]);
5035ebc644aec9 Roman Gushchin 2022-05-31  75  			seq_putc(m, '\n');
5035ebc644aec9 Roman Gushchin 2022-05-31  76  		}
5035ebc644aec9 Roman Gushchin 2022-05-31  77  
5035ebc644aec9 Roman Gushchin 2022-05-31 @78  		if (!memcg_aware) {
5035ebc644aec9 Roman Gushchin 2022-05-31  79  			mem_cgroup_iter_break(NULL, memcg);
5035ebc644aec9 Roman Gushchin 2022-05-31  80  			break;
5035ebc644aec9 Roman Gushchin 2022-05-31  81  		}
5035ebc644aec9 Roman Gushchin 2022-05-31  82  
5035ebc644aec9 Roman Gushchin 2022-05-31  83  		if (signal_pending(current)) {
5035ebc644aec9 Roman Gushchin 2022-05-31  84  			mem_cgroup_iter_break(NULL, memcg);
5035ebc644aec9 Roman Gushchin 2022-05-31  85  			ret = -EINTR;
5035ebc644aec9 Roman Gushchin 2022-05-31  86  			break;
5035ebc644aec9 Roman Gushchin 2022-05-31  87  		}
5035ebc644aec9 Roman Gushchin 2022-05-31 @88  	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
5035ebc644aec9 Roman Gushchin 2022-05-31  89  
b5b7259339a7a5 Qi Zheng       2023-02-20  90  	srcu_read_unlock(&shrinker_srcu, srcu_idx);
5035ebc644aec9 Roman Gushchin 2022-05-31  91  
5035ebc644aec9 Roman Gushchin 2022-05-31  92  	kfree(count_per_node);
5035ebc644aec9 Roman Gushchin 2022-05-31 @93  	return ret;
5035ebc644aec9 Roman Gushchin 2022-05-31  94  }
5035ebc644aec9 Roman Gushchin 2022-05-31  95  DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
5035ebc644aec9 Roman Gushchin 2022-05-31  96  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
