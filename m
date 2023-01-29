Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B08367FE2A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 11:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjA2K3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 05:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjA2K3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 05:29:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0755720D36
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674988146; x=1706524146;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JlSTbgK0HOQEbxgZtJrW0sdOaJmigDWciWOaN9E/tok=;
  b=f2S2sGdMgFu+t2oZuK8fwrsw2sIxp6en8ITeRKeuz8Rm5hVemyEwq3lh
   pG9qhZwtsJ/mK4bMRqjG10CEzMj1+eHvU+gUAxcFo3qVRDtR+/WGXp/ca
   vdIzDzGN8EDruyraP8MFdL6iI99s8jIOAIygW8Cf4XToe8mLfFIWu85iF
   rcVDLz4XbH1PEKo+LrZe3KcM1nv6SgXmihOTT7w6oG2CFyvqe/1lmYN2g
   scWVmPGR6AtXJuOTXF5/kmDaD5KGhmHyxaUaj4Ua+E67A3hsFKUHisgAt
   csQYQFv6kfY2aXvT+yWYCjm494hYOS8n/sM7TN8BUFmVkHfrexbVcyk2+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="315342379"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="315342379"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 02:29:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="787696227"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="787696227"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2023 02:29:03 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pM4vm-0002iQ-0z;
        Sun, 29 Jan 2023 10:29:02 +0000
Date:   Sun, 29 Jan 2023 18:28:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: drivers/block/paride/epia.c:183:59: sparse: sparse: cast to
 restricted __le16
