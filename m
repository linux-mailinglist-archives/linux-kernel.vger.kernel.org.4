Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C496E1E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjDNI2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjDNI1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:27:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A75CAD10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PoRIuLmbRzfAMEMLW/tZ0mplOMURrltk3yq8DayZffY=; b=ROk52eN33FcVdZSOg0C8WZIvVM
        47UGAguUYbxKDtUhLt0vqtsDWRoD7HayO/PVvfZ59w442aZ+tAVXJbkxRs6BmGeo+5M2fdUlP8TW0
        C1jToxo4cuRPThA3/uSIUsYnducBuoxnmQY8d8cUIxYH57V/sDQ45ac0z2NOaNuNg7KGsN2mTSFAr
        XpPdEGv1W74ogUug5Rzr/gkXkd7SnAriDo2UcROBGMDPf1TO+ZcHsaAlzrsFWplCHxaCKZlp4U9hN
        O7hyN9YtGvHN9qtFMc97yUshxN0l9+APfgz2zj6/RmjYLm/wrJqJrNYluI2An5JytDxEUWGutPWKz
        LtPGsiIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pnEjc-00FWof-2K;
        Fri, 14 Apr 2023 08:26:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 827B130002F;
        Fri, 14 Apr 2023 10:24:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0FA220248CE4; Fri, 14 Apr 2023 10:24:42 +0200 (CEST)
Date:   Fri, 14 Apr 2023 10:24:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Thompson <dev@aaront.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] sched/clock: Fix local_clock() before
 sched_clock_init()
Message-ID: <20230414082442.GV4253@hirez.programming.kicks-ass.net>
References: <20230413175012.2201-1-dev@aaront.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413175012.2201-1-dev@aaront.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 05:50:12PM +0000, Aaron Thompson wrote:
> Have local_clock() return sched_clock() if sched_clock_init() has not
> yet run. sched_clock_cpu() has this check but it was not included in the
> new noinstr implementation of local_clock().
> 
> The effect can be seen on x86 with CONFIG_PRINTK_TIME enabled, for
> instance. scd->clock quickly reaches the value of TICK_NSEC and that
> value is returned until sched_clock_init() runs.
> 
> dmesg without this patch:
> 
>     [    0.000000] kvm-clock: ...
>     [    0.000002] kvm-clock: ...
>     [    0.000672] clocksource: ...
>     [    0.001000] tsc: ...
>     [    0.001000] e820: ...
>     [    0.001000] e820: ...
>      ...
>     [    0.001000] ..TIMER: ...
>     [    0.001000] clocksource: ...
>     [    0.378956] Calibrating delay loop ...
>     [    0.379955] pid_max: ...
> 
> dmesg with this patch:
> 
>     [    0.000000] kvm-clock: ...
>     [    0.000001] kvm-clock: ...
>     [    0.000675] clocksource: ...
>     [    0.002685] tsc: ...
>     [    0.003331] e820: ...
>     [    0.004190] e820: ...
>      ...
>     [    0.421939] ..TIMER: ...
>     [    0.422842] clocksource: ...
>     [    0.424582] Calibrating delay loop ...
>     [    0.425580] pid_max: ...
> 
> Fixes: 776f22913b8e ("sched/clock: Make local_clock() noinstr")
> Signed-off-by: Aaron Thompson <dev@aaront.org>

Thanks!
