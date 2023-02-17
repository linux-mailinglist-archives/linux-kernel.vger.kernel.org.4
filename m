Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B755969A5F7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBQHPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQHPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:15:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955D94C6F5;
        Thu, 16 Feb 2023 23:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676618145; x=1708154145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yECA7TZIMTQGBBLaxq8M5VMtISSeJ1pEW7liYpiuwhg=;
  b=AjV1DEzxDc93oH7VCAa/dmySL5Doo1i6R5A3CVpkbWmSYlx0wmRldkn3
   eSZi+DsDQxjlIGZxi4jGEpDt/ns1SGv4r56sCgVtVQVlLUq3CJV0v3V0Z
   OMgkh24HrcukaUfy2cx+jm5BaukK1XKx0m3KTnEiOY1aMqX8WMLwnscVm
   SLRkowYNYb44lx57ZPTmobUA7+MqPR+FqG383MvdqJWMox5l7t0XZNdBF
   hY1qAdXQd8A3VUOB1EHlmqiMpithMpGejw6tiTyCGMS7hBCiDK6Vx4Re0
   yMXICevBwQjEt5Wtytfanf85HnWTxJk301r8O0l16/NQkQIYYKpNsE7je
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="320033255"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="320033255"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 23:13:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="700813047"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="700813047"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Feb 2023 23:13:02 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSuvV-000BCF-2r;
        Fri, 17 Feb 2023 07:13:01 +0000
Date:   Fri, 17 Feb 2023 15:12:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pawel Laszczak <pawell@cadence.com>, gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daisy.Barrera@siriusxm.com,
        Cliff.Holden@siriusxm.com, arnd@arndb.de, tony@atomide.com,
        jdelvare@suse.de, neal_liu@aspeedtech.com,
        linus.walleij@linaro.org, egtvedt@samfundet.no,
        biju.das.jz@bp.renesas.com, herve.codina@bootlin.com,
        Pawel Laszczak <pawell@cadence.com>
Subject: Re: [PATCH 2/4] usb: cdns2: Add main part of Cadence USBHS driver
Message-ID: <202302171404.Wy9aWegd-lkp@intel.com>
References: <20230216105411.364157-3-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216105411.364157-3-pawell@cadence.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus westeri-thunderbolt/next soc/for-next linus/master v6.2-rc8 next-20230216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawel-Laszczak/usb-cdns2-Device-side-header-file-for-CDNS2-driver/20230216-195428
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230216105411.364157-3-pawell%40cadence.com
patch subject: [PATCH 2/4] usb: cdns2: Add main part of Cadence USBHS driver
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20230217/202302171404.Wy9aWegd-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c2450201a6400c7dafcad24e4762506733b6af9b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pawel-Laszczak/usb-cdns2-Device-side-header-file-for-CDNS2-driver/20230216-195428
        git checkout c2450201a6400c7dafcad24e4762506733b6af9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/usb/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302171404.Wy9aWegd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/gadget/udc/cdns2/cdns2-gadget.c: In function 'cdns2_gadget_ep_enable':
>> drivers/usb/gadget/udc/cdns2/cdns2-gadget.c:1374:49: warning: variable 'comp_desc' set but not used [-Wunused-but-set-variable]
    1374 |         const struct usb_ss_ep_comp_descriptor *comp_desc;
         |                                                 ^~~~~~~~~
--
   drivers/usb/gadget/udc/cdns2/cdns2-ep0.c: In function 'cdns2_ep0_stall':
>> drivers/usb/gadget/udc/cdns2/cdns2-ep0.c:88:12: warning: variable 'reg' set but not used [-Wunused-but-set-variable]
      88 |         u8 reg;
         |            ^~~


vim +/comp_desc +1374 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c

  1370	
  1371	static int cdns2_gadget_ep_enable(struct usb_ep *ep,
  1372					  const struct usb_endpoint_descriptor *desc)
  1373	{
> 1374		const struct usb_ss_ep_comp_descriptor *comp_desc;
  1375		u32 reg = DMA_EP_STS_EN_TRBERREN;
  1376		struct cdns2_endpoint *pep;
  1377		struct cdns2_device *pdev;
  1378		unsigned long flags;
  1379		int enable = 1;
  1380		int ret = 0;
  1381	
  1382		if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT ||
  1383		    !desc->wMaxPacketSize) {
  1384			return -EINVAL;
  1385		}
  1386	
  1387		pep = ep_to_cdns2_ep(ep);
  1388		pdev = pep->pdev;
  1389		comp_desc = pep->endpoint.comp_desc;
  1390	
  1391		if (dev_WARN_ONCE(pdev->dev, pep->ep_state & EP_ENABLED,
  1392				  "%s is already enabled\n", pep->name))
  1393			return 0;
  1394	
  1395		spin_lock_irqsave(&pdev->lock, flags);
  1396	
  1397		pep->type = usb_endpoint_type(desc);
  1398		pep->interval = desc->bInterval ? BIT(desc->bInterval - 1) : 0;
  1399	
  1400		if (pdev->gadget.speed == USB_SPEED_FULL)
  1401			if (pep->type == USB_ENDPOINT_XFER_INT)
  1402				pep->interval = desc->bInterval;
  1403	
  1404		if (pep->interval > ISO_MAX_INTERVAL &&
  1405		    pep->type == USB_ENDPOINT_XFER_ISOC) {
  1406			dev_err(pdev->dev, "ISO period is limited to %d (current: %d)\n",
  1407				ISO_MAX_INTERVAL, pep->interval);
  1408	
  1409			ret =  -EINVAL;
  1410			goto exit;
  1411		}
  1412	
  1413		/*
  1414		 * During ISO OUT traffic DMA reads Transfer Ring for the EP which has
  1415		 * never got doorbell.
  1416		 * This issue was detected only on simulation, but to avoid this issue
  1417		 * driver add protection against it. To fix it driver enable ISO OUT
  1418		 * endpoint before setting DRBL. This special treatment of ISO OUT
  1419		 * endpoints are recommended by controller specification.
  1420		 */
  1421		if (pep->type == USB_ENDPOINT_XFER_ISOC  && !pep->dir)
  1422			enable = 0;
  1423	
  1424		ret = cdns2_alloc_tr_segment(pep);
  1425		if (ret)
  1426			goto exit;
  1427	
  1428		ret = cdns2_ep_config(pep, enable);
  1429		if (ret) {
  1430			cdns2_free_tr_segment(pep);
  1431			ret =  -EINVAL;
  1432			goto exit;
  1433		}
  1434	
  1435		pep->ep_state &= ~(EP_STALLED | EP_STALL_PENDING |
  1436				   EP_QUIRK_ISO_OUT_EN);
  1437		pep->ep_state |= EP_ENABLED | EP_UPDATE_EP_TRBADDR;
  1438		pep->wa1_set = 0;
  1439		pep->ring.enqueue = 0;
  1440		pep->ring.dequeue = 0;
  1441		reg = readl(&pdev->adma_regs->ep_sts);
  1442		pep->ring.pcs = !!DMA_EP_STS_CCS(reg);
  1443		pep->ring.ccs = !!DMA_EP_STS_CCS(reg);
  1444		/* one TRB is reserved for link TRB used in DMULT mode*/
  1445		pep->ring.free_trbs = TRBS_PER_SEGMENT - 1;
  1446	
  1447	exit:
  1448		spin_unlock_irqrestore(&pdev->lock, flags);
  1449	
  1450		return ret;
  1451	}
  1452	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
