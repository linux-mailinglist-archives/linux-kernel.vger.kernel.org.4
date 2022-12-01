Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6785E63F9EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiLAVgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLAVgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:36:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503CC3591
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:36:40 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669930599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icig6D4uwgAQyDOUbFopZsRfmuZi+WK53OPg6HW+JRU=;
        b=NX+k8RQM4YlaqjZeJz0Y1Vk+qNKus8Tl1OBXr2OcSvK7SaUUzwMvwxphSSY3/Mc5SGhN8V
        CEbx9R92E8fFpXIiWX4jNtXg4QgpAlXhAHeRI8M6pfmC1+5ZwDVfVZO+LJQeDAPEzy3S78
        gczQcIJlYC9MP82mxP/f7zWVLGT4BLYlrtXXNolI80h/kYsy97MkdzdYhn5PPlIclg9reJ
        PDO7Mgjtz1Y/5u22yHRkdTCp+nGy28tcgai9RC3WjjMxcSFu02whtA+C+LITUpVJEVlZ1I
        hQxVxsuIIhVsLHDeA81W/rYwee1Va/tNX6vZE35n7Do9abnsPp0Kv3xFs205Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669930599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icig6D4uwgAQyDOUbFopZsRfmuZi+WK53OPg6HW+JRU=;
        b=0GzhW6EDRm8dAsMiWKcYDsegtU3geKer2vTa1G5lCIV8FGmWBovVXy3iWXfpsvPbFr69p5
        fZ8ADrX8JcsV3fCg==
To:     Nathan Chancellor <nathan@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 03/40] printk: Prepare for SRCU console list
 protection
In-Reply-To: <Y4jw3hSuwt3RG4DL@dev-arch.thelio-3990X>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-4-john.ogness@linutronix.de>
 <Y4jw3hSuwt3RG4DL@dev-arch.thelio-3990X>
Date:   Thu, 01 Dec 2022 22:42:25 +0106
Message-ID: <87lenqq012.fsf@jogness.linutronix.de>
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

Hi Nathan,

Thanks for reporting this. Patch below.

@paulmck: Please also take a look below.

On 2022-12-01, Nathan Chancellor <nathan@kernel.org> wrote:
> bad: scheduling from the idle thread!
> CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1+ #1
> Hardware name: PowerMac3,1 7400 0xc0209 PowerMac
> Call Trace:
> [c0bc1db0] [c07f07e0] dump_stack_lvl+0x34/0x50 (unreliable)
> [c0bc1dd0] [c008429c] dequeue_task_idle+0x34/0x5c
> [c0bc1df0] [c0820924] __schedule+0x56c/0x5c4
> [c0bc1e40] [c08209d0] schedule+0x54/0xfc
> [c0bc1e60] [c0826034] schedule_timeout+0x13c/0x194
> [c0bc1ea0] [c082134c] __wait_for_common+0xcc/0x1f4
> [c0bc1ee0] [c00ac8ac] synchronize_srcu+0xc8/0x12c
> [c0bc1f20] [c00a0230] unregister_console+0xc8/0x10c
> [c0bc1f40] [c009e314] register_console+0x2f4/0x390
> [c0bc1f60] [c0a17510] pmz_console_init+0x34/0x48
> [c0bc1f70] [c0a0491c] console_init+0x9c/0xf0
> [c0bc1fa0] [c09f5584] start_kernel+0x588/0x6ac
> [c0bc1ff0] [00003540] 0x3540

This config is using TINY_RCU. Its srcu_synchronize() implementation
does not check if it called before scheduling is ready. The following
patch will fix it.

@paulmck: Should it check (system_state < SYSTEM_SCHEDULING) instead
since TINY_RCU does not use @rcu_scheduler_active?

John Ogness

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 33adafdad261..35338e6e37e7 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -197,6 +197,9 @@ void synchronize_srcu(struct srcu_struct *ssp)
 {
 	struct rcu_synchronize rs;
 
+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
+		return;
+
 	init_rcu_head_on_stack(&rs.head);
 	init_completion(&rs.completion);
 	call_srcu(ssp, &rs.head, wakeme_after_rcu);
