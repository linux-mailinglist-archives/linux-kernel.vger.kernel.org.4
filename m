Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996B866AA80
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjANJgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjANJgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:36:08 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E961BB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:36:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ud5so57537659ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33jFHcoTtTQr8UT3DZSacmDPfZLZk/zJi/JH7AxdZZ0=;
        b=kEK8SFhirW51xyDO5wUq/gSB+IjhgOgKOSwkwqtMfl9tZ+Y8Iqm3GFzZGHNnaLSc/M
         DuJKrlrOklfoTtiJ+E6aGshccXSHy81tSOrCHkpHmYjQuatSTvDxLNTZBELcni2ONT5s
         oaOtnD/x14oxJ/3fNY/CDBdsJm762WOd6SJWa0gy7WgqcXDUmXGV7VicHIHsZKj7Tjf6
         dqcL2W1jvWYpcSac5YGGs0zBfiOt1zGba6zMnYuq/7aDxgSBlMtVj8QiBjK+irgp9IXt
         fyth29q0/oEra8Az5l/9MARAYW8JZTfRsUDNJi1bJPu9JzlNj2xNt4Cwks5eBYYn7nzM
         vMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33jFHcoTtTQr8UT3DZSacmDPfZLZk/zJi/JH7AxdZZ0=;
        b=mVljl6VJc7sXnpSv7h5rt0wZ7fG5a/w0QNpNzqqRpvBoQcXPESOw+ZO/rmSQZV2bDC
         +Rh0RIcmCDbzMU60wDxzj7fydEb7938g2vXZuFHQojETN0cWJc3H7EgyzW+5RJGaq/Z9
         YDaToE0nBLm8aC3wArmW54SRUiMKX42gF0bPXLCzjAI9A8PzNr6oQuuBfb7UW+VAapA7
         BtlYdKM7g2uiV+kK6XW8eVqt1AJu8BMn7W619BfDGQsBSKyZIP0ZlvpaOQP8FGWJtM6j
         XMsoAj+R+F7yakX1hM8d44uOz/OH1yza9TKWsEW8fmDlL0B71s5+vqJww8ri5vn4WCFt
         Dcog==
X-Gm-Message-State: AFqh2krmKYSc45N1hcP1RYnlWrXzbJLS+Jnjiw9pAfTsUsA6GTzsT97M
        4DbefcAxSC8PkS6WfKZLna4=
X-Google-Smtp-Source: AMrXdXvBK1CpWa72vlvySH0ErnyDFgxitaHBkJ6FIWn3OonAReNzGThRAHsYP17AI6uqHD4RA2Mg8w==
X-Received: by 2002:a17:906:7fd7:b0:86c:fa4c:220e with SMTP id r23-20020a1709067fd700b0086cfa4c220emr1574223ejs.3.1673688962902;
        Sat, 14 Jan 2023 01:36:02 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056402530900b00463bc1ddc76sm1350801edb.28.2023.01.14.01.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 01:36:01 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 14 Jan 2023 10:36:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 (repost)] locking/lockdep: add
 debug_show_all_lock_holders()
Message-ID: <Y8J3gAXLf4yc0FcL@gmail.com>
References: <41f43b27-d910-78e0-c0b3-f2885fe1cd22@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f43b27-d910-78e0-c0b3-f2885fe1cd22@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> --- a/include/linux/debug_locks.h
> +++ b/include/linux/debug_locks.h
> @@ -48,7 +48,18 @@ extern int debug_locks_off(void);
>  #endif
>  
>  #ifdef CONFIG_LOCKDEP
> -extern void debug_show_all_locks(void);
> +extern void __debug_show_all_locks(bool show_stack);
> +
> +static inline void debug_show_all_locks(void)
> +{
> +	__debug_show_all_locks(false);
> +}
> +
> +static inline void debug_show_all_lock_holders(void)
> +{
> +	__debug_show_all_locks(true);
> +}
> +
>  extern void debug_show_held_locks(struct task_struct *task);
>  extern void debug_check_no_locks_freed(const void *from, unsigned long len);
>  extern void debug_check_no_locks_held(void);
> @@ -61,6 +72,10 @@ static inline void debug_show_held_locks(struct task_struct *task)
>  {
>  }
>  
> +static inline void debug_show_all_lock_holders(void)
> +{
> +}
> +

> -		debug_show_all_locks();
> +		debug_show_all_lock_holders();

> -void debug_show_all_locks(void)
> +void __debug_show_all_locks(bool show_stack)
>  {
>  	struct task_struct *g, *p;
>  
> @@ -6495,12 +6496,19 @@ void debug_show_all_locks(void)
>  		pr_warn("INFO: lockdep is turned off.\n");
>  		return;
>  	}
> -	pr_warn("\nShowing all locks held in the system:\n");
> +	if (show_stack)
> +		pr_warn("\nShowing all threads with locks held in the system:\n");
> +	else
> +		pr_warn("\nShowing all locks held in the system:\n");
>  
>  	rcu_read_lock();
>  	for_each_process_thread(g, p) {
>  		if (!p->lockdep_depth)
>  			continue;
> +		if (p == current && p->lockdep_depth == 1)
> +			continue;
> +		if (show_stack)
> +			sched_show_task(p);
>  		lockdep_print_held_locks(p);
>  		touch_nmi_watchdog();
>  		touch_all_softlockup_watchdogs();

Yeah, so note how you introduce a function with a parameter:

	void __debug_show_all_locks(bool show_stack)

... only to then *hide* the new parameter via helper functions:

	static inline void debug_show_all_locks(void)
	{
		__debug_show_all_locks(false);
	}

	static inline void debug_show_all_lock_holders(void)
	{
		__debug_show_all_locks(true);
	}

... which is a *strong* hint by our universe that the new parameter was 
probably a bad idea to begin with.

Given how small debug_show_all_locks() is to begin with, I'd suggest simply 
duplicating the loop into debug_show_all_lock_holders() or so.

Thanks,

	Ingo
