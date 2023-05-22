Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DAC70BC38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjEVLu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjEVLuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:50:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC1E19D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:49:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684756193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FlLarggdQsf0haQgR3ollNP2QNScxMoguXmxrvoJ7aM=;
        b=B1Q9CozSzAZC6BgwYCrQMmSdWA5nvQpN40HCIZPcrZXmJ1gNLv8LNwSq3rvA9TDR0zlsO2
        MJiqeHZZtT2zOE9Y2m+IeY5D+H0LJFdFdFTmhnIDVLd1goHNbzs9f3nphNb4qVPCTYcyoe
        jk8gaH5CckvoPcrVZB37RkrjEAzAcIGr4JOVpBKsIhgKdTQ7+dMZzB6v1c6fZsJxSNxwXG
        Zeif40Z7H3QBaCgmmWatpJnZrcy6Ydb+7W37C2k4My/XKX2qwGGz375QytL/47v5XmpkMV
        uV8xeu/iw45la4H94B7F7tqrbX5UnL5BOiKvEddMJJh08Z/r3DJ8vcG+0EdlRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684756193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FlLarggdQsf0haQgR3ollNP2QNScxMoguXmxrvoJ7aM=;
        b=YDmcaRDypFv0yLUxfXJmqOV+YKpBBaWJzr7oS/HbhcEyrW8qi4yF5oMs40vmeQqn7GmigY
        WHlOl6hNS08VfuCA==
To:     Feng Tang <feng.tang@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        rui.zhang@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
In-Reply-To: <ZGssENXFKmOk/zL7@feng-clx>
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx> <ZGssENXFKmOk/zL7@feng-clx>
Date:   Mon, 22 May 2023 13:49:53 +0200
Message-ID: <87zg5wwppa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22 2023 at 16:47, Feng Tang wrote:
> On Mon, May 22, 2023 at 10:14:08AM +0200, Thomas Gleixner wrote:
>> On Mon, May 22 2023 at 11:30, Feng Tang wrote:
>> Are any of these affected platforms shipping already or is this just
>> Intel internal muck?
>
> Paul and Rui can provide more info. AFAIK, those problems were raised
> by external customers, so the platform were already shipped from
> Intel. But I'm not sure they are commercial versions or early
> engineering drops. 

So its at a company which knows how to update firmware, right?

>> So why do you force this on everyone?
>
> How about we keep the optional parameter, and enforce the check for
> bare metal platforms which got TSC frequency info from CPUID(0x15),
> like:

What prevents a hypervisor from providing this info in CPUID(0x15)?

> @@ -670,8 +670,10 @@ unsigned long native_calibrate_tsc(void)
>  	 * frequency and is the most accurate one so far we have. This
>  	 * is considered a known frequency.
>  	 */
> -	if (crystal_khz != 0)
> +	if (crystal_khz != 0) {
>  		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> +		tsc_force_recalibrate = 1;
> +	}
>  
>  	/*
>  	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal

and five lines further down:

	/*
	 * For Atom SoCs TSC is the only reliable clocksource.
	 * Mark TSC reliable so no watchdog on it.
	 */
	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);

So its reliable and needs recalibration against hardware which does not
exist.

Thanks,

       tglx
