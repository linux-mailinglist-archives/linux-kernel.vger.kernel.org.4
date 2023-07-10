Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F6874CFBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjGJITU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 04:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjGJISy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:18:54 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C380F171F;
        Mon, 10 Jul 2023 01:17:26 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-579e212668fso60838467b3.1;
        Mon, 10 Jul 2023 01:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688977046; x=1691569046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ddf+hOcnMiZLTkfIYCWGkgO+7MGNJqpDEJg97NUU18=;
        b=WZxHuqLajj9DQ7NqaLlcyBPPoaW7bEKr7NfpU5yTIcMMH2+sXpKN6Grra/eRonZi9j
         wmfpnm0WigXLUqVMQv8tNXLOOU/+wcEgJpFSPvqINqR0TqYwUjyzyloyazB2FhO6MbsF
         fVh7v1jUjqeB1Xy9c2bHlWxaDEZElIrDdwycJNpXo7oPoHNaqj8w0BPH/DuMb34is4JH
         ebLkt7eO/EIZVtYkKCJIwRb7QKiIMC/EK5WdusR7rtQ2WHDSsH4gYaXoNO5aGn5U5n3H
         kp90d60VzScq/7wKnPYfySvjHvZMFCBrkF5tAS0Yx7Ng3xgkahLgG80G6hZRfphUuArB
         s6Fg==
X-Gm-Message-State: ABy/qLZanI8o3mJe9HY0uvA8M+L4K82n/WuBYsQWf2XZ5BBLmglHMcWQ
        CW1PT4ajTDk7d/7eKrn3soocDn9exL36Mg==
X-Google-Smtp-Source: APBJJlEZtbGFtDRf7O5zxXPSBre84Wsat7z+KN/eyXoYrt/Ql1+208OeM6qrktQ0J8p4unYkPtZaEA==
X-Received: by 2002:a0d:d508:0:b0:56d:4d1e:74ab with SMTP id x8-20020a0dd508000000b0056d4d1e74abmr12445526ywd.23.1688977045433;
        Mon, 10 Jul 2023 01:17:25 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id s2-20020a818202000000b0054f50f71834sm2943033ywf.124.2023.07.10.01.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 01:17:23 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-c6e4d4c59bcso3963811276.1;
        Mon, 10 Jul 2023 01:17:23 -0700 (PDT)
X-Received: by 2002:a25:5502:0:b0:bcf:d645:bd9 with SMTP id
 j2-20020a255502000000b00bcfd6450bd9mr9812800ybb.3.1688977042708; Mon, 10 Jul
 2023 01:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230706154520.11257-1-bhe@redhat.com> <20230706154520.11257-12-bhe@redhat.com>
In-Reply-To: <20230706154520.11257-12-bhe@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 10:17:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmv-Jdvi7a04JGXuA2QARj8c8mpUvY7TOcetPkG4pW7A@mail.gmail.com>
Message-ID: <CAMuHMdWmv-Jdvi7a04JGXuA2QARj8c8mpUvY7TOcetPkG4pW7A@mail.gmail.com>
Subject: Re: [PATCH v8 11/19] sh: add <asm-generic/io.h> including
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, arnd@arndb.de, hch@lst.de,
        christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, shorne@gmail.com, David.Laight@aculab.com,
        deller@gmx.de, nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On Thu, Jul 6, 2023 at 5:49 PM Baoquan He <bhe@redhat.com> wrote:
