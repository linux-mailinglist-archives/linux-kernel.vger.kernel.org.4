Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1FC5B3648
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIILY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiIILYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:24:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D184A138660;
        Fri,  9 Sep 2022 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662722657; x=1694258657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tNZVvaoIroI4CcedWHpWhX3pMpdWjxPYKYoBC7xujYM=;
  b=OCxdYWmEzMgCyifTLcyIApr+AIA10p8WFgilNgPAJhKA5KdQb8+YGfbV
   Liz8wXrIcaFmu2N1J+nyS7HX8KkJWkDGo/fQUprHbllf7VA9EJd5S+kc+
   38tjY1IV19LPIUtxbohVz2am0jejnf7fS/1KeA3kwj6fBSkrfg5ovbYus
   y+ewOfS/WYTFFvTNHPR9pI3+o1h/qTXzaH2olUr6Mdl39jC6c5VLrCmnl
   4PeSFKPN2ed9wqQmKT7ZlsefTME5KFG8AY0sC09zoOI/S+3tSPSDjTuba
   9hXEjmEim56Yqg0NCtG6LhH47ggBMN66UxJCYMr8/26pCE4B7oayNnZew
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298791882"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="298791882"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 04:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="741022180"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Sep 2022 04:24:14 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWc7J-00016h-39;
        Fri, 09 Sep 2022 11:24:13 +0000
Date:   Fri, 9 Sep 2022 19:23:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhong <floridsleeves@gmail.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     kbuild-all@lists.01.org, heghedus.razvan@gmail.com,
        evgreen@chromium.org, yuanjilin@cdjrlc.com,
        stern@rowland.harvard.edu, jj251510319013@gmail.com,
        gregkh@linuxfoundation.org, Li Zhong <floridsleeves@gmail.com>
Subject: Re: [PATCH v1] drivers/usb/core/driver: check return value of
 usb_set_interface()
Message-ID: <202209091933.ydDI9QtH-lkp@intel.com>
References: <20220909044215.2620024-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909044215.2620024-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on westeri-thunderbolt/next staging/staging-testing linus/master v6.0-rc4 next-20220909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhong/drivers-usb-core-driver-check-return-value-of-usb_set_interface/20220909-124349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220909/202209091933.ydDI9QtH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/720d6f8c6938ee748288a012e3212b26962a7960
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Zhong/drivers-usb-core-driver-check-return-value-of-usb_set_interface/20220909-124349
        git checkout 720d6f8c6938ee748288a012e3212b26962a7960
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from drivers/usb/core/driver.c:28:
   drivers/usb/core/driver.c: In function 'usb_resume_interface':
>> drivers/usb/core/driver.c:1337:45: error: incompatible type for argument 1 of '_dev_err'
    1337 |                                 dev_err(intf->dev, "usb_set_interface error %d\n",
         |                                         ~~~~^~~~~
         |                                             |
         |                                             struct device
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/usb/core/driver.c:1337:33: note: in expansion of macro 'dev_err'
    1337 |                                 dev_err(intf->dev, "usb_set_interface error %d\n",
         |                                 ^~~~~~~
   include/linux/dev_printk.h:50:36: note: expected 'const struct device *' but argument is of type 'struct device'
      50 | void _dev_err(const struct device *dev, const char *fmt, ...);
         |               ~~~~~~~~~~~~~~~~~~~~~^~~


vim +/_dev_err +1337 drivers/usb/core/driver.c

  1316	
  1317	static int usb_resume_interface(struct usb_device *udev,
  1318			struct usb_interface *intf, pm_message_t msg, int reset_resume)
  1319	{
  1320		struct usb_driver	*driver;
  1321		int			status = 0;
  1322	
  1323		if (udev->state == USB_STATE_NOTATTACHED)
  1324			goto done;
  1325	
  1326		/* Don't let autoresume interfere with unbinding */
  1327		if (intf->condition == USB_INTERFACE_UNBINDING)
  1328			goto done;
  1329	
  1330		/* Can't resume it if it doesn't have a driver. */
  1331		if (intf->condition == USB_INTERFACE_UNBOUND) {
  1332	
  1333			/* Carry out a deferred switch to altsetting 0 */
  1334			if (intf->needs_altsetting0 && !intf->dev.power.is_prepared) {
  1335				status = usb_set_interface(udev, intf->altsetting[0].desc.bInterfaceNumber, 0);
  1336				if (status < 0)
> 1337					dev_err(intf->dev, "usb_set_interface error %d\n",
  1338								status);
  1339				intf->needs_altsetting0 = 0;
  1340			}
  1341			goto done;
  1342		}
  1343	
  1344		/* Don't resume if the interface is marked for rebinding */
  1345		if (intf->needs_binding)
  1346			goto done;
  1347		driver = to_usb_driver(intf->dev.driver);
  1348	
  1349		if (reset_resume) {
  1350			if (driver->reset_resume) {
  1351				status = driver->reset_resume(intf);
  1352				if (status)
  1353					dev_err(&intf->dev, "%s error %d\n",
  1354							"reset_resume", status);
  1355			} else {
  1356				intf->needs_binding = 1;
  1357				dev_dbg(&intf->dev, "no reset_resume for driver %s?\n",
  1358						driver->name);
  1359			}
  1360		} else {
  1361			status = driver->resume(intf);
  1362			if (status)
  1363				dev_err(&intf->dev, "resume error %d\n", status);
  1364		}
  1365	
  1366	done:
  1367		dev_vdbg(&intf->dev, "%s: status %d\n", __func__, status);
  1368	
  1369		/* Later we will unbind the driver and/or reprobe, if necessary */
  1370		return status;
  1371	}
  1372	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
