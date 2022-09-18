Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0986B5BBF60
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 20:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIRStG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 14:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIRStE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 14:49:04 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CD512740;
        Sun, 18 Sep 2022 11:49:01 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2948C60004;
        Sun, 18 Sep 2022 18:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663526939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wv1lkXyPNnvuT33kuOpuzkwbPzoa6t/yV8QTY+AxU2s=;
        b=it19YxhyIw6Vcpo77yKrWEkY//J7g5tpm/QoARkfbsJWdu/+JHeDsX7hD3bMt3AMPC7Y++
        4IMjl/mbKx0HTFOOd693f0Qn/ZpehYe+fG5twKCtW2QELB7pXWNsROupD4o567xjNqfPGZ
        uNmhWJk161vRIQMq+SCj2RUzTjAlTb31aiBzqHU3sLM/397NlhwT9NmGhXPW3HDZKb0SfT
        Qxc9vyfbGJbRRuBpISmIOcaduQdYOH/WEHtWJFzht2Wo8QkiOTTMC9OVqO8FrpkWGmuhDj
        qiBSq1FmxgqkzXbFwSmcGkANmELTl4Yh47Tp+228AhhY9eyYQPA9XX0cjaqcpA==
Date:   Sun, 18 Sep 2022 20:48:58 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rtc: maxim: Add Maxim max31329 real time clock
Message-ID: <YydoGsEU/UPkXvXn@mail.local>
References: <20220912190753.10158-1-jagathjog1996@gmail.com>
 <20220912190753.10158-3-jagathjog1996@gmail.com>
 <YyHBKNC/YHbvIn40@mail.local>
 <CAM+2Eu+jCA9yJma2UtD736opw0=_uCz4Zbiem89ehexTEU7mQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM+2Eu+jCA9yJma2UtD736opw0=_uCz4Zbiem89ehexTEU7mQw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2022 16:09:54+0530, Jagath Jog J wrote:
> > This doesn't feel right, doesn't that break start-year?
> >
> > What is the actual time range supported by this RTC? Shouldn't you set
> > the century?
> 
> The time range supported by RTC is 2000 to 2199.
> The alarm registers don't have a century bit.
> I have tested the alarm for
> 2122-09-17T01:22:00
> 2142-09-17T01:22:00
> 2160-02-29T00:00:00
> 2196-02-29T00:00:00 etc
> 
> I will add another condition such that if the century bit
> from the time register is not set then configuring the
> alarm for the next century is not allowed.

The actual check should be for the alarm to not exceed 100 years in the
future then. Else, this wouldn't work well with datetime offsetting.

> > > +static int max31329_set_time(struct device *dev, struct rtc_time *tm)
> > > +{
> > > +     struct max31329_data *max31329 = dev_get_drvdata(dev);
> > > +     u8 regs[7];
> > > +     int ret;
> > > +
> > > +     ret = max31329_get_osc_status(dev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> >
> > Checking the oscillator is not needed here but resetting the status is.
> 
> Resetting the device will resets the digital block,
> I2C-programmable registers and oscillator also,
> The oscillator is taking some time around 80 milli sec
> to be back as usual.
> 
> Is it required to reset every time during the time setting?
> 

Not but resetting the osc status is.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
