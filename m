Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78AF614083
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJaWO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJaWO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:14:27 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8357213;
        Mon, 31 Oct 2022 15:14:25 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 226121C0002;
        Mon, 31 Oct 2022 22:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667254464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g4PYqOd5SRr9ZuoCVtP2HbAo+y1WggE/ijdZao4BPJE=;
        b=lBxsv9yTUr4PyHEPbZnozZrtBY4pkFdJYCDSFK6kwu4CPmz3rC7udy/qaHKVQ1eiUlmhQE
        LAGN2Gc5hIHM4gttcJLqSTqcBgPRawC/iRbbrGtJEVka2t5OKM24wZabTQWaB1n3WCLCgr
        gQe2FF/2JVKugfJkNnA5mX4GO/VjzG+8ef4360oysAdmmRDCVQ+0zgNvv5396WwEPFZpL6
        0gDsYoSiEIyG5ryH5OchdSJbL1MnLnHyoe8Y/Q6lmV+M0muI2CFqHHpEySK4s41kO2xKGf
        1snw+pA4xrduSm+q7UUySUl8620sqsUlF5bLy7Q884gBoUeJrB6GYXp8f+/5BA==
Date:   Mon, 31 Oct 2022 23:14:23 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>, linux-rtc@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] rtc: cros-ec: Limit RTC alarm range if needed
Message-ID: <Y2BIv21U7lpN0z23@mail.local>
References: <20221029005400.2712577-1-linux@roeck-us.net>
 <Y2ABnbBGSJGM3gSS@mail.local>
 <20221031181913.GA3841664@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031181913.GA3841664@roeck-us.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 11:19:13-0700, Guenter Roeck wrote:
