Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185A46105B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbiJ0WYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiJ0WYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:24:08 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5E3B14CB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:24:07 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id r187so4183240oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVV552RlmafxU8ICe/Ndbq9JrxwN9+hj45aKH1BDx4U=;
        b=Ix42sbrwNCkJ0gvPEf9RG2VDXhBBhnYJW59koGaRy+ZcOsCgNsipW3wJOkHafEpg/2
         S9ZQtM1otwOeorcv6mQ2qkQ0BG5nopeWQG/LBGV4ZiB0LfsQcQx4BwDIGFWsRveC/WSA
         2CGPFeCe9ITCTuL1DpjvB6nG1RxJX7k66VhVoY3t/US4rpnPOclWCaEa8zPSJYiRgWg2
         JqeftfddDEaY0HVt68c8guRfEl2w5VM7ls2ZUkRs/0uIxC2xz0csKVqicn1Yzncc1UM+
         Qhlxd2Xsjw+48DMGxYriZlk2OpeubQUFGTw65Zu4LRFrzE2ecRo9MzAycBlnEIN+f9Vq
         NPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVV552RlmafxU8ICe/Ndbq9JrxwN9+hj45aKH1BDx4U=;
        b=dzwdngaXa9rrsuilM4PXmKpNx17R6SEsMrcqZ7vrVF6U1EhCHuvPZCeQIAsiRibSNb
         C0IxoCTEjv12IVDbHklU2xU4r9+/9lS3WBBnpZKSklDWVC+HdfCPdXVU0DBvZm0nDihy
         uwnUOxyitIBH5aZN+sUBE+KpU6EgU+PzR4VvluAnzuu4lmJkccU+HJP0t6CvUocZxQMp
         EHKJQOuUyx43sC+B4ZE0dA3h00zk1osUcJ6MxgWAATzaPSQzNJlH9tcOLirwTyoJEEUr
         xtld46LfQHLaR8stfa3lr2L/NlH00JLez6bb80cbofobI2EU8DXoTyEyfTe6OGHR5kNE
         81tA==
X-Gm-Message-State: ACrzQf3xlBx7HJ5BJQXfGK34hRHCQSctgvqnVyHSVsUwwfQiz/iLlNlL
        rGHtXKU9/+t07+7RTH3y8Q4=
X-Google-Smtp-Source: AMsMyM76ZNWqFZqax2BbLnjQAB93G2XEvSI9aUvj2Izdw3Lbxe8oKJD4pSurybY6gFX4fqO4mYoIPQ==
X-Received: by 2002:a05:6808:13c2:b0:357:6f03:d0a1 with SMTP id d2-20020a05680813c200b003576f03d0a1mr6191057oiw.32.1666909446305;
        Thu, 27 Oct 2022 15:24:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t17-20020a0568080b3100b003546fada8f6sm881713oij.12.2022.10.27.15.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:24:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 27 Oct 2022 15:24:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Message-ID: <20221027222404.GA3123386@roeck-us.net>
References: <20221027150525.753064657@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221027150525.753064657@goodmis.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:05:25AM -0400, Steven Rostedt wrote:
> 
> Back in April, I posted an RFC patch set to help mitigate a common issue
> where a timer gets armed just before it is freed, and when the timer
> goes off, it crashes in the timer code without any evidence of who the
> culprit was. I got side tracked and never finished up on that patch set.
> Since this type of crash is still our #1 crash we are seeing in the field,
> it has become a priority again to finish it.
> 
> This is v2 of that patch set. Thomas Gleixner posted an untested version
> that makes timer->function NULL as the flag that it is shutdown. I took that
> code, tested it (fixed it up), added more comments, and changed the
> name to del_timer_shutdown() as Linus had asked. I also converted it to use
> WARN_ON_ONCE() instead of just WARN_ON() as Linus asked for that too.
> 

Here are various warnings and crashes. Complete logs are at

https://kerneltests.org/builders

in the "testing" column of the qemu test results.

This is with the published patch set plus the fixups in 
timer_fixup_init() and timer_fixup_free().

Guenter

---
Block code:

WARNING: CPU: 0 PID: 8 at lib/debugobjects.c:502 debug_print_object+0x66/0x7a
ODEBUG: free active (active state 0) object type: timer_list hint: blk_rq_timed_out_timer+0x0/0xc

---
In tcp:

WARNING: CPU: 0 PID: 255 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
ODEBUG: free active (active state 0) object type: timer_list hint: tcp_keepalive_timer+0x0/0x3a8

WARNING: CPU: 0 PID: 255 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
ODEBUG: free active (active state 0) object type: timer_list hint: tcp_write_timer+0x0/0x1a8

---
Other networking:

