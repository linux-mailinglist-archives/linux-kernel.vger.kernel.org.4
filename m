Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A562B6A5DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjB1Q4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjB1Q4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:56:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6E1B6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677603367; x=1709139367;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JR/qPYNeQqxkugh7Zfo4cVjYaK8vPl4+aE9FAxSbHSc=;
  b=hoZKZHUC2fKsjpMmy7oh5QcaT7+/kA15g8kGB8zoSW3MO8yXykPhw/vG
   c+p6xceQCfbYDIhNYHBT4M63m8V7mxcPAyZOqMf/CSMdyG5hn5nRkaLeR
   CJYCz9NedJJWHMFueAJhIo1EmFIAx3XtphPouDlH9qDzgRSc23dgQjb+f
   Po5iW0qJgH+eeT2vMP9IITZ/uFjZtsx+k4JkyxjYzNltJi7zPjDtKoPvO
   YRP889hm6Q74to+esdexkB0Bphel2VJrqso6AmFhyWuP2i+Qx+qnRmvn7
   0XYAkCz0nTiWIvsnRakTCH+A/UhUB3MBcx86Xw13Xws8dmfhOjpRKSuXY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="420450895"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="420450895"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:55:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="674220398"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="674220398"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Feb 2023 08:55:42 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pX3GP-0005XL-1X;
        Tue, 28 Feb 2023 16:55:41 +0000
Date:   Wed, 1 Mar 2023 00:55:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: include/linux/fortify-string.h:520:4: warning: call to
 '__write_overflow_field' declared with 'warning' attribute: detected write
 beyond size of field (1st parameter); maybe use struct_group()?
