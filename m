Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512DD5EC997
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiI0QeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiI0Qd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:33:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690FD1D88DE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC9DCB81C5B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F888C433D6;
        Tue, 27 Sep 2022 16:33:51 +0000 (UTC)
Date:   Tue, 27 Sep 2022 12:35:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <song@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] ftrace: fix recursive locking direct_mutex in
 ftrace_modify_direct_caller
Message-ID: <20220927123500.76b07f73@gandalf.local.home>
In-Reply-To: <20220927004146.1215303-1-song@kernel.org>
References: <20220927004146.1215303-1-song@kernel.org>
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


Minor nit, just change the subject to start with a capital letter.

 ftrace: Fix recursive locking direct_mutex in ftrace_modify_direct_caller

Other than that, this looks good.

Do you want to put this through your tree, or do you want me to take it?

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


On Mon, 26 Sep 2022 17:41:46 -0700
Song Liu <song@kernel.org> wrote:

> Naveen reported recursive locking of direct_mutex with sample
> ftrace-direct-modify.ko:
> 
> [   74.762406] WARNING: possible recursive locking detected
> [   74.762887] 6.0.0-rc6+ #33 Not tainted
> [   74.763216] --------------------------------------------
> [   74.763672] event-sample-fn/1084 is trying to acquire lock:
> [   74.764152] ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
>     register_ftrace_function+0x1f/0x180
> [   74.764922]
> [   74.764922] but task is already holding lock:
> [   74.765421] ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
>     modify_ftrace_direct+0x34/0x1f0
> [   74.766142]
> [   74.766142] other info that might help us debug this:
> [   74.766701]  Possible unsafe locking scenario:
> [   74.766701]
> [   74.767216]        CPU0
> [   74.767437]        ----
> [   74.767656]   lock(direct_mutex);
> [   74.767952]   lock(direct_mutex);
> [   74.768245]
> [   74.768245]  *** DEADLOCK ***
> [   74.768245]
> [   74.768750]  May be due to missing lock nesting notation
> [   74.768750]
> [   74.769332] 1 lock held by event-sample-fn/1084:
> [   74.769731]  #0: ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
>     modify_ftrace_direct+0x34/0x1f0
> [   74.770496]
> [   74.770496] stack backtrace:
> [   74.770884] CPU: 4 PID: 1084 Comm: event-sample-fn Not tainted ...
> [   74.771498] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ...
> [   74.772474] Call Trace:
> [   74.772696]  <TASK>
> [   74.772896]  dump_stack_lvl+0x44/0x5b
> [   74.773223]  __lock_acquire.cold.74+0xac/0x2b7
> [   74.773616]  lock_acquire+0xd2/0x310
> [   74.773936]  ? register_ftrace_function+0x1f/0x180
> [   74.774357]  ? lock_is_held_type+0xd8/0x130
> [   74.774744]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
> [   74.775213]  __mutex_lock+0x99/0x1010
> [   74.775536]  ? register_ftrace_function+0x1f/0x180
> [   74.775954]  ? slab_free_freelist_hook.isra.43+0x115/0x160
> [   74.776424]  ? ftrace_set_hash+0x195/0x220
> [   74.776779]  ? register_ftrace_function+0x1f/0x180
> [   74.777194]  ? kfree+0x3e1/0x440
> [   74.777482]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
> [   74.777941]  ? __schedule+0xb40/0xb40
> [   74.778258]  ? register_ftrace_function+0x1f/0x180
> [   74.778672]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
> [   74.779128]  register_ftrace_function+0x1f/0x180
> [   74.779527]  ? ftrace_set_filter_ip+0x33/0x70
> [   74.779910]  ? __schedule+0xb40/0xb40
> [   74.780231]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
> [   74.780678]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
> [   74.781147]  ftrace_modify_direct_caller+0x5b/0x90
> [   74.781563]  ? 0xffffffffa0201000
> [   74.781859]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
> [   74.782309]  modify_ftrace_direct+0x1b2/0x1f0
> [   74.782690]  ? __schedule+0xb40/0xb40
> [   74.783014]  ? simple_thread+0x2a/0xb0 [ftrace_direct_modify]
> [   74.783508]  ? __schedule+0xb40/0xb40
> [   74.783832]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
> [   74.784294]  simple_thread+0x76/0xb0 [ftrace_direct_modify]
> [   74.784766]  kthread+0xf5/0x120
> [   74.785052]  ? kthread_complete_and_exit+0x20/0x20
> [   74.785464]  ret_from_fork+0x22/0x30
> [   74.785781]  </TASK>
> 
> Fix this by using register_ftrace_function_nolock in
> ftrace_modify_direct_caller.
> 
> Fixes: 53cd885bc5c3 ("ftrace: Allow IPMODIFY and DIRECT ops on the same function")
> Reported-and-tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Song Liu <song@kernel.org>
> 
