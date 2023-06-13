Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574DD72DD23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbjFMI7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjFMI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:59:00 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF11AA;
        Tue, 13 Jun 2023 01:58:56 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686646735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WzN2Ac9TNvZka8mc3EL6P/jfHd2/+XW2RC/3jQwoJKg=;
        b=a+aUakOpxVgNwgM7lSaedlXEVyRkC2GC35n5dYwYOKEhLAaRBuSkeQ8BZpHKzczjhjSWmf
        9MdK8+JPRUiU+eB/MIHvbSY3zNnSFv5dFbRhMU9qcMWyCZIpqrKQ8zbJZzI5514TNey0W7
        yOuxYCGCMVk0bT1rw30HzbxiAjq4mTfAtRyuAafFYVgY9mpW52Qq/W1XybiGf8HcDwsPJd
        1mlCxI+mNOGUfiyqZCME5nd0jF7z/gsEYeqRlZPYBQ2QkEA5+nbHi2ivBmnGwQeSN7kqAI
        K5/QlnZox4mqqoV2EgaDMvmHyj3SFygyYhqL/BeOzMUr2WHe1uOrDAOtlgJ7rw==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90AC81C000E;
        Tue, 13 Jun 2023 08:58:54 +0000 (UTC)
Date:   Tue, 13 Jun 2023 10:58:54 +0200
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
Message-ID: <2023061308585481c7cb97@mail.local>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-7-linux@rasmusvillemoes.dk>
 <20230612141518c2119835@mail.local>
 <f3dc01bc-cdd1-ab0c-5891-083f6d255a4c@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3dc01bc-cdd1-ab0c-5891-083f6d255a4c@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 09:44:55+0200, Rasmus Villemoes wrote:
> On 12/06/2023 16.15, Alexandre Belloni wrote:
> > On 12/06/2023 13:30:56+0200, Rasmus Villemoes wrote:
> >> Since the meaning of the SR_LBAT85 and SR_LBAT75 bits are different in
> >> battery backup mode, they may very well be set after power on, and
> >> stay set for up to a minute (i.e. until the battery detection in VDD
> >> mode happens when the seconds counter hits 59). This would mean that
> >> userspace doing a ioctl(RTC_VL_READ) early on could get a false
> >> positive.
> >>
> >> The battery level detection can also be triggered by explicitly
> >> writing a 1 to the TSE bit in the BETA register. Do that once during
> >> boot (well, probe), and emit a single warning to the kernel log if the
> >> battery is already low.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >>  drivers/rtc/rtc-isl12022.c | 19 ++++++++++++++++++-
> >>  1 file changed, 18 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> >> index 1b6659a9b33a..690dbb446d1a 100644
> >> --- a/drivers/rtc/rtc-isl12022.c
> >> +++ b/drivers/rtc/rtc-isl12022.c
> >> @@ -280,8 +280,25 @@ static void isl12022_set_trip_levels(struct device *dev)
> >>  	mask = ISL12022_REG_VB85_MASK | ISL12022_REG_VB75_MASK;
> >>  
> >>  	ret = regmap_update_bits(regmap, ISL12022_REG_PWR_VBAT, mask, val);
> >> -	if (ret)
> >> +	if (ret) {
> >>  		dev_warn(dev, "unable to set battery alarm levels: %d\n", ret);
> >> +		return;
> >> +	}
> >> +
> >> +	ret = regmap_write_bits(regmap, ISL12022_REG_BETA,
> >> +				ISL12022_BETA_TSE, ISL12022_BETA_TSE);
> >> +	if (ret) {
> >> +		dev_warn(dev, "unable to trigger battery level detection: %d\n", ret);
> > 
> > This is too verbose, there is no action for the user upon getting this
> > message.
> 
> OK.
> 
> > Setting TSE also enables temperature compensation, which may be an
> > undesirable side effect. Shouldn't this be reverted if necessary?
> 
> Well, I can't imagine the board designer not wanting/expecting
> temperature compensation to be enabled since they've spent the $$ on
> using a part with that capability. Also, we anyway set TSE if
> CONFIG_HWMON so that the TEMP registers get updated once per minute.
> 
> If you insist I'll do the proper logic to set it back to 0 if it wasn't
> set beforehand, but I prefer to just keep it as-is.
> 

Ok, fine

> > 
> >> +		return;
> >> +	}
> >> +
> >> +	ret = isl12022_read_sr(regmap);
> >> +	if (ret < 0) {
> >> +		dev_warn(dev, "unable to read status register: %d\n", ret);
> >> +	} else if (ret & (ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75)) {
> >> +		dev_warn(dev, "battery voltage is below %u%%\n",
> >> +			 (ret & ISL12022_SR_LBAT75) ? 75 : 85);
> > 
> > This message is useless, I'd drop the whole block.
> 
> I only added this as "compensation" for ripping out the warning in 1/8,
> since I assumed somebody actually wanted at least one warning in the
> kernel log if the battery is low.
> 

No need, I had a patch removing the message anyway.

> I/we are not going to scrape dmesg but will use the ioctl() to monitor
> the battery, so I'm perfectly happy to just remove this. That will also
> make the question of how long to wait after setting TSE moot, since
> certainly userspace won't be able to issue the ioctl() soon enough to
> see stale values in the LBAT bits.
> 

Exactly.

> Rasmus
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
