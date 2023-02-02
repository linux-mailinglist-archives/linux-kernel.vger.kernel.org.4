Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC649688859
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjBBUlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjBBUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:40:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA0721CB;
        Thu,  2 Feb 2023 12:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675370455; x=1706906455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dca+SSdV2iPqpOOIalDHL2cowscJyYtLtR0+FpBaxhg=;
  b=EtZzn1fIfcevyVOJY85wGFJg3xYox71VhIfBnKQBz12YpwHTFoR0vAx9
   NXW9it+hJDNw5MZL28/lv62iACzdWNsRlIoUl7O3VRajfwmA7fqGosR+R
   +N7hw8QToqgwP41BicsZRRs1gWweiTDQHeg/xSNAc5KfaUzMHayRv97d4
   2KltSm0IaCn5X5GIJlw6sq1BTvN71qUIPTA4gEVz5P2DE5+JGKjuhid9+
   Z1jIjeb3eFWvYm5jjDdNjbnaVSBVgS1xjzF9zg317vn3DMEqVz3QbdYIk
   QmDBamGDW36Xjg5tYekvQhPdvhpbioBE/8Mf8wm0yh02rFkGVp41NI1QG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="414772484"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="414772484"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 12:40:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839335709"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="839335709"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2023 12:40:49 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNgO1-0006pp-0V;
        Thu, 02 Feb 2023 20:40:49 +0000
Date:   Fri, 3 Feb 2023 04:39:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        martin.petersen@oracle.com, beanhuo@micron.com, arnd@arndb.de,
        avri.altman@wdc.com, iwona.winiarska@intel.com,
        fmdefrancesco@gmail.com, dipenp@nvidia.com, ogabbay@kernel.org,
        bvanassche@acm.org, mathieu.poirier@linaro.org,
        yangyicong@hisilicon.com, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Subject: Re: [PATCHv2 4/4] wiegand: add Wiegand GPIO bit-banged controller
 driver
