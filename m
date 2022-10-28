Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E9F610FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJ1LoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1LoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:44:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C9E187091;
        Fri, 28 Oct 2022 04:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B720DB829B6;
        Fri, 28 Oct 2022 11:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C37AC433C1;
        Fri, 28 Oct 2022 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666957457;
        bh=LxK8ca6y6Rczv2aVqmp7Y3NMvH5sB9fmrcTGkold4c8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GWNHv8NwY6SRYHbJcSQHjQaT+KcIKRNsmyzesqFhWUQYxYh3cMFMRTROGooKAdRjh
         MHhF/m8bg2FLL/fMfB+1uqpRTnypV5NTe/MyoHFr3NerJwBbKUS4JEClPaHELVs7Dm
         zvyrHWbYWvx5MoTrl5P1ZVVY6gMbwCJsk7G1qhUTbGfLGcSThp59nQnWoejFf4wqpM
         an2aWBIzAosOGizUuO6P/1AbzawJgSYfcpHyFnf2BC49OPaTHizbfbSJex4cSLwD/b
         102BM8rJd+Ri/4eXUIu3orFbx5jZzxvkFBoaJKOYdeU/GBDU2L+cX5iUUmw0Ydeyzu
         OiAZm+yntcQhQ==
Message-ID: <d9139771-4bea-ae6a-17ae-4dbc71a191b9@kernel.org>
Date:   Fri, 28 Oct 2022 07:44:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v8 1/2] thermal: loongson-2: add thermal management
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        kernel test robot <lkp@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20221028013532.10361-1-zhuyinbo@loongson.cn>
 <202210281326.Wv56U0Zw-lkp@intel.com>
 <53b1516b-ec53-dc03-fc23-f3d8014e7d55@loongson.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <53b1516b-ec53-dc03-fc23-f3d8014e7d55@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 02:57, Yinbo Zhu wrote:
