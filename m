Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5705C6A7960
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCBCNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCBCND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:13:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4AF953;
        Wed,  1 Mar 2023 18:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677723182; x=1709259182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8DgzvjFhyEWvVKzH0IsTQ/56HfCQ8NNJBH4SKCM7ZyY=;
  b=LlOTyFJpQuw+I62VF19D9it22r8938irKdw4tVuMmuz79V2IUNb/DZog
   ZzEEoIHcpbLvc7Q66fcGHmEVLVao5cYRdEawHZwAhFLqv9QqQAOGfKQK3
   MKZNXvlJuYhqRP/acO0Wlel2t+RKIHUFCGty/rsfCzXC3lsgxn7zvW1nx
   Se81mRtoTz51MNVclaRPX5xOxV/fqSz/7tREOZ2FtsPXySgWn86AbTNvx
   j3CAdxqCmmkDIUGTG4ZYlq4NBuZvZBjMIiwqnnLpblzGbyFI1lcAiK1iA
   BTm5BXnq8kR7pPm/H7KbzzxjBmlR+0rUaHi48rwuk0cTyYPPwHoV6hZWe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="318391854"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="318391854"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 18:13:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="676998932"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="676998932"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Mar 2023 18:12:55 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXYRC-00004l-33;
        Thu, 02 Mar 2023 02:12:54 +0000
Date:   Thu, 2 Mar 2023 10:11:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@redhat.com, dipenp@nvidia.com, treding@nvidia.com,
        mwen@igalia.com, fmdefrancesco@gmail.com, arnd@arndb.de,
        bvanassche@acm.org, ogabbay@kernel.org, axboe@kernel.dk,
        mathieu.poirier@linaro.org, linux@zary.sk, masahiroy@kernel.org,
        yangyicong@hisilicon.com, dan.j.williams@intel.com,
        jacek.lawrynowicz@linux.intel.com, benjamin.tissoires@redhat.com,
        devicetree@vger.kernel.org, furong.zhou@linux.intel.com,
        andriy.shevchenko@intel.com, linus.walleij@linaro.org,
        Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Subject: Re: [PATCHv3 4/4] wiegand: add Wiegand GPIO bitbanged controller
 driver
Message-ID: <202303020937.pxOPT5nt-lkp@intel.com>
References: <20230301142835.19614-5-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301142835.19614-5-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.2 next-20230301]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230301-223030
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230301142835.19614-5-m.zatovic1%40gmail.com
patch subject: [PATCHv3 4/4] wiegand: add Wiegand GPIO bitbanged controller driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230302/202303020937.pxOPT5nt-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/641c36b9878a19ea4977f0e14df22c7475b423df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Za-ovi/dt-bindings-wiegand-add-Wiegand-controller-common-properties/20230301-223030
        git checkout 641c36b9878a19ea4977f0e14df22c7475b423df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303020937.pxOPT5nt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/wiegand/wiegand-gpio.c:50:9: warning: no previous prototype for 'payload_len_show' [-Wmissing-prototypes]
      50 | ssize_t payload_len_show(struct device *dev, struct device_attribute *attr, char *buf)
         |         ^~~~~~~~~~~~~~~~
