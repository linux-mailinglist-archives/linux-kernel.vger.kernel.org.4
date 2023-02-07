Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17968CF6C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjBGGVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBGGVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:21:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CAD2C676;
        Mon,  6 Feb 2023 22:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675750903; x=1707286903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j+pyadsYqLfVb4Iz0OO4wXfJls9IQhpM2J9KmFaO9d4=;
  b=UDOgzZibU4kKBIKOzfA7bNluPNcdbrtP/BNWQAWE8XzAQyRch6JMT2T+
   nVYbMblPGAdIKVYahBgH/OUkpBY/4LzimyIjNKv+LMV77IxAbUVdjVQ8q
   2kZ+fG7JtJZ0+iXefWPv4aFtWD82sbPAcJrvjIdBegroriD/JraD5ycXX
   xT9Jgz0IZJsIDUJW2fiVCIpEH8c+BDUbYt0Mro51WCGowUh4CcQ8Tj/tZ
   TZ8Z2CDLlncCOFQOKDDpjLOWH6gtHiKv1uTVYV928UlKRbHxnSlUlaPdn
   SKMWR8I9Bjmdx9130zGWlL9BPrSxON4l4TxgNDSzENIY8Vl5/VZ1qCXs3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="391813653"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="391813653"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 22:21:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="790679284"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="790679284"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Feb 2023 22:21:40 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPHMJ-0003AW-2L;
        Tue, 07 Feb 2023 06:21:39 +0000
Date:   Tue, 7 Feb 2023 14:21:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Willem-Jan de Hoog <arinc9.unal@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com
Subject: Re: [PATCH 1/2] firmware: bcm47xx_nvram: allow to read from buffered
 nvram data
Message-ID: <202302071414.czB7JMnU-lkp@intel.com>
References: <20230206100502.20243-2-wdehoog@exalondelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206100502.20243-2-wdehoog@exalondelft.nl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willem-Jan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.2-rc7 next-20230206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Willem-Jan-de-Hoog/firmware-bcm47xx_nvram-allow-to-read-from-buffered-nvram-data/20230206-180737
patch link:    https://lore.kernel.org/r/20230206100502.20243-2-wdehoog%40exalondelft.nl
patch subject: [PATCH 1/2] firmware: bcm47xx_nvram: allow to read from buffered nvram data
config: sparc-randconfig-r035-20230205 (https://download.01.org/0day-ci/archive/20230207/202302071414.czB7JMnU-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/763f6661565b50b967e4f22e41cf46d27e14e58f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Willem-Jan-de-Hoog/firmware-bcm47xx_nvram-allow-to-read-from-buffered-nvram-data/20230206-180737
        git checkout 763f6661565b50b967e4f22e41cf46d27e14e58f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/mtd/parsers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/mtd/parsers/ofpart_linksys_ns.c:6:
   include/linux/bcm47xx_nvram.h:56:2: error: expected identifier or '(' before ':' token
      56 | }:
         |  ^
   In file included from include/linux/uio.h:10,
                    from include/linux/mtd/mtd.h:10,
                    from drivers/mtd/parsers/ofpart_linksys_ns.c:7:
>> include/linux/mm_types.h:704:48: error: 'NR_MM_COUNTERS' undeclared here (not in a function)
     704 |                 struct percpu_counter rss_stat[NR_MM_COUNTERS];
         |                                                ^~~~~~~~~~~~~~


vim +/NR_MM_COUNTERS +704 include/linux/mm_types.h

