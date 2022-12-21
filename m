Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFD76532C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiLUOyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiLUOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:54:42 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C28F593
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 06:54:40 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id cf42so23876889lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOvUXE/q0Tdyd0bPSRAaGvQA+/ZBTEIGbXtuDyb5qs8=;
        b=lrAkGyKFd5O3bX/1X6VPI4RkxSy92a31PuLldtQgjuGq//Oq6RcTQ7GfBQ6vkzEAip
         W5Ko3r6RZkm/iRtSBaHlNQvswVuQDKs/B9VZGJUfHHeeq7rMXm7CTgEU5y0mFjNiB6d1
         +J1rWgibDJPjja9u2LxW98a60ppzxRHjPa7wCfUTSNFOgZ+yLipLAy771TdjcHwZB7iT
         aYBCPe8Cn/OkUa0I8mFAo3JepJuW+jk9Tf4QZPza/rt422pg8ewaYgtL9uWaCOKdE0++
         lVKXhKSnMV1naPaXtMbVJ3Z+9pf707Q8H4pS+EBgALPMKIcpLeswmiEjXHcK3X1RXs5l
         1kTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOvUXE/q0Tdyd0bPSRAaGvQA+/ZBTEIGbXtuDyb5qs8=;
        b=g305Ei5nATOlRABKJS2m+U/RJWYeH6nMZBK+4mD55eJqXwoCZV5E38YI6vzcwYrp/C
         reJGEsy6m14Go7yv1cBhQSXWFVad2IK4XfeQLOmr4NWQUT9kqWH8U5tzwpD6fM/IDtvf
         JYq03Qb8NaESZ2OHjgIgdzbap+iSFpHfGH3w5xzP2cylOo2fZiXni4cTCM62YwUC8/BE
         pnrZG0TXmazXZaz7AS3nYSAUzTCEomP5pT0REt8ygqir5EAFVJJp2M6hJ7bueNb/aExf
         MFEBwKULZd05QsCcYhH84wIRjkKVhA0XYnT5fUcrbbm5TAP/ADOK5+0Qfse7xmhsIQt/
         GGoQ==
X-Gm-Message-State: AFqh2krsi9Q2WGn5oEqddrY3ZMLZpNp3U+z32K5g1NEPJl/ASv7y1AYr
        DLLaFDII8C5NIUHjFQQj9Ai+9FQz0mv/icBDEVU=
X-Google-Smtp-Source: AMrXdXu8q4nkkz7/g/1/yhxfXBoy7bSl+6GDHsMIoeJszomEfbe9DPC5VLDZalaJdeZCDSB9a+SVeQ==
X-Received: by 2002:ac2:5453:0:b0:4b5:830d:12ba with SMTP id d19-20020ac25453000000b004b5830d12bamr600753lfn.14.1671634479229;
        Wed, 21 Dec 2022 06:54:39 -0800 (PST)
Received: from mutt (c-e429e555.07-21-73746f28.bbcust.telenor.se. [85.229.41.228])
        by smtp.gmail.com with ESMTPSA id b19-20020ac25633000000b004b551505c29sm1861593lff.218.2022.12.21.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:54:38 -0800 (PST)
Date:   Wed, 21 Dec 2022 15:54:36 +0100
From:   Anders Roxell <anders.roxell@linaro.org>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, ebiederm@xmission.com, elver@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: BUG: KCSAN: data-race in do_page_fault /
 spectre_v4_enable_task_mitigation
Message-ID: <20221221145436.GF69385@mutt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I'm building an allmodconfig kernel on yesterdays linux-next (tag:
next-20221220) and I see a
"BUG: KCSAN: data-race in do_page_fault / spectre_v4_enable_task_mitigation"
when I boot up in QEMU. I ran the output via
scripts/decode_stacktrace.sh and this is what I see:


