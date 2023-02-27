Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D366A4623
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjB0Pdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjB0PdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:33:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB127D508;
        Mon, 27 Feb 2023 07:33:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 543BE60EB6;
        Mon, 27 Feb 2023 15:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A27C433EF;
        Mon, 27 Feb 2023 15:32:59 +0000 (UTC)
Date:   Mon, 27 Feb 2023 10:32:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        contact@pgazz.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 rcu_core
Message-ID: <20230227103257.4b99b6fb@gandalf.local.home>
In-Reply-To: <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
        <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
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

On Mon, 27 Feb 2023 08:15:26 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> >> asm_sysvec_apic_timer_interrupt+0x1a/0x20
> >> RIP: 0010:default_idle+0xf/0x20
> >> Code: 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 ff ff ff cc cc cc cc f3 0f 1e fa eb 07 0f 00 2d e3 8a 34 00 fb f4 <fa> c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 65
> >> RSP: 0018:ffffc9000017fe00 EFLAGS: 00000202
> >> RAX: 0000000000dfbea1 RBX: dffffc0000000000 RCX: ffffffff89b1da9c
> >> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> >> RBP: 0000000000000007 R08: 0000000000000001 R09: ffff888119fb6c23
> >> R10: ffffed10233f6d84 R11: dffffc0000000000 R12: 0000000000000003
> >> R13: ffff888100833900 R14: ffffffff8e112850 R15: 0000000000000000
> >> default_idle_call+0x67/0xa0
> >> do_idle+0x361/0x440
> >> cpu_startup_entry+0x18/0x20
> >> start_secondary+0x256/0x300
> >> secondary_startup_64_no_verify+0xce/0xdb
> >> </TASK>
> >> Modules linked in:
> >> CR2: 0000000000000000
> >> ---[ end trace 0000000000000000 ]---
> >> RIP: 0010:0x0
> >> Code: Unable to access opcode bytes at 0xffffffffffffffd6.  
> 
> I have seen this exact signature when the processor tries to execute a function that has a NULL address. That causes IP to goto 0 and the exception. Sounds like something corrupted rcu_head (Just a guess).

[ Joel, you need to line wrap your emails ;-) ]

This looks like a call_rcu() was called on something that later got freed
or reused. That is, the bug is not with RCU but with something using RCU.

OR it could be a bug with RCU if the synchronize_rcu() ended before the
grace periods have finished.

-- Steve


