Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6D768D4B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjBGKrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjBGKrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:47:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6061B13518;
        Tue,  7 Feb 2023 02:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675766820; x=1707302820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3o/IO5jmL5OOKn1iWyLWVWGS5mU414VnroKUj8HrQAI=;
  b=G5HB9edPTIwhnqkuZ0s5uNoMNAvVtzWwaBCCdCPnVJl3gsxOcsn8JxH6
   S/Q5o7L2uOhP+M5IBwDLrUyqqyAFh9zoS5ucdbrUAi9Ya+xCLiI0NC9ro
   iwe1URuHq2o+UBdUJWOQBWomYmNLBhVMprys+qGbtRtx+AYeMcUuM5LUC
   inaF3bZI1FTfIMgTZF1alSRRAaT4SkT+uteat9UOb0cpPtDV9Dux6tDp6
   4IZDe07PAT7KaVQ5gI1IirRUufVG+7XjKJn2wv3jQI4yhtH+Exg8MQFx4
   z+36LuBz8cjOhgLEe8/vKhq7oigiJ1q2Iw5ZJZJc1qljfS1tIBLF85Ndi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="329493248"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="329493248"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 02:46:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668741431"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668741431"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Feb 2023 02:46:57 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPLV2-0003T2-10;
        Tue, 07 Feb 2023 10:46:56 +0000
