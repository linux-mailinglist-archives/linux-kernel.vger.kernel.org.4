Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56315728D0A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbjFIBXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbjFIBXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:23:46 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAB3630E5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:23:42 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxrOodf4JkfdQAAA--.2714S3;
        Fri, 09 Jun 2023 09:23:41 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxbMobf4Jk01sJAA--.20460S3;
        Fri, 09 Jun 2023 09:23:39 +0800 (CST)
Message-ID: <48ca03db-1e2c-b02a-f743-7911d970851f@loongson.cn>
Date:   Fri, 9 Jun 2023 09:23:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 1/8] drm/etnaviv: add a dedicated function to register
 an irq handler
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sui Jingfeng <15330273260@189.cn>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20230608172535.GA1207045@bhelgaas>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <20230608172535.GA1207045@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxbMobf4Jk01sJAA--.20460S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr45CF18Xr4DJFWUXFy5trc_yoW5Xr1fpF
        s7GFyYkr18ua42g34xZF98ZFya9w1fWFyxAw1Dt3sIk3s0vrs5tryYkFWUG34fAryrCw4I
        yr4jgFW7uF1Y9rgCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/9 01:25, Bjorn Helgaas wrote:
> On Wed, Jun 07, 2023 at 06:55:44PM +0800, Sui Jingfeng wrote:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> Because getting IRQ from a device is platform-dependent, PCI devices have
>> different methods for getting an IRQ. This patch is a preparation patch to
>> extend the driver for the PCI device support.
>>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 34 ++++++++++++++++++++-------
>>   1 file changed, 25 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> index de8c9894967c..b9c12d3145a2 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> @@ -1817,6 +1817,29 @@ static const struct of_device_id etnaviv_gpu_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, etnaviv_gpu_match);
>>   
>> +static int etnaviv_gpu_register_irq(struct etnaviv_gpu *gpu, int irq)
>> +{
>> +	struct device *dev = gpu->dev;
>> +	int err;
>> +
>> +	if (irq < 0) {
>> +		dev_err(dev, "failed to get irq: %d\n", irq);
> Isn't this message redundant because platform_get_irq() already
> emitted a message for this case?
Indeed, will be fixed at version.
>> +		return irq;
>> +	}
>> +
>> +	err = devm_request_irq(dev, irq, irq_handler, 0, dev_name(dev), gpu);
>> +	if (err) {
>> +		dev_err(dev, "failed to request irq %u: %d\n", irq, err);
>> +		return err;
>> +	}
>> +
>> +	gpu->irq = irq;
>> +
>> +	dev_info(dev, "irq(%d) handler registered\n", irq);
>> +
>> +	return 0;
>> +}
>> +
>>   static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> @@ -1837,16 +1860,9 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>>   		return PTR_ERR(gpu->mmio);
>>   
>>   	/* Get Interrupt: */
>> -	gpu->irq = platform_get_irq(pdev, 0);
>> -	if (gpu->irq < 0)
>> -		return gpu->irq;
>> -
>> -	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
>> -			       dev_name(gpu->dev), gpu);
>> -	if (err) {
>> -		dev_err(dev, "failed to request IRQ%u: %d\n", gpu->irq, err);
>> +	err = etnaviv_gpu_register_irq(gpu, platform_get_irq(pdev, 0));
>> +	if (err)
>>   		return err;
>> -	}
>>   
>>   	/* Get Clocks: */
>>   	gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");
>> -- 
>> 2.25.1
>>
-- 
Jingfeng

