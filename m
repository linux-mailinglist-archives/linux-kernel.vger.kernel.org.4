Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEDF6B180C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCIAqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 19:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCIAqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:46:10 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49517D57A;
        Wed,  8 Mar 2023 16:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678322768; x=1709858768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Veqpwt+6ZDvee7cMmaxNWBWzXfSU5O/iijF1ygu3kR0=;
  b=S5PY9Aj8qTkwiXe9Xn4ykRod2HqMrwWNc10XpR2MWZZvEEFjMeMP0nF/
   KfexE+99heijE4M5JXcLAPYZKwXFoiCJB0guzdIaroinzq7/MVY0fuBdC
   GvTF9rfNMzsjR9HG1C+0VvHt+kZA/ayWrGcVtcg4jxDt60XCMpzcHb59g
   MowOQu2lKPGxdns98ldg3TNV7m9rsiW+V13l/WNzuHivnuBTp5pYinnlO
   SDQJc+TPd43Um48T1DWR93RePlaU9Qgm23XhiywjVBt92byKWdRzonI9z
   JmE4mzK7USwyzA8D6s8gLYsNu43ZZgERP285ayD/ME2MZSF6cqkIM/jrI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="315976020"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="315976020"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 16:46:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="851323133"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="851323133"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2023 16:46:04 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pa4Q0-0002Wn-0z;
        Thu, 09 Mar 2023 00:46:04 +0000
Date:   Thu, 9 Mar 2023 08:45:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] power: max17040: get thermal data from adc if
 available