WARNING: CPU: 0 PID: 8 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
ODEBUG: free active (active state 0) object type: timer_list hint: neigh_timer_handler+0x0/0x468

---

WARNING: CPU: 0 PID: 280 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
ODEBUG: init active (active state 0) object type: timer_list hint: tulip_timer+0x0/0x38

That one is often followed by:

[   29.833216] ODEBUG: init active (active state 0) object type: timer_list hint: 0x0
[   29.833723] WARNING: CPU: 0 PID: 365 at lib/debugobjects.c:502 debug_print_object+0xb8/0x100

in the same code line, suggesting that the timer may be shut down
more than once (?). Then there is another crash with

[   29.863890] Insufficient stack space to handle exception!
[   29.863939] ESR: 0x0000000096000047 -- DABT (current EL)
[   29.863952] FAR: 0xffff800008b17f80
[   29.863959] Task stack:     [0xffff800008b18000..0xffff800008b1c000]
[   29.863967] IRQ stack:      [0xffff800008000000..0xffff800008004000]
[   29.863975] Overflow stack: [0xffff30a35fe7a0f0..0xffff30a35fe7b0f0]
[   29.863987] CPU: 0 PID: 365 Comm: ip Tainted: G        W        N 6.1.0-rc2-00138-gced58c742836 #1
[   29.863999] Hardware name: linux,dummy-virt (DT)

followed by a sequence of

[   29.864572]  __try_to_del_timer_sync+0x40/0xdc
[   29.864582]  __del_timer_sync+0xa4/0x100
[   29.864590]  timer_fixup_init+0x2c/0x5c
[   29.864599]  __debug_object_init+0x248/0x53c
[   29.864606]  debug_object_init+0x24/0x30
[   29.864614]  timer_fixup_init+0x40/0x5c
[   29.864622]  __debug_object_init+0x248/0x53c
[   29.864630]  debug_object_init+0x24/0x30
[   29.864637]  timer_fixup_init+0x40/0x5c
[   29.864645]  __debug_object_init+0x248/0x53c
[   29.864658]  debug_object_init+0x24/0x30
[   29.864666]  timer_fixup_init+0x40/0x5c
...
[   29.866492]  debug_object_init+0x24/0x30
[   29.866500]  init_timer_key+0x7c/0x80
[   29.866508]  tulip_down+0x1d0/0x24c
[   29.866518]  tulip_close+0x3c/0xc0

This crash is seen with variants on several platforms/architectures.

---

WARNING: CPU: 0 PID: 8 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
ODEBUG: free active (active state 0) object type: timer_list hint: addrconf_dad_work+0x0/0x628

---
mips64:

WARNING: CPU: 0 PID: 280 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
ODEBUG: init active (active state 0) object type: timer_list hint: 0x0
Modules linked in:
CPU: 0 PID: 280 Comm: ip Tainted: G        W        N 6.1.0-rc2-00138-gced58c742836 #1
Stack : 0000000000000056 ffffffffffffffff 0000000000000008 00b65275abba8126
        00b65275abba8126 0000000000000000 9000000004193728 ffffffff80f29f38
        ffffffff8105c9d8 ffffffffffff8880 9000000004193668 0000000000000000
        0000000000000005 0000000000000010 ffffffff80c731a0 ffffffff81030000
        2020205720202020 ffffffff81030000 0000000000000000 ffffffff80f29f38
        0000000000000009 00000000000001f6 ffffffff8063d45c ffffffff81cb94c0
        ffffffff81d76240 0000000000000000 ffffffff807575a8 0000000000000000
        ffffffff81230000 9000000004190000 9000000004193720 9000000018002030
        ffffffff80c8f528 0000000000000000 0000000000000000 00b65275abba8126
        ffffffff8122e050 000000001000a4e1 ffffffff8010a884 00b65275abba8126
        ...
Call Trace:
[<ffffffff8010a884>] show_stack+0x3c/0x120
[<ffffffff80c8f528>] dump_stack_lvl+0x4c/0x90
[<ffffffff80130e54>] __warn+0xdc/0x1c8
[<ffffffff80c75a08>] warn_slowpath_fmt+0x98/0xc4
[<ffffffff8063d45c>] debug_print_object+0xa4/0xd8
[<ffffffff8063e590>] __debug_object_init+0x2d0/0x670
[<ffffffff801b44b8>] timer_fixup_init+0x40/0x58

irq event stamp: 1537
hardirqs last  enabled at (1549): [<ffffffff8018e67c>] __up_console_sem+0x9c/0xc8
hardirqs last disabled at (1560): [<ffffffff8018e658>] __up_console_sem+0x78/0xc8
softirqs last  enabled at (1324): [<ffffffff80a572bc>] dev_deactivate_many+0x32c/0x458
softirqs last disabled at (1322): [<ffffffff80a57288>] dev_deactivate_many+0x2f8/0x458
---[ end trace 0000000000000000 ]---