Message-ID: <202303010005.KqCMLzYH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae3419fbac845b4d3f3a9fae4cc80c68d82cdf6e
commit: 439a1bcac648fe9b59210cde8991fb2acf37bdab fortify: Use __builtin_dynamic_object_size() when available
date:   8 weeks ago
config: s390-randconfig-r034-20230227 (https://download.01.org/0day-ci/archive/20230301/202303010005.KqCMLzYH-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=439a1bcac648fe9b59210cde8991fb2acf37bdab
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 439a1bcac648fe9b59210cde8991fb2acf37bdab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash fs/ksmbd/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303010005.KqCMLzYH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ksmbd/smb_common.c:13:
   In file included from fs/ksmbd/connection.h:10:
   In file included from include/linux/ip.h:16:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from fs/ksmbd/smb_common.c:13:
   In file included from fs/ksmbd/connection.h:10:
   In file included from include/linux/ip.h:16:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from fs/ksmbd/smb_common.c:13:
   In file included from fs/ksmbd/connection.h:10:
   In file included from include/linux/ip.h:16:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from fs/ksmbd/smb_common.c:7:
   In file included from include/linux/user_namespace.h:5:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:11:
   In file included from include/linux/string.h:253:
>> include/linux/fortify-string.h:520:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
                           __write_overflow_field(p_size_field, size);
                           ^
   13 warnings generated.


vim +520 include/linux/fortify-string.h

a28a6e860c6cf2 Francis Laniel 2021-02-25  464  
f68f2ff91512c1 Kees Cook      2021-04-20  465  /*
f68f2ff91512c1 Kees Cook      2021-04-20  466   * To make sure the compiler can enforce protection against buffer overflows,
f68f2ff91512c1 Kees Cook      2021-04-20  467   * memcpy(), memmove(), and memset() must not be used beyond individual
f68f2ff91512c1 Kees Cook      2021-04-20  468   * struct members. If you need to copy across multiple members, please use
f68f2ff91512c1 Kees Cook      2021-04-20  469   * struct_group() to create a named mirror of an anonymous struct union.
f68f2ff91512c1 Kees Cook      2021-04-20  470   * (e.g. see struct sk_buff.) Read overflow checking is currently only
f68f2ff91512c1 Kees Cook      2021-04-20  471   * done when a write overflow is also present, or when building with W=1.
f68f2ff91512c1 Kees Cook      2021-04-20  472   *
f68f2ff91512c1 Kees Cook      2021-04-20  473   * Mitigation coverage matrix
f68f2ff91512c1 Kees Cook      2021-04-20  474   *					Bounds checking at:
f68f2ff91512c1 Kees Cook      2021-04-20  475   *					+-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  476   *					| Compile time  |   Run time    |
f68f2ff91512c1 Kees Cook      2021-04-20  477   * memcpy() argument sizes:		| write | read  | write | read  |
f68f2ff91512c1 Kees Cook      2021-04-20  478   *        dest     source   length      +-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  479   * memcpy(known,   known,   constant)	|   y   |   y   |  n/a  |  n/a  |
f68f2ff91512c1 Kees Cook      2021-04-20  480   * memcpy(known,   unknown, constant)	|   y   |   n   |  n/a  |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  481   * memcpy(known,   known,   dynamic)	|   n   |   n   |   B   |   B   |
f68f2ff91512c1 Kees Cook      2021-04-20  482   * memcpy(known,   unknown, dynamic)	|   n   |   n   |   B   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  483   * memcpy(unknown, known,   constant)	|   n   |   y   |   V   |  n/a  |
f68f2ff91512c1 Kees Cook      2021-04-20  484   * memcpy(unknown, unknown, constant)	|   n   |   n   |   V   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  485   * memcpy(unknown, known,   dynamic)	|   n   |   n   |   V   |   B   |
f68f2ff91512c1 Kees Cook      2021-04-20  486   * memcpy(unknown, unknown, dynamic)	|   n   |   n   |   V   |   V   |
f68f2ff91512c1 Kees Cook      2021-04-20  487   *					+-------+-------+-------+-------+
f68f2ff91512c1 Kees Cook      2021-04-20  488   *
f68f2ff91512c1 Kees Cook      2021-04-20  489   * y = perform deterministic compile-time bounds checking
f68f2ff91512c1 Kees Cook      2021-04-20  490   * n = cannot perform deterministic compile-time bounds checking
f68f2ff91512c1 Kees Cook      2021-04-20  491   * n/a = no run-time bounds checking needed since compile-time deterministic
f68f2ff91512c1 Kees Cook      2021-04-20  492   * B = can perform run-time bounds checking (currently unimplemented)
f68f2ff91512c1 Kees Cook      2021-04-20  493   * V = vulnerable to run-time overflow (will need refactoring to solve)
f68f2ff91512c1 Kees Cook      2021-04-20  494   *
f68f2ff91512c1 Kees Cook      2021-04-20  495   */
54d9469bc515dc Kees Cook      2021-06-24  496  __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
f68f2ff91512c1 Kees Cook      2021-04-20  497  					 const size_t p_size,
f68f2ff91512c1 Kees Cook      2021-04-20  498  					 const size_t q_size,
f68f2ff91512c1 Kees Cook      2021-04-20  499  					 const size_t p_size_field,
f68f2ff91512c1 Kees Cook      2021-04-20  500  					 const size_t q_size_field,
f68f2ff91512c1 Kees Cook      2021-04-20  501  					 const char *func)
a28a6e860c6cf2 Francis Laniel 2021-02-25  502  {
a28a6e860c6cf2 Francis Laniel 2021-02-25  503  	if (__builtin_constant_p(size)) {
f68f2ff91512c1 Kees Cook      2021-04-20  504  		/*
f68f2ff91512c1 Kees Cook      2021-04-20  505  		 * Length argument is a constant expression, so we
f68f2ff91512c1 Kees Cook      2021-04-20  506  		 * can perform compile-time bounds checking where
fa35198f39571b Kees Cook      2022-09-19  507  		 * buffer sizes are also known at compile time.
f68f2ff91512c1 Kees Cook      2021-04-20  508  		 */
f68f2ff91512c1 Kees Cook      2021-04-20  509  
f68f2ff91512c1 Kees Cook      2021-04-20  510  		/* Error when size is larger than enclosing struct. */
fa35198f39571b Kees Cook      2022-09-19  511  		if (__compiletime_lessthan(p_size_field, p_size) &&
fa35198f39571b Kees Cook      2022-09-19  512  		    __compiletime_lessthan(p_size, size))
a28a6e860c6cf2 Francis Laniel 2021-02-25  513  			__write_overflow();
fa35198f39571b Kees Cook      2022-09-19  514  		if (__compiletime_lessthan(q_size_field, q_size) &&
fa35198f39571b Kees Cook      2022-09-19  515  		    __compiletime_lessthan(q_size, size))
a28a6e860c6cf2 Francis Laniel 2021-02-25  516  			__read_overflow2();
f68f2ff91512c1 Kees Cook      2021-04-20  517  
f68f2ff91512c1 Kees Cook      2021-04-20  518  		/* Warn when write size argument larger than dest field. */
fa35198f39571b Kees Cook      2022-09-19  519  		if (__compiletime_lessthan(p_size_field, size))
f68f2ff91512c1 Kees Cook      2021-04-20 @520  			__write_overflow_field(p_size_field, size);
f68f2ff91512c1 Kees Cook      2021-04-20  521  		/*
f68f2ff91512c1 Kees Cook      2021-04-20  522  		 * Warn for source field over-read when building with W=1
f68f2ff91512c1 Kees Cook      2021-04-20  523  		 * or when an over-write happened, so both can be fixed at
f68f2ff91512c1 Kees Cook      2021-04-20  524  		 * the same time.
f68f2ff91512c1 Kees Cook      2021-04-20  525  		 */
fa35198f39571b Kees Cook      2022-09-19  526  		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) ||
fa35198f39571b Kees Cook      2022-09-19  527  		     __compiletime_lessthan(p_size_field, size)) &&
fa35198f39571b Kees Cook      2022-09-19  528  		    __compiletime_lessthan(q_size_field, size))
f68f2ff91512c1 Kees Cook      2021-04-20  529  			__read_overflow2_field(q_size_field, size);
a28a6e860c6cf2 Francis Laniel 2021-02-25  530  	}
f68f2ff91512c1 Kees Cook      2021-04-20  531  	/*
f68f2ff91512c1 Kees Cook      2021-04-20  532  	 * At this point, length argument may not be a constant expression,
f68f2ff91512c1 Kees Cook      2021-04-20  533  	 * so run-time bounds checking can be done where buffer sizes are
f68f2ff91512c1 Kees Cook      2021-04-20  534  	 * known. (This is not an "else" because the above checks may only
f68f2ff91512c1 Kees Cook      2021-04-20  535  	 * be compile-time warnings, and we want to still warn for run-time
f68f2ff91512c1 Kees Cook      2021-04-20  536  	 * overflows.)
f68f2ff91512c1 Kees Cook      2021-04-20  537  	 */
f68f2ff91512c1 Kees Cook      2021-04-20  538  
f68f2ff91512c1 Kees Cook      2021-04-20  539  	/*
f68f2ff91512c1 Kees Cook      2021-04-20  540  	 * Always stop accesses beyond the struct that contains the
f68f2ff91512c1 Kees Cook      2021-04-20  541  	 * field, when the buffer's remaining size is known.
311fb40aa0569a Kees Cook      2022-09-02  542  	 * (The SIZE_MAX test is to optimize away checks where the buffer
f68f2ff91512c1 Kees Cook      2021-04-20  543  	 * lengths are unknown.)
f68f2ff91512c1 Kees Cook      2021-04-20  544  	 */
311fb40aa0569a Kees Cook      2022-09-02  545  	if ((p_size != SIZE_MAX && p_size < size) ||
311fb40aa0569a Kees Cook      2022-09-02  546  	    (q_size != SIZE_MAX && q_size < size))
f68f2ff91512c1 Kees Cook      2021-04-20  547  		fortify_panic(func);
54d9469bc515dc Kees Cook      2021-06-24  548  
54d9469bc515dc Kees Cook      2021-06-24  549  	/*
54d9469bc515dc Kees Cook      2021-06-24  550  	 * Warn when writing beyond destination field size.
54d9469bc515dc Kees Cook      2021-06-24  551  	 *
54d9469bc515dc Kees Cook      2021-06-24  552  	 * We must ignore p_size_field == 0 for existing 0-element
54d9469bc515dc Kees Cook      2021-06-24  553  	 * fake flexible arrays, until they are all converted to
54d9469bc515dc Kees Cook      2021-06-24  554  	 * proper flexible arrays.
54d9469bc515dc Kees Cook      2021-06-24  555  	 *
9f7d69c5cd2390 Kees Cook      2022-09-19  556  	 * The implementation of __builtin_*object_size() behaves
54d9469bc515dc Kees Cook      2021-06-24  557  	 * like sizeof() when not directly referencing a flexible
54d9469bc515dc Kees Cook      2021-06-24  558  	 * array member, which means there will be many bounds checks
54d9469bc515dc Kees Cook      2021-06-24  559  	 * that will appear at run-time, without a way for them to be
54d9469bc515dc Kees Cook      2021-06-24  560  	 * detected at compile-time (as can be done when the destination
54d9469bc515dc Kees Cook      2021-06-24  561  	 * is specifically the flexible array member).
54d9469bc515dc Kees Cook      2021-06-24  562  	 * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832
54d9469bc515dc Kees Cook      2021-06-24  563  	 */
54d9469bc515dc Kees Cook      2021-06-24  564  	if (p_size_field != 0 && p_size_field != SIZE_MAX &&
54d9469bc515dc Kees Cook      2021-06-24  565  	    p_size != p_size_field && p_size_field < size)
54d9469bc515dc Kees Cook      2021-06-24  566  		return true;
54d9469bc515dc Kees Cook      2021-06-24  567  
54d9469bc515dc Kees Cook      2021-06-24  568  	return false;
a28a6e860c6cf2 Francis Laniel 2021-02-25  569  }
a28a6e860c6cf2 Francis Laniel 2021-02-25  570  

:::::: The code at line 520 was first introduced by commit
:::::: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
