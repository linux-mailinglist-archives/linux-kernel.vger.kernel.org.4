Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACAE69EED1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 07:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjBVGkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 01:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBVGkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 01:40:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F4034C33
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 22:40:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so812514pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 22:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9L0mH+e4qGXynwfcfo7mfSRluQF/M6jwhm1ScZI2Yk=;
        b=E/7txbfN1aKxEm1l3tyXuKGDNBWM/14U+I2b3FLilbVnH/07gtGIlDzcnsOlR9szYc
         7h9unIj6fskGPkOspbqmvvddUGXVZsQVX+b3VHY260Lybyp1SE39CIaHEBcuH8Xc45ou
         v/Xaz2TXbn/j2GZKcvqM4PzusnyEVMdmBbeTqMGS2ePSPGC9M8t++qJ08Ixf/0PGdGkG
         z34oT5lla+coDJ/pfy9/lVIUUioAw9BP+2uW0iPQiQQYqRQ6rUEKA926Odi7v1pQ0vJh
         mOadYSHjaHcFKnZ7B417nNts8mzJgyAdwIt5oRsJXLcEmVv6sC1s7rrZUroD+IkJJsTA
         341Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9L0mH+e4qGXynwfcfo7mfSRluQF/M6jwhm1ScZI2Yk=;
        b=NkmCsx/18g5zDk1cmIlrqRiO52FbrpvQA8gRBzKkFsaXaMZuta4yAg9ddoI8VsmZI3
         sM0G4evZuRdylFUgJGjvkPUV0IdC91sl6y+RE1mdBXQZWCLG5BQCjD6oQM+ufXRyxt+j
         q2DkMi4F/IpOi0YBO021X1QhME9zHoUV6cTBaBmKBquQ2pbGKcZNuki5ZAAeGwViJLLU
         UhO2tItwlREPd5TgSCdzDtCzqLdIVjUQSoFMSCLfjSlfM7QdtN9c33Q5BgduHJWe/cK1
         2tbbibjYcMps93hUdRl38Ur5oJH6cJR1cppwLGi+3KrV7VP0nsrm7g+7i8L2+DfAFOfT
         tbtA==
X-Gm-Message-State: AO0yUKU7REAAPFckE/KwqwxbmdAsBJhvMf1ECNeCBIYgHcf0wG+ThI6o
        TOPyJCRU2HoPHfeqbly8OdECJytCPUeq/A==
X-Google-Smtp-Source: AK7set/WCTgLw/l7qwIez8Tm1S//HU4sfklD/3oKTx2m7C3UwAx5kzT7Evmfe81Q555sBzcaTcWxpA==
X-Received: by 2002:a05:6a21:329c:b0:c7:2c6c:b37a with SMTP id yt28-20020a056a21329c00b000c72c6cb37amr9263580pzb.13.1677048009040;
        Tue, 21 Feb 2023 22:40:09 -0800 (PST)
Received: from thinkstation.cmpxchg8b.net ([76.133.164.192])
        by smtp.gmail.com with ESMTPSA id y186-20020a638ac3000000b00476d1385265sm4187923pgd.25.2023.02.21.22.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 22:40:08 -0800 (PST)
Date:   Tue, 21 Feb 2023 22:40:07 -0800
From:   Tavis Ormandy <taviso@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org
Subject: x86: AMD Zen2 ymm registers rolling back
Message-ID: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FomKkfK23h1eei7S"
Content-Disposition: inline
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FomKkfK23h1eei7S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, I'm experiencing a serious bug on AMD Zen2 that is causing
registers to "roll back" to previous values after a context switch.

I know that sounds unbelievable - but I have a reliable reproducer!

$ grep -m1 'model name' /proc/cpuinfo
model name : AMD Ryzen Threadripper PRO 3945WX 12-Cores

The bug occurs when there is a context switch after a ucomiss
instruction. The YMM registers are "rolled back" to some previous state.

It's not clear to me how or why this is happening, or if it can happen
across a process boundary.

To reproduce:

$ nasm -felf64 -O0 zenymmasm.asm
$ ld -o zenymmasm zenymmasm.o

If you run it it should just print some nuls:

$ ./zenymmasm
$

That is the expected, correct result.

However, if you run the attached program hammer.c (it just runs
sched_yield() in a loop), and then pin this testcase to the same core as
that:

$ taskset -c 1 ./zenymmasm
SECRETSECRET

The previous register values are restored.

I think this should be impossible.

The code does this:

    vmovdqu         ymm0, [rel secret]      <--- put SECRET into ymm0
    mov             rax, SYS_sched_yield
    syscall
    vpxor           ymm0, ymm0, ymm0        <--- Here the value of ymm0 should be lost

It's not related to to VPXOR, you can use VZEROALL or whatever else.

    ucomiss         xmm0, dword [rel space]
    mov             rax, SYS_sched_yield
    syscall

It's the UCOMISS r128,m32 instruction that triggers the bug, the value
of the m32 must be < 0x80000. As far as I know, this should only ever
change condition flags, but if we dump the value of ymm0:

    mov             rax, SYS_write
    mov             rdi, 1
    lea             rsi, [rel regstate]
    mov             rdx, 32
    syscall

It will have reverted back to the pre-vpxor SECRET value !?!?

In the original C program, we were seeing register values randomly
restored from significantly earlier in the program execution (like, from
ld.so), sometimes values we don't recognize and can't explain.

We've reproduced on multiple Zen2 machines.

Obviously, not great if your registers are randomly time travelling :)

Thanks, Tavis.

-- 
 _o)            $ lynx lock.cmpxchg8b.com
 /\\  _o)  _o)  $ finger taviso@sdf.org
_\_V _( ) _( )  @taviso

--FomKkfK23h1eei7S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hammer.c"

#define _GNU_SOURCE
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <stdbool.h>
#include <sched.h>
#include <syscall.h>
#include <x86intrin.h>
#include <sys/random.h>

#include <err.h>

int main(int argc, char **argv)
{
    cpu_set_t set;

    CPU_ZERO(&set);
    CPU_SET(1, &set);

    if (sched_setaffinity(0, sizeof(set), &set) != 0) {
        err(EXIT_FAILURE, "failed to set cpu affinity");
    }

    while (true) {
        asm volatile ("syscall" :: "a"(SYS_sched_yield) : "rcx", "r11");
    }

    return 0;
}

--FomKkfK23h1eei7S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="zenymmasm.asm"

BITS 64

global _start

%define SYS_sched_yield 0x18
%define SYS_write 0x01
%define SYS_exit 0x3c

section .data
    align 32
    secret:     times 4 dq 'SECRET'
    align 32
    regstate:   dq 0,0,0,0
    align 32
    space:      dd 1
section .text
_start:
    vmovdqu         ymm0, [rel secret]
    mov             rax, SYS_sched_yield
    syscall
    vpxor           ymm0, ymm0, ymm0
    mov             rax, SYS_sched_yield
    syscall
    ucomiss         xmm0, dword [rel space]
    mov             rax, SYS_sched_yield
    syscall
    vmovdqu         [rel regstate], ymm0
    mov             rax, SYS_write
    mov             rdi, 1
    lea             rsi, [rel regstate]
    mov             rdx, 32
    syscall
    mov             rax, SYS_exit
    mov             rdi, 0
    syscall
    int3

--FomKkfK23h1eei7S--
