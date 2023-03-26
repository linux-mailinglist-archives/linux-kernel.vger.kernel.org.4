Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2356F6C9634
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjCZPmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCZPmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:42:33 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8621A19BA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:42:32 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32QFgRc3010635;
        Sun, 26 Mar 2023 17:42:27 +0200
Date:   Sun, 26 Mar 2023 17:42:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tools/nolibc: add support for stack protector
Message-ID: <ZCBn41F81oSf9m5H@1wt.eu>
References: <20230325154516.7995-1-w@1wt.eu>
 <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
 <a65340bb-2d11-445b-8595-9bf25a9f7a47@paulmck-laptop>
 <ZCBiDZfQW+YuiVNs@1wt.eu>
 <35a26245-0171-44b0-8072-325576768f91@paulmck-laptop>
 <46896df9-4bbc-4c24-906f-b4f0941a4cbf@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46896df9-4bbc-4c24-906f-b4f0941a4cbf@paulmck-laptop>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 08:30:52AM -0700, Paul E. McKenney wrote:
> But that got the same result, 0 tests passed and the splat below.
> 
> My next step would be to rebase the stack back to v6.2, but in
> the meantime, thoughts?

I'm currently rebuilding to retry. My eye got attracted by this in
your trace:

> [    4.733345] Run /init as init process
> [    4.759675] BUG: unable to handle page fault for address: 000000000001d5db
> [    4.760006] #PF: supervisor read access in kernel mode
> [    4.760164] #PF: error_code(0x0000) - not-present page
> [    4.760361] PGD 2998067 P4D 2998067 PUD 29a5067 PMD 0 
> [    4.760694] Oops: 0000 [#1] SMP NOPTI
> [    4.760917] CPU: 0 PID: 1 Comm: init Not tainted 6.3.0-rc1-00022-gd6bb807e5889 #3
> [    4.761194] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [    4.761499] RIP: 0010:__lock_acquire+0x5b5/0x2700
> [    4.761869] Code: 00 83 f8 2f 0f 87 40 07 00 00 3b 05 e9 d8 6e 02 41 bf 01 00 00 00 0f 86 f5 00 00 00 89 05 d7 d8 6e 02 e9 ea 00 00 00 45 31 f6 <48> 81 3f a0 c8 5e 85 45 0f 45 f0 83 fe 01 0f 87 96 fa ff ff 89 f0
> [    4.762391] RSP: 0018:ffffa0f4c0013c50 EFLAGS: 00000046
> [    4.762567] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> [    4.762765] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000001d5db
> [    4.762959] RBP: ffff9d9341140000 R08: 0000000000000001 R09: 0000000000000001
> [    4.763153] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> [    4.763346] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    4.763578] FS:  0000000000000000(0000) GS:ffff9d9347a00000(0000) knlGS:0000000000000000
> [    4.763804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.763970] CR2: 000000000001d5db CR3: 00000000028da000 CR4: 00000000000006f0
> [    4.764223] Call Trace:
> [    4.764389]  <TASK>
> [    4.764529]  ? lock_acquire+0xbf/0x310
> [    4.764689]  lock_acquire+0xbf/0x310
> [    4.764819]  ? add_timer_on+0x80/0x130
> [    4.764939]  ? add_timer_on+0x78/0x130
> [    4.765048]  ? lock_release+0xbe/0x2a0
> [    4.765162]  _raw_spin_lock+0x2b/0x40
> [    4.765275]  ? add_timer_on+0x80/0x130
> [    4.765384]  add_timer_on+0x80/0x130
> [    4.765495]  try_to_generate_entropy+0x250/0x270
> [    4.765630]  ? find_held_lock+0x2b/0x80
> [    4.765749]  ? __pfx_entropy_timer+0x10/0x10
> [    4.765874]  ? 0xffffffff83000000
> [    4.766068]  wait_for_random_bytes+0x49/0xe0
> [    4.766198]  __x64_sys_getrandom+0x8e/0xc0

The stackprot code indeed calls sys_getrandom() so maybe there is an
incidence in calling it that early.

> [    4.766320]  ? rcu_read_lock_sched_held+0x42/0x80
> [    4.766459]  ? syscall_enter_from_user_mode+0x21/0x50
> [    4.766600]  do_syscall_64+0x3f/0x90
> [    4.766709]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [    4.766900] RIP: 0033:0x404531
(...)

I'll restart the tests here so that we can compare and check what differs.

Willy
