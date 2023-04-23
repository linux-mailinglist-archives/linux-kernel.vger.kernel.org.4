Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE49B6EBFCE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDWNlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 09:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 09:41:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A50E4C;
        Sun, 23 Apr 2023 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682257272; x=1713793272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nApaPugB0NKoArpdUyRIB6CYaHOc7HGQWk2r6oDYb88=;
  b=XHZmSz/uWdV6h7Zgt+LUWciAGXON9/MADYmKUozw1DxjuY19vRKExsEi
   3ZF81I/W+dj5nzJOQjo0Mz/CZagQpNAT4wosBux/esQfMQt3s58VE9CUZ
   1cx960qUYeL8wWAwH7VBDloHO6I+XdUrKa2xc6kil2mcKtp3HG6KXQZW6
   QowRQBuwQxwHOGTCbBKj4qk19GEjsLgzbGlS2gxAaZMg+U1B0tx5AKQcl
   9STMnP3newvlGtEl6N7fxZNV8Yn+L8Rm2tG/QuCdAUq5tnoBI0OBpwDHa
   hXr3Ifu8eRVe8KJQbhfZr+68n5edzUw3ErDTaPUIDlYVQB98e6zccPdCp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="326605141"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="326605141"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 06:41:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="939021984"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="939021984"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2023 06:41:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqZxl-000hui-1u;
        Sun, 23 Apr 2023 13:41:09 +0000
