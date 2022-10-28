Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23A610AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ1G5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1G51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:57:27 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8024E16D89A;
        Thu, 27 Oct 2022 23:57:25 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8DxvrdTfVtj3wkDAA--.6717S3;
        Fri, 28 Oct 2022 14:57:23 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxiFdOfVtjsjkGAA--.3812S2;
        Fri, 28 Oct 2022 14:57:19 +0800 (CST)
Subject: Re: [PATCH v8 1/2] thermal: loongson-2: add thermal management
 support
To:     kernel test robot <lkp@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        zhuyinbo@loongson.cn, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20221028013532.10361-1-zhuyinbo@loongson.cn>
 <202210281326.Wv56U0Zw-lkp@intel.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <53b1516b-ec53-dc03-fc23-f3d8014e7d55@loongson.cn>
Date:   Fri, 28 Oct 2022 14:57:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202210281326.Wv56U0Zw-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxiFdOfVtjsjkGAA--.3812S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jr18ZF17trykKr47uw45KFg_yoWxCw4rpa
        y5Jas8GrZ7Xr1DZ3WUA3y8Ar4Dtr13tasrZr4xGw15ArWrX34agFy8JF15urWIkF98KFyj
        vr90gFWY93Z8XrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8jXdUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/28 下午1:55, kernel test robot 写道:
> Hi Yinbo,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on rafael-pm/thermal]
> [also build test WARNING on linus/master v6.1-rc2 next-20221027]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/thermal-loongson-2-add-thermal-management-support/20221028-093603
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
> patch link:    https://lore.kernel.org/r/20221028013532.10361-1-zhuyinbo%40loongson.cn
> patch subject: [PATCH v8 1/2] thermal: loongson-2: add thermal management support
> config: sparc-allyesconfig
> compiler: sparc64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/d94e01f4aefe4c0ab05babe101f0a0ce53165456
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Yinbo-Zhu/thermal-loongson-2-add-thermal-management-support/20221028-093603
>          git checkout d94e01f4aefe4c0ab05babe101f0a0ce53165456
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/thermal/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/thermal/loongson2_thermal.c:136:21: error: variable 'loongson2_of_thermal_ops' has initializer but incomplete type
>       136 | static const struct thermal_zone_of_device_ops loongson2_of_thermal_ops = {
>           |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/thermal/loongson2_thermal.c:137:10: error: 'const struct thermal_zone_of_device_ops' has no member named 'get_temp'
>       137 |         .get_temp = loongson2_thermal_get_temp,
>           |          ^~~~~~~~
>>> drivers/thermal/loongson2_thermal.c:137:21: warning: excess elements in struct initializer
>       137 |         .get_temp = loongson2_thermal_get_temp,
>           |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/thermal/loongson2_thermal.c:137:21: note: (near initialization for 'loongson2_of_thermal_ops')
>     drivers/thermal/loongson2_thermal.c:138:10: error: 'const struct thermal_zone_of_device_ops' has no member named 'set_trips'
>       138 |         .set_trips = loongson2_thermal_set_trips,
>           |          ^~~~~~~~~
>     drivers/thermal/loongson2_thermal.c:138:22: warning: excess elements in struct initializer
>       138 |         .set_trips = loongson2_thermal_set_trips,
>           |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/thermal/loongson2_thermal.c:138:22: note: (near initialization for 'loongson2_of_thermal_ops')
>     drivers/thermal/loongson2_thermal.c: In function 'loongson2_thermal_probe':
>     drivers/thermal/loongson2_thermal.c:177:21: error: implicit declaration of function 'devm_thermal_zone_of_sensor_register'; did you mean 'devm_thermal_of_zone_register'? [-Werror=implicit-function-declaration]
>       177 |         data->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
>           |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                     devm_thermal_of_zone_register
>>> drivers/thermal/loongson2_thermal.c:177:19: warning: assignment to 'struct thermal_zone_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>       177 |         data->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
>           |                   ^
>     drivers/thermal/loongson2_thermal.c: At top level:
>     drivers/thermal/loongson2_thermal.c:136:48: error: storage size of 'loongson2_of_thermal_ops' isn't known
>       136 | static const struct thermal_zone_of_device_ops loongson2_of_thermal_ops = {
>           |                                                ^~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
> 
> 
> vim +137 drivers/thermal/loongson2_thermal.c
> 
>     135	
>     136	static const struct thermal_zone_of_device_ops loongson2_of_thermal_ops = {
>   > 137		.get_temp = loongson2_thermal_get_temp,
>     138		.set_trips = loongson2_thermal_set_trips,
>     139	};
>     140	
>     141	static int loongson2_thermal_probe(struct platform_device *pdev)
>     142	{
>     143		struct device *dev = &pdev->dev;
>     144		struct resource *res;
>     145		struct loongson2_thermal_data *data;
>     146		int ret;
>     147	
>     148		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>     149		if (!data)
>     150			return -ENOMEM;
>     151	
>     152		data->pdev = pdev;
>     153		platform_set_drvdata(pdev, data);
>     154	
>     155		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>     156		data->regs = devm_ioremap(dev, res->start, resource_size(res));
>     157		if (IS_ERR(data->regs))
>     158			return PTR_ERR(data->regs);
>     159	
>     160		/* get irq */
>     161		data->irq = platform_get_irq(pdev, 0);
>     162		if (data->irq < 0)
>     163			return data->irq;
>     164	
>     165		/* get id */
>     166		data->id = loongson2_thermal_get_sensor_id();
>     167		if (data->id > LOONGSON2_SOC_MAX_SENSOR_NUM - 1 || data->id < 0) {
>     168			dev_err(dev, "sensor id error,must be in <0 ~ %d>\n",
>     169					LOONGSON2_SOC_MAX_SENSOR_NUM - 1);
>     170			return -EINVAL;
>     171		}
>     172	
>     173		writeb(0xff, data->regs + LOONGSON2_TSENSOR_STATUS);
>     174	
>     175		loongson2_thermal_set(data, 0, 0, false);
>     176	
>   > 177		data->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
>     178								   data->id, data,
>     179								   &loongson2_of_thermal_ops);
>     180		if (IS_ERR(data->tzd)) {
>     181			ret = PTR_ERR(data->tzd);
>     182			data->tzd = NULL;
>     183			dev_err(&pdev->dev, "failed to register %d\n", ret);
>     184			return ret;
>     185		}
>     186	
>     187		ret = devm_request_threaded_irq(dev, data->irq,
>     188				loongson2_thermal_alarm_irq, loongson2_thermal_irq_thread,
>     189				IRQF_ONESHOT, "loongson2_thermal", data);
>     190		if (ret < 0) {
>     191			dev_err(dev, "failed to request alarm irq: %d\n", ret);
>     192			return ret;
>     193		}
>     194	
>     195		/*
>     196		 * Thermal_zone doesn't enable hwmon as default,
>     197		 * enable it here
>     198		 */
>     199		data->tzd->tzp->no_hwmon = false;
>     200		ret = thermal_add_hwmon_sysfs(data->tzd);
>     201		if (ret) {
>     202			dev_err(dev, "failed to add hwmon sysfs interface %d\n", ret);
>     203			return ret;
>     204		}
>     205	
>     206		return 0;
>     207	}Hi

I use W=1 to compile it and doesn't reproduce that warning, and I added
the change that don't touch .c code. I think it shoud be error report.

Tks
Yinbo
>     208	
> 

