Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307A86CC111
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjC1NfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjC1NfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:35:21 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D938CA19;
        Tue, 28 Mar 2023 06:34:41 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 032DA1BF20A;
        Tue, 28 Mar 2023 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680010471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bixo3EguG8ry3BhHfrwgjJLk/bpjG+PfEZUK6cyM/PQ=;
        b=K0PnbLtSisL5Nl2aFIXgSep1EByLG/r1ECQrxS6lrEkLyiB6b3Bh6OheucZ4dowZy56w9e
        njCF9/6NJ5Jwd/n95AFBmAjMTCtH3uGy7WJnEucanXEvQQLWQsqOGRm7jMWiPUhOFM1B90
        QlZ5LKsKaiIuT6KYktriqV7MN9kio4/qVWnbfEOH0eFJ70Nuv9eMCKdPPyCplLINI+6vy3
        xpi5erUfIjaoRcpYa/qak1mmgDW9CWQRQsQZQT7NUWyUP8l5sxf39akSTuuwVyeImtSG9F
        Kl4IRLDQkY0/uou7XqMUUS3AbxSeTNJystmt39nr6H9rVIPK/DslL96dTHU4LA==
Date:   Tue, 28 Mar 2023 15:34:29 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
Subject: Re: [PATCH v2 1/3] rtc: tps6594: add driver for TPS6594 PMIC RTC
Message-ID: <20230328133429ff45c492@mail.local>
References: <20230328091448.648452-1-eblanc@baylibre.com>
 <20230328091448.648452-2-eblanc@baylibre.com>
 <202303280929448e41808d@mail.local>
 <CRI1AQ7OIF6F.2G26C7VQKL5P0@burritosblues>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CRI1AQ7OIF6F.2G26C7VQKL5P0@burritosblues>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 15:01:05+0200, Esteban Blanc wrote:
> On Tue Mar 28, 2023 at 11:29 AM CEST, Alexandre Belloni wrote:
> > Hello,
> >
> > On 28/03/2023 11:14:46+0200, Esteban Blanc wrote:
> > > +	/* Start rtc */
> > > +	ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> > > +			      TPS6594_BIT_STOP_RTC);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	mdelay(100);
> > > +
> > > +	/*
> > > +	 * RTC should be running now. Check if this is the case.
> > > +	 * If not it might be a missing oscillator.
> > > +	 */
> > > +	ret = regmap_test_bits(tps->regmap, TPS6594_REG_RTC_STATUS,
> > > +			       TPS6594_BIT_RUN);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	if (ret == 0)
> > > +		return -ENODEV;
> > > +
> > > +	/* Stop RTC until first call to `tps6594_rtc_set_time */
> > > +	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> > > +				TPS6594_BIT_STOP_RTC);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> >
> > This whole block must not be executed when the RTC is already running,
> > else, you are stopping a perfectly running RTC.
> 
> I'm not sure to get your point. You mean that during probe, the driver
> might encounter an RTC device that is already running with a correct
> timestamp? How would this be possible? A previous bootstage or the
> driver was removed then re-inserted again?
> 

The whole point of having an RTC is that the time tracking survives a
reboot so yes, I would expect the RTC to have a valid timestamp at probe
time.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