[ 2105.261121][  T154] ==================================================================
[ 2105.266067][  T154] BUG: KCSAN: data-race in do_page_fault / spectre_v4_enable_task_mitigation
[ 2105.271577][  T154] 
[ 2105.273121][  T154] write to 0xffff8000210b3fb8 of 8 bytes by task 136 on cpu 0:
[ 2105.277743][ T154] spectre_v4_enable_task_mitigation (/home/anders/src/kernel/next/arch/arm64/kernel/proton-pack.c:651 /home/anders/src/kernel/next/arch/arm64/kernel/proton-pack.c:664) 
[ 2105.281802][ T154] __switch_to (/home/anders/src/kernel/next/arch/arm64/kernel/process.c:459 /home/anders/src/kernel/next/arch/arm64/kernel/process.c:532) 
[ 2105.284670][ T154] __schedule (/home/anders/src/kernel/next/kernel/sched/core.c:5247 /home/anders/src/kernel/next/kernel/sched/core.c:6555) 
[ 2105.287555][ T154] preempt_schedule_irq (/home/anders/src/kernel/next/arch/arm64/include/asm/irqflags.h:70 /home/anders/src/kernel/next/arch/arm64/include/asm/irqflags.h:98 /home/anders/src/kernel/next/kernel/sched/core.c:6868) 
[ 2105.290857][ T154] arm64_preempt_schedule_irq (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:237) 
[ 2105.294433][ T154] el1_interrupt (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:476 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:486) 
[ 2105.297433][ T154] el1h_64_irq_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:492) 
[ 2105.300718][ T154] el1h_64_irq (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:580) 
[ 2105.303497][ T154] arch_local_irq_restore (/home/anders/src/kernel/next/arch/arm64/include/asm/jump_label.h:21 /home/anders/src/kernel/next/arch/arm64/include/asm/irqflags.h:130) 
[ 2105.306750][ T154] fs_reclaim_acquire (/home/anders/src/kernel/next/mm/page_alloc.c:4691) 
[ 2105.310118][ T154] slab_pre_alloc_hook.constprop.0 (/home/anders/src/kernel/next/include/linux/sched/mm.h:272 /home/anders/src/kernel/next/mm/slab.h:720) 
[ 2105.313966][ T154] slab_alloc_node.isra.0 (/home/anders/src/kernel/next/mm/slub.c:3434) 
[ 2105.317343][ T154] __kmem_cache_alloc_lru (/home/anders/src/kernel/next/mm/slub.c:3469) 
[ 2105.320659][ T154] kmem_cache_alloc (/home/anders/src/kernel/next/mm/slub.c:3477) 
[ 2105.323673][ T154] getname_flags (/home/anders/src/kernel/next/fs/namei.c:139) 
[ 2105.326703][ T154] getname (/home/anders/src/kernel/next/fs/namei.c:218) 
[ 2105.329377][ T154] do_sys_openat2 (/home/anders/src/kernel/next/fs/open.c:1304) 
[ 2105.332352][ T154] __arm64_sys_openat (/home/anders/src/kernel/next/fs/open.c:1326) 
[ 2105.335573][ T154] el0_svc_common.constprop.0 (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:38 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:52 /home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:142) 
[ 2105.339272][ T154] do_el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/syscall.c:197) 
[ 2105.342025][ T154] el0_svc (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:142 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:638) 
[ 2105.344687][ T154] el0t_64_sync_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:656) 
[ 2105.348089][ T154] el0t_64_sync (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:584) 
[ 2105.350998][  T154] 
[ 2105.352567][  T154] read to 0xffff8000210b3fb8 of 8 bytes by task 154 on cpu 0:
[ 2105.357117][ T154] do_page_fault (/home/anders/src/kernel/next/arch/arm64/mm/fault.c:517 /home/anders/src/kernel/next/arch/arm64/mm/fault.c:558) 
[ 2105.360110][ T154] do_translation_fault (/home/anders/src/kernel/next/arch/arm64/mm/fault.c:695) 
[ 2105.363400][ T154] do_mem_abort (/home/anders/src/kernel/next/arch/arm64/mm/fault.c:831) 
[ 2105.366400][ T154] el0_ia (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:133 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:142 /home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:534) 
[ 2105.369059][ T154] el0t_64_sync_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:662) 
[ 2105.372445][ T154] el0t_64_sync (/home/anders/src/kernel/next/arch/arm64/kernel/entry.S:584) 
[ 2105.375404][  T154] 
[ 2105.376935][  T154] no locks held by systemd/154.
[ 2105.379935][  T154] irq event stamp: 385
[ 2105.382448][ T154] hardirqs last enabled at (385): local_daif_restore (/home/anders/src/kernel/next/arch/arm64/include/asm/daifflags.h:71 (discriminator 1)) 
[ 2105.388413][ T154] hardirqs last disabled at (384): el0t_64_sync_handler (/home/anders/src/kernel/next/arch/arm64/kernel/entry-common.c:662) 
[ 2105.394436][ T154] softirqs last enabled at (352): fpsimd_restore_current_state (/home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:264 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1780) 
[ 2105.400932][ T154] softirqs last disabled at (350): fpsimd_restore_current_state (/home/anders/src/kernel/next/include/linux/bottom_half.h:20 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:242 /home/anders/src/kernel/next/arch/arm64/kernel/fpsimd.c:1773) 
[ 2105.407394][  T154] 
[ 2105.408909][  T154] value changed: 0x0000000060000000 -> 0x0000000060001000
[ 2105.413225][  T154] 
[ 2105.414746][  T154] Reported by Kernel Concurrency Sanitizer on:
[ 2105.426169][  T154] Hardware name: linux,dummy-virt (DT)
[ 2105.429528][  T154] ==================================================================


The prctl case, which only gets called on 'current'. However, assuming
the kernel could be preempted while accessing current->pt_regs->pstate,
and then it races against the task switch.

Any idea what happens and how to fix it?


Cheers,
Anders