Message-ID: <202301291805.K0QIVz4B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c96618275234ad03d44eafe9f8844305bb44fda4
commit: 30b5e6ef4a32ea4985b99200e06d6660a69f9246 m68k: atari: Make Atari ROM port I/O write macros return void
date:   8 months ago
config: m68k-randconfig-s052-20230129 (https://download.01.org/0day-ci/archive/20230129/202301291805.K0QIVz4B-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=30b5e6ef4a32ea4985b99200e06d6660a69f9246
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 30b5e6ef4a32ea4985b99200e06d6660a69f9246
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash drivers/block/paride/ drivers/comedi/drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/block/paride/epia.c:183:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/epia.c:183:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/epia.c:183:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/epia.c:183:59: sparse: sparse: cast to restricted __le16
   drivers/block/paride/epia.c: note: in included file (through arch/m68k/include/asm/io.h):
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
--
>> drivers/block/paride/bpck.c:182:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/bpck.c:182:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/bpck.c:182:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/bpck.c:182:59: sparse: sparse: cast to restricted __le16
   drivers/block/paride/bpck.c: note: in included file (through arch/m68k/include/asm/io.h):
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   drivers/block/paride/bpck.c:323:72: sparse: sparse: cast to restricted __le16
   drivers/block/paride/bpck.c:323:72: sparse: sparse: cast to restricted __le16
   drivers/block/paride/bpck.c:323:72: sparse: sparse: cast to restricted __le16
   drivers/block/paride/bpck.c:323:72: sparse: sparse: cast to restricted __le16
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
--
>> drivers/block/paride/kbic.c:58:21: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/kbic.c:58:21: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/kbic.c:58:21: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/kbic.c:58:21: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:156:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:156:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:156:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:156:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:156:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:156:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:156:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:156:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:157:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:157:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:157:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:157:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:157:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:157:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:157:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:157:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:159:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:159:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:159:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:159:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:159:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:159:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:159:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:159:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:160:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:160:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:160:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:160:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:160:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:160:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:160:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:160:48: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:179:59: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:179:59: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:179:59: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c:179:59: sparse: sparse: cast to restricted __le16
   drivers/block/paride/kbic.c: note: in included file (through arch/m68k/include/asm/io.h):
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
--
>> drivers/block/paride/dstr.c:145:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/dstr.c:145:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/dstr.c:145:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/dstr.c:145:59: sparse: sparse: cast to restricted __le16
   drivers/block/paride/dstr.c: note: in included file (through arch/m68k/include/asm/io.h):
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
--
>> drivers/block/paride/on26.c:221:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/on26.c:221:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/on26.c:221:59: sparse: sparse: cast to restricted __le16
>> drivers/block/paride/on26.c:221:59: sparse: sparse: cast to restricted __le16
   drivers/block/paride/on26.c: note: in included file (through arch/m68k/include/asm/io.h):
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
--
>> drivers/comedi/drivers/ni_at_ao.c:159:19: sparse: sparse: cast to restricted __le16
>> drivers/comedi/drivers/ni_at_ao.c:159:19: sparse: sparse: cast to restricted __le16
>> drivers/comedi/drivers/ni_at_ao.c:159:19: sparse: sparse: cast to restricted __le16
>> drivers/comedi/drivers/ni_at_ao.c:159:19: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_at_ao.c:282:9: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_at_ao.c:282:9: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_at_ao.c:282:9: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_at_ao.c:282:9: sparse: sparse: cast to restricted __le16

vim +183 drivers/block/paride/epia.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  139  
^1da177e4c3f41 Linus Torvalds 2005-04-16  140          switch (pi->mode) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  141  
^1da177e4c3f41 Linus Torvalds 2005-04-16  142          case 0: w0(0x81); w2(1); w2(3); w0(0xc1);
^1da177e4c3f41 Linus Torvalds 2005-04-16  143                  ph = 1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  144                  for (k=0;k<count;k++) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  145                          w2(2+ph); a = r1();
^1da177e4c3f41 Linus Torvalds 2005-04-16  146                          w2(4+ph); b = r1();
^1da177e4c3f41 Linus Torvalds 2005-04-16  147                          buf[k] = j44(a,b);
^1da177e4c3f41 Linus Torvalds 2005-04-16  148                          ph = 1 - ph;
^1da177e4c3f41 Linus Torvalds 2005-04-16  149                  } 
^1da177e4c3f41 Linus Torvalds 2005-04-16  150                  w0(0); w2(4);
^1da177e4c3f41 Linus Torvalds 2005-04-16  151                  break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  152  
^1da177e4c3f41 Linus Torvalds 2005-04-16  153          case 1: w0(0x91); w2(1); w0(0x10); w2(3); 
^1da177e4c3f41 Linus Torvalds 2005-04-16  154                  w0(0x51); w2(5); w0(0xd1); 
^1da177e4c3f41 Linus Torvalds 2005-04-16  155                  ph = 1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  156                  for (k=0;k<count;k++) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  157                          w2(4+ph);
^1da177e4c3f41 Linus Torvalds 2005-04-16  158                          a = r1(); b = r2();
^1da177e4c3f41 Linus Torvalds 2005-04-16  159                          buf[k] = j53(a,b);
^1da177e4c3f41 Linus Torvalds 2005-04-16  160                          ph = 1 - ph;
^1da177e4c3f41 Linus Torvalds 2005-04-16  161                  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  162                  w0(0); w2(4);
^1da177e4c3f41 Linus Torvalds 2005-04-16  163                  break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  164  
^1da177e4c3f41 Linus Torvalds 2005-04-16  165          case 2: w0(0x89); w2(1); w2(0x23); w2(0x21); 
^1da177e4c3f41 Linus Torvalds 2005-04-16  166                  ph = 1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  167                  for (k=0;k<count;k++) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  168                          w2(0x24+ph);
^1da177e4c3f41 Linus Torvalds 2005-04-16  169                          buf[k] = r0();
^1da177e4c3f41 Linus Torvalds 2005-04-16  170                          ph = 1 - ph;
^1da177e4c3f41 Linus Torvalds 2005-04-16  171                  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  172                  w2(6); w2(4);
^1da177e4c3f41 Linus Torvalds 2005-04-16  173                  break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  174  
^1da177e4c3f41 Linus Torvalds 2005-04-16  175          case 3: if (count > 512) WR(0x84,3);
^1da177e4c3f41 Linus Torvalds 2005-04-16  176  		w3(0); w2(0x24);
^1da177e4c3f41 Linus Torvalds 2005-04-16  177                  for (k=0;k<count;k++) buf[k] = r4();
^1da177e4c3f41 Linus Torvalds 2005-04-16  178                  w2(4); WR(0x84,0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  179                  break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  180  
^1da177e4c3f41 Linus Torvalds 2005-04-16  181          case 4: if (count > 512) WR(0x84,3);
^1da177e4c3f41 Linus Torvalds 2005-04-16  182  		w3(0); w2(0x24);
^1da177e4c3f41 Linus Torvalds 2005-04-16 @183  		for (k=0;k<count/2;k++) ((u16 *)buf)[k] = r4w();
^1da177e4c3f41 Linus Torvalds 2005-04-16  184                  w2(4); WR(0x84,0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  185                  break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  186  
^1da177e4c3f41 Linus Torvalds 2005-04-16  187          case 5: if (count > 512) WR(0x84,3);
^1da177e4c3f41 Linus Torvalds 2005-04-16  188  		w3(0); w2(0x24);
^1da177e4c3f41 Linus Torvalds 2005-04-16  189                  for (k=0;k<count/4;k++) ((u32 *)buf)[k] = r4l();
^1da177e4c3f41 Linus Torvalds 2005-04-16  190                  w2(4); WR(0x84,0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  191                  break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  192  
^1da177e4c3f41 Linus Torvalds 2005-04-16  193          }
^1da177e4c3f41 Linus Torvalds 2005-04-16  194  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  195  

:::::: The code at line 183 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
