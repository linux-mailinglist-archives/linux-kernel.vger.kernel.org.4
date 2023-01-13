Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1C668F56
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjAMHjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjAMHjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:39:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED519235
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:39:41 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p3-20020a05600c1d8300b003d9ee5f125bso11660696wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M4PJa8bRUQ4Sc+Wzz/wLpc5Oc/26l8w9l+YmujHJ60=;
        b=P1LDNQgqNtOTOXUgMU4kngFnoQqhy9Oq7QtZJYVR4R8y3LYth3y7NREJn0SEQjzIpt
         Y9vIhsduHpDGCLyv9tAMdFmQ4j/dh5+D1JbS+VYHbQaThnd4MoacI8qcpGg/4l1gOW2/
         lQrabY4P5iQTl0yf1gv9Y2/MwMldp7MEwXewivv1y4ZenzLvn0tSTfIwYpnphHcVWJ9o
         LgTArCu7JAcefSAtZYvgnHmnLGcJRBDBWePUwVhXgAQZ0yfJ9mjGeoNyp8CQcP2qCdqL
         NQ/rs73ktpBLscWTNQE4C8ddF4lzEPDW27yBO0IKttw+AhYeje1S34W4z4dieZeoD7PI
         saKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M4PJa8bRUQ4Sc+Wzz/wLpc5Oc/26l8w9l+YmujHJ60=;
        b=Ua3nqkpx8sULqJ4uYTY2cUoDqsFXMMLik6T/ikrH/MSvhwpoVOBGslwL4yFHp2sOvd
         L/p3iSv80pvE/uM62tz/Ejhdm0eMRvmXupUEKcm+mpPB5peLgG44o9zo3kQq57O0hGk1
         70jEaH1tteHvT2DqfkuiYvAPZIfGKi7S6tGLVgqF1EGf4t0zlzYG+O8J79EtavUTjiEL
         Lu2ag9Dbg91NVuBXgzWw2eqbB17zcTJYUPIG47PTyONzfBcmk/dDUVh50s8Q+TLImKWG
         hksA7oCVYfAS1DAP3eUvfc6iQerWt9vTXdFIhAmdQ3cHQxlJh0/Ty8KnYnlBFVI6WWRz
         KMBg==
X-Gm-Message-State: AFqh2kpDidzG+ryGMin/hVJQd4U0q8ytEA1mR+dcmNschBZ/+u0stfbj
        igtIawkNQm3MpQIrCJ84Q58=
X-Google-Smtp-Source: AMrXdXs3tLo1GHegPJMdV9HWu8qZmoNTQpGBWl1/Ydv1V8mjdLCceMWAUbQlN+gWfV6Ebj/DmKEHOw==
X-Received: by 2002:a05:600c:500e:b0:3cf:88c3:d008 with SMTP id n14-20020a05600c500e00b003cf88c3d008mr61730943wmr.28.1673595580235;
        Thu, 12 Jan 2023 23:39:40 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003d9a86a13bfsm26207681wmq.28.2023.01.12.23.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 23:39:39 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        x86@kernel.org
Subject: Re: [RFC][PATCH 0/6] x86: Fix suspend vs retbleed=stuff
Date:   Fri, 13 Jan 2023 07:39:38 +0000
Message-Id: <20230113073938.1066227-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112143141.645645775@infradead.org>
References: <20230112143141.645645775@infradead.org>
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

Hi Peter,

I tried your patches on both QEMU and my two (real) computers where
s2ram with `retbleed=stuff` was failing and they wake up fine now.

However, I think some minor reviews are needed:

