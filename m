Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065D45EF9DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiI2QLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiI2QLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:11:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB831D263F;
        Thu, 29 Sep 2022 09:11:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8F61B8250D;
        Thu, 29 Sep 2022 16:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD9EC433C1;
        Thu, 29 Sep 2022 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664467896;
        bh=T46nJceimKE9OXE9XXYp3BCVN62useGX/MPlv+uPvwg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XpZQ84ep0vb4hu6MLoTcVdobUp0opmbRUTJrvDzfJKR3Av8frq9206eAucNvBbKno
         Kc3fySH6Lz6LVqekX8o8A6pScRwe/Jh08SHbI0ncFyG3wK1al2eLaPtjeL286vffyc
         eYpKfmdwpUYu3/8TIpF3CDJ/DRfrwJUp9sVpZPdQ2l6bukNCX3JUA8ChLW5zBZ+46u
         6Y9OswXDQx+dxVlFhjaB4q364oDytE3f08Ur+dDlp82CAMSCqgf3JoV6fRc4RikJB7
         JObp9aprvSDXf6QNffVhlvLTdmMvDmMQdlIGSZxRszE5Y9xm91k+pdJL+W11zbjxuc
         r7O/aQ8PifFmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 08D005C0AC7; Thu, 29 Sep 2022 09:11:36 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:11:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Peter Oskolkov <posk@posk.io>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH] rseq: Use pr_warn_once() when deprecated/unknown ABI
 flags are encountered
Message-ID: <20220929161136.GK4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220929141227.205343-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929141227.205343-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:12:27AM -0400, Mathieu Desnoyers wrote:
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

Acked-by: Paul E. McKenney <paulmck@kernel.org>

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
