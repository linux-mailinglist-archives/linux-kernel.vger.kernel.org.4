Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246857427E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjF2OCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjF2OCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:02:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA911FD8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:02:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so324675e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688047369; x=1690639369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YHaMB6/FLbcCsrNQHZRYMsF90ZUBoVOl41MzNpLMLOg=;
        b=MI2xn5x+fXgHT4JtTHtDW2sVILJEsu7p+gjpesVu7Irqocx3MGZa8AalZWTBVjMTCH
         eb0mU46F0aXNLos8OIYuFs/OYJVkzA9XzoPzYjWFvymqqvrWnU+tqC4DWE96QnXvvEq4
         j2mkLWRxZwxiVoC0EdKrs53jlt5g5Ge8JgJWAyVPuGQ4WLSjlrY28FDZxZOLWHA3/fWt
         qvDNOmpvmzdiUhEmfLd4rvo9CWse+hOboN0eiq3UhsgmsNP0QnfnnIhwew7lvq4jMQlG
         CHI4XSAknM6d8d5D2OpdYd9jjIGqfXJbwiRatK1I6qJnja0ri+ctw5ue/f8TsX4JbPTO
         XPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688047369; x=1690639369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHaMB6/FLbcCsrNQHZRYMsF90ZUBoVOl41MzNpLMLOg=;
        b=E/qMFCNeAC6IM5/HdD+BAjQhu/a/z2LqwaJ1zeqBBB3rxhVbHXn6rWCFVyzbdGuyNA
         rIbHip9mt1e7dRWCd5j2rTKd8LN0233L/rWMq2t8ceFh6XljTeGOqMc0Xd8V5Jatl3oy
         XiRU+qoqJuybWFLLBDQ+zw3kVRyG8aXzSrgdTo+9mjYoYhJRByksB+9TbIGfcDxm8qJu
         VuGuMt/wrgBxTbSZP9XAWqqe8FBY66dXcR05/YcFgxE8Vh6ov9i46ZUCgqygnlWs0pph
         d6Iv+Rt4giJCUj3joJECsb1XGQ+elxBjb4iuRkUtJgoBV9dWbEqXxgvXVZm9D7NX1PUE
         oN3g==
X-Gm-Message-State: AC+VfDxgcJpWszo9COgt20iD3HCwmJOjXsGtaz2mRkWIgRzFkfdG7wtG
        h6PzqEq7llt47pIJ5cVFSfSRhA==
X-Google-Smtp-Source: ACHHUZ6Q6NuL7NW14CNjoHX5Owgtx0nXSOiYSjO3hoclgCq4/YkT20HjZSUWkc8hEOQGN4FxMeLOjA==
X-Received: by 2002:a1c:4b0d:0:b0:3fa:e92e:7a8b with SMTP id y13-20020a1c4b0d000000b003fae92e7a8bmr7962800wma.13.1688047369354;
        Thu, 29 Jun 2023 07:02:49 -0700 (PDT)
Received: from wychelm (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fb225d414fsm10140509wma.21.2023.06.29.07.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 07:02:49 -0700 (PDT)
Date:   Thu, 29 Jun 2023 15:02:46 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH -next V17 4/7] riscv: entry: Convert to generic entry
Message-ID: <ZJ2PBosSQtSX28Mf@wychelm>
References: <20230222033021.983168-1-guoren@kernel.org>
 <20230222033021.983168-5-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230222033021.983168-5-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This patch converts riscv to use the generic entry infrastructure from
> kernel/entry/*. The generic entry makes maintainers' work easier and
> codes more elegant. Here are the changes:
>
>  - More clear entry.S with handle_exception and ret_from_exception
>  - Get rid of complex custom signal implementation
>  - Move syscall procedure from assembly to C, which is much more
>    readable.
>  - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
>  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
>  - Use the standard preemption code instead of custom
>
> Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> Tested-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Ben Hutchings <ben@decadent.org.uk>

Apologies for the late feedback but I've been swamped lately and only
recently got round to running the full kgdb test suite on the v6.4
series.

The kgdb test suite includes a couple of tests that verify that the
system resumes after breakpointing due to a BUG():
https://github.com/daniel-thompson/kgdbtest/blob/master/tests/test_kdb_fault_injection.py#L24-L45

These tests have regressed on riscv between v6.3 and v6.4 and a bisect
is pointing at this patch. With these changes in place then, after kdb
resumes the system, the BUG() message is printed as normal but then
immediately fails. From the backtrace it looks like the new entry/exit
code cannot advance past a compiled breakpoint instruction:
~~~
PANIC: Fatal exception in interrupt

Entering kdb (current=0xff60000001a2a280, pid 104) on processor 1 due to
NonMask
able Interrupt @ 0xffffffff800bb3c4
[1]kdb> bt
Stack traceback for pid 104
0xff60000001a2a280      104       92  1    1   R  0xff60000001a2ac50
*echo
CPU: 1 PID: 104 Comm: echo Tainted: G      D
6.3.0-rc1-00003-gf0bddf50586d #119
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff800050dc>] dump_backtrace+0x1c/0x24
[<ffffffff808458f8>] show_stack+0x2c/0x38
[<ffffffff80851b00>] dump_stack_lvl+0x3c/0x54
[<ffffffff80851b2c>] dump_stack+0x14/0x1c
[<ffffffff800bc4b8>] kdb_dump_stack_on_cpu+0x64/0x66
[<ffffffff800c3d2a>] kdb_show_stack+0x82/0x88
[<ffffffff800c3dc0>] kdb_bt1+0x90/0xf2
[<ffffffff800c4206>] kdb_bt+0x34c/0x384
[<ffffffff800c1d28>] kdb_parse+0x27a/0x618
[<ffffffff800c2566>] kdb_main_loop+0x3b2/0x8fa
[<ffffffff800c4c5a>] kdb_stub+0x1ba/0x3a8
[<ffffffff800bbba8>] kgdb_cpu_enter+0x342/0x5ba
[<ffffffff800bc3da>] kgdb_handle_exception+0xe0/0x11a
[<ffffffff8000810c>] kgdb_riscv_notify+0x86/0xb4
[<ffffffff8002f210>] notify_die+0x6a/0xa6
[<ffffffff80004db0>] handle_break+0x70/0xe0
[<ffffffff80852462>] do_trap_break+0x48/0x5c
[<ffffffff80003598>] ret_from_exception+0x0/0x64
[<ffffffff800bb3c4>] kgdb_compiled_break+0x0/0x14
~~~


Daniel.
