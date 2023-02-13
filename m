Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83A6954DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjBMXju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBMXjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:39:48 -0500
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A29FCA2E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:39:40 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id ace8a4f6-abf7-11ed-aae9-005056bdfda7;
        Tue, 14 Feb 2023 01:39:38 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Tue, 14 Feb 2023 01:39:36 +0200
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] Support NVIDIA BlueField-3 GPIO controller
Message-ID: <Y+rKOEV/3PnrB/Dl@surfacebook>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <c1bf45a868edcd3df5263fa76a32b28e6c9ca3d1.1676042188.git.asmaa@nvidia.com>
 <Y+eBRLB0Q38vGtjR@smile.fi.intel.com>
 <CH2PR12MB389571F58AE1F8BF2196DC10D7DD9@CH2PR12MB3895.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB389571F58AE1F8BF2196DC10D7DD9@CH2PR12MB3895.namprd12.prod.outlook.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 13, 2023 at 11:14:06PM +0000, Asmaa Mnebhi kirjoitti:
> Thanks Andy for the feedback! Will address your comment in v4.
> 
> > +		generic_handle_irq(irq_find_mapping(gc->irq.domain, level));
> 
> There is a helper that unites these two calls together.
> 
> I didn't find any helper in v6.2. Could you please point me to it?

It's available even longer than just in v6.2:
generic_handle_domain_irq().

...

> > +static int mlxbf3_gpio_init_valid_mask(struct gpio_chip *gc,
> > +				       unsigned long *valid_mask,
> > +				       unsigned int ngpios)
> > +{
> > +	struct mlxbf3_gpio_context *gs = gpiochip_get_data(gc);
> > +
> > +	*valid_mask = gs->valid_mask;
> > +
> > +	return 0;
> > +}
> 
> Why do you need this?
> 
> Since we only use ACPI tables and we want user space (libgpiod tool) or possibly (in the future)
> other kernel drivers to have access to certain GPIO pins, we use this valid_mask to do so.
> Linus previously explained that if we ask for a GPIO then it will be muxed in using .gpio_request_enable().
> And so we would use .valid_mask to restrict the use of certain gpios.

So, why you can't use gpio-reserved-ranges property?

-- 
With Best Regards,
Andy Shevchenko


