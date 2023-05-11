Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B56FF7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbjEKQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbjEKQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:56:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A76F2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:56:45 -0700 (PDT)
Date:   Thu, 11 May 2023 18:56:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683824203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fzzbsCVi7GvUd2V67j0Lvhw+Gwm8cyLvwO3BwKeq5Y4=;
        b=LdiRiRtG6IrwZXD2jj8uL/5z8VSVlgEd/5LzrScWGMJ1hptVUif1X6Zlr7rLiE7GMmd5W4
        gSja1+XS45yTo+S9HfQQs+lIsXQKmM0X4YipEIIwoLqRjY0QQBgaGBuECP5kTlQ78UrbnK
        Q0W0Md1kFBUMbvLrLu2p05kQ5eCvGTD+jXvUOxFUY+TXrv89XUreZQkar60ICmRcO9g4QM
        VEMoxR7FfSRyA9jUdM66EWN8iDwROa+ZbEIy7xOCLyGcCRI3xRe0u3AtgCkQwjkpjXng+I
        l2Ohi7l2LU1WGIfyFeQDpT1NBzPv+ZSY1kI+iftlJejgZdR/unutZiMwfIca6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683824203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fzzbsCVi7GvUd2V67j0Lvhw+Gwm8cyLvwO3BwKeq5Y4=;
        b=SpZYZlybzq6PQp/IH/W0HRuY7d6aOh8HvBN7wDZDKhpW0IOct+TGK2MNYacZyZ2klPzti3
        yoYvCX/MhQW5nNDA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 19/21] timer: Implement the hierarchical pull model
Message-ID: <20230511165641.GNlGBnIT@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-20-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230510072817.116056-20-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-10 09:28:15 [+0200], Anna-Maria Behnsen wrote:
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -2240,6 +2278,15 @@ static void run_timer_base(int index)
>  	__run_timer_base(base);
>  }
>  
> +#ifdef CONFIG_SMP
 && CONFIG_NO_HZ_COMMON

> +void timer_expire_remote(unsigned int cpu)
> +{
> +	struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
> +
> +	__run_timer_base(base);
> +}
> +#endif
> +
>  /*
>   * This function runs timers and the timer-tq in bottom half context.
>   */

Sebastian