=====================================
WARNING: bad unlock balance detected!
6.1.0-rc2-00138-gced58c742836 #1 Tainted: G        W        N
-------------------------------------
�������␈␂/-1 is trying to release lock (&obj_hash[i].lock) at:
[<ffffffff801b41e0>] __try_to_del_timer_sync+0x48/0x140
but there are no more locks to release!

other info that might help us debug this:
qemu-system-mips64: terminating on signal 15 from pid 2525787 (/bin/bash)

---
Openrisc fails completely. Lots of the following, then boot stalls.

WARNING: CPU: 0 PID: 88 at lib/debugobjects.c:502 debug_print_object+0xc0/0xe8
ODEBUG: init active (active state 0) object type: timer_list hint: 0x0
Modules linked in:
CPU: 0 PID: 88 Comm: udhcpc Not tainted 6.1.0-rc2-00138-gced58c742836 #1
Call trace:
[<8eaa3f51>] dump_stack_lvl+0x44/0x80
[<4da6c5ef>] dump_stack+0x1c/0x2c
[<1b9f58b7>] __warn+0xdc/0x118
[<86d4d066>] ? debug_print_object+0xc0/0xe8
[<689beae8>] warn_slowpath_fmt+0x78/0x90
[<86d4d066>] debug_print_object+0xc0/0xe8
[<872f4074>] __debug_object_init+0x2bc/0x7f4
[<c30d6214>] ? _raw_spin_unlock_irqrestore+0x50/0x84
[<c3f3be91>] ? debug_check_no_locks_freed+0xb8/0x194
[<558675c1>] ? slob_alloc+0xe8/0x350
[<26225550>] ? lockdep_init_map_type+0x68/0x38c
[<c3f3be91>] ? debug_check_no_locks_freed+0xb8/0x194
[<2c9cf7b5>] ? inet_create+0x2e8/0x404
[<bab055df>] debug_object_init+0x30/0x40
[<6d2e468f>] init_timer_key+0xb4/0x110
[<60c0d3e7>] ? sk_init_common+0x1a0/0x1c0
[<b52686c2>] sock_init_data+0x60/0x2a4
[<1ff904c3>] ? sk_alloc+0xe8/0x138
[<ca3e6ef9>] inet_create+0x1e0/0x404
[<623d726a>] ? inet_create+0x80/0x404
[<a3256728>] ? lock_release+0x1c0/0x30c
[<960a454e>] __sock_create+0x140/0x288
[<0290cd64>] ? __sock_create+0x98/0x288
[<b62bc649>] __sys_socket+0x7c/0x128
[<fa003224>] ? do_work_pending+0x4c/0x118
[<705147e9>] sys_socket+0x14/0x24
[<9c4e015d>] ? _syscall_return+0x0/0x4
---[ end trace 0000000000000000 ]---

---
parisc crashes.

[    3.015186] ------------[ cut here ]------------
[    3.015580] ODEBUG: init active (active state 0) object type: timer_list hint: timeout_waiting_on_port+0x0/0x2c
[    3.016945] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print_object+0x98/0xc8
...
[    3.026117] ODEBUG: init active (active state 0) object type: timer_list hint: 0x0
[    3.026355] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_print_object+0x98/0xc8
...
[ many more of the same ]

[    3.054542] stackcheck: swapper/0 will most likely overflow irq stack (sp:11e51800, stk bottom-top:11460004-11468004)
[    3.054592] Kernel panic - not syncing: low stack detected by irq handler - check messages

and boom.

---
usb:

[   23.993737] WARNING: CPU: 0 PID: 343 at lib/debugobjects.c:502 debug_print_object+0xac/0xc8
[   23.993953] ODEBUG: free active (active state 0) object type: timer_list hint: hub_init_func2+0x0/0xc

---
ppc:

[    6.607478][    T1] ODEBUG: init active (active state 0) object type: timer_list hint: .ibmvscsi_timeout+0x0/0x58
[    6.608536][    T1] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 .debug_print_object+0xbc/0xf0

followed by several of

[    6.623661][    T1] ODEBUG: init active (active state 0) object type: timer_list hint: 0x0
[    6.624155][    T1] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 .debug_print_object+0xbc/0xf0

and finally:

[    6.694785][    C0] BUG: Kernel NULL pointer dereference on read at 0x000000b8
[    6.694796][    C0] Faulting instruction address: 0xc0000000001ece44
[    6.694807][    C0] Thread overran stack, or stack corrupted
[    6.694967][    C0] Oops: Kernel access of bad area, sig: 7 [#1]