>> drivers/wiegand/wiegand-gpio.c:58:9: warning: no previous prototype for 'payload_len_store' [-Wmissing-prototypes]
      58 | ssize_t payload_len_store(struct device *dev, struct device_attribute *attr, const char *buf,
         |         ^~~~~~~~~~~~~~~~~
>> drivers/wiegand/wiegand-gpio.c:81:6: warning: no previous prototype for 'wiegand_gpio_send_bit' [-Wmissing-prototypes]
      81 | void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio, bool value, bool last)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/wiegand/wiegand-gpio.c:195:5: warning: no previous prototype for 'wiegand_gpio_transfer_message' [-Wmissing-prototypes]
     195 | int wiegand_gpio_transfer_message(struct wiegand_device *dev, u8 *message, u8 msg_bitlen)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/payload_len_show +50 drivers/wiegand/wiegand-gpio.c

    46	
    47	/*
    48	 * Attribute file for setting payload length of Wiegand messages.
    49	 */
  > 50	ssize_t payload_len_show(struct device *dev, struct device_attribute *attr, char *buf)
    51	{
    52		struct wiegand_gpio *wiegand_gpio = dev_get_drvdata(dev);
    53		struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
    54	
    55		return sysfs_emit(buf, "%u\n", ctlr->payload_len);
    56	}
    57	
  > 58	ssize_t payload_len_store(struct device *dev, struct device_attribute *attr, const char *buf,
    59				size_t count)
    60	{
    61		struct wiegand_gpio *wiegand_gpio = dev_get_drvdata(dev);
    62		struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
    63	
    64		return store_ulong(&(ctlr->payload_len), buf, count, WIEGAND_MAX_PAYLEN_BYTES * 8);
    65	}
    66	DEVICE_ATTR_RW(payload_len);
    67	
    68	static struct attribute *wiegand_gpio_attrs[] = {
    69		&dev_attr_payload_len.attr,
    70		NULL,
    71	};
    72	
    73	ATTRIBUTE_GROUPS(wiegand_gpio);
    74	
    75	/*
    76	 * To send a bit of value 1 following the wiegand protocol, one must set
    77	 * the wiegand_data_hi to low for the duration of pulse. Similarly to send
    78	 * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
    79	 * This way the two lines are never low at the same time.
    80	 */
  > 81	void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio, bool value, bool last)
    82	{
    83		u32 pulse_len = wiegand_gpio->ctlr->pulse_len;
    84		u32 interval_len = wiegand_gpio->ctlr->interval_len;
    85		u32 frame_gap = wiegand_gpio->ctlr->frame_gap;
    86		struct gpio_desc *gpio = value ? wiegand_gpio->gpio_data_hi : wiegand_gpio->gpio_data_lo;
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
    99	static int wiegand_gpio_write_by_bits(struct wiegand_gpio *wiegand_gpio, u16 bitlen)
   100	{
   101		size_t i;
   102		bool bit_value, is_last_bit;
   103	
   104		for (i = 0; i < bitlen; i++) {
   105			bit_value = ((wiegand_gpio->data[i / 8] >> (7 - (i % 8))) & 0x01);
   106			is_last_bit = (i + 1) == bitlen;
   107			wiegand_gpio_send_bit(wiegand_gpio, bit_value, is_last_bit);
   108		}
   109	
   110		return 0;
   111	}
   112	
   113	static ssize_t wiegand_gpio_get_user_data(struct wiegand_gpio *wiegand_gpio, char __user const *buf,
   114						  size_t len)
   115	{
   116		size_t rc;
   117	
   118		if (len > WIEGAND_MAX_PAYLEN_BYTES)
   119			return -EBADMSG;
   120	
   121		rc = copy_from_user(&wiegand_gpio->data[0], buf, WIEGAND_MAX_PAYLEN_BYTES);
   122		if (rc < 0)
   123			return rc;
   124	
   125		return len;
   126	}
   127	
   128	static int wiegand_gpio_frelease(struct inode *ino, struct file *filp)
   129	{
   130		struct wiegand_gpio_instance *info = filp->private_data;
   131		struct wiegand_gpio *wiegand_gpio = info->dev;
   132	
   133		mutex_lock(&wiegand_gpio->mutex);
   134		info->flags = 0;
   135		mutex_unlock(&wiegand_gpio->mutex);
   136	
   137		kfree(info);
   138	
   139		return 0;
   140	}
   141	
   142	static ssize_t wiegand_gpio_fwrite(struct file *filp, char __user const *buf, size_t len,
   143					loff_t *offset)
   144	{
   145		struct wiegand_gpio_instance *info = filp->private_data;
   146		struct wiegand_gpio *wiegand_gpio = info->dev;
   147		u32 msg_length = wiegand_gpio->ctlr->payload_len;
   148		int rc;
   149	
   150		if (buf == NULL || len == 0 || len * 8 < msg_length)
   151			return -EINVAL;
   152	
   153		rc = wiegand_gpio_get_user_data(wiegand_gpio, buf, len);
   154		if (rc < 0)
   155			return rc;
   156	
   157		wiegand_gpio_write_by_bits(wiegand_gpio, msg_length);
   158	
   159		return len;
   160	}
   161	
   162	static int wiegand_gpio_fopen(struct inode *ino, struct file *filp)
   163	{
   164		int rc;
   165		struct wiegand_gpio_instance *info;
   166		struct wiegand_gpio *wiegand_gpio = container_of(filp->f_op, struct wiegand_gpio, fops);
   167	
   168		mutex_lock(&wiegand_gpio->mutex);
   169	
   170		if ((filp->f_flags & O_ACCMODE) == O_RDONLY || (filp->f_flags & O_ACCMODE) == O_RDWR) {
   171			dev_err(wiegand_gpio->dev, "Device is write only\n");
   172			rc = -EIO;
   173			goto err;
   174		}
   175	
   176		info = kzalloc(sizeof(*info), GFP_KERNEL);
   177		if (!info) {
   178			rc = -ENOMEM;
   179			goto err;
   180		}
   181	
   182		info->dev = wiegand_gpio;
   183		info->flags = filp->f_flags;
   184		mutex_unlock(&wiegand_gpio->mutex);
   185	
   186		filp->private_data = info;
   187	
   188		return 0;
   189	err:
   190		mutex_unlock(&wiegand_gpio->mutex);
   191		return rc;
   192	}
   193	
   194	/* This function is used by device drivers */
 > 195	int wiegand_gpio_transfer_message(struct wiegand_device *dev, u8 *message, u8 msg_bitlen)
   196	{
   197		struct wiegand_controller *ctlr = dev->controller;
   198		struct wiegand_gpio *wiegand_gpio = wiegand_master_get_devdata(ctlr);
   199		u8 msg_bytelength = (msg_bitlen % 8) ? (msg_bitlen / 8) + 1 : (msg_bitlen / 8);
   200	
   201		memcpy(wiegand_gpio->data, message, msg_bytelength);
   202		wiegand_gpio_write_by_bits(wiegand_gpio, msg_bitlen);
   203	
   204		return 0;
   205	}
   206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
