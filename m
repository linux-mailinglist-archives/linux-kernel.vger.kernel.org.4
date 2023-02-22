Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9649869F716
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjBVOuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjBVOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:49:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CCC2E810
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:49:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BDFEB815C9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AEFC433D2;
        Wed, 22 Feb 2023 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677077341;
        bh=LzPXSUQ5r1/Bs4hz84H6qgEjAoaTGeCsC9MBHvwLg7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APYDNzk/UbjtXq3Caf/1n71n0EfLNNBfKr9KK+ZfGlofTWWOOcSnZ8MhfdbPfHfC5
         /2sxpqIuhC5+mWHwy2BykM6u0Zr73fjTCCDLhzvlQZDFx/5qifxSwW+RgDHIWSL8L0
         g7Cu4HatXSiiuzjY4ImlZVnWuE5RWKkr9ZD3fPOYMx4QMl2uBGrQfv+ulR/JXHHiiv
         sXo1SshpdTDRmYQ8v6GkzJjK0PeyBq4lUym+axXbCVzoykv5PlaqWCWzZGgQRinDFN
         N+tiapm9Lrm0FieOpQMaFehjhesL7wS35c1e23WQyRcpZw4WNvazdHAZeKOm2xCoxH
         a3j7AN2th6VUQ==
Date:   Wed, 22 Feb 2023 15:48:57 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 7/7] selftests/proc: Remove idle time monotonicity
 assertions
Message-ID: <Y/YrWZ6GnwLcWlwW@lothringen>
References: <20230220124129.519477-1-frederic@kernel.org>
 <20230220124129.519477-8-frederic@kernel.org>
 <87k00covg2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k00covg2.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 10:53:17PM +0100, Thomas Gleixner wrote:
> On Mon, Feb 20 2023 at 13:41, Frederic Weisbecker wrote:
> 
> > Due to broken iowait task counting design (cf: comments above
> > get_cpu_idle_time_us() and nr_iowait()), it is not possible to provide
> > the guarantee that /proc/stat or /proc/uptime display monotonic idle
> > time values.
> >
> > Remove the selftests that verify the related wrong assumption so that
> > testers and maintainers don't spend more time on that.
> >
> > Reported-by: Yu Liao <liaoyu15@huawei.com>
> > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> 
> I did really not ask you to remove the selftests alltogether.
> 
> Those tests check uptime and idle time. I asked you to remove the idle
> time monotonicity assertion.
> 
> uptime is really supposed to be monotonically increasing. It's based on
> CLOCK_BOOTTIME. If that goes backwards then we surely have more trouble
> than /proc/uptime.

Right, I naively thought it wasn't worth checking CLOCK_BOOTTIME monotonicity
alone... Anyway, kept that in the new version.

> 
> But it would be a good thing to change the test in the following way:
> 
>        ut1 = parse("/proc/uptime");
>        bt1 = clock_gettime(CLOCK_BOOTTIME);
>        assert(ut1 <= bt1);
>        ut2 = parse("/proc/uptime");
>        bt2 = clock_gettime(CLOCK_BOOTTIME);
>        assert(ut2 <= bt2);
>        assert(ut1 <= ut2);
>        ....
> 
> Hmm?

Makes sense, added to the new version.

Thanks!

> 
> Thanks,
> 
>         tglx
