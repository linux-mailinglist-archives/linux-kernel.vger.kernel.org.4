Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ACA68B9E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjBFKV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjBFKV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:21:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 643EA206BE;
        Mon,  6 Feb 2023 02:20:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF90016F3;
        Mon,  6 Feb 2023 02:13:26 -0800 (PST)
Received: from bogus (unknown [10.57.12.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12FBE3F71E;
        Mon,  6 Feb 2023 02:12:41 -0800 (PST)
Date:   Mon, 6 Feb 2023 10:12:39 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Kazuki <kazukih0205@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: s2idle breaks on machines without cpuidle support
Message-ID: <20230206101239.dret3fv65cnzpken@bogus>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204152747.drte4uitljzngdt6@kazuki-mac>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kazaki,

On Sun, Feb 05, 2023 at 12:27:47AM +0900, Kazuki wrote:
> 
> Hi everyone,
> 
> s2idle is blocked on machines without proper cpuidle support here
> in kernel/sched/idle.c:
> 
> > if (cpuidle_not_available(drv, dev)) {
> > 	tick_nohz_idle_stop_tick();
> 
> > 	default_idle_call();
> > 	goto exit_idle;
> > }
> 
> > /*
> >  * Suspend-to-idle ("s2idle") is a system state in which all user space
> >  * has been frozen, all I/O devices have been suspended and the only
> 
> However, there are 2 problems with this approach:
> 
> 1. The suspend framework does not expect this, and continues to suspend the
> machine, which causes machines without proper cpuidle support to break when
> suspending

What do you mean by break ? More details on the observation would be helpful.

> 2. Suspend actually works on ARM64 machines even without proper
> cpuidle (PSCI cpuidle) since they support wfi, so the assumption here is wrong
> on such machines
>

Sorry I am bit confused here. Your point (2) contradicts the $subject.

> I'm not exactly sure how to figure this out, and my attempts have all led to an
> unbootable kernel, so I've cc'ed the relevant people and hopefully we can find a
> solution to this problem.
>

Again, since s2idle is userspace driven, I don't understand what do you
mean by unbootable kernel in the context of s2idle.

-- 
Regards,
Sudeep
