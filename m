Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2DB60545E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 02:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJTAHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 20:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJTAHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 20:07:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB011946E5;
        Wed, 19 Oct 2022 17:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D806B82626;
        Thu, 20 Oct 2022 00:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21371C433C1;
        Thu, 20 Oct 2022 00:07:42 +0000 (UTC)
Date:   Wed, 19 Oct 2022 20:07:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add trace_trigger kernel command line option
Message-ID: <20221019200745.0152fc51@gandalf.local.home>
In-Reply-To: <20221019200137.70343645@gandalf.local.home>
References: <20221019200137.70343645@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 20:01:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -90,6 +90,10 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
>  #ifdef CONFIG_TRACEPOINTS
>  static inline void tracepoint_synchronize_unregister(void)
>  {
> +	/* Early updates do not need synchronization */
> +	if (early_boot_irqs_disabled)
> +		return;
> +
>  	synchronize_srcu(&tracepoint_srcu);
>  	synchronize_rcu();

I wonder if this check should be just moved to the RCU synchronization
code? That is, if early_boot_irqs_disabled is set, do nothing, as there
should be nothing to synchronize against.

It took me a bit to figure out why I was constantly getting:

[    1.072013] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    1.078888] ------------[ cut here ]------------
[    1.083422] Interrupts were enabled early
[    1.087399] WARNING: CPU: 0 PID: 0 at init/main.c:1061 start_kernel+0x36f/0x4e8
[    1.094656] Modules linked in:
[    1.097683] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc1-test+ #461
[    1.104509] Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
[    1.113411] RIP: 0010:start_kernel+0x36f/0x4e8
[    1.117817] Code: 48 27 5f e8 fd 7b 03 00 e8 55 72 e5 fe e8 6b 05 03 00 ff 15 2a f9 89 ff 0f ba e0 09 73 0e 48 c7 c7 98 26 31 a0 e8 01 5b df fe <0f> 0b c6 05 c7 2c af ff 00 e8 da 36 47 fe ff 15 14 f9 89 ff e8 56
[    1.136485] RSP: 0000:ffffffffa0603f30 EFLAGS: 00010286
[    1.141670] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    1.148754] RDX: 0000000000000002 RSI: 00000000ffffdfff RDI: 0000000000000001
[    1.155840] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffa0603dd8
[    1.162926] R10: 0000000000000003 R11: ffffffffa0734168 R12: 000000000000180a
[    1.170011] R13: 00000000010fecf0 R14: 0000000000000000 R15: 00000000d44e3018
[    1.177097] FS:  0000000000000000(0000) GS:ffff91909aa00000(0000) knlGS:0000000000000000
[    1.185131] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.190835] CR2: ffff91909edff000 CR3: 000000007760a001 CR4: 00000000000606f0
[    1.197924] Call Trace:
[    1.200345]  <TASK>


It was a bit of whack-a-mole in finding all the places that were calling
synchronize RCU.

-- Steve
