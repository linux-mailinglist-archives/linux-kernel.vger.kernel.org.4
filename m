Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ABF6DC190
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 23:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDIV6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 17:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIV56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 17:57:58 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22B72710;
        Sun,  9 Apr 2023 14:57:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 95CF7604F5;
        Sun,  9 Apr 2023 23:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1681077474; bh=5dhivWFa6tb8MqlBeRaHufXo6BvsjI1To75qe68ffeo=;
        h=Date:To:From:Subject:Cc:From;
        b=DskjUfbSaIcLenzO/cK/mmz1yp7Z7Gr4B2NEqJKY13qjouGRziqoqF7zs8Q3dD59T
         FLVG+egu5Smz12EaeeXaoL5iXhRPmwxLkMHuii2sFvL+joKVBJVmPmnDvI1VP0zCHn
         F496jqcQ2FLXM5yMfUxTMDhVDJ1AkKMfIj+k2vXajVPHoLF+V5iuR7XYh7vdyBRxlY
         yorkM9s+IY5KWefHmFQ42eQLM+JU6//O6/8Z9m5xomJlfBoM09tgw8E5UgYPBuN13u
         1lBd+U94tDfaVF5r24AUOlnRsh5qQhn/XZdqJSuyHN9pxcLBIrW93qLC/ecS3KbDhE
         QJ8/Y4Q2+3p8g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m2QLGqw_sBQs; Sun,  9 Apr 2023 23:57:52 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.188.177])
        by domac.alu.hr (Postfix) with ESMTPSA id D8961604ED;
        Sun,  9 Apr 2023 23:57:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1681077472; bh=5dhivWFa6tb8MqlBeRaHufXo6BvsjI1To75qe68ffeo=;
        h=Date:To:From:Subject:Cc:From;
        b=xzOZatCVefYEyzBY2QrGFe7Fuzm9b85uwgxmQdeGX+7WTZMA/apciRWSywWmRdfzT
         s0rkcUgI1UOFIXLv+OIw/r/t6MJA8vy6rxOceq/YTvpJFOL5QAGwi1jO7TkYp9Z03j
         KFUbnor88B/NrHhYvhwSzvWJqtBGlhyjqb2G8NvFiaYSt2YbkqTW7C18MAgYzxacDE
         igX5J8siiskCsBN5ipBi5jTrWyDpqwkdQW5Dw9KTamQDDDYxzeIssufmsTFsqHMiq0
         zpYm6ww34XNjYdxApBX7dweDlGEPupLJsMEzsIKUFjt7K3HDAbov4VT9hhA3zXT0QA
         ae1vmA8jk4XLw==
Message-ID: <08144085-5a78-6511-5fc4-d140bbc514aa@alu.unizg.hr>
Date:   Sun, 9 Apr 2023 23:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, hr
To:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: BUG: Kernel 6.3-rc6 hang in power_supply_show_property() during
 selftest/ftrace/ftracetest
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all!

Just crashed my box with the new 6.3-rc6 kernel ...

I hope I will be able to reproduce.

The hang with sound chirp happened during the

root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds# tools/testing/selftests/ftrace/ftracetest 
=== Ftrace unit tests ===
[1] Basic trace file check	[PASS]
[2] Basic test for tracers	[PASS]
[3] Basic trace clock test	[PASS]
[4] Basic event tracing check	[PASS]
[5] Change the ringbuffer size	[PASS]
[6] Snapshot and tracing setting	[PASS]
[7] trace_pipe and trace_marker	[PASS]
[8] Test ftrace direct functions against tracers

