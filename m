Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A5A5E542D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiIUUHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiIUUHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:07:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD4A3D3F;
        Wed, 21 Sep 2022 13:07:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c7so6997766pgt.11;
        Wed, 21 Sep 2022 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Ctps0lpQ5geTsiZr2YOGXQFwIJx53Pob+pNyFOH1goo=;
        b=Yb2Z32KnyVwGUszky68zCftt+B6DjYtIrNDLvFf9QJKS2oiF+J+QwtiubRrL9pTet8
         DrVfPPCcy1GOqDlqWqB1aikyCjyaAxMzzleybNKWwqpotUQ3R4ZqIL2/G++4SKTyWnnT
         puPQCEKwqnusnJJBu6b2zfkITYgTViubRHENqhrpun2eekCpLPk9tyDRwIuAfOaFE12e
         zZCWhRkBSQeG427QdkPuCb9qpebl4qxsAVffaLcWDqMN8LXOmLkO2cBNyb+DISw9e9kg
         XO5GPkPTnXfUqvmX7MBhq4rsGQIRsy8JP9dyelGlAKYCCY1ID9J3BMfgnDNlq+wevTBF
         wUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ctps0lpQ5geTsiZr2YOGXQFwIJx53Pob+pNyFOH1goo=;
        b=DJ90k1dFnqHiZt4z/Yt54z26C0an1EaP3qc50sH2nzCbLmUOpfjnBIEcOZJCC2O5oD
         XeuEAEQ/C+sSLbU35pFJRYep5WJ+q+QbyKvdw6kzCb3L3D715Y40LRidFua5Qmmvr8Fb
         kQ+Td2vX/SxSHYiMu/DUeNopA4HQpVFg84O/A2ca36ZqdPBof+PD3+OoTet4AHg0BG7c
         GVPbON7NZhOnBFuu7xV7lji4VwMhTZ6U1SWWGLKKs257TSO54CRQHqz2pMrjkmVnZyLB
         TLcV4kp78QZmadR0cbjA+ANJwDjwF7XE1yv10isrIC9+4QkOfbKDt4DA9Oxjy+CTZUYK
         I/Bw==
X-Gm-Message-State: ACrzQf2ZSN3bjzwP0Ck08vl5UsiIB5bPLMUKxCjaNZiP2dr8DUPm9xDS
        Hc6cn0guV7RfgyAmJetHsVg=
X-Google-Smtp-Source: AMsMyM7upAAL9C5s9LGJbK+tng4ZD9t6/Fd7Hf1wKG1y+ET236ICHxDHhD9ZiLL08jrbozShHFtG4A==
X-Received: by 2002:a05:6a00:a05:b0:534:b1ad:cfac with SMTP id p5-20020a056a000a0500b00534b1adcfacmr29978996pfh.35.1663790849638;
        Wed, 21 Sep 2022 13:07:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090a13c800b002008d0e5cb5sm2243735pjf.47.2022.09.21.13.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 13:07:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Sep 2022 13:07:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        keescook@chromium.org, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2] x86/mm: Refuse W^X violations
Message-ID: <20220921200726.GA3094503@roeck-us.net>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 29, 2022 at 12:18:03PM +0200, Peter Zijlstra wrote:
> 
> x86 has STRICT_*_RWX, but not even a warning when someone violates it.
> 
> Add this warning and fully refuse the transition.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I see the following crash when trying to boot qemu using images with
PAE enabled. I checked again after applying "x86/mm/32: Fix W^X detection
when page tables do not support NX", but that did not fix the problem.

Guenter

