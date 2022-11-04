Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A557B61A546
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKDXAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKDXAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:00:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DA031F80
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667602835; x=1699138835;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I2llqX1EAraw9p96FSPhUSp4C9TbC/iV2wmXzHJHci8=;
  b=DsmSwAqXzqRZhXYbPZPbTDpxOgOoBPKY1aX8/Ytbv9+lffhkGheKdmjn
   3goVObtXqPW/kOTiH5kGDfN7rdfcxEjMaXWtaEv1DLlWJb907TDQ7ziPL
   wuIMGbBnfWwsJLRZc8bKz0/AdJe13QrtCJbDGWJN4pc7svXlLv6/Bo+SF
   v+nC8mIly0tNHX9hDhR7eCvgjsBGEPb6uH3q1GpTq1igRr0zPgHiSowgb
   i7ndG73xndo0ytyNvlMDe/hpyoQY95gryPUWkjMgQuKAP00wpG8nn7e3Z
   9qPp++aroDyOXCFM/CScwlnoq+GucPBwvmo/yV4zVj57ZhcGftXQKysNL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="297563072"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="297563072"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 16:00:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="635255991"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="635255991"
Received: from lcannon-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.251.9.195])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 16:00:34 -0700
Message-ID: <5372edc0b0a45de9286a2d4948e9858dcb9741fc.camel@linux.intel.com>
Subject: Re: INFO: rcu_preempt detected expedited stalls on CPUs/tasks
 (6.1.0-rc3): in cat /sys/kernel/debug/kmemleak
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Fri, 04 Nov 2022 16:00:34 -0700
In-Reply-To: <e048a5c5-dea5-a31a-1022-1b007e022adb@alu.unizg.hr>
References: <e048a5c5-dea5-a31a-1022-1b007e022adb@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2022-11-04 at 23:01 +0100, Mirsad Goran Todorovac wrote:
> Dear all,
> 
> When investigating thermald kmemleak, it occurred that the "cat 
> /sys/kernel/debug/kmemleak"
> and "tail -20 /sys/kernel/debug/kmemleak" commands take unusual
> amount 
> of time.
> 
This memleak occurred because of bad element in the BIOS configuration
of _OSC method.
Unfortunately fixing this in ACPI interpreter can have other side
effects as this is not expected. So the ACPICA team
(https://acpica.org/community) is looking further.

Thanks,
Srinivas

> Dmesg output showed expedited stalls that the commands caused NMIs
> and 
> NMI backtraces:
> 
> [ 8123.263464] rcu: INFO: rcu_preempt detected expedited stalls on 
> CPUs/tasks: { 0-.... } 26 jiffies s: 3829 root: 0x1/.
> [ 8123.263500] rcu: blocking rcu_node structures (internal RCU
> debug):
> [ 8123.263508] Sending NMI from CPU 7 to CPUs 0:
> [ 8123.263528] NMI backtrace for cpu 0
> [ 8123.263539] CPU: 0 PID: 27898 Comm: cat Not tainted 6.1.0-rc3 #1
> [ 8123.263552] Hardware name: LENOVO 82H8/LNVNB161216, BIOS GGCN34WW 
> 03/08/2022
> [ 8123.263557] RIP: 0010:kmemleak_seq_start+0x41/0x80
> [ 8123.263579] Code: 55 04 a6 00 4c 63 e0 85 c0 78 40 e8 b9 80 db ff
> 48 
> 8b 05 92 fb 88 01 4c 8d 60 f8 48 3d 30
>                                      62 63 92 75 17 eb 32 49 8b 44 24
> 08 
> <48> 83 eb 01 4c 8d 60 f8 48 3d 30 62 63 92 74 1d
>                                      48 85 db 7f e6 4c
> [ 8123.263588] RSP: 0018:ffff9968e400fc30 EFLAGS: 00000206
> [ 8123.263598] RAX: ffff8963b7005b58 RBX: 0000000000011cb8 RCX: 
> 0000000000000001
> [ 8123.263604] RDX: ffff8963b09c4000 RSI: ffff8963856de028 RDI: 
> ffffffff926361c0
> [ 8123.263608] RBP: ffff9968e400fc40 R08: 0000000000020000 R09: 
> ffff896380592a80
> [ 8123.263613] R10: 0000000000020000 R11: 0000000000000000 R12: 
> ffff8964114c2390
> [ 8123.263617] R13: ffff89639fa25b00 R14: ffff8963856de000 R15: 
> ffff9968e400fe30
> [ 8123.263622] FS:  00007ff217c15740(0000) GS:ffff896528800000(0000) 
> knlGS:0000000000000000
> [ 8123.263630] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8123.263636] CR2: 00007f19bd6a8000 CR3: 000000028e392001 CR4: 
> 0000000000770ef0
> [ 8123.263642] PKRU: 55555554
> [ 8123.263646] Call Trace:
> [ 8123.263649]  <TASK>
> [ 8123.263656]  seq_read_iter+0x169/0x420
> [ 8123.263671]  seq_read+0xad/0xe0
> [ 8123.263685]  full_proxy_read+0x59/0x90
> [ 8123.263701]  vfs_read+0xb2/0x2e0
> [ 8123.263718]  ksys_read+0x61/0xe0
> [ 8123.263730]  __x64_sys_read+0x1a/0x20
> [ 8123.263741]  do_syscall_64+0x58/0x80
> [ 8123.263754]  ? do_syscall_64+0x67/0x80
> [ 8123.263767]  ? exit_to_user_mode_prepare+0x15d/0x190
> [ 8123.263781]  ? syscall_exit_to_user_mode+0x1b/0x30
> [ 8123.263791]  ? do_syscall_64+0x67/0x80
> [ 8123.263804]  ? syscall_exit_to_user_mode+0x1b/0x30
> [ 8123.263813]  ? do_syscall_64+0x67/0x80
> [ 8123.263823]  ? do_syscall_64+0x67/0x80
> [ 8123.263833]  ? do_syscall_64+0x67/0x80
> [ 8123.263844]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [ 8123.263857] RIP: 0033:0x7ff217914992
> [ 8123.263867] Code: c0 e9 b2 fe ff ff 50 48 8d 3d fa b2 0c 00 e8 c5
> 1d 
> 02 00 0f 1f 44 00 00 f3 0f
>                                      1e fa 64 8b 04 25 18 00 00 00 85
> c0 
> 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56
>                                      c3 0f 1f 44 00 00 48 83 ec 28 48
> 89 
> 54 24
> [ 8123.263875] RSP: 002b:00007ffdfcbc3e28 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000000
> [ 8123.263894] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 
> 00007ff217914992
> [ 8123.263899] RDX: 0000000000020000 RSI: 00007ff217b9d000 RDI: 
> 0000000000000003
> [ 8123.263904] RBP: 00007ff217b9d000 R08: 00007ff217b9c010 R09: 
> 00007ff217b9c010
> [ 8123.263909] R10: 0000000000000022 R11: 0000000000000246 R12: 
> 0000000000022000
> [ 8123.263914] R13: 0000000000000003 R14: 0000000000020000 R15: 
> 0000000000020000
> [ 8123.263927]  </TASK>
> 
> To reproduce:
> 
> Enable CONFIG_DEBUG_KMEMLEAK=y in linux_stable 6.1.0-rc3 build.
> 
> Then, a stress test on a service known from the previous report is
> required:
> 
> for a in {1..1000}; doRIP: 0010:kmemleak_seq_start+0x41/0x80
>           echo $a
>           systemctl stop thermald
>           sleep 0.5
>           systemctl start thermald
>           sleep 0.5
> done
> 
> After that, /sys/kernel/debug/kmemleak indicated 1413 unreferenced
> objects.
> 
> However, dmesg had shown the stalls on CPUs while executing "cat" or 
> "tail -40" of /sys/kernel/debug/kmemleak.
> 
> I've read the 
> https://www.kernel.org/doc/Documentation/RCU/stallwarn.txt, but I was
> unable to understand
> what is going on except to locate the stall to "RIP: 
> 0010:kmemleak_seq_start+0x41/0x80" and probable
> maintainer/developer.
> 
> Please find attached the kernel build config, the output of "cat 
> /sys/kernel/debug/kmemleak" and
> dmesg ouput about the expedited stalls. The number of jiffies is not
> so 
> large, but IMHO they possibly indicate
> greater problems or deadlocks in RCU code in kmemleak.
> 
> NOTE:
> Please add:
> 
> Reported-By: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
> if (or when) the bug is fixed.
> 
> Thank you.
> 
> -mt
> 
> --
> Mirsad Goran Todorovac
> Sistem inženjer
> Grafički fakultet | Akademija likovnih umjetnosti
> Sveučilište u Zagrebu

