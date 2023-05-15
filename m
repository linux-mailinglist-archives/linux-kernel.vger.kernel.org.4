Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C396702C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbjEOMDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbjEOMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:03:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 603F03C22;
        Mon, 15 May 2023 05:01:20 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Bx7eoNH2Jk980IAA--.15319S3;
        Mon, 15 May 2023 20:01:17 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx4zgNH2JkywNgAA--.34962S3;
        Mon, 15 May 2023 20:01:17 +0800 (CST)
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     andy.shevchenko@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230426071045.20753-1-zhuyinbo@loongson.cn>
 <20230426071045.20753-3-zhuyinbo@loongson.cn> <ZFkPZhF8QqScXAmH@surfacebook>
 <049c871d-c658-24c1-91e6-701098f5fc28@loongson.cn>
 <16913b76-0256-492a-ec90-d367f2b52cc3@loongson.cn>
 <ZGH4SPsu40Mt-Z8f@surfacebook>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <109a8453-2172-a2ee-8672-8efb489e3dd9@loongson.cn>
Date:   Mon, 15 May 2023 20:01:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZGH4SPsu40Mt-Z8f@surfacebook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx4zgNH2JkywNgAA--.34962S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7CrWfWFy5Cw1UXF47JF43KFg_yoW8Cr1fpF
        n7Aa17uryrtrn5Kr17tryv9FZIyFWkJ390q3s3Jas3ZF90yFy2kr47ZFZF9w1Iqrs7Jry2
        v3WfuFZ2va98XFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bTkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8I
        j28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI4
        8JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
        xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x07jbVyxUUUUU=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/15 下午5:15, andy.shevchenko@gmail.com 写道:
> Mon, May 15, 2023 at 04:14:00PM +0800, zhuyinbo kirjoitti:
>> 在 2023/5/11 下午3:18, zhuyinbo 写道:
>>> 在 2023/5/8 下午11:04, andy.shevchenko@gmail.com 写道:
> 
> ...
> 
>>>>> +config SPI_LOONGSON_CORE
>>>>> +    tristate "Loongson SPI Controller Core Driver Support"
>>>>
>>>> Does it need to be visible to the user?
>>
>> I try to set it invisible that by removing the SPI_LOONGSON_CORE Kconfig
>> or removing "tristate "Loongson SPI Controller Core Driver Support" that
>> will cause spi-core driver doesn't be compiled or compiled fail issue,
>> so I will still set it visible to the user.
> 
> Making a symbol selectable only can be achieved by removing the description
> (near to tristate directive), have you tried that?

Is it like this ?

--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -517,7 +517,7 @@ config SPI_LM70_LLP
           a parallel port.

  config SPI_LOONGSON_CORE
-       tristate "Loongson SPI Controller Core Driver Support"
+       tristate
         depends on LOONGARCH || COMPILE_TEST


Thanks.
> 
> ...
> 
>>>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>> +    if (res == NULL) {
>>>>
>>>> Why not using devm_platform_ioremap_resource()?
>>> okay, I will use it.
>>>>
>>>>> +        dev_err(dev, "cannot get io resource memory\n");
>>>>> +        return -ENOENT;
>>>>
>>>>      return dev_err_probe();
>>
>> It seems that there is no need to print memory log when use
>> devm_platform_ioremap_resource because this function had contained
>> the this memory log print thus I will return PTR_ERR(reg_base).
>>
>>          reg_base = devm_platform_ioremap_resource(pdev, 0);
>>          if (IS_ERR(reg_base))
>>                  return PTR_ERR(reg_base);
> 
> Good catch! Sure, go with this.
> 

