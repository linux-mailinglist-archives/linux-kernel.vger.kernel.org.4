Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D216FFA36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbjEKTfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjEKTf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:35:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126BC5276;
        Thu, 11 May 2023 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683833728; x=1715369728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UCfb786k0CkFk6SFe9xc6UK6PQOmd5zPDQwh74go7sI=;
  b=kcAhseR+loMKbq2HX/RFg+jTmfp80i5ZStzc74YcMWU4oJqusT95uq78
   qLenjPS/Gqe7J2sysZo7YeE5y+qkezt5WiaWuLaqtYxzjM9lSXneZlrNq
   BPaNAiO+jdb3Y2W24wt4Y1cli/LDL9ai3NVcBrajHCsjRaxD6hKwoISqs
   gDO6wlUzlLIHNwsqdse5Xp7vjzVGCB7YxMQffVjZLvFjbMl+DYKB8Q8+h
   ZrMQHU3LlFjvMWCj77ZZNYjAt1KiqiIPjhihXfXib9CjmK31o071U++GY
   RhOlWXHeZRCAC5y6e1k4Jp6M6EXxmzqc+g0oOpU5k33Dv7xSfN6egYMnB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="416231780"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="416231780"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 12:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="824100176"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="824100176"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 May 2023 12:34:29 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxC3Y-0004DY-35;
        Thu, 11 May 2023 19:34:28 +0000
Date:   Fri, 12 May 2023 03:33:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: Re: [PATCH 1/2] usb: function: u_ether: Handle rx requests during
 suspend/resume
Message-ID: <202305120311.KEGxEo2Z-lkp@intel.com>
References: <1683827311-1462-2-git-send-email-quic_eserrao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683827311-1462-2-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elson,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.4-rc1 next-20230511]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elson-Roy-Serrao/usb-function-u_ether-Handle-rx-requests-during-suspend-resume/20230512-015036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/1683827311-1462-2-git-send-email-quic_eserrao%40quicinc.com
patch subject: [PATCH 1/2] usb: function: u_ether: Handle rx requests during suspend/resume
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230512/202305120311.KEGxEo2Z-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/90c8743982bad3c71cd13e366efa6b596dd24120
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Elson-Roy-Serrao/usb-function-u_ether-Handle-rx-requests-during-suspend-resume/20230512-015036
        git checkout 90c8743982bad3c71cd13e366efa6b596dd24120
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/usb/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305120311.KEGxEo2Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/gadget/function/u_ether.c: In function 'ether_wakeup_work':
>> drivers/usb/gadget/function/u_ether.c:442:33: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     442 |         int                     ret;
         |                                 ^~~
   drivers/usb/gadget/function/u_ether.c: In function 'gether_suspend':
>> drivers/usb/gadget/function/u_ether.c:1049:13: warning: variable 'status' set but not used [-Wunused-but-set-variable]
    1049 |         int status;
         |             ^~~~~~


vim +/ret +442 drivers/usb/gadget/function/u_ether.c

2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell   2008-06-19  439  
90c8743982bad3 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-05-11  440  static void ether_wakeup_work(struct work_struct *w)
0a1af6dfa0772f drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-03-24  441  {
0a1af6dfa0772f drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-03-24 @442  	int			ret;
90c8743982bad3 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-05-11  443  	struct eth_dev		*dev = container_of(w, struct eth_dev, wakeup_work);
90c8743982bad3 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-05-11  444  	struct gether		*port = dev->port_usb;
0a1af6dfa0772f drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-03-24  445  	struct usb_function	*func = &port->func;
0a1af6dfa0772f drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-03-24  446  	struct usb_gadget	*gadget = func->config->cdev->gadget;
0a1af6dfa0772f drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-03-24  447  
0a1af6dfa0772f drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-03-24  448  	if (func->func_suspended)
0a1af6dfa0772f drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-03-24  449  		ret = usb_func_wakeup(func);
0a1af6dfa0772f drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-03-24  450  	else
0a1af6dfa0772f drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-03-24  451  		ret = usb_gadget_wakeup(gadget);
0a1af6dfa0772f drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-03-24  452  }
0a1af6dfa0772f drivers/usb/gadget/function/u_ether.c Elson Roy Serrao 2023-03-24  453  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
