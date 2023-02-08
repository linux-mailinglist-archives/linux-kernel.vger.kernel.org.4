Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3C768EDCF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBHLV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjBHLV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:21:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4A576A7;
        Wed,  8 Feb 2023 03:20:50 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d2so14400887pjd.5;
        Wed, 08 Feb 2023 03:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fso3u+DXawZ5Dg96ItXFwx17vVhh+JjQUrLK3cPFxXA=;
        b=cQHSMKrLWqQTtCWNcCZz5MRxhBqndzS4nDdsJ1ulEaUQaBlkwz6HvMz8jN6zGB9pVY
         bFSP28DG8JaIdTfrPvili2beREzVUcGEC5ARfMzRQo0TOzSMbOaCXvQZ2sNCxQjAswmT
         Pk2jBTi+/QgEmKDhvoE4cjwdl9dzNaqI+Llo4w+eQ6h04on3mQCJq1f8WtQGEHzWX/CF
         RFCLSla740o5g5GpEmOUJW6NLKDx9pJeXEwk+rClwlPj7PTEz57hz0FAlXDWC6LixXjy
         11ekGzktunr5VfzsAcXAHrKtkx03PaK7Q/68d64LTtyR1AVxs9OnBhSzasszFYQJBzn2
         HC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fso3u+DXawZ5Dg96ItXFwx17vVhh+JjQUrLK3cPFxXA=;
        b=N/XCGWSNCKyTXS1n/+41/KTXFkt1AkcIz5Wx1IRx6G3x22enqhNn6Ao5Q89RDmQ1G9
         qne/njFQ586hTJ7o17IgqDPLDb0UppQ66RvEb5XXlgrP9nojs94rupIbasJMnXhKmD4M
         E/ODSzPAnElDGp5RVmghDcHNrMGFKaZn8dU2KMaAM9l1V6RUUigTor7Dj9/D7n1Ergy/
         SLmQ7bCd3HCy5GRCFrweKGT4SWIcTO11T2z/yAk+9p2VQwlHw+xw67IWlIVgnfF2rEAt
         vKRrAlZbOqvabEDdRW3nSSs3nYIdJeTht7vKZMYX6A/aUzlUNKv/dvhpQoVZhm5tMpm+
         aerQ==
X-Gm-Message-State: AO0yUKXlvnc5stM/pMaDNFVaIbB3keJUMRDaaQG7JpfPmBFX+eNybT6Y
        udmIuYmxCs9A21rnjFwfZAw=
X-Google-Smtp-Source: AK7set9VBHl6MNgHsPHaCu5Y1XOfNohh/XCFSbB9YFhbzntGLB9Ov5WP+YNQXbnBp9rrXE7f2SIGJg==
X-Received: by 2002:a17:90a:e7c6:b0:230:9106:18ec with SMTP id kb6-20020a17090ae7c600b00230910618ecmr7994156pjb.43.1675855236689;
        Wed, 08 Feb 2023 03:20:36 -0800 (PST)
Received: from kazuki-mac ([2400:4051:ea3:5910::19a])
        by smtp.gmail.com with ESMTPSA id gq17-20020a17090b105100b0020dc318a43esm1305791pjb.25.2023.02.08.03.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 03:20:36 -0800 (PST)
From:   Kazuki <kazukih0205@gmail.com>
X-Google-Original-From: Kazuki <kazuki@kazuki-mac>
Date:   Wed, 8 Feb 2023 20:20:31 +0900
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
Message-ID: <20230208112031.sdfuluajjerf4wwp@kazuki-mac>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208103511.w7jzxw6spy6humdn@bogus>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 10:35:11AM +0000, Sudeep Holla wrote:
> On Wed, Feb 08, 2023 at 04:48:18AM +0900, Kazuki wrote:
> > On Mon, Feb 06, 2023 at 10:12:39AM +0000, Sudeep Holla wrote:
> > >
> > > What do you mean by break ? More details on the observation would be helpful.
> > For example, CLOCK_MONOTONIC doesn't stop even after suspend since
> > these chain of commands don't get called.
> >
> > call_cpuidle_s2idle->cpuidle_enter_s2idle->enter_s2idle_proper->tick_freeze->sched_clock_suspend (Function that pauses CLOCK_MONOTONIC)
> >
> > Which in turn causes programs like systemd to crash since it doesn't
> > expect this.
> 
> Yes expected IIUC. The per-cpu timers and counters continue to tick in
> WFI and hence CLOCK_MONOTONIC can't stop.
Yes, but it shouldn't be the case when suspending[1]. Currently that's what
happens when we enter s2idle without a cpuidle driver. This doesn't seem
to happen with S3 sleep [2].

[1]
Documentation/core-api/timekeeping.rst:

.. c:function:: ktime_t ktime_get( void )

	CLOCK_MONOTONIC

	Useful for reliable timestamps and measuring short time intervals
	accurately. Starts at system boot time but stops during suspend.

[2]
kernel/time/sched_clock.c:

int sched_clock_suspend(void)
{
	struct clock_read_data *rd = &cd.read_data[0];

	update_sched_clock();
	hrtimer_cancel(&sched_clock_timer);
	rd->read_sched_clock = suspended_sched_clock_read;

	return 0;
}

void sched_clock_resume(void)
{
	struct clock_read_data *rd = &cd.read_data[0];

	rd->epoch_cyc = cd.actual_read_sched_clock();
	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HARD);
	rd->read_sched_clock = cd.actual_read_sched_clock;
}

static struct syscore_ops sched_clock_ops = {
	.suspend	= sched_clock_suspend,
	.resume		= sched_clock_resume,
};

static int __init sched_clock_syscore_init(void)
{
	register_syscore_ops(&sched_clock_ops);

	return 0;
}
device_initcall(sched_clock_syscore_init);
> 
> > >
> > > > 2. Suspend actually works on ARM64 machines even without proper
> > > > cpuidle (PSCI cpuidle) since they support wfi, so the assumption here is wrong
> > > > on such machines
> > > >
> > >
> > > Sorry I am bit confused here. Your point (2) contradicts the $subject.
> > drivers/cpuidle/cpuidle.c:
> >
> > bool cpuidle_not_available(struct cpuidle_driver *drv,
> > 			   struct cpuidle_device *dev)
> > {
> > 	return off || !initialized || !drv || !dev || !dev->enabled;
> > }
> >
> > The cpuidle framework reports ARM64 devices without PSCI cpuidle as
> > "cpuidle not available" even when they support wfi, which causes suspend
> > to fail, which shouldn't be happening since they do support idling.
> 
> Yes with just WFI, there will be no active cpuidle driver.
> 
> [...]
> 
> > > Again, since s2idle is userspace driven, I don't understand what do you
> > > mean by unbootable kernel in the context of s2idle.
> >
> > Sorry, I meant "attempts to fix this bug have all led to an unbootable
> > kernel."
> 
> Again I assume you mean kernel hang or crash and nothing to do with boot.
> Once you enter s2i state with your changes/fix, it hangs or is unresponsive
> as it might have either failed to enter or resume from the state.
> 
> --
> Regards,
> Sudeep
Thanks,
Kazuki
