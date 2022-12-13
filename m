Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F238164B449
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiLMLga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbiLMLgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:36:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6DF1C42B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:36:07 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NWbyK4zW9zRpqd;
        Tue, 13 Dec 2022 19:35:05 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 19:36:04 +0800
Message-ID: <3312eb55-6ce5-67e3-389f-4937002423cd@huawei.com>
Date:   Tue, 13 Dec 2022 19:36:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 1/8] mm: memory_hotplug: add pfn_to_online_folio()
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <damon@lists.linux.dev>,
        <vishal.moola@gmail.com>, <willy@infradead.org>
References: <20221213092735.187924-2-wangkefeng.wang@huawei.com>
 <202212131842.5xNHRahj-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202212131842.5xNHRahj-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/13 19:13, kernel test robot wrote:
> Hi Kefeng,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.1]
> [cannot apply to akpm-mm/mm-everything next-20221213]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm-converted-page-idle-and-damon-to-use-folios/20221213-171230
> patch link:    https://lore.kernel.org/r/20221213092735.187924-2-wangkefeng.wang%40huawei.com
> patch subject: [PATCH -next 1/8] mm: memory_hotplug: add pfn_to_online_folio()
> config: alpha-allyesconfig
> compiler: alpha-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/6549c7ce5345695320d1dadef2aceff6e76d34f4
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Kefeng-Wang/mm-converted-page-idle-and-damon-to-use-folios/20221213-171230
>          git checkout 6549c7ce5345695320d1dadef2aceff6e76d34f4
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha prepare
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>     In file included from include/linux/mmzone.h:1245,
>                      from include/linux/gfp.h:7,
>                      from include/linux/percpu_counter.h:16,
>                      from include/linux/sched/user.h:7,
>                      from include/linux/cred.h:17,
>                      from include/linux/sched/signal.h:10,
>                      from include/linux/ptrace.h:7,
>                      from arch/alpha/kernel/asm-offsets.c:11:
>     include/linux/memory_hotplug.h: In function 'pfn_to_online_folio':
>>> include/linux/memory_hotplug.h:230:13: error: implicit declaration of function 'pfn_valid'; did you mean 'gid_valid'? [-Werror=implicit-function-declaration]
>       230 |         if (pfn_valid(pfn))                     \
>           |             ^~~~~~~~~
>     include/linux/memory_hotplug.h:270:29: note: in expansion of macro 'pfn_to_online_page'
>       270 |         struct page *page = pfn_to_online_page(pfn);
>           |                             ^~~~~~~~~~~~~~~~~~
>     In file included from arch/alpha/include/asm/page.h:94,
>                      from include/linux/shm.h:6,
>                      from include/linux/sched.h:16,
>                      from arch/alpha/kernel/asm-offsets.c:10:
>>> include/asm-generic/memory_model.h:41:37: error: implicit declaration of function '__pfn_to_section' [-Werror=implicit-function-declaration]
>        41 |         struct mem_section *__sec = __pfn_to_section(__pfn);    \
>           |                                     ^~~~~~~~~~~~~~~~
>     include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
>        53 | #define pfn_to_page __pfn_to_page
>           |                     ^~~~~~~~~~~~~
>     include/linux/memory_hotplug.h:231:27: note: in expansion of macro 'pfn_to_page'
>       231 |                 ___page = pfn_to_page(pfn);     \
>           |                           ^~~~~~~~~~~
>     include/linux/memory_hotplug.h:270:29: note: in expansion of macro 'pfn_to_online_page'
>       270 |         struct page *page = pfn_to_online_page(pfn);
>           |                             ^~~~~~~~~~~~~~~~~~
>>> include/asm-generic/memory_model.h:41:37: warning: initialization of 'struct mem_section *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>        41 |         struct mem_section *__sec = __pfn_to_section(__pfn);    \
>           |                                     ^~~~~~~~~~~~~~~~
>     include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
>        53 | #define pfn_to_page __pfn_to_page
>           |                     ^~~~~~~~~~~~~
>     include/linux/memory_hotplug.h:231:27: note: in expansion of macro 'pfn_to_page'
>       231 |                 ___page = pfn_to_page(pfn);     \
>           |                           ^~~~~~~~~~~
>     include/linux/memory_hotplug.h:270:29: note: in expansion of macro 'pfn_to_online_page'
>       270 |         struct page *page = pfn_to_online_page(pfn);
>           |                             ^~~~~~~~~~~~~~~~~~
>     include/asm-generic/memory_model.h:41:37: note: (near initialization for 'page')
>        41 |         struct mem_section *__sec = __pfn_to_section(__pfn);    \
>           |                                     ^~~~~~~~~~~~~~~~
>     include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
>        53 | #define pfn_to_page __pfn_to_page
>           |                     ^~~~~~~~~~~~~
>     include/linux/memory_hotplug.h:231:27: note: in expansion of macro 'pfn_to_page'
>       231 |                 ___page = pfn_to_page(pfn);     \
>           |                           ^~~~~~~~~~~
>     include/linux/memory_hotplug.h:270:29: note: in expansion of macro 'pfn_to_online_page'
>       270 |         struct page *page = pfn_to_online_page(pfn);
>           |                             ^~~~~~~~~~~~~~~~~~
>>> include/asm-generic/memory_model.h:42:9: error: implicit declaration of function '__section_mem_map_addr' [-Werror=implicit-function-declaration]
>        42 |         __section_mem_map_addr(__sec) + __pfn;          \
>           |         ^~~~~~~~~~~~~~~~~~~~~~
>     include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
>        53 | #define pfn_to_page __pfn_to_page
>           |                     ^~~~~~~~~~~~~
>     include/linux/memory_hotplug.h:231:27: note: in expansion of macro 'pfn_to_page'
>       231 |                 ___page = pfn_to_page(pfn);     \
>           |                           ^~~~~~~~~~~
>     include/linux/memory_hotplug.h:270:29: note: in expansion of macro 'pfn_to_online_page'
>       270 |         struct page *page = pfn_to_online_page(pfn);
>           |                             ^~~~~~~~~~~~~~~~~~
>>> include/linux/memory_hotplug.h:231:25: warning: assignment to 'struct page *' from 'long unsigned int' makes pointer from integer without a cast [-Wint-conversion]
>       231 |                 ___page = pfn_to_page(pfn);     \
>           |                         ^
>     include/linux/memory_hotplug.h:270:29: note: in expansion of macro 'pfn_to_online_page'
>       270 |         struct page *page = pfn_to_online_page(pfn);
>           |                             ^~~~~~~~~~~~~~~~~~
>     include/linux/mmzone.h: At top level:
>>> include/linux/mmzone.h:1740:28: error: conflicting types for '__section_mem_map_addr'; have 'struct page *(struct mem_section *)'
>      1740 | static inline struct page *__section_mem_map_addr(struct mem_section *section)
>           |                            ^~~~~~~~~~~~~~~~~~~~~~
>     include/asm-generic/memory_model.h:42:9: note: previous implicit declaration of '__section_mem_map_addr' with type 'int()'
>        42 |         __section_mem_map_addr(__sec) + __pfn;          \
>           |         ^~~~~~~~~~~~~~~~~~~~~~
>     include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
>        53 | #define pfn_to_page __pfn_to_page
>           |                     ^~~~~~~~~~~~~
>     include/linux/memory_hotplug.h:231:27: note: in expansion of macro 'pfn_to_page'
>       231 |                 ___page = pfn_to_page(pfn);     \
>           |                           ^~~~~~~~~~~
>     include/linux/memory_hotplug.h:270:29: note: in expansion of macro 'pfn_to_online_page'
>       270 |         struct page *page = pfn_to_online_page(pfn);
>           |                             ^~~~~~~~~~~~~~~~~~
>>> include/linux/mmzone.h:1801:35: error: conflicting types for '__pfn_to_section'; have 'struct mem_section *(long unsigned int)'
>      1801 | static inline struct mem_section *__pfn_to_section(unsigned long pfn)
>           |                                   ^~~~~~~~~~~~~~~~
>     include/asm-generic/memory_model.h:41:37: note: previous implicit declaration of '__pfn_to_section' with type 'int()'
>        41 |         struct mem_section *__sec = __pfn_to_section(__pfn);    \
>           |                                     ^~~~~~~~~~~~~~~~
>     include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
>        53 | #define pfn_to_page __pfn_to_page
>           |                     ^~~~~~~~~~~~~
>     include/linux/memory_hotplug.h:231:27: note: in expansion of macro 'pfn_to_page'
>       231 |                 ___page = pfn_to_page(pfn);     \
>           |                           ^~~~~~~~~~~
>     include/linux/memory_hotplug.h:270:29: note: in expansion of macro 'pfn_to_online_page'
>       270 |         struct page *page = pfn_to_online_page(pfn);
>           |                             ^~~~~~~~~~~~~~~~~~
>>> include/linux/mmzone.h:1839:19: error: static declaration of 'pfn_valid' follows non-static declaration
>      1839 | static inline int pfn_valid(unsigned long pfn)
>           |                   ^~~~~~~~~
>     include/linux/memory_hotplug.h:230:13: note: previous implicit declaration of 'pfn_valid' with type 'int()'
>       230 |         if (pfn_valid(pfn))                     \
>           |             ^~~~~~~~~
>     include/linux/memory_hotplug.h:270:29: note: in expansion of macro 'pfn_to_online_page'
>       270 |         struct page *page = pfn_to_online_page(pfn);
>           |                             ^~~~~~~~~~~~~~~~~~
>     arch/alpha/kernel/asm-offsets.c:15:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
>        15 | void foo(void)
>           |      ^~~
>     cc1: some warnings being treated as errors
>     make[2]: *** [scripts/Makefile.build:118: arch/alpha/kernel/asm-offsets.s] Error 1
>     make[2]: Target 'prepare' not remade because of errors.
>     make[1]: *** [Makefile:1272: prepare0] Error 2
>     make[1]: Target 'prepare' not remade because of errors.
>     make: *** [Makefile:231: __sub-make] Error 2
>     make: Target 'prepare' not remade because of errors.
>
>
> vim +230 include/linux/memory_hotplug.h
Thanks, it seems that we need use macro definition instead of inline 
function, will update in the next version.
>
> b4a0215e11dcfe Kefeng Wang  2022-08-27  225
> 208d54e5513c0c Dave Hansen  2005-10-29  226  #else /* ! CONFIG_MEMORY_HOTPLUG */
> 2d070eab2e8270 Michal Hocko 2017-07-06  227  #define pfn_to_online_page(pfn)			\
> 2d070eab2e8270 Michal Hocko 2017-07-06  228  ({						\
> 2d070eab2e8270 Michal Hocko 2017-07-06  229  	struct page *___page = NULL;		\
> 2d070eab2e8270 Michal Hocko 2017-07-06 @230  	if (pfn_valid(pfn))			\
> 2d070eab2e8270 Michal Hocko 2017-07-06 @231  		___page = pfn_to_page(pfn);	\
> 2d070eab2e8270 Michal Hocko 2017-07-06  232  	___page;				\
> 2d070eab2e8270 Michal Hocko 2017-07-06  233   })
> 2d070eab2e8270 Michal Hocko 2017-07-06  234
>
