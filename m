Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0466B967
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjAPIxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjAPIxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:53:44 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5014C29
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=toxnBJPFRtD3QOxALorC41rSKC05NJueDnvaN0Ilxs0=; b=M5welZx+/iKa0n3a6z5zvrAUxa
        gFdVaBclwpujg4U+Us2xvVw2eQ/Ug5Rsq0bqi5u+SrBQMLF58Dhhk6G122w/YBU123GQXjPwU2juX
        PdXz9pThtpJ2NKJwwvUPER4oKG2+/Cp4gu+mOp5Hg1fWKJOo46CcLiIBrbWgWcimBPTj1HdbSqmU+
        6b0cxblEP29/3240IJwuoKxFmSqTOqMJgOlaNS4k/Esq2J5EE9n21nxc0t+TirF2ueY/j6aoGfIHf
        QrW3ybCgcFaslQYYAryEn/8ZRCFnMQI8iDZLKlKSvu1f9nrYTLsRiH9tbtBARuuNKHVYG71t8KsVz
        Q1pr8Ong==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pHLEk-005XLh-2n;
        Mon, 16 Jan 2023 08:53:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE8DC30030F;
        Mon, 16 Jan 2023 09:53:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9448C20A006E1; Mon, 16 Jan 2023 09:53:08 +0100 (CET)
Date:   Mon, 16 Jan 2023 09:53:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sched/idle: Make idle poll dynamic per-cpu
Message-ID: <Y8UQdKx+004a28fL@hirez.programming.kicks-ass.net>
References: <20230112162426.217522-1-bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112162426.217522-1-bristot@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 05:24:26PM +0100, Daniel Bristot de Oliveira wrote:
> idle=poll is frequently used on ultra-low-latency systems. Examples of
> such systems are high-performance trading and 5G NVRAM. The performance
> gain is given by avoiding the idle driver machinery and by keeping the
> CPU is always in an active state - avoiding (odd) hardware heuristics that
> are out of the control of the OS.
> 
> Currently, idle=poll is an all-or-nothing static option defined at
> boot time. The motivation for creating this option dynamic and per-cpu
> are two:
> 
>   1) Reduce the power usage/heat by allowing only selected CPUs to
>      do idle polling;
>   2) Allow multi-tenant systems (e.g., Kubernetes) to enable idle
>      polling only when ultra-low-latency applications are present
>      on specific CPUs.
> 
> Joe Mario did some experiments with this option enabled, and the results
> were significant. For example, by using dynamic idle polling on
> selected CPUs, cyclictest performance is optimal (like when using
> idle=poll), but cpu power consumption drops from 381 to 233 watts.
> 
> Also, limiting idle=poll to the set of CPUs that benefits from
> it allows other CPUs to benefit from frequency boosts. Joe also
> shows that the results can be in the order of 80nsec round trip
> improvement when system-wide idle=poll was not used.
> 
> The user can enable idle polling with this command:
>   # echo 1 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll
> 
> And disable it via:
>   # echo 0 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll
> 
> By default, all CPUs have idle polling disabled (the current behavior).
> A static key avoids the CPU mask check overhead when no idle polling
> is enabled.

Urgh, can we please make this a cpuidle governor thing or so? So that we
don't need to invent new interfaces and such.