> In <asm-generic/io.h>, it provides a generic implementation of all
> I/O accessors.
>
> For some port|mm io functions, SuperH has its own implementation
> in arch/sh/kernel/iomap.c and arch/sh/include/asm/io_noioport.h.
> These will conflict with those in <asm-generic/io.h> and cause compiling
> error. Hence add macro definitions to ensure that the SuperH version
> of them will override the generic version.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Thanks for your patch, which is now commit edad4470b45298ba ("sh:
add <asm-generic/io.h> including") in next-20230710.

This break dreamcast_defconfig:

  CC      arch/sh/kernel/asm-offsets.s
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:636:15: error: redefinition of ‘inb_p’
  636 | #define inb_p inb_p
      |               ^~~~~
./include/asm-generic/io.h:637:18: note: in expansion of macro ‘inb_p’
  637 | static inline u8 inb_p(unsigned long addr)
      |                  ^~~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:185:25: note: previous definition of
‘inb_p’ with type ‘u8(long unsigned int)’ {aka ‘unsigned char(long
unsigned int)’}
  185 | static inline type pfx##in##bwlq##p(unsigned long port)
         \
      |                         ^~
./arch/sh/include/asm/io.h:199:9: note: in expansion of macro
‘__BUILD_IOPORT_SINGLE’
  199 |         __BUILD_IOPORT_SINGLE(bus, bwlq, type, _p, SLOW_DOWN_IO)
      |         ^~~~~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:202:9: note: in expansion of macro
‘__BUILD_IOPORT_PFX’
  202 |         __BUILD_IOPORT_PFX(, bwlq, type)
      |         ^~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:204:1: note: in expansion of macro ‘BUILDIO_IOPORT’
  204 | BUILDIO_IOPORT(b, u8)
      | ^~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:644:15: error: redefinition of ‘inw_p’
  644 | #define inw_p inw_p
      |               ^~~~~
./include/asm-generic/io.h:645:19: note: in expansion of macro ‘inw_p’
  645 | static inline u16 inw_p(unsigned long addr)
      |                   ^~~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:185:25: note: previous definition of
‘inw_p’ with type ‘u16(long unsigned int)’ {aka ‘short unsigned
int(long unsigned int)’}
  185 | static inline type pfx##in##bwlq##p(unsigned long port)
         \
      |                         ^~
./arch/sh/include/asm/io.h:199:9: note: in expansion of macro
‘__BUILD_IOPORT_SINGLE’
  199 |         __BUILD_IOPORT_SINGLE(bus, bwlq, type, _p, SLOW_DOWN_IO)
      |         ^~~~~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:202:9: note: in expansion of macro
‘__BUILD_IOPORT_PFX’
  202 |         __BUILD_IOPORT_PFX(, bwlq, type)
      |         ^~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:205:1: note: in expansion of macro ‘BUILDIO_IOPORT’
  205 | BUILDIO_IOPORT(w, u16)
      | ^~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:652:15: error: redefinition of ‘inl_p’
  652 | #define inl_p inl_p
      |               ^~~~~
./include/asm-generic/io.h:653:19: note: in expansion of macro ‘inl_p’
  653 | static inline u32 inl_p(unsigned long addr)
      |                   ^~~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:185:25: note: previous definition of
‘inl_p’ with type ‘u32(long unsigned int)’ {aka ‘unsigned int(long
unsigned int)’}
  185 | static inline type pfx##in##bwlq##p(unsigned long port)
         \
      |                         ^~
./arch/sh/include/asm/io.h:199:9: note: in expansion of macro
‘__BUILD_IOPORT_SINGLE’
  199 |         __BUILD_IOPORT_SINGLE(bus, bwlq, type, _p, SLOW_DOWN_IO)
      |         ^~~~~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:202:9: note: in expansion of macro
‘__BUILD_IOPORT_PFX’
  202 |         __BUILD_IOPORT_PFX(, bwlq, type)
      |         ^~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:206:1: note: in expansion of macro ‘BUILDIO_IOPORT’
  206 | BUILDIO_IOPORT(l, u32)
      | ^~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:660:16: error: redefinition of ‘outb_p’
  660 | #define outb_p outb_p
      |                ^~~~~~
./include/asm-generic/io.h:661:20: note: in expansion of macro ‘outb_p’
  661 | static inline void outb_p(u8 value, unsigned long addr)
      |                    ^~~~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:176:25: note: previous definition of
‘outb_p’ with type ‘void(u8,  long unsigned int)’ {aka ‘void(unsigned
char,  long unsigned int)’}
  176 | static inline void pfx##out##bwlq##p(type val, unsigned long
port)      \
      |                         ^~~
