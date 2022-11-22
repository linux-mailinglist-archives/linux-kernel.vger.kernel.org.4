Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A90634AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiKVXOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiKVXOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:14:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713B4C4945
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:14:30 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669158867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zS9dWEV/h5JIrsxFQ5b1PlCIyhlmU6h4P3CnzGwt0T0=;
        b=b27rlAuygSqLkrwxyFvSZRDL436WYtIqaVVVuf8aCSK3PZkYsyj0VjtCV8ENICnjBGC+8g
        PHAQ4wl6kMPqX+z+OqBhgZwSgj8gtD+/ZNHsa8sk8KcdWCqueMIpkd7u14UMPoG0vYsAX4
        FdeRHCHyFCEnNaCKh5WkZ/f2VdycJbulBMfxd5aap6JY/1SvW5QNpLv23+d9XKgGoTnf1f
        BqgdTbYsPcOPpipUVDys24AnSJSwxMT/Iksfh3x+8HF0K8e29ECZX2iSo9217fpWN/W7YY
        4Vv5Ng7H1xxFBKW08XUnFPIbZNrD77xMCw3BPMblFjUpFgNHSuN3PlRv0k/R2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669158867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zS9dWEV/h5JIrsxFQ5b1PlCIyhlmU6h4P3CnzGwt0T0=;
        b=G8oemVjkccQozmMQSXzJn8EnblAmzlocK6v6ciEdhxMJc9A0D7tcyC+o+sW06NjwACYlxw
        gibrUnDkd2q7U1Ag==
To:     paulmck@kernel.org, Petr Mladek <pmladek@suse.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
 [-Werror,-Wimplicit-int]
In-Reply-To: <20221122220053.GO4001@paulmck-ThinkPad-P17-Gen-1>
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <87leo3ovpw.fsf@jogness.linutronix.de> <Y3zw7nv5KJ32P4FG@alley>
 <20221122220053.GO4001@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 23 Nov 2022 00:20:19 +0106
Message-ID: <87wn7m7fas.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-22, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> And here is a first cut.  There will be more patches removing uses
> of CONFIG_SRCU.
>
> Thoughts?

I am happy with it. Thanks!

>     rcu: Make SRCU mandatory
>     
>     Kernels configured with CONFIG_PRINTK=n and CONFIG_SRCU=n get build
>     failures.  This causes trouble for deep embedded systems.  But given
>     that there are more than 25 instances of "select SRCU" in the kernel,
>     it is hard to believe that there are many kernels running in production
>     without SRCU.  This commit therefore makes SRCU mandatory.  The SRCU
>     Kconfig option remains for backwards compatibility, and will be removed
>     when it is no longer used.
>     
>     Reported-by: John Ogness <john.ogness@linutronix.de>
>     Reported-by: Petr Mladek <pmladek@suse.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
