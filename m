Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80ED661369
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 04:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjAHDH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 22:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAHDHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 22:07:53 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A539FCA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 19:07:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso3947770wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 19:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEKskELdLZIJtmIyKt6gufSHAWMjKa063XQi/xZ7jOI=;
        b=DkePwDWxPWgZyo8z3TQRMCCkTFjR/aSPXejeRo/2fNq7hGqAGJLG1CfNujqMPBJwGj
         46SAzSJMTRDIJ+6K4+uo7+RB1H8AKAweAFN/w1aJMCFKkMx+jGNbmqWRuxmSMZzgRTae
         Tyspg055HCqBBmqoP/6BrBlLuXWN6AZRiGogoLk+1udcF3RQxHGcFj8+3JxJ8FM/S8J7
         qEu2Y36gNiFWeMIwT836rIx7zj2BKzRs2+QRGW82Qwlmfz0n15PKDpnAi9q3xbT9Edp0
         E13NnbCNw73//mGj5u0GRi703BLpbFBcTRlc2JJ1hiI87QPUIQ3zaRuzt9CUd238Tsqi
         AUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEKskELdLZIJtmIyKt6gufSHAWMjKa063XQi/xZ7jOI=;
        b=djGDkBGJUndD+xsQRCaruLrIWy2RANn3gzI1sI3EsE0qzdIzW0KswXhhbHT63qDKWd
         BsX782zNgGGlUtfzSdUfkufp+vA5iTublGCTtpQFjkuFJ++mOKhXRyEfApFG0JfNqBFE
         H0kvhKNiOR+n2qYSwREnje4OVOevrpXOnjhJKc3glwSIGkQgP1BkCgZSB8ui/G03/5uK
         See+f7CATK2MLAPClcA0pSKH8oEc3K0B/cmcDzStG+par49/woFLg1l2cPWFQJVGqLzf
         NQET3eDVyc6iLJlrv2pYP7rEZtHOA+pnA8Qjs0wJt4H669seBeO00HeOufv4jw24WkkE
         Iwtw==
X-Gm-Message-State: AFqh2kpVOSvNJaFjIRN12CMmRgSGWFgROqOjMOscWpDiS7Phw3Kzg1TP
        6fC6RGgWofU3gjlzZtOfZBdSpQPpLcmxrurC
X-Google-Smtp-Source: AMrXdXu8AkcJm/vzMaQXgy2fZWf+1GfGzxYd2ae0I1i1DSX6XapGAB3Qn7V/mIFLprhOksRphyLTOw==
X-Received: by 2002:a05:600c:41d1:b0:3d2:3d7b:6118 with SMTP id t17-20020a05600c41d100b003d23d7b6118mr42899127wmh.24.1673147270070;
        Sat, 07 Jan 2023 19:07:50 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003c6bbe910fdsm13434028wmq.9.2023.01.07.19.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 19:07:49 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Wake-up from suspend to RAM broken under `retbleed=stuff`
