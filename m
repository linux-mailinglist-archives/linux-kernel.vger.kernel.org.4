Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF31D617B89
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiKCLcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKCLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:32:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAEF511838;
        Thu,  3 Nov 2022 04:32:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D034823A;
        Thu,  3 Nov 2022 04:32:10 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.69.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7ECE3F5A1;
        Thu,  3 Nov 2022 04:32:02 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:31:55 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH] rseq: Use pr_warn_once() when deprecated/unknown ABI
 flags are encountered
Message-ID: <Y2Omq9KCe/wvtJpu@FVFF77S0Q05N>
References: <20221102130635.7379-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102130635.7379-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:06:35AM -0400, Mathieu Desnoyers wrote:
> These commits use WARN_ON_ONCE() and kill the offending processes when
> deprecated and unknown flags are encountered:
> 
> commit c17a6ff93213 ("rseq: Kill process when unknown flags are encountered in ABI structures")
> commit 0190e4198e47 ("rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_* flags")
> 
> The WARN_ON_ONCE() triggered by userspace input prevents use of
> Syzkaller to fuzz the rseq system call.
> 
> Replace this WARN_ON_ONCE() by pr_warn_once() messages which contain
> actually useful information.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

It would be nice ot have this merged; my Syzkaller runs are still hitting the
WARN_ON_ONCE() periodically, preventing some useful fuzzing.

Is the plan still for this to go via -tip?

Thanks,
Mark.

> ---
>  kernel/rseq.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index bda8175f8f99..d38ab944105d 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -171,12 +171,27 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
>  	return 0;
>  }
>  
> +static bool rseq_warn_flags(const char *str, u32 flags)
> +{
> +	u32 test_flags;
> +
> +	if (!flags)
> +		return false;
> +	test_flags = flags & RSEQ_CS_NO_RESTART_FLAGS;
> +	if (test_flags)
> +		pr_warn_once("Deprecated flags (%u) in %s ABI structure", test_flags, str);
> +	test_flags = flags & ~RSEQ_CS_NO_RESTART_FLAGS;
> +	if (test_flags)
> +		pr_warn_once("Unknown flags (%u) in %s ABI structure", test_flags, str);
> +	return true;
> +}
> +
>  static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
>  {
>  	u32 flags, event_mask;
>  	int ret;
>  
> -	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS) || cs_flags)
> +	if (rseq_warn_flags("rseq_cs", cs_flags))
>  		return -EINVAL;
>  
>  	/* Get thread flags. */
> @@ -184,7 +199,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
>  	if (ret)
>  		return ret;
>  
> -	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS) || flags)
> +	if (rseq_warn_flags("rseq", flags))
>  		return -EINVAL;
>  
>  	/*
> -- 
> 2.30.2
> 