> 
> 
> 在 2022/10/28 下午1:55, kernel test robot 写道:
>> Hi Yinbo,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on rafael-pm/thermal]
>> [also build test WARNING on linus/master v6.1-rc2 next-20221027]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/thermal-loongson-2-add-thermal-management-support/20221028-093603
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
>> patch link:    https://lore.kernel.org/r/20221028013532.10361-1-zhuyinbo%40loongson.cn
>> patch subject: [PATCH v8 1/2] thermal: loongson-2: add thermal management support
>> config: sparc-allyesconfig
>> compiler: sparc64-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/intel-lab-lkp/linux/commit/d94e01f4aefe4c0ab05babe101f0a0ce53165456
>>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review Yinbo-Zhu/thermal-loongson-2-add-thermal-management-support/20221028-093603
>>          git checkout d94e01f4aefe4c0ab05babe101f0a0ce53165456
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/thermal/
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     drivers/thermal/loongson2_thermal.c:136:21: error: variable 'loongson2_of_thermal_ops' has initializer but incomplete type
>>       136 | static const struct thermal_zone_of_device_ops loongson2_of_thermal_ops = {
>>           |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>     drivers/thermal/loongson2_thermal.c:137:10: error: 'const struct thermal_zone_of_device_ops' has no member named 'get_temp'
>>       137 |         .get_temp = loongson2_thermal_get_temp,
>>           |          ^~~~~~~~
>>>> drivers/thermal/loongson2_thermal.c:137:21: warning: excess elements in struct initializer
>>       137 |         .get_temp = loongson2_thermal_get_temp,
>>           |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>     drivers/thermal/loongson2_thermal.c:137:21: note: (near initialization for 'loongson2_of_thermal_ops')
>>     drivers/thermal/loongson2_thermal.c:138:10: error: 'const struct thermal_zone_of_device_ops' has no member named 'set_trips'
>>       138 |         .set_trips = loongson2_thermal_set_trips,
>>           |          ^~~~~~~~~
>>     drivers/thermal/loongson2_thermal.c:138:22: warning: excess elements in struct initializer
>>       138 |         .set_trips = loongson2_thermal_set_trips,
>>           |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     drivers/thermal/loongson2_thermal.c:138:22: note: (near initialization for 'loongson2_of_thermal_ops')
>>     drivers/thermal/loongson2_thermal.c: In function 'loongson2_thermal_probe':
>>     drivers/thermal/loongson2_thermal.c:177:21: error: implicit declaration of function 'devm_thermal_zone_of_sensor_register'; did you mean 'devm_thermal_of_zone_register'? [-Werror=implicit-function-declaration]
>>       177 |         data->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
>>           |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>           |                     devm_thermal_of_zone_register
>>>> drivers/thermal/loongson2_thermal.c:177:19: warning: assignment to 'struct thermal_zone_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>>       177 |         data->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
>>           |                   ^
>>     drivers/thermal/loongson2_thermal.c: At top level:
>>     drivers/thermal/loongson2_thermal.c:136:48: error: storage size of 'loongson2_of_thermal_ops' isn't known
>>       136 | static const struct thermal_zone_of_device_ops loongson2_of_thermal_ops = {
>>           |                                                ^~~~~~~~~~~~~~~~~~~~~~~~
>>     cc1: some warnings being treated as errors
>>
>>
>> vim +137 drivers/thermal/loongson2_thermal.c
>>
>>     135	
>>     136	static const struct thermal_zone_of_device_ops loongson2_of_thermal_ops = {
>>   > 137		.get_temp = loongson2_thermal_get_temp,
>>     138		.set_trips = loongson2_thermal_set_trips,
>>     139	};
>>     140	
>>     141	static int loongson2_thermal_probe(struct platform_device *pdev)
>>     142	{
>>     143		struct device *dev = &pdev->dev;
>>     144		struct resource *res;
>>     145		struct loongson2_thermal_data *data;
>>     146		int ret;
>>     147	
>>     148		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>     149		if (!data)
>>     150			return -ENOMEM;
>>     151	
>>     152		data->pdev = pdev;
>>     153		platform_set_drvdata(pdev, data);
>>     154	
>>     155		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>     156		data->regs = devm_ioremap(dev, res->start, resource_size(res));
>>     157		if (IS_ERR(data->regs))
>>     158			return PTR_ERR(data->regs);
>>     159	
>>     160		/* get irq */
>>     161		data->irq = platform_get_irq(pdev, 0);
>>     162		if (data->irq < 0)
>>     163			return data->irq;
>>     164	
>>     165		/* get id */
>>     166		data->id = loongson2_thermal_get_sensor_id();
>>     167		if (data->id > LOONGSON2_SOC_MAX_SENSOR_NUM - 1 || data->id < 0) {
>>     168			dev_err(dev, "sensor id error,must be in <0 ~ %d>\n",
>>     169					LOONGSON2_SOC_MAX_SENSOR_NUM - 1);
>>     170			return -EINVAL;
>>     171		}
>>     172	
>>     173		writeb(0xff, data->regs + LOONGSON2_TSENSOR_STATUS);
>>     174	
>>     175		loongson2_thermal_set(data, 0, 0, false);
>>     176	
>>   > 177		data->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
>>     178								   data->id, data,
>>     179								   &loongson2_of_thermal_ops);
>>     180		if (IS_ERR(data->tzd)) {
>>     181			ret = PTR_ERR(data->tzd);
>>     182			data->tzd = NULL;
>>     183			dev_err(&pdev->dev, "failed to register %d\n", ret);
>>     184			return ret;
>>     185		}
>>     186	
>>     187		ret = devm_request_threaded_irq(dev, data->irq,
>>     188				loongson2_thermal_alarm_irq, loongson2_thermal_irq_thread,
>>     189				IRQF_ONESHOT, "loongson2_thermal", data);
>>     190		if (ret < 0) {
>>     191			dev_err(dev, "failed to request alarm irq: %d\n", ret);
>>     192			return ret;
>>     193		}
>>     194	
>>     195		/*
>>     196		 * Thermal_zone doesn't enable hwmon as default,
>>     197		 * enable it here
>>     198		 */
>>     199		data->tzd->tzp->no_hwmon = false;
>>     200		ret = thermal_add_hwmon_sysfs(data->tzd);
>>     201		if (ret) {
>>     202			dev_err(dev, "failed to add hwmon sysfs interface %d\n", ret);
>>     203			return ret;
>>     204		}
>>     205	
>>     206		return 0;
>>     207	}Hi
> 
> I use W=1 to compile it and doesn't reproduce that warning, and I added
> the change that don't touch .c code. I think it shoud be error report.

More likely is your code is not correct.

Best regards,
Krzysztof

