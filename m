Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD6741A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjF1VPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjF1VNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:13:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E91D2704;
        Wed, 28 Jun 2023 14:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0832A614AC;
        Wed, 28 Jun 2023 21:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A26CC433C9;
        Wed, 28 Jun 2023 21:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687986646;
        bh=zKjNzkX/4Suk1DSKfWO5q+G02nHPWwKDc6OwiAcfhf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2mnlfpbzbjoSum+dqYitKp8j9j7Zo+O/g31Dq5YDye63K+uLeJ2Y1QkxiSwIPJpr
         NLPHCFRVFCwF8xh/0xs8qvRs8ZnbamHSKMomoIuQJ9dnM4g2UlT19jgesQqhxmtafI
         PGKrXQPB08T1jrSvD59/4KxwVLQfVS72tRbQiYIxBGre0zwgKQLsYH4SZhBdW7Bwbu
         8FEXcKF8Cs/X9xb/X5p62UOI0ykcBgKDpD6LrO86LgqqnXhsrm3mwBZX4/nyCkrCw/
         GqR++SU2clRAviQK+7TcrJlQsaxiuXw2GfTaJJl4JVlfmTdFpc05dx9MKfspggor7G
         Rnk4skpviy4fg==
Date:   Wed, 28 Jun 2023 14:10:44 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Message-ID: <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
 <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
 <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
 <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 07:31:43PM +0200, Rafael J. Wysocki wrote:
> 
> 
> 
> On Thu, Jun 22, 2023 at 6:56 AM Eduardo Valentin <evalenti@kernel.org> wrote:
> >
> > On Wed, Jun 21, 2023 at 01:43:26PM +0200, Daniel Lezcano wrote:
> > >
> > >
> > >
> > > On 21/06/2023 07:06, Eduardo Valentin wrote:
> > > > On Mon, Jun 12, 2023 at 10:17:51AM +0200, Daniel Lezcano wrote:
> > > > >
> > > > >
> > > > >
> > > > > Hi Eduardo,
> > > > >
> > > > > On 08/06/2023 19:44, Eduardo Valentin wrote:
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > > Do you have a use case with some measurements to spot an issue or is it
> > > > > > > a potential issue you identified ?
> > > > > >
> > > > > >
> > > > > > yes, a governor that is using I2C device as input, behind I2C fast mode (100KHz)
> > > > > > and needs to update the zone every 100ms. Each read in this bus, if done alone
> > > > > > would be around 500us, takes 10bytes to read the device, it is 10 clocks per byte,
> > > > > > well technically 9, but rounding for the sake of the example, which gets you
> > > > > > 50 / 100KHz = 500 us. That is for a single read. You add one single extra
> > > > > > userspace read triggering an unused device update, that is already a 1ms drift.
> > > > > > Basically you looking at 0.5% for each extra userspace read competing in this
> > > > > > sysfs node. You add extra devices in the same I2C bus, your governor is looking
> > > > > > at more than 1% overhead. And I am talking also about a main CPU of ~800MHz.
> > > > > > I did not even include the lock overhead considered for this CPU ;-)
> > > > > >
> > > > > > Again, this is not about controlling the DIE temperature of the CPU you
> > > > > > are running the thermal subsystem. This is about controlling
> > > > > > a target device.
> > > > >
> > > > > Ok. The target device is on a bus which is slow and prone to contention.
> > > > >
> > > > > This hardware is not designed to be monitored with a high precision, so
> > > > > reading the temperature at a high rate does not really make sense.
> > > >
> > > > On the contrary, it needs even more precision and any extra delay adds to
> > > > loss on accuracy :-)
> > >
> > > What I meant is if the hardware designer thought there could be a
> > > problem with the thermal zone they would have put another kind of
> > > sensor, not one with a i2c based communication.
> >
> > No, that is not a problem in the physical thermal zone. Or to cover
> > for a hardware design flaw. This is an actual typical case. However,
> > yes, designer must take into account any sort of delays or jittering
> > in the control system, and typically one would add some thermal margins
> > on the control system. But to the original point here, we should eliminate
> > unnecessary jittering or delay in the control system.
> >
> > >
> > >
> > > > > Moreover (putting apart a potential contention), the delayed read does
> > > > > not change the time interval, which remains the same from the governor
> > > > > point of view.
> > > >
> > > > It does not change the governor update interval and that is a property of
> > > > the thermal zone. Correct. And that is the intention of the change.
> > > > The actual temperature updates driven by the governor will always
> > > > result in a driver call. While a userspace call will not be in the way
> > > > of the governor update.
> > > >
> > > > Sysfs reads, However, with the current code as is, it may cause
> > > > jittering on the actual execution of the governor throttle function.
> > > >   causing the computation of the desired outcome cooling device being skewed.
> > > >
> > > > >
> > > > > In addition, i2c sensors are usually handled in the hwmon subsystem
> > > > > which are registered in the thermal framework from there. Those have
> > > > > most of their 'read' callback with a cached value in a jiffies based way
> > > > > eg. [1].
> > > >
> > > > I guess what you are really saying is: go read the hwmon sysfs node,
> > > > or, hwmon solves this for us, which unfortunately is not true for all devices.
> > >
> > > I meant the i2c sensors are under the hwmon subsystem. This subsystem is
> > > connected with the thermal framework, so when a hwmon sensor is created,
> > > it register this sensor as a thermal zone.
> > >
> > >
> > > > > So the feature already exists for slow devices and are handled in the
> > > > > drivers directly via the hwmon subsystem.
> > > > >
> > > > >  From my POV, the feature is not needed in the thermal framework.
> > > >
> > > > The fact that hwmon does it in some way is another evidence of the
> > > > actual problem.
> > >
> > > Not really, it shows the i2c sensors are in the hwmon subsystems.
> >
> > They are there too. And hwmon also sees same problem of too frequent
> > device update. The problem is there regardless of the subsystem we use
> > to represent the device. Also, I dont buy the argument that this is
> > a problem of hwmon because it is already supported to plug in
> > hwmon devices in the thermal subsystem. That is actually the original
> > design in fact :-). So running a control in the thermal subsystem
> > on top of inputs from hwmon, which happens to support I2C devices,
> > is not a problem for hwmon to solve, since the control is in the
> > thermal subsystem, and hwmon does not offer control solutions.
> 
> Regardless of where the problem is etc, if my understanding of the
> patch is correct, it is proposing to change the behavior of a
> well-known sysfs interface in a way that is likely to be incompatible
> with at least some of its users.  This is an obvious no-go in kernel
> development and I would expect you to be well aware of it.

