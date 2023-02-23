Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639406A07DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjBWL6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjBWL6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:58:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16A41555C;
        Thu, 23 Feb 2023 03:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677153482; x=1708689482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zpgcNYhoA496+RSwPP+SH3dIndgNj3WsYifr7w6TjJA=;
  b=HmOw6eKgFJT+BQzCxm5drWMdJUFEEKEvkAjyA6FoWRUEihH4GnmzGhGp
   PjiBeGF92iJTSP3WtiUMNqgthrt+X2KnSyU1Z37DqHkUQXWeg7pKvYKev
   R/qxwE39aK1d8VhgDz7ykcC6y4XTLasjLddSn+3OcZCfmomvTztgZV7Ne
   NWKFr8N9pwbXjvERsj7mQT1spgHis6SKCgcUCi0cKf83bYjNsXz7PsFA1
   dolggYdIi/oeMCIzNK2EPh3XNbU6Rm3Aglz3caYtZjZTiF/GEvnsAZ6Zo
   mNl2yNzhOnsJ9DiuCRIcSmhK3Zd53r52tU3D6NoZNadq8D74/f5VvSa5i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="313562779"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="313562779"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 03:58:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="1001391531"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="1001391531"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2023 03:57:58 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVAEY-0001JB-0Z;
        Thu, 23 Feb 2023 11:57:58 +0000
Date:   Thu, 23 Feb 2023 19:57:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prashanth K <quic_prashk@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Prashanth K <quic_prashk@quicinc.com>
Subject: Re: [PATCH v2 2/2] usb: gadget: composite: Draw 100mA current if not
 configured
Message-ID: <202302231910.xs35xNcG-lkp@intel.com>
References: <1677142665-8686-3-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1677142665-8686-3-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashanth,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prashanth-K/usb-dwc3-gadget-Change-condition-for-processing-suspend-event/20230223-165955
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/1677142665-8686-3-git-send-email-quic_prashk%40quicinc.com
patch subject: [PATCH v2 2/2] usb: gadget: composite: Draw 100mA current if not configured
config: hexagon-randconfig-r005-20230222 (https://download.01.org/0day-ci/archive/20230223/202302231910.xs35xNcG-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/19beaeb0554fc9c1556e8f7da85011f4267bd8fc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Prashanth-K/usb-dwc3-gadget-Change-condition-for-processing-suspend-event/20230223-165955
        git checkout 19beaeb0554fc9c1556e8f7da85011f4267bd8fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/usb/gadget/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302231910.xs35xNcG-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/usb/gadget/composite.c:19:
   In file included from include/linux/usb/composite.h:27:
   In file included from include/linux/usb/gadget.h:24:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/usb/gadget/composite.c:19:
   In file included from include/linux/usb/composite.h:27:
   In file included from include/linux/usb/gadget.h:24:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/usb/gadget/composite.c:19:
   In file included from include/linux/usb/composite.h:27:
   In file included from include/linux/usb/gadget.h:24:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/usb/gadget/composite.c:2535:14: warning: comparison of distinct pointer types ('typeof (2) *' (aka 'int *') and 'typeof (100U) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
                   maxpower = min(CONFIG_USB_GADGET_VBUS_DRAW, 100U)
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
>> drivers/usb/gadget/composite.c:2535:52: error: expected ';' after expression
                   maxpower = min(CONFIG_USB_GADGET_VBUS_DRAW, 100U)
                                                                    ^
                                                                    ;
   7 warnings and 1 error generated.


vim +2535 drivers/usb/gadget/composite.c

  2504	
  2505	void composite_resume(struct usb_gadget *gadget)
  2506	{
  2507		struct usb_composite_dev	*cdev = get_gadget_data(gadget);
  2508		struct usb_function		*f;
  2509		unsigned			maxpower;
  2510	
  2511		/* REVISIT:  should we have config level
  2512		 * suspend/resume callbacks?
  2513		 */
  2514		DBG(cdev, "resume\n");
  2515		if (cdev->driver->resume)
  2516			cdev->driver->resume(cdev);
  2517		if (cdev->config) {
  2518			list_for_each_entry(f, &cdev->config->functions, list) {
  2519				if (f->resume)
  2520					f->resume(f);
  2521			}
  2522	
  2523			maxpower = cdev->config->MaxPower ?
  2524				cdev->config->MaxPower : CONFIG_USB_GADGET_VBUS_DRAW;
  2525			if (gadget->speed < USB_SPEED_SUPER)
  2526				maxpower = min(maxpower, 500U);
  2527			else
  2528				maxpower = min(maxpower, 900U);
  2529	
  2530			if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW)
  2531				usb_gadget_clear_selfpowered(gadget);
  2532	
  2533			usb_gadget_vbus_draw(gadget, maxpower);
  2534		} else {
> 2535			maxpower = min(CONFIG_USB_GADGET_VBUS_DRAW, 100U)
  2536			usb_gadget_vbus_draw(gadget, maxpower);
  2537		}
  2538	
  2539		cdev->suspended = 0;
  2540	}
  2541	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
