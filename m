Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB46208CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiKHFKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiKHFKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:10:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635F212D2D;
        Mon,  7 Nov 2022 21:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D545A61477;
        Tue,  8 Nov 2022 05:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4B2C433D6;
        Tue,  8 Nov 2022 05:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667884215;
        bh=3IrJwJrA1RHpQGiiZvKL0qC5cBBuXUjOTdkaNFU91NE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o9r5qIP8M05KbsxQB029t+OxiONfyvU9RZ5iNZ+S3gX1R07+jir3ElxEpCKroYGla
         vjItR1yiQeIV4cQPXLNvQIixWs0nXCtzDrJar4uF+STKIfMkMYTyFoHgdod8Gx8C4Z
         XtqdAYUwCYJ2oXb0deMA/ndn4WMjdiQTRXFHIszc9VKtn9E8oSeK5ZzU/wbmVj3bPS
         I4ZssQiev3LAJinU8S8SBIrRtnSGuc6zdI4+JOfN0W2QlM6egpub0AQDPtMEdkco1a
         CzLEvSfNXL9NPgasSiAIT9IHvIh92aI+Y6NZTlrs//5yroRgX8v2L+HrFrNIICZ8S4
         dFU1PQDCyjxWw==
Date:   Tue, 8 Nov 2022 14:10:09 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>, Jianlin Lv <iecedge@gmail.com>,
        corbet@lwn.net, catalin.marinas@arm.com, rostedt@goodmis.org,
        mingo@redhat.com, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, arnd@arndb.de, zhengzengkai@huawei.com,
        jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/kprobes: Add support for KPROBES_ON_FTRACE
Message-Id: <20221108141009.d39d1d02f07e8993c1f37349@kernel.org>
In-Reply-To: <Y2ktAisfFAr0aU2V@FVFF77S0Q05N>
References: <20220728020250.1699-1-iecedge@gmail.com>
        <20221107144931.GA20793@willie-the-truck>
        <Y2klCLj7F7fKsza+@FVFF77S0Q05N>
        <20221107153506.GA21157@willie-the-truck>
        <Y2ktAisfFAr0aU2V@FVFF77S0Q05N>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 16:06:26 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Mon, Nov 07, 2022 at 03:35:07PM +0000, Will Deacon wrote:
> > On Mon, Nov 07, 2022 at 03:32:24PM +0000, Mark Rutland wrote:
> > > On Mon, Nov 07, 2022 at 02:49:31PM +0000, Will Deacon wrote:
> > > > [+Mark R]
> > > > 
> > > > On Thu, Jul 28, 2022 at 02:02:50AM +0000, Jianlin Lv wrote:
> > > > > This is the arm64 version of ftrace-based kprobes to avoid the overhead
> > > > > with regular kprobes, by using the ftrace infrastructure.
> > > > > 
> > > > > Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> > > > > ---
> > > > >  .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
> > > > >  arch/arm64/Kconfig                            |  1 +
> > > > >  arch/arm64/kernel/probes/Makefile             |  1 +
> > > > >  arch/arm64/kernel/probes/kprobes-ftrace.c     | 81 +++++++++++++++++++
> > > > >  include/linux/kprobes.h                       |  2 +
> > > > >  kernel/kprobes.c                              |  4 +-
> > > > >  6 files changed, 88 insertions(+), 3 deletions(-)
> > > > >  create mode 100644 arch/arm64/kernel/probes/kprobes-ftrace.c
> > > > 
> > > > Sorry for the slow reply on this, but I think this deserved to be split
> > > > into two patches: the first one reworking the core check_ftrace_location()
> > > > logic to work properly with branch-and-link style architectures, and the
> > > > second one adding support for arm64.
> > > 
> > > I'd prefer we don't do this at all; there a bunch of issues with kprobes *not*
> > > taking an exception, since we get a dodgy not-quite-real pt_regs, and to clean
> > > up the existing issues the plan is:
> > > 
> > > 1) Move ftrace over to ftrace_regs
> > > 2) Implement fprobes using ftrace_regs
> > > 3) Remove kretprobes

Yes, that is what we agreed at the tracing summit.

When we finished to move on the fprobe and fprobe-events, kretprobes
(and kprobe-on-ftrace if CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS is not
supported) are not needed from the user viewpoint.
So we can mark the kretprobe API obsolete.

> > > 
> > > ... and regular kprobes will need to take an exception (via BRK) to get a real
> > > pt_regs, so that can't be optimized to use ftrace.
> > 
> > OKey doke. Does that mean that other architectures will follow the same
> > approach of taking an exception,
> 
> I think once everyone has FPROBE, KPROBES_ON_FTRACE becomes redundant, and
> could be removed (leaving kprobes to always follow a take-an-exception flow on
> all architectures).

Anyway I will give some window to transit to the fprobe with ftrace_regs.

> 
> > or do they somehow work by magic?
> 
> Some architectures don't need to take an exception to be able to create a full
> pt_regs (e.g. x86's flags are accessible in a way arm64's PSTATE isn't), but
> that needs to be generated / restored differently to exception entry/return,
> and so even where it's possible it can be painful to maintain (and slower than
> using ftrace_regs), so I suspect KPROBES_ON_FTRACE would be removed.

I think KPROBES_ON_FTRACE support depends on CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS.
When the all architecture removed it, I remove it. But it means that if function
tracer is enabled, we can not put any kprobes on the entry of functions on x86
because there is no space to put a software breakpoint at the function entry
on x86.

For the ftrace (tracefs) user, I will minimize the effect of this change, but
the tools developers (including eBPF developer) this change may be critical.

Thank you,


> 
> So different constaints more than magic.
> 
> Thanks,
> Mark.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
