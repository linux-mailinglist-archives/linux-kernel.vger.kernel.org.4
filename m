Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF816EF105
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjDZJXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbjDZJXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:23:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85AE4C24;
        Wed, 26 Apr 2023 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682500997; x=1714036997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HVuw8vWnuoZFgy6Fr249eVM+tSLfwKH1nh0CZ35C6dk=;
  b=MPBoDpF6LhTOLorCecepIHQGDnaTqE52+NHdeb3NlrcHSQVaeTZ8PrdR
   v2qxwzHIljWXA6F1puRfSt7Tklywd8LU9evUmU0LOOschWvVYP1F7Vv5l
   4pe5IKhuZ7dZgk5k8grucUONbcHIDXCH8I7AKcgdW5VY5r8pjssU3rm73
   l5+kz4McfkxxgPZMSMIzmR8E0QhaaAXpxrOzkvWuAB3D//ZD8014l/SDY
   IfiQY9jdW3kpBWw8GBpDNo6Ifah/bMqQofJ3v/Yp7LoWhkrsQpEyQJoyE
   IX0h6kP8qYX+61TKU6efeF/2Q4GKDgu2zl225/akCLxYWs4dEcUpufSgX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="327375952"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="327375952"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 02:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="687874590"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="687874590"
Received: from lkp-server01.sh.intel.com (HELO 98ee5a99fc83) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2023 02:22:43 -0700
Received: from kbuild by 98ee5a99fc83 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prbMI-0000Kg-1L;
        Wed, 26 Apr 2023 09:22:42 +0000
Date:   Wed, 26 Apr 2023 17:21:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, oxffffaa@gmail.com,
        kernel@sberdevices.ru, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v1] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
Message-ID: <202304261704.eyrD5KVk-lkp@intel.com>
References: <20230426072455.3887717-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426072455.3887717-1-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

kernel test robot noticed the following build errors:

[auto build test ERROR on mtd/nand/next]
[also build test ERROR on linus/master v6.3 next-20230425]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arseniy-Krasnov/mtd-rawnand-macronix-OTP-access-for-MX30LFxG18AC/20230426-153143
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20230426072455.3887717-1-AVKrasnov%40sberdevices.ru
patch subject: [PATCH v1] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230426/202304261704.eyrD5KVk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3529f3465e99379489b59c035a8a0506c3756ef4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Arseniy-Krasnov/mtd-rawnand-macronix-OTP-access-for-MX30LFxG18AC/20230426-153143
        git checkout 3529f3465e99379489b59c035a8a0506c3756ef4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/mtd/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304261704.eyrD5KVk-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/mtd/nand/raw/nand_macronix.c: In function '__macronix_30lfxg18ac_rw_otp':
>> drivers/mtd/nand/raw/nand_macronix.c:384:19: error: implicit declaration of function 'kmalloc'; did you mean 'mm_alloc'? [-Werror=implicit-function-declaration]
     384 |         dma_buf = kmalloc(MACRONIX_30LFXG18AC_OTP_PAGE_SIZE, GFP_KERNEL);
         |                   ^~~~~~~
         |                   mm_alloc
>> drivers/mtd/nand/raw/nand_macronix.c:384:17: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     384 |         dma_buf = kmalloc(MACRONIX_30LFXG18AC_OTP_PAGE_SIZE, GFP_KERNEL);
         |                 ^
>> drivers/mtd/nand/raw/nand_macronix.c:437:9: error: implicit declaration of function 'kfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
     437 |         kfree(dma_buf);
         |         ^~~~~
         |         kvfree
   cc1: some warnings being treated as errors


vim +384 drivers/mtd/nand/raw/nand_macronix.c

   366	
   367	static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
   368						loff_t offs_in_flash,
   369						size_t len, size_t *retlen,
   370						u_char *buf, bool write)
   371	{
   372		struct nand_chip *nand;
   373		size_t bytes_handled;
   374		unsigned long page;
   375		off_t offs_in_page;
   376		void *dma_buf;
   377		int ret;
   378	
   379		/* 'nand_prog/read_page_op()' may use 'buf' as DMA buffer,
   380		 * so allocate properly aligned memory for it. This is
   381		 * needed because cross page accesses may lead to unaligned
   382		 * buffer address for DMA.
   383		 */
 > 384		dma_buf = kmalloc(MACRONIX_30LFXG18AC_OTP_PAGE_SIZE, GFP_KERNEL);
   385		if (!dma_buf)
   386			return -ENOMEM;
   387	
   388		nand = mtd_to_nand(mtd);
   389		nand_select_target(nand, 0);
   390	
   391		ret = macronix_30lfxg18ac_otp_enable(nand);
   392		if (ret)
   393			goto out_otp;
   394	
   395		page = offs_in_flash;
   396		/* 'page' will be result of division. */
   397		offs_in_page = do_div(page, MACRONIX_30LFXG18AC_OTP_PAGE_SIZE);
   398		bytes_handled = 0;
   399	
   400		while (bytes_handled < len &&
   401		       page < MACRONIX_30LFXG18AC_OTP_PAGES) {
   402			size_t bytes_to_handle;
   403	
   404			bytes_to_handle = min_t(size_t, len - bytes_handled,
   405						MACRONIX_30LFXG18AC_OTP_PAGE_SIZE -
   406						offs_in_page);
   407	
   408			if (write) {
   409				memcpy(dma_buf, &buf[bytes_handled], bytes_to_handle);
   410				ret = nand_prog_page_op(nand, page, offs_in_page,
   411							dma_buf, bytes_to_handle);
   412			} else {
   413				ret = nand_read_page_op(nand, page, offs_in_page,
   414							dma_buf, bytes_to_handle);
   415				if (!ret)
   416					memcpy(&buf[bytes_handled], dma_buf,
   417					       bytes_to_handle);
   418			}
   419			if (ret)
   420				goto out_otp;
   421	
   422			bytes_handled += bytes_to_handle;
   423			offs_in_page = 0;
   424			page++;
   425		}
   426	
   427		*retlen = bytes_handled;
   428	
   429	out_otp:
   430		if (ret)
   431			dev_err(&mtd->dev, "failed to perform OTP IO: %i\n", ret);
   432	
   433		ret = macronix_30lfxg18ac_otp_disable(nand);
   434		WARN(ret, "failed to leave OTP mode after %s\n",
   435		     write ? "write" : "read");
   436		nand_deselect_target(nand);
 > 437		kfree(dma_buf);
   438	
   439		return ret;
   440	}
   441	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