227a4aadc75ba2 Mathieu Desnoyers     2019-09-19  628  
b279ddc3382426 Vegard Nossum         2017-02-27  629  		/**
b279ddc3382426 Vegard Nossum         2017-02-27  630  		 * @mm_users: The number of users including userspace.
b279ddc3382426 Vegard Nossum         2017-02-27  631  		 *
c1a2f7f0c06454 Rik van Riel          2018-07-16  632  		 * Use mmget()/mmget_not_zero()/mmput() to modify. When this
c1a2f7f0c06454 Rik van Riel          2018-07-16  633  		 * drops to 0 (i.e. when the task exits and there are no other
c1a2f7f0c06454 Rik van Riel          2018-07-16  634  		 * temporary reference holders), we also release a reference on
c1a2f7f0c06454 Rik van Riel          2018-07-16  635  		 * @mm_count (which may then free the &struct mm_struct if
c1a2f7f0c06454 Rik van Riel          2018-07-16  636  		 * @mm_count also drops to 0).
b279ddc3382426 Vegard Nossum         2017-02-27  637  		 */
b279ddc3382426 Vegard Nossum         2017-02-27  638  		atomic_t mm_users;
b279ddc3382426 Vegard Nossum         2017-02-27  639  
b279ddc3382426 Vegard Nossum         2017-02-27  640  		/**
b279ddc3382426 Vegard Nossum         2017-02-27  641  		 * @mm_count: The number of references to &struct mm_struct
b279ddc3382426 Vegard Nossum         2017-02-27  642  		 * (@mm_users count as 1).
b279ddc3382426 Vegard Nossum         2017-02-27  643  		 *
b279ddc3382426 Vegard Nossum         2017-02-27  644  		 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
b279ddc3382426 Vegard Nossum         2017-02-27  645  		 * &struct mm_struct is freed.
b279ddc3382426 Vegard Nossum         2017-02-27  646  		 */
b279ddc3382426 Vegard Nossum         2017-02-27  647  		atomic_t mm_count;
b279ddc3382426 Vegard Nossum         2017-02-27  648  
c4812909f5d5a9 Kirill A. Shutemov    2017-11-15  649  #ifdef CONFIG_MMU
af5b0f6a09e42c Kirill A. Shutemov    2017-11-15  650  		atomic_long_t pgtables_bytes;	/* PTE page table pages */
5a3fbef325e872 Kirill A. Shutemov    2015-04-14  651  #endif
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  652  		int map_count;			/* number of VMAs */
481b4bb5e370aa Richard Kennedy       2011-03-22  653  
c1a2f7f0c06454 Rik van Riel          2018-07-16  654  		spinlock_t page_table_lock; /* Protects page tables and some
c1a2f7f0c06454 Rik van Riel          2018-07-16  655  					     * counters
c1a2f7f0c06454 Rik van Riel          2018-07-16  656  					     */
2e3025434a6ba0 Feng Tang             2021-06-11  657  		/*
2e3025434a6ba0 Feng Tang             2021-06-11  658  		 * With some kernel config, the current mmap_lock's offset
2e3025434a6ba0 Feng Tang             2021-06-11  659  		 * inside 'mm_struct' is at 0x120, which is very optimal, as
2e3025434a6ba0 Feng Tang             2021-06-11  660  		 * its two hot fields 'count' and 'owner' sit in 2 different
2e3025434a6ba0 Feng Tang             2021-06-11  661  		 * cachelines,  and when mmap_lock is highly contended, both
2e3025434a6ba0 Feng Tang             2021-06-11  662  		 * of the 2 fields will be accessed frequently, current layout
2e3025434a6ba0 Feng Tang             2021-06-11  663  		 * will help to reduce cache bouncing.
2e3025434a6ba0 Feng Tang             2021-06-11  664  		 *
2e3025434a6ba0 Feng Tang             2021-06-11  665  		 * So please be careful with adding new fields before
2e3025434a6ba0 Feng Tang             2021-06-11  666  		 * mmap_lock, which can easily push the 2 fields into one
2e3025434a6ba0 Feng Tang             2021-06-11  667  		 * cacheline.
2e3025434a6ba0 Feng Tang             2021-06-11  668  		 */
da1c55f1b272f4 Michel Lespinasse     2020-06-08  669  		struct rw_semaphore mmap_lock;
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  670  
c1a2f7f0c06454 Rik van Riel          2018-07-16  671  		struct list_head mmlist; /* List of maybe swapped mm's.	These
c1a2f7f0c06454 Rik van Riel          2018-07-16  672  					  * are globally strung together off
c1a2f7f0c06454 Rik van Riel          2018-07-16  673  					  * init_mm.mmlist, and are protected
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  674  					  * by mmlist_lock
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  675  					  */
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  676  
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  677  
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  678  		unsigned long hiwater_rss; /* High-watermark of RSS usage */
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  679  		unsigned long hiwater_vm;  /* High-water virtual memory usage */
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  680  
e10d59f2c3deca Christoph Lameter     2011-10-31  681  		unsigned long total_vm;	   /* Total pages mapped */
e10d59f2c3deca Christoph Lameter     2011-10-31  682  		unsigned long locked_vm;   /* Pages that have PG_mlocked set */
70f8a3ca68d3e1 Davidlohr Bueso       2019-02-06  683  		atomic64_t    pinned_vm;   /* Refcount permanently increased */
30bdbb78009e67 Konstantin Khlebnikov 2016-02-02  684  		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
30bdbb78009e67 Konstantin Khlebnikov 2016-02-02  685  		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
30bdbb78009e67 Konstantin Khlebnikov 2016-02-02  686  		unsigned long stack_vm;	   /* VM_STACK */
e10d59f2c3deca Christoph Lameter     2011-10-31  687  		unsigned long def_flags;
88aa7cc688d48d Yang Shi              2018-06-07  688  
2e3025434a6ba0 Feng Tang             2021-06-11  689  		/**
2e3025434a6ba0 Feng Tang             2021-06-11  690  		 * @write_protect_seq: Locked when any thread is write
2e3025434a6ba0 Feng Tang             2021-06-11  691  		 * protecting pages mapped by this mm to enforce a later COW,
2e3025434a6ba0 Feng Tang             2021-06-11  692  		 * for instance during page table copying for fork().
2e3025434a6ba0 Feng Tang             2021-06-11  693  		 */
2e3025434a6ba0 Feng Tang             2021-06-11  694  		seqcount_t write_protect_seq;
2e3025434a6ba0 Feng Tang             2021-06-11  695  
88aa7cc688d48d Yang Shi              2018-06-07  696  		spinlock_t arg_lock; /* protect the below fields */
2e3025434a6ba0 Feng Tang             2021-06-11  697  
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  698  		unsigned long start_code, end_code, start_data, end_data;
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  699  		unsigned long start_brk, brk, start_stack;
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  700  		unsigned long arg_start, arg_end, env_start, env_end;
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  701  
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  702  		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  703  
f1a7941243c102 Shakeel Butt          2022-10-24 @704  		struct percpu_counter rss_stat[NR_MM_COUNTERS];
d559db086ff5be KAMEZAWA Hiroyuki     2010-03-05  705  
801460d0cf5c52 Hiroshi Shimamoto     2009-09-23  706  		struct linux_binfmt *binfmt;
801460d0cf5c52 Hiroshi Shimamoto     2009-09-23  707  
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  708  		/* Architecture-specific MM context */
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  709  		mm_context_t context;
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  710  
c1a2f7f0c06454 Rik van Riel          2018-07-16  711  		unsigned long flags; /* Must use atomic bitops to access */
c92ff1bde06f69 Martin Schwidefsky    2007-10-16  712  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
