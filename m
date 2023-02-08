Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2168F10E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjBHOnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjBHOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:43:36 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17334941C;
        Wed,  8 Feb 2023 06:43:33 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 78so12777112pgb.8;
        Wed, 08 Feb 2023 06:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ibGGLdQhYKFijS9U4u6gpDBfDt6Va5v44uCkdLOaOY=;
        b=X84lWlO/+7p6MUrKYTEamgtOhmyjg4q5wLSq9B50q2PSVjLHQ7WN3hIt9I8hOlp78I
         kccCD3a/ljQFEWVpxsNpGxG8oZf8TUpoNqVzrnqs5uX/mCupQTFSnh0jxVZhbOswAi/+
         UaG7XGcDpDj4FwjtExSTraXvVGaYgjQUPzQQLRlmKRQghJ3UxVbBtmOhH5/ZQ6fNZ/N0
         WJWG89zpSs9gbkvNPo6AxumO9RbwXbMpOAMUkHSFHzDAdebx3yXk73K4ACr4zzFn70cZ
         mTtDHkYlIggArWtRnD/VQRMA1TgpQZtcsCaydXGmXFtL6jrOIhBPBcaqsPDUpBKdKHj7
         bZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ibGGLdQhYKFijS9U4u6gpDBfDt6Va5v44uCkdLOaOY=;
        b=x5faGKUtGvq9qB0ZbGO73d6wcTOxEESifnRLxFDZGvxEIJcJ4Sb8a2FqPesbKYhQss
         CbTa8mFEyL0yb80eqf6DJvVIUp7G3C/e8HObFxbv5TaV1XFQ678OMSOxbVQvYl4jeKJr
         KCyP50JM9+xv6hYAZd3b7V5aW63frEH7CnRVswyvbtwcIxN+tBD+rcfe5wOLdu8+brHk
         Lc5bb7bCETDVyU23YsB2AoQ1iGV78ROoA4DiCMwQDO12OmzFcZk6sR3krUg+MGs6IagI
         PSMJtQ6h2yInq3g/1/YOlnI3szyZ7LiDOwzycM/SCr85dqmrAxuYWdU9GZe+CHxinDFj
         1N4Q==
X-Gm-Message-State: AO0yUKWMO1zkeIc4RtW7VbBFw0wI0aJ5JgJ1O9447uekNFBzwd6r4B2K
        /7/h6TDE4TYPtJsu4FLkuZE=
X-Google-Smtp-Source: AK7set+e8aof1p8hmjsNsaW9v9yahPdxjUuLtjj6E8bXznyzTULGFxdQ581IWQNApNo9ZhqCZb1KEg==
X-Received: by 2002:aa7:8bc1:0:b0:590:22b:c29d with SMTP id s1-20020aa78bc1000000b00590022bc29dmr6838211pfd.10.1675867412910;
        Wed, 08 Feb 2023 06:43:32 -0800 (PST)
Received: from kazuki-mac ([2400:4051:ea3:5910::19a])
        by smtp.gmail.com with ESMTPSA id a184-20020a621ac1000000b0058bacd6c4e8sm11212622pfa.207.2023.02.08.06.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 06:43:32 -0800 (PST)
From:   Kazuki <kazukih0205@gmail.com>
X-Google-Original-From: Kazuki <kazuki@kazuki-mac>
Date:   Wed, 8 Feb 2023 23:43:27 +0900
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: s2idle breaks on machines without cpuidle support
Message-ID: <20230208144327.3ftjxnquwhsdykfc@kazuki-mac>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
 <20230208112031.sdfuluajjerf4wwp@kazuki-mac>
 <20230208141658.kede5ylqk4zqvrnj@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208141658.kede5ylqk4zqvrnj@bogus>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 02:16:58PM +0000, Sudeep Holla wrote:
> On Wed, Feb 08, 2023 at 08:20:31PM +0900, Kazuki wrote:
> > On Wed, Feb 08, 2023 at 10:35:11AM +0000, Sudeep Holla wrote:
> > > On Wed, Feb 08, 2023 at 04:48:18AM +0900, Kazuki wrote:
> > > > On Mon, Feb 06, 2023 at 10:12:39AM +0000, Sudeep Holla wrote:
> > > > >
> > > > > What do you mean by break ? More details on the observation would be helpful.
> > > > For example, CLOCK_MONOTONIC doesn't stop even after suspend since
> > > > these chain of commands don't get called.
> > > >
> > > > call_cpuidle_s2idle->cpuidle_enter_s2idle->enter_s2idle_proper->tick_freeze->sched_clock_suspend (Function that pauses CLOCK_MONOTONIC)
> > > >
> > > > Which in turn causes programs like systemd to crash since it doesn't
> > > > expect this.
> > >
> > > Yes expected IIUC. The per-cpu timers and counters continue to tick in
> > > WFI and hence CLOCK_MONOTONIC can't stop.
> > Yes, but it shouldn't be the case when suspending[1]. Currently that's what
> > happens when we enter s2idle without a cpuidle driver. This doesn't seem
> > to happen with S3 sleep [2].
> >
> 
> Correct, but check the requirements to use syscore operations(mainly
> syscore_suspend/resume where only one CPU is online with interrupts
> disabled. In case of s2idle, all CPUs are idling and not offlined as
> required by the syscore operations and hence it can't be used.
> 
> I was about ask you earlier as why can't you implement just system
> suspend in PSCI where the last cpu just calls WFI if you are interested
> in system sleep state. Or you can implement CPU_SUSPEND with an additional
> retention state which enters PSCI implementation just to make sure there is
> an active cpuidle driver and the s2idle state machinery works as expected.
The machine I have (Macbook with Apple M1) doesn't have PSCI.
> It is built with those requirements and trying to work it out for WFI without
> any idle driver or firmware implementation to back it up is just not going
> to work.
Any reason why that's the case?

I guess we should ensure that systems without a cpuidle driver
will not suspend maybe around here then.

kernel/power/main.c:

static ssize_t mem_sleep_store(struct kobject *kobj, struct kobj_attribute *attr,
			       const char *buf, size_t n)
{
	suspend_state_t state;
	int error;

	error = pm_autosleep_lock();
	if (error)
		return error;

	if (pm_autosleep_state() > PM_SUSPEND_ON) {
		error = -EBUSY;
		goto out;
	}

	state = decode_suspend_state(buf, n);
	if (state < PM_SUSPEND_MAX && state > PM_SUSPEND_ON)
		mem_sleep_current = state;
	else
		error = -EINVAL;

 out:
	pm_autosleep_unlock();
	return error ? error : n;
}
> 
> --
> Regards,
> Sudeep
Thanks,
Kazuki
