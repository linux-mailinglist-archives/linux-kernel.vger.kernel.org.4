Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC56B7879
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCMNJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCMNJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:09:17 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6447133447;
        Mon, 13 Mar 2023 06:09:14 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 5482520B16;
        Mon, 13 Mar 2023 14:09:12 +0100 (CET)
Date:   Mon, 13 Mar 2023 14:09:08 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 2/2] gpio: fxl6408: add I2C GPIO expander driver
Message-ID: <ZA8gdHWzRx73by5u@francesco-nb.int.toradex.com>
References: <20230313113308.157930-1-francesco@dolcini.it>
 <20230313113308.157930-3-francesco@dolcini.it>
 <CAHp75VePJ76nhwX-1cyo-uD=2+w4dbyGNhazJzKkkQOfDma6aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VePJ76nhwX-1cyo-uD=2+w4dbyGNhazJzKkkQOfDma6aQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 02:24:47PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 13, 2023 at 1:33 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> > +config GPIO_FXL6408
> > +       tristate "FXL6408 I2C GPIO expander"
> > +       select GPIO_REGMAP
> 
> > +       select REGMAP_I2C
> 
> Somebody pointed out that this might require
> 
>     depends on I2C
> 
> being added as well.

This is already there, I would prefer to not duplicate it neither do it
differently from all the other I2C GPIO drivers.

menu "I2C GPIO expanders"
	depends on I2C

> > +#define FXL6408_MAX_REGISTER           0x13
> 
> This is used as a range, but why? If we can have a proper name for
> this register, why bother dumping all this or even having access to?

So, I see 2 options:
1. Use FXL6408_REG_INPUT_STATUS instead of FXL6408_MAX_REGISTER
2. #define FXL6408_REG_INT_STS 0x13 and use it instead

I think that there are trivial benefits on both, with option 2 being the
correct hardware description and that would not need to be changed when adding
additional functionalities to the driver.

Which solution do we prefer for v3?
My preference would be to define FXL6408_REG_INT_STS and use it instead.

Francesco

