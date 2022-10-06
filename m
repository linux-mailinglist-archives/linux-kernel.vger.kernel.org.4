Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7465F6D6F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiJFSUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiJFSUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:20:12 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A641E2CC81
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 11:20:11 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.219])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 566A41C0087
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:20:09 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2AEAA780089
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:20:09 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id ADE0613C2B0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 11:20:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com ADE0613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1665080408;
        bh=7diBoMweNGC6v/Sh3rcte0YwUYK7Vl289pXuOAyOF8U=;
        h=To:From:Subject:Date:From;
        b=GpwYCkqNtjDtbTR/ndjNfstMaRhhkfr7ngxaKIVybqlvFbUO8peTxLzXICfTlZzgQ
         Ds7hZEyuzfqb5bu+Chal/L1Whzkrk9fQduntiHZLC9PMBsxEW4kbrMJY/mAI6DcI2q
         YLAZ0X9GgUjhyQ8M7Qbm5GJ/D/ibBfsZ6rtnA2tE=
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Invalid wait context in serial console path, 5.19.11+
Organization: Candela Technologies
Message-ID: <12d2c1b4-3175-0201-7531-2d80b06d9f95@candelatech.com>
Date:   Thu, 6 Oct 2022 11:20:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1665080409-RzTtEneyKarZ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found this in the logs of a KASAN+LOCKDEP kernel system...
Not sure it caused any real problems...

