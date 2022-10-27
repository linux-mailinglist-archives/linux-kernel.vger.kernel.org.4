Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F560F21E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiJ0IUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbiJ0IUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:20:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A2FC2FC10;
        Thu, 27 Oct 2022 01:20:25 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8CxrrdIP1pj8dUCAA--.5816S3;
        Thu, 27 Oct 2022 16:20:24 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9VZHP1pjcbAFAA--.2365S2;
        Thu, 27 Oct 2022 16:20:24 +0800 (CST)
Subject: Re: [PATCH v3 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, zhuyinbo@loongson.cn,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20221024014209.5327-1-zhuyinbo@loongson.cn>
 <a5a5c18f-476c-2f45-8cd0-3c88b3aa509d@linaro.org>
 <841bad76-e19c-e400-e46a-2a83986c29eb@loongson.cn>
 <9dfb7434-dd62-64e8-7831-b797687827e7@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <542e661c-5aa3-a855-889f-6deb8a74584f@loongson.cn>
Date:   Thu, 27 Oct 2022 16:20:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9dfb7434-dd62-64e8-7831-b797687827e7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx9VZHP1pjcbAFAA--.2365S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KF1fWry5GF45JFyUuFW3KFg_yoW8tF15pr
        Z3Ja1qkF4UGr10g34IqwnYqrn2kr4UtF43Xr1fW3yxuas8JFy7JFWUGF1jkrn5C34kAr4U
        Xr4YgayYyF45Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x
        8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8I_M7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/26 下午10:11, Krzysztof Kozlowski 写道:
> On 26/10/2022 02:40, Yinbo Zhu wrote:
>>
>>
>> 在 2022/10/26 上午12:07, Krzysztof Kozlowski 写道:
>>> On 23/10/2022 21:42, Yinbo Zhu wrote:
>>>> The loongson2 SoC has a few pins that can be used as GPIOs or take
>>>> multiple other functions. Add a driver for the pinmuxing.
>>>>
>>>> There is currently no support for GPIO pin pull-up and pull-down.
>>>
>>> Thank you for your patch. There is something to discuss/improve.
>>>
>>>> +static const struct pinmux_ops loongson2_pmx_ops = {
>>>> +	.set_mux = loongson2_pmx_set_mux,
>>>> +	.get_functions_count = loongson2_pmx_get_funcs_count,
>>>> +	.get_function_name = loongson2_pmx_get_func_name,
>>>> +	.get_function_groups = loongson2_pmx_get_groups,
>>>> +};
>>>> +
>>>> +static int loongson2_pinctrl_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct device *dev = &pdev->dev;
>>>> +	struct loongson2_pinctrl *pctrl;
>>>> +	struct resource *res;
>>>> +
>>>> +	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
>>>> +	if (!pctrl)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +	pctrl->reg_base = devm_ioremap_resource(dev, res);
>>>
>>> This is still not fixed.
>> sorry, I don't get your meaning about "Use combined helper for this."
>> please you tell me more specific.
> 
> So you ignored the feedback? That's not how review process works. You
> either implement the feeedback or ask questions. Ignoring it is not
> acceptable.
You can find these code has a change in this code conext.  I have a 
feedback on this code.  but I mistakenly thought helper is dev_err_probe.
         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
         pctrl->reg_base = devm_ioremap_resource(dev, res);
         if (IS_ERR(pctrl->reg_base))
-               return PTR_ERR(pctrl->reg_base);
+               return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->reg_base),
+                               "unable to map I/O memory");

         raw_spin_lock_init(&pctrl->lock);

> 
> There is a helper combining two calls into one. Grep for it in headers
> and use it.
> 
You said is that use "devm_platform_get_and_ioremap_resource" as a 
helper? sorry, I will do it.
> Best regards,
> Krzysztof
> 

