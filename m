Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DD96790A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjAXGI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjAXGIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:08:50 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C2E2E0F8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674540528; x=1706076528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FG5wi4nVDwvzoVjFdleOp1NxA/Nr3g/OSssbqc/uBCE=;
  b=a/496WVgRq6pdzout45c214b2Tcp/2Q+ECyrxTRia3fQQPjv7t6ayK1y
   bPFxhM7XkKST5EKkSgV2TVZsbaQEnzQZ6BehQgNYVWO1VGzZqSUWlDsPO
   pRDv0wL/R0X6na+zEUPH3yuhZqrH89DccQFvA/dhJMHZgGnoZ6CgwDyYA
   ArCRLChhicaPFBizMd3sYnEkHkgPZamwzhNn87VmAj1O1JpdWTfMwoHm2
   2060vUsoXT4jXUOmFb7EAlIY40CHBfo+T7LdoE9FFHtDwzRR9x5Wl5gZg
   SYz2pNOuJabO1gP2n1+pv3NzWQdLIJiOpfl3tyOwByG9amYbEl1gKZmyp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="309812192"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="309812192"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 22:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="730568829"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="730568829"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jan 2023 22:08:42 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKCU5-0006Bm-2F;
        Tue, 24 Jan 2023 06:08:41 +0000
Date:   Tue, 24 Jan 2023 14:07:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     George Prekas <george@enfabrica.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        George Prekas <george@enfabrica.net>
Subject: Re: [PATCH 1/9] mm: kmemleak: properly disable task stack scanning
Message-ID: <202301241343.blMmgE7L-lkp@intel.com>
References: <20230123170419.7292-2-george@enfabrica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123170419.7292-2-george@enfabrica.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on vbabka-slab/for-next]
[also build test ERROR on linus/master v6.2-rc5 next-20230124]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/George-Prekas/mm-kmemleak-properly-disable-task-stack-scanning/20230124-010911
base:   git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git for-next
patch link:    https://lore.kernel.org/r/20230123170419.7292-2-george%40enfabrica.net
patch subject: [PATCH 1/9] mm: kmemleak: properly disable task stack scanning
config: s390-randconfig-r044-20230123 (https://download.01.org/0day-ci/archive/20230124/202301241343.blMmgE7L-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/f0d9df4305849ecea4402bc614cadb0dd357da77
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review George-Prekas/mm-kmemleak-properly-disable-task-stack-scanning/20230124-010911
        git checkout f0d9df4305849ecea4402bc614cadb0dd357da77
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/kmemleak.c:85:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from mm/kmemleak.c:85:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from mm/kmemleak.c:85:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> mm/kmemleak.c:1244:32: error: incompatible pointer to integer conversion passing 'const void *' to parameter of type 'unsigned long' [-Wint-conversion]
                   object = find_and_get_object(ptr, 0);
                                                ^~~
   mm/kmemleak.c:561:66: note: passing argument to parameter 'ptr' here
   static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
                                                                    ^
   12 warnings and 1 error generated.


vim +1244 mm/kmemleak.c

  1233	
  1234	/**
  1235	 * kmemleak_mark_stack - mark the allocated object as a kernel stack
  1236	 *
  1237	 * @ptr:	pointer to beginning of the object
  1238	 */
  1239	void __ref kmemleak_mark_stack(const void *ptr)
  1240	{
  1241		struct kmemleak_object *object;
  1242	
  1243		if (kmemleak_enabled && ptr && !IS_ERR(ptr)) {
> 1244			object = find_and_get_object(ptr, 0);
  1245			if (object) {
  1246				object->flags |= OBJECT_STACK;
  1247				put_object(object);
  1248			}
  1249		}
  1250	}
  1251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
