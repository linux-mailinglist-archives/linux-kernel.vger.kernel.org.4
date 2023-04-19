Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3E6E79F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjDSMuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjDSMuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:50:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B17686;
        Wed, 19 Apr 2023 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681908599; x=1713444599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qLuT6kv58KDo/hNk40H1qLsx89RYFTdN6WGG7LR1UZc=;
  b=J1MFi/V2CO+Pi0u0aWo0+xkRk2b8r885jlWSAxEBgRy7IZOHdupVfb8B
   GMdKgdHuo/Xysyf2C+4oJfoy5w2pj/bxFAgHx3qTD2DlzW3WwwXna4GBA
   A+TC1GPs5rBIFe+a4anMRhDkmjlkUVouiTr7ESf+eOigjWyGyS2000cFX
   xMT8/fOj0pcBQZ+kQQNkiLkxbggG7t7sUCzKqgKYfO0dpQJlX2OtNOKtE
   6WGnlTyF2Y+sM785H/29fDWNsiiuQcLQ3ExWxN35PM8SgILWe1wv/RQ37
   fW+AdGa9bmc5QO6ONHOK8acf5+eR90aPTLizzhJDNdaj3JreWl2vjm9ba
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325771856"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325771856"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 05:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="684972718"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="684972718"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 Apr 2023 05:49:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pp7Fu-000et9-1v;
        Wed, 19 Apr 2023 12:49:50 +0000
Date:   Wed, 19 Apr 2023 20:48:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        jdelvare@suse.com, linux@roeck-us.net, manio@skyboo.net
Cc:     oe-kbuild-all@lists.linux.dev, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v2 2/2] hwmon: (adt7475) Convert to use device_property
 APIs
Message-ID: <202304192005.lJVSjooB-lkp@intel.com>
References: <20230418233656.869055-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418233656.869055-3-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.3-rc7 next-20230418]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Packham/hwmon-adt7475-Use-device_property-APIs-when-configuring-polarity/20230419-074117
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230418233656.869055-3-chris.packham%40alliedtelesis.co.nz
patch subject: [PATCH v2 2/2] hwmon: (adt7475) Convert to use device_property APIs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230419/202304192005.lJVSjooB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/59836340c66130951595e2adebf284eca3063ccd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chris-Packham/hwmon-adt7475-Use-device_property-APIs-when-configuring-polarity/20230419-074117
        git checkout 59836340c66130951595e2adebf284eca3063ccd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304192005.lJVSjooB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/adt7475.c: In function 'load_config3':