./arch/sh/include/asm/io.h:199:9: note: in expansion of macro
‘__BUILD_IOPORT_SINGLE’
  199 |         __BUILD_IOPORT_SINGLE(bus, bwlq, type, _p, SLOW_DOWN_IO)
      |         ^~~~~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:202:9: note: in expansion of macro
‘__BUILD_IOPORT_PFX’
  202 |         __BUILD_IOPORT_PFX(, bwlq, type)
      |         ^~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:204:1: note: in expansion of macro ‘BUILDIO_IOPORT’
  204 | BUILDIO_IOPORT(b, u8)
      | ^~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:668:16: error: redefinition of ‘outw_p’
  668 | #define outw_p outw_p
      |                ^~~~~~
./include/asm-generic/io.h:669:20: note: in expansion of macro ‘outw_p’
  669 | static inline void outw_p(u16 value, unsigned long addr)
      |                    ^~~~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:176:25: note: previous definition of
‘outw_p’ with type ‘void(u16,  long unsigned int)’ {aka ‘void(short
unsigned int,  long unsigned int)’}
  176 | static inline void pfx##out##bwlq##p(type val, unsigned long
port)      \
      |                         ^~~
./arch/sh/include/asm/io.h:199:9: note: in expansion of macro
‘__BUILD_IOPORT_SINGLE’
  199 |         __BUILD_IOPORT_SINGLE(bus, bwlq, type, _p, SLOW_DOWN_IO)
      |         ^~~~~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:202:9: note: in expansion of macro
‘__BUILD_IOPORT_PFX’
  202 |         __BUILD_IOPORT_PFX(, bwlq, type)
      |         ^~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:205:1: note: in expansion of macro ‘BUILDIO_IOPORT’
  205 | BUILDIO_IOPORT(w, u16)
      | ^~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:676:16: error: redefinition of ‘outl_p’
  676 | #define outl_p outl_p
      |                ^~~~~~
./include/asm-generic/io.h:677:20: note: in expansion of macro ‘outl_p’
  677 | static inline void outl_p(u32 value, unsigned long addr)
      |                    ^~~~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:176:25: note: previous definition of
‘outl_p’ with type ‘void(u32,  long unsigned int)’ {aka ‘void(unsigned
int,  long unsigned int)’}
  176 | static inline void pfx##out##bwlq##p(type val, unsigned long
port)      \
      |                         ^~~
./arch/sh/include/asm/io.h:199:9: note: in expansion of macro
‘__BUILD_IOPORT_SINGLE’
  199 |         __BUILD_IOPORT_SINGLE(bus, bwlq, type, _p, SLOW_DOWN_IO)
      |         ^~~~~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:202:9: note: in expansion of macro
‘__BUILD_IOPORT_PFX’
  202 |         __BUILD_IOPORT_PFX(, bwlq, type)
      |         ^~~~~~~~~~~~~~~~~~
./arch/sh/include/asm/io.h:206:1: note: in expansion of macro ‘BUILDIO_IOPORT’
  206 | BUILDIO_IOPORT(l, u32)
      | ^~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:689:14: error: redefinition of ‘insb’
  689 | #define insb insb
      |              ^~~~
./include/asm-generic/io.h:690:20: note: in expansion of macro ‘insb’
  690 | static inline void insb(unsigned long addr, void *buffer,
unsigned int count)
      |                    ^~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:222:20: note: previous definition of ‘insb’
with type ‘void(long unsigned int,  void *, unsigned int)’
  222 | static inline void ins##bwlq(unsigned long port, void *addr,
         \
      |                    ^~~
./arch/sh/include/asm/io.h:233:1: note: in expansion of macro
‘__BUILD_IOPORT_STRING’
  233 | __BUILD_IOPORT_STRING(b, u8)
      | ^~~~~~~~~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:697:14: error: redefinition of ‘insw’
  697 | #define insw insw
      |              ^~~~
./include/asm-generic/io.h:698:20: note: in expansion of macro ‘insw’
  698 | static inline void insw(unsigned long addr, void *buffer,
unsigned int count)
      |                    ^~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:222:20: note: previous definition of ‘insw’