> On Mon, Oct 31, 2022 at 06:10:53PM +0100, Alexandre Belloni wrote:
> > Hello,
> > 
> > On 28/10/2022 17:54:00-0700, Guenter Roeck wrote:
> > > RTC chips on some older Chromebooks can only handle alarms less than 24
> > > hours in the future. Attempts to set an alarm beyond that range fails.
> > > The most severe impact of this limitation is that suspend requests fail
> > > if alarmtimer_suspend() tries to set an alarm for more than 24 hours
> > > in the future.
> > > 
> > > Try to set the real-time alarm to just below 24 hours if setting it to
> > > a larger value fails to work around the problem. While not perfect, it
> > > is better than just failing the call. A similar workaround is already
> > > implemented in the rtc-tps6586x driver.
> > 
> > I'm not super convinced this is actually better than failing the call
> > because your are implementing policy in the driver which is bad from a
> > user point of view. It would be way better to return -ERANGE and let
> > userspace select a better alarm time.
> 
> The failing call is from alarmtimer_suspend() which is called during suspend.
> It is not from userspace, and userspace has no chance to intervene.
> 
> It is also not just one userspace application which could request a large
> timeout, it is a variety of userspace applications, and not all of them are
> written by Google. Some are Android applications. I don't see how it would be
> realistic to expect all such applications to fix their code (if that is even
> possible - there might be an application which called sleep(100000) or
> something equivalent, which works just fine as long as the system is not
> suspended.
> 
> > Do you have to know in advance which are the "older" chromebooks that
> > are affected?
> 
> Not sure I understand the question. Technically we know, but the cros_ec
> rtc driver doesn't know because the EC doesn't have an API to report the
> maximum timeout to the Linux driver. Even if that existed, it would not
> help because the rtc API only supports absolute maximum clock values,
> not clock offsets relative to the current time. So ultimately there is no
> means for an RTC driver to tell the maximum possible alarm timer offset to 
> the RTC subsystem, and there is no means for a user such as
> alarmtimer_suspend() to obtain the maximum time offset. Does that answer
> your question ?

Yes, my question was missing a few words, sorry I wanted to know if you
had *a way* to know.

> 
> On a side note, I tried an alternate implementation by adding a retry into
> alarmtimer_suspend(), where it would request a smaller timeout if the
> requested timeout failed. I did not pursue/submit this since it seemed
> hacky. To solve that problem, I'd rather discuss extending the RTC API
> to provide a maximum offset to its users. Such a solution would probably
> be desirable, but that it more longer term and would not solve the
> immediate problem.

Yes, this is what I was aiming for. This is something that is indeed
missing in the RTC API and that I already thought about. But indeed, it
would be great to have a way to set the alarm range separately from the
time keeping range. This would indeed have to be a range relative to the
current time.

alarmtimer_suspend() can then get the allowed alarm range for the RTC,
and set the alarm to max(alarm range, timer value) and loop until the
timer has expired. Once we have this API, userspace can do the same.

I guess that ultimately, this doesn't help your driver unless you are
wanting to wakeup all the chromebooks at least once a day regardless of
their EC.

> If you see a better solution, please let me know. Again, the problem
> is that alarmtimer_suspend() fails because the requested timeout is too
> large.
> 
> Thanks,
> Guenter
> 
> > 
> > > 
> > > Drop error messages in cros_ec_rtc_get() and cros_ec_rtc_set() since the
> > > calling code also logs an error and to avoid spurious error messages if
> > > setting the alarm ultimately succeeds.
> > > 
> > > Cc: Brian Norris <briannorris@chromium.org>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/rtc/rtc-cros-ec.c | 35 ++++++++++++++++++++---------------
> > >  1 file changed, 20 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
> > > index 887f5193e253..a3ec066d8066 100644
> > > --- a/drivers/rtc/rtc-cros-ec.c
> > > +++ b/drivers/rtc/rtc-cros-ec.c
> > > @@ -14,6 +14,8 @@
> > >  
> > >  #define DRV_NAME	"cros-ec-rtc"
> > >  
> > > +#define SECS_PER_DAY	(24 * 60 * 60)
> > > +
> > >  /**
> > >   * struct cros_ec_rtc - Driver data for EC RTC
> > >   *
> > > @@ -43,13 +45,8 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
> > >  	msg.msg.insize = sizeof(msg.data);
> > >  
> > >  	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
> > > -	if (ret < 0) {
> > > -		dev_err(cros_ec->dev,
> > > -			"error getting %s from EC: %d\n",
> > > -			command == EC_CMD_RTC_GET_VALUE ? "time" : "alarm",
> > > -			ret);
> > > +	if (ret < 0)
> > >  		return ret;
> > > -	}
> > >  
> > >  	*response = msg.data.time;
> > >  
> > > @@ -59,7 +56,7 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
> > >  static int cros_ec_rtc_set(struct cros_ec_device *cros_ec, u32 command,
> > >  			   u32 param)
> > >  {
> > > -	int ret = 0;
> > > +	int ret;
> > >  	struct {
> > >  		struct cros_ec_command msg;
> > >  		struct ec_response_rtc data;
> > > @@ -71,13 +68,8 @@ static int cros_ec_rtc_set(struct cros_ec_device *cros_ec, u32 command,
> > >  	msg.data.time = param;
> > >  
> > >  	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
> > > -	if (ret < 0) {
> > > -		dev_err(cros_ec->dev, "error setting %s on EC: %d\n",
> > > -			command == EC_CMD_RTC_SET_VALUE ? "time" : "alarm",
> > > -			ret);
> > > +	if (ret < 0)
> > >  		return ret;
> > > -	}
> > > -
> > >  	return 0;
> > >  }
> > >  
> > > @@ -190,8 +182,21 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> > >  
> > >  	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
> > >  	if (ret < 0) {
> > > -		dev_err(dev, "error setting alarm: %d\n", ret);
> > > -		return ret;
> > > +		if (ret == -EINVAL && alarm_offset >= SECS_PER_DAY) {
> > > +			/*
> > > +			 * RTC chips on some older Chromebooks can only handle
> > > +			 * alarms up to 24h in the future. Try to set an alarm
> > > +			 * below that limit to avoid suspend failures.
> > > +			 */
> > > +			ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM,
> > > +					      SECS_PER_DAY - 1);
> > > +		}
> > > +
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "error setting alarm in %u seconds: %d\n",
> > > +				alarm_offset, ret);
> > > +			return ret;
> > > +		}
> > >  	}
> > >  
> > >  	return 0;
> > > -- 
> > > 2.36.2
> > > 
> > 
> > -- 
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
