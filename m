Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F6B630D1F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 09:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKSIFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 03:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiKSIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 03:05:37 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750DB6DFC8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 00:05:34 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id wIquoyL42zQOKwIquoElgP; Sat, 19 Nov 2022 09:05:32 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Nov 2022 09:05:32 +0100
X-ME-IP: 86.243.100.34
Message-ID: <ef3c1a62-029e-ffae-8a37-fde35a8235d5@wanadoo.fr>
Date:   Sat, 19 Nov 2022 09:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] rtc: msc313: Fix function prototype mismatch in
 msc313_rtc_probe()
Content-Language: fr, en-GB
To:     Kees Cook <keescook@chromium.org>, Daniel Palmer <daniel@thingy.jp>
Cc:     kernel test robot <lkp@intel.com>,
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
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221118233101.never.215-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/11/2022 à 00:31, Kees Cook a écrit :
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed.
> 
> msc313_rtc_probe() was passing clk_disable_unprepare() directly, which
> did not have matching prototypes for devm_add_action_or_reset()'s callback
> argument. Add a wrapper and remove the cast.
> 
> This was found as a result of Clang's new -Wcast-function-type-strict
> flag, which is more sensitive than the simpler -Wcast-function-type,
> which only checks for type width mismatches.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202211041527.HD8TLSE1-lkp@intel.com
> Cc: Daniel Palmer <daniel@thingy.jp>
> Cc: Romain Perier <romain.perier@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rtc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/rtc/rtc-msc313.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-msc313.c b/drivers/rtc/rtc-msc313.c
> index f3fde013c4b8..36e3e77f303e 100644
> --- a/drivers/rtc/rtc-msc313.c
> +++ b/drivers/rtc/rtc-msc313.c
> @@ -177,6 +177,13 @@ static irqreturn_t msc313_rtc_interrupt(s32 irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> +static void msc313_clk_disable_unprepare(void *data)
> +{
> +	struct clk *clk = data;
> +
> +	clk_disable_unprepare(clk);
> +}
> +
>   static int msc313_rtc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -224,7 +231,7 @@ static int msc313_rtc_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	ret = devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare, clk);
> +	ret = devm_add_action_or_reset(dev, msc313_clk_disable_unprepare, clk);
>   	if (ret)
>   		return ret;
>   

Hi,

another way to fix it, is to use devm_clk_get_enabled().

It removes some LoC instead of introducing some new ones and saves a few 
bytes of memory.

CJ

