Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF5F66029C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjAFOxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjAFOxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:53:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047B580AEF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:53:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 880E06170E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77BCC433EF;
        Fri,  6 Jan 2023 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673016811;
        bh=78UUdwZOPaG83oAbSmoNYuND6jYC1D7+vVTriLgEc5k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LeHJRv1hNWtxX/1Lp7htRP8afhS0AQckjzduO2zn0vW6NNm73IN7kUXbDgZt3mFvR
         xNr+0+d/ZXATFPz4F8PqrDikOt39VOLQZ1OtqzABCP7vH+UbpBQu8e7BRDvW63wtfw
         2vRRc6JhMxfM66/RcfQOr/UY913ZpNCben0m+wrApcLiTTt/387Q4zxLv29004nLZN
         dKGhB9HY+N4gSqCk3asaYJtfTnZCeH12+di319kNnOEPWMHFfdW5QIc7XfnNORCrSF
         sgunNDmHhZWDfaZCxZWTPxMb0h/8Vxlg59YwBMtdXy0blWpIMuFivppEhIun40yU0p
         8YK0Q6qq0HF0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 68ACA5C0920; Fri,  6 Jan 2023 06:53:31 -0800 (PST)
Date:   Fri, 6 Jan 2023 06:53:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Genjian <zhanggenjian123@gmail.com>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] context_tracking: Use arch_atomic_*() in __ct_user_enter
 and __ct_user_exit
Message-ID: <20230106145331.GS4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221110082443.4069161-1-zhanggenjian@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110082443.4069161-1-zhanggenjian@kylinos.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:24:43PM +0800, Genjian wrote:
> From: Genjian Zhang <zhanggenjian@kylinos.cn>
> 
> vmlinux.o: warning: objtool: __ct_user_enter+0x45: call to
> __kasan_check_write() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __ct_user_exit+0x3f: call to
> __kasan_check_write() leaves .noinstr.text section
> 
> noinstr cannot have atomic_*() functions.because they have explicit
> instrumentation.Switch to arch_ prefixed atomic operation functions to
> avoid the explicit instrumentation.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>

Apologies for the delay, but finally queued, thank you!  Frederic gave
his ack off-list, which I have included in the wordsmithed version below.
Could you please check to make sure that I did not mess anything up?

							Thanx, Paul

------------------------------------------------------------------------

commit 936acd859f4a7b2b0f9900e26bc972385286df6e
Author: Genjian Zhang <zhanggenjian@kylinos.cn>
Date:   Thu Nov 10 16:24:43 2022 +0800

    context_tracking: Use arch_atomic_*() in __ct_user_enter and __ct_user_exit
    
    The following diagnostics are issued by objtool:
    
    vmlinux.o: warning: objtool: __ct_user_enter+0x45: call to
    __kasan_check_write() leaves .noinstr.text section
    vmlinux.o: warning: objtool: __ct_user_exit+0x3f: call to
    __kasan_check_write() leaves .noinstr.text section
    
    The reason for these diagnostics is that code marked noinstr if prohibited
    from using atomic_*() functions, which have explicit instrumentation.
    Therefore, switch to arch_ prefixed atomic operation functions to avoid
    the explicit instrumentation.
    
    Reported-by: k2ci <kernel-bot@kylinos.cn>
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
    Acked-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 77978e3723771..a09f1c19336ae 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -510,7 +510,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * In this we case we don't care about any concurrency/ordering.
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
-				atomic_set(&ct->state, state);
+				arch_atomic_set(&ct->state, state);
 		} else {
 			/*
 			 * Even if context tracking is disabled on this CPU, because it's outside
@@ -527,7 +527,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
 				/* Tracking for vtime only, no concurrent RCU EQS accounting */
-				atomic_set(&ct->state, state);
+				arch_atomic_set(&ct->state, state);
 			} else {
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
@@ -535,7 +535,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
 				 * ordered.
 				 */
-				atomic_add(state, &ct->state);
+				arch_atomic_add(state, &ct->state);
 			}
 		}
 	}
@@ -630,12 +630,12 @@ void noinstr __ct_user_exit(enum ctx_state state)
 			 * In this we case we don't care about any concurrency/ordering.
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
-				atomic_set(&ct->state, CONTEXT_KERNEL);
+				arch_atomic_set(&ct->state, CONTEXT_KERNEL);
 
 		} else {
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
 				/* Tracking for vtime only, no concurrent RCU EQS accounting */
-				atomic_set(&ct->state, CONTEXT_KERNEL);
+				arch_atomic_set(&ct->state, CONTEXT_KERNEL);
 			} else {
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
@@ -643,7 +643,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
 				 * ordered.
 				 */
-				atomic_sub(state, &ct->state);
+				arch_atomic_sub(state, &ct->state);
 			}
 		}
 	}
