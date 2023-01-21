Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021B66763D7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 05:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjAUEnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 23:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAUEm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 23:42:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B9C50853;
        Fri, 20 Jan 2023 20:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674276176; x=1705812176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MjbzbjiZDXv+mKGfE+rmDazoRKi5ngCxDJGRVWJTC3o=;
  b=e/Fz5oBlXL5nffGjkxhMkRIUHKAQzq1dtR+epnYBV8GkOyGdd6YrSXfZ
   tJKbYY80tF9TdBzfoz/a9vAVG+1oATXFz2wMqE1HTZq31Qdwp5dkpBz8O
   7mw8K8pX1oauRiqG15ZIjIBGzF+ls3u0AR+6jbHTzPl/MUolr5EQ0eru1
   udYYnzJUfVa6r9T2LfmfOg2Ls2UZnQrQGH/VFqOcUvT00iU7MKo9YiOxN
   57B0LVGsBLSFw4TpFNWHEQRlkbwWQE0+e2MmgOLfsj+tu0nrElKaYiccO
   HDR0hYtdRI3fEg5o00xRbmg7k+2Zvuz52Bs3I9foVGN8ACzrQu/lk/nEw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="306117873"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="306117873"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 20:42:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="662767019"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="662767019"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jan 2023 20:42:52 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ5iN-0003UY-0W;
        Sat, 21 Jan 2023 04:42:51 +0000
Date:   Sat, 21 Jan 2023 12:42:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anjana Hari <quic_ahari@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        konrad.dybcio@linaro.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_narepall@quicinc.com,
        quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com,
        Anjana Hari <quic_ahari@quicinc.com>
Subject: Re: [PATCH v3 1/1] scsi: ufs: Add hibernation callbacks
Message-ID: <202301211209.4byNcJjL-lkp@intel.com>
References: <20230120113321.30433-2-quic_ahari@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120113321.30433-2-quic_ahari@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anjana,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on next-20230120]
[cannot apply to jejb-scsi/for-next linus/master v6.2-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anjana-Hari/scsi-ufs-Add-hibernation-callbacks/20230120-193447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230120113321.30433-2-quic_ahari%40quicinc.com
patch subject: [PATCH v3 1/1] scsi: ufs: Add hibernation callbacks
config: riscv-randconfig-r042-20230119 (https://download.01.org/0day-ci/archive/20230121/202301211209.4byNcJjL-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/239ad2244616006dd39bc9a5380108435d168a86
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anjana-Hari/scsi-ufs-Add-hibernation-callbacks/20230120-193447
        git checkout 239ad2244616006dd39bc9a5380108435d168a86
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/ufs/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/ufs/core/ufshcd.c:10004:8: error: call to undeclared function 'ufshcd_system_suspend'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           ret = ufshcd_system_suspend(dev);
                 ^
>> drivers/ufs/core/ufshcd.c:10017:9: error: call to undeclared function 'ufshcd_system_resume'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return ufshcd_system_resume(dev);
                  ^
   drivers/ufs/core/ufshcd.c:10017:9: note: did you mean 'ufshcd_system_restore'?
   drivers/ufs/core/ufshcd.c:10011:5: note: 'ufshcd_system_restore' declared here
   int ufshcd_system_restore(struct device *dev)
       ^
   drivers/ufs/core/ufshcd.c:10024:9: error: call to undeclared function 'ufshcd_system_resume'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return ufshcd_system_resume(dev);
                  ^
   drivers/ufs/core/ufshcd.c:10048:44: warning: shift count >= width of type [-Wshift-count-overflow]
                   if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/ufs/core/ufshcd.c:10048:44: warning: shift count >= width of type [-Wshift-count-overflow]
                   if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^~~~
   drivers/ufs/core/ufshcd.c:10048:44: warning: shift count >= width of type [-Wshift-count-overflow]
                   if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                       ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   3 warnings and 3 errors generated.


vim +/ufshcd_system_suspend +10004 drivers/ufs/core/ufshcd.c

  9993	
  9994		struct ufs_hba *hba = dev_get_drvdata(dev);
  9995		int ret = 0;
  9996	
  9997		/*
  9998		 * Run time resume the controller to make sure
  9999		 * the PM work queue threads do not try to resume
 10000		 * the child (scsi host), which leads to errors as
 10001		 * the controller is not yet resumed.
 10002		 */
 10003		pm_runtime_get_sync(hba->dev);
 10004		ret = ufshcd_system_suspend(dev);
 10005		pm_runtime_put_sync(hba->dev);
 10006	
 10007		return ret;
 10008	}
 10009	EXPORT_SYMBOL_GPL(ufshcd_system_freeze);
 10010	
 10011	int ufshcd_system_restore(struct device *dev)
 10012	{
 10013	
 10014		struct ufs_hba *hba = dev_get_drvdata(dev);
 10015	
 10016		hba->restore = true;
 10017		return ufshcd_system_resume(dev);
 10018	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
