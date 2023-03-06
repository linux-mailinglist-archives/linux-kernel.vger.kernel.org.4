Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76C36ABE03
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCFLUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCFLUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:20:39 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A92A2367B;
        Mon,  6 Mar 2023 03:20:38 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id ev13so6307986qvb.10;
        Mon, 06 Mar 2023 03:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678101637;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITa/PNq9clQBqOtNNMtN0KuFWltQAuyQLMGl4SkvV1g=;
        b=uLlve43QBBduSFchzJUM5p6612yy0wkPTx4/EYgv6K2DgtRZnJ5QY9ehXz2OhWkIeM
         l9q0tV/8nvgyhdzOFKkIu3ZzXJttZNfTH5yhjUTXUFuc1UzOOJKguRZCRiQbDkKY+Clq
         2SdL7ycnJ7wNyYsunpPEYhwWR72tJQPhUpuAB22R/Hl5siT1U5MiWE0aqVOMbUf0pI0W
         c5yjVNQj2osuCT5r0R+pYOXwURsRqXGGGZUlsQ2KQad/mWBfbfKVV7jSH84Qf0XnwDOI
         zW7sxeDUKh3E1MdX0VdnFTP95gkA6aQowq3CiX9ClZ6lifcvMhguT3WFT+NyKiiKkX+C
         m5UQ==
X-Gm-Message-State: AO0yUKU1w/BVyZ33ZP0Zm/4kjKJUqCUNVfCEQDbgglsaL35QrPFK4a47
        e4XDII7kfGf2/F6wsg6aGuG0lNB5ZJWLPQ==
X-Google-Smtp-Source: AK7set+eV8Nf3jiL8ZBWTG7L6AehS0KBDAaFJ3hob7IuvrYR2gSqDFqnE8Pg3SJnjtX5Pt8BB4Dkrw==
X-Received: by 2002:a05:6214:509d:b0:56e:9f19:71f9 with SMTP id kk29-20020a056214509d00b0056e9f1971f9mr22757817qvb.17.1678101637081;
        Mon, 06 Mar 2023 03:20:37 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id n135-20020a37408d000000b007402fdda195sm2169789qka.123.2023.03.06.03.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 03:20:36 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id x12so7685924ybt.7;
        Mon, 06 Mar 2023 03:20:36 -0800 (PST)
X-Received: by 2002:a5b:c42:0:b0:a43:52fe:c36f with SMTP id
 d2-20020a5b0c42000000b00a4352fec36fmr4874571ybr.7.1678101636408; Mon, 06 Mar
 2023 03:20:36 -0800 (PST)
