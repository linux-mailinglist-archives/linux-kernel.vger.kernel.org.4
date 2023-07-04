Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8773D746847
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 06:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGDEPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 00:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGDEPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:15:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C780E1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 21:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688444137; x=1719980137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/F+LIQsLzXez+IC1rONpFuok02j+UYPREA6i/RpbJpE=;
  b=IYKFbTatx85NCWGf4IaY+frY/t7IPDVobF8PFtnvrwUaAhNO/sdzVeqX
   ON6kpO3foJdl+8yrNheLPySHej/OFWJ2yNDbu9Y1HZo5O9wMkujZBerOb
   9jFf/Xty4XsbLCKQdOumVIEJmYVLKHdGfNTWSUPlwBwObfoVqMFRvPcgW
   qYDTXj+c6L9lJzLAazw3uw8hs2AMzSBLccndg6tPwfK56O2bWn3QNG1zS
   bPdJc0RAqyi7FqRb46nlikb1Zzp+2NK+tg3uZvXry3Q45ihwCXaWglwZF
   WkH2P2+gZr9ajXpSZzIj9iYXfcyndMNOlwwNSJUbIEZvZ1ZkxkLkrHVER
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="360505716"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="360505716"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 21:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="753933285"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="753933285"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Jul 2023 21:15:33 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGXRs-000Hs7-0x;
        Tue, 04 Jul 2023 04:15:32 +0000
Date:   Tue, 4 Jul 2023 12:15:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Rizzo <matteorizzo@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, jannh@google.com,
        matteorizzo@google.com
Subject: Re: [PATCH] mm/slub: refactor freelist to use custom type
Message-ID: <202307041252.XCQcx0eb-lkp@intel.com>
References: <20230703143820.152479-1-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703143820.152479-1-matteorizzo@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matteo,

kernel test robot noticed the following build errors:

[auto build test ERROR on a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451]

url:    https://github.com/intel-lab-lkp/linux/commits/Matteo-Rizzo/mm-slub-refactor-freelist-to-use-custom-type/20230703-223944
base:   a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
patch link:    https://lore.kernel.org/r/20230703143820.152479-1-matteorizzo%40google.com
patch subject: [PATCH] mm/slub: refactor freelist to use custom type
config: arm-randconfig-r001-20230703 (https://download.01.org/0day-ci/archive/20230704/202307041252.XCQcx0eb-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230704/202307041252.XCQcx0eb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307041252.XCQcx0eb-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/slub.c:368:15: error: unknown type name 'freeptr_t'
   static inline freeptr_t freelist_ptr_encode(const struct kmem_cache *s,
                 ^
>> mm/slub.c:385:10: error: use of undeclared identifier 'freeptr_t'
           return (freeptr_t){.v = (unsigned long)ptr};
                   ^
   mm/slub.c:390:6: error: unknown type name 'freeptr_t'
                                           freeptr_t ptr, unsigned long ptr_addr)
                                           ^
>> mm/slub.c:408:45: error: expected expression
           return freelist_ptr_decode(s, *(freeptr_t *)(ptr_addr),
                                                      ^
   mm/slub.c:408:34: error: use of undeclared identifier 'freeptr_t'
           return freelist_ptr_decode(s, *(freeptr_t *)(ptr_addr),
                                           ^
   mm/slub.c:415:45: error: expected expression
           return freelist_dereference(s, (freeptr_t *)(object + s->offset));
                                                      ^
   mm/slub.c:415:34: error: use of undeclared identifier 'freeptr_t'
           return freelist_dereference(s, (freeptr_t *)(object + s->offset));
                                           ^
   mm/slub.c:439:2: error: use of undeclared identifier 'freeptr_t'
           freeptr_t p;
           ^
   mm/slub.c:446:43: error: expected expression
           copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeof(p));
                                                    ^
   mm/slub.c:446:32: error: use of undeclared identifier 'freeptr_t'
           copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeof(p));
                                         ^
>> mm/slub.c:446:69: error: use of undeclared identifier 'p'
           copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeof(p));
                                                                              ^
   mm/slub.c:446:28: error: use of undeclared identifier 'p'
           copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeof(p));
                                     ^
   mm/slub.c:447:32: error: use of undeclared identifier 'p'
           return freelist_ptr_decode(s, p, freepointer_addr);
                                         ^
   mm/slub.c:459:15: error: expected expression
           *(freeptr_t *)freeptr_addr = freelist_ptr_encode(s, fp, freeptr_addr);
                        ^
   mm/slub.c:459:4: error: use of undeclared identifier 'freeptr_t'
           *(freeptr_t *)freeptr_addr = freelist_ptr_encode(s, fp, freeptr_addr);
             ^
   mm/slub.c:2285:15: warning: variable 'partial_slabs' set but not used [-Wunused-but-set-variable]
           unsigned int partial_slabs = 0;
                        ^
   1 warning and 15 errors generated.


