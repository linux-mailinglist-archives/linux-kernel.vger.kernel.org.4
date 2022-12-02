Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54B2640C9C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiLBRyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiLBRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:54:14 -0500
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EDDC2D39
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:54:12 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 1AEhpL49Pb9QW1AEhp4Yhx; Fri, 02 Dec 2022 18:54:10 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 Dec 2022 18:54:10 +0100
X-ME-IP: 86.243.100.34
Message-ID: <4bef43c9-1ba9-6739-07be-2a819ee01091@wanadoo.fr>
Date:   Fri, 2 Dec 2022 18:54:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] rtc: msc313: Fix function prototype mismatch in
 msc313_rtc_probe()
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Palmer <daniel@thingy.jp>,
        kernel test robot <lkp@intel.com>,
        Romain Perier <romain.perier@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20221118233101.never.215-kees@kernel.org>
 <ef3c1a62-029e-ffae-8a37-fde35a8235d5@wanadoo.fr>
 <202212012043.C4ED0824@keescook>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <202212012043.C4ED0824@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/12/2022 à 05:46, Kees Cook a écrit :
> On Sat, Nov 19, 2022 at 09:05:28AM +0100, Christophe JAILLET wrote:
>> Le 19/11/2022 à 00:31, Kees Cook a écrit :
>>> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
>>> indirect call targets are validated against the expected function
>>> pointer prototype to make sure the call target is valid to help mitigate
>>> ROP attacks. If they are not identical, there is a failure at run time,
>>> which manifests as either a kernel panic or thread getting killed.
>>>
>>> msc313_rtc_probe() was passing clk_disable_unprepare() directly, which
>>> did not have matching prototypes for devm_add_action_or_reset()'s callback
>>> argument. Add a wrapper and remove the cast.
>>>
>>> This was found as a result of Clang's new -Wcast-function-type-strict
>>> flag, which is more sensitive than the simpler -Wcast-function-type,
>>> which only checks for type width mismatches.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Link: https://lore.kernel.org/lkml/202211041527.HD8TLSE1-lkp@intel.com
>>> Cc: Daniel Palmer <daniel@thingy.jp>
>>> Cc: Romain Perier <romain.perier@gmail.com>
>>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-rtc@vger.kernel.org
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>    drivers/rtc/rtc-msc313.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/rtc/rtc-msc313.c b/drivers/rtc/rtc-msc313.c
>>> index f3fde013c4b8..36e3e77f303e 100644
>>> --- a/drivers/rtc/rtc-msc313.c
>>> +++ b/drivers/rtc/rtc-msc313.c
>>> @@ -177,6 +177,13 @@ static irqreturn_t msc313_rtc_interrupt(s32 irq, void *dev_id)
>>>    	return IRQ_HANDLED;
>>>    }
>>> +static void msc313_clk_disable_unprepare(void *data)
>>> +{
>>> +	struct clk *clk = data;
>>> +
>>> +	clk_disable_unprepare(clk);
>>> +}
>>> +
>>>    static int msc313_rtc_probe(struct platform_device *pdev)
>>>    {
>>>    	struct device *dev = &pdev->dev;
>>> @@ -224,7 +231,7 @@ static int msc313_rtc_probe(struct platform_device *pdev)
>>>    		return ret;
>>>    	}
>>> -	ret = devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare, clk);
>>> +	ret = devm_add_action_or_reset(dev, msc313_clk_disable_unprepare, clk);
>>>    	if (ret)
>>>    		return ret;
>>
>> Hi,
>>
>> another way to fix it, is to use devm_clk_get_enabled().
>>
>> It removes some LoC instead of introducing some new ones and saves a few
>> bytes of memory.
> 
> Hrm, I'm not familiar with the clk stuff here -- how do I use it? Should
> it just be like this? (The NULL argument is ok?)

Yes, the code below looks fine.
NULL argument is ok.

See [1]. Both function are very similar. devm_clk_get_enabled() just 
pass some additional init() and exit() functions.

CJ


[1]: 
https://elixir.bootlin.com/linux/v6.1-rc7/source/drivers/clk/clk-devres.c#L63
> 
> diff --git a/drivers/rtc/rtc-msc313.c b/drivers/rtc/rtc-msc313.c
> index f3fde013c4b8..8d7737e0e2e0 100644
> --- a/drivers/rtc/rtc-msc313.c
> +++ b/drivers/rtc/rtc-msc313.c
> @@ -212,22 +212,12 @@ static int msc313_rtc_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	clk = devm_clk_get(dev, NULL);
> +	clk = devm_clk_get_enabled(dev, NULL);
>   	if (IS_ERR(clk)) {
>   		dev_err(dev, "No input reference clock\n");
>   		return PTR_ERR(clk);
>   	}
>   
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable the reference clock, %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare, clk);
> -	if (ret)
> -		return ret;
> -
>   	rate = clk_get_rate(clk);
>   	writew(rate & 0xFFFF, priv->rtc_base + REG_RTC_FREQ_CW_L);
>   	writew((rate >> 16) & 0xFFFF, priv->rtc_base + REG_RTC_FREQ_CW_H);
> 

