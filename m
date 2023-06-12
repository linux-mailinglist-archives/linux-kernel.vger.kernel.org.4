Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94B572C814
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbjFLOVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbjFLOUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:20:39 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FC3420A;
        Mon, 12 Jun 2023 07:18:13 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686579427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vXOzp+rKL77JOYC8eYHmA0SNruaXz0Znhi2NTQDe75A=;
        b=L2rSyjdd2xT+aG9LrldbbmkHzSV51aaIVTI2/BKwhGlx/2hD9+F5fdXAO1SGknQSYNhgIX
        dE4ec/hBMbOMAn0bPRXmGCQPB0krWTT5VJi9QohQAs/ou0eve8wcTvEU/icw2uqYj5abuK
        Tzl48yoaOlGLKm7v6oqTvpoaDLBOi58GhQ54DLA6zWt5W7w4qx0rtJHl6OHa9J615z9yTW
        2Ux0SguA63VvSa35bQeTcLWwUSBd/lb2FSqlfdZ+bijXQp2QlNEH3YeMkvF71SthPSrgm+
        PC0EZZSyH14LcwFaKBO6VrpsqCmo4rQIHBDq4R0KiZRTlFTQS4ytuhDFJv6y2g==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF137240006;
        Mon, 12 Jun 2023 14:17:05 +0000 (UTC)
Date:   Mon, 12 Jun 2023 16:17:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] rtc: isl12022: trigger battery level detection
 during probe
Message-ID: <2023061214170504ac9f0b@mail.local>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-7-linux@rasmusvillemoes.dk>
 <665d9926-2e0f-4b16-1414-f6d8fc487124@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665d9926-2e0f-4b16-1414-f6d8fc487124@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 14:30:18+0200, Rasmus Villemoes wrote:
> On 12/06/2023 13.30, Rasmus Villemoes wrote:
> 
> > diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> > index 1b6659a9b33a..690dbb446d1a 100644
> > --- a/drivers/rtc/rtc-isl12022.c
> > +++ b/drivers/rtc/rtc-isl12022.c
> > @@ -280,8 +280,25 @@ static void isl12022_set_trip_levels(struct device *dev)
> >  	mask = ISL12022_REG_VB85_MASK | ISL12022_REG_VB75_MASK;
> >  
> >  	ret = regmap_update_bits(regmap, ISL12022_REG_PWR_VBAT, mask, val);
> > -	if (ret)
> > +	if (ret) {
> >  		dev_warn(dev, "unable to set battery alarm levels: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	ret = regmap_write_bits(regmap, ISL12022_REG_BETA,
> > +				ISL12022_BETA_TSE, ISL12022_BETA_TSE);
> > +	if (ret) {
> > +		dev_warn(dev, "unable to trigger battery level detection: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	ret = isl12022_read_sr(regmap);
> 
> So testing this a bit more thoroughly reveals that the LBAT85/LBAT75
> bits do not get updated immediately after the TSE bit is set; one needs
> to wait a little before the battery voltage detection is done and the SR
> bits updated. Unfortunately, the data sheet doesn't say anything about
> how long that might be or if there's some busy bit one could look at;
> all it says is actually exactly what I've done above:
> 
>   The battery level monitor is not functional in battery backup
>   mode. In order to read the monitor bits after powering up VDD,
>   instigate a battery level measurement by setting the TSE bit to
>   "1" (BETA register), and then read the bits.
> 
> IOW, please don't apply this patch until I figure out how to do this
> properly.
> 

The datasheet states 22ms for the temperature conversion so I would
expect it takes about that time.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
