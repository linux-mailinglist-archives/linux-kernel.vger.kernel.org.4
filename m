Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38E061F7C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiKGPfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiKGPfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:35:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196F01099;
        Mon,  7 Nov 2022 07:35:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAF5960E17;
        Mon,  7 Nov 2022 15:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E27DC433C1;
        Mon,  7 Nov 2022 15:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667835314;
        bh=YgTjc9NWRa4hkCM5G3S0/8cBCSAgAXOlIov4LDNhgLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0h0qU8/wbruaUY0+KTShGs7d4ZHYnVtjDKBT776gi82Vc5PUrq7aSP6OhXloFNRq
         QRL/JqICUb/pDv1M5V6P7oLyrzAWtqUhAs0D2y5lJ3H2ZBDxRAjT9S+0WRIfHzDsS4
         lRSFqMUEBtpV3AxQWLIC+C8BTKeRybIogwS4G4/G4FkEMgmifzsK6z6bNWLmwPO8iq
         47LT4LWt0q46ICgGe1m6HqZYOeRrqETvzZu9ZZAI1aYudHsLPeOCBNZKgm+VaxLRgK
         dxFJLSj3kjjlnwVi+/u+Le4bhJebjrb5rPRwWCY9AgGNBvbEFNHekNZd68S/j+vJ5O
         m4OWFNcGrpUQg==
Date:   Mon, 7 Nov 2022 15:35:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jianlin Lv <iecedge@gmail.com>, corbet@lwn.net,
        catalin.marinas@arm.com, rostedt@goodmis.org, mingo@redhat.com,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, arnd@arndb.de,
        zhengzengkai@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/kprobes: Add support for KPROBES_ON_FTRACE
Message-ID: <20221107153506.GA21157@willie-the-truck>
References: <20220728020250.1699-1-iecedge@gmail.com>
 <20221107144931.GA20793@willie-the-truck>
 <Y2klCLj7F7fKsza+@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2klCLj7F7fKsza+@FVFF77S0Q05N>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:32:24PM +0000, Mark Rutland wrote:
> On Mon, Nov 07, 2022 at 02:49:31PM +0000, Will Deacon wrote:
> > [+Mark R]
> > 
> > On Thu, Jul 28, 2022 at 02:02:50AM +0000, Jianlin Lv wrote:
> > > This is the arm64 version of ftrace-based kprobes to avoid the overhead
> > > with regular kprobes, by using the ftrace infrastructure.
> > > 
> > > Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> > > ---
> > >  .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
> > >  arch/arm64/Kconfig                            |  1 +
> > >  arch/arm64/kernel/probes/Makefile             |  1 +
> > >  arch/arm64/kernel/probes/kprobes-ftrace.c     | 81 +++++++++++++++++++
> > >  include/linux/kprobes.h                       |  2 +
> > >  kernel/kprobes.c                              |  4 +-
> > >  6 files changed, 88 insertions(+), 3 deletions(-)
> > >  create mode 100644 arch/arm64/kernel/probes/kprobes-ftrace.c
> > 
> > Sorry for the slow reply on this, but I think this deserved to be split
> > into two patches: the first one reworking the core check_ftrace_location()
> > logic to work properly with branch-and-link style architectures, and the
> > second one adding support for arm64.
> 
> I'd prefer we don't do this at all; there a bunch of issues with kprobes *not*
> taking an exception, since we get a dodgy not-quite-real pt_regs, and to clean
> up the existing issues the plan is:
> 
> 1) Move ftrace over to ftrace_regs
> 2) Implement fprobes using ftrace_regs
> 3) Remove kretprobes
> 
> ... and regular kprobes will need to take an exception (via BRK) to get a real
> pt_regs, so that can't be optimized to use ftrace.

OKey doke. Does that mean that other architectures will follow the same
approach of taking an exception, or do they somehow work by magic?

Will
