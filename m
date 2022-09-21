Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8085BF37D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiIUCbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIUCbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:31:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2046B14E;
        Tue, 20 Sep 2022 19:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 895DA627D2;
        Wed, 21 Sep 2022 02:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE14C43146;
        Wed, 21 Sep 2022 02:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663727453;
        bh=IlG0gnyjYzJPRT4Op43nB8mTf1EWR65qF0nnc5/7Th4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tMGhK/2IZ34IEAE7WzLcYamKLmk06jbH4IFNJQnMU6TGZbYlF7RUMRGGMA/sVcttm
         lZgKgDXCpNaeQZ+GdJsmhOSJQpestwA/Av81YfXEP8b7kHthbixCDu3Is+zFy6nIyv
         6mtJSbQvbNSel4sNNTfqZsaj31CVLgqv01W3aj9huRUBd5Vf7s0aK0whq9a3gzQQZE
         b3abvqdXmpvXQceVd9F4ExQsmbEh9t7V155jugOaxheIUIv3FKahdoOR9NCgVzGYIM
         dsAKv3kcZ7qALWG3S3DvBaiumsr9mOnyvkCmfHvq7y130Ak1dytFUr+qntWeywEl2N
         BpctILw3/KzLg==
Received: by mail-oi1-f169.google.com with SMTP id d64so3298867oia.9;
        Tue, 20 Sep 2022 19:30:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf34MsIPXDALZ5zTZ8Rl7Hmj+6DB1QxfdbIkQT+nRwpff3BYrPgQ
        yxCrK//cBPznd/5zm9kpDqgb0IJgOoCFGEcYJNo=
X-Google-Smtp-Source: AMsMyM6KrdR2Wv3e6RoF6x1x7BI4T9AH7ddVRa6LgIcQDLrWFR5/Eo+BTY5lQTB1EzIbHQmoX0DKqBvD5AFUJvDkE9o=
X-Received: by 2002:a05:6808:201f:b0:34f:9fdf:dbbf with SMTP id
 q31-20020a056808201f00b0034f9fdfdbbfmr2887695oiw.19.1663727452972; Tue, 20
 Sep 2022 19:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220920151202.180057-1-chenzhongjin@huawei.com>
In-Reply-To: <20220920151202.180057-1-chenzhongjin@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Sep 2022 10:30:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRUh6RiMypEm=b=iJruXDWXoqXpXwn1YaUChgyJ0v2gxw@mail.gmail.com>
Message-ID: <CAJF2gTRUh6RiMypEm=b=iJruXDWXoqXpXwn1YaUChgyJ0v2gxw@mail.gmail.com>
Subject: Re: [PATCH -next 0/7] riscv: Improvments for stacktrace
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-perf-users@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, nsaenzju@redhat.com, frederic@kernel.org,
        changbin.du@intel.com, vincent.chen@sifive.com, ardb@kernel.org,
        mhiramat@kernel.org, rostedt@goodmis.org, keescook@chromium.org,
        catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some modifications are related to the patch series [1] [2], please take a look.

[1] https://lore.kernel.org/linux-riscv/20220918155246.1203293-1-guoren@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20220916103817.9490-1-guoren@kernel.org/

On Tue, Sep 20, 2022 at 11:15 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
> Currently, the stacktrace with FRAME_POINTER on riscv has some problem:
>
> 1. stacktrace will stop at irq so it can't get the stack frames before
> irq entry.
> 2. stacktrace can't unwind all the real stack frames when there is
> k{ret}probes or ftrace.
>
> These are mainly becase when there is a pt_regs on stack, we can't unwind
> the stack frame as normal function.
>
> Some architectures (e.g. arm64) create a extra stackframe inside pt_regs.
> However this doesn't work for riscv because the ra is not ensured to be
> pushed to stack. As explained in:
> commit f766f77a74f5("riscv/stacktrace: Fix stack output without ra on the stack top")
>
> So, I choosed the method of x86 that, if there is a pt_regs on stack,
> we encoded the frame pointer and save it. When unwinding stack frame,
> we can get pt_regs and registers required for unwinding stacks.
>
> In addition, the patch set contains some refactoring of stacktrace.c to
> keep the stacktrace code on riscv consistent with other architectures.
>
> Chen Zhongjin (7):
>   riscv: stacktrace: Replace walk_stackframe with arch_stack_walk
>   riscv: stacktrace: Introduce unwind functions
>   riscv: stacktrace: Save pt_regs in encoded fp on irq entry
>   riscv: syscall: Don't clobber s0 when syscall
>   riscv: stacktrace: Implement stacktrace for irq
>   riscv: stacktrace: Fix unwinding on ftrace_regs_call
>   riscv: stacktrace: Fix unwinding on __kretporbe_trampoline
>
>  arch/riscv/include/asm/frame.h                |  45 +++++
>  arch/riscv/include/asm/stacktrace.h           |  13 +-
>  arch/riscv/kernel/entry.S                     |  23 +--
>  arch/riscv/kernel/mcount-dyn.S                |   8 +
>  arch/riscv/kernel/perf_callchain.c            |   2 +-
>  arch/riscv/kernel/probes/kprobes_trampoline.S |   8 +
>  arch/riscv/kernel/stacktrace.c                | 155 ++++++++++++------
>  7 files changed, 195 insertions(+), 59 deletions(-)
>  create mode 100644 arch/riscv/include/asm/frame.h
>
> --
> 2.17.1
>


--
Best Regards
 Guo Ren
