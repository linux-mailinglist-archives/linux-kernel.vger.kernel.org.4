Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C8F70A715
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjETKFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjETKFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:05:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E169AE47
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 03:05:21 -0700 (PDT)
X-QQ-mid: bizesmtp77t1684577113tzgluc37
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 20 May 2023 18:05:12 +0800 (CST)
X-QQ-SSF: 01200000000000C0V000000A0000000
X-QQ-FEAT: 9fp+MOMfZT3nNzi64cDEIKQZuSnUQMcYiosHj/oz5jZi8nbYcnhUm+jT1v6aO
        FU2vhY+7Dzu4qX4YoY/K2ZUCAQUxbmRjCjj5gdy8oxBv/sGdjx21pPUSgARxj7z/gsfs+PF
        Il/v/HmDTS+LzSf/aDwp7ujHBmP/mr4omHuYa55vYs7i7BAbdIkBy0VsuK8XpJmtpiY9+V9
        mBI+4koVjkh7GWZZ6jI2sPyMEPEQcNcynYslQyhJM4KHAGMhNlWo1jlwzuZJYuHsf+CA85O
        teIcmSCYzc4xYZYKwYmtBlIV5nvIu6+jJZqEq2JQD310+D6QtvO8eXraXXMGDViLLn/lHgU
        MIiS+ZovwVIRliavvVjPSEPGYC2Hpae8VNIZdNPfK+jh/7bxxs=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4523727069941875416
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     aou@eecs.berkeley.edu, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@rivosinc.com, paul.walmsley@sifive.com, paulmck@kernel.org
Subject: Re: Re: [PATCH 1/2] tools/nolibc: riscv: Fix up load/store instructions for rv32
Date:   Sat, 20 May 2023 18:05:10 +0800
Message-Id: <20230520100510.31605-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230520093307.GA27287@1wt.eu>
References: <20230520093307.GA27287@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, May 20, 2023 at 05:11:44PM +0800, Zhangjin Wu wrote:
> > Hi, Willy
> > 
> > This is a full commit message for this patch:
> > 
> > When compile for rv32, we got such error:
> > 
> > ---
> > 
> > nolibc/sysroot/riscv/include/arch.h:190: Error: unrecognized opcode `ld a4,0(a3)'
> > nolibc/sysroot/riscv/include/arch.h:194: Error: unrecognized opcode `sd a3,%lo(_auxv)(a4)'
> > nolibc/sysroot/riscv/include/arch.h:196: Error: unrecognized opcode `sd a2,%lo(environ)(a3)'
> > 
> > Refer to arch/riscv/include/asm/asm.h and add REG_L/REG_S macros here to let
> > rv32 use its own lw/sw instructions.
> > 
> > ---
> 
> That's fine, thank you!
> 
> > I will send a new version with the above full message for you, wait for a
> > while, very sorry ;-)
> 
> Don't waste your time resending, I can perfectly take that one and
> put it into the series.
>

Thanks very much, just found the first `---` is in the wrong line, please
remove the '---' lines manually ;-)

    When compile nolibc application for rv32, we got such errors:
    
    nolibc/sysroot/riscv/include/arch.h:190: Error: unrecognized opcode `ld a4,0(a3)'
    nolibc/sysroot/riscv/include/arch.h:194: Error: unrecognized opcode `sd a3,%lo(_auxv)(a4)'
    nolibc/sysroot/riscv/include/arch.h:196: Error: unrecognized opcode `sd a2,%lo(environ)(a3)'
    
    Refer to arch/riscv/include/asm/asm.h and add REG_L/REG_S macros here to let
    rv32 uses its own lw/sw instructions.

Btw, I wrote some new comments for the 2nd __NR_lseek patch, it is:

    riscv uses the generic include/uapi/asm-generic/unistd.h, it has code
    like this:
    
        #if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
        #define __NR_lseek __NR3264_lseek
        #else
        #define __NR_llseek __NR3264_lseek
        #endif
    
    There is no __NR_lseek for rv32, use __NR_llseek instead.
    
    This code is based on sysdeps/unix/sysv/linux/lseek.c of glibc.

The preceeding 4 white spaces are not required for real commit messages.

Best Regards,
Zhangjin Wu

> Thanks!
> Willy
