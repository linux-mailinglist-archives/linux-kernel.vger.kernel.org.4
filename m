Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D85730BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjFOABf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFOABc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:01:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469181BF8;
        Wed, 14 Jun 2023 17:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686787291; x=1718323291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vlOy6sNgAGOk3m1Tw2KlI83PWTTLu4KM+zfhCO79zT0=;
  b=SEffVFP0qRkZO/g+PYR+X68Coz40848nKC/oLkJjGC6WpJGvxX/d3LdY
   nOnfklE0UUCRZzUGx32nebyOhL/wQOqLMTLBCjXO+7Qj67XWgOO9kVmRF
   SeMZv4XuzOhf8yIfOSwerzRQRjJLOMG7mVNm+TW72vS/VZqvbcWE9tjC5
   Q67kPRHfE7rhikmRz0lsPRwUM/Hg5ViwCvCJjpMJhAKvFTIaTZkPeiqJY
   Uj0t649yeRbLbszofd3rCO/9DULw3fKB54Vzs+jwfd6f5fOXUqg6YUcaj
   RhmUbuuz7wU8f1+4X6R0mHThJpsPX1QLK8fN0aHtnnT4Ahh0dLgjqKWCu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="356259699"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="356259699"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 17:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="742021292"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="742021292"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2023 17:01:25 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9aQ0-0001BJ-1e;
        Thu, 15 Jun 2023 00:00:57 +0000
Date:   Thu, 15 Jun 2023 07:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usbip: usbip_host: Replace strlcpy with strscpy
Message-ID: <202306150753.vOUEonLq-lkp@intel.com>
References: <20230614141026.2113749-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614141026.2113749-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Azeem,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.4-rc6 next-20230614]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Azeem-Shaikh/usbip-usbip_host-Replace-strlcpy-with-strscpy/20230614-221217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230614141026.2113749-1-azeemshaikh38%40gmail.com
patch subject: [PATCH v2] usbip: usbip_host: Replace strlcpy with strscpy
config: i386-randconfig-i012-20230614 (https://download.01.org/0day-ci/archive/20230615/202306150753.vOUEonLq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        git remote add usb https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
        git fetch usb usb-testing
        git checkout usb/usb-testing
        b4 shazam https://lore.kernel.org/r/20230614141026.2113749-1-azeemshaikh38@gmail.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/usbip/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306150753.vOUEonLq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/usbip/stub_main.c: In function 'match_busid_store':
>> drivers/usb/usbip/stub_main.c:170:13: warning: unused variable 'len' [-Wunused-variable]
     170 |         int len;
         |             ^~~


vim +/len +170 drivers/usb/usbip/stub_main.c

4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  166  
cc3d53def83a99 drivers/usb/usbip/stub_main.c     Greg Kroah-Hartman 2017-06-09  167  static ssize_t match_busid_store(struct device_driver *dev, const char *buf,
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  168  				 size_t count)
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  169  {
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09 @170  	int len;
e913397202b755 drivers/staging/usbip/stub_main.c Kay Sievers        2008-10-30  171  	char busid[BUSID_SIZE];
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  172  
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  173  	if (count < 5)
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  174  		return -EINVAL;
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  175  
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  176  	/* busid needs to include \0 termination */
7e5b2b663aa01a drivers/usb/usbip/stub_main.c     Azeem Shaikh       2023-06-14  177  	if (strscpy(busid, buf + 4, BUSID_SIZE) < 0)
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  178  		return -EINVAL;
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  179  
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  180  	if (!strncmp(buf, "add ", 4)) {
2183b77ece517f drivers/staging/usbip/stub_main.c Kurt Kanzenbach    2013-04-04  181  		if (add_match_busid(busid) < 0)
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  182  			return -ENOMEM;
2183b77ece517f drivers/staging/usbip/stub_main.c Kurt Kanzenbach    2013-04-04  183  
1a4b6f66285785 drivers/staging/usbip/stub_main.c matt mooney        2011-05-19  184  		pr_debug("add busid %s\n", busid);
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  185  		return count;
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  186  	}
2183b77ece517f drivers/staging/usbip/stub_main.c Kurt Kanzenbach    2013-04-04  187  
2183b77ece517f drivers/staging/usbip/stub_main.c Kurt Kanzenbach    2013-04-04  188  	if (!strncmp(buf, "del ", 4)) {
2183b77ece517f drivers/staging/usbip/stub_main.c Kurt Kanzenbach    2013-04-04  189  		if (del_match_busid(busid) < 0)
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  190  			return -ENODEV;
2183b77ece517f drivers/staging/usbip/stub_main.c Kurt Kanzenbach    2013-04-04  191  
1a4b6f66285785 drivers/staging/usbip/stub_main.c matt mooney        2011-05-19  192  		pr_debug("del busid %s\n", busid);
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  193  		return count;
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  194  	}
2183b77ece517f drivers/staging/usbip/stub_main.c Kurt Kanzenbach    2013-04-04  195  
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  196  	return -EINVAL;
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  197  }
cc3d53def83a99 drivers/usb/usbip/stub_main.c     Greg Kroah-Hartman 2017-06-09  198  static DRIVER_ATTR_RW(match_busid);
4d7b5c7f8ad49b drivers/staging/usbip/stub_main.c Takahiro Hirofuchi 2008-07-09  199  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