Oct 06 19:33:13 ct523c-0b4f kernel:
Oct 06 19:33:13 ct523c-0b4f kernel: =============================
Oct 06 19:33:13 ct523c-0b4f kernel: [ BUG: Invalid wait context ]
Oct 06 19:33:13 ct523c-0b4f kernel: 5.19.11+ #8 Not tainted
Oct 06 19:33:13 ct523c-0b4f kernel: -----------------------------
Oct 06 19:33:13 ct523c-0b4f kernel: swapper/0/1 is trying to lock:
Oct 06 19:33:13 ct523c-0b4f kernel: ffffffff85232c18 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x630/0x680
Oct 06 19:33:13 ct523c-0b4f kernel: other info that might help us debug this:
Oct 06 19:33:13 ct523c-0b4f kernel: context-{5:5}
Oct 06 19:33:13 ct523c-0b4f kernel: 3 locks held by swapper/0/1:
Oct 06 19:33:13 ct523c-0b4f kernel:  #0: ffffffff836393a0 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic+0x22/0x2f0
Oct 06 19:33:13 ct523c-0b4f kernel:  #1: ffffffff8362c740 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0xd2/0x310
Oct 06 19:33:13 ct523c-0b4f kernel:  #2: ffffffff8354c340 (console_owner){....}-{0:0}, at: console_emit_next_record.constprop.31+0x1d9/0x500
Oct 06 19:33:13 ct523c-0b4f kernel: stack backtrace:
Oct 06 19:33:13 ct523c-0b4f kernel: CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.11+ #8
Oct 06 19:33:13 ct523c-0b4f kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/19/2019
Oct 06 19:33:13 ct523c-0b4f kernel: Call Trace:
Oct 06 19:33:13 ct523c-0b4f kernel:  <TASK>
Oct 06 19:33:13 ct523c-0b4f kernel:  dump_stack_lvl+0x55/0x6d
Oct 06 19:33:13 ct523c-0b4f kernel:  __lock_acquire.cold.69+0xc7/0x31b
Oct 06 19:33:13 ct523c-0b4f kernel:  ? stack_trace_save+0x85/0xb0
Oct 06 19:33:13 ct523c-0b4f kernel:  ? filter_irq_stacks+0x70/0x70
Oct 06 19:33:13 ct523c-0b4f kernel:  ? lockdep_hardirqs_on_prepare+0x200/0x200
Oct 06 19:33:13 ct523c-0b4f kernel:  ? rcu_read_lock_sched_held+0x9c/0xd0
Oct 06 19:33:13 ct523c-0b4f kernel:  lock_acquire+0x155/0x3e0
Oct 06 19:33:13 ct523c-0b4f kernel:  ? serial8250_console_write+0x630/0x680
Oct 06 19:33:13 ct523c-0b4f kernel:  ? lock_release+0x400/0x400
Oct 06 19:33:13 ct523c-0b4f kernel:  _raw_spin_lock_irqsave+0x3c/0x60
Oct 06 19:33:13 ct523c-0b4f kernel:  ? serial8250_console_write+0x630/0x680
Oct 06 19:33:13 ct523c-0b4f kernel:  serial8250_console_write+0x630/0x680
Oct 06 19:33:13 ct523c-0b4f kernel:  ? serial8250_config_port+0x15f0/0x15f0
Oct 06 19:33:13 ct523c-0b4f kernel:  ? lock_release+0x400/0x400
Oct 06 19:33:13 ct523c-0b4f kernel:  ? do_raw_spin_lock+0x114/0x1d0
Oct 06 19:33:13 ct523c-0b4f kernel:  ? rwlock_bug.part.2+0x50/0x50
Oct 06 19:33:13 ct523c-0b4f kernel:  ? prb_read_valid+0x61/0x90
Oct 06 19:33:13 ct523c-0b4f kernel:  ? prb_final_commit+0x50/0x50
Oct 06 19:33:13 ct523c-0b4f kernel:  console_emit_next_record.constprop.31+0x281/0x500
Oct 06 19:33:13 ct523c-0b4f kernel:  ? info_print_ext_header.constprop.32+0x130/0x130
Oct 06 19:33:13 ct523c-0b4f kernel:  ? rcu_read_lock_sched_held+0x9c/0xd0
Oct 06 19:33:13 ct523c-0b4f kernel:  console_unlock+0x1dc/0x2d0
Oct 06 19:33:13 ct523c-0b4f kernel:  ? devkmsg_read+0x3d0/0x3d0
Oct 06 19:33:13 ct523c-0b4f kernel:  ? vprintk_emit+0xd2/0x310
Oct 06 19:33:13 ct523c-0b4f kernel:  vprintk_emit+0xdb/0x310
Oct 06 19:33:13 ct523c-0b4f kernel:  _printk+0x9a/0xc0
Oct 06 19:33:13 ct523c-0b4f kernel:  ? record_print_text.cold.35+0x11/0x11
Oct 06 19:33:13 ct523c-0b4f kernel:  ? proc_register+0x1a0/0x230
Oct 06 19:33:13 ct523c-0b4f kernel:  ? do_raw_spin_lock+0x114/0x1d0
Oct 06 19:33:13 ct523c-0b4f kernel:  cblist_init_generic.cold.26+0x24/0x32
Oct 06 19:33:13 ct523c-0b4f kernel:  ? proc_create+0x10/0x10
Oct 06 19:33:13 ct523c-0b4f kernel:  rcu_init_tasks_generic+0x1c/0x113
Oct 06 19:33:13 ct523c-0b4f kernel:  kernel_init_freeable+0x25e/0x460
Oct 06 19:33:13 ct523c-0b4f kernel:  ? lockdep_hardirqs_on_prepare+0x132/0x200
Oct 06 19:33:13 ct523c-0b4f kernel:  ? console_on_rootfs+0x4d/0x4d
Oct 06 19:33:13 ct523c-0b4f kernel:  ? mark_held_locks+0x29/0xa0
Oct 06 19:33:13 ct523c-0b4f kernel:  ? rest_init+0x1c0/0x1c0
Oct 06 19:33:13 ct523c-0b4f kernel:  kernel_init+0x13/0x130
Oct 06 19:33:13 ct523c-0b4f kernel:  ? rest_init+0x1c0/0x1c0
Oct 06 19:33:13 ct523c-0b4f kernel:  ret_from_fork+0x1f/0x30
Oct 06 19:33:13 ct523c-0b4f kernel:  </TASK>

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

