Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CD3749CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjGFNDA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 09:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjGFNCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:02:55 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADB519A0;
        Thu,  6 Jul 2023 06:02:53 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-991f9148334so17618266b.1;
        Thu, 06 Jul 2023 06:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648572; x=1691240572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROZzyOO666TNx7fzn6G8xyIEzZlf0t0j8YuwaFtdhGc=;
        b=Ph7Rszqd2EDhxR593VDge3r516fzw2g0AHgyoQ98SzoaqR4So5PLwtUTfqQpKF6kx6
         KDGx+ibt/UMYi7xQSGoMmvAO1jvp9383+JOsV8kjCSXDkgDctcwZBSJCDuU5KZbAEIdO
         GMqxrBVOThm6wwQVNIvcwIZ5kRYcLD/21nu1Cumu32meF+ctxN6lUwCNX1/hV01a7+mG
         A8n1ma/T31JrP/kdpXNenqMyEnifeOHKGiwNdQQSJdru+6isD5yjj8N+5pshW0Lxecjx
         EHzGKihPafgJrWtqyC5zB27JPXzkfyF6saGLjBIZnvR558v0flGhm2wWb7AbjNNPSAT4
         52Mw==
X-Gm-Message-State: ABy/qLbMHClUcG8cH18htYRK3maLJm/GulcFWLlWcuHCtqONUwywZj83
        x4g3x8Hor+7RNfwuUvMIiUu4blVOjTICVfvL5Wc=
X-Google-Smtp-Source: APBJJlHWKb0rwWuDcDKo8RnYWexZr9+5UJpK+NbIEawG7Ru2BqBGWOyUIZPi1pxsg2+NzV4iq/IYUHpNhfJYlw5P+K8=
X-Received: by 2002:a17:906:51cc:b0:98e:32d:c390 with SMTP id
 v12-20020a17090651cc00b0098e032dc390mr1249327ejk.5.1688648571414; Thu, 06 Jul
 2023 06:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
 <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org> <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
 <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org> <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
 <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org> <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com> <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
 <ZJ+DdYpPEEjehoFP@uf8f119305bce5e.ant.amazon.com>