MIME-Version: 1.0
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Mar 2023 12:20:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUKo_Sf7TjKzcNDa8Ve+6QrK+P8nSQrSQ=6LTRmcBKNww@mail.gmail.com>
Message-ID: <CAMuHMdUKo_Sf7TjKzcNDa8Ve+6QrK+P8nSQrSQ=6LTRmcBKNww@mail.gmail.com>
Subject: Re: cpumask: re-introduce constant-sized cpumask optimizations
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Your final commit 596ff4a09b898179 ("cpumask: re-introduce
constant-sized cpumask optimizations") in v6.3-rc1 introduced a
regression.  During Debian userspace startup, the kernel crashes with:

    Alignment trap: not handling instruction e1931f9f at [<c015f0b4>]
    8<--- cut here ---
    Unhandled fault: alignment exception (0x001) at 0xc0c5b701
    [c0c5b701] *pgd=40c1141e(bad)
    Internal error: : 1 [#1] SMP ARM
    CPU: 0 PID: 1 Comm: systemd Not tainted 6.3.0-rc1-shmobile #1519
    Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
    PC is at arch_spin_lock+0x10/0x48
    LR is at arch_spin_lock+0xc/0x48
    pc : [<c015f0b8>]    lr : [<c015f0b4>]    psr: 80060093
    sp : f0815e48  ip : c0c5b700  fp : c0d04e08
    r10: c0d05b34  r9 : c0e5c284  r8 : c10ad140
    r7 : f0815e84  r6 : 00000008  r5 : c0c5b701  r4 : f0815e84
    r3 : c0c5b701  r2 : c0858678  r1 : 40060013  r0 : c0c5b701
    Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
    Control: 10c5387d  Table: 4204c06a  DAC: 00000051
    Register r0 information: non-slab/vmalloc memory
    Register r1 information: non-paged memory
    Register r2 information: non-slab/vmalloc memory
    Register r3 information: non-slab/vmalloc memory
    Register r4 information: 2-page vmalloc region starting at
0xf0814000 allocated at kernel_clone+0xa0/0x258
    Register r5 information: non-slab/vmalloc memory
    Register r6 information: non-paged memory
    Register r7 information: 2-page vmalloc region starting at
0xf0814000 allocated at kernel_clone+0xa0/0x258
    Register r8 information: slab task_struct start c10ad140 pointer
offset 0 size 2176
    Register r9 information: non-slab/vmalloc memory
    Register r10 information: non-slab/vmalloc memory
    Register r11 information: non-slab/vmalloc memory
    Register r12 information: non-slab/vmalloc memory
    Process systemd (pid: 1, stack limit = 0x(ptrval))
    Stack: (0xf0815e48 to 0xf0816000)
    5e40:                   f0815e84 c0186694 40060013 96063d9c
f0815e80 00000008
    5e60: 00000002 c08584a4 00000000 96063d9c 00000000 04a183ac
00000003 00000001
    5e80: 04a183ac 00000122 00000000 ffff8dd8 c0858678 06040001
00000001 00000002
    5ea0: f7e1016b 00000007 c2143015 004c6000 00000000 c1d05000
c12c20d0 00000101
    5ec0: 00000000 00000000 00000000 0000007a 00000038 00000000
00000000 96063d9c
    5ee0: f0815ee4 c0e5c284 f0815f18 c22ad240 f0815f78 be847850
c10ad140 00000003
    5f00: b6e61130 c0445328 00000000 00000010 c22ad240 c024ab18
01000006 00000000
    5f20: 00000010 be847850 00000000 00000000 c22ad240 00000000
00000000 00000000
    5f40: 00000000 00000000 00000000 00004004 00000000 00000000
00000001 96063d9c
    5f60: c22ad240 be847850 f0815f78 f0815f84 00000010 c024af94
00000000 00000000
    5f80: 00000000 c22ad240 00000000 96063d9c 00000074 be847850
00000000 00000003
    5fa0: c01002c4 c0100060 00000074 be847850 0000000c be847850
00000010 00000000
    5fc0: 00000074 be847850 00000000 00000003 00000001 00000001
00000001 b6e61130
    5fe0: 00000003 be8477c0 b6ef152f b6e7a746 60060030 0000000c
00000000 00000000
     arch_spin_lock from add_timer_on+0xe8/0x124
     add_timer_on from try_to_generate_entropy+0x1f4/0x250
     try_to_generate_entropy from urandom_read_iter+0x2c/0xc8
     urandom_read_iter from vfs_read+0x124/0x178
     vfs_read from ksys_read+0x74/0xc8
     ksys_read from ret_fast_syscall+0x0/0x54
    Exception stack(0xf0815fa8 to 0xf0815ff0)
    5fa0:                   00000074 be847850 0000000c be847850
00000010 00000000
    5fc0: 00000074 be847850 00000000 00000003 00000001 00000001
00000001 b6e61130
    5fe0: 00000003 be8477c0 b6ef152f b6e7a746
    Code: e92d4010 e1a03000 ebfffff7 e1931f9f (e2812801)
    ---[ end trace 0000000000000000 ]---
    note: systemd[1] exited with irqs disabled

|     #define for_each_cpu_wrap(cpu, mask, start)                            \
|    -       for_each_set_bit_wrap(cpu, cpumask_bits(mask),
nr_cpumask_bits, start)
|    +       for_each_set_bit_wrap(cpu, cpumask_bits(mask),
small_cpumask_bits, start)

Presumably using small_cpumask_bits instead of nr_cpu_ids accesses
some uninitialized array members?

    NR_CPUS = 8
    small_cpumask_bits = 8
    nr_cpu_ids = 2

A similar kernel on an arm64 system that does have 8 CPU cores works fine.
On an arm64 system with 2 CPU cores, it crashes in a similar way.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
