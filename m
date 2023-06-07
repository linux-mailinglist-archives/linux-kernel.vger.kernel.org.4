Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEE2726340
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbjFGOtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjFGOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:49:10 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2383392
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:49:09 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 7314a8b2-0542-11ee-b3cf-005056bd6ce9;
        Wed, 07 Jun 2023 17:49:05 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 7 Jun 2023 17:49:05 +0300
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     andy.shevchenko@gmail.com, oe-kbuild-all@lists.linux.dev,
        linus.walleij@linaro.org, brgl@bgdev.pl, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-gpio@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] gpio: ath79: Add missing check for platform_get_irq
Message-ID: <ZICY4dTgZZGpiDPY@surfacebook>
References: <20230607070819.48553-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607070819.48553-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jun 07, 2023 at 03:08:19PM +0800, Jiasheng Jiang kirjoitti:
> On Tue, 6 Jun 2023 17:46:36 +0800 Andy Shevchenko wrote:
> > Tue, Jun 06, 2023 at 12:28:17PM +0300, andy.shevchenko@gmail.com kirjoitti:
> >> Tue, Jun 06, 2023 at 11:18:41AM +0800, Jiasheng Jiang kirjoitti:

...

> >> > Add the missing check for platform_get_irq() and return error
> >> > if it fails.
> >> > The returned error code will be dealed with in
> >> > module_platform_driver(ath79_gpio_driver) and the driver will not
> >> > be registered.
> >> 
> >> No, this functional change and has not to be for the fixes unless _this_ is the
> >> regression you are fixing. Did the driver work before at some point as after
> >> this change?
> 
> I will remove the fixes tag in v4.
> 
> > To be more clear, answer to the following questions:
> > 1) does driver work with wrong DT configuration?
> > 2a) if yes, does it make sense, i.e. the hardware functioning usefully?
> > 2b) if yes, can we guarantee there are no broken configurations in the wild?
> > 
> > Depending on the answers correct your code and/or commit message.

The above is a list of the questions you need to investigate.
(Note, it takes several minutes on elixir.bootlin.com to check
 some of this, but I'm not the author of the code)

> >> Otherwise you have to _justify_ that this functional change won't break
> >> existing setups (with broked IRQ in Device Tree, for example).
> 
> Sorry, I do not quite understand what you mean.
> I have no idea how these questions are related to my patch.

The IRQ is usually provided by Device Tree or ACPI (here is DT only case).
Then the platform code converts that to resource which this driver consumes.
That resource is used when instantiating GPIO (IRQ) chip.

> Do you mean I should not fail the ->probe() if there is wrong IRQ numbering in the DT?

I don't know. The commit message of your change should elaborate this.

> Please tell me the relationship between these questions and my patch.

The tight relationship. The patch changes the flow. Either
you shouldn't do that, or be aware and explain why it's not
a problem. Or get it done differently.

-- 
With Best Regards,
Andy Shevchenko