While running a TB session and Yutube video in Firefox with cca. 100 tabs open.

Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893636] BUG: MAX_LOCKDEP_ENTRIES too low!
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893647] turning off the locking correctness validator.
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893651] CPU: 1 PID: 873 Comm: upowerd Not tainted 6.3.0-rc6-mt-20230401-00001-gf86822a1170f #4
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893657] Hardware name: LENOVO 82H8/LNVNB161216, BIOS GGCN51WW 11/16/2022
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893661] Call Trace:
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893664]  <TASK>
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893667]  dump_stack_lvl+0x5f/0xa0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893676]  dump_stack+0x14/0x20
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893681]  alloc_list_entry+0x88/0xa0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893689]  __lock_acquire+0x13ec/0x1990
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893696]  lock_acquire+0xc7/0x2d0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893700]  ? cpu_stop_queue_work+0x6e/0x110
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893710]  _raw_spin_lock_irqsave+0x4d/0x70
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893715]  ? cpu_stop_queue_work+0x6e/0x110
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893721]  cpu_stop_queue_work+0x6e/0x110
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893728]  stop_one_cpu_nowait+0x3b/0x50
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893733]  load_balance+0xca5/0xf60
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893744]  newidle_balance+0x29d/0x670
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893751]  pick_next_task_fair+0x52/0x490
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893756]  __schedule+0x183/0x1530
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893765]  ? find_held_lock+0x35/0xb0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893774]  ? schedule_timeout+0x1d4/0x310
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893781]  ? schedule_timeout+0x1d9/0x310
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893785]  ? schedule_timeout+0x1d9/0x310
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893791]  ? schedule_timeout+0x1d9/0x310
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893796]  schedule+0x9c/0x1a0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893804]  schedule_timeout+0x1d9/0x310
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893810]  ? trace_preempt_on+0x31/0x90
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893821]  ? __pfx_process_timeout+0x10/0x10
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893832]  ? msleep+0x20/0x50
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893840]  msleep+0x43/0x50
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893848]  acpi_os_sleep+0x12/0x20
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893857]  acpi_ex_system_do_sleep+0x30/0x40
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893865]  acpi_ex_opcode_1A_0T_0R+0xd0/0x140
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893872]  acpi_ds_exec_end_op+0x265/0x920
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893883]  acpi_ps_parse_loop+0x26a/0xa10
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893890]  acpi_ps_parse_aml+0x22f/0x5e0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893896]  acpi_ps_execute_method+0x156/0x380
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893902]  acpi_ns_evaluate+0x182/0x5f0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893908]  acpi_evaluate_object+0x173/0x450
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893918]  acpi_battery_get_state+0x96/0x250
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893931]  acpi_battery_get_property+0x57/0x3f0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893938]  power_supply_get_property+0x20/0x50
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893945]  power_supply_show_property+0xdc/0x290
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893950]  ? lock_is_held_type+0xa8/0x120
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893957]  dev_attr_show+0x1e/0x60
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893963]  sysfs_kf_seq_show+0xb0/0x140
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893969]  kernfs_seq_show+0x43/0x60
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893976]  seq_read_iter+0x1a4/0x460
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893983]  kernfs_fop_read_iter+0x16a/0x1d0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893989]  ? security_file_permission+0xaf/0x1c0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.893997]  vfs_read+0x22b/0x310
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894005]  ksys_read+0x68/0xe0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894010]  __x64_sys_read+0x1e/0x30
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894014]  do_syscall_64+0x5c/0x90
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894019]  ? irq_exit_rcu+0x2b/0xc0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894025]  ? irq_exit_rcu+0x2b/0xc0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894035]  ? irqentry_exit_to_user_mode+0x29/0x30
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894044]  ? irqentry_exit+0x6f/0xa0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894052]  ? sysvec_call_function+0x4f/0xa0
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894060]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894069] RIP: 0033:0x7f569950cd2c
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894077] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 d9 f4 f7 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 2f f5 f7 ff 48
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894084] RSP: 002b:00007ffe2aff12f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894093] RAX: ffffffffffffffda RBX: 0000558d91683600 RCX: 00007f569950cd2c
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894099] RDX: 0000000000001000 RSI: 0000558d916697a0 RDI: 000000000000000b
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894104] RBP: 00007ffe2aff1420 R08: 0000000000000000 R09: 00007f56995f6d20
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894109] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894113] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000000b
Apr  9 22:48:37 marvin-IdeaPad-3-15ITL6 kernel: [ 3481.894125]  </TASK>

Hope this helps.

I tried to address the maintainers according to the call trace, but frankly
I am not completely sworn it is the best list possible.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"
