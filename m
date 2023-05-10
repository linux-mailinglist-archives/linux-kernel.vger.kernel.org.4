Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04AC6FDFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbjEJOPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbjEJOPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:15:45 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021EE2D40
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:15:42 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 23a0e2df-ef3d-11ed-b972-005056bdfda7;
        Wed, 10 May 2023 17:15:40 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 10 May 2023 17:15:38 +0300
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pinctrl: axp209: Add support for GPIO3 on the
 AXP209
Message-ID: <ZFunCnXldqEMFYaE@surfacebook>
References: <cover.1681580558.git.noodles@earth.li>
 <cover.1683719613.git.noodles@earth.li>
 <f9b643ff0d0ed770f5a841111f213f8481dc920f.1683719613.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9b643ff0d0ed770f5a841111f213f8481dc920f.1683719613.git.noodles@earth.li>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, May 10, 2023 at 01:01:27PM +0100, Jonathan McDowell kirjoitti:
> The AXP209 device has a 4th GPIO which has a slightly different register
> setup, where the control + status bits are held in a single register
> rather than sharing AXP20X_GPIO20_SS with GPIOs 0-2.

...

> +#define AXP20X_GPIO3_FUNCTIONS		(BIT(2) | BIT(1))

GENMASK() ?

...


> +#define AXP20X_GPIO3_FUNCTION_OUT_LOW	0
> +#define AXP20X_GPIO3_FUNCTION_OUT_HIGH	BIT(1)
> +#define AXP20X_GPIO3_FUNCTION_INPUT	BIT(2)

Seems mixed use of decimal and bitwise values, switch to decimal, since it
makes more sense in my opinion.

...

> +	if (offset == 3) {
> +		ret = regmap_read(pctl->regmap, AXP20X_GPIO3_CTRL, &val);
> +		if (ret)
> +			return ret;
> +		if (val & AXP20X_GPIO3_FUNCTION_INPUT)
> +			return GPIO_LINE_DIRECTION_IN;

> +		else

Redundant 'else'.

> +			return GPIO_LINE_DIRECTION_OUT;
> +	}


-- 
With Best Regards,
Andy Shevchenko


