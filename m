Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE060BF15
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJXXzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiJXXyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:54:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68306302BD5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79905B80EDF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B8EC433C1;
        Mon, 24 Oct 2022 18:52:40 +0000 (UTC)
Date:   Mon, 24 Oct 2022 14:52:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
Message-ID: <20221024145250.08cfc147@gandalf.local.home>
In-Reply-To: <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
References: <20221024114536.44686c83@gandalf.local.home>
        <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
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

On Mon, 24 Oct 2022 11:19:31 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> in text_poke_bp(). And that, in turn, is because PeterZ ended up
> special-casing this all in commit 768ae4406a5c ("x86/ftrace: Use
> text_poke()")
> 
> Maybe we should just strive to get rid of all these SYSTEM_BOOTING
> special cases, instead of adding yet another a new one.
> 
> There's presumably "it slows down boot" reason to avoid the full
> text_poke_bp() dance, but do we really care for the "ftrace=function"
> case?
> 

It's not just speed up at boot up. It's because text_poke doesn't work at
early boot up when function tracing is enabled. If I remove the
SYSTEM_BOOTING checks in text_poke() this happens:

[    0.963966] ftrace: allocating 47021 entries in 184 pages
[    0.969376] ftrace section at ffffffff89ef54c0 sorted properly
[    0.982126] ftrace: allocated 184 pages with 4 groups
[    1.009779] Starting tracer 'function'
[    1.013753] BUG: kernel NULL pointer dereference, address: 0000000000000048
[    1.020516] #PF: supervisor read access in kernel mode
[    1.025616] #PF: error_code(0x0000) - not-present page
[    1.030718] PGD 0 P4D 0 
[    1.033224] Oops: 0000 [#1] PREEMPT SMP PTI
[    1.037373] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-test+ #496
[    1.044031] Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
[    1.052934] RIP: 0010:walk_to_pmd+0x17/0x130
[    1.057172] Code: 1f ff ff ff 0f 0b e9 ed fe ff ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f0 41 55 48 c1 e8 24 41 54 25 f8 0f 00 00 55 53 <48> 03 47 48 0f 84 c4 00 00 00 49 89 fc 48 8b 38 48 89 f3 48 89 c5
[    1.075846] RSP: 0000:ffffffff89603cd8 EFLAGS: 00010046
[    1.081033] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffd0f980000000
[    1.088121] RDX: ffffffff89603d68 RSI: 0000000000000000 RDI: 0000000000000000
[    1.095213] RBP: 0000000000000000 R08: ffffffff8a017cf0 R09: ffffffff8a017cf1
[    1.102302] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89603d68
[    1.109389] R13: 000000000000031e R14: 000000000000031f R15: 8000000000000063
[    1.116479] FS:  0000000000000000(0000) GS:ffffa068daa00000(0000) knlGS:0000000000000000
[    1.124516] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.130220] CR2: 0000000000000048 CR3: 000000000760a001 CR4: 00000000000606f0
[    1.137309] Call Trace:
[    1.139732]  <TASK>
[    1.141805]  __get_locked_pte+0x1b/0x120
[    1.145694]  ? ftrace_caller_op_ptr+0x17/0x17
[    1.150016]  __text_poke+0xf8/0x540
[    1.153474]  ? patch_retpoline+0x170/0x170
[    1.157536]  ? text_poke_loc_init+0x5b/0x170
[    1.161773]  text_poke_bp_batch+0x86/0x290
[    1.165835]  ? cache_mod+0x280/0x280
[    1.169378]  text_poke_bp+0x3a/0x60
[    1.172836]  ftrace_update_ftrace_func+0x3e/0x80
[    1.177416]  ftrace_modify_all_code+0x79/0x160
[    1.181827]  ftrace_startup+0xbd/0x150
[    1.185544]  ? ftrace_stacktrace_count+0xc0/0xc0
[    1.190128]  register_ftrace_function_nolock+0x20/0x60
[    1.195227]  register_ftrace_function+0xc7/0x130
[    1.199807]  ? ftrace_stacktrace_count+0xc0/0xc0
[    1.204390]  function_trace_init+0x71/0xd0
[    1.208454]  tracing_set_tracer+0x172/0x280
[    1.212603]  register_tracer+0x1e0/0x205
[    1.216495]  tracer_alloc_buffers.isra.0+0x1f8/0x2fe
[    1.221421]  start_kernel+0x21f/0x4e8
[    1.225051]  ? x86_64_start_kernel+0x60/0x78
[    1.229288]  secondary_startup_64_no_verify+0xd3/0xdb
[    1.234301]  </TASK>
[    1.236459] Modules linked in:
[    1.239484] CR2: 0000000000000048
[    1.242769] ---[ end trace 0000000000000000 ]---

Interrupts haven't been enabled yet, so things are still rather fragile at
this point of start up.

-- Steve
