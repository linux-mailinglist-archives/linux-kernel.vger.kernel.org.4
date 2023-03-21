Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263296C2D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCUJIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCUJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:08:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E85F13D74
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:08:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679389710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LeqlgeXC0c3Uvq35CAS78MKG30bbh9aQkZzNydWZa4s=;
        b=cASpB3MAiFnHhrbsprbDwkxt+pBOInQxuLeeF1qREMAh7R5fFdGHwY62AiT3bcIPWNOEhv
        eqnYQFHlZDvLcYsoz51wFfv4mAASVGQVXS1rDiBoBNg4b4628ylj/X79olrPs4IiXoLuad
        qDP2IuZEHN+Ja8WZButBvAKamQiIoKo1AAs+tpO4l5Mn7tMGHtPRCRdq/NJON1XDw4Ew7W
        +ONRsXclJsQGns7EH1R4Zjy0gcd2ZCmPQZ5VcUKiEiUqK6B85EsdNmODAR0/RxoVFLB+RK
        ooARSGB6ABHP4plBNq19xlKZ5aSoUn7LGrG02QPkbUCgiUaXLnhiX7h33K/KkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679389710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LeqlgeXC0c3Uvq35CAS78MKG30bbh9aQkZzNydWZa4s=;
        b=m4c/LHBd5HHJ7/VklceUnYFyzAEWu4vIgc3gFkhMG+mmWgeycT4xOD0+DndvFsIPgodcTi
        w3WZs8TxsSSTeoAA==
To:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/entry: Fix noinstr warning in __enter_from_user_mode()
In-Reply-To: <d8955fa6d68dc955dda19baf13ae014ae27926f5.1677369694.git.jpoimboe@kernel.org>
References: <d8955fa6d68dc955dda19baf13ae014ae27926f5.1677369694.git.jpoimboe@kernel.org>
Date:   Tue, 21 Mar 2023 10:08:29 +0100
Message-ID: <87jzzaa2uq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25 2023 at 16:01, Josh Poimboeuf wrote:
> __enter_from_user_mode() is triggering noinstr warnings with
> CONFIG_DEBUG_PREEMPT due to its call of preempt_count_add() via
> ct_state().
>
> The preemption disable isn't needed as interrupts are already disabled.
> And the context_tracking_enabled() check in ct_state() also isn't needed
> as that's already being done by the CT_WARN_ON().
>
> Just use __ct_state() instead.
>
> Fixes the following warnings:
>
>   vmlinux.o: warning: objtool: enter_from_user_mode+0xba: call to preempt_count_add() leaves .noinstr.text section
>   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0xf9: call to preempt_count_add() leaves .noinstr.text section
>   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0xc7: call to preempt_count_add() leaves .noinstr.text section
>   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0xba: call to preempt_count_add() leaves .noinstr.text section
>
> Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  include/linux/context_tracking.h | 1 +
>  kernel/entry/common.c            | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
> index d4afa8508a80..3a7909ed5498 100644
> --- a/include/linux/context_tracking.h
> +++ b/include/linux/context_tracking.h
> @@ -96,6 +96,7 @@ static inline void user_exit_irqoff(void) { }
>  static inline int exception_enter(void) { return 0; }
>  static inline void exception_exit(enum ctx_state prev_ctx) { }
>  static inline int ct_state(void) { return -1; }
> +static inline int __ct_state(void) { return -1; }

This results in a redefinition warning due to CONFIG_CONTEXT_TRACKING=y
and CONFIG_CONFIG_TRACKING_USER=n.

Those headers are a fricking mess.

Thanks,

        tglx
