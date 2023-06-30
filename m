Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A421D743BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjF3MfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3MfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:35:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ACBED
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:35:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688128520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7mWwWKQ99oKZ90DcPE75bJARoQCA1byjhwd+ffjYakk=;
        b=zxj+It5kmJNWmXCQ/pEqt48NSPuYDgJA8Fri7lJei2mELgZ10hmwSpWPa/pw+nrI/3zwPp
        tRV0MG5XM2q5QAGqi1deao6f8JkJiyPpsVLFHdKN5mtOzXBdergaYVCLJjkuMXYhUs/ajg
        fjbjIN15+zL+EFkiMXLm8mX/3boinVaK5S9N61tRPa6o2RmFmXhbCnbNZf8aahKPRCzdZb
        CZRJQ0vXUU0+kXktFcS1UmuNvsA23Y3HcxjCXiKgG0pQI3jT+MqkeBCLtbtQ3OOIMjXeYq
        zvBmKh4VTNh09TUiXOFzhQxuXQhOrb0Ub86LpCHm4etdLvSQ6AqP7Up7+xXS7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688128520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7mWwWKQ99oKZ90DcPE75bJARoQCA1byjhwd+ffjYakk=;
        b=r1ByTSx5CaOrcnekPhf2iclpmPKpvGR2UpsxBZKpNC8VT/ppMwSVbqU0DslTDdzaJ0hRQu
        d/8/bwjSSNPuv9Cg==
To:     Keyon Jie <yang.jie@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yair Podemsky <ypodemsk@redhat.com>,
        Keyon Jie <yang.jie@linux.intel.com>
Subject: Re: [PATCH] x86/aperfmperf: Fix the fallback condition in
 arch_freq_get_on_cpu()
In-Reply-To: <20230626193601.9169-1-yang.jie@linux.intel.com>
References: <20230626193601.9169-1-yang.jie@linux.intel.com>
Date:   Fri, 30 Jun 2023 14:35:20 +0200
Message-ID: <878rc1yvp3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26 2023 at 12:36, Keyon Jie wrote:
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index fdbb5f07448f..24e24e137226 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -432,7 +432,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
>  	 * Bail on invalid count and when the last update was too long ago,
>  	 * which covers idle and NOHZ full CPUs.
>  	 */
> -	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
> +	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE * cpu_khz)

What?

#define MAX_SAMPLE_AGE  ((unsigned long)HZ / 50)

HZ is the number of ticks (jiffies) per second. 20ms is 1/50 of a
second.

As the sample age is measured in jiffies and the maximum is defined to
be 20ms, the existing code is correct.

With your change the condition resolves to:

     delta > MAX_SAMPLE_AGE * cpu_khz

cpu_khz = Nominal CPU frequency / 1000

Ergo:

     delta > (HZ / 50) * (cpufreq / 1000)

                HZ * cpufreq
-->  delta > ------------------
                  50000

Let's describe cpufreq in GHz:

                HZ * G * 1e9
-->  delta > ------------------
                  50000

-->  delta > HZ * G * 20000

delta is calculated in jiffies, i.e. the number of ticks since the last
invocation. Because HZ is ticks per second, the resulting timeout
measured in seconds is:

         HZ * G * 20000 / HZ

-->      G * 20000 seconds

20000 seconds for a 1GHz CPU, 40000 seconds for a 4GHz CPU independent
of the actual HZ value.

jiffies are incremented once per tick, i.e. at tick frequency. The
number of ticks required to reach 20ms depends obviously on the tick
frequency, aka HZ.

HZ         ticks per second     tick period     Number of ticks which
                                                are equivalent to 20ms
 100        100                 10ms             2
 250        250                  4ms             5
1000       1000                  1ms            10

And that's what the code does correctly:

#define MAX_SAMPLE_AGE  ((unsigned long)HZ / 50)

No?

> From the commit f3eca381bd49 on, the fallback condition about the 'the
> last update was too long' have been comparing ticks and milliseconds by
> mistake, which leads to that the condition is met and the fallback
> method is used frequently.

The comparison is comparing a tick delta with a maximum number of ticks
and that's not a mistake. It's simply correct.

> The change to compare ticks here corrects that and fixes related issues
> have been seen on x86 platforms since 5.18 kernel.

I have no idea what you are trying to "fix" here, but that's moot as
there is nothing to fix.

Thanks,

        tglx
