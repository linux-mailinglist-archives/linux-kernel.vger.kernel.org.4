Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BCF74911E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 00:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGEWuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 18:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEWuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14941700;
        Wed,  5 Jul 2023 15:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FAD0617D6;
        Wed,  5 Jul 2023 22:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527F0C433C8;
        Wed,  5 Jul 2023 22:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688597400;
        bh=CdhZi57+ooX5Vh3nExJNISgtjgpzzCOryd04Ra8nj3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0QXoQpEibHTZDy3K/uXjUKiXySjGXGLKGZ4ars+Jduh+DTuQ9wgdZqm/47b8pxTU
         uzIZ16sVlxBPQeLBrNpZbFfU3OfDJVvD8lDTi0K4xT1RhCyYcB3OMTjxR2wpolIqQ5
         ivL9H62wH1tAKJgqR4v4Q0/XrRDPSZaVOqsEXXiPcPcHbtgDqbJ4XpZPfGf1deGG6R
         9DuJMUHsOhk8Q6MLZgOhK2ITP/X3tMQwH0eXbkcVK5R4/iSQjILR1LiCm4VzXqb11T
         WExhbd0tmTIf3Rg1dRkH3vRR0GdPaeqS7yKDRLrAg8oKCroxRFrFajvCqTwXtmZprM
         AHgfob34p/0SA==
Date:   Wed, 5 Jul 2023 15:49:58 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Message-ID: <ZKXzli5BtRF9u5de@uf8f119305bce5e.ant.amazon.com>
References: <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
 <2d59de0d-5011-780a-cb6c-94e6e2b74156@linaro.org>
 <CAJZ5v0jQssaVMim3b3yWEqw2NGt4SYSZP6Zb4i5O++=9Tp7C3w@mail.gmail.com>
 <1373aef0-c837-8e6f-fc94-9c6bd70a5b31@linaro.org>
 <ZJ+GIRfhuHxbSxRf@uf8f119305bce5e.ant.amazon.com>
 <0c766514-1063-bb57-192e-332559e22529@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c766514-1063-bb57-192e-332559e22529@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 09:28:31AM +0200, Daniel Lezcano wrote:
> 
> 
> 
> Eduardo,
> 
> On 01/07/2023 03:49, Eduardo Valentin wrote:
> 
> [ ... ]
> 
> > > All that are hypothesis, that is why having a real use case would help
> > > to figure out the temperature limit drift at mitigation time.
> > 
> > Yeah, I guess the problem here is that you are assuming I2C is not a real
> > use case, not sure why. But it is and very common design in fact.
> 
> If it is so common you should be able to reproduce the issue and give
> numbers. At this point, what I read is "that may happen because I2C is
> slow and we may monitor it at an insane rate, so let's cache the value".
> 
> > > Assuming it is really needed, I'm not sure that should be exported via
> > > sysfs. It is a driver issue and it may register the thermal zone with a
> > > parameter telling the userspace rate limit.
> > > 
> > > On the other side, hwmon and thermal are connected. hwmon drivers
> > > register a thermal zone and thermal drivers add themselves in the hwmon
> > > sysfs directory. The temperature cache is handled in the driver level in
> > > the hwmon subsystems and we want to handle the temperature cache at the
> > > thermal sysfs level. How will we cope with this inconsistency?
> > 
> > Yeah, I do not see this, again, as where to handle cache type of design problem only.
> > This is really a protective / defensive code on the thermal core to avoid
> > userspace interfering on a kernel based control.
> > 
> > 
> > I agree that drivers may be free to go and defend themselves against
> > too frequent userspace requests, like they do, as you already shared
> > a link in another email. But saying that it is up to the driver to do this
> > is basically saying that the thermal subsystem do not care about their
> > own threads being delayed by a too frequent reads on a sysfs entry
> > created by the thermal subsystem, just because it is drivers responsability
> > to cache. To that is a missing defensive code.
> 
> No, the core code has not to be defensive against bad hardware design.

I do not understand why you are calling this a bad hardware design.

> 
> If multiple processes are reading in an infinite loop the temperature,
> they will constantly take the lock, and as the monitoring thread is a
> CFS task, this one will be considered as the readers and be delayed,
> with probably a mitigation temperature drift. Here we have a missing
> defensive / optimized code against a DoS but it is unrelated to the
> hardware and the fix is not caching the value.

I am not even going into the CFS discussion, yet. But if we go that direction,
here we are having a case of a userspace process contending into
a in kernel process, regardless of the userspace process priority.

But again that is not the main point of discussion for this change.

> 
> > > As a side note, slow drivers are usually going under drivers/hwmon.
> > 
> > Have you seen this code?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/lm75.c#n517
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/hwmon.c#n850
> 
> Yes, and ?


I mean , I am sure can git grep for all occurences if that is what are looking for.
> 
> That is what I said, the hwmon and the thermal zone are connected.
> 
> > I also do not understand when you say slow drivers are usually going under
> > drivers/hwmon, does it really matter? One can design a thermal zone
> > that is connected to a hwmon device as input. Why would that be illogical?
> 
> I'm not saying it is illogical. I'm pointing the slow drivers are under
> hwmon subsystems and usually don't aim in-kernel mitigation. The
> get_temp ops is going through hwmon and the drivers may cache the
> values. So *if* there is an in-kernel mitigation, the value will be
> already cached usually.

Oh I see. yes, I totally give you that the most common case is to have
the in kernel policy written with drivers under thermal, but neglecting
the existence of drivers under /hwmon that connects into the thermal subsystem
is not fair, is it? They are there, they connect to thermal subsystem
and one can certainly have an in kernel control with hwmon drivers as input,
I am not understanding why protecting against those cases make the change
invalid or overcomplicates the subsystem design.

> 
> I do believe I raised some valid concerns regarding the approach. Could
> please take them into account instead of eluding them
> 
> 1. A real use case with temperature limit drift (easy to reproduce
> because it is very common)
> 
> 2. How about the consistency between hwmon and thermal? (one driver but
> two ways to access the temperature - one may cache and the other not)

I am not eluding anything. But this conversation seams to not move forward
because of the assumption that building in kernel control based on
hwmon drivers is either wrong or uncommon.  I fail to see that as the
main argument to be discussed mainly because it is a problem that exists.
Driver count is also not a meaningful metric to conclude if the problem
is common or not. How many motherboard can you think that are out there
that may have an lm75 to represent an actual temperature point in the
PCB? Or an lm75 that may come from a PCI board? That is what I meant
by common design.

Seams to me that you are trying to make a point that this problem
is not worth having a fix for, even if you already recognized the
basic point of it, because (a) this is not happening MMIO based
drivers which is the (today) common case for drivers under /thermal
and (b) hwmon drivers are supposed to feed in only control in userspace.

for both argument that seams to restrict the thermal subsystem
to only MMIO base devices drivers to feed into CPU temperature control,
which is a limited application of it in real world scenario, for
any real life scenario really, mobile. BMC, or any embedded case. 
When in fact, the abstraction and desing on the thermal subsystem today
is pure control of temperature and can be used in any application
that does it. Limiting the application of the thermal subsystem to
only MMIO based devices is, well, limiting :-).

> 
> Another question regarding the I2C example, if another subsystem is
> using the I2C, won't it take the bus lock and create the contention
> also? I mean it is possible to create a mitigation drift by reading
> constantly another sensor value (eg. voltage or whatever) ?

Yes, if a flood of events in the bus happen, then the drift will also happen,
specially if reads are aligned with the in kernel monitoring thread
update / call to .get_temp().

> 
> 
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
All the best,
Eduardo Valentin
