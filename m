Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A78A7445E2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 03:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjGABiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 21:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGABiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 21:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376F44201;
        Fri, 30 Jun 2023 18:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976F361751;
        Sat,  1 Jul 2023 01:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C71C433C8;
        Sat,  1 Jul 2023 01:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688175479;
        bh=dINvi1s8N3Nm2ZPsPVOPrM4C4O6oID6cNW31iu48MNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZswgHWCQkOrbDjOoZ9n8fdQsUGNSaQqFraoRJUdk363hfqhvNxCi0IAbo0pfOCDF
         BTW/7X/Ez+gV3fsXuVeC7FBTc98B3UMK91b/jlkOS1HTzWz1MKw4Qpm4EPrGJkpRLT
         IWMwgU82DRRGxnJtT/eRbHX3GqcJ8Ue0i+9fbI8N4jG/gt8uR5TpobvCwHtf6Suq4q
         UYo+GuY/jbLXs/f999wqVI3Um7vwecCkCnrqwtqew1lDr2yfjTv/V8q/EhpTSP1l6A
         /0wOmc6soD7Htz7b4eAqS54LgfccdYmO2DdALd3yT8yZZ4akuYpcEtbSb+iBYbxy5T
         R7VnjYCI6CzLA==
Date:   Fri, 30 Jun 2023 18:37:57 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Message-ID: <ZJ+DdYpPEEjehoFP@uf8f119305bce5e.ant.amazon.com>
References: <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
 <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
 <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
 <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 10:16:38AM +0200, Rafael J. Wysocki wrote:
> 
> 
> 
> On Wed, Jun 28, 2023 at 11:10 PM Eduardo Valentin <evalenti@kernel.org> wrote:
> >
> > On Fri, Jun 23, 2023 at 07:31:43PM +0200, Rafael J. Wysocki wrote:
> > >
> 
> [cut]
> 
> > >
> > > Regardless of where the problem is etc, if my understanding of the
> > > patch is correct, it is proposing to change the behavior of a
> > > well-known sysfs interface in a way that is likely to be incompatible
> > > with at least some of its users.  This is an obvious no-go in kernel
> > > development and I would expect you to be well aware of it.
> >
> > yeah I get it.
> >
> > >
> > > IOW, if you want the cached value to be returned, a new interface (eg.
> > > a new sysfs attribute) is needed.
> >
> > Yeah, I am fine with either a new sysfs entry to return the cached value,
> > or a new sysfs entry to change the behavior of the existing /temp, as I
> > mentioned before, either way works for me, if changing the existing one
> > is too intrusive.
> >
> > >
> > > And I think that the use case is not really i2c sensors in general,
> >
> > I2C was just the factual example I had, but you are right, the use case
> > is not isolated to I2C sensor. Rather, to be clear I am not blaming I2C,
> > the actual issue just happen to be easier to see when I2C devices, slower
> > than typical MMIO devices, are being used as input for the control.
> >
> > > because at least in some cases they work just fine AFAICS, but a
> > > platform with a control loop running in the kernel that depends on
> > > sensor reads carried out at a specific, approximately constant, rate
> > > that can be disturbed by user space checking the sensor temperature
> > > via sysfs at "wrong" times.  If at the same time the user space
> > > program in question doesn't care about the most recent values reported
> > > by the sensor, it may very well use the values cached by the in-kernel
> > > control loop.
> >
> > That is right, the balance between supporting user space reads and
> > running the control timely is the actual original concern. The problem
> > fades out a bit when you have device reads in the us / ns time scale
> > and control update is in 100s of ms. But becomes more apparent on slower
> > devices, when reads are in ms and policy update is in the 100s ms, that is
> > why the I2C case was quoted. But nothing wrong with I2C, or supporting
> > I2C on the thermal subsystem as we do today via the hwmon interface REGISTER_TZ,
> > the problem is on having to support the control in kernel and a read in
> > userspace that can create jitter to the control.
> >
> > And as you properly stated, for this use case, the userspace does not care
> > about the most recent value of the device, so that is why the change
> > proposes to give cached values.
> >
> > On the flip side though, there may be user space based policies that
> > require the most recent device value. But in this case, the expectation
> > is to disable the in kernel policy and switch the thermal zone to
> > mode == disabled. And that is also why this patch will go the path
> > to request the most recent device value when the /temp sysfs entry
> > is read and the mode is disabled.
> >
> > I would suggest to have an addition sysfs entry that sets the
> > thermal zone into cached mode or not, let's say for the sake of the
> > discussion, we call it 'cached_values', with default to 'not cached'.
> > This way, we could support:
> >
> > a) Default, current situation, where all reads in /temp are always backed up
> > with an actual device .get_temp(). Nothing changes here, keeps reading
> > under /temp, and so long system designer is satisfied with jittering,
> > no need to change anything.
> >
> > b) When one has control in kernel, and frequent userspace reads on /temp
> > but system designer wants to protect the control in kernel to avoid jittering.
> > Just keep reading from /temp but set the new sysfs property 'cached_values' to 'cached'.
> > Then userspace will get updated values as frequent as the kernel control has
> > and the kernel control will not be disturbed by frequent device reads.
> >
> > c) When one has control in userspace, and wants to have the most frequent
> > device read. Here, one can simply disable the in kernel control by
> > setting the 'mode' sysfs entry to 'disabled', and making sure the new sysfs property is set
> > to 'not cached'. Well in fact, the way I thought this originally in this patch
> > was to simply always read the device when /temp is read is 'mode' is 'disabled'.
> >
> > I believe you proposed to have another sysfs entry  sysfs entry for reading cached temperature.
> > Something like 'temp_cached'. Thinking of it, as I mentioned before, it will work.
> > The only possible downside is to have two entries to read temperature.
> >
> > Strong opinions on any of the above?
> 
> So what about adding a new zone attribute that can be used to specify
> the preferred caching time for the temperature?
> 
> That is, if the time interval between two consecutive updates of the
> cached temperature value is less than the value of the new attribute,
> the cached temperature value will be returned by "temp".  Otherwise,
> it will cause the sensor to be read and the value obtained from it
> will be returned to user space and cached.
> 
> If the value of the new attribute is 0, everything will work as it
> does now (which will also need to be the default behavior).


Yeah, that makes sense to me. I can cook something up in the next version.

-- 
All the best,
Eduardo Valentin
