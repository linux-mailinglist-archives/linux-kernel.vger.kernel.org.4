Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062087445F2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 03:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGABzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 21:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGABy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 21:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845E64212;
        Fri, 30 Jun 2023 18:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15F4861751;
        Sat,  1 Jul 2023 01:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20FDC433C7;
        Sat,  1 Jul 2023 01:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688176163;
        bh=RTe0T3RxVdjPQuqXPHZ4Bf8dxfr/q1YCAdVyhSYaVUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4+xC34Ony+evMPxFyKLFNGZabi21MaQZSWpgDGCDeUtv0nmEVEUY4dvtDMX2nI1x
         qWcD4HiUnhqsPyaDRbeGIZHzO3WEdWJiZGeiOrDSB+tVnO4V0k6rA+X0BmyQIMtSij
         7PChyfUcDQjfpmn1Qz8NDyCcl7QDGFavUjWblsjO/OMkSdlQVUPjWirXowR9NQfH6N
         ySQtMVt8VabwP1o7xMmKkEiiBRvW4GyJL4ZJ049BfIM949czfa4dqbE+EUZTtUroeN
         /EHesIVR7D/3ZJSHwckuQn5T+OHgPPFdRA6bhQGCI9gurLgM3hdI6URCauFYaSMgNA
         6X3l11HlBL3YA==
Date:   Fri, 30 Jun 2023 18:49:21 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Message-ID: <ZJ+GIRfhuHxbSxRf@uf8f119305bce5e.ant.amazon.com>
References: <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
 <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
 <2d59de0d-5011-780a-cb6c-94e6e2b74156@linaro.org>
 <CAJZ5v0jQssaVMim3b3yWEqw2NGt4SYSZP6Zb4i5O++=9Tp7C3w@mail.gmail.com>
 <1373aef0-c837-8e6f-fc94-9c6bd70a5b31@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1373aef0-c837-8e6f-fc94-9c6bd70a5b31@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 30, 2023 at 02:09:44PM +0200, Daniel Lezcano wrote:
> 
> 
> 
> On 30/06/2023 12:46, Rafael J. Wysocki wrote:
> > Hi Daniel,
> > 
> > On Fri, Jun 30, 2023 at 12:11 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > > 
> > > 
> > > Hi Rafael,
> > > 
> > > On 30/06/2023 10:16, Rafael J. Wysocki wrote:
> > > > On Wed, Jun 28, 2023 at 11:10 PM Eduardo Valentin <evalenti@kernel.org> wrote:
> > > 
> > > [ ... ]
> > > 
> > > > So what about adding a new zone attribute that can be used to specify
> > > > the preferred caching time for the temperature?
> > > > 
> > > > That is, if the time interval between two consecutive updates of the
> > > > cached temperature value is less than the value of the new attribute,
> > > > the cached temperature value will be returned by "temp".  Otherwise,
> > > > it will cause the sensor to be read and the value obtained from it
> > > > will be returned to user space and cached.
> > > > 
> > > > If the value of the new attribute is 0, everything will work as it
> > > > does now (which will also need to be the default behavior).
> > > 
> > > I'm still not convinced about the feature.
> > > 
> > > Eduardo provided some numbers but they seem based on the characteristics
> > > of the I2C, not to a real use case. Eduardo?
> > > 
> > > Before adding more complexity in the thermal framework and yet another
> > > sysfs entry, it would be interesting to have an experiment and show the
> > > impact of both configurations, not from a timing point of view but with
> > > a temperature mitigation accuracy.
> > > 
> > > Without a real use case, this feature does make really sense IMO.
> > 
> > I'm kind of unsure why you think that it is not a good idea in general
> > to have a way to limit the rate of accessing a temperature sensor, for
> > energy-efficiency reasons if nothing more.
> 
> I don't think it is not a good idea. I've no judgement with the proposed
> change.
> 
> But I'm not convinced it is really useful, that is why having a real use
> case and some numbers showing that feature solves the issue would be nice.
> 
> It is illogical we want a fast and accurate response on a specific
> hardware and then design it with slow sensors and contention prone bus.

Totally agree, but at same time, this is real world :-)

> 
> In Eduardo's example, we have 100ms monitoring rate on a I2C. This rate
> is usually to monitor CPUs with very fast transitions. With a remote
> site, the monitoring rate would be much slower, so if there is a
> contention in the bus because a dumb process is reading constantly the
> temperature, then it should be negligible.
> 
> All that are hypothesis, that is why having a real use case would help
> to figure out the temperature limit drift at mitigation time.

Yeah, I guess the problem here is that you are assuming I2C is not a real
use case, not sure why. But it is and very common design in fact.

> 
> Assuming it is really needed, I'm not sure that should be exported via
> sysfs. It is a driver issue and it may register the thermal zone with a
> parameter telling the userspace rate limit.
> 
> On the other side, hwmon and thermal are connected. hwmon drivers
> register a thermal zone and thermal drivers add themselves in the hwmon
> sysfs directory. The temperature cache is handled in the driver level in
> the hwmon subsystems and we want to handle the temperature cache at the
> thermal sysfs level. How will we cope with this inconsistency?

Yeah, I do not see this, again, as where to handle cache type of design problem only.
This is really a protective / defensive code on the thermal core to avoid
userspace interfering on a kernel based control.


I agree that drivers may be free to go and defend themselves against
too frequent userspace requests, like they do, as you already shared
a link in another email. But saying that it is up to the driver to do this
is basically saying that the thermal subsystem do not care about their
own threads being delayed by a too frequent reads on a sysfs entry
created by the thermal subsystem, just because it is drivers responsability
to cache. To that is a missing defensive code. 

> 
> As a side note, slow drivers are usually going under drivers/hwmon.

Have you seen this code?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/lm75.c#n517
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/hwmon.c#n850


I also do not understand when you say slow drivers are usually going under
drivers/hwmon, does it really matter? One can design a thermal zone
that is connected to a hwmon device as input. Why would that be illogical?


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
