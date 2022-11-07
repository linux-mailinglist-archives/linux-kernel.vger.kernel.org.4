Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF86861F7B2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiKGPcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiKGPce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:32:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 377A31F2FB;
        Mon,  7 Nov 2022 07:32:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C74EB1FB;
        Mon,  7 Nov 2022 07:32:38 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BE3F3F73D;
        Mon,  7 Nov 2022 07:32:30 -0800 (PST)
Date:   Mon, 7 Nov 2022 15:32:24 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Jianlin Lv <iecedge@gmail.com>, corbet@lwn.net,
        catalin.marinas@arm.com, rostedt@goodmis.org, mingo@redhat.com,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, arnd@arndb.de,
        zhengzengkai@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/kprobes: Add support for KPROBES_ON_FTRACE
Message-ID: <Y2klCLj7F7fKsza+@FVFF77S0Q05N>
References: <20220728020250.1699-1-iecedge@gmail.com>
 <20221107144931.GA20793@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107144931.GA20793@willie-the-truck>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:49:31PM +0000, Will Deacon wrote:
> [+Mark R]
> 
> On Thu, Jul 28, 2022 at 02:02:50AM +0000, Jianlin Lv wrote:
> > This is the arm64 version of ftrace-based kprobes to avoid the overhead
> > with regular kprobes, by using the ftrace infrastructure.
> > 
> > Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> > ---
> >  .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
> >  arch/arm64/Kconfig                            |  1 +
> >  arch/arm64/kernel/probes/Makefile             |  1 +
> >  arch/arm64/kernel/probes/kprobes-ftrace.c     | 81 +++++++++++++++++++
> >  include/linux/kprobes.h                       |  2 +
> >  kernel/kprobes.c                              |  4 +-
> >  6 files changed, 88 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/arm64/kernel/probes/kprobes-ftrace.c
> 
> Sorry for the slow reply on this, but I think this deserved to be split
> into two patches: the first one reworking the core check_ftrace_location()
> logic to work properly with branch-and-link style architectures, and the
> second one adding support for arm64.

I'd prefer we don't do this at all; there a bunch of issues with kprobes *not*
taking an exception, since we get a dodgy not-quite-real pt_regs, and to clean
up the existing issues the plan is:

1) Move ftrace over to ftrace_regs
2) Implement fprobes using ftrace_regs
3) Remove kretprobes

... and regular kprobes will need to take an exception (via BRK) to get a real
pt_regs, so that can't be optimized to use ftrace.

Thanks,
Mark.
