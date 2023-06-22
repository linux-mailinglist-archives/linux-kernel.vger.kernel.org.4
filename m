Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A845873968C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFVE42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFVE4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24F19A1;
        Wed, 21 Jun 2023 21:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF31961725;
        Thu, 22 Jun 2023 04:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A41C433C8;
        Thu, 22 Jun 2023 04:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687409780;
        bh=lri1nd5wS7oB4FBbQf+NRYb9hZNLJZy73nB3fVrApqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r31UtikvdakxdEF/Lk+BBD/pvE7TkJ4piHbWdl9rXyV1XzRU28MG5Cg0JLGpgjU1y
         OzZfsYHCJuSBPUk41TmcwLSh5rqxUIsnMgDcxa9yGahdaHdUG9MKMM6CyOhn57Rjt6
         U119Ox/smMeb61R/h7fy5ls7ggpsQx2YNSNyQHEG9xXAr0keo/+ZsBEvlYtK7zltoO
         DpMlWUfiR/sQ5XkT2FsRVnnEZmfATBl9ghM99fWnhf3kIwzcFfRLYcnAV/vAeF/hWk
         RhDAWZoih7g0ls+lnZAXFLGGOHmvJuh3kl2IBGHQt/lp5mzRKJ3Jl4zCs2v/ijhUVP
         OlUDyLP5cMPNQ==
Date:   Wed, 21 Jun 2023 21:56:18 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Message-ID: <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
 <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
 <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
 <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:43:26PM +0200, Daniel Lezcano wrote:
> 
> 
> 
> On 21/06/2023 07:06, Eduardo Valentin wrote:
> > On Mon, Jun 12, 2023 at 10:17:51AM +0200, Daniel Lezcano wrote:
> > > 
> > > 
> > > 
> > > Hi Eduardo,
> > > 
> > > On 08/06/2023 19:44, Eduardo Valentin wrote:
> > > 
> > > [ ... ]
> > > 
> > > > > Do you have a use case with some measurements to spot an issue or is it
> > > > > a potential issue you identified ?
> > > > 
> > > > 
> > > > yes, a governor that is using I2C device as input, behind I2C fast mode (100KHz)
> > > > and needs to update the zone every 100ms. Each read in this bus, if done alone
> > > > would be around 500us, takes 10bytes to read the device, it is 10 clocks per byte,
> > > > well technically 9, but rounding for the sake of the example, which gets you
> > > > 50 / 100KHz = 500 us. That is for a single read. You add one single extra
> > > > userspace read triggering an unused device update, that is already a 1ms drift.
> > > > Basically you looking at 0.5% for each extra userspace read competing in this
> > > > sysfs node. You add extra devices in the same I2C bus, your governor is looking
> > > > at more than 1% overhead. And I am talking also about a main CPU of ~800MHz.
> > > > I did not even include the lock overhead considered for this CPU ;-)
> > > > 
> > > > Again, this is not about controlling the DIE temperature of the CPU you
> > > > are running the thermal subsystem. This is about controlling
> > > > a target device.
> > > 
> > > Ok. The target device is on a bus which is slow and prone to contention.
> > > 
> > > This hardware is not designed to be monitored with a high precision, so
> > > reading the temperature at a high rate does not really make sense.
> > 
> > On the contrary, it needs even more precision and any extra delay adds to
> > loss on accuracy :-)
> 
> What I meant is if the hardware designer thought there could be a
> problem with the thermal zone they would have put another kind of
> sensor, not one with a i2c based communication.

No, that is not a problem in the physical thermal zone. Or to cover
for a hardware design flaw. This is an actual typical case. However,
yes, designer must take into account any sort of delays or jittering
in the control system, and typically one would add some thermal margins
on the control system. But to the original point here, we should eliminate
unnecessary jittering or delay in the control system.

> 
> 
> > > Moreover (putting apart a potential contention), the delayed read does
> > > not change the time interval, which remains the same from the governor
> > > point of view.
> > 
> > It does not change the governor update interval and that is a property of
> > the thermal zone. Correct. And that is the intention of the change.
> > The actual temperature updates driven by the governor will always
> > result in a driver call. While a userspace call will not be in the way
> > of the governor update.
> > 
> > Sysfs reads, However, with the current code as is, it may cause
> > jittering on the actual execution of the governor throttle function.
> >   causing the computation of the desired outcome cooling device being skewed.
> > 
> > > 
> > > In addition, i2c sensors are usually handled in the hwmon subsystem
> > > which are registered in the thermal framework from there. Those have
> > > most of their 'read' callback with a cached value in a jiffies based way
> > > eg. [1].
> > 
> > I guess what you are really saying is: go read the hwmon sysfs node,
> > or, hwmon solves this for us, which unfortunately is not true for all devices.
> 
> I meant the i2c sensors are under the hwmon subsystem. This subsystem is
> connected with the thermal framework, so when a hwmon sensor is created,
> it register this sensor as a thermal zone.
> 
> 
> > > So the feature already exists for slow devices and are handled in the
> > > drivers directly via the hwmon subsystem.
> > > 
> > >  From my POV, the feature is not needed in the thermal framework.
> > 
> > The fact that hwmon does it in some way is another evidence of the
> > actual problem.
> 
> Not really, it shows the i2c sensors are in the hwmon subsystems.

They are there too. And hwmon also sees same problem of too frequent
device update. The problem is there regardless of the subsystem we use
to represent the device. Also, I dont buy the argument that this is
a problem of hwmon because it is already supported to plug in
hwmon devices in the thermal subsystem. That is actually the original
design in fact :-). So running a control in the thermal subsystem
on top of inputs from hwmon, which happens to support I2C devices,
is not a problem for hwmon to solve, since the control is in the
thermal subsystem, and hwmon does not offer control solutions.


> 
> 
> > Telling that this has to be solved by another subsystem
> > for a sysfs node that is part of thermal subsystem does not really solve
> > the problem. Also as I mentioned, this is not common on all hwmon
> > devices, and not all I2C devices are hwmon devices. In fact, I2C
> > was just one example of a slow device. There are more I can quote
> > that are not necessarily under the hwmon case.
> 
> Yes, please. Can you give examples with existing drivers in the thermal
> framework and observed issues on specific platforms ? Numbers would help.

I believe I already gave you numbers. And as I explained above,
the driver does not need to sit on thermal subsystem only,
we already support plugging in I2C/pmbus devices on the thermal
subsystem, so basically all drivers on hwmon that has the REGISTER_TZ
flag are actual samples for this problem


-- 
All the best,
Eduardo Valentin
