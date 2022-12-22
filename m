Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73820653AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 04:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiLVDkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 22:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVDko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 22:40:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2838417E29
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 19:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671680396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2K/BkWyYsT/Jk2fklfpa4mrCdOdKG4g2EgGgkbPYAo=;
        b=UjnZSDcNIEGVRAbEFN0L4pZxKfCSf+TPhTXqLPgcGB/jFfqGiu8uPlvtgJiek6w2TACGBb
        qfY6zJgxIDGj2L1pROIEaCB5j3U60cgVsUQvkppTlKyWvXHX3rNTbNdN+DtA+22lTWOmkq
        YU8hjsq5/XOvqEPbVkUphqtcYTRkpIc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-2dlkGSn0MWyQ8eLUiSWLog-1; Wed, 21 Dec 2022 22:39:54 -0500
X-MC-Unique: 2dlkGSn0MWyQ8eLUiSWLog-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24FBC38173C0;
        Thu, 22 Dec 2022 03:39:54 +0000 (UTC)
Received: from [10.22.33.5] (unknown [10.22.33.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BF902166B26;
        Thu, 22 Dec 2022 03:39:53 +0000 (UTC)
Message-ID: <a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com>
Date:   Wed, 21 Dec 2022 22:39:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Feng Tang <feng.tang@intel.com>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>
References: <20221220082512.186283-1-feng.tang@intel.com>
 <6fb04ee9-ce77-4835-2ad1-b7f8419cfb77@redhat.com>
 <20221220183400.GY4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6Ja+kYQAi4pppV6@feng-clx> <8a9bed0d-c166-37e9-24c3-8cea7a336c76@redhat.com>
 <20221222004032.GI4001@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221222004032.GI4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/22 19:40, Paul E. McKenney wrote:
> commit 199dfa2ba23dd0d650b1482a091e2e15457698b7
> Author: Paul E. McKenney<paulmck@kernel.org>
> Date:   Wed Dec 21 16:20:25 2022 -0800
>
>      clocksource: Verify HPET and PMTMR when TSC unverified
>      
>      On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
>      NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
>      TSC is disabled.  This works well much of the time, but there is the
>      occasional system that meets all of these criteria, but which still
>      has a TSC that skews significantly from atomic-clock time.  This is
>      usually attributed to a firmware or hardware fault.  Yes, the various
>      NTP daemons do express their opinions of userspace-to-atomic-clock time
>      skew, but they put them in various places, depending on the daemon and
>      distro in question.  It would therefore be good for the kernel to have
>      some clue that there is a problem.
>      
>      The old behavior of marking the TSC unstable is a non-starter because a
>      great many workloads simply cannot tolerate the overheads and latencies
>      of the various non-TSC clocksources.  In addition, NTP-corrected systems
>      often seem to be able to tolerate significant kernel-space time skew as
>      long as the userspace time sources are within epsilon of atomic-clock
>      time.
>      
>      Therefore, when watchdog verification of TSC is disabled, enable it for
>      HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
>      time-skew diagnostic without degrading the system's performance.
>      
>      Signed-off-by: Paul E. McKenney<paulmck@kernel.org>
>      Cc: Thomas Gleixner<tglx@linutronix.de>
>      Cc: Ingo Molnar<mingo@redhat.com>
>      Cc: Borislav Petkov<bp@alien8.de>
>      Cc: Dave Hansen<dave.hansen@linux.intel.com>
>      Cc: "H. Peter Anvin"<hpa@zytor.com>
>      Cc: Daniel Lezcano<daniel.lezcano@linaro.org>
>      Cc: Feng Tang<feng.tang@intel.com>
>      Cc: Waiman Long <longman@redhat.com
>      Cc:<x86@kernel.org>

As I currently understand, you are trying to use TSC as a watchdog to 
check against HPET and PMTMR. I do have 2 questions about this patch.

First of all, why you need to use both HPET and PMTMR? Can you just use 
one of those that are available. Secondly, is it possible to enable this 
time-skew diagnostic for a limit amount of time instead running 
indefinitely? The running of the clocksource watchdog itself will still 
consume a tiny amount of CPU cycles.

Cheers,
Longman


