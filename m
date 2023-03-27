Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8266C9CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjC0HsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjC0HsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:48:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 999B149D2;
        Mon, 27 Mar 2023 00:48:00 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxXNonSiFkSjwSAA--.16333S3;
        Mon, 27 Mar 2023 15:47:51 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxAeUaSiFkSf0NAA--.45014S3;
        Mon, 27 Mar 2023 15:47:40 +0800 (CST)
Subject: Re: [PATCH v3 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230324063317.14664-3-zhuyinbo@loongson.cn>
 <202303250536.OV1LR58y-lkp@intel.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <5de5ca5f-d920-9ed9-a6d2-983a46d3b740@loongson.cn>
Date:   Mon, 27 Mar 2023 15:47:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202303250536.OV1LR58y-lkp@intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxAeUaSiFkSf0NAA--.45014S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZw1xWFWxWF4kJr1xKFWfZrb_yoW5Cw4fpa
        1UCa1qkrs5Xr18CFWkGayDZ3WYqrZ5X3srWFWjyr4UuF9xZ34jqrn2kF15XFnIyF1kWFy8
        ZrW8WrWkKF18ua7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ajg7UUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2023/3/25 ÉÏÎç5:53, kernel test robot Ð´µÀ:
> Hi Yinbo,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on broonie-spi/for-next]
> [also build test ERROR on robh/for-next krzk-dt/for-next linus/master v6.3-rc3 next-20230324]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/dt-bindings-spi-add-loongson-spi/20230324-143432
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> patch link:    https://lore.kernel.org/r/20230324063317.14664-3-zhuyinbo%40loongson.cn
> patch subject: [PATCH v3 2/2] spi: loongson: add bus driver for the loongson spi controller
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230325/202303250536.OV1LR58y-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/3742622c455d25c4a110d2caf2f5b2ceefe88f91
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Yinbo-Zhu/dt-bindings-spi-add-loongson-spi/20230324-143432
>          git checkout 3742622c455d25c4a110d2caf2f5b2ceefe88f91
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303250536.OV1LR58y-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "loongson_spi_dev_pm_ops" [drivers/spi/spi-loongson-pci.ko] undefined!
>>> ERROR: modpost: "loongson_spi_dev_pm_ops" [drivers/spi/spi-loongson-plat.ko] undefined!
> 
This compile issue when spi config was set as module then 
"loongson_spi_dev_pm_ops undefined" will occur, but if set spi config as 
built-in and not this issue, and my patch was tested that use spi config 
built-in so not this error occur,  and this compile fail issue's reason 
was "loongson_spi_dev_pm_ops" not use EXPORT_SYMBOL_GPL to export, I 
will add following change to fix this compile error issue.

--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -297,6 +297,7 @@ const struct dev_pm_ops loongson_spi_dev_pm_ops = {
         .suspend = loongson_spi_suspend,
         .resume = loongson_spi_resume,
  };
+EXPORT_SYMBOL_GPL(loongson_spi_dev_pm_ops);

