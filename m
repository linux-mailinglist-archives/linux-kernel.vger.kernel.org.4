Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27099719D4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjFANVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjFANVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:21:42 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85B0797
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:21:40 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Ax3Opjm3hkqE8DAA--.2859S3;
        Thu, 01 Jun 2023 21:21:39 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx87Bhm3hkq02EAA--.18683S3;
        Thu, 01 Jun 2023 21:21:38 +0800 (CST)
Message-ID: <81276850-d371-e61d-e13d-3a90aa950981@loongson.cn>
Date:   Thu, 1 Jun 2023 21:21:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/6] drm/etnaviv: add a dedicated function to get
 various clocks
Content-Language: en-US
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230530160643.2344551-1-suijingfeng@loongson.cn>
 <20230530160643.2344551-3-suijingfeng@loongson.cn>
 <85565974d45b5553035aeabe8a98a667718482d5.camel@pengutronix.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <85565974d45b5553035aeabe8a98a667718482d5.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dx87Bhm3hkq02EAA--.18683S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kw1rtF15ZF48uF1fGFW8tFb_yoW8tw4UpF
        s7J3W5GrWUury0k347Xr1DGrsakr1Iy3W2k3ZYvF92vrn8uF1kKw4YkrWYg3Wrur10qFWF
        kw4UGr4qka4F9FDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2TKZDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/1 02:07, Lucas Stach wrote:
>> +static int etnaviv_gpu_clk_get(struct etnaviv_gpu *gpu)
>> +{
>> +	struct device *dev = gpu->dev;
>> +
>> +	if (gpu->no_clk)
>> +		return 0;
>> +
>> +	gpu->clk_reg = devm_clk_get_optional(dev, "reg");
>> +	DBG("clk_reg: %p", gpu->clk_reg);
>> +	if (IS_ERR(gpu->clk_reg))
>> +		return PTR_ERR(gpu->clk_reg);
>> +
>> +	gpu->clk_bus = devm_clk_get_optional(dev, "bus");
>> +	DBG("clk_bus: %p", gpu->clk_bus);
>> +	if (IS_ERR(gpu->clk_bus))
>> +		return PTR_ERR(gpu->clk_bus);
>> +
>> +	gpu->clk_core = devm_clk_get(dev, "core");
>> +	DBG("clk_core: %p", gpu->clk_core);
>> +	if (IS_ERR(gpu->clk_core))
>> +		return PTR_ERR(gpu->clk_core);
>> +	gpu->base_rate_core = clk_get_rate(gpu->clk_core);
>> +
>> +	gpu->clk_shader = devm_clk_get_optional(dev, "shader");
>> +	DBG("clk_shader: %p", gpu->clk_shader);
>> +	if (IS_ERR(gpu->clk_shader))
>> +		return PTR_ERR(gpu->clk_shader);
>> +	gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
>> +
>> +	return 0;
>> +}
>> +
>>   static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
>>   {
>>   	int ret;
>>   
>> +	if (gpu->no_clk)
>> +		return 0;
>> +
> I don't see why this would be needed?
I have just tested, this do not needed.
> If your platform doesn't provide
> CONFIG_HAVE_CLK all those functions should be successful no-ops, so
> there is no need to special case this in the driver.

My platform do enable CONFIG_HAVE_CLK,

for ls3a5000 + ls7a1000, my system do not provide device tree support,

that's is to say, there is no DT support.


For ls3a4000 + ls7a1000 platform, the system has DT support, but don't 
has CLK drivers implement toward the clock tree.

typically, our platform's firmware will do such thing(setting a default 
working frequency).


When I first saw etnaviv, I'm also astonishing.

I don't know why there so much clock controllable.

As far as I can understand, my system/hardware have only one clock,

It shall corresponding to the core clk.

> Or does your platform in fact provide a clk subsystem, just the GPU
> clocks are managed by it?
>
> Also all those functions are fine with being called on a NULL clk, so
> shouldn't it be enough to simply avoid calling etnaviv_gpu_clk_get() in
> the PCI device case?
>
> Regards,
> Lucas
>
-- 
Jingfeng

