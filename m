Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9F46920F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjBJOmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjBJOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:41:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFE871024
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jaq9SvPMK72EvPLEMKDpijiStY/1+6JPCuX6VG2Dy/4=; b=sruCV7/ytMTU3j+doQ0dUKjL8Q
        HThQaaS1ESPLo0CX2bjAKKpefFcxp+oYzvLm0IRcR3m1+3cEuck7IogmCMkUuZxPokNSRzV8gudOg
        +LlkuhX1WJYgyj8GaZ1hlFWE0cNCi0Oz9bhmYjuie8HZJYQl4xNtSOu/0rlLy+94YndFc/m8xs7an
        HYMilqdp/riDOlRaDKenc2tfT5chAqRP6EEeoE8TYYexaGCVcg0ZZeIKbKLdJti9uS/BN8Ac0x8b7
        KP0UTrVwvKgPLrBfYQDqsHsQOp22s4tlh5fzU26byZcZkZXm6U56gepm1QRZsXwzYMq+QNIQyEaSk
        0DMGWDnw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQUac-003BZW-5p; Fri, 10 Feb 2023 14:41:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CEEEC300293;
        Fri, 10 Feb 2023 15:41:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8518209A00B7; Fri, 10 Feb 2023 15:41:25 +0100 (CET)
Date:   Fri, 10 Feb 2023 15:41:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/6] timers/nohz: Fixes and cleanups
Message-ID: <Y+ZXlUbXfrcGUXSs@hirez.programming.kicks-ass.net>
References: <20230210140917.279062-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210140917.279062-1-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:09:11PM +0100, Frederic Weisbecker wrote:
> Try to (partially) fix the issue reported in https://lore.kernel.org/lkml/20230128020051.2328465-1-liaoyu15@huawei.com/
> 
> Frederic Weisbecker (6):
>   timers/nohz: Restructure and reshuffle struct tick_sched
>   timers/nohz: Only ever update sleeptime from idle exit
>   timers/nohz: Protect idle/iowait sleep time under seqcount
>   timers/nohz: Add a comment about broken iowait counter update race
>   timers/nohz: Remove middle-function __tick_nohz_idle_stop_tick()
>   MAINTAINERS: Remove stale email address

Seem sensible enough.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
