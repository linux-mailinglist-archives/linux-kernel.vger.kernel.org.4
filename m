Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A34720B28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbjFBVrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbjFBVrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:47:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08681A5;
        Fri,  2 Jun 2023 14:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685742428; x=1717278428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y0Ioa4ug2F0tmnP21rKqZ+B3hDBJzy5cKKM2DR6nBWQ=;
  b=mPAQb9vnOUl0u7uhwsLLkHBC3YtuVTrLZO1GejVnQtA8teRdQ5FGnRgw
   ELlQS2Ejr5tG1qB4p3v8rpy/fDdJ5sqJMIpf5iyac8xy45lkAmZP/BhmR
   tZntq19pu1A79FC2E5wmh/ISHjmbsIAkYjE6rfb6+wRsLnNfTG/CnaJK2
   vbSlEaTSn0T8Sc7R+3hhjDt6eLIdROQSeybi97SBVabBzl5BRcQrOU43H
   W7unLFM2EAIlaPHAeWYugCLXhIG0qC55vy03sr5apog7p7y/X/rIpJCV0
   bYcUq2x8PBxegPIYuyi9BlrmHhdlIqjndzDVCgVFBopjJnrlRe2U6Zb2Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="345560148"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="345560148"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 14:47:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="954635144"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="954635144"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jun 2023 14:47:03 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5Cbv-000109-0f;
        Fri, 02 Jun 2023 21:47:03 +0000
Date:   Sat, 3 Jun 2023 05:46:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO
 configuration
Message-ID: <202306030535.SjzsDJSD-lkp@intel.com>
References: <20230602152626.284324-6-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602152626.284324-6-hugo@hugovil.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9e87b63ed37e202c77aa17d4112da6ae0c7c097c]

