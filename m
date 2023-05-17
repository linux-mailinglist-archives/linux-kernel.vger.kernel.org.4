Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61BB706025
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjEQGdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjEQGdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:33:06 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED5363AAD;
        Tue, 16 May 2023 23:33:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 359608108;
        Wed, 17 May 2023 06:33:05 +0000 (UTC)
Date:   Wed, 17 May 2023 09:33:03 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Subject: Re: [PATCH v2 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Message-ID: <20230517063303.GO14287@atomide.com>
References: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
 <20230511-tps65219-add-gpio-support-v2-1-60feb64d649a@baylibre.com>
 <CACRpkdbjjoOoGeaqv9yQ4fTKqxt5eLDBjZCnNAYQnng3L+n8TQ@mail.gmail.com>
 <2e5cae40-7040-a92f-3d11-ce68f1307049@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e5cae40-7040-a92f-3d11-ce68f1307049@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* jerome Neanne <jneanne@baylibre.com> [230512 07:13]:
> 
> 
> On 11/05/2023 22:57, Linus Walleij wrote:
> > > +       /* Documentation is stating that GPIO0 direction must not be changed in Linux:
> > > +        * Table 8-34. MFP_1_CONFIG(3): MULTI_DEVICE_ENABLE,
> > > +        * Should only be changed in INITIALIZE state (prior to ON Request).
> > > +        * Set statically by NVM, changing direction in application can cause a hang.
> > > +        * Below can be used for test purpose only:
> > > +        */
> > > +
> > > +#if 0
> > > +       int ret = regmap_update_bits(gpio->tps->regmap, TPS65219_REG_MFP_1_CONFIG,
> > > +                                TPS65219_GPIO0_DIR_MASK, direction);
> > > +       if (ret)
> > > +               return ret;
> > > +#endif
> > > +       dev_err(gpio->tps->dev,
> > > +               "GPIO%d direction set by NVM, change to %u failed, not allowed by specification\n",
> > > +                offset, direction);
> > > +       return -EOPNOTSUPP;
> > > +}
> > 
> > Normally people would complain about #if 0 code.
> > 
> > But this is a special case!
> > 
> > I definitely want the code to be in there somehow.
> > 
> > What about:
> > 
> > if (IS_ENABLED(DEBUG))?
> > 
> > If someone enables debug with an explicit -DDEBUG to the compiler
> > this could be allowed.
> I'm fine with your proposal. Will wait few days just in case anyone wants to
> add any comment then go for this.

Just wondering.. Would it help for the driver probe to set gpio0 as a gpio
hog after reading the configured value?

Maybe the multi device enable just means the pin may be shared with no
specific hardware reason to not change it during the runtime?

Regards,

Tony

