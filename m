Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562556B7512
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCMLCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCMLCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:02:15 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784AB3644C;
        Mon, 13 Mar 2023 04:02:02 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 218BEC0018;
        Mon, 13 Mar 2023 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678705320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KAu5eb5cBM2N0TFrpHaTmeciWLo9iKA5Z5jW5dA0qRM=;
        b=EYM8Zc5ZL7e06LhrgrC9uRPTpRu53MWxRGT+Mr7yC8ny1mCmyi4AsrYABcg5Yc94SppL5A
        BCSL08OjV9F5n87md8ab/rHDU3x1dccJ9xEc0CiOU9lGdo2hx+DP0Yy7gw1SQEf0iRP4sE
        w4gAtqa9JCXHB6DRG/eyqYuEUJjr0TgCcRsMELvTodgC1/oEriv789FY9NV82WV86mXuU0
        dll5QV54bF1EVCASZnRrLbwDVd3m4rX0Jgt58ZCnGBFajMKeCytFAnxpFK3uNEDgV0ZAWW
        A7jFjDdYu11lP1DAT4csoHyV1K/6KpY96XkL2ToQnL0B4ma502MVOXNKf4EjXg==
Date:   Mon, 13 Mar 2023 12:01:58 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com
Subject: Re: [PATCH INTERNAL v1 1/3] rtc: tps6594: add driver for TPS6594
 PMIC RTC
Message-ID: <20230313110158f5c27b63@mail.local>
References: <20230224133129.887203-1-eblanc@baylibre.com>
 <20230224133129.887203-2-eblanc@baylibre.com>
 <ZAcbJxrNtWTTTSjR@mail.local>
 <CR556BV2M4I4.2L3LLJ8V1I352@burritosblues>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CR556BV2M4I4.2L3LLJ8V1I352@burritosblues>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 10:18:45+0100, Esteban Blanc wrote:
> On Tue Mar 7, 2023 at 12:08 PM CET, Alexandre Belloni wrote:
> > On 24/02/2023 14:31:27+0100, Esteban Blanc wrote:
> > > +struct tps6594_rtc {
> > > +   struct rtc_device *rtc;
> > > +};
> >
> > Is the struct actually useful?
> 
> Good catch, it's not. I will remove it for V2.
> 
> (...)
> 
> > > +/*
> > > + * Gets current tps6594 RTC time and date parameters.
> > > + *
> > > + * The RTC's time/alarm representation is not what gmtime(3) requires
> > > + * Linux to use:
> > > + *
> > > + *  - Months are 1..12 vs Linux 0-11
> > > + *  - Years are 0..99 vs Linux 1900..N (we assume 21st century)
> > > + */
> >
> > I don't find this comment to be particularly useful.
> 
> Ok. I propose that I add 2 constants for the -1 and +100 in the month and year
> calculation. This way, without the comment the computation would be a
> bit more self explanatory.
> What do you think?

I don't think this is necessary, keep -1 for the month and +100 for the
year, those are very common operations in the subsystem and don't really
need any explanation

> 
> (...)
> 
> > > +static int tps6594_rtc_probe(struct platform_device *pdev)
> > > +{
> > > +   struct tps6594 *tps6594;
> > > +   struct tps6594_rtc *tps_rtc;
> > > +   int irq;
> > > +   int ret;
> > > +
> > > +   tps6594 = dev_get_drvdata(pdev->dev.parent);
> > > +
> > > +   tps_rtc = devm_kzalloc(&pdev->dev, sizeof(struct tps6594_rtc),
> > > +                          GFP_KERNEL);
> > > +   if (!tps_rtc)
> > > +           return -ENOMEM;
> > > +
> > > +   tps_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
> > > +   if (IS_ERR(tps_rtc->rtc))
> > > +           return PTR_ERR(tps_rtc->rtc);
> > > +
> > > +   /* Enable crystal oscillator */
> > > +   ret = regmap_set_bits(tps6594->regmap, TPS6594_REG_RTC_CTRL_2,
> > > +                         TPS6594_BIT_XTAL_EN);
> > > +   if (ret < 0)
> > > +           return ret;
> > > +
> > > +   /* Start rtc */
> > > +   ret = regmap_set_bits(tps6594->regmap, TPS6594_REG_RTC_CTRL_1,
> > > +                         TPS6594_BIT_STOP_RTC);
> > > +   if (ret < 0)
> > > +           return ret;
> >
> > Do that (XTAL_EN and clearing STOP) only once the time is known to be
> > set to a correct value so read_time doesn't have a chance to return a
> > bogus value.
> >
> 
> (...)
> 
> I understand your point, however I'm not sure of the canonical way to do
> this. Simply calling `tps6594_rtc_set_time` is enough?

Yeah, let userspace set the time and start the rtc at that point.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
