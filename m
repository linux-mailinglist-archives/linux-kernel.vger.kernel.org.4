Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798626E9177
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjDTLDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjDTLDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:03:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD267294;
        Thu, 20 Apr 2023 04:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0F65647AF;
        Thu, 20 Apr 2023 11:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1A5C433EF;
        Thu, 20 Apr 2023 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681988477;
        bh=40BVpmsumFk3aPJFU2dLAwtHIV2znVDn+AorQnPvg6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwc9h8CxmHsWH284LQ5Y9kjXKGF9zPhi6pLlHfED54eNbX2FmxNVsemhJ7eirXBc/
         5AgxzXtlUt+BHop476+JBDh9JGzRVvm6iNmwxq4ShniCA3ivmFTRHvNYAA2uwItmgN
         Imwzc8LZwYlUoE+V5dpZj30PkfNPvNFQxH8hnoOzDnEvkaszH7gVrr/zq5p5jyFBdK
         FhQpbGbSnalKu7k0vRBI+XQzzAgwoIqoMKVQHVFY1eczA3whwPW2MUGDSz7hLuCTtO
         SJqSA0go6sPOd3AK7Hu42fdk3MNzJCt0HYfU3FAeoBRkGzLEvBJUCqOMrCOtMD7WPw
         HYj+dYmI5SCvA==
Date:   Thu, 20 Apr 2023 12:01:11 +0100
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-timer-cnt: Reset TIM_TISEL and TIM_SMCR
 to their default value
Message-ID: <20230420110111.GM9904@google.com>
References: <20230412153709.3557323-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230412153709.3557323-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023, Uwe Kleine-König wrote:

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

Acked-by: Lee Jones <lee@kernel.org>

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
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
