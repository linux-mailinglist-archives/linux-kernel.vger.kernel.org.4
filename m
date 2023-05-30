Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE6B7160EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjE3NAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjE3M7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:59:46 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA5E7198
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:59:20 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:36042.1831460184
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id EB33C100198;
        Tue, 30 May 2023 20:58:09 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-7vx9t with ESMTP id 74c4c7cd99da4575ac5fd10594e22a3e for lkp@intel.com;
        Tue, 30 May 2023 20:58:10 CST
X-Transaction-ID: 74c4c7cd99da4575ac5fd10594e22a3e
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <c3d67084-df46-6ea4-2f37-43cc03147ef9@189.cn>
Date:   Tue, 30 May 2023 20:58:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 5/6] drm/etnaviv: expand driver support for the PCI
 devices
To:     kernel test robot <lkp@intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn
References: <20230529172452.2148819-6-suijingfeng@loongson.cn>
 <202305301659.4guSLavL-lkp@intel.com>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <202305301659.4guSLavL-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Previously, I don't realize some arch doesn't enable CONFIG_PCI by default.

This problem only happens on the arch which CONFIG_PCI isn't being enabled.

This problem also caused by the fact that pci_clear_master don't have a 
dummy implement.

I have create a patch to fix that, see [1].


This problem is easy to fix,  with some #ifdef and #endif definition guard,

make the PCI driver support don't get compiled on the architecture which 
don't have  CONFIG_PCI enable. Originally, I want it always built-in.


Should I fix this problem at driver side and respin this patch?


[1] 
https://patchwork.kernel.org/project/linux-pci/patch/20230530101655.2275731-1-suijingfeng@loongson.cn/


On 2023/5/30 17:00, kernel test robot wrote:
> Hi Sui,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on drm-misc/drm-misc-next]
> [also build test ERROR on drm/drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.4-rc4 next-20230530]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/drm-etnaviv-add-a-dedicated-function-to-register-an-irq-handler/20230530-012547
> base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
> patch link:    https://lore.kernel.org/r/20230529172452.2148819-6-suijingfeng%40loongson.cn
> patch subject: [PATCH v5 5/6] drm/etnaviv: expand driver support for the PCI devices
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230530/202305301659.4guSLavL-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.3.0
> reproduce (this is a W=1 build):
>          mkdir -p ~/bin
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/1d05a5fa048dd4b2a934ffbb07c330ddd9279287
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Sui-Jingfeng/drm-etnaviv-add-a-dedicated-function-to-register-an-irq-handler/20230530-012547
>          git checkout 1d05a5fa048dd4b2a934ffbb07c330ddd9279287
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/gpu/drm/etnaviv/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c: In function 'etnaviv_gpu_pci_fini':
>>> drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:32:9: error: implicit declaration of function 'pci_clear_master'; did you mean 'pci_set_master'? [-Werror=implicit-function-declaration]
>        32 |         pci_clear_master(pdev);
>           |         ^~~~~~~~~~~~~~~~
>           |         pci_set_master
>     cc1: some warnings being treated as errors
>
>
> vim +32 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
>
>      27	
>      28	static void etnaviv_gpu_pci_fini(struct etnaviv_gpu *gpu, bool component)
>      29	{
>      30		struct pci_dev *pdev = to_pci_dev(gpu->dev);
>      31	
>    > 32		pci_clear_master(pdev);
>      33	
>      34		dev_dbg(gpu->dev, "component is %s\n",
>      35			component ? "enabled" : "disabled");
>      36	}
>      37	
>
