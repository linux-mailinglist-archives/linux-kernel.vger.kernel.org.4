Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B4611995
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJ1RqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJ1Rp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:45:58 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A716515F900
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V+Axcy5zdoBEOZ+Nw3P3R1gZbgaXg9G1Yir4dUmAh18=; b=Ttc7FPYRXWMnyvfGJ9H2+NZqiJ
        /CgNy7aJiWdbFfLjL09R44ThPXRXbV/tgpH+YldVXsUodxao44xiHzb0ANXXjPIN9dm5rTeiJyjQy
        qQH3hgTQ2f1J3QYnEi/ydcjjGlZSpd60FrhYbhyZSS1NHhFY1ntbAB8IyN8kYIaopu5l1wvWNnih3
        hpQ0UvqyfUdx6PqumzZ/AMsnCZsqqP/UP6b9TmiHTU60mJs0gGZycJgJhE9EJgNcIM2Rf6pAgHer7
        li8rAjGLli+qmVfN0MiX/+2TrwpHIPFxR26Oq5NaDWWFqS7wiBQQc2MSQKx56JW1BeAczoz99H4iW
        3xm100Tg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35012)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ooTQX-0000Er-1k; Fri, 28 Oct 2022 18:45:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ooTQU-0002kc-C2; Fri, 28 Oct 2022 18:45:50 +0100
Date:   Fri, 28 Oct 2022 18:45:50 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] ARM: findbit: document ARMv5 bit offset calculation
Message-ID: <Y1wVTkIZjoMVfxOK@shell.armlinux.org.uk>
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
 <E1ooSWP-000FDy-5t@rmk-PC.armlinux.org.uk>
 <CAHk-=wi63Sw3vNJ86gzg1Tdr=_xGwGyj+mH-eT0UgaAfGAHX+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi63Sw3vNJ86gzg1Tdr=_xGwGyj+mH-eT0UgaAfGAHX+A@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:05:29AM -0700, Linus Torvalds wrote:
> On Fri, Oct 28, 2022 at 9:47 AM Russell King (Oracle)
> <rmk+kernel@armlinux.org.uk> wrote:
> >
> > Document the ARMv5 bit offset calculation code.
> 
> Hmm. Don't the generic bitop functions end up using this? We do have a
> comment in the code that says
> 
>  * On ARMv5 and above, the gcc built-ins may rely on the clz instruction
>  * and produce optimal inlined code in all cases. On ARMv7 it is even
>  * better by also using the rbit instruction.

It's true that the generic code also makes use of the rbit and clz
instructions - but in terms of the speed of the functions these only
get used once we've found a word that is interesting to locate the
bit we want in.

> but that 'may' makes me wonder...
> 
> IOW, what is it in the hand-written code that doesn't get done by the
> generic code these days?

For the _find_first_bit, there isn't much difference in the number
of instructions or really what is going on, only the organisation
and flow of the code is more inline - but that shouldn't make much
of a difference. Yet, there is a definite repeatable measurable
difference between the two:

random-filled:
arm    : find_first_bit:               17778911 ns,  16448 iterations
generic: find_first_bit:               18596622 ns,  16401 iterations

sparse:
arm    : find_first_bit:                7301363 ns,    656 iterations
generic: find_first_bit:                7589120 ns,    655 iterations

The bigger difference is in the find_next_bit operations, and this
likely comes from the arm32 code not having the hassles of the "_and"
and other conditionals that the generic code has:

random-filled:
arm    : find_next_bit:                 2242618 ns, 163949 iterations
generic: find_next_bit:                 2632859 ns, 163743 iterations

sparse:
arm    : find_next_bit:                   40078 ns,    656 iterations
generic: find_next_bit:                   69943 ns,    655 iterations

find_next_zero_bit show a greater difference:

random-filled:
arm    : find_next_zero_bit:            2049129 ns, 163732 iterations
generic: find_next_zero_bit:            2844221 ns, 163938 iterations

sparse:
arm    : find_next_zero_bit:            3939309 ns, 327025 iterations
generic: find_next_zero_bit:            5529553 ns, 327026 iterations

Here's the disassemblies for comparison. Note that the arm versions
share code paths between the functions which makes the code even more
compact - so the loop in the find_first gets re-used for find_next
after we check the current word.

generic:

