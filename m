Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5294972A1EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjFISPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjFISOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:14:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F835BE;
        Fri,  9 Jun 2023 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686334483; x=1717870483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s6PMRTdXqAmK7gh5R1wLzFq6mutI0Y/2eO7ArWN9Qco=;
  b=cMFzpIFP7msS0ubM/xiT/SQS8s7nfAqIezdup6plFT+7MDbFGgU9qWWH
   kZzZIzyy906WpCwv5tzhVvvWrE1Xs/gS2kC7BzdhXWZXCRUefns1oU/un
   Nw4C1hPYEY+exyAXkDUO09LVx6ma4KnCwX4KNOrEeozhAOsKZpzgKnjP1
   GRlyGv+jyCBQFSaXLNS5pKbVZSK7Epc4jtjtJfU5/6dSODOEhR2xdMqUi
   k44sW3CvndkOm/n2UjAdpj5bmytkw0ROUwM4PHyNePmapRvVp+BIeFAr2
   ktrfSKiYV7bj8BEjg4Ql9B/eN2M3PxBYTzhhnzioFBqzvDBNVCRYdBeLi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="355148000"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="355148000"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 11:14:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="1040564649"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="1040564649"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2023 11:14:40 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7gdD-0009IG-0s;
        Fri, 09 Jun 2023 18:14:39 +0000
Date:   Sat, 10 Jun 2023 02:13:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        quic_anane@quicinc.com
Subject: Re: [PATCH v1 2/2] misc: fastrpc: Add persistent header buffer
 support
Message-ID: <202306100111.JeCyQ9wW-lkp@intel.com>
References: <1686307187-15199-3-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686307187-15199-3-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ekansh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.4-rc5 next-20230609]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ekansh-Gupta/misc-fastrpc-Add-cached-buffer-support/20230609-184517
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/1686307187-15199-3-git-send-email-quic_ekangupt%40quicinc.com
patch subject: [PATCH v1 2/2] misc: fastrpc: Add persistent header buffer support
config: arm64-randconfig-r024-20230608 (https://download.01.org/0day-ci/archive/20230610/202306100111.JeCyQ9wW-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
        git fetch char-misc char-misc-testing
        git checkout char-misc/char-misc-testing
        b4 shazam https://lore.kernel.org/r/1686307187-15199-3-git-send-email-quic_ekangupt@quicinc.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/misc/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306100111.JeCyQ9wW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/misc/fastrpc.c:1400:8: warning: format specifies type 'unsigned long long' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
                           fd, va, size);
                               ^~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
>> drivers/misc/fastrpc.c:1400:12: warning: format specifies type 'long long' but the argument has type 'size_t' (aka 'unsigned long') [-Wformat]
                           fd, va, size);
                                   ^~~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +1400 drivers/misc/fastrpc.c

  1360	
  1361	static int fastrpc_mem_map_to_dsp(struct fastrpc_user *fl, int fd, int offset,
  1362					u32 flags, u32 va, u64 phys,
  1363					size_t size, uintptr_t *raddr)
  1364	{
  1365		struct fastrpc_invoke_args args[4] = { [0 ... 3] = { 0 } };
  1366		struct fastrpc_mem_map_req_msg req_msg = { 0 };
  1367		struct fastrpc_mmap_rsp_msg rsp_msg = { 0 };
  1368		struct fastrpc_phy_page pages = { 0 };
  1369		struct device *dev = fl->sctx->dev;
  1370		int err = 0;
  1371		u32 sc;
  1372	
  1373		req_msg.pgid = fl->tgid;
  1374		req_msg.fd = fd;
  1375		req_msg.offset = offset;
  1376		req_msg.vaddrin = va;
  1377		req_msg.flags = flags;
  1378		req_msg.num = sizeof(pages);
  1379		req_msg.data_len = 0;
  1380	
  1381		args[0].ptr = (u64) (uintptr_t) &req_msg;
  1382		args[0].length = sizeof(req_msg);
  1383	
  1384		pages.addr = phys;
  1385		pages.size = size;
  1386	
  1387		args[1].ptr = (u64) (uintptr_t) &pages;
  1388		args[1].length = sizeof(pages);
  1389	
  1390		args[2].ptr = (u64) (uintptr_t) &pages;
  1391		args[2].length = 0;
  1392	
  1393		args[3].ptr = (u64) (uintptr_t) &rsp_msg;
  1394		args[3].length = sizeof(rsp_msg);
  1395	
  1396		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
  1397		err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
  1398		if (err) {
  1399			dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
> 1400				fd, va, size);
  1401			return err;
  1402		}
  1403		*raddr = rsp_msg.vaddr;
  1404	
  1405		return 0;
  1406	}
  1407	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
