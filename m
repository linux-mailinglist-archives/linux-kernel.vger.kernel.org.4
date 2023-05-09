Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2412C6FBC73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjEIB03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjEIB01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:26:27 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E1BF422E;
        Mon,  8 May 2023 18:26:25 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8CxvOpAoVlkJs4GAA--.11043S3;
        Tue, 09 May 2023 09:26:24 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxFLU9oVlkO_9RAA--.16520S3;
        Tue, 09 May 2023 09:26:23 +0800 (CST)
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230426071045.20753-1-zhuyinbo@loongson.cn>
 <20230426071045.20753-3-zhuyinbo@loongson.cn>
 <ZFj3BEHCDc/XLBZB@finisterre.sirena.org.uk>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <795a34c3-bf84-9f43-adc9-edab4d91394b@loongson.cn>
Date:   Tue, 9 May 2023 09:26:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZFj3BEHCDc/XLBZB@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxFLU9oVlkO_9RAA--.16520S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF18Ary5ZF4rXr1rXr1UJrb_yoW8Xr1fpa
        yYkrZxCw48JrWkGwnay393Ca1Y9393J3y5J3yxK3W7CFWDKa48Xw1DXFy5uwsrJF1jvFyY
        g348ua1DWF15ZF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b4AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz4
        8v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1tl1PUUUUU==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/8 下午9:20, Mark Brown 写道:
> On Wed, Apr 26, 2023 at 03:10:45PM +0800, Yinbo Zhu wrote:
>> This bus driver supports the Loongson spi hardware controller in the
>> Loongson platforms and supports to use DTS and PCI framework to
>> register spi device resources.
> 
> This breaks an x86 allmodconfig build:
> 
> /build/stage/linux/drivers/spi/spi-loongson-core.c: In function ‘loongson_spi_init_master’:
> /build/stage/linux/drivers/spi/spi-loongson-core.c:222:31: error: implicit declaration of function ‘of_node_get’ [-Werror=implicit-function-declaration]
>    222 |         master->dev.of_node = of_node_get(dev->of_node);
>        |                               ^~~~~~~~~~~
> /build/stage/linux/drivers/spi/spi-loongson-core.c:222:29: error: assignment to ‘struct device_node *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
>    222 |         master->dev.of_node = of_node_get(dev->of_node);
>        |                             ^
> /build/stage/linux/drivers/spi/spi-loongson-core.c:242:13: error: implicit declaration of function ‘of_get_property’ [-Werror=implicit-function-declaration]
>    242 |         if (of_get_property(dev->of_node, "spi-nocs", NULL))
>        |             ^~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors


These errors was due to the function of_node_get and of_get_property
loss a declaration and I will add "#include <linux/of.h>" in
spi-loongson-core.c to fix it.

Thanks.
> 

