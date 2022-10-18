Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3C0602E84
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiJRObV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiJRObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:31:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8490ED18C0;
        Tue, 18 Oct 2022 07:31:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666103462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MLMPh+VEr75kZkd+eYzhBIY3KKkr96JkW8HhJitdN78=;
        b=OXLHe5M1Y5T1ZTGP5/KZegsG1xGrCvxK0T9LyaZxE5Ak78IMgONLInFsvxdLZQPVJJGR4q
        9t5fT2ynUXEpri3m8kEv6d9zMU3kPD/FheA8PD9xJqFwIJ8XRgsq5Xvu/bcYaoQEhbbf6x
        bwrsYpv7RCRyewMBbuKOWKA2r5v1lIEfXYqidJ/YP5Gz6yMslfvWRlj+hq86gFO1yMX9qw
        Dytb5O+PxjOz1aTslGvef0fVMhCtacgbEuiuKegnPHYL4go4KbPdl0TZOZJvV6PeQdHVQG
        p0nBkDLpx3vQL9ah1rpOcql2pOjr+9AtNJ+Ct330ddu5BOBi8PqHLjBf7u6tdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666103462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MLMPh+VEr75kZkd+eYzhBIY3KKkr96JkW8HhJitdN78=;
        b=y3bblRLhMSpA1vVXTrZfZHOu2Br10sq4Cli871mDjX/TbcDx806u+wtfKgRfEQQ4X0b5XE
        jVO7gqCgFQYoDCBA==
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 2/8] srcu: Create an srcu_read_lock_nmisafe()
 and srcu_read_unlock_nmisafe()
In-Reply-To: <20220929180731.2875722-2-paulmck@kernel.org>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-2-paulmck@kernel.org>
Date:   Tue, 18 Oct 2022 16:37:01 +0206
Message-ID: <87edv54316.fsf@jogness.linutronix.de>
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

Hi Paul,

Sorry for the late response here. I am now trying to actually use this
series.

On 2022-09-29, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index d471d22a5e21..f53ad63b2bc6 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -72,6 +72,9 @@ config TREE_SRCU
>  	help
>  	  This option selects the full-fledged version of SRCU.
>  

You are missing a:

+config ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
+	bool
+

Otherwise there is no CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS, so for
example CONFIG_NEED_SRCU_NMI_SAFE always ends up with y on X86.

> +config NEED_SRCU_NMI_SAFE
> +	def_bool HAVE_NMI && !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !TINY_SRCU
> +

John
