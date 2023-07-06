Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F35749C54
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjGFMqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjGFMq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:46:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784581BF9;
        Thu,  6 Jul 2023 05:45:58 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FEFB6606FDC;
        Thu,  6 Jul 2023 13:45:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688647520;
        bh=wWn6TJpPGJwpnJEW5eOYnGJj8SEgi8uRCntKKcZ2N54=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=feAJ7w3kphSYGpfQQAUINeYeVSxE9Ngfvmhl9z/y7dfTFoy1768rrwezjNtkr3apO
         O5uf9ofWRFJXIsZohnA/QqIfZ0qdZNdSHmdKTg2NqYflCnzvst2VG3lJchF9d5cQpw
         jfe/cWyyPn+kA9H3l8pSY/Krta7xx4tyZYgIlWYv46ZqGpSSVBXjk8LknPV0F6Lfub
         keCmq1z9CDF3vckMRKaJZoF0tApfmyYlAQKnt5nNyCFhrO83tJ1zFM4jLArLukt+mb
         eJqn8yggvHs+uaNc0/ITUSwng2g/teb5HMY+Y+GR2UKnyUEbdPMVwRYC1GNnMu/vFK
         E4kpJEhSsLscQ==
Message-ID: <152b6912-ce2f-5580-1e2a-550a6fd7e6ed@collabora.com>
Date:   Thu, 6 Jul 2023 14:45:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pwm: mtk_disp: fix disp_pwm coverity issue
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Shuijing Li <shuijing.li@mediatek.com>,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
References: <20230706100454.28998-1-shuijing.li@mediatek.com>
 <55c3a448-e6c6-5e04-2cee-b2a18f0033e3@baylibre.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <55c3a448-e6c6-5e04-2cee-b2a18f0033e3@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/07/23 14:29, Alexandre Mergnat ha scritto:
> 
> 
> On 06/07/2023 12:04, Shuijing Li wrote:
>> There is a coverity issue in the original mtk_disp_pwm_get_state()
>> function. In function call DIV64_U64_ROUND_UP, division by expression
>> Which may be zero has undefined behavior.
>> Fix this accordingly.
>>
>> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
>> ---
>>   drivers/pwm/pwm-mtk-disp.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
>> index 79e321e96f56..ca00058a6ef4 100644
>> --- a/drivers/pwm/pwm-mtk-disp.c
>> +++ b/drivers/pwm/pwm-mtk-disp.c
>> @@ -196,6 +196,14 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
>>           return err;
>>       }
>> +    rate = clk_get_rate(mdp->clk_main);
>> +    if (rate <= 0) {
>> +        dev_err(chip->dev, "Can't get rate: %pe\n", ERR_PTR(rate));
>> +        clk_disable_unprepare(mdp->clk_mm);
>> +        clk_disable_unprepare(mdp->clk_main);
>> +        return err;
>> +    }
>> +
>>       /*
>>        * Apply DISP_PWM_DEBUG settings to choose whether to enable or disable
>>        * registers double buffer and manual commit to working register before
>> @@ -206,7 +214,6 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
>>                        mdp->data->bls_debug_mask,
>>                        mdp->data->bls_debug_mask);
>> -    rate = clk_get_rate(mdp->clk_main);
>>       con0 = readl(mdp->base + mdp->data->con0);
>>       con1 = readl(mdp->base + mdp->data->con1);
>>       pwm_en = readl(mdp->base + DISP_PWM_EN);
> 
> IMHO, it should be done int the function `mtk_disp_pwm_apply` too.
> Do you agree ?
> 

I think that realistically this will never happen.

We're getting the clk_main clock's handle at probe time (or fail and get out),
then the PWM clock never has the CLK_GET_RATE_NOCACHE flag, as there wouldn't
be any reason to not cache the rates for this clock.
But even if we had the CLK_GET_RATE_NOCACHE flag, it wouldn't change much, as
our validation actually happens at probe time...

This means that our call to clk_get_rate is guaranteed to have a not NULL
pointer to this clock's `struct clk_core` and, unless the declaration of
this clock in the clock controller driver was wrong, for it, or for its
parent, the branch...

	if (!core->num_parents || core->parent)
		return core->rate;

...is always satisfied, so, in the end, this instance of clk_get_rate() can't
really return zero.
If you got such an issue, I suggest to check what the problem is, as it is
likely to be outside of this driver.


...that, besides the fact that the proposed code is incorrect, as clk_get_rate()
returns an `unsigned long`, so `rate` can never be less than zero, anyway.


Cheers,
Angelo
