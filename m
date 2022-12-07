Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE73764592A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiLGLlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGLlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:41:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3112ED50;
        Wed,  7 Dec 2022 03:41:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670413277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fRpSjw/dv9FqccY9B1OCUrj861X2cDoY5pFNqPDabgw=;
        b=dhpT6Xh8TSka7TzvVWEgqE16nR0wQXJuJX5JqMl6ZBDZrd/uh5ByLLfdGdeUC77Wis8B9n
        8ivR+NO2vZG0E+cD5SdyitBedHlA+0P2MtO+/pH9AWcALYqPLjvs2ILBAaTw9X34BjDq97
        +//n6AfpTzuInhJMuIcY8OrJjePTqEVzzL5zXiBhX1VwGAuZ9f+Q9FnNEfg8baEZnfOJBa
        01HZSCRJa4EtzTF8jPLeFKF0YXPGV0HLldWEJqX2C8H5oKUcWD0F5MIA1wdzjx025qI93b
        h+qLWaUIe/91R2IMgXhHH1pDwCHJlMJ+/BdCr4H83AJtLpe9AecyrhMTBDcMNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670413277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fRpSjw/dv9FqccY9B1OCUrj861X2cDoY5pFNqPDabgw=;
        b=951oyHKX8lCBPK3vQIRbKGNpjPqnNzpE+pC1VwDcf+X7g1eWmyHw9l++EnBq1c76C3FxT3
        2B/g3LIW/wl3KiDg==
To:     "Li,Rongqing" <lirongqing@baidu.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpuidle-haltpoll: Disable kvm guest polling when
 mwait_idle is used
In-Reply-To: <59bf331606fc4d68a8aa866c50c902be@baidu.com>
References: <1670308998-12313-1-git-send-email-lirongqing@baidu.com>
 <CAJZ5v0gG93BXZWOcRVpng_EN-h4+sOyUqTc1XRt4xZkqMnaZZw@mail.gmail.com>
 <87mt80g2fp.ffs@tglx> <59bf331606fc4d68a8aa866c50c902be@baidu.com>
Date:   Wed, 07 Dec 2022 12:41:16 +0100
Message-ID: <875yenfnkz.ffs@tglx>
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

On Wed, Dec 07 2022 at 10:49, Rongqing Li wrote:
>> Before change, "sockperf ping-pong -i 127.0.0.1 -p 20001  --tcp " latency is:
>> sockperf: Summary: Latency is 6.245 usec
>> 
>> this patch, disable cpuidle-haltpoll
>> sockperf: Summary: Latency is 4.671 usec
>> 
>> 
>> using arch_cpu_idle() in default_enter_idle()
>> sockperf: Summary: Latency is 4.285 usec
>> 
>
> When I did upper tests, I taskset sockperf server and client to
> different cpus, so using arch_cpu_idle() in default_enter_idle() gets
> better result.
>
> I test unixbench also, find that Don't loading cpuidle-haltholl can
> get more performance on 8 cores (2 threads per core) intel cpu which
> cstate is disabled in host
>
> Don't load cpuidle-haltpoll:
> System Benchmarks Index Score                                        1995.8
> System Benchmarks Index Score                                        8482.8
>
> Replace default_idle with arch_cpu_idle, and load cpuidle-haltpoll, code like below:
> System Benchmarks Index Score                                        1971.4
> System Benchmarks Index Score                                        8467.7
>
> So I think we should not load cpuidle-haltpoll driver when guest has mwait

So in the above you got:

Driver loaded not modified:     6.245
Driver not loaded:              4.671           ~25%
Driver loaded modified:         4.285           ~30%

Now with unixbench:

Driver not loaded:              8482.8
Driver loaded modified:         8467.7          ~0.2%

So because of 0.2% delta you justify to throw away a 5% win?

If you really care about the 0.2%, then blacklist the module for your
use case.

Thanks,

        tglx