url:    https://github.com/intel-lab-lkp/linux/commits/Hugo-Villeneuve/serial-sc16is7xx-fix-broken-port-0-uart-init/20230602-232811
base:   9e87b63ed37e202c77aa17d4112da6ae0c7c097c
patch link:    https://lore.kernel.org/r/20230602152626.284324-6-hugo%40hugovil.com
patch subject: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO configuration
config: microblaze-randconfig-s052-20230531 (https://download.01.org/0day-ci/archive/20230603/202306030535.SjzsDJSD-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/24626643fe711f447b04a2421ef68e8e8cce86d1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hugo-Villeneuve/serial-sc16is7xx-fix-broken-port-0-uart-init/20230602-232811
        git checkout 24626643fe711f447b04a2421ef68e8e8cce86d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306030535.SjzsDJSD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/sc16is7xx.c: In function 'sc16is7xx_probe':
>> drivers/tty/serial/sc16is7xx.c:1450:12: warning: variable 'mctrl_mask' set but not used [-Wunused-but-set-variable]
    1450 |         u8 mctrl_mask;
         |            ^~~~~~~~~~


vim +/mctrl_mask +1450 drivers/tty/serial/sc16is7xx.c

  1443	
  1444	static int sc16is7xx_probe(struct device *dev,
  1445				   const struct sc16is7xx_devtype *devtype,
  1446				   struct regmap *regmap, int irq)
  1447	{
  1448		unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
  1449		unsigned int val;
> 1450		u8 mctrl_mask;
  1451		u32 uartclk = 0;
  1452		int i, ret;
  1453		struct sc16is7xx_port *s;
  1454	
  1455		if (IS_ERR(regmap))
  1456			return PTR_ERR(regmap);
  1457	
  1458		/*
  1459		 * This device does not have an identification register that would
  1460		 * tell us if we are really connected to the correct device.
  1461		 * The best we can do is to check if communication is at all possible.
  1462		 */
  1463		ret = regmap_read(regmap,
  1464				  SC16IS7XX_LSR_REG << SC16IS7XX_REG_SHIFT, &val);
  1465		if (ret < 0)
  1466			return -EPROBE_DEFER;
  1467	
  1468		/* Alloc port structure */
  1469		s = devm_kzalloc(dev, struct_size(s, p, devtype->nr_uart), GFP_KERNEL);
  1470		if (!s) {
  1471			dev_err(dev, "Error allocating port structure\n");
  1472			return -ENOMEM;
  1473		}
  1474	
  1475		/* Always ask for fixed clock rate from a property. */
  1476		device_property_read_u32(dev, "clock-frequency", &uartclk);
  1477	
  1478		s->clk = devm_clk_get_optional(dev, NULL);
  1479		if (IS_ERR(s->clk))
  1480			return PTR_ERR(s->clk);
  1481	
  1482		ret = clk_prepare_enable(s->clk);
  1483		if (ret)
  1484			return ret;
  1485	
  1486		freq = clk_get_rate(s->clk);
  1487		if (freq == 0) {
  1488			if (uartclk)
  1489				freq = uartclk;
  1490			if (pfreq)
  1491				freq = *pfreq;
  1492			if (freq)
  1493				dev_dbg(dev, "Clock frequency: %luHz\n", freq);
  1494			else
  1495				return -EINVAL;
  1496		}
  1497	
  1498		s->regmap = regmap;
  1499		s->devtype = devtype;
  1500		dev_set_drvdata(dev, s);
  1501		mutex_init(&s->efr_lock);
  1502	
  1503		kthread_init_worker(&s->kworker);
  1504		s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
  1505					      "sc16is7xx");
  1506		if (IS_ERR(s->kworker_task)) {
  1507			ret = PTR_ERR(s->kworker_task);
  1508			goto out_clk;
  1509		}
  1510		sched_set_fifo(s->kworker_task);
  1511	
  1512		/* reset device, purging any pending irq / data */
  1513		regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
  1514				SC16IS7XX_IOCONTROL_SRESET_BIT);
  1515	
  1516		for (i = 0; i < devtype->nr_uart; ++i) {
  1517			s->p[i].line		= i;
  1518			/* Initialize port data */
  1519			s->p[i].port.dev	= dev;
  1520			s->p[i].port.irq	= irq;
  1521			s->p[i].port.type	= PORT_SC16IS7XX;
  1522			s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
  1523			s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
  1524			s->p[i].port.iobase	= i;
  1525			s->p[i].port.membase	= (void __iomem *)~0;
  1526			s->p[i].port.iotype	= UPIO_PORT;
  1527			s->p[i].port.uartclk	= freq;
  1528			s->p[i].port.rs485_config = sc16is7xx_config_rs485;
  1529			s->p[i].port.rs485_supported = sc16is7xx_rs485_supported;
  1530			s->p[i].port.ops	= &sc16is7xx_ops;
  1531			s->p[i].old_mctrl	= 0;
  1532			s->p[i].port.line	= sc16is7xx_alloc_line();
  1533	
  1534			if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
  1535				ret = -ENOMEM;
  1536				goto out_ports;
  1537			}
  1538	
  1539			/* Disable all interrupts */
  1540			sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_IER_REG, 0);
  1541			/* Disable TX/RX */
  1542			sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_REG,
  1543					     SC16IS7XX_EFCR_RXDISABLE_BIT |
  1544					     SC16IS7XX_EFCR_TXDISABLE_BIT);
  1545	
  1546			/* Initialize kthread work structs */
  1547			kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
  1548			kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
  1549			kthread_init_delayed_work(&s->p[i].ms_work, sc16is7xx_ms_proc);
  1550			/* Register port */
  1551			uart_add_one_port(&sc16is7xx_uart, &s->p[i].port);
  1552	
  1553			/* Enable EFR */
  1554			sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
  1555					     SC16IS7XX_LCR_CONF_MODE_B);
  1556	
  1557			regcache_cache_bypass(s->regmap, true);
  1558	
  1559			/* Enable write access to enhanced features */
  1560			sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFR_REG,
  1561					     SC16IS7XX_EFR_ENABLE_BIT);
  1562	
  1563			regcache_cache_bypass(s->regmap, false);
  1564	
  1565			/* Restore access to general registers */
  1566			sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG, 0x00);
  1567	
  1568			/* Go to suspend mode */
  1569			sc16is7xx_power(&s->p[i].port, 0);
  1570		}
  1571	
  1572		if (dev->of_node) {
  1573			struct property *prop;
  1574			const __be32 *p;
  1575			u32 u;
  1576	
  1577			of_property_for_each_u32(dev->of_node, "irda-mode-ports",
  1578						 prop, p, u)
  1579				if (u < devtype->nr_uart)
  1580					s->p[u].irda_mode = true;
  1581		}
  1582	
  1583		mctrl_mask = sc16is7xx_setup_mctrl_ports(dev);
  1584	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
