Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD55B631433
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 13:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiKTMun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 07:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKTMum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:50:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B92BD1;
        Sun, 20 Nov 2022 04:50:40 -0800 (PST)
Received: from zn.tnic (p200300ea9733e704329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e704:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 590F91EC058B;
        Sun, 20 Nov 2022 13:50:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668948639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Z294jfW899gWG9KQJWygBN9zIbq2/u/7AqtFDe3jlW8=;
        b=iwf36W9xW/3K2aexfmifh/4MvxLoZfw9OePF9LS1T/tKpxYehADORzG8WPNKeF3TWu8AZc
        b/q3Kzr76FFNJmZnxXK4m+W5OiKhEifeM5sw8fcH7Tje6z8NaEjSfnFGKobZZMrdmS3V6V
        6t5SWTV1TRgT9CfZ40r4tvYUhIffco8=
Date:   Sun, 20 Nov 2022 13:50:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sanan Hasanov <hasanou59@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, syzkaller <syzkaller@googlegroups.com>
Subject: Re: Syzkaller found a bug: general protection fault in
 x86_pmu_enable_event
Message-ID: <Y3oimvn5CfU4N7Zc@zn.tnic>
References: <CAMt6jhxg-_Pd__TfpSqX+=d2_-MFqCoF84qYYDcuu1Ps9M9hfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMt6jhxg-_Pd__TfpSqX+=d2_-MFqCoF84qYYDcuu1Ps9M9hfQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 01:47:26PM -0500, Sanan Hasanov wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.
> We enhanced the coverage of the configuration file using our tool, krepair.
> config and reproducer files are attached.
> Branch: https://github.com/torvalds/linux (HEAD detached at 33c9805860e58)
> Reproducer can be executed as follows:
> ./syz-execprog -repeat=0 -procs=8 program
> More info: https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md
> Thank you!
> 
> general protection fault, probably for non-canonical address
> 0xdffffc0000000033: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000198-0x000000000000019f]
> CPU: 0 PID: 7030 Comm: systemd-udevd Not tainted
> 6.1.0-rc1-00010-gbb1a1146467a #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:x86_pmu_enable_event+0x61/0x2b0
> Code: 00 e8 93 95 3a 00 48 c7 c7 40 59 60 85 e8 47 17 a4 02 48 8d bb
> 98 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6
> 04 02 65 48 8b 2d 0b 46 a1 7d 84 c0 74 08 3c 03 0f 8e f3 01
> RSP: 0000:ffff88811ae09ce8 EFLAGS: 00010016
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8260e90d
> RDX: 0000000000000033 RSI: ffffffff85605940 RDI: 0000000000000198
> RBP: ffff88811ae21e20 R08: 0000000000000001 R09: ffffed10235c43c5
> R10: ffff88811ae21e27 R11: ffffed10235c43c4 R12: 0000000000000007
> R13: ffff88811ae21c20 R14: fffffbfff0cf1d0f R15: 0000000000000004
> FS:  00007f2607dbb8c0(0000) GS:ffff88811ae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005606fbe35108 CR3: 000000010c384000 CR4: 0000000000350ef0
> DR0: 0000000003be2348 DR1: 0000000003be2348 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000600
> Call Trace:
>  <IRQ>
>  amd_pmu_enable_all+0x101/0x160
>  x86_pmu_enable+0x367/0xcb0
>  perf_pmu_enable+0xb6/0xf0
>  perf_mux_hrtimer_handler+0x4c0/0x880
>  __hrtimer_run_queues+0x2cf/0x6c0
>  hrtimer_interrupt+0x2f3/0x700
>  __sysvec_apic_timer_interrupt+0x114/0x370
>  sysvec_apic_timer_interrupt+0x89/0xc0

Looks like

baa014b9543c ("perf/x86/amd: Fix crash due to race between amd_pmu_enable_all, perf NMI and throttling")

which just went to Linus.

You could try 6.1-rc6 when it releases tomorrow.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
