Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454256B98BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCNPPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjCNPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:15:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EACA42E5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678806881; x=1710342881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K6Vdzp8KjBCuYcLJXxHVlkQzUyS+zE/ruzxJSurp4Mc=;
  b=f4T4dzh8LUkyEVJgas63A3peAqAVYJvtPOwwImRhPOnPFhiqtALMUY+1
   PH1CWco0HtkCzz63WmN26DThoubMELTub88b2PxI+fTsdSMtcH3Tzy0zB
   1NgtnnWKMuSW9H1P3Z0A78tIJarqk5Or4Wc4ixlIFOva2IgzHtzHfq05M
   oeFivxQN05hYPKx6CQV0rIVWCQEOVTeEVfqFJbeaZGUarcc3WMemHY4PK
   rTRvGGzWbK25u15LswWWVq1KO020m9MmyePnMF/nS3bZHLbEjFHLpHxKy
   eF4NkM+tQAFi64KMTaYYWfW/k9RyRGNGbJVw0O2DzHcxmOP15TvAPx4ji
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="337478293"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="337478293"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="822410486"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="822410486"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.140.184])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:13:55 -0700
Date:   Tue, 14 Mar 2023 08:13:53 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBCPMVFvjodeUbGF@aschofie-mobl2>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <202303141159.6wN9HNP9-lkp@intel.com>
 <ZBB/30ZBW9EU1QfK@khadija-virtual-machine>
 <20230314144207.GA4106922@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314144207.GA4106922@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 07:42:07AM -0700, Nathan Chancellor wrote:
> Hi Khadija,
> 
> On Tue, Mar 14, 2023 at 07:08:31PM +0500, Khadija Kamran wrote:
> > On Tue, Mar 14, 2023 at 11:45:51AM +0800, kernel test robot wrote:
> > > Hi Khadija,
> > > 
> > > Thank you for the patch! Perhaps something to improve:
> > > 
> > > [auto build test WARNING on staging/staging-testing]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Khadija-Kamran/staging-axis-fifo-initialize-timeouts-in-probe-only/20230314-020827
> > > patch link:    https://lore.kernel.org/r/ZA9mThZ7NyRrQAMX%40khadija-virtual-machine
> > > patch subject: [PATCH] staging: axis-fifo: initialize timeouts in probe only
> > > config: arm64-randconfig-r012-20230313 (https://download.01.org/0day-ci/archive/20230314/202303141159.6wN9HNP9-lkp@intel.com/config)
> > > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install arm64 cross compiling tool for clang build
> > >         # apt-get install binutils-aarch64-linux-gnu
> > >         # https://github.com/intel-lab-lkp/linux/commit/9d186f6c9f9bf467b48da3e28b0e9aa31fc3faf3
> > >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> > >         git fetch --no-tags linux-review Khadija-Kamran/staging-axis-fifo-initialize-timeouts-in-probe-only/20230314-020827
> > >         git checkout 9d186f6c9f9bf467b48da3e28b0e9aa31fc3faf3
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/staging/axis-fifo/
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Link: https://lore.kernel.org/oe-kbuild-all/202303141159.6wN9HNP9-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > >> drivers/staging/axis-fifo/axis-fifo.c:817:18: warning: implicit conversion from 'long' to 'int' changes value from 9223372036854775807 to -1 [-Wconstant-conversion]
> > >                    read_timeout = MAX_SCHEDULE_TIMEOUT;
> > >                                 ~ ^~~~~~~~~~~~~~~~~~~~
> > >    include/linux/sched.h:296:31: note: expanded from macro 'MAX_SCHEDULE_TIMEOUT'
> > >    #define MAX_SCHEDULE_TIMEOUT            LONG_MAX
> > >                                            ^~~~~~~~
> > >    include/vdso/limits.h:11:19: note: expanded from macro 'LONG_MAX'
> > >    #define LONG_MAX        ((long)(~0UL >> 1))
> > >                             ^~~~~~~~~~~~~~~~~
> > >    drivers/staging/axis-fifo/axis-fifo.c:822:19: warning: implicit conversion from 'long' to 'int' changes value from 9223372036854775807 to -1 [-Wconstant-conversion]
> > >                    write_timeout = MAX_SCHEDULE_TIMEOUT;
> > >                                  ~ ^~~~~~~~~~~~~~~~~~~~
> > >    include/linux/sched.h:296:31: note: expanded from macro 'MAX_SCHEDULE_TIMEOUT'
> > >    #define MAX_SCHEDULE_TIMEOUT            LONG_MAX
> > >                                            ^~~~~~~~
> > >    include/vdso/limits.h:11:19: note: expanded from macro 'LONG_MAX'
> > >    #define LONG_MAX        ((long)(~0UL >> 1))
> > >                             ^~~~~~~~~~~~~~~~~
> > >    2 warnings generated.
> > >
> > 
> > Hi everyone!
> > Kindly let me know if I should look into these warnings.
> > Thank you!
> 
> You should always avoid introducing new warnings whenever possible. In
> this case, it appears that read_timeout and write_timeout should be
> changed from 'int' to 'long' to account for the fact that
> MAX_SCHEDULE_TIMEOUT is being assigned to it directly now, versus being
> passed as a parameter to wait_event_interruptible_timeout(), which
> assigned it to 'long' anyways.
> 
> If you have any other questions or need further help, let me know :)
> 
> Cheers,
> Nathan

Hi Khadaji,