---
[    2.042861] CPA refuse W^X violation: 8000000000000063 -> 0000000000000063 range: 0x00000000c00a0000 - 0x00000000c00a0fff PFN a0
ILLOPC: cbc65efa: 0f 0b
[    2.043267] WARNING: CPU: 0 PID: 1 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr_set_clr+0xdca/0xdd0
[    2.043743] Modules linked in:
[    2.043978] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc6-next-20220921 #1
[    2.044277] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    2.044572] EIP: __change_page_attr_set_clr+0xdca/0xdd0
[    2.044751] Code: 10 8b 45 ac 89 7c 24 04 89 74 24 14 89 4c 24 1c 8d 8e ff 0f 00 00 89 4c 24 18 89 44 24 08 c7 04 24 44 67 08 cd e8 56 38 fb 00 <0f> 0b eb 83 66 90 55 89 e5 57 56 89 d6 53 89 c3 83 ec 58 31 d2 8b
[    2.045179] EAX: 00000074 EBX: 000a0063 ECX: 00000000 EDX: 00000002
[    2.045315] ESI: c00a0000 EDI: 00000063 EBP: c115fe4c ESP: c115fd34
[    2.045445] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000282
[    2.045585] CR0: 80050033 CR2: ffbff000 CR3: 0d57c000 CR4: 000006f0
[    2.046170] Call Trace:
[    2.046631]  ? __purge_vmap_area_lazy+0x6c/0x640
[    2.046768]  ? _vm_unmap_aliases.part.0+0x1d8/0x1f0
[    2.046923]  ? __mutex_unlock_slowpath+0x2b/0x2b0
[    2.047035]  ? purge_fragmented_blocks_allcpus+0x64/0x2c0
[    2.047199]  ? _vm_unmap_aliases.part.0+0x1d8/0x1f0
[    2.047315]  ? _vm_unmap_aliases.part.0+0x54/0x1f0
[    2.047496]  change_page_attr_set_clr+0x11d/0x2d0
[    2.047738]  set_memory_x+0x56/0x60
[    2.047863]  pci_pcbios_init+0xc8/0x28c
[    2.047981]  ? pcibios_resource_survey+0x63/0x63
[    2.048152]  pci_arch_init+0x3c/0x73
[    2.048242]  ? pcibios_resource_survey+0x63/0x63
[    2.048340]  do_one_initcall+0x4f/0x2e0
[    2.048442]  ? __this_cpu_preempt_check+0xf/0x11
[    2.048578]  ? rcu_read_lock_sched_held+0x41/0x70
[    2.048684]  ? trace_initcall_level+0x65/0xa6
[    2.048805]  kernel_init_freeable+0x210/0x264
[    2.048908]  ? rest_init+0x140/0x140
[    2.049002]  kernel_init+0x15/0x110
[    2.049211]  ? schedule_tail_wrapper+0x9/0xc
[    2.049312]  ret_from_fork+0x1c/0x28
[    2.049547] irq event stamp: 7715
[    2.049633] hardirqs last  enabled at (7723): [<cbce7119>] __up_console_sem+0x69/0x80
[    2.049822] hardirqs last disabled at (7730): [<cbce70fd>] __up_console_sem+0x4d/0x80
[    2.049972] softirqs last  enabled at (7176): [<cbc29ac7>] call_on_stack+0x47/0x60
[    2.050153] softirqs last disabled at (7167): [<cbc29ac7>] call_on_stack+0x47/0x60
[    2.050307] ---[ end trace 0000000000000000 ]---
[    2.050762] PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
[    2.051115] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[    2.051115] BUG: unable to handle page fault for address: c00fd2bf
[    2.051115] #PF: supervisor instruction fetch in kernel mode
[    2.051115] #PF: error_code(0x0011) - permissions violation
[    2.051115] *pdpt = 000000000d578001 *pde = 000000000dc18063 *pte = 80000000000fd063
[    2.051115] Oops: 0011 [#1] PREEMPT SMP PTI
[    2.051115] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.0.0-rc6-next-20220921 #1
[    2.051115] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    2.051115] EIP: 0xc00fd2bf
[    2.051115] Code: 06 1e 8c d0 8e d8 66 89 e3 66 0f b7 e4 66 89 e0 66 e8 43 e8 ff ff 66 89 dc 1f 07 66 5f 66 5e 66 5d 66 5b 66 5a 66 59 66 58 cf <9c> 3d 24 50 43 49 75 13 bb 00 00 0f 00 b9 00 00 01 00 ba 1d d2 00
[    2.051115] EAX: 49435024 EBX: 00000000 ECX: 00000000 EDX: cd1a027f
[    2.051115] ESI: 00000200 EDI: cd50e7f4 EBP: c115ff08 ESP: c115fee0
[    2.051115] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000046
[    2.051115] CR0: 80050033 CR2: c00fd2bf CR3: 0d57c000 CR4: 000006f0
[    2.051115] Call Trace:
[    2.051115]  ? pci_pcbios_init+0xfa/0x28c
[    2.051115]  ? pcibios_resource_survey+0x63/0x63
[    2.051115]  pci_arch_init+0x3c/0x73
[    2.051115]  ? pcibios_resource_survey+0x63/0x63
[    2.051115]  do_one_initcall+0x4f/0x2e0
[    2.051115]  ? __this_cpu_preempt_check+0xf/0x11
[    2.051115]  ? rcu_read_lock_sched_held+0x41/0x70
[    2.051115]  ? trace_initcall_level+0x65/0xa6
[    2.051115]  kernel_init_freeable+0x210/0x264
[    2.051115]  ? rest_init+0x140/0x140
[    2.051115]  kernel_init+0x15/0x110
[    2.051115]  ? schedule_tail_wrapper+0x9/0xc
[    2.051115]  ret_from_fork+0x1c/0x28
[    2.051115] Modules linked in:
[    2.051115] CR2: 00000000c00fd2bf
[    2.051115] ---[ end trace 0000000000000000 ]---
[    2.051115] EIP: 0xc00fd2bf
[    2.051115] Code: 06 1e 8c d0 8e d8 66 89 e3 66 0f b7 e4 66 89 e0 66 e8 43 e8 ff ff 66 89 dc 1f 07 66 5f 66 5e 66 5d 66 5b 66 5a 66 59 66 58 cf <9c> 3d 24 50 43 49 75 13 bb 00 00 0f 00 b9 00 00 01 00 ba 1d d2 00
[    2.051115] EAX: 49435024 EBX: 00000000 ECX: 00000000 EDX: cd1a027f
[    2.051115] ESI: 00000200 EDI: cd50e7f4 EBP: c115ff08 ESP: c115fee0
[    2.051115] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000046
[    2.051115] CR0: 80050033 CR2: c00fd2bf CR3: 0d57c000 CR4: 000006f0
[    2.051426] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

