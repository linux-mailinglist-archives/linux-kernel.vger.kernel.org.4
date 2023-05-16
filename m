Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB9B705304
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjEPQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjEPQDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:03:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35CAC7;
        Tue, 16 May 2023 09:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7138B6316B;
        Tue, 16 May 2023 16:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A397C433D2;
        Tue, 16 May 2023 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252997;
        bh=helSsO57tH8dHbFRP7TCi/6hSqDAckI7M3dabJ0ZYsA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sRkEXd4R4P1ulUwx8C82RCmJWGwc8Ste6XlVCpWZvC9Qcc2gYmHA1k6dQ21Zf+Tiy
         qT8FRgwCIYA2117hVruEKq1bbXpARuD7yg9dDIHvUkcjIprxWMEttCswGjfaODMqXc
         AbXpR7xi/J1hAdmFn+Qh5gjJ9JxKLjCb3Cof3rc+4o65KBLnERtyx/NaKaoY9mPWbF
         3mHNnv6y/Mb2J/lWb+cFvzU15NB9pXvxhSykI2u2DfhhpK+alFr4cBdVnQ9MCZ4kK7
         BaZPMq90Cc6L+2Qm7TdMttAPm2F4w1UnWDoohkzsv7EmzaY3M2R0sCCQD8nVffAXI3
         WooI/NSCY2bRw==
Date:   Wed, 17 May 2023 01:03:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Ze Gao <zegao@tencent.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion
 free
Message-Id: <20230517010311.f46db3f78b11cf9d92193527@kernel.org>
In-Reply-To: <CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
References: <20230516071830.8190-1-zegao@tencent.com>
        <20230516071830.8190-3-zegao@tencent.com>
        <20230516091820.GB2587705@hirez.programming.kicks-ass.net>
        <CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 17:47:52 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Precisely, these that are called within kprobe_busy_{begin, end},
> which the previous patch does not resolve.

Note that kprobe_busy_{begin,end} don't need to use notrace version
because kprobe itself prohibits probing on preempt_count_{add,sub}.

Thank you,

> I will refine the commit message to make it clear.
> 
> FYI, details can checked out here:
>     Link: https://lore.kernel.org/linux-trace-kernel/20230516132516.c902edcf21028874a74fb868@kernel.org/
> 
> Regards,
> Ze
> 
> On Tue, May 16, 2023 at 5:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:
> > > Current implementation calls kprobe related functions before doing
> > > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > > is traceable.
> >
> > Which preempt_count*() are you referring to? The ones you just made
> > _notrace in the previous patch?


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
