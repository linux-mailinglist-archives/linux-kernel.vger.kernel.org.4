Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C97E6A2464
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBXWjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBXWjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:39:51 -0500
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DB219685
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:39:49 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 2319e286-b494-11ed-a2f4-005056bdd08f;
        Sat, 25 Feb 2023 00:39:45 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Sat, 25 Feb 2023 00:39:45 +0200
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpio: mmio: handle "ngpios" properly in bgpio_init()
Message-ID: <Y/k8sVtDhDiT1Iy3@surfacebook>
References: <20230224192021.22591-1-asmaa@nvidia.com>
 <CAHp75Vdz=P=HrjyhT=dQFJt0LmqzBG2Cmw=sCBmU-RCwkQ3uUw@mail.gmail.com>
 <CH2PR12MB3895688618F6465904E7ADD9D7A89@CH2PR12MB3895.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH2PR12MB3895688618F6465904E7ADD9D7A89@CH2PR12MB3895.namprd12.prod.outlook.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 24, 2023 at 09:31:23PM +0000, Asmaa Mnebhi kirjoitti:

...

> > The problem with this change is that you need to provide bgpio_bits.
> > 
> > So, if there is a property when bgpio_bits will be updated?
> > 
> > That's said what you need is something like this:
> > 1) split "ngpios" handling code (lines ~718-744 in gpiolib.c)  into a helper
> > function that is available inside drivers/gpio;
> > 2) use it in bgpio_init() by overriding bgpio_bits.
> > 
> > ret = new_helper();
> > if (ret)
> >     gc->bgpio_bits = sz * 8;
> > else
> >     ... = gc->ngpio;
> 
> So this new_helper() which reads the ngpios property, would be called from
> bgpio_init() and From gpiochip_add_data_with_key() correct? Since there are
> some drivers that don’t use bgpio_init().

Correct.

> Also, shouldn't "gc->bgpio_bits = = sz * 8;" be independent of new_helper()

Nope. You need to link them anyway.

> function?  "bgpio_bits" is described as "number of register bits used for a
> generic GPIO i.e. <register width> * 8" which seems different from "ngpio"
> described as "the number of GPIOs handled by this controller"

But you are right, this should be = round_up(gc->ngpio, 8); to match the logic
with sz.

-- 
With Best Regards,
Andy Shevchenko


