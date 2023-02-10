Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61076920F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjBJOkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjBJOke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:40:34 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0D9749B6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j6LbxHIBCVV5rjQrdijnVfVEmR+19SnQcdcK0RUu0rY=; b=q+6TpSdsMG2l/kD8PCkPzAkDYW
        2/zAYJebYlCKaU5jsd0V5JqyezKDstQPiz7XqzwPq0KvX+A4JJNJ7iIzwxSHrIk7Af6SuiPKeWfRr
        l+QP182ZCPGbqUswwmXtIXYv4g0EZ0n4O517wLGUvV2B9LNnUcBl1TuLN7qbI5iXub1bMWgzwAPIo
        VBltuP6NUE0KWvm1r83zPBDyKc5wifoKcMrbAyD7JaB4NxWjZsCGs5kPs2b/dleznA2dmuxvjhNQf
        Deel7KU1qIt8ngaFuxLClo7Y+/BXZ7ILdVtm3QX+ESecuNhMS99uwLmKSgt4LtWwi1YrxjCfTsmVD
        cQ7fU7jQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pQUYM-008EBU-0o;
        Fri, 10 Feb 2023 14:39:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DAC2E3001CE;
        Fri, 10 Feb 2023 15:39:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A7B2209A00B7; Fri, 10 Feb 2023 15:39:43 +0100 (CET)
Date:   Fri, 10 Feb 2023 15:39:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/6] timers/nohz: Add a comment about broken iowait
 counter update race
Message-ID: <Y+ZXLy0P0Sggbrxc@hirez.programming.kicks-ass.net>
References: <20230210140917.279062-1-frederic@kernel.org>
 <20230210140917.279062-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210140917.279062-5-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:09:15PM +0100, Frederic Weisbecker wrote:
> The per-cpu iowait task counter is incremented locally upon sleeping.
> But since the task can be woken to (and by) another CPU, the counter may
> then be decremented remotely. This is the source of a race involving
> readers VS writer of idle/iowait sleeptime.
> 
> The following scenario shows an example where a /proc/stat reader
> observes a pending sleep time as IO whereas that pending sleep time
> later eventually gets accounted as non-IO.
> 
>     CPU 0                       CPU  1                    CPU 2
>     -----                       -----                     ------
>     //io_schedule() TASK A
>     current->in_iowait = 1
>     rq(0)->nr_iowait++
>     //switch to idle
>                         // READ /proc/stat
>                         // See nr_iowait_cpu(0) == 1
>                         return ts->iowait_sleeptime +
>                                ktime_sub(ktime_get(), ts->idle_entrytime)
> 
>                                                           //try_to_wake_up(TASK A)
>                                                           rq(0)->nr_iowait--
>     //idle exit
>     // See nr_iowait_cpu(0) == 0
>     ts->idle_sleeptime += ktime_sub(ktime_get(), ts->idle_entrytime)
> 
> As a result subsequent reads on /proc/stat may expose backward progress.
> 
> This is unfortunately hardly fixable. Just add a comment about that
> condition.

It is far worse than that, the whole concept of per-cpu iowait is
absurd. Also see the comment near nr_iowait().
