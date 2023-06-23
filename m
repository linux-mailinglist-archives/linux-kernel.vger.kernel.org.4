Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A8F73BDD2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjFWRcC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 13:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjFWRb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:31:59 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEAB1FCE;
        Fri, 23 Jun 2023 10:31:56 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b57b4e95a8so3038411fa.1;
        Fri, 23 Jun 2023 10:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687541515; x=1690133515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOE+wA84bUgsrB1AzgI2LWtxgwxjdnvrreNkwnCKlM4=;
        b=YWYQIAtX2f6BxL4OPRJIcii2RtFdCvCWCAHH5v7LVU//W3hDduEvq2myTiT8M3TidR
         JTL8Jt4uwM39WZImpdgJdS8uvUylG2z8GmtSOQzeDqbGlL8zS7A95ca6AqNfm7y7Fqm6
         l2F+yHD4uC87O71Y0LtDr27YK8haWd90Pj4EpS7nhEs0e1IK+4mL7H4rmo6A9cbJ0QtY
         /Oo9H0Q7AY5FutwgaKoAIc9XTlwin/7LXjrTDTAo7pWHV6awraKxgvzWXhFWVnD1dDrS
         T1zr1V/d0ZJUe9tEToxoImglR6mQtKj/FcskyL6tCwyNilvZJdHc+g7JnSDFeTskqdQz
         4AAw==
X-Gm-Message-State: AC+VfDwTZu24jtMk/R6v00IyhuMNaOKMT1oGsUVOaVPE7xGDWjAd9fpl
        pB4meDgS9JUs9pMcygup5Wd4LlM1XjLNJHs9xs4=
X-Google-Smtp-Source: ACHHUZ5GM58vz8yYEuxsD8CNzGT05eOKZYG6ay3XXTPUxwgDeLliAMWGobFGGvZeH9zpc6JSF1zoYG8vWPxdVCKYYpQ=
X-Received: by 2002:a05:651c:1187:b0:2b4:799e:fb3e with SMTP id
 w7-20020a05651c118700b002b4799efb3emr7829671ljo.1.1687541514886; Fri, 23 Jun
 2023 10:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230607003721.834038-1-evalenti@kernel.org> <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com> <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com> <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com> <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