---
# bad: [ef08d387bbbc20df740ced8caee0ffac835869ac] Add linux-next specific files for 20220920
# good: [521a547ced6477c54b4b0cc206000406c221b4d6] Linux 6.0-rc6
git bisect start 'HEAD' 'v6.0-rc6'
# good: [df970c033333b10c728198606fe787535e08ab8a] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
git bisect good df970c033333b10c728198606fe787535e08ab8a
# bad: [c46ae7d9b6ad0283ffd7b40117b52444d68e083e] Merge branch 'usb-next' of git://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git
git bisect bad c46ae7d9b6ad0283ffd7b40117b52444d68e083e
# good: [6a21588fd7f579342d71f2c543d7dca6fd44ff8a] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
git bisect good 6a21588fd7f579342d71f2c543d7dca6fd44ff8a
# bad: [9b5a7d7a43dc87c6326a23394f37d0786dc9e712] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 9b5a7d7a43dc87c6326a23394f37d0786dc9e712
# good: [00a0886a99d2aba28e8c9f1c124d9cbbaadab693] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
git bisect good 00a0886a99d2aba28e8c9f1c124d9cbbaadab693
# good: [57b16b0bfae3a029815b845e8e623fb02d255d68] Merge branch into tip/master: 'x86/cache'
git bisect good 57b16b0bfae3a029815b845e8e623fb02d255d68
# good: [2632186d3de796a47b2dc00ac9dc9bbe6e70796b] Merge remote-tracking branch 'spi/for-6.1' into spi-next
git bisect good 2632186d3de796a47b2dc00ac9dc9bbe6e70796b
# good: [65c4764941bb230ef00164771fba0cdad0bfd3e4] dt-bindings: phy: hisilicon,hi3670-usb3: simplify example
git bisect good 65c4764941bb230ef00164771fba0cdad0bfd3e4
# bad: [32aefecc271aa1ca4431e0f9094e5a578922527b] Merge branch into tip/master: 'x86/mm'
git bisect bad 32aefecc271aa1ca4431e0f9094e5a578922527b
# good: [16ac81825892970fbe5f32fb379466d19d3d3134] Merge branch into tip/master: 'x86/cpu'
git bisect good 16ac81825892970fbe5f32fb379466d19d3d3134
# good: [77614503f9f135323315a53d60dc001f1a429f7c] Merge branch into tip/master: 'x86/misc'
git bisect good 77614503f9f135323315a53d60dc001f1a429f7c
# bad: [1043897681808118c0f7e70b210774000fe06621] Merge branch 'linus' into x86/mm, to refresh the branch
git bisect bad 1043897681808118c0f7e70b210774000fe06621
# bad: [652c5bf380ad018e15006a7f8349800245ddbbad] x86/mm: Refuse W^X violations
git bisect bad 652c5bf380ad018e15006a7f8349800245ddbbad
# good: [86af8230ce138e0423f43f6b104f3fa050aced6d] x86/mm: Rename set_memory_present() to set_memory_p()
git bisect good 86af8230ce138e0423f43f6b104f3fa050aced6d
# first bad commit: [652c5bf380ad018e15006a7f8349800245ddbbad] x86/mm: Refuse W^X violations

