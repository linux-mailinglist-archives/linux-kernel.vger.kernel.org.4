Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1962029F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiKGWw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKGWwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:52:54 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C420A1AD;
        Mon,  7 Nov 2022 14:52:52 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A2A41FF803;
        Mon,  7 Nov 2022 22:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667861571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Igg3eaSSbsFgdGyb2PSWE7yjdySxbKxEfPo8FPLAq0=;
        b=KwYPSyHZUkWR3Yjwvo8IXartUFN2UtJQqOk9dXKuPUap/XTV8uyIyvC0xXP8bZ0B5ZD3C8
        8rPmZEt9lRpvUVZDedJDC4SnakTZTFg9HQrnrIUPdTD6hWIb1EKC9D5p/5HYXyFboRW5ii
        RBvw1bMXHfCLolD8OqnGDdS0ziUQ/153TvePYbEy/WniUhx+8fGYKb0MGNjfZLul9/t7c/
        NlDUUfjUuwLfOEsLcpVuO2eAL3MzmK9hVzr61rEVImB9dGim8FikC+7xYDH4XTfzGfBGRk
        kZy9KW8ZFTUb4syFlst7g8/UV9auh9ahfzefxFOWjK5mTQiZV+IQf6UyareG9Q==
Date:   Mon, 7 Nov 2022 23:52:50 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>, linux-rtc@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] rtc: cros-ec: Limit RTC alarm range if needed
Message-ID: <Y2mMQifOl7BzPCZm@mail.local>
References: <20221029005400.2712577-1-linux@roeck-us.net>
 <Y2ABnbBGSJGM3gSS@mail.local>
 <20221031181913.GA3841664@roeck-us.net>
 <Y2BIv21U7lpN0z23@mail.local>
 <20221031230749.GB2082109@roeck-us.net>
 <20221102184804.GA1918067@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102184804.GA1918067@roeck-us.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/11/2022 11:48:04-0700, Guenter Roeck wrote:
> Alexandre,
> 
> On Mon, Oct 31, 2022 at 04:07:51PM -0700, Guenter Roeck wrote:
> [ ... ]
> > > > 
> > > > On a side note, I tried an alternate implementation by adding a retry into
> > > > alarmtimer_suspend(), where it would request a smaller timeout if the
> > > > requested timeout failed. I did not pursue/submit this since it seemed
> > > > hacky. To solve that problem, I'd rather discuss extending the RTC API
> > > > to provide a maximum offset to its users. Such a solution would probably
> > > > be desirable, but that it more longer term and would not solve the
> > > > immediate problem.
> > > 
> > > Yes, this is what I was aiming for. This is something that is indeed
> > > missing in the RTC API and that I already thought about. But indeed, it
> > > would be great to have a way to set the alarm range separately from the
> > > time keeping range. This would indeed have to be a range relative to the
> > > current time.
> > > 
> > > alarmtimer_suspend() can then get the allowed alarm range for the RTC,
> > > and set the alarm to max(alarm range, timer value) and loop until the
> > > timer has expired. Once we have this API, userspace can do the same.
> > > 
> > > I guess that ultimately, this doesn't help your driver unless you are
> > > wanting to wakeup all the chromebooks at least once a day regardless of
> > > their EC.
> > 
> > That is a no-go. It would reduce battery lifetime on all Chromebooks,
> > including those not affected by the problem (that is, almost all of them).
> > 
> > To implement reporting the maximum supported offset, I'd probably either
> > try to identify affected Chromebooks using devicetree information,
> > or by sending am alarm request > 24h in the future in the probe function
> > and setting the maximum offset just below 24h if that request fails.
> > We'd have to discuss the best approach internally.
> > 
> > Either case, that doesn't help with the short term problem that we
> > have to solve now and that can be backported to older kernels. It also
> > won't help userspace - userspace alarm requests, as Brian has pointed out,
> > are separate from limits supported by the RTC hardware. We can not change
> > the API for CLOCK_xxx_ALARM to userspace, and doing so would not make
> > sense anyway since it works just fine as long as the system isn't
> > suspended. Besides, changing alarmtimer_suspend() as you suggest above
> > would solve the problem for userspace, so I don't see a need for a
> > userspace API/ABI change unless I am missing something.
> >
> 
> Would you be open to accepting this patch, with me starting to work
> on the necessary infastructure changes as suggested above for a more
> comprehensive solution ?
> 

I'll take the patch as-is so you can backport it and have a solution.
I'll also work on the alarm range and I'll let you get the series once
this is ready so you can test.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
