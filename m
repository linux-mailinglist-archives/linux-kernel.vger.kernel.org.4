Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD836219EB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiKHQ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiKHQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:59:24 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2A1E70D;
        Tue,  8 Nov 2022 08:59:22 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q186so3732323oia.9;
        Tue, 08 Nov 2022 08:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/retO0IOn9gQQquHKtQyZRA1zXaOIaucGlTNCVBH/M=;
        b=M0qgOYFr5sijy/+ZKYT67kMvMsWpLWguwITmNMkCmQ7LjbgpYKeVZhWQvt96ZEJbst
         MgL3tOq8VHefGAhd3Gni0dakbLNxrxrlt4WxDXWKPKp50I3DvW6LMIo1sbFN7BOdWFfs
         QsPyMTVYGqw3HCeJsqiGLGpQFuF7k5a4HR1KWxhWRDJfwtuN/pQNchIBvcYUAj4CQmge
         phAskO2MssbrgjKlTR8OqDJNYkQZoc2tJ00rEnmd6+w+3sKe9Gj+ZNInekCpJlaHPpmJ
         6IK53EfJC2cSYwIsGmDd1c/Iv7VtYV6NOLvqICrR8HDNatb0Arz1ed0Vz6XBT4URuOti
         ig2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/retO0IOn9gQQquHKtQyZRA1zXaOIaucGlTNCVBH/M=;
        b=UVW1LLOSj06iuaMSI/LWOiv1vLLO9St9cr1fgc6ehNCtYxjZTnhV73rnZHNXHzmZwY
         IAuYxJauPWm+bgkTCQBPYE2D3F3sAwDAZPBh2pOwAni8xo1X2zr5r5c7Y9zUKjCKWSVM
         /ZtZ/28htPuw+2sMb0NdsR2VOuaXBd01iJuph4CB+RUyNY4ZMNW+XAhunUdKg9vXSWTY
         3wXZUEqaoY8Aqe9dj2tI8tq8ZaKATU4hlmkPsy/lkB/azd7JhYfyCWjg+WZYp7ZgFtJI
         Dd3cb0b/iEoblX6Pc3Pi6gS0g+ByA6nNek5BYx83ALhYuurKFG18XO+wdZCiQmOwdDms
         DSOQ==
X-Gm-Message-State: ACrzQf2EPDnTSLkDEl4VB3hb3CApkrVodC/934CO1sfR81c6tcRDmvKk
        IDawmjZo5jMiKlJv59X930Q=
X-Google-Smtp-Source: AMsMyM613LmbqXHX6qbmzPDTbRL9UTPsE0EYmYd59auwTtOZsG9X/HJb5s+yVzhvuHKcLhANl6qldA==
X-Received: by 2002:aca:a982:0:b0:359:e9f4:5483 with SMTP id s124-20020acaa982000000b00359e9f45483mr28782336oie.127.1667926762015;
        Tue, 08 Nov 2022 08:59:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g17-20020a056870d21100b00136cfb02a94sm4839827oac.7.2022.11.08.08.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 08:59:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 8 Nov 2022 08:59:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>, linux-rtc@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] rtc: cros-ec: Limit RTC alarm range if needed
Message-ID: <20221108165637.GA801591@roeck-us.net>
References: <20221029005400.2712577-1-linux@roeck-us.net>
 <Y2ABnbBGSJGM3gSS@mail.local>
 <20221031181913.GA3841664@roeck-us.net>
 <Y2BIv21U7lpN0z23@mail.local>
 <20221031230749.GB2082109@roeck-us.net>
 <20221102184804.GA1918067@roeck-us.net>
 <Y2mMQifOl7BzPCZm@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2mMQifOl7BzPCZm@mail.local>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 07, 2022 at 11:52:50PM +0100, Alexandre Belloni wrote:
[ ... ]
> 
> I'll take the patch as-is so you can backport it and have a solution.
> I'll also work on the alarm range and I'll let you get the series once
> this is ready so you can test.
> 

Excellent, thanks a lot. I also started looking into a poor-man's solution
of range support. I attached what I currently have below for your
reference. It isn't much, but it let me test follow-up changes in the
cros-ec rtc driver. Unfortunately I was not able to find a means to
implement something like "go back to sleep fast" in the alarm timer code.

In this context: Is there a standardized set of error codes for RTC
drivers ? I see -EINVAL, -ETIME, -EDOM, -ERANGE, but those are not
consistently used. I assumed -ETIME for "time expired" and -ERANGE
for "time too far in the future" below, but that was just a wild guess.

Thanks,
Guenter

---
commit 7918f162f947424ec0ad7a318c45febeaea51d2e
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Wed Nov 2 19:35:09 2022 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Fri Nov 4 09:54:06 2022 -0700

    rtc: Add support for limited alarm timer offsets
    
    Some alarm timers are based on time offsets, not on absolute times.
    In some situations, the amount of time that can be scheduled in the
    future is limited. This may result in a refusal to suspend the system,
    causing substantial battery drain.
    
    Some RTC alarm drivers remedy the situation by setting the alarm time
    to the maximum supported time if a request for an out-of-range timeout
    is made. This is not really desirable since it may result in unexpected
    early wakeups.
    
    To reduce the impact of this problem, let RTC drivers report the maximum
    supported alarm timer offset. The code setting alarm timers can then
    decide if it wants to reject setting alarm timers to a larger value, if it
    wants to implement recurring alarms until the actually requested alarm
    time is met, or if it wants to accept the limited alarm time.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 9edd662c69ac..05ec9afbb6ba 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -426,6 +426,10 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 
 	if (scheduled <= now)
 		return -ETIME;
+
+	if (rtc->range_max_offset && scheduled - now > rtc->range_max_offset)
+		return -ERANGE;
+
 	/*
 	 * XXX - We just checked to make sure the alarm time is not
 	 * in the past, but there is still a race window where if
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 1fd9c6a21ebe..b6d000ab1e5e 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -146,6 +146,7 @@ struct rtc_device {
 
 	time64_t range_min;
 	timeu64_t range_max;
+	timeu64_t range_max_offset;
 	time64_t start_secs;
 	time64_t offset_secs;
 	bool set_start_time;
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 5897828b9d7e..af8e0a9e0d63 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -291,6 +291,19 @@ static int alarmtimer_suspend(struct device *dev)
 	rtc_timer_cancel(rtc, &rtctimer);
 	rtc_read_time(rtc, &tm);
 	now = rtc_tm_to_ktime(tm);
+
+	/*
+	 * If the RTC alarm timer only supports a limited time offset, set
+	 * the alarm time to the maximum supported value.
+	 * The system will wake up earlier than necessary and is expected
+	 * to go back to sleep if it has nothing to do.
+	 * It would be desirable to handle such early wakeups without fully
+	 * waking up the system, but it is unknown if this is even possible.
+	 */
+	if (rtc->range_max_offset &&
+	    rtc->range_max_offset * NSEC_PER_SEC > ktime_to_ns(min))
+		min = ns_to_ktime(rtc->range_max_offset * NSEC_PER_SEC);
+
 	now = ktime_add(now, min);
 
 	/* Set alarm, if in the past reject suspend briefly to handle */
