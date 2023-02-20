Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E1269C5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjBTHXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTHXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:23:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BD9BDF4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:23:29 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676877807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IhCL6jB+9rByr1E5xp030i/jHAvOGuR13U47/0pMa+M=;
        b=v5SLrmbRXRw5chdCkrep1emH49+AmBfGRRD7g35xmLS2a+aNzfaTsiO5WdzAfoAtrilIAx
        BYo4Rj/+/db3wdZJVkMKywKM3Q3Sffc36bwpfD8/kvF8csy0Htx91UkXoivjdOSp6obFrD
        QAhiqOmJ/lOePim18q0QZliH4tSpF+E0SB0ATFsYPS+yZYrAFhtMjL10uFYubbiNNVFjMg
        qpOh7QKns7c04Jtp57+zPa7kKVg5KYbZKmQ+6c02W81wMr/p0bCD6svy4T5Req0ujQwUmx
        QEzc84KwJIrQ/UOXE4a4TCp2+37u1NuEIvVlsBglZwTf+hmiwW8/+UmaefeSJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676877807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IhCL6jB+9rByr1E5xp030i/jHAvOGuR13U47/0pMa+M=;
        b=SlxCHV3Oz+f177JEQZVt4LC0K4vJ0Wx6d232zWfpHg2PWDuMdDecwfbmmHyy1bI0v7lrSW
        BuSGR4r6ghGqT+Ag==
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to
 cleanup freezer handling
In-Reply-To: <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
References: <20230211064527.3481754-1-jstultz@google.com>
 <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
Date:   Mon, 20 Feb 2023 08:23:26 +0100
Message-ID: <87o7porea9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18 2023 at 15:56, Michael Nazzareno Trimarchi wrote:
>
> I have changed the alarm test to check some corner case

Could you tell us please which test did you change and what the change is?

> periodic_alarm
> Start time (CLOCK_REALTIME_ALARM)[   85.624819] alarmtimer_enqueue: called
> : 94:865096467
> Setting alarm for every 4 seconds
> Starting suspend loops
> [   89.674127] PM: suspend entry (deep)
> [   89.714916] Filesystems sync: 0.037 seconds
> [   89.733594] Freezing user space processes
> [   89.740680] Freezing user space processes completed (elapsed 0.002 seconds)
> [   89.748593] OOM killer disabled.
> [   89.752257] Freezing remaining freezable tasks
> [   89.756807] alarmtimer_fired: called
> [   89.756831] alarmtimer_dequeue: called <---- HERE
>
> I have the dequeue but not an enquee of the periodic alarm. I was
> thinking that create a periodic time of 4 seconds
> and have the first alarm on suspend will always guarantee the re-arm
> it but it's not working as I expect

Again. You are not telling what you expect. It depends on how the timer
is set up whether the timer is self rearmed or not.

Thanks,

        tglx
