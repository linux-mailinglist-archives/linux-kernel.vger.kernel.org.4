Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3546F7267DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjFGR5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjFGR5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:57:52 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF1D1FC2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:57:49 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id c846300f-055c-11ee-b972-005056bdfda7;
        Wed, 07 Jun 2023 20:57:35 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 7 Jun 2023 20:57:34 +0300
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        linus.walleij@linaro.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: npcm7xx: Add missing check for ioremap
Message-ID: <ZIDFDgcM07aPlzoB@surfacebook>
References: <20230607095829.1345-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607095829.1345-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jun 07, 2023 at 05:58:29PM +0800, Jiasheng Jiang kirjoitti:
> Add check for ioremap() and return the error if it fails in order to
> guarantee the success of ioremap().

This one is correct, otherwise the GPIO is not functional at all.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> index 21e61c2a3798..843ffcd96877 100644
> --- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> +++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> @@ -1884,6 +1884,8 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
>  		}
>  
>  		pctrl->gpio_bank[id].base = ioremap(res.start, resource_size(&res));
> +		if (!pctrl->gpio_bank[id].base)
> +			return -EINVAL;
>  
>  		ret = bgpio_init(&pctrl->gpio_bank[id].gc, dev, 4,
>  				 pctrl->gpio_bank[id].base + NPCM7XX_GP_N_DIN,

-- 
With Best Regards,
Andy Shevchenko