00000000 <_find_first_bit>:
   0:   e1a02000        mov     r2, r0
   4:   e2510000        subs    r0, r1, #0
   8:   012fff1e        bxeq    lr
   c:   e2422004        sub     r2, r2, #4
  10:   e3a03000        mov     r3, #0
  14:   ea000002        b       24 <_find_first_bit+0x24>
  18:   e2833020        add     r3, r3, #32
  1c:   e1500003        cmp     r0, r3
  20:   912fff1e        bxls    lr
  24:   e5b2c004        ldr     ip, [r2, #4]!
  28:   e35c0000        cmp     ip, #0
  2c:   0afffff9        beq     18 <_find_first_bit+0x18>
  30:   e6ffcf3c        rbit    ip, ip
  34:   e16fcf1c        clz     ip, ip
  38:   e08c3003        add     r3, ip, r3
  3c:   e1500003        cmp     r0, r3
  40:   21a00003        movcs   r0, r3
  44:   e12fff1e        bx      lr

000000e8 <_find_next_bit>:
  e8:   e92d4070        push    {r4, r5, r6, lr}
  ec:   e1530002        cmp     r3, r2
  f0:   e59d4010        ldr     r4, [sp, #16]
  f4:   e59d5014        ldr     r5, [sp, #20]
  f8:   2a000024        bcs     190 <_find_next_bit+0xa8>
  fc:   e1a0e2a3        lsr     lr, r3, #5
 100:   e3510000        cmp     r1, #0
 104:   e203601f        and     r6, r3, #31
 108:   e3c3301f        bic     r3, r3, #31
 10c:   e790c10e        ldr     ip, [r0, lr, lsl #2]
 110:   1791e10e        ldrne   lr, [r1, lr, lsl #2]
 114:   100cc00e        andne   ip, ip, lr
 118:   e3e0e000        mvn     lr, #0
 11c:   e02cc004        eor     ip, ip, r4
 120:   e3550000        cmp     r5, #0
 124:   e1a0e61e        lsl     lr, lr, r6
 128:   1a00001a        bne     198 <_find_next_bit+0xb0>
 12c:   e01cc00e        ands    ip, ip, lr
 130:   1a000011        bne     17c <_find_next_bit+0x94>
 134:   e2833020        add     r3, r3, #32
 138:   e1530002        cmp     r3, r2
 13c:   3a000003        bcc     150 <_find_next_bit+0x68>
 140:   ea000012        b       190 <_find_next_bit+0xa8>
 144:   e2833020        add     r3, r3, #32
 148:   e1520003        cmp     r2, r3
 14c:   9a00000f        bls     190 <_find_next_bit+0xa8>
 150:   e1a0e2a3        lsr     lr, r3, #5
 154:   e3510000        cmp     r1, #0
 158:   e790c10e        ldr     ip, [r0, lr, lsl #2]
 15c:   1791e10e        ldrne   lr, [r1, lr, lsl #2]
 160:   100cc00e        andne   ip, ip, lr
 164:   e15c0004        cmp     ip, r4
 168:   0afffff5        beq     144 <_find_next_bit+0x5c>
 16c:   e02cc004        eor     ip, ip, r4
 170:   e3550000        cmp     r5, #0
 174:   0a000000        beq     17c <_find_next_bit+0x94>
 178:   e6bfcf3c        rev     ip, ip
 17c:   e6ffcf3c        rbit    ip, ip
 180:   e16fcf1c        clz     ip, ip
 184:   e08c3003        add     r3, ip, r3
 188:   e1520003        cmp     r2, r3
 18c:   21a02003        movcs   r2, r3
 190:   e1a00002        mov     r0, r2
 194:   e8bd8070        pop     {r4, r5, r6, pc}
 198:   e6bfef3e        rev     lr, lr
 19c:   e01cc00e        ands    ip, ip, lr
 1a0:   0affffe3        beq     134 <_find_next_bit+0x4c>
 1a4:   eafffff3        b       178 <_find_next_bit+0x90>

==========
arm optimised:

00000060 <_find_first_bit_le>:
  60:   e3310000        teq     r1, #0
  64:   0a000006        beq     84 <_find_first_bit_le+0x24>
  68:   e3a02000        mov     r2, #0
  6c:   e4903004        ldr     r3, [r0], #4
  70:   e1b03003        movs    r3, r3
  74:   1a000011        bne     c0 <_find_next_bit_le+0x34>
  78:   e2822020        add     r2, r2, #32
  7c:   e1520001        cmp     r2, r1
  80:   3afffff9        bcc     6c <_find_first_bit_le+0xc>
  84:   e1a00001        mov     r0, r1
  88:   e12fff1e        bx      lr

0000008c <_find_next_bit_le>:
  8c:   e1520001        cmp     r2, r1
  90:   2afffffb        bcs     84 <_find_first_bit_le+0x24>
  94:   e1a0c2a2        lsr     ip, r2, #5
  98:   e080010c        add     r0, r0, ip, lsl #2
  9c:   e212c01f        ands    ip, r2, #31
  a0:   0afffff1        beq     6c <_find_first_bit_le+0xc>
  a4:   e4903004        ldr     r3, [r0], #4
  a8:   e1b03c33        lsrs    r3, r3, ip
  ac:   1a000003        bne     c0 <_find_next_bit_le+0x34>
  b0:   e382201f        orr     r2, r2, #31
  b4:   e2822001        add     r2, r2, #1
  b8:   eaffffef        b       7c <_find_first_bit_le+0x1c>
  bc:   e6bf3f33        rev     r3, r3
  c0:   e6ff3f33        rbit    r3, r3
  c4:   e16f3f13        clz     r3, r3
  c8:   e0820003        add     r0, r2, r3
  cc:   e1510000        cmp     r1, r0
  d0:   31a00001        movcc   r0, r1
  d4:   e12fff1e        bx      lr

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
