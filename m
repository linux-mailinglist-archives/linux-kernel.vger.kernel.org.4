Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC046F135B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjD1Ije (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjD1Ijc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:39:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7B7268D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682671170; x=1714207170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q4gh97dpYLmdt332irgmsGH23Tzt8243yUTSoJpwPEU=;
  b=Ch51RK9u95jg1f6EBDQsGRCzQpOXL4t2GbZl28bRzFXXYcDf+iKPheRa
   g4du2eIJ1VbWzFnH2HKYZ4Z2th+dwbRsFIFMLM91/A1Kp1grCFX9g2bPH
   EGJ1dUrYAAB80RQml48idehhDfIn5qwelpkpyc1F6CIY0tB6w14vUDzDK
   UQ8NRUttHdXL/XWKlWcqpcq0QfNRf+sc5UulZmx9UvMqVQnpDdFGOokw0
   Nb6En8CEifli50CNot1QJgxBEu0nanQdBYXgeD+t+IxAs+DyM5HVd7NFA
   FvHAz1PUItB3torob/V+DS6fsXyJwbsuoN+HBe5/nKF8Jsb1zvMkN6kl0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="331992517"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="331992517"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 01:39:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="818924522"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="818924522"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Apr 2023 01:39:28 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psJdX-0000JR-1B;
        Fri, 28 Apr 2023 08:39:27 +0000
Date:   Fri, 28 Apr 2023 16:39:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 27/34] maple_tree: Introduce mas_next_slot() interface
Message-ID: <202304281651.cfC6scj6-lkp@intel.com>
References: <20230425140955.3834476-28-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425140955.3834476-28-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.3 next-20230427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liam-R-Howlett/maple_tree-Fix-static-analyser-cppcheck-issue/20230425-233958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230425140955.3834476-28-Liam.Howlett%40oracle.com
patch subject: [PATCH 27/34] maple_tree: Introduce mas_next_slot() interface
config: i386-randconfig-a005-20230424 (https://download.01.org/0day-ci/archive/20230428/202304281651.cfC6scj6-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0e736b8a8054e7f0b216320d2458a00b54fcd2b0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liam-R-Howlett/maple_tree-Fix-static-analyser-cppcheck-issue/20230425-233958
        git checkout 0e736b8a8054e7f0b216320d2458a00b54fcd2b0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304281651.cfC6scj6-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   lib/maple_tree.c:4710:7: warning: no previous prototype for function 'mas_next_slot' [-Wmissing-prototypes]
   void *mas_next_slot(struct ma_state *mas, unsigned long max)
         ^
   lib/maple_tree.c:4710:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void *mas_next_slot(struct ma_state *mas, unsigned long max)
   ^
   static 
>> lib/maple_tree.c:4780:10: error: implicit declaration of function 'mas_next_slot_limit' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           entry = mas_next_slot_limit(mas, limit);
                   ^
   lib/maple_tree.c:4780:10: note: did you mean 'mas_next_slot'?
   lib/maple_tree.c:4710:7: note: 'mas_next_slot' declared here
   void *mas_next_slot(struct ma_state *mas, unsigned long max)
         ^
>> lib/maple_tree.c:4780:8: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           entry = mas_next_slot_limit(mas, limit);
                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> lib/maple_tree.c:4787:9: warning: incompatible integer to pointer conversion returning 'int' from a function with result type 'void *' [-Wint-conversion]
           return mas_next_slot_limit(mas, limit);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings and 1 error generated.


vim +/mas_next_slot_limit +4780 lib/maple_tree.c

  4701	
  4702	/*
  4703	 * mas_next_slot() - Get the entry in the next slot
  4704	 *
  4705	 * @mas: The maple state
  4706	 * @max: The maximum starting range
  4707	 *
  4708	 * Return: The entry in the next slot which is possibly NULL
  4709	 */
> 4710	void *mas_next_slot(struct ma_state *mas, unsigned long max)
  4711	{
  4712		void __rcu **slots;
  4713		unsigned long *pivots;
  4714		unsigned long pivot;
  4715		enum maple_type type;
  4716		struct maple_node *node;
  4717		unsigned char data_end;
  4718		unsigned long save_point = mas->last;
  4719		void *entry;
  4720	
  4721	retry:
  4722		node = mas_mn(mas);
  4723		type = mte_node_type(mas->node);
  4724		pivots = ma_pivots(node, type);
  4725		data_end = ma_data_end(node, type, pivots, mas->max);
  4726		pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
  4727		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
  4728			goto retry;
  4729	
  4730		if (pivot >= max)
  4731			return NULL;
  4732	
  4733		if (likely(data_end > mas->offset)) {
  4734			mas->offset++;
  4735			mas->index = mas->last + 1;
  4736		} else  {
  4737			if (mas_next_node(mas, node, max)) {
  4738				mas_rewalk(mas, save_point);
  4739				goto retry;
  4740			}
  4741	
  4742			if (mas_is_none(mas))
  4743				return NULL;
  4744	
  4745			mas->offset = 0;
  4746			mas->index = mas->min;
  4747			node = mas_mn(mas);
  4748			type = mte_node_type(mas->node);
  4749			pivots = ma_pivots(node, type);
  4750		}
  4751	
  4752		slots = ma_slots(node, type);
  4753		mas->last = mas_logical_pivot(mas, pivots, mas->offset, type);
  4754		entry = mas_slot(mas, slots, mas->offset);
  4755		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
  4756			goto retry;
  4757	
  4758		return entry;
  4759	}
  4760	
  4761	/*
  4762	 * mas_next_entry() - Internal function to get the next entry.
  4763	 * @mas: The maple state
  4764	 * @limit: The maximum range start.
  4765	 *
  4766	 * Set the @mas->node to the next entry and the range_start to
  4767	 * the beginning value for the entry.  Does not check beyond @limit.
  4768	 * Sets @mas->index and @mas->last to the limit if it is hit.
  4769	 * Restarts on dead nodes.
  4770	 *
  4771	 * Return: the next entry or %NULL.
  4772	 */
  4773	static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
  4774	{
  4775		void *entry = NULL;
  4776	
  4777		if (mas->last >= limit)
  4778			return NULL;
  4779	
> 4780		entry = mas_next_slot_limit(mas, limit);
  4781		if (entry)
  4782			return entry;
  4783	
  4784		if (mas_is_none(mas))
  4785			return NULL;
  4786	
> 4787		return mas_next_slot_limit(mas, limit);
  4788	}
  4789	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