Echoing Nathan's feedback - yes, you need to correct these.

Do you see these warnings when you compiled?  If yes, then your path to
fixing them is easier. Make sure it recompiles with no warnings.

If you don't see these warnings, then you need to follow the steps to
reproduce in the lkp email. You have to be able to 'see the warning'
make a change and 'see it go away'.

Alison

> 
> > > vim +817 drivers/staging/axis-fifo/axis-fifo.c
> > > 
> > >    805	
> > >    806	static int axis_fifo_probe(struct platform_device *pdev)
> > >    807	{
> > >    808		struct resource *r_mem; /* IO mem resources */
> > >    809		struct device *dev = &pdev->dev; /* OS device (from device tree) */
> > >    810		struct axis_fifo *fifo = NULL;
> > >    811		char *device_name;
> > >    812		int rc = 0; /* error return value */
> > >    813	
> > >    814		if (read_timeout >= 0)
> > >    815			read_timeout = msecs_to_jiffies(read_timeout);
> > >    816		else
> > >  > 817			read_timeout = MAX_SCHEDULE_TIMEOUT;
> > >    818	
> > >    819		if (write_timeout >= 0)
> > >    820			write_timeout = msecs_to_jiffies(write_timeout);
> > >    821		else
> > >    822			write_timeout = MAX_SCHEDULE_TIMEOUT;
> > >    823	
> > >    824		/* ----------------------------
> > >    825		 *     init wrapper device
> > >    826		 * ----------------------------
> > >    827		 */
> > >    828	
> > >    829		device_name = devm_kzalloc(dev, 32, GFP_KERNEL);
> > >    830		if (!device_name)
> > >    831			return -ENOMEM;
> > >    832	
> > >    833		/* allocate device wrapper memory */
> > >    834		fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
> > >    835		if (!fifo)
> > >    836			return -ENOMEM;
> > >    837	
> > >    838		dev_set_drvdata(dev, fifo);
> > >    839		fifo->dt_device = dev;
> > >    840	
> > >    841		init_waitqueue_head(&fifo->read_queue);
> > >    842		init_waitqueue_head(&fifo->write_queue);
> > >    843	
> > >    844		mutex_init(&fifo->read_lock);
> > >    845		mutex_init(&fifo->write_lock);
> > >    846	
> > >    847		/* ----------------------------
> > >    848		 *   init device memory space
> > >    849		 * ----------------------------
> > >    850		 */
> > >    851	
> > >    852		/* get iospace for the device */
> > >    853		r_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >    854		if (!r_mem) {
> > >    855			dev_err(fifo->dt_device, "invalid address\n");
> > >    856			rc = -ENODEV;
> > >    857			goto err_initial;
> > >    858		}
> > >    859	
> > >    860		/* request physical memory */
> > >    861		fifo->base_addr = devm_ioremap_resource(fifo->dt_device, r_mem);
> > >    862		if (IS_ERR(fifo->base_addr)) {
> > >    863			rc = PTR_ERR(fifo->base_addr);
> > >    864			goto err_initial;
> > >    865		}
> > >    866	
> > >    867		dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
> > >    868	
> > >    869		/* create unique device name */
> > >    870		snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
> > >    871		dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
> > >    872	
> > >    873		/* ----------------------------
> > >    874		 *          init IP
> > >    875		 * ----------------------------
> > >    876		 */
> > >    877	
> > >    878		rc = axis_fifo_parse_dt(fifo);
> > >    879		if (rc)
> > >    880			goto err_initial;
> > >    881	
> > >    882		reset_ip_core(fifo);
> > >    883	
> > >    884		/* ----------------------------
> > >    885		 *    init device interrupts
> > >    886		 * ----------------------------
> > >    887		 */
> > >    888	
> > >    889		/* get IRQ resource */
> > >    890		rc = platform_get_irq(pdev, 0);
> > >    891		if (rc < 0)
> > >    892			goto err_initial;
> > >    893	
> > >    894		/* request IRQ */
> > >    895		fifo->irq = rc;
> > >    896		rc = devm_request_irq(fifo->dt_device, fifo->irq, &axis_fifo_irq, 0,
> > >    897				      DRIVER_NAME, fifo);
> > >    898		if (rc) {
> > >    899			dev_err(fifo->dt_device, "couldn't allocate interrupt %i\n",
> > >    900				fifo->irq);
> > >    901			goto err_initial;
> > >    902		}
> > >    903	
> > >    904		/* ----------------------------
> > >    905		 *      init char device
> > >    906		 * ----------------------------
> > >    907		 */
> > >    908	
> > >    909		/* create character device */
> > >    910		fifo->miscdev.fops = &fops;
> > >    911		fifo->miscdev.minor = MISC_DYNAMIC_MINOR;
> > >    912		fifo->miscdev.name = device_name;
> > >    913		fifo->miscdev.groups = axis_fifo_attrs_groups;
> > >    914		fifo->miscdev.parent = dev;
> > >    915		rc = misc_register(&fifo->miscdev);
> > >    916		if (rc < 0)
> > >    917			goto err_initial;
> > >    918	
> > >    919		dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%pa, irq=%i\n",
> > >    920			 &r_mem->start, &fifo->base_addr, fifo->irq);
> > >    921	
> > >    922		return 0;
> > >    923	
> > >    924	err_initial:
> > >    925		dev_set_drvdata(dev, NULL);
> > >    926		return rc;
> > >    927	}
> > >    928	
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests
> > 
> 