Date:   Tue, 7 Feb 2023 18:45:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: Re: [PATCH v3 2/5] usb: dwc3: Add remote wakeup handling
Message-ID: <202302071850.VZRjtYXx-lkp@intel.com>
References: <1675710806-9735-3-git-send-email-quic_eserrao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675710806-9735-3-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elson,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.2-rc7 next-20230207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elson-Roy-Serrao/usb-gadget-Properly-configure-the-device-for-remote-wakeup/20230207-031528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/1675710806-9735-3-git-send-email-quic_eserrao%40quicinc.com
patch subject: [PATCH v3 2/5] usb: dwc3: Add remote wakeup handling
config: i386-randconfig-a002-20230206 (https://download.01.org/0day-ci/archive/20230207/202302071850.VZRjtYXx-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e0d9f3f5f168e36cdb599617634010326a1412af
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Elson-Roy-Serrao/usb-gadget-Properly-configure-the-device-for-remote-wakeup/20230207-031528
        git checkout e0d9f3f5f168e36cdb599617634010326a1412af
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/dwc3/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/dwc3/gadget.c:2318:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           case DWC3_LINK_STATE_RESET:
           ^
   drivers/usb/dwc3/gadget.c:2318:2: note: insert 'break;' to avoid fall-through
           case DWC3_LINK_STATE_RESET:
           ^
           break; 
   1 warning generated.


vim +2318 drivers/usb/dwc3/gadget.c

72246da40f3719af Felipe Balbi           2011-08-19  2291  
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2292  static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
72246da40f3719af Felipe Balbi           2011-08-19  2293  {
d6011f6fc21b4d4a Nicolas Saenz Julienne 2016-08-16  2294  	int			retries;
72246da40f3719af Felipe Balbi           2011-08-19  2295  
218ef7b647e3367c Felipe Balbi           2016-04-04  2296  	int			ret;
72246da40f3719af Felipe Balbi           2011-08-19  2297  	u32			reg;
72246da40f3719af Felipe Balbi           2011-08-19  2298  
72246da40f3719af Felipe Balbi           2011-08-19  2299  	u8			link_state;
72246da40f3719af Felipe Balbi           2011-08-19  2300  
72246da40f3719af Felipe Balbi           2011-08-19  2301  	/*
72246da40f3719af Felipe Balbi           2011-08-19  2302  	 * According to the Databook Remote wakeup request should
72246da40f3719af Felipe Balbi           2011-08-19  2303  	 * be issued only when the device is in early suspend state.
72246da40f3719af Felipe Balbi           2011-08-19  2304  	 *
72246da40f3719af Felipe Balbi           2011-08-19  2305  	 * We can check that via USB Link State bits in DSTS register.
72246da40f3719af Felipe Balbi           2011-08-19  2306  	 */
72246da40f3719af Felipe Balbi           2011-08-19  2307  	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
72246da40f3719af Felipe Balbi           2011-08-19  2308  
72246da40f3719af Felipe Balbi           2011-08-19  2309  	link_state = DWC3_DSTS_USBLNKST(reg);
72246da40f3719af Felipe Balbi           2011-08-19  2310  
72246da40f3719af Felipe Balbi           2011-08-19  2311  	switch (link_state) {
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2312  	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2313  		if (!dwc->rw_configured) {
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2314  			dev_err(dwc->dev,
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2315  				"device not configured for remote wakeup\n");
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2316  			return -EINVAL;
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2317  		}
d0550cd20e52558e Thinh Nguyen           2020-01-31 @2318  	case DWC3_LINK_STATE_RESET:
72246da40f3719af Felipe Balbi           2011-08-19  2319  	case DWC3_LINK_STATE_RX_DET:	/* in HS, means Early Suspend */
c560e76319a94a3b Thinh Nguyen           2021-04-19  2320  	case DWC3_LINK_STATE_U2:	/* in HS, means Sleep (L1) */
c560e76319a94a3b Thinh Nguyen           2021-04-19  2321  	case DWC3_LINK_STATE_U1:
d0550cd20e52558e Thinh Nguyen           2020-01-31  2322  	case DWC3_LINK_STATE_RESUME:
72246da40f3719af Felipe Balbi           2011-08-19  2323  		break;
72246da40f3719af Felipe Balbi           2011-08-19  2324  	default:
218ef7b647e3367c Felipe Balbi           2016-04-04  2325  		return -EINVAL;
72246da40f3719af Felipe Balbi           2011-08-19  2326  	}
72246da40f3719af Felipe Balbi           2011-08-19  2327  
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2328  	if (async)
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2329  		dwc3_gadget_enable_linksts_evts(dwc, true);
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2330  
8598bde7fa125e85 Felipe Balbi           2012-01-02  2331  	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
8598bde7fa125e85 Felipe Balbi           2012-01-02  2332  	if (ret < 0) {
8598bde7fa125e85 Felipe Balbi           2012-01-02  2333  		dev_err(dwc->dev, "failed to put link in Recovery\n");
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2334  		dwc3_gadget_enable_linksts_evts(dwc, false);
218ef7b647e3367c Felipe Balbi           2016-04-04  2335  		return ret;
8598bde7fa125e85 Felipe Balbi           2012-01-02  2336  	}
72246da40f3719af Felipe Balbi           2011-08-19  2337  
802fde983e8a3391 Paul Zimmerman         2012-04-27  2338  	/* Recent versions do this automatically */
9af21dd6faeba593 Thinh Nguyen           2020-04-11  2339  	if (DWC3_VER_IS_PRIOR(DWC3, 194A)) {
72246da40f3719af Felipe Balbi           2011-08-19  2340  		/* write zeroes to Link Change Request */
fcc023c726b5879d Felipe Balbi           2012-05-24  2341  		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
72246da40f3719af Felipe Balbi           2011-08-19  2342  		reg &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
72246da40f3719af Felipe Balbi           2011-08-19  2343  		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
802fde983e8a3391 Paul Zimmerman         2012-04-27  2344  	}
72246da40f3719af Felipe Balbi           2011-08-19  2345  
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2346  	/*
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2347  	 * Since link status change events are enabled we will receive
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2348  	 * an U0 event when wakeup is successful. So bail out.
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2349  	 */
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2350  	if (async)
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2351  		return 0;
e0d9f3f5f168e36c Elson Roy Serrao       2023-02-06  2352  
1d046793958f128d Paul Zimmerman         2012-02-15  2353  	/* poll until Link State changes to ON */
d6011f6fc21b4d4a Nicolas Saenz Julienne 2016-08-16  2354  	retries = 20000;
72246da40f3719af Felipe Balbi           2011-08-19  2355  
d6011f6fc21b4d4a Nicolas Saenz Julienne 2016-08-16  2356  	while (retries--) {
72246da40f3719af Felipe Balbi           2011-08-19  2357  		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
72246da40f3719af Felipe Balbi           2011-08-19  2358  
72246da40f3719af Felipe Balbi           2011-08-19  2359  		/* in HS, means ON */
72246da40f3719af Felipe Balbi           2011-08-19  2360  		if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
72246da40f3719af Felipe Balbi           2011-08-19  2361  			break;
72246da40f3719af Felipe Balbi           2011-08-19  2362  	}
72246da40f3719af Felipe Balbi           2011-08-19  2363  
72246da40f3719af Felipe Balbi           2011-08-19  2364  	if (DWC3_DSTS_USBLNKST(reg) != DWC3_LINK_STATE_U0) {
72246da40f3719af Felipe Balbi           2011-08-19  2365  		dev_err(dwc->dev, "failed to send remote wakeup\n");
218ef7b647e3367c Felipe Balbi           2016-04-04  2366  		return -EINVAL;
72246da40f3719af Felipe Balbi           2011-08-19  2367  	}
72246da40f3719af Felipe Balbi           2011-08-19  2368  
218ef7b647e3367c Felipe Balbi           2016-04-04  2369  	return 0;
218ef7b647e3367c Felipe Balbi           2016-04-04  2370  }
218ef7b647e3367c Felipe Balbi           2016-04-04  2371  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
