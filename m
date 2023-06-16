Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABCC732510
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbjFPCMa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 22:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFPCM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:12:28 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC372965;
        Thu, 15 Jun 2023 19:12:24 -0700 (PDT)
X-QQ-mid: Yeas50t1686881504t089t25183
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.159.171.58])
X-QQ-SSF: 00400000000000F0FPF000000000000
From:   =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6584627287116177339
To:     "'Andy Shevchenko'" <andy.shevchenko@gmail.com>,
        "'Michael Walle'" <michael@walle.cc>
Cc:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <shreeya.patel@collabora.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230607081803.778223-1-jiawenwu@trustnetic.com> <CAHp75Vdbq3uHOyrfT-KFYRSj6v+s9GgOQjQ9a8mGn-4HSCpB9Q@mail.gmail.com> <15e2fc098a1e63317368f4812290ca35@walle.cc> <010401d99f6f$26d41600$747c4200$@trustnetic.com> <b9af98d801d2808de3460c9e4fec8bdd@walle.cc> <CAHp75VcgAhaSARXMnRzsDE3x57AjnwS6Ep25Mz7SnizUccG6BA@mail.gmail.com>
In-Reply-To: <CAHp75VcgAhaSARXMnRzsDE3x57AjnwS6Ep25Mz7SnizUccG6BA@mail.gmail.com>
Subject: RE: [PATCH v2] gpiolib: Fix GPIO chip IRQ initialization restriction
Date:   Fri, 16 Jun 2023 10:11:43 +0800
Message-ID: <012b01d99ff7$e51075e0$af3161a0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJryWnquP8Y9u98p8GNjzLx69HVGQGrRNiSAZtbv08BxPTBjAH/YNofAf5b6aOuIA5BEA==
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

On Thursday, June 15, 2023 9:56 PM, Andy Shevchenko wrote:
> On Thu, Jun 15, 2023 at 1:45 PM Michael Walle <michael@walle.cc> wrote:
> > > BTW, I wonder if it has problems when unregistering gpio-regmap.
> > > Call Trace of irq_domain_remove() always exits in my test:
> > > https://lore.kernel.org/all/011c01d98d3d$99e6c6e0$cdb454a0$@trustnetic.com/
> > >
> > > Of course, it could be because there was something wrong with my
> > > test code. But I want to be clear about this.
> >
> > Mh, you've said you don't use the devm_ variant of
> > regmap_add_irq_chip(),
> > correct? Do you call regmap_del_irq_chip() yourself?

Yes, devm_regmap_del_irq_chip() also led to a call trace. I thought it
might be the order of release, so I called it myself without devm_.

> > It seems that gpiolib is already removing the domain itself. Mh.
> > I guess if the the domain is set via gpiochip_irqchip_add_domain()
> > gpiolib must not call irq_domain_remove() because the domain resource
> > is handled externally (i.e. gpiolib doesn't allocate the domain
> > itself) in our case.
> >
> > Nice finding! Looks like it has been broken since the beginning
> > when I've introduced the gpiochip_irqchip_add_domain(). Will you
> > do another fixes patch for that? 

I used to be rough at fixing in my test, I tried to set gc->irq.domain = NULL
after calling irq_domain_remove() in gpiochip_irqchip_remove(). But
there seemed to be some other issue that was causing my device to not
work, so I didn't go further. I wonder what risks such fix introduces.

Sorry I may not be able to do the fix patch for a while. I'm working on
other patches, this test will disrupt my work.

> > I'm not sure where to store
> > that information though. Maybe a new bool "no_domain_free"
> > in struct gpio_irq_chip?
> 
> While reading this I also thought about flag, but please use positive
> notation, e.g. "irq_domain_is_ext".


