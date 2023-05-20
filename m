Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F9070A725
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjETKVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjETKVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:21:10 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 262E7189
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 03:21:07 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34KAKMGF027329;
        Sat, 20 May 2023 12:20:22 +0200
Date:   Sat, 20 May 2023 12:20:22 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulmck@kernel.org
Subject: Re: Re: [PATCH 1/2] tools/nolibc: riscv: Fix up load/store
 instructions for rv32
Message-ID: <20230520102022.GA27326@1wt.eu>
References: <20230520093307.GA27287@1wt.eu>
 <20230520100510.31605-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520100510.31605-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 06:05:10PM +0800, Zhangjin Wu wrote:
> > On Sat, May 20, 2023 at 05:11:44PM +0800, Zhangjin Wu wrote:
> > > Hi, Willy
> > > 
> > > This is a full commit message for this patch:
> > > 
> > > When compile for rv32, we got such error:
> > > 
> > > ---
> > > 
> > > nolibc/sysroot/riscv/include/arch.h:190: Error: unrecognized opcode `ld a4,0(a3)'
> > > nolibc/sysroot/riscv/include/arch.h:194: Error: unrecognized opcode `sd a3,%lo(_auxv)(a4)'
> > > nolibc/sysroot/riscv/include/arch.h:196: Error: unrecognized opcode `sd a2,%lo(environ)(a3)'
> > > 
> > > Refer to arch/riscv/include/asm/asm.h and add REG_L/REG_S macros here to let
> > > rv32 use its own lw/sw instructions.
> > > 
> > > ---
> > 
> > That's fine, thank you!
> > 
> > > I will send a new version with the above full message for you, wait for a
> > > while, very sorry ;-)
> > 
> > Don't waste your time resending, I can perfectly take that one and
> > put it into the series.
> >
> 
> Thanks very much, just found the first `---` is in the wrong line, please
> remove the '---' lines manually ;-)
> 
>     When compile nolibc application for rv32, we got such errors:
>     
>     nolibc/sysroot/riscv/include/arch.h:190: Error: unrecognized opcode `ld a4,0(a3)'
>     nolibc/sysroot/riscv/include/arch.h:194: Error: unrecognized opcode `sd a3,%lo(_auxv)(a4)'
>     nolibc/sysroot/riscv/include/arch.h:196: Error: unrecognized opcode `sd a2,%lo(environ)(a3)'
>     
>     Refer to arch/riscv/include/asm/asm.h and add REG_L/REG_S macros here to let
>     rv32 uses its own lw/sw instructions.
> 
> Btw, I wrote some new comments for the 2nd __NR_lseek patch, it is:
> 
>     riscv uses the generic include/uapi/asm-generic/unistd.h, it has code
>     like this:
>     
>         #if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
>         #define __NR_lseek __NR3264_lseek
>         #else
>         #define __NR_llseek __NR3264_lseek
>         #endif
>     
>     There is no __NR_lseek for rv32, use __NR_llseek instead.
>     
>     This code is based on sysdeps/unix/sysv/linux/lseek.c of glibc.

Many thanks, it's indeed better this way.

> The preceeding 4 white spaces are not required for real commit messages.

Sure ;-)

Thanks
willy