vim +/freeptr_t +385 mm/slub.c

   358	
   359	/********************************************************************
   360	 * 			Core slab cache functions
   361	 *******************************************************************/
   362	
   363	/*
   364	 * Returns freelist pointer (ptr). With hardening, this is obfuscated
   365	 * with an XOR of the address where the pointer is held and a per-cache
   366	 * random number.
   367	 */
 > 368	static inline freeptr_t freelist_ptr_encode(const struct kmem_cache *s,
   369						    void *ptr, unsigned long ptr_addr)
   370	{
   371	#ifdef CONFIG_SLAB_FREELIST_HARDENED
   372		/*
   373		 * When CONFIG_KASAN_SW/HW_TAGS is enabled, ptr_addr might be tagged.
   374		 * Normally, this doesn't cause any issues, as both set_freepointer()
   375		 * and get_freepointer() are called with a pointer with the same tag.
   376		 * However, there are some issues with CONFIG_SLUB_DEBUG code. For
   377		 * example, when __free_slub() iterates over objects in a cache, it
   378		 * passes untagged pointers to check_object(). check_object() in turns
   379		 * calls get_freepointer() with an untagged pointer, which causes the
   380		 * freepointer to be restored incorrectly.
   381		 */
   382		return (freeptr_t){.v = (unsigned long)ptr ^ s->random ^
   383				swab((unsigned long)kasan_reset_tag((void *)ptr_addr))};
   384	#else
 > 385		return (freeptr_t){.v = (unsigned long)ptr};
   386	#endif
   387	}
   388	
   389	static inline void *freelist_ptr_decode(const struct kmem_cache *s,
   390						freeptr_t ptr, unsigned long ptr_addr)
   391	{
   392		void *decoded;
   393	
   394	#ifdef CONFIG_SLAB_FREELIST_HARDENED
   395		/* See the comment in freelist_ptr_encode */
   396		decoded = (void *)(ptr.v ^ s->random ^
   397			swab((unsigned long)kasan_reset_tag((void *)ptr_addr)));
   398	#else
   399		decoded = (void *)ptr.v;
   400	#endif
   401		return decoded;
   402	}
   403	
   404	/* Returns the freelist pointer recorded at location ptr_addr. */
   405	static inline void *freelist_dereference(const struct kmem_cache *s,
   406						 void *ptr_addr)
   407	{
 > 408		return freelist_ptr_decode(s, *(freeptr_t *)(ptr_addr),
   409				    (unsigned long)ptr_addr);
   410	}
   411	
   412	static inline void *get_freepointer(struct kmem_cache *s, void *object)
   413	{
   414		object = kasan_reset_tag(object);
   415		return freelist_dereference(s, (freeptr_t *)(object + s->offset));
   416	}
   417	
   418	#ifndef CONFIG_SLUB_TINY
   419	static void prefetch_freepointer(const struct kmem_cache *s, void *object)
   420	{
   421		prefetchw(object + s->offset);
   422	}
   423	#endif
   424	
   425	/*
   426	 * When running under KMSAN, get_freepointer_safe() may return an uninitialized
   427	 * pointer value in the case the current thread loses the race for the next
   428	 * memory chunk in the freelist. In that case this_cpu_cmpxchg_double() in
   429	 * slab_alloc_node() will fail, so the uninitialized value won't be used, but
   430	 * KMSAN will still check all arguments of cmpxchg because of imperfect
   431	 * handling of inline assembly.
   432	 * To work around this problem, we apply __no_kmsan_checks to ensure that
   433	 * get_freepointer_safe() returns initialized memory.
   434	 */
   435	__no_kmsan_checks
   436	static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
   437	{
   438		unsigned long freepointer_addr;
 > 439		freeptr_t p;
   440	
   441		if (!debug_pagealloc_enabled_static())
   442			return get_freepointer(s, object);
   443	
   444		object = kasan_reset_tag(object);
   445		freepointer_addr = (unsigned long)object + s->offset;
 > 446		copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeof(p));
   447		return freelist_ptr_decode(s, p, freepointer_addr);
   448	}
   449	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
