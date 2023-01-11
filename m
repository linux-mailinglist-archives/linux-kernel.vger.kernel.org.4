Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F86E665E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbjAKOgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbjAKOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:34:41 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6FD1CFF1;
        Wed, 11 Jan 2023 06:32:15 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 058067E55D;
        Wed, 11 Jan 2023 14:32:13 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673447535;
        bh=Y0aZSVEi7INxVva5qzpxsP+e3kt8XvIXcbfqPJSNvqc=;
        h=Date:To:From:Subject:From;
        b=e4ojP6dpexljMpkylq3NAXpi2DDn3zADipsxVlcavvGaJVJB8HvhRsq8Ie2d1uddA
         Wbc2sbqrUUkAJgIOGeJMp3vI72w/L1r1nxsPifZO5gh+zrITYhbTZmxz64u0n0u/fS
         e8ZAhfu/GYxOlz9cERgsMsZc2XPE/FLKnPM312UKfcpZDuD/GRsyu/84f+zLuo+MK3
         MeaBV5FyfqwdOTUaTlyiEI0KrVOmZl8HHsPe8bfLG9AXyeQ6OpIIquEwcKScmQcLzq
         RCCivyx+t4K5XCebDwrHJWC0rQwXQNtnULRaX9wyK9vEEB38m/fZNDrRO28MH1ikxu
         fWRRnzUE8c45g==
Message-ID: <160cffee-5be8-4e8f-22ee-2958695f0cd3@gnuweeb.org>
Date:   Wed, 11 Jan 2023 21:32:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux KBuild Mailing List <linux-kbuild@vger.kernel.org>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: scripts/decode_stacktrace.sh doesn't show the file name and line num?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


What is the kernel build config to enable debugging line by line?

With CONFIG_DEBUG_KERNEL=y, scripts/decode_stacktrace.sh doesn't show
the file name when used to decode a call trace. It shows "(??:?)" and
sometimes it shows the file name, but no line like (fair.c:?).

Running this in the Linux kernel compilation directory:

$ scripts/decode_stacktrace.sh vmlinux < kernel_log_from_dmesg.txt;
[...]
[ 1020.299126] RSP: 0018:ffff888106a97318 EFLAGS: 00000202
[ 1020.299131] RAX: ffff888106a973b3 RBX: ffff888106a973b0 RCX: ffffffff810acb79
[ 1020.299136] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffff888106a973b0
[ 1020.299140] RBP: ffff888106a97440 R08: dffffc0000000000 R09: fffffbfff0abd8cd
[ 1020.299145] R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888106a973f8
[ 1020.299149] R13: ffff888106a97408 R14: ffffffff8142c967 R15: ffff888106a976d0
[ 1020.299154] FS:  00007f190332e740(0000) GS:ffff889796180000(0000) knlGS:0000000000000000
[ 1020.299160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1020.299164] CR2: 0000000020002240 CR3: 000000015d478002 CR4: 00000000007706e0
[ 1020.299169] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1020.299171] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1020.299174] PKRU: 55555554
[ 1020.299175] Call Trace:
[ 1020.299176]  <TASK>
[ 1020.299178] unwind_next_frame (??:?)
[ 1020.299183] ? kasan_set_track (??:?)
[ 1020.299186] ? stack_trace_consume_entry (stacktrace.c:?)
[ 1020.299192] ? kasan_save_free_info (??:?)
[ 1020.299196] ? stack_trace_save (stacktrace.c:?)
[ 1020.299200] arch_stack_walk (??:?)
[ 1020.299205] ? kasan_save_free_info (??:?)
[ 1020.299209] ? tcp_rcv_established (??:?)
[ 1020.299213] stack_trace_save (??:?)
[ 1020.299218] kasan_set_track (??:?)
[ 1020.299222] ? kasan_set_track (??:?)
[ 1020.299225] ? kasan_save_free_info (??:?)
[ 1020.299229] ? io_wq_submit_work (??:?)
[ 1020.299232] ? io_worker_handle_work (io-wq.c:?)
[ 1020.299236] ? io_wqe_worker (io-wq.c:?)
[ 1020.299239] ? ret_from_fork (??:?)
[ 1020.299244] ? __mod_timer (timer.c:?)
[ 1020.299247] ? tcp_ack_update_rtt (tcp_input.c:?)
[ 1020.299251] ? cubictcp_cong_avoid (tcp_cubic.c:?)
[ 1020.299259] ? tcp_rate_gen (??:?)
[ 1020.299263] ? tcp_ack (tcp_input.c:?)
[ 1020.299268] ? kasan_save_free_info (??:?)
[ 1020.299273] ? __kmem_cache_free (??:?)
[ 1020.299278] kasan_save_free_info (??:?)
[ 1020.299285] ____kasan_slab_free (common.c:?)
[ 1020.299290] kmem_cache_free (??:?)
[ 1020.299294] ? tcp_rcv_established (??:?)
[ 1020.299300] tcp_rcv_established (??:?)
[ 1020.299305] tcp_v4_do_rcv (??:?)
[ 1020.299310] __release_sock (??:?)
[ 1020.299315] __sk_flush_backlog (??:?)
[ 1020.299318] tcp_sendmsg_locked (??:?)
[ 1020.299327] tcp_sendmsg (??:?)
[ 1020.299331] ? inet_send_prepare (??:?)
[ 1020.299335] ____sys_sendmsg (socket.c:?)
[ 1020.299341] __sys_sendmsg_sock (??:?)
[ 1020.299345] io_sendmsg_zc (??:?)
[ 1020.299350] ? update_load_avg (fair.c:?)
[ 1020.299354] ? reweight_entity (fair.c:?)
[ 1020.299359] ? psi_group_change (build_utility.c:?)
[ 1020.299365] ? io_assign_file (io_uring.c:?)
[ 1020.299369] io_issue_sqe (io_uring.c:?)
[ 1020.299372] io_wq_submit_work (??:?)
[ 1020.299376] io_worker_handle_work (io-wq.c:?)
[ 1020.299382] io_wqe_worker (io-wq.c:?)
[ 1020.299387] ? finish_task_switch (core.c:?)
[ 1020.299393] ? recalc_sigpending (??:?)
[ 1020.299398] ? create_worker_cont (io-wq.c:?)
[ 1020.299401] ret_from_fork (??:?)
[ 1020.299407]  </TASK>

-- 
Ammar Faizi