In-Reply-To: <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Jun 2023 19:31:43 +0200
Message-ID: <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, eduval@amazon.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 6:56 AM Eduardo Valentin <evalenti@kernel.org> wrote:
>
> On Wed, Jun 21, 2023 at 01:43:26PM +0200, Daniel Lezcano wrote:
> >
> >
> >
> > On 21/06/2023 07:06, Eduardo Valentin wrote:
> > > On Mon, Jun 12, 2023 at 10:17:51AM +0200, Daniel Lezcano wrote:
> > > >
> > > >
> > > >
> > > > Hi Eduardo,
> > > >
> > > > On 08/06/2023 19:44, Eduardo Valentin wrote:
> > > >
> > > > [ ... ]
> > > >
> > > > > > Do you have a use case with some measurements to spot an issue or is it
> > > > > > a potential issue you identified ?
> > > > >
> > > > >
> > > > > yes, a governor that is using I2C device as input, behind I2C fast mode (100KHz)
> > > > > and needs to update the zone every 100ms. Each read in this bus, if done alone
> > > > > would be around 500us, takes 10bytes to read the device, it is 10 clocks per byte,
> > > > > well technically 9, but rounding for the sake of the example, which gets you
> > > > > 50 / 100KHz = 500 us. That is for a single read. You add one single extra
> > > > > userspace read triggering an unused device update, that is already a 1ms drift.
> > > > > Basically you looking at 0.5% for each extra userspace read competing in this
> > > > > sysfs node. You add extra devices in the same I2C bus, your governor is looking
> > > > > at more than 1% overhead. And I am talking also about a main CPU of ~800MHz.
> > > > > I did not even include the lock overhead considered for this CPU ;-)
> > > > >
> > > > > Again, this is not about controlling the DIE temperature of the CPU you
> > > > > are running the thermal subsystem. This is about controlling
> > > > > a target device.
> > > >
> > > > Ok. The target device is on a bus which is slow and prone to contention.
> > > >
> > > > This hardware is not designed to be monitored with a high precision, so
> > > > reading the temperature at a high rate does not really make sense.
> > >
> > > On the contrary, it needs even more precision and any extra delay adds to
> > > loss on accuracy :-)
> >
> > What I meant is if the hardware designer thought there could be a
> > problem with the thermal zone they would have put another kind of
> > sensor, not one with a i2c based communication.
>
> No, that is not a problem in the physical thermal zone. Or to cover
> for a hardware design flaw. This is an actual typical case. However,
> yes, designer must take into account any sort of delays or jittering
> in the control system, and typically one would add some thermal margins
> on the control system. But to the original point here, we should eliminate
> unnecessary jittering or delay in the control system.
>
> >
> >
> > > > Moreover (putting apart a potential contention), the delayed read does
> > > > not change the time interval, which remains the same from the governor
> > > > point of view.
> > >
> > > It does not change the governor update interval and that is a property of
> > > the thermal zone. Correct. And that is the intention of the change.
> > > The actual temperature updates driven by the governor will always
> > > result in a driver call. While a userspace call will not be in the way
> > > of the governor update.
> > >
> > > Sysfs reads, However, with the current code as is, it may cause
> > > jittering on the actual execution of the governor throttle function.
> > >   causing the computation of the desired outcome cooling device being skewed.
> > >
> > > >
> > > > In addition, i2c sensors are usually handled in the hwmon subsystem
> > > > which are registered in the thermal framework from there. Those have
> > > > most of their 'read' callback with a cached value in a jiffies based way
> > > > eg. [1].
> > >
> > > I guess what you are really saying is: go read the hwmon sysfs node,
> > > or, hwmon solves this for us, which unfortunately is not true for all devices.
> >
> > I meant the i2c sensors are under the hwmon subsystem. This subsystem is
> > connected with the thermal framework, so when a hwmon sensor is created,
> > it register this sensor as a thermal zone.
> >
> >
> > > > So the feature already exists for slow devices and are handled in the
> > > > drivers directly via the hwmon subsystem.
> > > >
> > > >  From my POV, the feature is not needed in the thermal framework.
> > >
> > > The fact that hwmon does it in some way is another evidence of the
> > > actual problem.
> >
> > Not really, it shows the i2c sensors are in the hwmon subsystems.
>
> They are there too. And hwmon also sees same problem of too frequent
> device update. The problem is there regardless of the subsystem we use
> to represent the device. Also, I dont buy the argument that this is
> a problem of hwmon because it is already supported to plug in
> hwmon devices in the thermal subsystem. That is actually the original
> design in fact :-). So running a control in the thermal subsystem
> on top of inputs from hwmon, which happens to support I2C devices,
> is not a problem for hwmon to solve, since the control is in the
> thermal subsystem, and hwmon does not offer control solutions.

Regardless of where the problem is etc, if my understanding of the
patch is correct, it is proposing to change the behavior of a
well-known sysfs interface in a way that is likely to be incompatible
with at least some of its users.  This is an obvious no-go in kernel
development and I would expect you to be well aware of it.

IOW, if you want the cached value to be returned, a new interface (eg.
a new sysfs attribute) is needed.

And I think that the use case is not really i2c sensors in general,
because at least in some cases they work just fine AFAICS, but a
platform with a control loop running in the kernel that depends on
sensor reads carried out at a specific, approximately constant, rate
that can be disturbed by user space checking the sensor temperature
via sysfs at "wrong" times.  If at the same time the user space
program in question doesn't care about the most recent values reported
by the sensor, it may very well use the values cached by the in-kernel
control loop.
