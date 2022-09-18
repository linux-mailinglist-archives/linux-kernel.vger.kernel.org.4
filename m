Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03B55BBCC7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiIRJ0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIRJZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:25:51 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CEC21835
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:25:49 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id ZqYboS2ydtk1aZqYcoIyTK; Sun, 18 Sep 2022 11:25:48 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Sep 2022 11:25:48 +0200
X-ME-IP: 90.11.190.129
Message-ID: <a0215d71-b7d6-17cf-8e98-dcefa7a1671b@wanadoo.fr>
Date:   Sun, 18 Sep 2022 11:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] misc: microchip: pci1xxxx: Fix the error handling
 paths of gp_aux_bus_probe()
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-gpio@vger.kernel.org
References: <1b41531de02ee029628d9b0ec2cf1ee7f180fe10.1663482259.git.christophe.jaillet@wanadoo.fr>
 <202209181527.7wmi1NBN-lkp@intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <202209181527.7wmi1NBN-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/09/2022 à 10:03, kernel test robot a écrit :
> Hi Christophe,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on char-misc/char-misc-testing]
> [also build test WARNING on next-20220916]
> [cannot apply to linus/master v6.0-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/misc-microchip-pci1xxxx-Fix-the-error-handling-path-of-gp_aux_bus_probe/20220918-143022
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git ceecbbddbf549fe0b7ffa3804a6e255b3360030f
> config: xtensa-randconfig-r022-20220918
> compiler: xtensa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/089c1639fdebdad9be8de56c1546308eac15747d
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Christophe-JAILLET/misc-microchip-pci1xxxx-Fix-the-error-handling-path-of-gp_aux_bus_probe/20220918-143022
>          git checkout 089c1639fdebdad9be8de56c1546308eac15747d
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/misc/mchp_pci1xxxx/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c: In function 'gp_aux_bus_probe':
>>> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:35:13: warning: variable 'irq' set but not used [-Wunused-but-set-variable]
>        35 |         int irq, retval;
>           |             ^~~
> 
> 
> vim +/irq +35 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> 

[...]

>      75	
>      76		retval = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>      77		if (retval < 0)
>      78			goto err_aux_dev_del_0;
>      79	
>      80		retval = pci_irq_vector(pdev, 0);
>      81		if (retval < 0)
>      82			goto err_aux_dev_del_0;
>      83		irq = retval;

We save the irq number here...

>      84	
>      85		aux_bus->aux_device_wrapper[1] = kzalloc(sizeof(*aux_bus->aux_device_wrapper[1]),
>      86							 GFP_KERNEL);
>      87		if (!aux_bus->aux_device_wrapper[1]) {
>      88			retval = -ENOMEM;
>      89			goto err_aux_dev_del_0;
>      90		}
>      91	
>      92		retval = ida_alloc(&gp_client_ida, GFP_KERNEL);
>      93		if (retval < 0) {
>      94			kfree(aux_bus->aux_device_wrapper[1]);
>      95			goto err_aux_dev_del_0;
>      96		}
>      97	
>      98		aux_bus->aux_device_wrapper[1]->aux_dev.name = aux_dev_gpio_name;
>      99		aux_bus->aux_device_wrapper[1]->aux_dev.dev.parent = &pdev->dev;
>     100		aux_bus->aux_device_wrapper[1]->aux_dev.dev.release = gp_auxiliary_device_release;
>     101		aux_bus->aux_device_wrapper[1]->aux_dev.id = retval;
>     102	
>     103		aux_bus->aux_device_wrapper[1]->gp_aux_data.region_start = pci_resource_start(pdev, 0);
>     104		aux_bus->aux_device_wrapper[1]->gp_aux_data.region_length = pci_resource_end(pdev, 0);
>     105	
>     106		pdev->irq = retval;

... then this should be:
    pdev->irq = irq;
here.

I'll send a v2 in a few days.
Let see first if we get some other feedback.

CJ

