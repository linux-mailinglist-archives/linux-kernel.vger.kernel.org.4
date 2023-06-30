Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463AA7436D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjF3IQ5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 04:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjF3IQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:16:54 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D56F1FCD;
        Fri, 30 Jun 2023 01:16:52 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-98273ae42d0so44974766b.0;
        Fri, 30 Jun 2023 01:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113011; x=1690705011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfxbwdpeMQQvTv31Oc0SVR3lIYY6m47WR3xIKyZ9hIw=;
        b=cV4rvpaQSJY6zb+kuZYYrOQWkPmNRDnjih616XOInM3L5I9ZL9x6s7hCaac/Vy9BuK
         9GfaCtiELyn5itKgQqqpka+nmZN35W68NC1YQKdAEOqfYwz9ysKpxrJ0w1Fm0CGHdlna
         bMBHGKSgr+ZcQJsIwXlF/KsMXQ0BMjQ0Oo3n1z6Ps+F4sGkE+pzaFX6vSbJua+ZMtF99
         erm3ceM/hLnavqa1XuAQoAYKnA37+su7I2xIeiEoBZVdOW6cV+KTRU2+zqwQnkTRhQ9w
         KuAEVpl9iQzA6PLSRn3QrXVcRQfSAzVE0eR63wUQan2fpPZYZGFZAA9FFaN5CoT54Cnq
         36yw==
X-Gm-Message-State: ABy/qLZBZwyozK2yhIU45CFnEMSRoX+sFrW0Vy69fM2U/arMbyVlXjfB
        FV0GHU31oS6PxJxDY0bDVgOlIP9gntPJNtsnGXo=
X-Google-Smtp-Source: APBJJlGI/phyaqONAXVUW2D0a4O01+FZA8vfbKUd3DyOJ2+sKDVQ+gy3JrTkE46Q5rKwvvb5pSvrdgobDVJFwKkcE68=
X-Received: by 2002:a17:906:ccc3:b0:98e:46f:3eab with SMTP id
 ot3-20020a170906ccc300b0098e046f3eabmr1362190ejb.6.1688113010602; Fri, 30 Jun
 2023 01:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230607003721.834038-1-evalenti@kernel.org> <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com> <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com> <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com> <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com> <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
In-Reply-To: <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jun 2023 10:16:38 +0200
Message-ID: <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
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

On Wed, Jun 28, 2023 at 11:10 PM Eduardo Valentin <evalenti@kernel.org> wrote:
>
> On Fri, Jun 23, 2023 at 07:31:43PM +0200, Rafael J. Wysocki wrote:
> >

[cut]

> >
> > Regardless of where the problem is etc, if my understanding of the
> > patch is correct, it is proposing to change the behavior of a
> > well-known sysfs interface in a way that is likely to be incompatible
> > with at least some of its users.  This is an obvious no-go in kernel
> > development and I would expect you to be well aware of it.
>
> yeah I get it.
>
> >
> > IOW, if you want the cached value to be returned, a new interface (eg.
> > a new sysfs attribute) is needed.
>
> Yeah, I am fine with either a new sysfs entry to return the cached value,
> or a new sysfs entry to change the behavior of the existing /temp, as I
> mentioned before, either way works for me, if changing the existing one
> is too intrusive.
>
> >
> > And I think that the use case is not really i2c sensors in general,
>
> I2C was just the factual example I had, but you are right, the use case
> is not isolated to I2C sensor. Rather, to be clear I am not blaming I2C,
> the actual issue just happen to be easier to see when I2C devices, slower
> than typical MMIO devices, are being used as input for the control.
>
> > because at least in some cases they work just fine AFAICS, but a
> > platform with a control loop running in the kernel that depends on
> > sensor reads carried out at a specific, approximately constant, rate
> > that can be disturbed by user space checking the sensor temperature
> > via sysfs at "wrong" times.  If at the same time the user space
> > program in question doesn't care about the most recent values reported
> > by the sensor, it may very well use the values cached by the in-kernel
> > control loop.
>
> That is right, the balance between supporting user space reads and
> running the control timely is the actual original concern. The problem
> fades out a bit when you have device reads in the us / ns time scale
> and control update is in 100s of ms. But becomes more apparent on slower
> devices, when reads are in ms and policy update is in the 100s ms, that is
> why the I2C case was quoted. But nothing wrong with I2C, or supporting
> I2C on the thermal subsystem as we do today via the hwmon interface REGISTER_TZ,
> the problem is on having to support the control in kernel and a read in
> userspace that can create jitter to the control.
>
> And as you properly stated, for this use case, the userspace does not care
> about the most recent value of the device, so that is why the change
> proposes to give cached values.
>
> On the flip side though, there may be user space based policies that
> require the most recent device value. But in this case, the expectation
> is to disable the in kernel policy and switch the thermal zone to
> mode == disabled. And that is also why this patch will go the path
> to request the most recent device value when the /temp sysfs entry
> is read and the mode is disabled.
>
> I would suggest to have an addition sysfs entry that sets the
> thermal zone into cached mode or not, let's say for the sake of the
> discussion, we call it 'cached_values', with default to 'not cached'.
> This way, we could support:
>
> a) Default, current situation, where all reads in /temp are always backed up
> with an actual device .get_temp(). Nothing changes here, keeps reading
> under /temp, and so long system designer is satisfied with jittering,
> no need to change anything.
>
> b) When one has control in kernel, and frequent userspace reads on /temp
> but system designer wants to protect the control in kernel to avoid jittering.
> Just keep reading from /temp but set the new sysfs property 'cached_values' to 'cached'.
> Then userspace will get updated values as frequent as the kernel control has
> and the kernel control will not be disturbed by frequent device reads.
>
> c) When one has control in userspace, and wants to have the most frequent
> device read. Here, one can simply disable the in kernel control by
> setting the 'mode' sysfs entry to 'disabled', and making sure the new sysfs property is set
> to 'not cached'. Well in fact, the way I thought this originally in this patch
> was to simply always read the device when /temp is read is 'mode' is 'disabled'.
>
> I believe you proposed to have another sysfs entry  sysfs entry for reading cached temperature.
> Something like 'temp_cached'. Thinking of it, as I mentioned before, it will work.
> The only possible downside is to have two entries to read temperature.
>
> Strong opinions on any of the above?

So what about adding a new zone attribute that can be used to specify
the preferred caching time for the temperature?

That is, if the time interval between two consecutive updates of the
cached temperature value is less than the value of the new attribute,
the cached temperature value will be returned by "temp".  Otherwise,
it will cause the sensor to be read and the value obtained from it
will be returned to user space and cached.

If the value of the new attribute is 0, everything will work as it
does now (which will also need to be the default behavior).