Date:   Sun,  8 Jan 2023 03:07:48 +0000
Message-Id: <20230108030748.158120-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wake-up from suspend to RAM seems broken under `retbleed=stuff`
(the recently introduced call depth tracking mitigation, see:
https://lore.kernel.org/lkml/f9fd86acac4f49bc8f90b403978e9df3@AcuMS.aculab.com/t/)
I can replicate it on both real hardware and QEMU (with and without KVM).

It can replicate it by booting a fairly standard mainline kernel
on QEMU with `init=/bin/bash` and then suspending to RAM with:
    echo "deep" > /sys/power/mem_sleep
    echo "mem" > /sys/power/state
Then executing `system_wakeup` on the QEMU monitor causes the crash.

Some tracing with QEMU shows that some of the instrumentation
(`INCREMENT_CALL_DEPTH` / `sarq $5, %gs:__x86_call_depth`, ...)
seems to be done before %gs has been set up, causing a fault.

The crash happens shortly after the call to `restore_processor_state`
from `wakeup_64.S`, on the `sarq $5, %gs:__x86_call_depth` instruction.
Probably needs to be excluded?

And I can also see some other suspicious instances of `sarq $5, ...`
before the one that causes the crash, which also look suspicious.

QEMU log before the crash:

    ...
    0xffffffff9486dc89:  4c 8b 68 10              movq     0x10(%rax), %r13
    0xffffffff9486dc8d:  4c 8b 70 08              movq     8(%rax), %r14
    0xffffffff9486dc91:  4c 8b 38                 movq     (%rax), %r15
    0xffffffff9486dc94:  31 c0                    xorl     %eax, %eax
    0xffffffff9486dc96:  48 83 c4 08              addq     $8, %rsp
    # (This is the 'jmp restore_processor_state' on wakeup_64.S)
    0xffffffff9486dc9a:  e9 51 e5 c2 00           jmp      0xffffffff9549c1f0
    0xffffffff9549c1f0:  66 0f 1f 00              nopw     (%rax)
    0xffffffff9549c1f4:  55                       pushq    %rbp
    0xffffffff9549c1f5:  48 89 e5                 movq     %rsp, %rbp
    0xffffffff9549c1f8:  41 57                    pushq    %r15
    0xffffffff9549c1fa:  41 56                    pushq    %r14
    0xffffffff9549c1fc:  41 55                    pushq    %r13
    0xffffffff9549c1fe:  41 54                    pushq    %r12
    0xffffffff9549c200:  53                       pushq    %rbx
    0xffffffff9549c201:  48 83 ec 20              subq     $0x20, %rsp
    0xffffffff9549c205:  80 3d 10 93 c4 01 00     cmpb     $0, 0x1c49310(%rip)
    0xffffffff9549c20c:  0f 85 8b 02 00 00        jne      0xffffffff9549c49d
    0xffffffff9549c49d:  48 8b 15 24 90 c4 01     movq     0x1c49024(%rip), %rdx
    0xffffffff9549c4a4:  bf a0 01 00 00           movl     $0x1a0, %edi
    0xffffffff9549c4a9:  89 d6                    movl     %edx, %esi
    0xffffffff9549c4ab:  48 c1 ea 20              shrq     $0x20, %rdx
    0xffffffff9549c4af:  e8 32 9c 3e ff           callq    0xffffffff948860e6
    0xffffffff948860e6:  65 48 c1 3c 25 90 29 03  sarq     $5, %gs:0x32990
    0xffffffff948860ee:  00 05
    
    RAX=0000000000000000 RBX=ffff98fbc1295d00 RCX=0000000000000000 RDX=0000000000000000
    RSI=0000000000000001 RDI=00000000000001a0 RBP=ffffaace80013ca0 RSP=ffffaace80013c50
    R8 =0000000000000004 R9 =0000000021bf694e R10=00000000aaaaaaab R11=0000000000000005
    R12=0000000000000000 R13=0000000000000000 R14=0000000000000004 R15=ffff98fbc4ae2560
    RIP=ffffffff948860e6 RFL=00000046 [---Z-P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
    ES =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    CS =0010 0000000000000000 ffffffff 00af9b00 DPL=0 CS64 [-RA]
    SS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    DS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    FS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    GS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
    TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
    GDT=     ffff98fbfec0b000 0000007f
    IDT=     ffffffff96604000 000001ff
    CR0=80050033 CR2=000055b505d6fd48 CR3=0000000001bfa000 CR4=000006f0
    DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
    DR6=00000000ffff0ff0 DR7=0000000000000400
    CCS=0000000000000000 CCD=0000000000000000 CCO=SARQ
    EFER=0000000000000d01
    check_exception old: 0xffffffff new 0xe
         0: v=0e e=0000 i=0 cpl=0 IP=0010:ffffffff948860e6 pc=ffffffff948860e6 SP=0018:ffffaace80013c50 CR2=0000000000032990
    RAX=0000000000000000 RBX=ffff98fbc1295d00 RCX=0000000000000000 RDX=0000000000000000
    RSI=0000000000000001 RDI=00000000000001a0 RBP=ffffaace80013ca0 RSP=ffffaace80013c50
    R8 =0000000000000004 R9 =0000000021bf694e R10=00000000aaaaaaab R11=0000000000000005
    R12=0000000000000000 R13=0000000000000000 R14=0000000000000004 R15=ffff98fbc4ae2560
    RIP=ffffffff948860e6 RFL=00000046 [---Z-P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
    ES =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    CS =0010 0000000000000000 ffffffff 00af9b00 DPL=0 CS64 [-RA]
    SS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    DS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    FS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    GS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
    TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
    GDT=     ffff98fbfec0b000 0000007f
    IDT=     ffffffff96604000 000001ff
    CR0=80050033 CR2=0000000000032990 CR3=0000000001bfa000 CR4=000006f0
    DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
    DR6=00000000ffff0ff0 DR7=0000000000000400
    CCS=0000000000000000 CCD=0000000000000000 CCO=SARQ
    EFER=0000000000000d01
    check_exception old: 0xe new 0xd
         1: v=08 e=0000 i=0 cpl=0 IP=0010:ffffffff948860e6 pc=ffffffff948860e6 SP=0018:ffffaace80013c50 env->regs[R_EAX]=0000000000000000
    RAX=0000000000000000 RBX=ffff98fbc1295d00 RCX=0000000000000000 RDX=0000000000000000
    RSI=0000000000000001 RDI=00000000000001a0 RBP=ffffaace80013ca0 RSP=ffffaace80013c50
    R8 =0000000000000004 R9 =0000000021bf694e R10=00000000aaaaaaab R11=0000000000000005
    R12=0000000000000000 R13=0000000000000000 R14=0000000000000004 R15=ffff98fbc4ae2560
    RIP=ffffffff948860e6 RFL=00000046 [---Z-P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
    ES =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    CS =0010 0000000000000000 ffffffff 00af9b00 DPL=0 CS64 [-RA]
    SS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    DS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    FS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    GS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
    LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
    TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
    GDT=     ffff98fbfec0b000 0000007f
    IDT=     ffffffff96604000 000001ff
    CR0=80050033 CR2=0000000000032990 CR3=0000000001bfa000 CR4=000006f0
    DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
    DR6=00000000ffff0ff0 DR7=0000000000000400
    CCS=0000000000000000 CCD=0000000000000000 CCO=SARQ
    EFER=0000000000000d01
    check_exception old: 0x8 new 0xd
    Triple fault
