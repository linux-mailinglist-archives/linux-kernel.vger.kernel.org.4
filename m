Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C405B6E116E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjDMPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjDMPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:50:01 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9F2977C;
        Thu, 13 Apr 2023 08:49:53 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DDcXxo015973;
        Thu, 13 Apr 2023 17:49:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=10v21qlgUMLfu5kPMNcmhdYRHZiJpyjT0L0dJsmLtvw=;
 b=v6OhYbbvrpPLx1JwxegMChOboBtJzz6Ylcpk0rKNJucPUsYQ9fGbD3rZjZvsLZRYgMaS
 n7rSO28G+PgKy6Cf/wXXzO4Msz4+5s4qAT42Fx8Fj8UzZqnz7/jIfMfabs2yVX/tf0OB
 cH1eIMCvtn7kXWBtR+mdOmNT4kzDwTk2AfKSvJYBwHnTU/oNblBWA6ydFj1CkHbu3KoE
 gdZ5k3T6A3ivRznb9021jFKHjzrnbqQOHFb47c9+mi+MaIoLZ3HcjZWusxDn+BihZQPD
 2l8Gyjjkt8iwP5LdmUpd5jkocIvnJHVt3iWCDj69TV78dTiKqj2SvHnxNE9bZLrDcUcT tA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pxf2qah42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 17:49:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F24BE10002A;
        Thu, 13 Apr 2023 17:49:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EACB9227885;
        Thu, 13 Apr 2023 17:49:23 +0200 (CEST)
Received: from [10.48.1.102] (10.48.1.102) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 13 Apr
 2023 17:49:22 +0200
Message-ID: <434b4497-0dd4-4818-b4f7-f57264d8b2a7@foss.st.com>
Date:   Thu, 13 Apr 2023 17:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] counter: stm32-timer-cnt: Reset TIM_TISEL and TIM_SMCR to
 their default value
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        William Breathitt Gray <william.gray@linaro.org>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>,
        Lee Jones <lee@kernel.org>, <linux-iio@vger.kernel.org>
References: <20230412153709.3557323-1-u.kleine-koenig@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20230412153709.3557323-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_11,2023-04-13_01,2023-02-09_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 17:37, Uwe Kleine-König wrote:
> The driver assumes that the input selection register (TIM_TISEL) is at
> its reset default value. Usually this is the case, but the bootloader
> might have modified it. Also reset the SMCR register while at it.
> 
> This bases on the effectively same patch submitted by Olivier Moysan for
> pwm-stm32.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> note that the patch by Olivier Moysan[1] for pwm-stm32 is expected to
> appear in Thierry's tree soon. It added the definition of TIM_TISEL in
> the same way, so the two patches should merge just fine. Alternatively
> you can commit it to a tree that already has the pwm change (and then
> drop the change to include/linux/mfd/stm32-timers.h from this one).
> 
> Best regards
> Uwe
> 
> [1] https://lore.kernel.org/linux-pwm/20221213102707.1096345-1-olivier.moysan@foss.st.com
> 
>  drivers/counter/stm32-timer-cnt.c | 4 ++++
>  include/linux/mfd/stm32-timers.h  | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 9bf20a5d6bda..d001d77f17ac 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -342,6 +342,10 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, priv);
>  
> +	/* Reset input selector to its default input and disable slave mode */
> +	regmap_write(priv->regmap, TIM_TISEL, 0x0);
> +	regmap_write(priv->regmap, TIM_SMCR, 0x0);

Hi Uwe,

Just on SMCR: the function_write routine will take care of setting it
depending on the count function (increase, encoder mode...). So it looks
like useless to disable slave mode during probe.
Could it be removed ?

With that, you can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com

Best Regards,
Fabrice

> +
>  	/* Register Counter device */
>  	ret = devm_counter_add(dev, counter);
>  	if (ret < 0)
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index 5f5c43fd69dd..1b94325febb3 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -31,6 +31,7 @@
>  #define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
>  #define TIM_DCR		0x48	/* DMA control register    */
>  #define TIM_DMAR	0x4C	/* DMA register for transfer */
> +#define TIM_TISEL	0x68	/* Input Selection         */
>  
>  #define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
>  #define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */
> 
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
