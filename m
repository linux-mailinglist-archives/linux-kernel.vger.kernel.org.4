Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB90E731497
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbjFOJyj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 05:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245692AbjFOJyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:54:16 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6F92D61;
        Thu, 15 Jun 2023 02:53:42 -0700 (PDT)
X-QQ-mid: Yeas50t1686822773t395t65381
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.159.171.58])
X-QQ-SSF: 00400000000000F0FPF000000000000
From:   =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8017873442922814828
To:     "'Michael Walle'" <michael@walle.cc>,
        "'Andy Shevchenko'" <andy.shevchenko@gmail.com>
Cc:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <shreeya.patel@collabora.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230607081803.778223-1-jiawenwu@trustnetic.com> <CAHp75Vdbq3uHOyrfT-KFYRSj6v+s9GgOQjQ9a8mGn-4HSCpB9Q@mail.gmail.com> <15e2fc098a1e63317368f4812290ca35@walle.cc>
In-Reply-To: <15e2fc098a1e63317368f4812290ca35@walle.cc>
Subject: RE: [PATCH v2] gpiolib: Fix GPIO chip IRQ initialization restriction
Date:   Thu, 15 Jun 2023 17:52:52 +0800
Message-ID: <010401d99f6f$26d41600$747c4200$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJryWnquP8Y9u98p8GNjzLx69HVGQGrRNiSAZtbv0+uTRIGMA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 15, 2023 5:26 PM, Michael Walle wrote:
> Am 2023-06-07 16:12, schrieb Andy Shevchenko:
> > +Cc: Michael
> >
> > On Wed, Jun 7, 2023 at 11:20 AM Jiawen Wu <jiawenwu@trustnetic.com>
> > wrote:
> >>
> >> In case of gpio-regmap, IRQ chip is added by regmap-irq and associated
> >> with
> >> GPIO chip by gpiochip_irqchip_add_domain(). The initialization flag
> >> was not
> >> added in gpiochip_irqchip_add_domain(), causing gpiochip_to_irq() to
> >> return
> >> -EPROBE_DEFER.
> >
> > Makes sense to me.
> > FWIW,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > But it would be nice to hear from Michael about this.
> 
> Thanks for bringing this to my attention. In fact, currently
> my sl28cpld is broken due to this. So:

Thanks for your test, it's exciting for me to actually fix a bug.

BTW, I wonder if it has problems when unregistering gpio-regmap.
Call Trace of irq_domain_remove() always exits in my test:
https://lore.kernel.org/all/011c01d98d3d$99e6c6e0$cdb454a0$@trustnetic.com/

Of course, it could be because there was something wrong with my
test code. But I want to be clear about this.

> 
> Reviewed-by: Michael Walle <michael@walle.cc>
> Tested-by: Michael Walle <michael@walle.cc> # on kontron-sl28
> 
> >> Fixes: 5467801f1fcb ("gpio: Restrict usage of GPIO chip irq members
> >> before initialization")
> >> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> -michael
> 