Message-ID: <202303090836.dpbjGxDu-lkp@intel.com>
References: <20230308084419.11934-5-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308084419.11934-5-clamor95@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Svyatoslav,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on krzk-dt/for-next linus/master v6.3-rc1 next-20230308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-power-supply-maxim-max17040-update-properties/20230308-164538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20230308084419.11934-5-clamor95%40gmail.com
patch subject: [PATCH v1 4/4] power: max17040: get thermal data from adc if available
config: csky-randconfig-r015-20230308 (https://download.01.org/0day-ci/archive/20230309/202303090836.dpbjGxDu-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7b9bbf6f2b910ef4ffab18022223573e9094f007
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Svyatoslav-Ryhel/dt-bindings-power-supply-maxim-max17040-update-properties/20230308-164538
        git checkout 7b9bbf6f2b910ef4ffab18022223573e9094f007
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303090836.dpbjGxDu-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/power/supply/max17040_battery.o: in function `max17040_get_property':
>> drivers/power/supply/max17040_battery.c:422: undefined reference to `iio_read_channel_raw'
   csky-linux-ld: drivers/power/supply/max17040_battery.o: in function `max17040_remove':
>> drivers/power/supply/max17040_battery.c:586: undefined reference to `iio_channel_release'
>> csky-linux-ld: drivers/power/supply/max17040_battery.c:587: undefined reference to `iio_read_channel_raw'
>> csky-linux-ld: drivers/power/supply/max17040_battery.c:587: undefined reference to `iio_channel_release'
   csky-linux-ld: drivers/power/supply/max17040_battery.o: in function `max17040_probe':
>> drivers/power/supply/max17040_battery.c:572: undefined reference to `iio_channel_get'
   csky-linux-ld: drivers/power/supply/max17040_battery.o: in function `max17040_work':
   drivers/power/supply/max17040_battery.c:297: undefined reference to `iio_channel_get'
   pahole: .tmp_vmlinux.btf: Invalid argument
   .btf.vmlinux.bin.o: file not recognized: file format not recognized


vim +422 drivers/power/supply/max17040_battery.c

   386	
   387	static int max17040_get_property(struct power_supply *psy,
   388				    enum power_supply_property psp,
   389				    union power_supply_propval *val)
   390	{
   391		struct max17040_chip *chip = power_supply_get_drvdata(psy);
   392	
   393		switch (psp) {
   394		case POWER_SUPPLY_PROP_ONLINE:
   395		case POWER_SUPPLY_PROP_PRESENT:
   396			val->intval = max17040_get_online(chip);
   397			break;
   398		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
   399			val->intval = max17040_get_vcell(chip);
   400			break;
   401		case POWER_SUPPLY_PROP_CAPACITY:
   402			val->intval = max17040_get_soc(chip);
   403			break;
   404		case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
   405			val->intval = chip->low_soc_alert;
   406			break;
   407	
   408		case POWER_SUPPLY_PROP_STATUS:
   409		case POWER_SUPPLY_PROP_HEALTH:
   410			power_supply_get_property_from_supplier(psy, psp, val);
   411			break;
   412		case POWER_SUPPLY_PROP_TECHNOLOGY:
   413			val->intval = chip->batt_info->technology;
   414			break;
   415		case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
   416			val->intval = chip->batt_info->energy_full_design_uwh;
   417			break;
   418		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
   419			val->intval = chip->batt_info->charge_full_design_uah;
   420			break;
   421		case POWER_SUPPLY_PROP_TEMP:
 > 422			iio_read_channel_raw(chip->channel_temp,
   423					     &val->intval);
   424			val->intval *= 10;
   425			break;
   426		case POWER_SUPPLY_PROP_TEMP_MIN:
   427			if (chip->batt_info->temp_min == INT_MIN)
   428				return -ENODATA;
   429	
   430			val->intval = chip->batt_info->temp_min * 10;
   431			break;
   432		case POWER_SUPPLY_PROP_TEMP_MAX:
   433			if (chip->batt_info->temp_max == INT_MAX)
   434				return -ENODATA;
   435	
   436			val->intval = chip->batt_info->temp_max * 10;
   437			break;
   438		default:
   439			return -EINVAL;
   440		}
   441		return 0;
   442	}
   443	
   444	static const struct regmap_config max17040_regmap = {
   445		.reg_bits	= 8,
   446		.reg_stride	= 2,
   447		.val_bits	= 16,
   448		.val_format_endian = REGMAP_ENDIAN_BIG,
   449	};
   450	
   451	static enum power_supply_property max17040_battery_props[] = {
   452		POWER_SUPPLY_PROP_ONLINE,
   453		POWER_SUPPLY_PROP_PRESENT,
   454		POWER_SUPPLY_PROP_VOLTAGE_NOW,
   455		POWER_SUPPLY_PROP_CAPACITY,
   456		POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
   457		POWER_SUPPLY_PROP_TECHNOLOGY,
   458		POWER_SUPPLY_PROP_STATUS,
   459		POWER_SUPPLY_PROP_HEALTH,
   460		POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
   461		POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
   462		POWER_SUPPLY_PROP_TEMP,
   463		POWER_SUPPLY_PROP_TEMP_MIN,
   464		POWER_SUPPLY_PROP_TEMP_MAX,
   465	};
   466	
   467	static const struct power_supply_desc max17040_battery_desc = {
   468		.name			= "battery",
   469		.type			= POWER_SUPPLY_TYPE_BATTERY,
   470		.get_property		= max17040_get_property,
   471		.set_property		= max17040_set_property,
   472		.property_is_writeable  = max17040_prop_writeable,
   473		.properties		= max17040_battery_props,
   474		.num_properties		= ARRAY_SIZE(max17040_battery_props),
   475	};
   476	
   477	static int max17040_probe(struct i2c_client *client)
   478	{
   479		const struct i2c_device_id *id = i2c_client_get_device_id(client);
   480		struct i2c_adapter *adapter = client->adapter;
   481		struct power_supply_config psy_cfg = {};
   482		struct max17040_chip *chip;
   483		enum chip_id chip_id;
   484		bool enable_irq = false;
   485		int ret;
   486	
   487		if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
   488			return -EIO;
   489	
   490		chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
   491		if (!chip)
   492			return -ENOMEM;
   493	
   494		chip->client = client;
   495		chip->regmap = devm_regmap_init_i2c(client, &max17040_regmap);
   496		if (IS_ERR(chip->regmap))
   497			return PTR_ERR(chip->regmap);
   498		chip_id = (enum chip_id) id->driver_data;
   499		if (client->dev.of_node) {
   500			ret = max17040_get_of_data(chip);
   501			if (ret)
   502				return ret;
   503			chip_id = (uintptr_t)of_device_get_match_data(&client->dev);
   504		}
   505		chip->data = max17040_family[chip_id];
   506	
   507		i2c_set_clientdata(client, chip);
   508		psy_cfg.drv_data = chip;
   509	
   510		chip->battery = devm_power_supply_register(&client->dev,
   511					&max17040_battery_desc, &psy_cfg);
   512		if (IS_ERR(chip->battery)) {
   513			dev_err(&client->dev, "failed: power supply register\n");
   514			return PTR_ERR(chip->battery);
   515		}
   516	
   517		if (client->dev.of_node) {
   518			if (power_supply_get_battery_info(chip->battery, &chip->batt_info))
   519				dev_warn(&client->dev,
   520					 "No monitored battery, some properties will be missing\n");
   521		}
   522	
   523		ret = max17040_get_version(chip);
   524		if (ret < 0)
   525			return ret;
   526		dev_dbg(&chip->client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", ret);
   527	
   528		if (chip_id == ID_MAX17040 || chip_id == ID_MAX17041)
   529			max17040_reset(chip);
   530	
   531		max17040_set_rcomp(chip, chip->rcomp);
   532	
   533		/* check interrupt */
   534		if (client->irq && chip->data.has_low_soc_alert) {
   535			ret = max17040_set_low_soc_alert(chip, chip->low_soc_alert);
   536			if (ret) {
   537				dev_err(&client->dev,
   538					"Failed to set low SOC alert: err %d\n", ret);
   539				return ret;
   540			}
   541	
   542			enable_irq = true;
   543		}
   544	
   545		if (client->irq && chip->data.has_soc_alert) {
   546			ret = max17040_set_soc_alert(chip, 1);
   547			if (ret) {
   548				dev_err(&client->dev,
   549					"Failed to set SOC alert: err %d\n", ret);
   550				return ret;
   551			}
   552			enable_irq = true;
   553		} else {
   554			/* soc alerts negate the need for polling */
   555			INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
   556			ret = devm_add_action(&client->dev, max17040_stop_work, chip);
   557			if (ret)
   558				return ret;
   559			max17040_queue_work(chip);
   560		}
   561	
   562		if (enable_irq) {
   563			ret = max17040_enable_alert_irq(chip);
   564			if (ret) {
   565				client->irq = 0;
   566				dev_warn(&client->dev,
   567					 "Failed to get IRQ err %d\n", ret);
   568			}
   569		}
   570	
   571		if (of_property_read_bool(client->dev.of_node, "io-channels")) {
 > 572			chip->channel_temp = iio_channel_get(&client->dev, "temp");
   573			if (IS_ERR(chip->channel_temp))
   574				return dev_err_probe(&client->dev, PTR_ERR(chip->channel_temp),
   575						     "failed to get temp\n");
   576		};
   577	
   578		return 0;
   579	}
   580	
   581	static void max17040_remove(struct i2c_client *client)
   582	{
   583		struct max17040_chip *chip = i2c_get_clientdata(client);
   584	
   585		if (chip->channel_temp)
 > 586			iio_channel_release(chip->channel_temp);
 > 587	}
   588	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
