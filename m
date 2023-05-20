Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD3C70A885
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 16:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjETOcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 10:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 10:32:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6B109
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 07:32:03 -0700 (PDT)
X-QQ-mid: bizesmtp66t1684593116t2c0umov
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 20 May 2023 22:31:54 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: RmDZc/K2LPEPOHsJ1JSKHHcUPDqD0No37nsGY5eqpO6LGzdOd94mh4Wd/weQ4
        cRb1gzcYjFdZnWMwKzupL3vpcbPcf7Z4rUwiCAjk3gZTbFQpkGr+jyC6yLIc97CzZUjax6s
        5kwcGgCFfenBkl6Oc2fxkuBxF+xxfX8QhT8l6XdccQO9wGQLPBMMmeqR1olBaqac7Jzjbhh
        4EzJEtwIzh1blSAYvkTuR1xReUHj5yFNsvcW/KzHnONxV0HeIZkzqMQ8R0YtzANctNba4/v
        /DEtjWi1bITZ7IfaNGFWT/mjEZMWT9oumz6JhzLTemftEGwTBbupnZWwaXdQU+L5Szq4wWn
        Jree7y5SH5J0CUj5Jkv1izDnQnZQvaaoTyTQb744yuZD4yXzR+yUtnkqFxk8Q==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16622545413430521310
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     aou@eecs.berkeley.edu, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulmck@kernel.org
Subject: Re: [PATCH 0/2] tools/nolibc: riscv: Fix up compile error for rv32
Date:   Sat, 20 May 2023 22:31:54 +0800
Message-Id: <20230520143154.68663-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519094030.GA24947@1wt.eu>
References: <20230519094030.GA24947@1wt.eu>
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

Hi Willy,

> Hi Zhangjin,
> 
> On Fri, May 19, 2023 at 01:00:18AM +0800, Zhangjin Wu wrote:
> ...
>
> > * To let it compile for rv32, we still need to apply one of such actions:
> >     * Revert the kernel commit d4c08b9776b3 ("riscv: Use latest system call ABI"),
> >       but it is not the right direction, that commit has removed all of the time32 syscalls,
> >       and let C lib (e.g. glibc) provide the same C APIs based on the other time64 syscalls
> > 
> >     * If not really use any of the time32 syscalls, defining __ARCH_WANT_TIME32_SYSCALLS
> >       macro will let it compile, but this is buggy for the current implmentations are based
> >       on time32 syscalls!
> > 
> >     * Really implement the C APIs for rv32, based on the time64 syscalls, just like glibc.
> >       This commit c8ce48f06503 ("asm-generic: Make time32 syscall numbers optional") shows
> >       us which functions should be re-implemented.
> > 
> > So, the work todo for rv32 is:
> > 
> > * Rebasing all of the old time32 syscalls based C APIs on the new time64 syscalls,
> >   but they are not simply mapped one by one, glibc is a good reference.
> > 
> > * Add standalone rv32 test support in tools/testing/selftests/nolibc/
> 
> I'm not the right one to judge how to best support rv32 but at least I just
> don't want to go backwards. I'm just having a probably stupid question, but
> how relevant is rv32 ? I mean, all the boards I've seen to date were based
> on rv64 even the smallest embedded ones, so I'm sincerely wondering if there
> exists at all any rv32 devices capable of running Linux. Because if that's
> not the case, maybe we should instead declare that we only support rv64 ?
> If such devices exist however, I'm all for us supporting them well.
>

Firstly, as the commit c8ce48f06503 ("asm-generic: Make time32 syscall
numbers optional") shows:

    We don't want new architectures to even provide the old 32-bit time_t
    based system calls any more, or define the syscall number macros.

So, this is not rv32 specific, more and more architectures are trying to
use the generic unistd.h (include/uapi/asm-generic/unistd.h), but rv32
may be the first new architecture variant who have no time32 syscalls.

Second, I did search some rv32 socs/boards from two companies, they are
bl602/bl616/bl702, esp32-c2/c3/c6, some of them even have 532KB sRAM which is
enough for nolibc-based app + linux kernel, I have gotten 334K rv64 vmlinuz
(+nolibc hello.c) in the tinylinux work for riscv, the future work may be
running linux on such a real rv32 board ;-)

Best regards,
Zhangjin Wu

> Thanks,
> Willy