yeah I get it.

> 
> IOW, if you want the cached value to be returned, a new interface (eg.
> a new sysfs attribute) is needed.

Yeah, I am fine with either a new sysfs entry to return the cached value,
or a new sysfs entry to change the behavior of the existing /temp, as I
mentioned before, either way works for me, if changing the existing one
is too intrusive.

> 
> And I think that the use case is not really i2c sensors in general,

I2C was just the factual example I had, but you are right, the use case
is not isolated to I2C sensor. Rather, to be clear I am not blaming I2C,
the actual issue just happen to be easier to see when I2C devices, slower
than typical MMIO devices, are being used as input for the control.

> because at least in some cases they work just fine AFAICS, but a
> platform with a control loop running in the kernel that depends on
> sensor reads carried out at a specific, approximately constant, rate
> that can be disturbed by user space checking the sensor temperature
> via sysfs at "wrong" times.  If at the same time the user space
> program in question doesn't care about the most recent values reported
> by the sensor, it may very well use the values cached by the in-kernel
> control loop.

That is right, the balance between supporting user space reads and
running the control timely is the actual original concern. The problem
fades out a bit when you have device reads in the us / ns time scale
and control update is in 100s of ms. But becomes more apparent on slower
devices, when reads are in ms and policy update is in the 100s ms, that is
why the I2C case was quoted. But nothing wrong with I2C, or supporting
I2C on the thermal subsystem as we do today via the hwmon interface REGISTER_TZ,
the problem is on having to support the control in kernel and a read in
userspace that can create jitter to the control.

And as you properly stated, for this use case, the userspace does not care
about the most recent value of the device, so that is why the change
proposes to give cached values.

On the flip side though, there may be user space based policies that
require the most recent device value. But in this case, the expectation
is to disable the in kernel policy and switch the thermal zone to
mode == disabled. And that is also why this patch will go the path
to request the most recent device value when the /temp sysfs entry
is read and the mode is disabled.

I would suggest to have an addition sysfs entry that sets the
thermal zone into cached mode or not, let's say for the sake of the
discussion, we call it 'cached_values', with default to 'not cached'.
This way, we could support:

a) Default, current situation, where all reads in /temp are always backed up
with an actual device .get_temp(). Nothing changes here, keeps reading
under /temp, and so long system designer is satisfied with jittering,
no need to change anything.

b) When one has control in kernel, and frequent userspace reads on /temp
but system designer wants to protect the control in kernel to avoid jittering.
Just keep reading from /temp but set the new sysfs property 'cached_values' to 'cached'.
Then userspace will get updated values as frequent as the kernel control has
and the kernel control will not be disturbed by frequent device reads.

c) When one has control in userspace, and wants to have the most frequent
device read. Here, one can simply disable the in kernel control by
setting the 'mode' sysfs entry to 'disabled', and making sure the new sysfs property is set
to 'not cached'. Well in fact, the way I thought this originally in this patch
was to simply always read the device when /temp is read is 'mode' is 'disabled'.

I believe you proposed to have another sysfs entry  sysfs entry for reading cached temperature.
Something like 'temp_cached'. Thinking of it, as I mentioned before, it will work.
The only possible downside is to have two entries to read temperature.

Strong opinions on any of the above?


-- 
All the best,
Eduardo Valentin