>> drivers/hwmon/adt7475.c:1471:43: warning: passing argument 1 of 'device_property_read_string' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1471 |         ret = device_property_read_string(&client->dev, propname, &function);
         |                                           ^~~~~~~~~~~~
   In file included from include/linux/of.h:22,
                    from include/linux/of_device.h:9,
                    from drivers/hwmon/adt7475.c:13:
   include/linux/property.h:54:48: note: expected 'struct device *' but argument is of type 'const struct device *'
      54 | int device_property_read_string(struct device *dev, const char *propname,
         |                                 ~~~~~~~~~~~~~~~^~~
   drivers/hwmon/adt7475.c: In function 'load_config4':
   drivers/hwmon/adt7475.c:1497:43: warning: passing argument 1 of 'device_property_read_string' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1497 |         ret = device_property_read_string(&client->dev, propname, &function);
         |                                           ^~~~~~~~~~~~
   include/linux/property.h:54:48: note: expected 'struct device *' but argument is of type 'const struct device *'
      54 | int device_property_read_string(struct device *dev, const char *propname,
         |                                 ~~~~~~~~~~~~~~~^~~
   drivers/hwmon/adt7475.c: In function 'set_property_bit':
>> drivers/hwmon/adt7475.c:1559:44: warning: passing argument 1 of 'device_property_read_u32' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1559 |         int ret = device_property_read_u32(&client->dev, property,
         |                                            ^~~~~~~~~~~~
   include/linux/property.h:164:59: note: expected 'struct device *' but argument is of type 'const struct device *'
     164 | static inline int device_property_read_u32(struct device *dev,
         |                                            ~~~~~~~~~~~~~~~^~~


vim +1471 drivers/hwmon/adt7475.c

  1464	
  1465	static int load_config3(const struct i2c_client *client, const char *propname)
  1466	{
  1467		const char *function;
  1468		u8 config3;
  1469		int ret;
  1470	
> 1471		ret = device_property_read_string(&client->dev, propname, &function);
  1472		if (!ret) {
  1473			ret = adt7475_read(REG_CONFIG3);
  1474			if (ret < 0)
  1475				return ret;
  1476	
  1477			config3 = ret & ~CONFIG3_SMBALERT;
  1478			if (!strcmp("pwm2", function))
  1479				;
  1480			else if (!strcmp("smbalert#", function))
  1481				config3 |= CONFIG3_SMBALERT;
  1482			else
  1483				return -EINVAL;
  1484	
  1485			return i2c_smbus_write_byte_data(client, REG_CONFIG3, config3);
  1486		}
  1487	
  1488		return 0;
  1489	}
  1490	
  1491	static int load_config4(const struct i2c_client *client, const char *propname)
  1492	{
  1493		const char *function;
  1494		u8 config4;
  1495		int ret;
  1496	
  1497		ret = device_property_read_string(&client->dev, propname, &function);
  1498		if (!ret) {
  1499			ret = adt7475_read(REG_CONFIG4);
  1500			if (ret < 0)
  1501				return ret;
  1502	
  1503			config4 = ret & ~CONFIG4_PINFUNC;
  1504	
  1505			if (!strcmp("tach4", function))
  1506				;
  1507			else if (!strcmp("therm#", function))
  1508				config4 |= CONFIG4_THERM;
  1509			else if (!strcmp("smbalert#", function))
  1510				config4 |= CONFIG4_SMBALERT;
  1511			else if (!strcmp("gpio", function))
  1512				config4 |= CONFIG4_PINFUNC;
  1513			else
  1514				return -EINVAL;
  1515	
  1516			return i2c_smbus_write_byte_data(client, REG_CONFIG4, config4);
  1517		}
  1518	
  1519		return 0;
  1520	}
  1521	
  1522	static int load_config(const struct i2c_client *client, enum chips chip)
  1523	{
  1524		int err;
  1525		const char *prop1, *prop2;
  1526	
  1527		switch (chip) {
  1528		case adt7473:
  1529		case adt7475:
  1530			prop1 = "adi,pin5-function";
  1531			prop2 = "adi,pin9-function";
  1532			break;
  1533		case adt7476:
  1534		case adt7490:
  1535			prop1 = "adi,pin10-function";
  1536			prop2 = "adi,pin14-function";
  1537			break;
  1538		}
  1539	
  1540		err = load_config3(client, prop1);
  1541		if (err) {
  1542			dev_err(&client->dev, "failed to configure %s\n", prop1);
  1543			return err;
  1544		}
  1545	
  1546		err = load_config4(client, prop2);
  1547		if (err) {
  1548			dev_err(&client->dev, "failed to configure %s\n", prop2);
  1549			return err;
  1550		}
  1551	
  1552		return 0;
  1553	}
  1554	
  1555	static int set_property_bit(const struct i2c_client *client, char *property,
  1556				    u8 *config, u8 bit_index)
  1557	{
  1558		u32 prop_value = 0;
> 1559		int ret = device_property_read_u32(&client->dev, property,
  1560						   &prop_value);
  1561	
  1562		if (!ret) {
  1563			if (prop_value)
  1564				*config |= (1 << bit_index);
  1565			else
  1566				*config &= ~(1 << bit_index);
  1567		}
  1568	
  1569		return ret;
  1570	}
  1571	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
