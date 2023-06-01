Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F2F71F2A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjFATJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFATJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:09:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BA3184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:08:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ED6A648DB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 19:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA17C433D2;
        Thu,  1 Jun 2023 19:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685646537;
        bh=nXTFrPXF1ChSi7Q/RomOwojoV8TWIeh5JlHOhyUhLqY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=rH2z5zPAJVPJc6Ka7MVDMN6XrTQZvF3UO/d4RWcksb0q1OGdEdcEqdfNwfnhOOmxB
         KT3HvRGotOKVVi8lkyJYfbH9ZZv4af7DeJ97elGGiq+0146nGNP4jbHF6V26hFvGdU
         mKOit+UwES7p/kAt2iEw6Olu1+rocFF6qGN0H8Fv9Mn0YZ23A96R0RWegahe7kWZ3j
         RU4Q93Dd6qMEtoCe2iFgO//enWJgsV7ySY0Q5JKigkLN3QMg2xpogwpxHBMVOscnpW
         Q6XCByBKCXwxj6bjg14Lt/BPYxyVaHdsi7knHy7fkUUJCdMHRK1ZH3ZNkf1EkcMSh1
         OwloaU+9Te0UQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5DC0CCE04B0; Thu,  1 Jun 2023 12:08:57 -0700 (PDT)
Date:   Thu, 1 Jun 2023 12:08:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tj@kernel.org, jiangshanlai@gmail.com, qiang.zhang1211@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [BUG] wait_task_inactive() WARN_ON() in __kthread_bind_mask()
Message-ID: <0329dbe3-c7a0-4dad-a244-14061168d7b7@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I just now saw this in SRCU-P rcutorture testing.  It might well be a
one-off, but I thought I should pass it along in case someone else is
seeing similar things.

I don't immediately see how this would be related, but who knows?

https://lore.kernel.org/lkml/20230524035339.25185-1-qiang.zhang1211@gmail.com/

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

[ 1726.040567] ------------[ cut here ]------------
[ 1726.040569] WARNING: CPU: 3 PID: 2016 at kernel/kthread.c:515 __kthread_bind_mask+0x18/0x60
[ 1726.040581] Modules linked in:
[ 1726.040584] CPU: 3 PID: 2016 Comm: kworker/7:3 Not tainted 6.4.0-rc1-00072-g99f9f93c0bce #5209
[ 1726.040588] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[ 1726.040594] RIP: 0010:__kthread_bind_mask+0x18/0x60
[ 1726.040598] Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 55 41 54 55 48 89 f5 89 d6 53 48 89 fb e8 8d 5a 01 00 48 85 c0 75 0d <0f> 0b 5b 5d 41 5c 41 5d c3 cc cc cc cc 4c 8d a3 00 09 00 00 4c 89
[ 1726.040601] RSP: 0000:ffff97c7c1ecfe78 EFLAGS: 00010246
[ 1726.040604] RAX: 0000000000000000 RBX: ffff90ce82918000 RCX: 0000000000000000
[ 1726.040606] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff90ce82918000
[ 1726.040607] RBP: ffff90ce81047248 R08: 0000000000000001 R09: ffffffff9cab5d97
[ 1726.040609] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
[ 1726.040610] R13: ffff90ce9f5ee460 R14: ffff97c7c1ecfea0 R15: ffff90ce812ef840
[ 1726.040614] FS:  0000000000000000(0000) GS:ffff90ce9f4c0000(0000) knlGS:0000000000000000
[ 1726.040616] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1726.040618] CR2: 0000000000000000 CR3: 0000000014648000 CR4: 00000000000006e0
[ 1726.040619] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1726.040621] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1726.040622] Call Trace:
[ 1726.040624]  <TASK>
[ 1726.040630]  create_worker+0xf1/0x220
[ 1726.040637]  worker_thread+0x2e4/0x3b0
[ 1726.040641]  ? __pfx_worker_thread+0x10/0x10
[ 1726.040643]  kthread+0xe6/0x120
[ 1726.040648]  ? __pfx_kthread+0x10/0x10
[ 1726.040651]  ret_from_fork+0x2c/0x50
[ 1726.040658]  </TASK>
[ 1726.040659] irq event stamp: 34
[ 1726.040661] hardirqs last  enabled at (33): [<ffffffff9da014ea>] asm_sysvec_call_function_single+0x1a/0x20
[ 1726.040668] hardirqs last disabled at (34): [<ffffffff9d95cead>] __schedule+0x67d/0xd20
[ 1726.040675] softirqs last  enabled at (0): [<ffffffff9ca82da8>] copy_process+0xb98/0x1f10
[ 1726.040681] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1726.040685] ---[ end trace 0000000000000000 ]---