Message-ID: <202302030403.qE5eN2x8-lkp@intel.com>
References: <20230202143305.21789-5-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202143305.21789-5-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.2-rc6 next-20230202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230202-223510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230202143305.21789-5-m.zatovic1%40gmail.com
patch subject: [PATCHv2 4/4] wiegand: add Wiegand GPIO bit-banged controller driver
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230203/202302030403.qE5eN2x8-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d2c4bf0953d186dba735c1f95b5c25ff5523872c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230202-223510
        git checkout d2c4bf0953d186dba735c1f95b5c25ff5523872c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/wiegand/wiegand-gpio.c:51:9: warning: no previous prototype for 'payload_len_show' [-Wmissing-prototypes]
      51 | ssize_t payload_len_show(struct device *dev, struct device_attribute *attr,
         |         ^~~~~~~~~~~~~~~~
>> drivers/wiegand/wiegand-gpio.c:61:9: warning: no previous prototype for 'payload_len_store' [-Wmissing-prototypes]
      61 | ssize_t payload_len_store(struct device *dev, struct device_attribute *attr,
         |         ^~~~~~~~~~~~~~~~~
>> drivers/wiegand/wiegand-gpio.c:79:6: warning: no previous prototype for 'wiegand_gpio_send_bit' [-Wmissing-prototypes]
      79 | void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio, bool value,
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/wiegand/wiegand-gpio.c:198:5: warning: no previous prototype for 'wiegand_gpio_transfer_message' [-Wmissing-prototypes]
     198 | int wiegand_gpio_transfer_message(struct wiegand_device *dev, u8 *message,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/payload_len_show +51 drivers/wiegand/wiegand-gpio.c

    47	
    48	/*
    49	 * Attribute file for setting payload length of Wiegand messages.
    50	 */
  > 51	ssize_t payload_len_show(struct device *dev, struct device_attribute *attr,
    52									 char *buf)
    53	{
    54		struct wiegand_gpio *wiegand_gpio = (struct wiegand_gpio *)
    55								dev->driver_data;
    56		struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
    57	
    58		return sysfs_emit(buf, "%u\n", ctlr->payload_len);
    59	}
    60	
  > 61	ssize_t payload_len_store(struct device *dev, struct device_attribute *attr,
    62							const char *buf, size_t count)
    63	{
    64		struct wiegand_gpio *wiegand_gpio = (struct wiegand_gpio *)
    65								dev->driver_data;
    66		struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
    67	
    68		return store_ulong(&(ctlr->payload_len), buf, count,
    69							WIEGAND_MAX_PAYLEN_BYTES * 8);
    70	}
    71	DEVICE_ATTR_RW(payload_len);
    72	
    73	/*
    74	 * To send a bit of value 1 following the wiegand protocol, one must set
    75	 * the wiegand_data_hi to low for the duration of pulse. Similarly to send
    76	 * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
    77	 * This way the two lines are never low at the same time.
    78	 */
  > 79	void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio, bool value,
    80									bool last)
    81	{
    82		u32 pulse_len = wiegand_gpio->ctlr->pulse_len;
    83		u32 interval_len = wiegand_gpio->ctlr->interval_len;
    84		u32 frame_gap = wiegand_gpio->ctlr->frame_gap;
    85		struct gpio_desc *gpio = value ? wiegand_gpio->gpio_data_hi
    86						: wiegand_gpio->gpio_data_lo;
    87	
    88		gpiod_set_value_cansleep(gpio, 0);
    89		udelay(pulse_len);
    90		gpiod_set_value_cansleep(gpio, 1);
    91	
    92		if (last)
    93			udelay(frame_gap - pulse_len);
    94		else
    95			udelay(interval_len - pulse_len);
    96	}
    97	
    98	/* This function is used for writing from file in dev directory */
    99	static int wiegand_gpio_write_by_bits(struct wiegand_gpio *wiegand_gpio,
   100									u16 bitlen)
   101	{
   102		size_t i;
   103		bool bit_value, is_last_bit;
   104	
   105		for (i = 0; i < bitlen; i++) {
   106			bit_value = ((wiegand_gpio->data[i / 8] >> (7 - (i % 8)))
   107										& 0x01);
   108			is_last_bit = (i + 1) == bitlen;
   109			wiegand_gpio_send_bit(wiegand_gpio, bit_value, is_last_bit);
   110		}
   111	
   112		return 0;
   113	}
   114	
   115	static ssize_t wiegand_gpio_get_user_data(struct wiegand_gpio *wiegand_gpio,
   116						char __user const *buf, size_t len)
   117	{
   118		size_t rc;
   119	
   120		if (len > WIEGAND_MAX_PAYLEN_BYTES)
   121			return -EBADMSG;
   122	
   123		rc = copy_from_user(&wiegand_gpio->data[0], buf,
   124							WIEGAND_MAX_PAYLEN_BYTES);
   125		if (rc < 0)
   126			return rc;
   127	
   128		return len;
   129	}
   130	
   131	static int wiegand_gpio_frelease(struct inode *ino, struct file *filp)
   132	{
   133		struct wiegand_gpio_instance *info = filp->private_data;
   134		struct wiegand_gpio *wiegand_gpio = info->dev;
   135	
   136		mutex_lock(&wiegand_gpio->mutex);
   137		info->flags = 0;
   138		mutex_unlock(&wiegand_gpio->mutex);
   139	
   140		kfree(info);
   141	
   142		return 0;
   143	}
   144	
   145	static ssize_t wiegand_gpio_fwrite(struct file *filp, char __user const *buf,
   146							size_t len, loff_t *offset)
   147	{
   148		struct wiegand_gpio_instance *info = filp->private_data;
   149		struct wiegand_gpio *wiegand_gpio = info->dev;
   150		u32 msg_length = wiegand_gpio->ctlr->payload_len;
   151		int rc;
   152	
   153		if (buf == NULL || len == 0 || len * 8 < msg_length)
   154			return -EINVAL;
   155	
   156		rc = wiegand_gpio_get_user_data(wiegand_gpio, buf, len);
   157		if (rc < 0)
   158			return rc;
   159	
   160		wiegand_gpio_write_by_bits(wiegand_gpio, msg_length);
   161	
   162		return len;
   163	}
   164	
   165	static int wiegand_gpio_fopen(struct inode *ino, struct file *filp)
   166	{
   167		int rc;
   168		struct wiegand_gpio_instance *info;
   169		struct wiegand_gpio *wiegand_gpio = container_of(filp->f_op,
   170								 struct wiegand_gpio,
   171								 fops);
   172		mutex_lock(&wiegand_gpio->mutex);
   173		if ((filp->f_flags & O_ACCMODE) == O_RDONLY ||
   174					(filp->f_flags & O_ACCMODE) == O_RDWR) {
   175			dev_err(wiegand_gpio->dev, "Device is write only\n");
   176			rc = -EIO;
   177			goto err;
   178		}
   179		info = kzalloc(sizeof(*info), GFP_KERNEL);
   180		if (!info) {
   181			rc = -ENOMEM;
   182			goto err;
   183		}
   184	
   185		info->dev = wiegand_gpio;
   186		info->flags = filp->f_flags;
   187		mutex_unlock(&wiegand_gpio->mutex);
   188	
   189		filp->private_data = info;
   190	
   191		return 0;
   192	err:
   193		mutex_unlock(&wiegand_gpio->mutex);
   194		return rc;
   195	}
   196	
   197	/* This function is used by device drivers */
 > 198	int wiegand_gpio_transfer_message(struct wiegand_device *dev, u8 *message,
   199									u8 msg_bitlen)
   200	{
   201		struct wiegand_controller *ctlr = dev->controller;
   202		struct wiegand_gpio *wiegand_gpio = wiegand_master_get_devdata(ctlr);
   203		u8 msg_bytelength = (msg_bitlen % 8) ?
   204					(msg_bitlen / 8) + 1 : (msg_bitlen / 8);
   205	
   206		memcpy(wiegand_gpio->data, message, msg_bytelength);
   207		wiegand_gpio_write_by_bits(wiegand_gpio, msg_bitlen);
   208	
   209		return 0;
   210	}
   211	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
