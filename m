Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA969BFDE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjBSJsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjBSJsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:48:07 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A7012F24;
        Sun, 19 Feb 2023 01:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676800051; x=1708336051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xhcCnf0cNcsotIr4PN51gmS8bzJYzvKjq4kiT2RhNfs=;
  b=nBAd4fUX0OXafPILtHDzCYboWaCHqkNSDHqBs1oYdbs0/y1NfH2QQd+l
   27HXK+kz6jYF8erBka3rzVnb1Djtyjqgc166nyeire+ucFeLJHmTR0cNX
   0Ze3ZhiEV80g8wOinfCajApjL2LJ3VPgbri6D5SopkoP/AjEriOZftU+m
   /8d4zasu+sOyQRodgy2K3OSrGU+ZtNwD+GvUAB3IWP+lqTewc696sincw
   CS/9K08zWrZVJOFA2Kae1kpUowl79UU/n1b0LEHlnKryktVaVYDxCfu5X
   aomO2choHU0H6BZXMtuMQ+8dvfmFS8CH6bRjHMiZS8MK4MDIt7ANXvdCu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="311867310"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="311867310"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 01:45:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="759872251"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="759872251"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Feb 2023 01:45:34 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTgGD-000DEd-0n;
        Sun, 19 Feb 2023 09:45:33 +0000
Date:   Sun, 19 Feb 2023 17:44:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, arnd@arndb.de, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v10 2/3] cachestat: implement cachestat syscall
Message-ID: <202302191728.rXGLcydi-lkp@intel.com>
References: <20230219073318.366189-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219073318.366189-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 1440f576022887004f719883acb094e7e0dd4944]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230219-153500
base:   1440f576022887004f719883acb094e7e0dd4944
patch link:    https://lore.kernel.org/r/20230219073318.366189-3-nphamcs%40gmail.com
patch subject: [PATCH v10 2/3] cachestat: implement cachestat syscall
config: hexagon-randconfig-r014-20230219 (https://download.01.org/0day-ci/archive/20230219/202302191728.rXGLcydi-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d691a3b4a696ab20c9c5fe86c624e9e36814523c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230219-153500
        git checkout d691a3b4a696ab20c9c5fe86c624e9e36814523c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302191728.rXGLcydi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/filemap.c:20:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from mm/filemap.c:20:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from mm/filemap.c:20:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> mm/filemap.c:4035:6: warning: no previous prototype for function 'ksys_cachestat' [-Wmissing-prototypes]
   long ksys_cachestat(unsigned int fd, size_t len, loff_t off,
        ^
   mm/filemap.c:4035:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   long ksys_cachestat(unsigned int fd, size_t len, loff_t off,
   ^
   static 
   7 warnings generated.


vim +/ksys_cachestat +4035 mm/filemap.c

  4033	
  4034	#ifdef CONFIG_CACHESTAT_SYSCALL
> 4035	long ksys_cachestat(unsigned int fd, size_t len, loff_t off,
  4036			struct cachestat __user *cstat, unsigned int flags)
  4037	{
  4038		struct fd f = fdget(fd);
  4039		struct address_space *mapping;
  4040		struct cachestat cs;
  4041		pgoff_t first_index = off >> PAGE_SHIFT;
  4042		pgoff_t last_index =
  4043			len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
  4044	
  4045		if (!f.file)
  4046			return -EBADF;
  4047	
  4048		if (off < 0 || flags != 0) {
  4049			fdput(f);
  4050			return -EINVAL;
  4051		}
  4052	
  4053		memset(&cs, 0, sizeof(struct cachestat));
  4054		mapping = f.file->f_mapping;
  4055		filemap_cachestat(mapping, first_index, last_index, &cs);
  4056		fdput(f);
  4057	
  4058		if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
  4059			return -EFAULT;
  4060	
  4061		return 0;
  4062	}
  4063	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
