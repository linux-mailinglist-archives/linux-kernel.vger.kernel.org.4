Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCBB72A119
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjFIRTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFIRTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:19:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4593595
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686331179; x=1717867179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R+DPNYs3Odx4as87qA6r8oobE/bUElgTceoldri5s7o=;
  b=icNZBXQLJtbnm0KNPhJsFktZjI6Guqv83S8ZhuOtLn9IzuR98Lkq8W6v
   NOffLucCEGPg5c8CB0WBjYWxjK/fg72j/pGERa5NuSueL3gdEnx73BICp
   J3WSs4yKrnLSgMM0htUcAOgB2vtVUmTqnhSc0a7N2O7FThEeZ2JFhNijn
   D9TJpfdrh173dMonTKAxUGAV/SlbeCBYORtvqvGBP9pVZeT56NLjr15mV
   5a7ln0Yre8dApzygDmt1aCsafgfPmp9ZgY4rCiWy3dZ3d6yijiRKkYDK9
   ac78Efu4e3uzzDn5XqR+iDHnwbERtir90zanOkJeYYNvEE/PFHQ1XVZJT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="444020531"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="444020531"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 10:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="687815968"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="687815968"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2023 10:19:37 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7flw-0009FT-2Z;
        Fri, 09 Jun 2023 17:19:36 +0000
Date:   Sat, 10 Jun 2023 01:19:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jordy Zomer <jordyzomer@google.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, phil@philpotter.co.uk,
        Jordy Zomer <jordyzomer@google.com>
Subject: Re: [PATCH 1/1] cdrom: Fix spectre-v1 gadget
Message-ID: <202306100143.yzdJpUid-lkp@intel.com>
References: <20230609131355.71130-2-jordyzomer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131355.71130-2-jordyzomer@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jordy,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.4-rc5 next-20230609]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jordy-Zomer/cdrom-Fix-spectre-v1-gadget/20230609-211545
base:   linus/master
patch link:    https://lore.kernel.org/r/20230609131355.71130-2-jordyzomer%40google.com
patch subject: [PATCH 1/1] cdrom: Fix spectre-v1 gadget
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230610/202306100143.yzdJpUid-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout linus/master
        b4 shazam https://lore.kernel.org/r/20230609131355.71130-2-jordyzomer@google.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306100143.yzdJpUid-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cdrom/cdrom.c: In function 'cdrom_ioctl_media_changed':
>> drivers/cdrom/cdrom.c:2333:15: error: implicit declaration of function 'array_index_mask_nospec' [-Werror=implicit-function-declaration]
    2333 |         arg = array_index_mask_nospec(arg, cdi->capacity);
         |               ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/array_index_mask_nospec +2333 drivers/cdrom/cdrom.c

  2314	
  2315	static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
  2316			unsigned long arg)
  2317	{
  2318		struct cdrom_changer_info *info;
  2319		int ret;
  2320	
  2321		cd_dbg(CD_DO_IOCTL, "entering CDROM_MEDIA_CHANGED\n");
  2322	
  2323		if (!CDROM_CAN(CDC_MEDIA_CHANGED))
  2324			return -ENOSYS;
  2325	
  2326		/* cannot select disc or select current disc */
  2327		if (!CDROM_CAN(CDC_SELECT_DISC) || arg == CDSL_CURRENT)
  2328			return media_changed(cdi, 1);
  2329	
  2330		if (arg >= cdi->capacity)
  2331			return -EINVAL;
  2332	
> 2333		arg = array_index_mask_nospec(arg, cdi->capacity);
  2334	
  2335		info = kmalloc(sizeof(*info), GFP_KERNEL);
  2336		if (!info)
  2337			return -ENOMEM;
  2338	
  2339		ret = cdrom_read_mech_status(cdi, info);
  2340		if (!ret)
  2341			ret = info->slots[arg].change;
  2342		kfree(info);
  2343		return ret;
  2344	}
  2345	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