In-Reply-To: <ZJ+DdYpPEEjehoFP@uf8f119305bce5e.ant.amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jul 2023 15:02:38 +0200
Message-ID: <CAJZ5v0ix1T1V5B78MA=ut56K6G=KbZb_41BHwgGmcFrV9EpKFg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 1, 2023 at 3:37 AM Eduardo Valentin <evalenti@kernel.org> wrote:
>
> On Fri, Jun 30, 2023 at 10:16:38AM +0200, Rafael J. Wysocki wrote:
> >
> >
> >
> > On Wed, Jun 28, 2023 at 11:10 PM Eduardo Valentin <evalenti@kernel.org> wrote:
> > >
> > > On Fri, Jun 23, 2023 at 07:31:43PM +0200, Rafael J. Wysocki wrote:
> > > >
> >
> > [cut]
> >
> > > >
> > > > Regardless of where the problem is etc, if my understanding of the
> > > > patch is correct, it is proposing to change the behavior of a
> > > > well-known sysfs interface in a way that is likely to be incompatible
> > > > with at least some of its users.  This is an obvious no-go in kernel
> > > > development and I would expect you to be well aware of it.
> > >
> > > yeah I get it.
> > >
> > > >
> > > > IOW, if you want the cached value to be returned, a new interface (eg.
> > > > a new sysfs attribute) is needed.
> > >
> > > Yeah, I am fine with either a new sysfs entry to return the cached value,
> > > or a new sysfs entry to change the behavior of the existing /temp, as I
> > > mentioned before, either way works for me, if changing the existing one
> > > is too intrusive.
> > >
> > > >
> > > > And I think that the use case is not really i2c sensors in general,
> > >
> > > I2C was just the factual example I had, but you are right, the use case
> > > is not isolated to I2C sensor. Rather, to be clear I am not blaming I2C,
> > > the actual issue just happen to be easier to see when I2C devices, slower
> > > than typical MMIO devices, are being used as input for the control.
> > >
> > > > because at least in some cases they work just fine AFAICS, but a
> > > > platform with a control loop running in the kernel that depends on
> > > > sensor reads carried out at a specific, approximately constant, rate
> > > > that can be disturbed by user space checking the sensor temperature
> > > > via sysfs at "wrong" times.  If at the same time the user space
> > > > program in question doesn't care about the most recent values reported
> > > > by the sensor, it may very well use the values cached by the in-kernel
> > > > control loop.
> > >
> > > That is right, the balance between supporting user space reads and
> > > running the control timely is the actual original concern. The problem
> > > fades out a bit when you have device reads in the us / ns time scale
> > > and control update is in 100s of ms. But becomes more apparent on slower
> > > devices, when reads are in ms and policy update is in the 100s ms, that is
> > > why the I2C case was quoted. But nothing wrong with I2C, or supporting
> > > I2C on the thermal subsystem as we do today via the hwmon interface REGISTER_TZ,
> > > the problem is on having to support the control in kernel and a read in
> > > userspace that can create jitter to the control.
> > >
> > > And as you properly stated, for this use case, the userspace does not care
> > > about the most recent value of the device, so that is why the change
> > > proposes to give cached values.
> > >
> > > On the flip side though, there may be user space based policies that
> > > require the most recent device value. But in this case, the expectation
> > > is to disable the in kernel policy and switch the thermal zone to
> > > mode == disabled. And that is also why this patch will go the path
> > > to request the most recent device value when the /temp sysfs entry
> > > is read and the mode is disabled.
> > >
> > > I would suggest to have an addition sysfs entry that sets the
> > > thermal zone into cached mode or not, let's say for the sake of the
> > > discussion, we call it 'cached_values', with default to 'not cached'.
> > > This way, we could support:
> > >
> > > a) Default, current situation, where all reads in /temp are always backed up
> > > with an actual device .get_temp(). Nothing changes here, keeps reading
> > > under /temp, and so long system designer is satisfied with jittering,
> > > no need to change anything.
> > >
> > > b) When one has control in kernel, and frequent userspace reads on /temp
> > > but system designer wants to protect the control in kernel to avoid jittering.
> > > Just keep reading from /temp but set the new sysfs property 'cached_values' to 'cached'.
> > > Then userspace will get updated values as frequent as the kernel control has
> > > and the kernel control will not be disturbed by frequent device reads.
> > >
> > > c) When one has control in userspace, and wants to have the most frequent
> > > device read. Here, one can simply disable the in kernel control by
> > > setting the 'mode' sysfs entry to 'disabled', and making sure the new sysfs property is set
> > > to 'not cached'. Well in fact, the way I thought this originally in this patch
> > > was to simply always read the device when /temp is read is 'mode' is 'disabled'.
> > >
> > > I believe you proposed to have another sysfs entry  sysfs entry for reading cached temperature.
> > > Something like 'temp_cached'. Thinking of it, as I mentioned before, it will work.
> > > The only possible downside is to have two entries to read temperature.
> > >
> > > Strong opinions on any of the above?
> >
> > So what about adding a new zone attribute that can be used to specify
> > the preferred caching time for the temperature?
> >
> > That is, if the time interval between two consecutive updates of the
> > cached temperature value is less than the value of the new attribute,
> > the cached temperature value will be returned by "temp".  Otherwise,
> > it will cause the sensor to be read and the value obtained from it
> > will be returned to user space and cached.
> >
> > If the value of the new attribute is 0, everything will work as it
> > does now (which will also need to be the default behavior).
>
> Yeah, that makes sense to me. I can cook something up in the next version.

Yes, please.

Also I think that the $subject patch was inspired by observations made
on a specific system in practice.  It would be good to say what the
system is and include some numbers illustrating how severe the problem
is (that is, what is expected and what is observed and why the
discrepancy is attributed to the effect of direct sensor accesses from
user space via sysfs).
