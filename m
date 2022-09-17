Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC15BB5DD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 05:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIQDPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 23:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIQDP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 23:15:28 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997BA8F961;
        Fri, 16 Sep 2022 20:15:26 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d15so17106623qka.9;
        Fri, 16 Sep 2022 20:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XUfzBzZuWyfF9wBV/OL25Z4oquzs51QmhKLoNSr3k1c=;
        b=PT59GgzURMS7drzwFEyVo7lPwaUbOGziEHXgRQ75ZczkEy+6JvTvw6yeycoMHEYEVP
         ySjiN2Eww4G9tZPd+HQ9Vl7OcK1+00VzqBXPTJsQ6yD3ltGMiF1KtcH4uD9VHYvtdXNN
         oeuosiiWwOyiywNcLwhxg3b+j6WPA2Xl2/8QZsTULeRQYYCW1rbcFw1ZIQPEZaqNbjwm
         IQ3gJr3TN/USqaWjdDHx5+W9YpOT0H6VezlWfjSIL5hR0+fTZNg8/qoDr9fNtVCVOHy3
         CKj3ll94O1CCIDH4titHm9yxGYEIrI7WMX0ghgjoGFSW5qKQVM0I13fSrfQBCFi7OQPC
         +Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XUfzBzZuWyfF9wBV/OL25Z4oquzs51QmhKLoNSr3k1c=;
        b=gh0etR16LadcJ3ow6aSwk6s3zx3dbvoFiHiZH5wYIMAXjzk7AT56sKcNfiU7yKVnNB
         ZyMF/R2w2FB1RuELul/DnvsFn+ed17lCpFxWJBbmY537rjZgJk4zq/M+0dRI98wtrvhe
         ek0i2V7XHpZVsHWMxC8KUrj5+FPRrBS6c69c9j/ZvxZEt0mKga46hSp1z1v//e5wr691
         pIyowVtx3qvFYzCwjMgA6hailewxeAd840HUhGOY0ngbEoLiGLuHUxrOfEHNP+Wtaomg
         Sf1HVvAfsLMH5FZi0/AJE5taqIpxJ+kcTzfe26Qir43wnXFrJg7em8qv3peM4u75XeI+
         ELkg==
X-Gm-Message-State: ACrzQf1PYJX6nEcO+LRw1ovR2jpM52lhZ2yeiYSVTxTSua1bzbcHrDoh
        WkN2ez/P77KjG14E8AQBUk0=
X-Google-Smtp-Source: AMsMyM550wELvKwBpS842nqt2Ta6446CQl7asd4w6TozPsTUlROqtB8ANnyOI5Wi1YZvB3M+4mssFw==
X-Received: by 2002:a37:f71c:0:b0:6ce:e3f7:4438 with SMTP id q28-20020a37f71c000000b006cee3f74438mr128978qkj.453.1663384525649;
        Fri, 16 Sep 2022 20:15:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:9414:100:7d9f:4703:e9c:52c])
        by smtp.gmail.com with ESMTPSA id m12-20020ac866cc000000b0035bbc29b3c9sm6335008qtp.60.2022.09.16.20.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:15:24 -0700 (PDT)
From:   Alexey Klimov <klimov.linux@gmail.com>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, gregkh@linuxfoundation.org,
        oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, atishp@rivosinc.com,
        atishp@atishpatra.org, yury.norov@gmail.com, aklimov@redhat.com,
        atomlin@redhat.com, stern@rowland.harvard.edu,
        klimov.linux@gmail.com
Subject: Re: [PATCH v6] watchdog: add driver for StreamLabs USB watchdog device
Date:   Sat, 17 Sep 2022 04:15:02 +0100
Message-Id: <20220917031502.372319-1-klimov.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220917030534.363192-1-klimov.linux@gmail.com>
References: <20220917030534.363192-1-klimov.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wim/Guenter,

For me it seems that there could be a potential race condition. I have to rely
on watchdog_active(&streamlabs_wdt->wdt_dev) function which tests the WDOG_ACTIVE
bit in struct watchdog_device->status member.
The watchdog_dev changes the state of the device with ->start() or ->ping() and
->stop() methods and updates the WDOG_ACTIVE accordingly.
In {pre,post}_reset methods here I have to change the state of the device from
running to stopped and back to running conditionally, however WDOG_ACTIVE bit
could be updated in between these callbacks execution or starting/stopping
the device can race.
For instance, I see the potential dangerous race like this:

	CPUX					CPUY

	..				watchdog_stop() {
	..					if (wdd->ops->stop) {
							...
							err = wdd->ops->stop(wdd)
						}
usb_streamlabs_wdt_pre_reset() {
	if (watchdog_active())
		stop_command();			/* WDOG_ACTIVE bit is still set
	...					 here indicating that watchdog is
}						 started, but ->stop() has already
						 finished */
	...
usb_streamlabs_wdt_post_reset() {
	if (watchdog_active())
		start_command();
}
	...					/* WDOG_ACTIVE is updated here */
						clear_bit(WDOG_ACTIVE, &wdd->status);
					}

As a result, the watchdog subsystem "thinks" that watchdog is not active and should
not be pinged. However, the driver observed using watchdog_active() that watchdog
was active during {pre,post}_reset and restarted the device which will lead to
unexpected reset. It is very unlikely race to happen but consequence is fatal.
In other words, there are two independent paths leading to driver changing
the state of the watchdog device and one path relies on status that can be changed
by another path.

Thinking about that I see the following approaches:

1. Introduce a variable in struct streamlabs_wdt that tracks the state of the
watchdog device itself and checking/updating the state of a device happens under
semaphore lock.
Obviously, this "internal" to the driver state variable should be used in
{pre,post}_reset. In case there will be other drivers (say, USB ones) they also
need to implement this.

or

2. The updates to wdd->status should happen under wd_data->lock.
Currently, it is mutex-based. The acquiring and releasing the lock could be
exported for the drivers to use. The mutex lock probably should be switched
to a binary semaphore for that.

In such case, in pre_reset() for example, I would need to do:
static int pre_reset()
{
	lock_wdd();
	acquire_internal_driver_lock();
	
	if (watchdog_active())
		stop_command();
}

static int post_reset()
{

	if (watchdog_active())
		start_command();

	release_internal_driver_lock();
	unlock_wdd();
}

There should be an order that we have to acquire subsystem wdd lock first, then
internal driver lock. Otherwise there could be deadlocks.

This could be done if you think it's more wiser move.

or

3. The {pre,post}_reset callbacks should execute watchdog_dev.c subsystem functions
(not sure which functions exactly). Eventually, it will look similar to what is
described in the previous point with respect to locks order.
I meant something like this:

static int pre_reset()
{
	watchdog_dev_pre_reset_prepare();
}

static int post_reset()
{
	watchdog_dev_post_reset_done();
}

In watchdog_dev.c:
void watchdog_dev_pre_reset_prepare()
{
	mutex_lock(&wd_data->lock);	<-- should be changed to semaphore too?

	watchdog_stop(wdd);		<-- without updating WDOG_ACTIVE bit?
					 or there should be a way to indicate
					 to watchdog_dev_post_reset_done() if
					 watchdog should be started or not
}

void watchdog_dev_post_reset_done()
{
	if (watchdog_active())
		watchdog_start(wdd);

        mutex_unlock(&wd_data->lock);
}

I didn't really thought about point 3 yet. For me personally the point 2 seems
the like right way to go but you have more experience with that. The exported
locks could be re-used by other drivers if needed in future.
In case of point 1 each USB driver should deal with {pre,post}_reset by themselves.

Any thoughts?

Thanks,
Alexey
