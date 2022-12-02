Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF82F640475
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiLBKUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiLBKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:20:40 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DACCCEF8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:20:38 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="86207382"
X-IronPort-AV: E=Sophos;i="5.96,212,1665414000"; 
   d="scan'208";a="86207382"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 02 Dec 2022 19:20:36 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6EAC3CC157
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:20:35 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id AD723D8C3A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:20:34 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 7BFEC200B41D;
        Fri,  2 Dec 2022 19:20:34 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     tglx@linutronix.de
Cc:     geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH] hrtimer: CPU and entry_time is added to a warning message in hrtimer_interrupt()
Date:   Fri,  2 Dec 2022 18:55:44 +0900
Message-Id: <20221202095544.487487-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <87sfhyrev2.ffs@tglx>
References: <87sfhyrev2.ffs@tglx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas Gleixner,

Thanks for your reply.

On  Thu, 01 Dec 2022 22:30:41, Thomas Gleixner wrote:
> On Fri, Jun 24 2022 at 16:00, Rei Yamamoto wrote:
>> A warning message in hrtimer_interrupt() is output up to 5 times
>> by default, and CPU and entry_time are also shown.
> 
> This describes to some extent _what_ the patch is doing, but not the
> why.
> 
>> These changes are helpful that the function spending a lot of time is clear
>> by using ftrace:
> 
> That's a constructed case. There are multiple reasons why this can
> happen, not just because a single hrtimer callback misbehaves.
> 
>> @@ -2038,6 +2039,15 @@ static struct ctl_table kern_table[] = {
>>  		.extra1		= SYSCTL_ONE,
>>  		.extra2		= SYSCTL_INT_MAX,
>>  	},
>> +#endif
>> +#ifdef CONFIG_HIGH_RES_TIMERS
>> +	{
>> +		.procname       = "hrtimer_interrupt_warnings",
>> +		.data           = &sysctl_hrtimer_interrupt_warnings,
>> +		.maxlen         = sizeof(int),
>> +		.mode           = 0644,
>> +		.proc_handler   = proc_dointvec,
>> +	},
> 
> So this adds a new sysctl, but the changelog does not tell anything
> about it. Aside of the dubious value of this sysctl, this lacks the
> required documentation for new sysctls.
> 
>> +	/*
>> +	 * If a message is output many times, the delayed funciton
>> +	 * may be identified by resetting sysctl_hrtimer_interrupt_warnings
>> +	 * and enabling ftrace.
> 
> What has the reset of sysctl_hrtimer_interrupt_warnings to do with
> ftrace and how is that reset helpful to identify the root cause?
>
> Also repeating the printk 5 times does not add any value at all. The
> runaway detection already has logic to supress spurious events and if
> the problem persists then it can be observed by ftrace without any of
> these changes.

If the system performance degradation exists and this message is output
some times at the same time, my idea was that the reset of
sysctl_hrtimer_interrupt_warnings helps to check whether hrtimer event
is related to the degradation.
However, as you said, it can be observed by ftrace.
Therefore, I withdraw an opinion to add hrtimer_interrupt_warnings as
the sysctl parameter.

> I assume - because you did not tell so - that you try to have a
> correlation between ftrace and dmesg via the entry timestamp output,
> right?

Yes, that's right.

> That's just a half thought out debug bandaid, really.
> 
> You can provide a way better mechanism by adding a tracepoint right at
> the pr_warn_once(), which emits information for correlation right into
> the trace.
> 
> That allows you to stop the trace once the tracepoint is emitted instead
> of having to do all of this including the correlation manually.

OK, I will recreate the patch with following your idea.

Thanks.
Rei
