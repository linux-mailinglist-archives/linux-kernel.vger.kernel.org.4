Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7626169D603
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjBTVxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBTVxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:53:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDCC92
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:53:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676929997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JelXXsgQ0Tpc6TPoPpKvR0I//kqEtaBn2c0M+XPzYqM=;
        b=KpzhZ3/vVZOxRAauYvNwfIQ7/oPYepu8ZN+d+UMBfLm4YmR46qyt349zwMSKzdgkcZCtpl
        RfqUktFs4FDq2Wgc83NzYtB1AjkIGmGbsymRx/G6jajUN+pcVy4ps3W5gsyGh3h21hgT5k
        dMnLFbWu6NiJtSKBBp+FSsgK5wFuSrcl+VYzcy5IWiXlGJPCbL4uXAcZpguaU/SkCPrzgF
        kKsBWeHZskW5LcY6fKo2VvUPYqjsNrMxM+HgoUriPcFgz0g4KKTjr572CTeSr0i30ngX93
        pmwBzq3v47rIF/lECsWdM8QDO4YbU6TMxBnL5aYWKCl5RVhZH16wCw5OMAwQTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676929997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JelXXsgQ0Tpc6TPoPpKvR0I//kqEtaBn2c0M+XPzYqM=;
        b=kL00xiN72orIaR4qlwrz1esn+NfHhUtfYdlHYxW5G5be7I++3UKLdRh5ErHLPVe78hUrDq
        fcCstgJ5DhAHsNDg==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 7/7] selftests/proc: Remove idle time monotonicity
 assertions
In-Reply-To: <20230220124129.519477-8-frederic@kernel.org>
References: <20230220124129.519477-1-frederic@kernel.org>
 <20230220124129.519477-8-frederic@kernel.org>
Date:   Mon, 20 Feb 2023 22:53:17 +0100
Message-ID: <87k00covg2.ffs@tglx>
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

On Mon, Feb 20 2023 at 13:41, Frederic Weisbecker wrote:

> Due to broken iowait task counting design (cf: comments above
> get_cpu_idle_time_us() and nr_iowait()), it is not possible to provide
> the guarantee that /proc/stat or /proc/uptime display monotonic idle
> time values.
>
> Remove the selftests that verify the related wrong assumption so that
> testers and maintainers don't spend more time on that.
>
> Reported-by: Yu Liao <liaoyu15@huawei.com>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>

I did really not ask you to remove the selftests alltogether.

Those tests check uptime and idle time. I asked you to remove the idle
time monotonicity assertion.

uptime is really supposed to be monotonically increasing. It's based on
CLOCK_BOOTTIME. If that goes backwards then we surely have more trouble
than /proc/uptime.

But it would be a good thing to change the test in the following way:

       ut1 = parse("/proc/uptime");
       bt1 = clock_gettime(CLOCK_BOOTTIME);
       assert(ut1 <= bt1);
       ut2 = parse("/proc/uptime");
       bt2 = clock_gettime(CLOCK_BOOTTIME);
       assert(ut2 <= bt2);
       assert(ut1 <= ut2);
       ....

Hmm?

Thanks,

        tglx
