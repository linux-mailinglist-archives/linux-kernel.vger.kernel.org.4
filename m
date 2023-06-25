Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A74873D532
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjFYXPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjFYXPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:15:01 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C14DE44;
        Sun, 25 Jun 2023 16:14:59 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687734897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QXB3ySiP1de3WZqGb+ujHYxIctkJUAMjkXFXMWV8wQw=;
        b=K6oEXDIIzo/uBtJGuZQTFMHpanMsRe1ukRJVKiWBxvXbYm2wdoBUr4KtoNxoflqg7AGjST
        BwPSXjMT84psoWjg3B5muVLSmXWuDTQRgSz+sFFA+jinEXlFbYyG6TBLMhQG9mdGezKRaS
        NYZBzrEM3/Eo4IjHnW/cW21Id+Js2vQnD3WQRxiHkyHVtxrWKJxSa7LLGe3Mxx1wscuUYd
        6fbpWn5YTj9iHvm9G0Fs9hMKUgJtpS5QBIhfJVwLsZbB19xnBeIoj8NhtAn7dpx1WCgaqA
        gcxpb3eMXvjodaQHIuolSWiL3Eg7T2ymE8jQs2M/zd/hgX+qFrUwlRB9R4ShSw==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A23391BF203;
        Sun, 25 Jun 2023 23:14:55 +0000 (UTC)
Date:   Mon, 26 Jun 2023 01:14:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] rtc: stm32: improve rtc precision
Message-ID: <20230625231454d53ad0e0@mail.local>
References: <20230615092753.323844-1-valentin.caron@foss.st.com>
 <20230615092753.323844-4-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615092753.323844-4-valentin.caron@foss.st.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 11:27:49+0200, Valentin Caron wrote:
> From: Christophe Guibout <christophe.guibout@foss.st.com>
> 
> The rtc is used to update the stgen counter on wake up from
> low power modes, so it needs to be as much accurate as possible.
> 
> The maximization of asynchronous divider leads to a 4ms rtc
> precision clock.
> By decreasing pred_a to 0, it will have pred_s=32767 (when
> need_accuracy is true), so stgen clock becomes more accurate
> with 30us precision.
> Nevertheless this will leads to an increase of power consumption.
> 
> Signed-off-by: Christophe Guibout <christophe.guibout@foss.st.com>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>  drivers/rtc/rtc-stm32.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
> index bd7a59a07537..cad88668bcfb 100644
> --- a/drivers/rtc/rtc-stm32.c
> +++ b/drivers/rtc/rtc-stm32.c
> @@ -114,6 +114,7 @@ struct stm32_rtc_data {
>  	void (*clear_events)(struct stm32_rtc *rtc, unsigned int flags);
>  	bool has_pclk;
>  	bool need_dbp;
> +	bool need_accuracy;
>  };
>  
>  struct stm32_rtc {
> @@ -545,6 +546,7 @@ static void stm32_rtc_clear_events(struct stm32_rtc *rtc,
>  static const struct stm32_rtc_data stm32_rtc_data = {
>  	.has_pclk = false,
>  	.need_dbp = true,
> +	.need_accuracy = false,
>  	.regs = {
>  		.tr = 0x00,
>  		.dr = 0x04,
> @@ -566,6 +568,7 @@ static const struct stm32_rtc_data stm32_rtc_data = {
>  static const struct stm32_rtc_data stm32h7_rtc_data = {
>  	.has_pclk = true,
>  	.need_dbp = true,
> +	.need_accuracy = false,
>  	.regs = {
>  		.tr = 0x00,
>  		.dr = 0x04,
> @@ -596,6 +599,7 @@ static void stm32mp1_rtc_clear_events(struct stm32_rtc *rtc,
>  static const struct stm32_rtc_data stm32mp1_data = {
>  	.has_pclk = true,
>  	.need_dbp = false,
> +	.need_accuracy = true,
>  	.regs = {
>  		.tr = 0x00,
>  		.dr = 0x04,
> @@ -636,11 +640,25 @@ static int stm32_rtc_init(struct platform_device *pdev,
>  	pred_a_max = STM32_RTC_PRER_PRED_A >> STM32_RTC_PRER_PRED_A_SHIFT;
>  	pred_s_max = STM32_RTC_PRER_PRED_S >> STM32_RTC_PRER_PRED_S_SHIFT;
>  
> -	for (pred_a = pred_a_max; pred_a + 1 > 0; pred_a--) {
> -		pred_s = (rate / (pred_a + 1)) - 1;
> +	if (rate > (pred_a_max + 1) * (pred_s_max + 1)) {
> +		dev_err(&pdev->dev, "rtc_ck rate is too high: %dHz\n", rate);

What is the expect user action after seeing this message?

> +		return -EINVAL;
> +	}
> +
> +	if (rtc->data->need_accuracy) {
> +		for (pred_a = 0; pred_a <= pred_a_max; pred_a++) {
> +			pred_s = (rate / (pred_a + 1)) - 1;
>  
> -		if (((pred_s + 1) * (pred_a + 1)) == rate)
> -			break;
> +			if (pred_s <= pred_s_max && ((pred_s + 1) * (pred_a + 1)) == rate)
> +				break;
> +		}
> +	} else {
> +		for (pred_a = pred_a_max; pred_a + 1 > 0; pred_a--) {
> +			pred_s = (rate / (pred_a + 1)) - 1;
> +
> +			if (((pred_s + 1) * (pred_a + 1)) == rate)
> +				break;
> +		}
>  	}
>  
>  	/*
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
