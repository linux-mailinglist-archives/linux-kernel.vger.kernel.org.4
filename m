Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831616E8869
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 05:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjDTDH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 23:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjDTDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 23:06:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD1749E0;
        Wed, 19 Apr 2023 20:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681959976; x=1713495976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vrqpja8Z1hSqrZRC7tQPIr/La29qW5DFqZCbyUZi4Kk=;
  b=GA2wWuKshoPOsjO2o1ZeEtriDk66nkCmLlQap2sYskLFmetyjGzP3jt7
   Fhnschzkp29FjNBJp6s9Gq9lCUSXgSMcKsFUuuCrs33KCLIxhZrXhrhLF
   D3RtDtccHZlqoUPqoOncBhubnpeZMhwZWvBNNGLjO/Tc+ABEok8fYJqQe
   on6S2s+t9Og/ai1i2I7gtrPxqT494LQtZuD2xUai0AG1qr9ifRsqZ2k8W
   A8n4jxkJC6drodLRHuowBaCIRD/+iPDIy1txcSGqphFGFStfZw2Ix2Fzt
   WMKjCJyvfUA1mAQkwDM9ZMsM54b8l3wQjWTGX+hy8vMdEk7fHQrw4cRB0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="431896672"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="431896672"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 20:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="760978836"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="760978836"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Apr 2023 20:06:13 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppKcf-000fPU-0A;
        Thu, 20 Apr 2023 03:06:13 +0000
Date:   Thu, 20 Apr 2023 11:05:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>, mani@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        quic_srichara@quicinc.com, quic_mdalam@quicinc.com
Subject: Re: [PATCH V2] mtd: rawnand: qcom: Implement exec_op()
Message-ID: <202304201013.6bradWxp-lkp@intel.com>
References: <20230419093617.27134-1-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419093617.27134-1-quic_mdalam@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Md,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on linus/master v6.3-rc7 next-20230419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/mtd-rawnand-qcom-Implement-exec_op/20230419-173849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20230419093617.27134-1-quic_mdalam%40quicinc.com
patch subject: [PATCH V2] mtd: rawnand: qcom: Implement exec_op()
config: s390-randconfig-r034-20230418 (https://download.01.org/0day-ci/archive/20230420/202304201013.6bradWxp-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/a2d1599a63e93bde90166287021663cfc13c91b2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Md-Sadre-Alam/mtd-rawnand-qcom-Implement-exec_op/20230419-173849
        git checkout a2d1599a63e93bde90166287021663cfc13c91b2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/mtd/nand/raw/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304201013.6bradWxp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mtd/nand/raw/qcom_nandc.c:9:
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
   In file included from drivers/mtd/nand/raw/qcom_nandc.c:9:
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
   In file included from drivers/mtd/nand/raw/qcom_nandc.c:9:
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
>> drivers/mtd/nand/raw/qcom_nandc.c:2617:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   drivers/mtd/nand/raw/qcom_nandc.c:2617:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   13 warnings generated.


vim +2617 drivers/mtd/nand/raw/qcom_nandc.c

  2587	
  2588	static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 cmd,
  2589				       struct qcom_op *q_op)
  2590	{
  2591		int ret = 0;
  2592	
  2593		switch (cmd) {
  2594		case NAND_CMD_RESET:
  2595			ret = OP_RESET_DEVICE;
  2596			break;
  2597		case NAND_CMD_READID:
  2598			ret = OP_FETCH_ID;
  2599			break;
  2600		case NAND_CMD_PARAM:
  2601			if (nandc->props->qpic_v2)
  2602				ret = OP_PAGE_READ_ONFI_READ;
  2603			else
  2604				ret = OP_PAGE_READ;
  2605			break;
  2606		case NAND_CMD_ERASE1:
  2607		case NAND_CMD_ERASE2:
  2608			ret = OP_BLOCK_ERASE;
  2609			break;
  2610		case NAND_CMD_STATUS:
  2611			ret = OP_CHECK_STATUS;
  2612			break;
  2613		case NAND_CMD_PAGEPROG:
  2614			ret = OP_PROGRAM_PAGE;
  2615			q_op->flag = NAND_CMD_PAGEPROG;
  2616			nandc->exec_opwrite = true;
> 2617		default:
  2618			break;
  2619		}
  2620	
  2621		return ret;
  2622	}
  2623	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
