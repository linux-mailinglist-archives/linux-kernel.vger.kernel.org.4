Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6236211B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiKHNAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiKHNAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:00:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D8651C26;
        Tue,  8 Nov 2022 05:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=olIRjvaT0a1rrqwIqSwvRmzbEh4XGsq5/8DNb5CsDww=; b=oDuIVuYc4iT3k7aA8Av5FxmtAq
        terfqJVI43Fi4Meei/pcZmax28q/pqzKbtdOipQxX0UBmdMuEvfxTLwEu4x5mi7q1lgzNqhvFTcqi
        t94BXp3eUAQKuPS/cmuTFQsFkM56GXvtJrK9/VzOf08Al/fjgbAc7lxHOtHdVmQZ69pkaqzYqFUPF
        0HLqDS391jCex48W7j9+2el1gKa4ltVrHnTd6aicTQNJnVtYGDYX609D66TMgUpnjtalEf3P/Z+Ll
        vM0VH0v4r2HVGH8RaGj2UwnWpmZCQuH3QU3tep8jO1gXUxNroNIGADongFYyLYYNFQdHzG9nmuzfN
        hCXKm8Yw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osODN-00AHD3-4b; Tue, 08 Nov 2022 13:00:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB98E30036B;
        Tue,  8 Nov 2022 14:00:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 993BF2B8C7B0C; Tue,  8 Nov 2022 14:00:18 +0100 (CET)
Date:   Tue, 8 Nov 2022 14:00:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Message-ID: <Y2pS4gC1MHw+mX3x@hirez.programming.kicks-ass.net>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
 <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 04:03:43PM -0400, Mathieu Desnoyers wrote:

> diff --git a/fs/exec.c b/fs/exec.c
> index 349a5da91efe..93eb88f4053b 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1013,6 +1013,9 @@ static int exec_mmap(struct mm_struct *mm)
>  	tsk->active_mm = mm;
>  	tsk->mm = mm;
>  	lru_gen_add_mm(mm);
> +	mm_init_vcpu_lock(mm);
> +	mm_init_vcpumask(mm);
> +	mm_init_node_vcpumask(mm);
>  	/*
>  	 * This prevents preemption while active_mm is being loaded and
>  	 * it and mm are being updated, which could cause problems for

> @@ -1150,6 +1154,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  
>  	mm->user_ns = get_user_ns(user_ns);
>  	lru_gen_init_mm(mm);
> +	mm_init_vcpu_lock(mm);
> +	mm_init_vcpumask(mm);
> +	mm_init_node_vcpumask(mm);
>  	return mm;
>  
>  fail_nocontext:

Why isn't all that a single mm_init_vcpu(mm) or something ?