Date:   Sun, 23 Apr 2023 21:41:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yan Wang <rk.code@outlook.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl
Cc:     oe-kbuild-all@lists.linux.dev, Yan Wang <rk.code@outlook.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] gpio: gpiolib: clear the array_info's memory space
Message-ID: <202304232146.7M89pwCz-lkp@intel.com>
References: <KL1PR01MB54489B7A3D9D02D242B4BDA1E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1PR01MB54489B7A3D9D02D242B4BDA1E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on next-20230421]
[cannot apply to linus/master v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yan-Wang/gpio-gpiolib-clear-the-array_info-s-memory-space/20230423-190500
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/KL1PR01MB54489B7A3D9D02D242B4BDA1E6669%40KL1PR01MB5448.apcprd01.prod.exchangelabs.com
patch subject: [PATCH v1] gpio: gpiolib: clear the array_info's memory space
config: microblaze-buildonly-randconfig-r006-20230423 (https://download.01.org/0day-ci/archive/20230423/202304232146.7M89pwCz-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/061c9f6937fab64a9c1d051252fcd3236a35381f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yan-Wang/gpio-gpiolib-clear-the-array_info-s-memory-space/20230423-190500
        git checkout 061c9f6937fab64a9c1d051252fcd3236a35381f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304232146.7M89pwCz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpio/gpiolib.c: In function 'gpiod_get_array':
>> drivers/gpio/gpiolib.c:4345:25: warning: argument 1 null where non-null expected [-Wnonnull]
    4345 |                         memset(array_info, 0, sizeof(struct gpio_array));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:36,
                    from include/linux/acpi.h:13,
                    from drivers/gpio/gpiolib.c:3:
   arch/microblaze/include/asm/string.h:16:14: note: in a call to function 'memset' declared 'nonnull'
      16 | extern void *memset(void *, int, __kernel_size_t);
         |              ^~~~~~


vim +4345 drivers/gpio/gpiolib.c

  4263	
  4264	/**
  4265	 * gpiod_get_array - obtain multiple GPIOs from a multi-index GPIO function
  4266	 * @dev:	GPIO consumer, can be NULL for system-global GPIOs
  4267	 * @con_id:	function within the GPIO consumer
  4268	 * @flags:	optional GPIO initialization flags
  4269	 *
  4270	 * This function acquires all the GPIOs defined under a given function.
  4271	 *
  4272	 * Return a struct gpio_descs containing an array of descriptors, -ENOENT if
  4273	 * no GPIO has been assigned to the requested function, or another IS_ERR()
  4274	 * code if an error occurred while trying to acquire the GPIOs.
  4275	 */
  4276	struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
  4277							const char *con_id,
  4278							enum gpiod_flags flags)
  4279	{
  4280		struct gpio_desc *desc;
  4281		struct gpio_descs *descs;
  4282		struct gpio_array *array_info = NULL;
  4283		struct gpio_chip *gc;
  4284		int count, bitmap_size;
  4285		size_t descs_size;
  4286	
  4287		count = gpiod_count(dev, con_id);
  4288		if (count < 0)
  4289			return ERR_PTR(count);
  4290	
  4291		descs_size = struct_size(descs, desc, count);
  4292		descs = kzalloc(descs_size, GFP_KERNEL);
  4293		if (!descs)
  4294			return ERR_PTR(-ENOMEM);
  4295	
  4296		for (descs->ndescs = 0; descs->ndescs < count; descs->ndescs++) {
  4297			desc = gpiod_get_index(dev, con_id, descs->ndescs, flags);
  4298			if (IS_ERR(desc)) {
  4299				gpiod_put_array(descs);
  4300				return ERR_CAST(desc);
  4301			}
  4302	
  4303			descs->desc[descs->ndescs] = desc;
  4304	
  4305			gc = gpiod_to_chip(desc);
  4306			/*
  4307			 * If pin hardware number of array member 0 is also 0, select
  4308			 * its chip as a candidate for fast bitmap processing path.
  4309			 */
  4310			if (descs->ndescs == 0 && gpio_chip_hwgpio(desc) == 0) {
  4311				struct gpio_descs *array;
  4312	
  4313				bitmap_size = BITS_TO_LONGS(gc->ngpio > count ?
  4314							    gc->ngpio : count);
  4315	
  4316				array = krealloc(descs, descs_size +
  4317						 struct_size(array_info, invert_mask, 3 * bitmap_size),
  4318						 GFP_KERNEL | __GFP_ZERO);
  4319				if (!array) {
  4320					gpiod_put_array(descs);
  4321					return ERR_PTR(-ENOMEM);
  4322				}
  4323	
  4324				descs = array;
  4325	
  4326				array_info = (void *)descs + descs_size;
  4327				array_info->get_mask = array_info->invert_mask +
  4328							  bitmap_size;
  4329				array_info->set_mask = array_info->get_mask +
  4330							  bitmap_size;
  4331	
  4332				array_info->desc = descs->desc;
  4333				array_info->size = count;
  4334				array_info->chip = gc;
  4335				bitmap_set(array_info->get_mask, descs->ndescs,
  4336					   count - descs->ndescs);
  4337				bitmap_set(array_info->set_mask, descs->ndescs,
  4338					   count - descs->ndescs);
  4339				descs->info = array_info;
  4340			}
  4341	
  4342			/* If there is no cache for fast bitmap processing path, continue */
  4343			if (!array_info) {
  4344				/*clear descs->info*/
> 4345				memset(array_info, 0, sizeof(struct gpio_array));
  4346				continue;
  4347			}
  4348	
  4349			/* Unmark array members which don't belong to the 'fast' chip */
  4350			if (array_info->chip != gc) {
  4351				__clear_bit(descs->ndescs, array_info->get_mask);
  4352				__clear_bit(descs->ndescs, array_info->set_mask);
  4353			}
  4354			/*
  4355			 * Detect array members which belong to the 'fast' chip
  4356			 * but their pins are not in hardware order.
  4357			 */
  4358			else if (gpio_chip_hwgpio(desc) != descs->ndescs) {
  4359				/*
  4360				 * Don't use fast path if all array members processed so
  4361				 * far belong to the same chip as this one but its pin
  4362				 * hardware number is different from its array index.
  4363				 */
  4364				if (bitmap_full(array_info->get_mask, descs->ndescs)) {
  4365					array_info = NULL;
  4366				} else {
  4367					__clear_bit(descs->ndescs,
  4368						    array_info->get_mask);
  4369					__clear_bit(descs->ndescs,
  4370						    array_info->set_mask);
  4371				}
  4372			} else {
  4373				/* Exclude open drain or open source from fast output */
  4374				if (gpiochip_line_is_open_drain(gc, descs->ndescs) ||
  4375				    gpiochip_line_is_open_source(gc, descs->ndescs))
  4376					__clear_bit(descs->ndescs,
  4377						    array_info->set_mask);
  4378				/* Identify 'fast' pins which require invertion */
  4379				if (gpiod_is_active_low(desc))
  4380					__set_bit(descs->ndescs,
  4381						  array_info->invert_mask);
  4382			}
  4383		}
  4384		if (array_info)
  4385			dev_dbg(dev,
  4386				"GPIO array info: chip=%s, size=%d, get_mask=%lx, set_mask=%lx, invert_mask=%lx\n",
  4387				array_info->chip->label, array_info->size,
  4388				*array_info->get_mask, *array_info->set_mask,
  4389				*array_info->invert_mask);
  4390		return descs;
  4391	}
  4392	EXPORT_SYMBOL_GPL(gpiod_get_array);
  4393	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
