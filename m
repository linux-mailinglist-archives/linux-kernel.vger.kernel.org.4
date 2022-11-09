Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB86226EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKIJ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKIJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:28:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACF11E4;
        Wed,  9 Nov 2022 01:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=550k583ytKlQmS1L2KsRGrIUXS3avi+7Y1sWRHILWd4=; b=s+wxmiJezVRJMcVS3iWJaZNuiw
        A0J9xsum1QBbWbBiOC495YeVzPC5WpSiDKUbSPNibk20303gRcxp7gyORmdJPgGZEAkdgbuZ9cZHo
        Dc9WFklokbdBybHeVKc/Ga46ztlcpvv5jDm/W59ADpJPgHizYQYqpBAkZFU8Kz64aa1OxXspnDXHH
        FZNgQFQOaQPJg+uhfzyazfflY9zZEy5lpi+ujVzpPQ0SLJZRJoc9B1TBH1pNLoKqQZL+N5kHiWzgo
        nNITMPGAx7GPJHWxyrruHDRV91HgD+rkFxog/NNqG/x6E/I6nBznEtUR+41MwnUSXlESAWpVCIyxT
        jKBhXCUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oshNj-00B46i-8C; Wed, 09 Nov 2022 09:28:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E306300392;
        Wed,  9 Nov 2022 10:28:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A14C2BD856F7; Wed,  9 Nov 2022 10:28:18 +0100 (CET)
Date:   Wed, 9 Nov 2022 10:28:18 +0100
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
Message-ID: <Y2tyshbt+qgJXU9O@hirez.programming.kicks-ass.net>
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

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 08969f5aa38d..6a2323266942 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1047,6 +1047,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  	tsk->reported_split_lock = 0;
>  #endif
>  
> +#ifdef CONFIG_SCHED_MM_VCPU
> +	tsk->mm_vcpu = -1;
> +	tsk->mm_vcpu_active = 0;
> +#endif
>  	return tsk;
>  
>  free_stack:

Note how the above hunk does exactly the same as the below thunk, and I
think they're even on the same code-path.

How about moving all of this to __sched_fork() or something?

> @@ -1579,6 +1586,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
>  
>  	tsk->mm = mm;
>  	tsk->active_mm = mm;
> +	sched_vcpu_fork(tsk);
>  	return 0;
>  }

> +void sched_vcpu_fork(struct task_struct *t)
> +{
> +	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
> +	t->mm_vcpu = -1;
> +	t->mm_vcpu_active = 1;
> +}
