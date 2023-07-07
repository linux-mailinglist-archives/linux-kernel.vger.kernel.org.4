Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE57674B599
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGGROP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGGROO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE201BE8;
        Fri,  7 Jul 2023 10:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EB8661A15;
        Fri,  7 Jul 2023 17:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1DEC433C8;
        Fri,  7 Jul 2023 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688750051;
        bh=grjrpDDuXrcXco+TAikudw5vn7ZiNKw/LMhmZ8FUjso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBkCvuogO54/jZ35R2u7HeWkGHxOaM3vRS01W4c7TBVLgNIl7SXT2hLmE2UGGAfQo
         kEcxNzZxc2PZaXHlzNkp82im05TMPo9UpCcAwpqTEVE3dGg4HRbjvnFRerWCiPEDZD
         0K4ybvMrOX3AjcmhwUY129KOVcCF595CVXA5Jbv7bBwCgCedrOQtYPbtTARylN6EbN
         RWRRVKpw+5snmziS2YNtfkm8559QqKPzwdGBih3ctSusuwODkswLGqla2cZlpJ//XN
         3Li4qeh9NIdNT91OBN/NMjl+dSgYgwuzzCWjS44vHNx/YgnP48XhtrzT1qMvGj+d2l
         sXjWrwqvh0ZkA==
Date:   Fri, 7 Jul 2023 10:14:09 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Message-ID: <ZKhH4e+70kM5P+Zd@uf8f119305bce5e.ant.amazon.com>
References: <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
 <2d59de0d-5011-780a-cb6c-94e6e2b74156@linaro.org>
 <CAJZ5v0jQssaVMim3b3yWEqw2NGt4SYSZP6Zb4i5O++=9Tp7C3w@mail.gmail.com>
 <1373aef0-c837-8e6f-fc94-9c6bd70a5b31@linaro.org>
 <ZJ+GIRfhuHxbSxRf@uf8f119305bce5e.ant.amazon.com>
 <0c766514-1063-bb57-192e-332559e22529@linaro.org>
 <ZKXzli5BtRF9u5de@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jRPh6_6ERf_d2AL+3bgTqhqi0f4oNS+91omXt9-q9cRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jRPh6_6ERf_d2AL+3bgTqhqi0f4oNS+91omXt9-q9cRQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 03:22:55PM +0200, Rafael J. Wysocki wrote:
