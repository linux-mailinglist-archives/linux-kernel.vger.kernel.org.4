Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804D2702989
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbjEOJvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240112AbjEOJvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:51:17 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B271FC2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:50:36 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id eea96ea3-f305-11ed-a9de-005056bdf889;
        Mon, 15 May 2023 12:50:33 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 15 May 2023 12:50:32 +0300
To:     Ryan.Wanner@microchip.com
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        Claudiu.Beznea@microchip.com
Subject: Re: GPIO set config argument value difference in pinconf and gpiolib
Message-ID: <ZGIAaPSycsmOq690@surfacebook>
References: <120117b6-feda-e7aa-4f09-a126a0747388@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120117b6-feda-e7aa-4f09-a126a0747388@microchip.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 15, 2023 at 08:21:35AM +0000, Ryan.Wanner@microchip.com kirjoitti:
> Hello,
> 
> I have a question about gpiochip_generic_config function. I noticed when
> calling this function the pin configuration is incorrect for
> push-pull/open-drain in pinctrl-at91-pio4. I traced this down to a
> argument value that is incorrect, this is extracted from the config
> using pinconf_to_config_argument. The pinctrl driver processes this
> config argument value correctly but when gpiolib calls this function
> that value is not passed causing the argument to be 0 in the function
> atmel_conf_pin_config_group_set. I see this same structure in other
> pinctrl drivers as well.
> 
> It seems that gpio_set_config is called which hard codes 0 into
> gpio_set_config_with_arugment function call making the argument 0 when
> passed into the pinctrl set config function.

Correct.

> It seems that the correct
> way would to mimic the gpio_set_bias function handling of this argument
> value. Doing a small local test seems to confirm my suggestion.

Nope. The driver developer(s) didn't get this correctly. The state
configuration are booleans, hence argument is ignored. It can be anything.

Seems they missed to add the switch to PUSH_PULL.

TL;DR: I'm pretty sure this is the bug in the above mentioned driver.

-- 
With Best Regards,
Andy Shevchenko