with type ‘void(long unsigned int,  void *, unsigned int)’
  222 | static inline void ins##bwlq(unsigned long port, void *addr,
         \
      |                    ^~~
./arch/sh/include/asm/io.h:234:1: note: in expansion of macro
‘__BUILD_IOPORT_STRING’
  234 | __BUILD_IOPORT_STRING(w, u16)
      | ^~~~~~~~~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:705:14: error: redefinition of ‘insl’
  705 | #define insl insl
      |              ^~~~
./include/asm-generic/io.h:706:20: note: in expansion of macro ‘insl’
  706 | static inline void insl(unsigned long addr, void *buffer,
unsigned int count)
      |                    ^~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:222:20: note: previous definition of ‘insl’
with type ‘void(long unsigned int,  void *, unsigned int)’
  222 | static inline void ins##bwlq(unsigned long port, void *addr,
         \
      |                    ^~~
./arch/sh/include/asm/io.h:235:1: note: in expansion of macro
‘__BUILD_IOPORT_STRING’
  235 | __BUILD_IOPORT_STRING(l, u32)
      | ^~~~~~~~~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:713:15: error: redefinition of ‘outsb’
  713 | #define outsb outsb
      |               ^~~~~
./include/asm-generic/io.h:714:20: note: in expansion of macro ‘outsb’
  714 | static inline void outsb(unsigned long addr, const void *buffer,
      |                    ^~~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:211:20: note: previous definition of
‘outsb’ with type ‘void(long unsigned int,  const void *, unsigned
int)’
  211 | static inline void outs##bwlq(unsigned long port, const void
*addr,     \
      |                    ^~~~
./arch/sh/include/asm/io.h:233:1: note: in expansion of macro
‘__BUILD_IOPORT_STRING’
  233 | __BUILD_IOPORT_STRING(b, u8)
      | ^~~~~~~~~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:722:15: error: redefinition of ‘outsw’
  722 | #define outsw outsw
      |               ^~~~~
./include/asm-generic/io.h:723:20: note: in expansion of macro ‘outsw’
  723 | static inline void outsw(unsigned long addr, const void *buffer,
      |                    ^~~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:211:20: note: previous definition of
‘outsw’ with type ‘void(long unsigned int,  const void *, unsigned
int)’
  211 | static inline void outs##bwlq(unsigned long port, const void
*addr,     \
      |                    ^~~~
./arch/sh/include/asm/io.h:234:1: note: in expansion of macro
‘__BUILD_IOPORT_STRING’
  234 | __BUILD_IOPORT_STRING(w, u16)
      | ^~~~~~~~~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:731:15: error: redefinition of ‘outsl’
  731 | #define outsl outsl
      |               ^~~~~
./include/asm-generic/io.h:732:20: note: in expansion of macro ‘outsl’
  732 | static inline void outsl(unsigned long addr, const void *buffer,
      |                    ^~~~~
In file included from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./arch/sh/include/asm/io.h:211:20: note: previous definition of
‘outsl’ with type ‘void(long unsigned int,  const void *, unsigned
int)’
  211 | static inline void outs##bwlq(unsigned long port, const void
*addr,     \
      |                    ^~~~
./arch/sh/include/asm/io.h:235:1: note: in expansion of macro
‘__BUILD_IOPORT_STRING’
  235 | __BUILD_IOPORT_STRING(l, u32)
      | ^~~~~~~~~~~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:1111:20: error: static declaration of
‘ioport_map’ follows non-static declaration
 1111 | #define ioport_map ioport_map
      |                    ^~~~~~~~~~
./include/asm-generic/io.h:1112:29: note: in expansion of macro ‘ioport_map’
 1112 | static inline void __iomem *ioport_map(unsigned long port,
unsigned int nr)
      |                             ^~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:22,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/iomap.h:92:22: note: previous declaration of
‘ioport_map’ with type ‘void *(long unsigned int,  unsigned int)’
   92 | extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
      |                      ^~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:290,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:1121:22: error: static declaration of
‘ioport_unmap’ follows non-static declaration
 1121 | #define ioport_unmap ioport_unmap
      |                      ^~~~~~~~~~~~
./include/asm-generic/io.h:1122:20: note: in expansion of macro ‘ioport_unmap’
 1122 | static inline void ioport_unmap(void __iomem *p)
      |                    ^~~~~~~~~~~~
In file included from ./arch/sh/include/asm/io.h:22,
                 from ./include/linux/io.h:13,
                 from ./include/linux/irq.h:20,
                 from ./include/asm-generic/hardirq.h:17,
                 from ./arch/sh/include/asm/hardirq.h:9,
                 from ./include/linux/hardirq.h:11,
                 from ./include/linux/interrupt.h:11,
                 from ./include/linux/kernel_stat.h:9,
                 from ./include/linux/cgroup.h:26,
                 from ./include/linux/memcontrol.h:13,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/iomap.h:93:13: note: previous declaration of
‘ioport_unmap’ with type ‘void(void *)’
   93 | extern void ioport_unmap(void __iomem *);
      |             ^~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:116: arch/sh/kernel/asm-offsets.s] Error 1
make[1]: *** [Makefile:1275: prepare0] Error 2
make: *** [Makefile:234: __sub-make] Error 2

> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -119,6 +119,26 @@ void __raw_readsl(const void __iomem *addr, void *data, int longlen);
>
>  __BUILD_MEMORY_STRING(__raw_, q, u64)
>
> +#define ioread8 ioread8
> +#define ioread16 ioread16
> +#define ioread16be ioread16be
> +#define ioread32 ioread32
> +#define ioread32be ioread32be
> +
> +#define iowrite8 iowrite8
> +#define iowrite16 iowrite16
> +#define iowrite16be iowrite16be
> +#define iowrite32 iowrite32
> +#define iowrite32be iowrite32be
> +
> +#define ioread8_rep ioread8_rep
> +#define ioread16_rep ioread16_rep
> +#define ioread32_rep ioread32_rep
> +
> +#define iowrite8_rep iowrite8_rep
> +#define iowrite16_rep iowrite16_rep
> +#define iowrite32_rep iowrite32_rep
> +
>  #ifdef CONFIG_HAS_IOPORT_MAP
>
>  /*
> @@ -225,6 +245,9 @@ __BUILD_IOPORT_STRING(q, u64)
>  #define IO_SPACE_LIMIT 0xffffffff
>
>  /* We really want to try and get these to memcpy etc */
> +#define memset_io memset_io
> +#define memcpy_fromio memcpy_fromio
> +#define memcpy_toio memcpy_toio
>  void memcpy_fromio(void *, const volatile void __iomem *, unsigned long);
>  void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
>  void memset_io(volatile void __iomem *, int, unsigned long);
> @@ -287,6 +310,8 @@ static inline void iounmap(volatile void __iomem *addr) { }
>   */
>  #define xlate_dev_mem_ptr(p)   __va(p)
>
> +#include <asm-generic/io.h>
> +
>  #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
>  int valid_phys_addr_range(phys_addr_t addr, size_t size);
>  int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
> diff --git a/arch/sh/include/asm/io_noioport.h b/arch/sh/include/asm/io_noioport.h
> index f7938fe0f911..5ba4116b4265 100644
> --- a/arch/sh/include/asm/io_noioport.h
> +++ b/arch/sh/include/asm/io_noioport.h
> @@ -53,6 +53,13 @@ static inline void ioport_unmap(void __iomem *addr)
>  #define outw_p(x, addr)        outw((x), (addr))
>  #define outl_p(x, addr)        outl((x), (addr))
>
> +#define insb insb
> +#define insw insw
> +#define insl insl
> +#define outsb outsb
> +#define outsw outsw
> +#define outsl outsl
> +
>  static inline void insb(unsigned long port, void *dst, unsigned long count)
>  {
>         BUG();
> --
> 2.34.1
>


-- 
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
