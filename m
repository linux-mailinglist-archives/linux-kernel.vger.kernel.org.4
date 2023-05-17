Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB3705D84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjEQCym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjEQCyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60764215;
        Tue, 16 May 2023 19:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6027963A67;
        Wed, 17 May 2023 02:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81329C433EF;
        Wed, 17 May 2023 02:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684292078;
        bh=sFe/hVwr1RlqKJNFm/E/CQUy8RQP2QPCq5ps+biUM9c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g+5EQcDL1aJVnKUa9P7oA57b/J0fhJzeYfjHTKmU/TRp0LWprYJG7s3i3FWeWbRbR
         X9bJ2KLuZB6L62KxGGDwk739uH0Oh9865Gapt7hV+NuajubaQCh6YPj9tbebJHDEDM
         m4WRnqNvcl5a8uF/AJsgrjlgrsp316p+SBDagEbisG/VbjrjDb5BpoisrcGEw9u51G
         c0DhunDC++nODeOS0aUyO8UbMBnjA5G21/4mLTf1ex2oAI9Chbs6Sa/GrxQfBk2sDt
         jDGp9OjmVhTV+sjsYTUpARxL546bJitU/aBLs7h9L9thv4XQsaKVUXYpHn+8/AZZoU
         ZMmYifuUoeDag==
Date:   Wed, 17 May 2023 11:54:32 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-Id: <20230517115432.94a65364e53cbd5b40c54e82@kernel.org>
In-Reply-To: <CAD8CoPAw_nKsm4vUJ_=aSwzLc5zo8D5pY6A7-grXENxpMYz9og@mail.gmail.com>
References: <20230516071830.8190-1-zegao@tencent.com>
        <20230516071830.8190-3-zegao@tencent.com>
        <20230516091820.GB2587705@hirez.programming.kicks-ass.net>
        <CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
        <20230517010311.f46db3f78b11cf9d92193527@kernel.org>
        <CAD8CoPAw_nKsm4vUJ_=aSwzLc5zo8D5pY6A7-grXENxpMYz9og@mail.gmail.com>
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

On Wed, 17 May 2023 09:54:53 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Oops, I misunderstood your comments before.
> 
> Yes, it's not necessary to do this reordering as regards to kprobe.

Let me confirm, I meant that your current patch is correct. I just mentioned
that kprobe_busy_{begin,end} will continue use standard version because
kprobe itself handles that. Please update only the patch description and
add my ack.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

If you add Steve's call graph for the explanation, it will help us to
understand what will be fixed.

Thank you,

> 
> Thanks for your review.
> 
> I'll rebase onto the latest tree and send v3 ASAP.
> 
> Regards,
> Ze
> 
> On Wed, May 17, 2023 at 12:03 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 16 May 2023 17:47:52 +0800
> > Ze Gao <zegao2021@gmail.com> wrote:
> >
> > > Precisely, these that are called within kprobe_busy_{begin, end},
> > > which the previous patch does not resolve.
> >
> > Note that kprobe_busy_{begin,end} don't need to use notrace version
> > because kprobe itself prohibits probing on preempt_count_{add,sub}.
> >
> > Thank you,
> >
> > > I will refine the commit message to make it clear.
> > >
> > > FYI, details can checked out here:
> > >     Link: https://lore.kernel.org/linux-trace-kernel/20230516132516.c902edcf21028874a74fb868@kernel.org/
> > >
> > > Regards,
> > > Ze
> > >
> > > On Tue, May 16, 2023 at 5:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:
> > > > > Current implementation calls kprobe related functions before doing
> > > > > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > > > > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > > > > is traceable.
> > > >
> > > > Which preempt_count*() are you referring to? The ones you just made
> > > > _notrace in the previous patch?
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