> 
> 
> 
> On Thu, Jul 6, 2023 at 12:50 AM Eduardo Valentin <evalenti@kernel.org> wrote:
> >
> > On Sat, Jul 01, 2023 at 09:28:31AM +0200, Daniel Lezcano wrote:
> > >
> > >
> > >
> > > Eduardo,
> > >
> > > On 01/07/2023 03:49, Eduardo Valentin wrote:
> > >
> > > [ ... ]
> > >
> > > > > All that are hypothesis, that is why having a real use case would help
> > > > > to figure out the temperature limit drift at mitigation time.
> > > >
> > > > Yeah, I guess the problem here is that you are assuming I2C is not a real
> > > > use case, not sure why. But it is and very common design in fact.
> > >
> > > If it is so common you should be able to reproduce the issue and give
> > > numbers. At this point, what I read is "that may happen because I2C is
> > > slow and we may monitor it at an insane rate, so let's cache the value".
> > >
> > > > > Assuming it is really needed, I'm not sure that should be exported via
> > > > > sysfs. It is a driver issue and it may register the thermal zone with a
> > > > > parameter telling the userspace rate limit.
> > > > >
> > > > > On the other side, hwmon and thermal are connected. hwmon drivers
> > > > > register a thermal zone and thermal drivers add themselves in the hwmon
> > > > > sysfs directory. The temperature cache is handled in the driver level in
> > > > > the hwmon subsystems and we want to handle the temperature cache at the
> > > > > thermal sysfs level. How will we cope with this inconsistency?
> > > >
> > > > Yeah, I do not see this, again, as where to handle cache type of design problem only.
> > > > This is really a protective / defensive code on the thermal core to avoid
> > > > userspace interfering on a kernel based control.
> > > >
> > > >
> > > > I agree that drivers may be free to go and defend themselves against
> > > > too frequent userspace requests, like they do, as you already shared
> > > > a link in another email. But saying that it is up to the driver to do this
> > > > is basically saying that the thermal subsystem do not care about their
> > > > own threads being delayed by a too frequent reads on a sysfs entry
> > > > created by the thermal subsystem, just because it is drivers responsability
> > > > to cache. To that is a missing defensive code.
> > >
> > > No, the core code has not to be defensive against bad hardware design.
> >
> > I do not understand why you are calling this a bad hardware design.
> >
> > >
> > > If multiple processes are reading in an infinite loop the temperature,
> > > they will constantly take the lock, and as the monitoring thread is a
> > > CFS task, this one will be considered as the readers and be delayed,
> > > with probably a mitigation temperature drift. Here we have a missing
> > > defensive / optimized code against a DoS but it is unrelated to the
> > > hardware and the fix is not caching the value.
> >
> > I am not even going into the CFS discussion, yet. But if we go that direction,
> > here we are having a case of a userspace process contending into
> > a in kernel process, regardless of the userspace process priority.
> >
> > But again that is not the main point of discussion for this change.
> >
> > >
> > > > > As a side note, slow drivers are usually going under drivers/hwmon.
> > > >
> > > > Have you seen this code?
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/lm75.c#n517
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/hwmon.c#n850
> > >
> > > Yes, and ?
> >
> >
> > I mean , I am sure can git grep for all occurences if that is what are looking for.
> > >
> > > That is what I said, the hwmon and the thermal zone are connected.
> > >
> > > > I also do not understand when you say slow drivers are usually going under
> > > > drivers/hwmon, does it really matter? One can design a thermal zone
> > > > that is connected to a hwmon device as input. Why would that be illogical?
> > >
> > > I'm not saying it is illogical. I'm pointing the slow drivers are under
> > > hwmon subsystems and usually don't aim in-kernel mitigation. The
> > > get_temp ops is going through hwmon and the drivers may cache the
> > > values. So *if* there is an in-kernel mitigation, the value will be
> > > already cached usually.
> >
> > Oh I see. yes, I totally give you that the most common case is to have
> > the in kernel policy written with drivers under thermal, but neglecting
> > the existence of drivers under /hwmon that connects into the thermal subsystem
> > is not fair, is it? They are there, they connect to thermal subsystem
> > and one can certainly have an in kernel control with hwmon drivers as input,
> > I am not understanding why protecting against those cases make the change
> > invalid or overcomplicates the subsystem design.
> >
> > >
> > > I do believe I raised some valid concerns regarding the approach. Could
> > > please take them into account instead of eluding them
> > >
> > > 1. A real use case with temperature limit drift (easy to reproduce
> > > because it is very common)
> > >
> > > 2. How about the consistency between hwmon and thermal? (one driver but
> > > two ways to access the temperature - one may cache and the other not)
> >
> > I am not eluding anything. But this conversation seams to not move forward
> > because of the assumption that building in kernel control based on
> > hwmon drivers is either wrong or uncommon.  I fail to see that as the
> > main argument to be discussed mainly because it is a problem that exists.
> > Driver count is also not a meaningful metric to conclude if the problem
> > is common or not. How many motherboard can you think that are out there
> > that may have an lm75 to represent an actual temperature point in the
> > PCB? Or an lm75 that may come from a PCI board? That is what I meant
> > by common design.
> >
> > Seams to me that you are trying to make a point that this problem
> > is not worth having a fix for, even if you already recognized the
> > basic point of it, because (a) this is not happening MMIO based
> > drivers which is the (today) common case for drivers under /thermal
> > and (b) hwmon drivers are supposed to feed in only control in userspace.
> >
> > for both argument that seams to restrict the thermal subsystem
> > to only MMIO base devices drivers to feed into CPU temperature control,
> > which is a limited application of it in real world scenario, for
> > any real life scenario really, mobile. BMC, or any embedded case.
> > When in fact, the abstraction and desing on the thermal subsystem today
> > is pure control of temperature and can be used in any application
> > that does it. Limiting the application of the thermal subsystem to
> > only MMIO based devices is, well, limiting :-).
> >
> > >
> > > Another question regarding the I2C example, if another subsystem is
> > > using the I2C, won't it take the bus lock and create the contention
> > > also? I mean it is possible to create a mitigation drift by reading
> > > constantly another sensor value (eg. voltage or whatever) ?
> >
> > Yes, if a flood of events in the bus happen, then the drift will also happen,
> > specially if reads are aligned with the in kernel monitoring thread
> > update / call to .get_temp().
> 
> This is all in general terms, though.
> 
> I think that Daniel has been asking for a specific example, because if
> a new sysfs i/f is added with a certain issue in mind and then it
> turns out to be never used by anyone, because the issue is theoretical
> or not severe enough for anyone to care, it is a pure maintenance
> burden.  It would be good to have at least some assurance that this
> will not be the case.
> 
> Daniel, even if you think that the hardware in question is
> misdesigned, Linux has a long record of supporting misdesigned
> hardware, so this wouldn't be the first time ever.  However, I do
> agree that it would be good to have a specific example supporting this
> case.


I will add some examples in the next version with the numbers I quoted in this thread.

Also, generally speaking, this series uses the thermal subsystem mostly
for board monitoring use cases, which includes applications like BMC,
and that has generated some churn because the current set of existing
drivers mainly targets in-kernel control for the running system CPU temperature monitoring.
However, even since time of thermal device tree binding conception, this limitation
was never part of the original thoughts on enhancing the thermal subsystem from
ACPI only to a more general solution.

For this reason, next iteration I will start with enhancing documentation.
I took a brief look in the existing master tree and plenty of
the existing documentation references to board monitoring have been lost
in reshuffle of thermal documentation files, including thermal device tree
bindings, which is a shame. I will recover those examples with refreshed examples.
Thermal doc has been not the prettiest anyways so it is always good to spend
some time enhancing it.

-- 
All the best,
Eduardo Valentin
