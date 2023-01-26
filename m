Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB8167D3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjAZSPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjAZSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:15:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABD05DC2A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:15:01 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so2552259pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YAO6Bmqd4/Pyi+jt3kpxu+RC5rfOheWa1qUUyr5eeJc=;
        b=K3OgLbdFtLk7NmKInSXeOode70KPPXga8guA8NgQEtyA/B7nykAptAGKQH/Dl1XfF5
         SugkXAt9OYGyGtcFYNPX/OHGajZQ0GeEOTfOO1H7rcNJXU4Gvuwg/rinp/9vZ6/zX41K
         SkfAgcgRPPxkyTldyC8UKhoU6TLV0UaT7cH9Ss11g1YZb0ytKMUA8xEKKpDAtwOMeFgP
         a1x3sWFgcuOJKuMcbxg8/ayEbglXZZU2jI2QBxf90nRNIjvi6WFoQGIuYi+D3Lx9vd8U
         Cj6rUSDY2mhdo1ic96ljjpS4IeN9mrJovUrHfb/VMXNn7ZLRYs4BvAPsQJppyybSehvJ
         cEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAO6Bmqd4/Pyi+jt3kpxu+RC5rfOheWa1qUUyr5eeJc=;
        b=JM1iBRQVNcVUJAxrYBRMHfP1718oA7BFy4y90jl6zQgFfSYEsebdMK3tAtSLTv2Jvu
         pAuOUvIRF2jEsZMUGLgUL7KmPmTQNvBjC0HzMuxcYAcpnqjsaWA+dopGx/Oii4oD8n1/
         drHw/O+XaHpcDKFF+v1SpC3qj64BPRh/Bbk+bwoG8AAm0HXjD8ehAhY5qSCGrpRBbyUJ
         EvGnSyOjWZ3ziEfIyYm2DILJ7A/f0nG4aVlh49i8oL8Tz4w+a8bQPVJsZKvwZAbxIFJp
         PT0vBiPr4pDuXx16MVKa6IcNtKBT33hPv99CU7yT2ZwECkbvfqYP8ZRJGciEwF6sFNkq
         zP3w==
X-Gm-Message-State: AO0yUKV4cDHo4W9TqJk05kogteFcCjacYxpT+/eo5d6mIfQpSTHHmNRN
        MBwvd69nxMvtDPl0IqBgOTB14Pmaiwr2BSLRc1JU3TZ3vBuuG1q4QS8=
X-Google-Smtp-Source: AK7set+qRLx3ViGqdN0zJ8lOPJ7m0kPJmW9YtsEwwqn5UZ0s+Fpnnq91CV1IFzOdUrJAP8fN3l7+sw3rOlbS1ACT8xU=
X-Received: by 2002:a17:90a:c291:b0:22b:e5e0:1229 with SMTP id
 f17-20020a17090ac29100b0022be5e01229mr1791942pjt.13.1674756900911; Thu, 26
 Jan 2023 10:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20230123205915.751729592@infradead.org> <20230123210607.173715335@infradead.org>
 <20230123174431.4421dfdf@gandalf.local.home> <Y8/X6fdRT80jssIf@hirez.programming.kicks-ass.net>
 <20230124100753.13608e1f@gandalf.local.home> <Y9Kdg9QjHkr9G5b5@hirez.programming.kicks-ass.net>
In-Reply-To: <Y9Kdg9QjHkr9G5b5@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Jan 2023 10:14:49 -0800
Message-ID: <CAKwvOdmE4bHdOr4TCm0EKrqKjMWk52NAkEOOd9JgsbUFaknOrw@mail.gmail.com>
Subject: Re: [PATCH v1.1 3/3] x86/static_call: Add support for Jcc tail-calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@kernel.org,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, jpoimboe@kernel.org,
        jbaron@akamai.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        erhard_f@mailbox.org, mhiramat@kernel.org, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 7:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 24, 2023 at 10:07:53AM -0500, Steven Rostedt wrote:
> > On Tue, 24 Jan 2023 14:06:49 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > Just to confirm, as it's not clear if this is the static call site or one
> > > > of the functions that is being called.
> > >
> > > Ah, you've not looked at enough asm then? ;-) Yes this is the static
> > > call site, see the __SCT_ target (instruction at 0x35d).
> >
> > Yeah, could you specify it a bit more in the change log such that those
> > looking back at this don't have to have that requirement of staring at
> > enough asm ;-)
>
> How's this then?
>
> ---
> Subject: x86/static_call: Add support for Jcc tail-calls
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Jan 20 16:40:33 CET 2023
>
> Clang likes to create conditional tail calls like:
>
> 0000000000000350 <amd_pmu_add_event>:
> 350:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 351: R_X86_64_NONE      __fentry__-0x4
> 355:       48 83 bf 20 01 00 00 00         cmpq   $0x0,0x120(%rdi)
> 35d:       0f 85 00 00 00 00       jne    363 <amd_pmu_add_event+0x13>     35f: R_X86_64_PLT32     __SCT__amd_pmu_branch_add-0x4
> 363:       e9 00 00 00 00          jmp    368 <amd_pmu_add_event+0x18>     364: R_X86_64_PLT32     __x86_return_thunk-0x4

If it helps reduce the line width in the commit message to focus on
just the instructions, lately I've been using
`--no-addresses --no-show-raw-insn` flags to llvm-objdump.

In my ~/.zshrc, I have this function:
dis () {
  file=$1
  func=$2
  llvm-objdump -Dr --no-addresses --no-show-raw-insn
--disassemble-symbols=$func $file
}
Which let me run `dis vmlinux amd_pmu_add_event` or `dis foo.o func`.
Sometimes I don't want `-r` or `--no-show-raw-insn or
`--no-addresses`, but most of the time I do.

-- 
Thanks,
~Nick Desaulniers
