Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F796EEBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbjDZBmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbjDZBmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:42:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB92817A3A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682473335; x=1714009335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E4qz96K/CPS29oTxjqTt8iqKyA38KsS3TZP8VeYZyH8=;
  b=Iev2djeG9sD/JpPW9e8fDkSDRCZpnzBVN1Q4EgDA5LeKwI9CfeqPukg+
   8Gx7Fy1a1+CrkBuGhfruHc94d8NcmvJaAtIk0bfmyh32Jg9fhLuUMi2O1
   Yt0xX3bIUAZlNyLvEHrvrGbyhG+fqRdDJGyPTtVlmXFMSI6o4OAYJ8s9D
   0HbEfQaUBHn1AF6l7rt44cP059xKBDUlIhBh63bbhSVayu5qKsjM1Nmgu
   foF+9czuRwOZBEAdLXIT2wIC2TG6SfQqE0MWeVgyoyUnom1hF4BqzkT+N
   WbLSgLCLHQZgBKgAuWtVMLzMjGldGQuwttGFOwhDer8eauLVul2Og87p2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="331183636"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="331183636"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 18:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="687732075"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="687732075"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Apr 2023 18:42:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prUAb-000jxg-0W;
        Wed, 26 Apr 2023 01:42:09 +0000
Date:   Wed, 26 Apr 2023 09:41:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 33/34] maple_tree: Add testing for mas_{prev,next}_range()
Message-ID: <202304260916.KTgrhA2f-lkp@intel.com>
References: <20230425140955.3834476-34-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425140955.3834476-34-Liam.Howlett@oracle.com>
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
[also build test ERROR on linus/master v6.3 next-20230425]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liam-R-Howlett/maple_tree-Fix-static-analyser-cppcheck-issue/20230425-233958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230425140955.3834476-34-Liam.Howlett%40oracle.com
patch subject: [PATCH 33/34] maple_tree: Add testing for mas_{prev,next}_range()
config: hexagon-randconfig-r045-20230424 (https://download.01.org/0day-ci/archive/20230426/202304260916.KTgrhA2f-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/571139f33a7ede9db66c7892c40e88ed66a32bc5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liam-R-Howlett/maple_tree-Fix-static-analyser-cppcheck-issue/20230425-233958
        git checkout 571139f33a7ede9db66c7892c40e88ed66a32bc5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304260916.KTgrhA2f-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_maple_tree.c:3437:17: error: call to undeclared function 'mas_find_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   void *entry = mas_find_range(&mas, ULONG_MAX);
                                 ^
>> lib/test_maple_tree.c:3437:9: error: incompatible integer to pointer conversion initializing 'void *' with an expression of type 'int' [-Wint-conversion]
                   void *entry = mas_find_range(&mas, ULONG_MAX);
                         ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/test_maple_tree.c:3443:2: error: call to undeclared function 'mas_find_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           mas_contiguous(&mas, test, ULONG_MAX) {
           ^
   include/linux/maple_tree.h:545:22: note: expanded from macro 'mas_contiguous'
           while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
                               ^
>> lib/test_maple_tree.c:3443:2: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           mas_contiguous(&mas, test, ULONG_MAX) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/maple_tree.h:545:20: note: expanded from macro 'mas_contiguous'
           while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
                             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/test_maple_tree.c:3453:2: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           mas_contiguous(&mas, test, ULONG_MAX) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/maple_tree.h:545:20: note: expanded from macro 'mas_contiguous'
           while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
                             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/test_maple_tree.c:3464:2: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           mas_contiguous(&mas, test, 340) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/maple_tree.h:545:20: note: expanded from macro 'mas_contiguous'
           while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
                             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/test_maple_tree.c:3476:7: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           test = mas_find_range(&mas, ULONG_MAX);
                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> lib/test_maple_tree.c:3482:9: error: call to undeclared function 'mas_find_range_rev'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           test = mas_find_range_rev(&mas, 0);
                  ^
   lib/test_maple_tree.c:3482:7: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           test = mas_find_range_rev(&mas, 0);
                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/test_maple_tree.c:3487:7: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           test = mas_find_range_rev(&mas, 0);
                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/test_maple_tree.c:3493:7: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           test = mas_find_range_rev(&mas, 340);
                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   11 errors generated.


vim +/mas_find_range +3437 lib/test_maple_tree.c

  3358	
  3359	static noinline void __init check_slot_iterators(struct maple_tree *mt)
  3360	{
  3361		MA_STATE(mas, mt, 0, 0);
  3362		unsigned long i, index = 40;
  3363		unsigned char offset = 0;
  3364		void *test;
  3365	
  3366		mt_set_non_kernel(99999);
  3367	
  3368		mas_lock(&mas);
  3369		for (i = 0; i <= index; i++) {
  3370			unsigned long end = 5;
  3371			if (i > 20 && i < 35)
  3372				end = 9;
  3373			mas_set_range(&mas, i*10, i*10 + end);
  3374			mas_store_gfp(&mas, xa_mk_value(i), GFP_KERNEL);
  3375		}
  3376	
  3377		i = 21;
  3378		mas_set(&mas, i*10);
  3379		MAS_BUG_ON(&mas, mas_walk(&mas) != xa_mk_value(i));
  3380		MAS_BUG_ON(&mas, mas_prev_range(&mas, 0) != NULL);
  3381		MAS_BUG_ON(&mas, mas.index != 206);
  3382		MAS_BUG_ON(&mas, mas.last != 209);
  3383	
  3384		i--;
  3385		MAS_BUG_ON(&mas, mas_prev_range(&mas, 0) != xa_mk_value(i));
  3386		MAS_BUG_ON(&mas, mas.index != 200);
  3387		MAS_BUG_ON(&mas, mas.last != 205);
  3388	
  3389		i = 25;
  3390		mas_set(&mas, i*10);
  3391		MAS_BUG_ON(&mas, mas_walk(&mas) != xa_mk_value(i));
  3392		MAS_BUG_ON(&mas, mas.offset != 0);
  3393	
  3394		/* Previous range is in another node */
  3395		i--;
  3396		MAS_BUG_ON(&mas, mas_prev_range(&mas, 0) != xa_mk_value(i));
  3397		MAS_BUG_ON(&mas, mas.index != 240);
  3398		MAS_BUG_ON(&mas, mas.last != 249);
  3399	
  3400		/* Shift back with mas_next */
  3401		i++;
  3402		MAS_BUG_ON(&mas, mas_next_range(&mas, ULONG_MAX) != xa_mk_value(i));
  3403		MAS_BUG_ON(&mas, mas.index != 250);
  3404		MAS_BUG_ON(&mas, mas.last != 259);
  3405	
  3406		i = 33;
  3407		mas_set(&mas, i*10);
  3408		MAS_BUG_ON(&mas, mas_walk(&mas) != xa_mk_value(i));
  3409		MAS_BUG_ON(&mas, mas.index != 330);
  3410		MAS_BUG_ON(&mas, mas.last != 339);
  3411	
  3412		/* Next range is in another node */
  3413		i++;
  3414		MAS_BUG_ON(&mas, mas_next_range(&mas, ULONG_MAX) != xa_mk_value(i));
  3415		MAS_BUG_ON(&mas, mas.offset != 0);
  3416		MAS_BUG_ON(&mas, mas.index != 340);
  3417		MAS_BUG_ON(&mas, mas.last != 349);
  3418	
  3419		/* Next out of range */
  3420		i++;
  3421		MAS_BUG_ON(&mas, mas_next_range(&mas, i*10 - 1) != NULL);
  3422		/* maple state does not move */
  3423		MAS_BUG_ON(&mas, mas.offset != 0);
  3424		MAS_BUG_ON(&mas, mas.index != 340);
  3425		MAS_BUG_ON(&mas, mas.last != 349);
  3426	
  3427		/* Prev out of range */
  3428		i--;
  3429		MAS_BUG_ON(&mas, mas_prev_range(&mas, i*10 + 1) != NULL);
  3430		/* maple state does not move */
  3431		MAS_BUG_ON(&mas, mas.offset != 0);
  3432		MAS_BUG_ON(&mas, mas.index != 340);
  3433		MAS_BUG_ON(&mas, mas.last != 349);
  3434	
  3435		mas_set(&mas, 210);
  3436		for (i = 210; i<= 350; i += 10) {
> 3437			void *entry = mas_find_range(&mas, ULONG_MAX);
  3438	
  3439			MAS_BUG_ON(&mas, entry != xa_mk_value(i/10));
  3440		}
  3441	
  3442		mas_set(&mas, 0);
> 3443		mas_contiguous(&mas, test, ULONG_MAX) {
  3444			MAS_BUG_ON(&mas, test != xa_mk_value(0));
  3445			MAS_BUG_ON(&mas, mas.index != 0);
  3446			MAS_BUG_ON(&mas, mas.last != 5);
  3447		}
  3448		MAS_BUG_ON(&mas, test != NULL);
  3449		MAS_BUG_ON(&mas, mas.index != 6);
  3450		MAS_BUG_ON(&mas, mas.last != 9);
  3451	
  3452		mas_set(&mas, 6);
  3453		mas_contiguous(&mas, test, ULONG_MAX) {
  3454			MAS_BUG_ON(&mas, test != xa_mk_value(1));
  3455			MAS_BUG_ON(&mas, mas.index != 10);
  3456			MAS_BUG_ON(&mas, mas.last != 15);
  3457		}
  3458		MAS_BUG_ON(&mas, test != NULL);
  3459		MAS_BUG_ON(&mas, mas.index != 16);
  3460		MAS_BUG_ON(&mas, mas.last != 19);
  3461	
  3462		i = 210;
  3463		mas_set(&mas, i);
  3464		mas_contiguous(&mas, test, 340) {
  3465			MAS_BUG_ON(&mas, test != xa_mk_value(i/10));
  3466			MAS_BUG_ON(&mas, mas.index != i);
  3467			MAS_BUG_ON(&mas, mas.last != i+9);
  3468			i+=10;
  3469			offset = mas.offset;
  3470		}
  3471		/* Hit the limit, iterator is at the limit. */
  3472		MAS_BUG_ON(&mas, offset != mas.offset);
  3473		MAS_BUG_ON(&mas, test != NULL);
  3474		MAS_BUG_ON(&mas, mas.index != 340);
  3475		MAS_BUG_ON(&mas, mas.last != 349);
  3476		test = mas_find_range(&mas, ULONG_MAX);
  3477		MAS_BUG_ON(&mas, test != xa_mk_value(35));
  3478		MAS_BUG_ON(&mas, mas.index != 350);
  3479		MAS_BUG_ON(&mas, mas.last != 355);
  3480	
  3481	
> 3482		test = mas_find_range_rev(&mas, 0);
  3483		MAS_BUG_ON(&mas, test != xa_mk_value(34));
  3484		MAS_BUG_ON(&mas, mas.index != 340);
  3485		MAS_BUG_ON(&mas, mas.last != 349);
  3486		mas_set(&mas, 345);
  3487		test = mas_find_range_rev(&mas, 0);
  3488		MAS_BUG_ON(&mas, test != xa_mk_value(34));
  3489		MAS_BUG_ON(&mas, mas.index != 340);
  3490		MAS_BUG_ON(&mas, mas.last != 349);
  3491	
  3492		offset = mas.offset;
  3493		test = mas_find_range_rev(&mas, 340);
  3494		MAS_BUG_ON(&mas, offset != mas.offset);
  3495		MAS_BUG_ON(&mas, test != NULL);
  3496		MAS_BUG_ON(&mas, mas.index != 340);
  3497		MAS_BUG_ON(&mas, mas.last != 349);
  3498	
  3499		mas_unlock(&mas);
  3500		mt_set_non_kernel(0);
  3501	}
  3502	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