(1) I got a build error due to a symbol conflict between the
    `restore_registers` in `arch/x86/include/asm/suspend_64.h` and the
    one in `drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c`.

    (I fixed by renaming the one in `hw_gpio.c`, but it's worth
     an `allmodconfig` just in case there's something else)

(2) Tracing with QEMU I still see two `sarq $5, %gs:0x1337B33F` before
    `%gs` is restored. Those correspond to the calls from
    `secondary_startup_64` in `arch/x86/kernel/head_64.S` to
    `verify_cpu` and `sev_verify_cbit`.
    Those don't cause a crash but look suspicious, are they correct?

    (There are also some `sarq`s in the call to `early_setup_idt` from
    `secondary_startup_64`, but `%gs` is restored immediately before)

    I attach an annotated QEMU log for those if it is useful.

Regards,
- Joan

QEMU wakeup log:

# 32-bit code ellided. Next line calls `secondary_startup_64` from `startup_64`
0x0009a0d0:  ff 25 2a 2f 00 00        jmpq     *0x2f2a(%rip)
# Next line is `call verify_cpu` from `secondary_startup_64`
0xffffffff9a800070:  e8 f1 00 00 00           callq    0xffffffff9a800166
# This next `sarq` does not have the correct GS set?
#     RAX=0000000080050033 RBX=0000000000000800 RCX=00000000c0000080 RDX=0000000000000000
#     RSI=0000000000000000 RDI=0000000000000001 RBP=0000000000000000 RSP=000000000009e018
#     R8 =0000000000000000 R9 =0000000000000000 R10=0000000000000000 R11=0000000000000000
#     R12=0000000000000000 R13=0000000000000000 R14=0000000000000000 R15=0000000000000000
#     RIP=ffffffff9a800166 RFL=00200097 [--S-APC] CPL=0 II=0 A20=1 SMM=0 HLT=0
#     ES =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     CS =0010 0000000000000000 ffffffff 00af9b00 DPL=0 CS64 [-RA]
#     SS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     DS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     FS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     GS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
#     TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
#     GDT=     0000000000098030 0000001f
#     IDT=     0000000000000000 00000000
#     CR0=80050033 CR2=0000000000000000 CR3=000000000009c000 CR4=000006b0
#     DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
#     DR6=00000000ffff0ff0 DR7=0000000000000400
#     CCS=0000000000000095 CCD=fffffffffffff6ff CCO=EFLAGS
#     EFER=0000000000000d01
0xffffffff9a800166:  65 48 c1 3c 25 90 29 03  sarq     $5, %gs:0x32990
0xffffffff9a80016e:  00 05
0xffffffff9a800170:  66 0f 1f 00              nopw     (%rax)
0xffffffff9a800174:  9c                       pushfq   
0xffffffff9a800175:  6a 00                    pushq    $0
0xffffffff9a800177:  9d                       popfq    
0xffffffff9a800178:  b8 00 00 00 00           movl     $0, %eax
0xffffffff9a80017d:  0f a2                    cpuid    
0xffffffff9a80017f:  83 f8 01                 cmpl     $1, %eax
0xffffffff9a800182:  0f 82 d2 00 00 00        jb       0xffffffff9a80025a
0xffffffff9a800188:  66 31 ff                 xorw     %di, %di
0xffffffff9a80018b:  81 fb 41 75 74 68        cmpl     $0x68747541, %ebx
0xffffffff9a800191:  75 16                    jne      0xffffffff9a8001a9
0xffffffff9a800193:  81 fa 65 6e 74 69        cmpl     $0x69746e65, %edx
0xffffffff9a800199:  75 0e                    jne      0xffffffff9a8001a9
0xffffffff9a80019b:  81 f9 63 41 4d 44        cmpl     $0x444d4163, %ecx
0xffffffff9a8001a1:  75 06                    jne      0xffffffff9a8001a9
0xffffffff9a8001a3:  66 bf 01 00              movw     $1, %di
0xffffffff9a8001a7:  eb 4d                    jmp      0xffffffff9a8001f6
0xffffffff9a8001f6:  b8 01 00 00 00           movl     $1, %eax
0xffffffff9a8001fb:  0f a2                    cpuid    
0xffffffff9a8001fd:  81 e2 61 81 00 07        andl     $0x7008161, %edx
0xffffffff9a800203:  81 f2 61 81 00 07        xorl     $0x7008161, %edx
0xffffffff9a800209:  75 4f                    jne      0xffffffff9a80025a
0xffffffff9a80020b:  b8 00 00 00 80           movl     $0x80000000, %eax
0xffffffff9a800210:  0f a2                    cpuid    
0xffffffff9a800212:  3d 01 00 00 80           cmpl     $0x80000001, %eax
0xffffffff9a800217:  72 41                    jb       0xffffffff9a80025a
0xffffffff9a800219:  b8 01 00 00 80           movl     $0x80000001, %eax
0xffffffff9a80021e:  0f a2                    cpuid    
0xffffffff9a800220:  81 e2 00 00 00 20        andl     $0x20000000, %edx
0xffffffff9a800226:  81 f2 00 00 00 20        xorl     $0x20000000, %edx
0xffffffff9a80022c:  75 2c                    jne      0xffffffff9a80025a
0xffffffff9a80022e:  b8 01 00 00 00           movl     $1, %eax
0xffffffff9a800233:  0f a2                    cpuid    
0xffffffff9a800235:  81 e2 00 00 00 06        andl     $0x6000000, %edx
0xffffffff9a80023b:  81 fa 00 00 00 06        cmpl     $0x6000000, %edx
0xffffffff9a800241:  74 22                    je       0xffffffff9a800265
0xffffffff9a800265:  9d                       popfq    
0xffffffff9a800266:  31 c0                    xorl     %eax, %eax
0xffffffff9a800268:  e9 23 24 d4 00           jmp      0xffffffff9b542690
0xffffffff9b542690:  f3 0f 1e fa              endbr64  
0xffffffff9b542694:  65 48 c1 24 25 90 29 03  shlq     $5, %gs:0x32990
0xffffffff9b54269c:  00 05
0xffffffff9b54269e:  74 02                    je       0xffffffff9b5426a2
0xffffffff9b5426a2:  e8 01 00 00 00           callq    0xffffffff9b5426a8
0xffffffff9b5426a8:  e8 01 00 00 00           callq    0xffffffff9b5426ae
0xffffffff9b5426ae:  e8 01 00 00 00           callq    0xffffffff9b5426b4
0xffffffff9b5426b4:  e8 01 00 00 00           callq    0xffffffff9b5426ba
0xffffffff9b5426ba:  e8 01 00 00 00           callq    0xffffffff9b5426c0
0xffffffff9b5426c0:  e8 01 00 00 00           callq    0xffffffff9b5426c6
0xffffffff9b5426c6:  e8 01 00 00 00           callq    0xffffffff9b5426cc
0xffffffff9b5426cc:  e8 01 00 00 00           callq    0xffffffff9b5426d2
0xffffffff9b5426d2:  e8 01 00 00 00           callq    0xffffffff9b5426d8
0xffffffff9b5426d8:  e8 01 00 00 00           callq    0xffffffff9b5426de
0xffffffff9b5426de:  e8 01 00 00 00           callq    0xffffffff9b5426e4
0xffffffff9b5426e4:  e8 01 00 00 00           callq    0xffffffff9b5426ea
0xffffffff9b5426ea:  e8 01 00 00 00           callq    0xffffffff9b5426f0
0xffffffff9b5426f0:  e8 01 00 00 00           callq    0xffffffff9b5426f6
0xffffffff9b5426f6:  e8 01 00 00 00           callq    0xffffffff9b5426fc
0xffffffff9b5426fc:  e8 01 00 00 00           callq    0xffffffff9b542702
0xffffffff9b542702:  48 81 c4 80 00 00 00     addq     $0x80, %rsp
0xffffffff9b542709:  65 48 c7 04 25 90 29 03  movq     $-1, %gs:0x32990
0xffffffff9b542711:  00 ff ff ff ff
# Returns from `verify_cpu`
0xffffffff9b542716:  c3                       retq     
0xffffffff9a800075:  48 8b 04 25 38 2e 64 9c  movq     0xffffffff9c642e38, %rax
0xffffffff9a80007d:  48 05 00 00 61 1c        addq     $0x1c610000, %rax
0xffffffff9a800083:  0f 20 e1                 movq     %cr4, %rcx
0xffffffff9a800086:  83 e1 40                 andl     $0x40, %ecx
0xffffffff9a800089:  81 c9 a0 00 00 00        orl      $0xa0, %ecx
0xffffffff9a80008f:  f7 05 87 bf 6c 01 01 00  testl    $1, 0x16cbf87(%rip)
0xffffffff9a800097:  00 00
0xffffffff9a800099:  74 06                    je       0xffffffff9a8000a1
0xffffffff9a8000a1:  0f 22 e1                 movq     %rcx, %cr4
0xffffffff9a8000a4:  48 03 05 65 9f e1 01     addq     0x1e19f65(%rip), %rax
0xffffffff9a8000ab:  56                       pushq    %rsi
0xffffffff9a8000ac:  48 89 c7                 movq     %rax, %rdi
# Next line is `call sev_verify_cbit` from `secondary_startup_64`
0xffffffff9a8000af:  e8 c2 01 00 00           callq    0xffffffff9a800276
# This next `sarq` does not have the correct GS set?
#     RAX=0000000002e10000 RBX=0000000000000800 RCX=00000000000000a0 RDX=0000000006000000
#     RSI=0000000000000000 RDI=0000000002e10000 RBP=0000000000000000 RSP=000000000009e018
#     R8 =0000000000000000 R9 =0000000000000000 R10=0000000000000000 R11=0000000000000000
#     R12=0000000000000000 R13=0000000000000000 R14=0000000000000000 R15=0000000000000000
#     RIP=ffffffff9a8000af RFL=00200007 [-----PC] CPL=0 II=0 A20=1 SMM=0 HLT=0
#     ES =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     CS =0010 0000000000000000 ffffffff 00af9b00 DPL=0 CS64 [-RA]
#     SS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     DS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     FS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     GS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
#     TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
#     GDT=     0000000000098030 0000001f
#     IDT=     0000000000000000 00000000
#     CR0=80050033 CR2=0000000000000000 CR3=000000000009c000 CR4=000000a0
#     DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
#     DR6=00000000ffff0ff0 DR7=0000000000000400
#     CCS=ffffffffe6800000 CCD=0000000002e10000 CCO=ADDQ
#     EFER=0000000000000d01
0xffffffff9a800276:  65 48 c1 3c 25 90 29 03  sarq     $5, %gs:0x32990
0xffffffff9a80027e:  00 05
0xffffffff9a800280:  66 0f 1f 00              nopw     (%rax)
0xffffffff9a800284:  48 8b 35 ad 2b e4 01     movq     0x1e42bad(%rip), %rsi
0xffffffff9a80028b:  48 85 f6                 testq    %rsi, %rsi
0xffffffff9a80028e:  74 4b                    je       0xffffffff9a8002db
0xffffffff9a8002db:  48 89 f8                 movq     %rdi, %rax
0xffffffff9a8002de:  e9 ad 23 d4 00           jmp      0xffffffff9b542690
0xffffffff9b542690:  f3 0f 1e fa              endbr64  
0xffffffff9b542694:  65 48 c1 24 25 90 29 03  shlq     $5, %gs:0x32990
0xffffffff9b54269c:  00 05
0xffffffff9b54269e:  74 02                    je       0xffffffff9b5426a2
# Returns from `sev_verify_cbit`
0xffffffff9b5426a0:  c3                       retq     
0xffffffff9a8000b4:  5e                       popq     %rsi
0xffffffff9a8000b5:  0f 22 d8                 movq     %rax, %cr3
0xffffffff9a8000b8:  0f 20 e1                 movq     %cr4, %rcx
0xffffffff9a8000bb:  48 89 c8                 movq     %rcx, %rax
0xffffffff9a8000be:  48 81 f1 80 00 00 00     xorq     $0x80, %rcx
0xffffffff9a8000c5:  0f 22 e1                 movq     %rcx, %cr4
0xffffffff9a8000c8:  0f 22 e0                 movq     %rax, %cr4
0xffffffff9a8000cb:  48 c7 c0 d4 00 80 9a     movq     $-0x657fff2c, %rax
0xffffffff9a8000d2:  ff e0                    jmpq     *%rax
0xffffffff9a8000d4:  0f 01 15 25 9f e1 01     lgdtq    0x1e19f25(%rip)
0xffffffff9a8000db:  31 c0                    xorl     %eax, %eax
0xffffffff9a8000dd:  8e d8                    movl     %eax, %ds
0xffffffff9a8000df:  8e d0                    movl     %eax, %ss
0xffffffff9a8000e1:  8e c0                    movl     %eax, %es
0xffffffff9a8000e3:  8e e0                    movl     %eax, %fs
0xffffffff9a8000e5:  8e e8                    movl     %eax, %gs
0xffffffff9a8000e7:  b9 01 01 00 c0           movl     $0xc0000101, %ecx
0xffffffff9a8000ec:  8b 05 36 e5 fa 01        movl     0x1fae536(%rip), %eax
0xffffffff9a8000f2:  8b 15 34 e5 fa 01        movl     0x1fae534(%rip), %edx
# Restores GS in `secondary_startup_64`
0xffffffff9a8000f8:  0f 30                    wrmsr    
# Processor state after is:
#     RAX=00000000c7a00000 RBX=0000000000000800 RCX=00000000c0000101 RDX=00000000ffff97b9
#     RSI=0000000000000000 RDI=0000000002e10000 RBP=0000000000000000 RSP=000000000009e020
#     R8 =0000000000000000 R9 =0000000000000000 R10=0000000000000000 R11=0000000000000000
#     R12=0000000000000000 R13=0000000000000000 R14=0000000000000000 R15=0000000000000000
#     RIP=ffffffff9a8000fa RFL=00200046 [---Z-P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
#     ES =0000 0000000000000000 00000000 00000000
#     CS =0010 0000000000000000 ffffffff 00af9b00 DPL=0 CS64 [-RA]
#     SS =0000 0000000000000000 00000000 00000000
#     DS =0000 0000000000000000 00000000 00000000
#     FS =0000 0000000000000000 00000000 00000000
#     GS =0000 ffff97b9c7a00000 00000000 00000000
#     LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
#     TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
#     GDT=     ffff97b9c7a0b000 0000007f
#     IDT=     0000000000000000 00000000
#     CR0=80050033 CR2=0000000000000000 CR3=0000000002e10000 CR4=000000a0
#     DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
#     DR6=00000000ffff0ff0 DR7=0000000000000400
#     CCS=0000000000000081 CCD=0000000000000020 CCO=CLR
#     EFER=0000000000000d01
0xffffffff9a8000fa:  48 8b 25 37 e5 fa 01     movq     0x1fae537(%rip), %rsp
0xffffffff9a800101:  56                       pushq    %rsi
# Next line is `call early_setup_idt` from `secondary_startup_64`
0xffffffff9a800102:  e8 9f 0f 00 00           callq    0xffffffff9a8010a6
0xffffffff9a8010a6:  65 48 c1 3c 25 90 29 03  sarq     $5, %gs:0x32990
0xffffffff9a8010ae:  00 05
0xffffffff9a8010b0:  66 0f 1f 00              nopw     (%rax)
0xffffffff9a8010b4:  e8 2d af 08 00           callq    0xffffffff9a88bfe6
0xffffffff9a88bfe6:  65 48 c1 3c 25 90 29 03  sarq     $5, %gs:0x32990
0xffffffff9a88bfee:  00 05
0xffffffff9a88bff0:  66 0f 1f 00              nopw     (%rax)
0xffffffff9a88bff4:  bf 03 00 00 00           movl     $3, %edi
0xffffffff9a88bff9:  e8 18 68 f7 ff           callq    0xffffffff9a802816
0xffffffff9a802816:  65 48 c1 3c 25 90 29 03  sarq     $5, %gs:0x32990
0xffffffff9a80281e:  00 05
0xffffffff9a802820:  f3 0f 1e fa              endbr64  
0xffffffff9a802824:  8b 15 3e 98 6c 01        movl     0x16c983e(%rip), %edx
# ... more stuff inside `early_setup_idt` ellided
0xffffffff9a800107:  5e                       popq     %rsi
0xffffffff9a800108:  b8 01 00 00 80           movl     $0x80000001, %eax
0xffffffff9a80010d:  0f a2                    cpuid    
0xffffffff9a80010f:  89 d7                    movl     %edx, %edi
0xffffffff9a800111:  b9 80 00 00 c0           movl     $0xc0000080, %ecx
0xffffffff9a800116:  0f 32                    rdmsr    
0xffffffff9a800118:  89 c2                    movl     %eax, %edx
0xffffffff9a80011a:  0f ba e8 00              btsl     $0, %eax
0xffffffff9a80011e:  0f ba e7 14              btl      $0x14, %edi
0xffffffff9a800122:  73 0d                    jae      0xffffffff9a800131
0xffffffff9a800124:  0f ba e8 0b              btsl     $0xb, %eax
0xffffffff9a800128:  48 0f ba 2d 8f 9f e1 01  btsq     $0x3f, 0x1e19f8f(%rip)
0xffffffff9a800130:  3f
0xffffffff9a800131:  39 d0                    cmpl     %edx, %eax
0xffffffff9a800133:  74 04                    je       0xffffffff9a800139
0xffffffff9a800139:  b8 33 00 05 80           movl     $0x80050033, %eax
0xffffffff9a80013e:  0f 22 c0                 movq     %rax, %cr0
0xffffffff9a800141:  6a 00                    pushq    $0
0xffffffff9a800143:  9d                       popfq    
0xffffffff9a800144:  48 89 f7                 movq     %rsi, %rdi
0xffffffff9a800147:  68 5a 01 80 9a           pushq    $-0x657ffea6
0xffffffff9a80014c:  31 ed                    xorl     %ebp, %ebp
0xffffffff9a80014e:  48 8b 05 cb e4 fa 01     movq     0x1fae4cb(%rip), %rax
0xffffffff9a800155:  6a 10                    pushq    $0x10
0xffffffff9a800157:  50                       pushq    %rax
0xffffffff9a800158:  48 cb                    lretq    
0xffffffff9a86db70:  f3 0f 1e fa              endbr64  
# START wakeup_long64
0xffffffff9a86db74:  48 8b 04 25 90 0a 63 9c  movq     0xffffffff9c630a90, %rax
0xffffffff9a86db7c:  48 ba f0 de bc 9a 78 56  movabsq  $0x123456789abcdef0, %rdx
0xffffffff9a86db84:  34 12
0xffffffff9a86db86:  48 39 d0                 cmpq     %rdx, %rax
0xffffffff9a86db89:  74 0c                    je       0xffffffff9a86db97
0xffffffff9a86db97:  66 b8 18 00              movw     $0x18, %ax
0xffffffff9a86db9b:  8e d0                    movl     %eax, %ss
0xffffffff9a86db9d:  8e d8                    movl     %eax, %ds
0xffffffff9a86db9f:  8e c0                    movl     %eax, %es
0xffffffff9a86dba1:  8e e0                    movl     %eax, %fs
# This clears GS again
0xffffffff9a86dba3:  8e e8                    movl     %eax, %gs
# Processor state after is:
#     RAX=123456789abc0018 RBX=0000000000000000 RCX=00000000c0000080 RDX=123456789abcdef0
#     RSI=0000000000000000 RDI=0000000000000000 RBP=0000000000000000 RSP=ffffffff9cff3fd8
#     R8 =0000000000000000 R9 =0000000000000000 R10=0000000000000000 R11=0000000000000000
#     R12=0000000000000000 R13=0000000000000000 R14=0000000000000000 R15=0000000000000000
#     RIP=ffffffff9a86dba5 RFL=00000046 [---Z-P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
#     ES =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     CS =0010 0000000000000000 ffffffff 00af9b00 DPL=0 CS64 [-RA]
#     SS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     DS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     FS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     GS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
#     TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
#     GDT=     ffff97b9c7a0b000 0000007f
#     IDT=     ffffffff9c604000 000001ff
#     CR0=80050033 CR2=0000000000000000 CR3=0000000002e10000 CR4=000000a0
#     DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
#     DR6=00000000ffff0ff0 DR7=0000000000000400
#     CCS=0000000000000044 CCD=0000000000000000 CCO=EFLAGS
#     EFER=0000000000000d01
0xffffffff9a86dba5:  48 8b 24 25 88 0a 63 9c  movq     0xffffffff9c630a88, %rsp
0xffffffff9a86dbad:  48 8b 1c 25 78 0a 63 9c  movq     0xffffffff9c630a78, %rbx
0xffffffff9a86dbb5:  48 8b 3c 25 70 0a 63 9c  movq     0xffffffff9c630a70, %rdi
0xffffffff9a86dbbd:  48 8b 34 25 68 0a 63 9c  movq     0xffffffff9c630a68, %rsi
0xffffffff9a86dbc5:  48 8b 2c 25 60 0a 63 9c  movq     0xffffffff9c630a60, %rbp
0xffffffff9a86dbcd:  48 8b 04 25 80 0a 63 9c  movq     0xffffffff9c630a80, %rax
0xffffffff9a86dbd5:  ff e0                    jmpq     *%rax
# START `.Lresume_point` in `do_suspend_lowlevel`
0xffffffff9a86dc90:  48 c7 c0 e0 53 0e 9d     movq     $-0x62f1ac20, %rax
0xffffffff9a86dc97:  48 8b 98 e0 00 00 00     movq     0xe0(%rax), %rbx
0xffffffff9a86dc9e:  0f 22 e3                 movq     %rbx, %cr4
0xffffffff9a86dca1:  48 8b 98 d8 00 00 00     movq     0xd8(%rax), %rbx
0xffffffff9a86dca8:  0f 22 db                 movq     %rbx, %cr3
0xffffffff9a86dcab:  48 8b 98 d0 00 00 00     movq     0xd0(%rax), %rbx
0xffffffff9a86dcb2:  0f 22 d3                 movq     %rbx, %cr2
0xffffffff9a86dcb5:  48 8b 98 c8 00 00 00     movq     0xc8(%rax), %rbx
0xffffffff9a86dcbc:  0f 22 c3                 movq     %rbx, %cr0
0xffffffff9a86dcbf:  ff b0 90 00 00 00        pushq    0x90(%rax)
0xffffffff9a86dcc5:  9d                       popfq    
0xffffffff9a86dcc6:  48 8b a0 98 00 00 00     movq     0x98(%rax), %rsp
0xffffffff9a86dccd:  48 8b 68 20              movq     0x20(%rax), %rbp
0xffffffff9a86dcd1:  48 8b 70 68              movq     0x68(%rax), %rsi
0xffffffff9a86dcd5:  48 8b 78 70              movq     0x70(%rax), %rdi
0xffffffff9a86dcd9:  48 8b 58 28              movq     0x28(%rax), %rbx
0xffffffff9a86dcdd:  48 8b 48 58              movq     0x58(%rax), %rcx
0xffffffff9a86dce1:  48 8b 50 60              movq     0x60(%rax), %rdx
0xffffffff9a86dce5:  4c 8b 40 48              movq     0x48(%rax), %r8
0xffffffff9a86dce9:  4c 8b 48 40              movq     0x40(%rax), %r9
0xffffffff9a86dced:  4c 8b 50 38              movq     0x38(%rax), %r10
0xffffffff9a86dcf1:  4c 8b 58 30              movq     0x30(%rax), %r11
0xffffffff9a86dcf5:  4c 8b 60 18              movq     0x18(%rax), %r12
0xffffffff9a86dcf9:  4c 8b 68 10              movq     0x10(%rax), %r13
0xffffffff9a86dcfd:  4c 8b 70 08              movq     8(%rax), %r14
0xffffffff9a86dd01:  4c 8b 38                 movq     (%rax), %r15
0xffffffff9a86dd04:  31 c0                    xorl     %eax, %eax
0xffffffff9a86dd06:  48 83 c4 08              addq     $8, %rsp
# Jumps to `restore_processor_state`
0xffffffff9a86dd0a:  e9 31 ed cb 00           jmp      0xffffffff9b52ca40
0xffffffff9b52ca40:  55                       pushq    %rbp
0xffffffff9b52ca41:  48 89 e5                 movq     %rsp, %rbp
0xffffffff9b52ca44:  41 57                    pushq    %r15
0xffffffff9b52ca46:  41 56                    pushq    %r14
0xffffffff9b52ca48:  41 55                    pushq    %r13
0xffffffff9b52ca4a:  41 54                    pushq    %r12
0xffffffff9b52ca4c:  53                       pushq    %rbx
0xffffffff9b52ca4d:  48 83 ec 20              subq     $0x20, %rsp
0xffffffff9b52ca51:  80 3d c4 8a bb 01 00     cmpb     $0, 0x1bb8ac4(%rip)
0xffffffff9b52ca58:  74 15                    je       0xffffffff9b52ca6f
0xffffffff9b52ca5a:  48 8b 05 67 8a bb 01     movq     0x1bb8a67(%rip), %rax
0xffffffff9b52ca61:  b9 a0 01 00 00           movl     $0x1a0, %ecx
0xffffffff9b52ca66:  48 89 c2                 movq     %rax, %rdx
0xffffffff9b52ca69:  48 c1 ea 20              shrq     $0x20, %rdx
0xffffffff9b52ca6d:  0f 30                    wrmsr    
0xffffffff9b52ca6f:  48 8b 05 6a 8a bb 01     movq     0x1bb8a6a(%rip), %rax
0xffffffff9b52ca76:  b9 80 00 00 c0           movl     $0xc0000080, %ecx
0xffffffff9b52ca7b:  48 89 c2                 movq     %rax, %rdx
0xffffffff9b52ca7e:  48 c1 ea 20              shrq     $0x20, %rdx
0xffffffff9b52ca82:  0f 30                    wrmsr    
0xffffffff9b52ca84:  48 8b 05 35 8a bb 01     movq     0x1bb8a35(%rip), %rax
0xffffffff9b52ca8b:  0f 22 e0                 movq     %rax, %cr4
0xffffffff9b52ca8e:  48 89 05 2b 8a bb 01     movq     %rax, 0x1bb8a2b(%rip)
0xffffffff9b52ca95:  48 8b 05 1c 8a bb 01     movq     0x1bb8a1c(%rip), %rax
0xffffffff9b52ca9c:  0f 22 d8                 movq     %rax, %cr3
0xffffffff9b52ca9f:  48 8b 05 0a 8a bb 01     movq     0x1bb8a0a(%rip), %rax
0xffffffff9b52caa6:  0f 22 d0                 movq     %rax, %cr2
0xffffffff9b52caa9:  48 8b 05 f8 89 bb 01     movq     0x1bb89f8(%rip), %rax
0xffffffff9b52cab0:  0f 22 c0                 movq     %rax, %cr0
0xffffffff9b52cab3:  48 89 05 ee 89 bb 01     movq     %rax, 0x1bb89ee(%rip)
0xffffffff9b52caba:  0f 01 1d 35 8a bb 01     lidtq    0x1bb8a35(%rip)
0xffffffff9b52cac1:  b8 18 00 00 00           movl     $0x18, %eax
0xffffffff9b52cac6:  8e d0                    movl     %eax, %ss
0xffffffff9b52cac8:  b8 2b 00 00 00           movl     $0x2b, %eax
0xffffffff9b52cacd:  89 c2                    movl     %eax, %edx
0xffffffff9b52cacf:  8e da                    movl     %edx, %ds
0xffffffff9b52cad1:  8e c0                    movl     %eax, %es
0xffffffff9b52cad3:  48 8b 05 b6 89 bb 01     movq     0x1bb89b6(%rip), %rax
0xffffffff9b52cada:  b9 01 01 00 c0           movl     $0xc0000101, %ecx
0xffffffff9b52cadf:  48 89 c2                 movq     %rax, %rdx
0xffffffff9b52cae2:  48 c1 ea 20              shrq     $0x20, %rdx
# Restores GS inside `__restore_processor_state`. Processor state after is:
#     RAX=ffff97b9c7a00000 RBX=ffff97b9c5b6be00 RCX=00000000c0000101 RDX=00000000ffff97b9
#     RSI=ffffffffd43c95f9 RDI=0000000000000004 RBP=ffffad4e8062fca0 RSP=ffffad4e8062fc58
#     R8 =0000000000000004 R9 =0000000021bee048 R10=00000000aaaaaaab R11=0000000000000005
#     R12=0000000000000000 R13=0000000000000000 R14=0000000000000004 R15=ffff97b9c5929020
#     RIP=ffffffff9b52cae8 RFL=00000003 [------C] CPL=0 II=0 A20=1 SMM=0 HLT=0
#     ES =002b 0000000000000000 ffffffff 00cff300 DPL=3 DS   [-WA]
#     CS =0010 0000000000000000 ffffffff 00af9b00 DPL=0 CS64 [-RA]
#     SS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     DS =002b 0000000000000000 ffffffff 00cff300 DPL=3 DS   [-WA]
#     FS =0018 0000000000000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     GS =0018 ffff97b9c7a00000 ffffffff 00cf9300 DPL=0 DS   [-WA]
#     LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
#     TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
#     GDT=     ffff97b9c7a0b000 0000007f
#     IDT=     fffffe0000000000 00000fff
#     CR0=80050033 CR2=000000000049304a CR3=0000000005b58000 CR4=000006f0
#     DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
#     DR6=00000000ffff0ff0 DR7=0000000000000400
#     CCS=00000001ffff2f73 CCD=00000000ffff97b9 CCO=SARQ
#     EFER=0000000000000d01
0xffffffff9b52cae6:  0f 30                    wrmsr    
