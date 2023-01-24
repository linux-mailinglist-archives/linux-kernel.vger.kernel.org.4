Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C8A679C40
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbjAXOnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbjAXOnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:43:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E8574A1E1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:42:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 703194B3;
        Tue, 24 Jan 2023 06:43:30 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92E083F71E;
        Tue, 24 Jan 2023 06:42:47 -0800 (PST)
Date:   Tue, 24 Jan 2023 14:42:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [GIT PULL] cacheinfo/arch_topology: Updates for v6.3
Message-ID: <20230124144245.ddphvqbcxpzrlgek@bogus>
References: <20230120121856.1407369-1-sudeep.holla@arm.com>
 <CAMuHMdUZzLkWvhQ=YeH2KfQ_FRidemfOvbbHf_b1AHROK9HFNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUZzLkWvhQ=YeH2KfQ_FRidemfOvbbHf_b1AHROK9HFNA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:44:10PM +0100, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Fri, Jan 20, 2023 at 1:22 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > It has been tested on RISC-V which is the main users outside of arm64.
> 
> Has it?
>

Hmm, I might have mixed up things then. I was on a vacation for quite some
time and might have assumed Conor response on the thread with testing.
Extremely sorry for that. However it was in -next for few days before
Greg applied to his tree.

> > The ACPI the RISC-V parts are acked-by the respective maintainers. All
> > the changes are in the -next for sometime and no issues reported at this
> > time.
> >
> > Regards,
> > Sudeep
> >
> > -->8
> >
> > The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> >
> >   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/archtopo-cacheinfo-updates-6.3
> >
> > for you to fetch changes up to 198102c9103fc78d8478495971947af77edb05c1:
> >
> >   cacheinfo: Fix shared_cpu_map to handle shared caches at different levels (2023-01-18 09:58:40 +0000)
> >
> > ----------------------------------------------------------------
> > cacheinfo and arch_topology updates for v6.3
> >
> > The main change is to build the cache topology information for all
> > the CPUs from the primary CPU. Currently the cacheinfo for secondary CPUs
> > is created during the early boot on the respective CPU itself. Preemption
> > and interrupts are disabled at this stage. On PREEMPT_RT kernels, allocating
> > memory and even parsing the PPTT table for ACPI based systems triggers a:
> >   'BUG: sleeping function called from invalid context'
> >
> > To prevent this bug, the cacheinfo is now allocated from the primary CPU
> > when preemption and interrupts are enabled and before booting secondary
> > CPUs. The cache levels/leaves are computed from DT/ACPI PPTT information
> > only, without relying on any architecture specific mechanism if done so
> > early.
> >
> > The other minor change included here is to handle shared caches at
> > different levels when not all the CPUs on the system have the same
> > cache hierarchy.
> 
> While this gets rid of the "cacheinfo: Unable to detect cache hierarchy
> for CPU N" warnings printed during boot, it resurrects the printing of
> 
>     Early cacheinfo failed, ret = -12
> 
> during early boot on all my RV64 platforms
> 
> See also https://lore.kernel.org/all/CAMuHMdUBZ791fxCPkKQ6HCwLE4GJB2S35QC=SQ+X8w5Q4C_70g@mail.gmail.com/
> for a similar earlier version triggering the same issue.
> 
> > ----------------------------------------------------------------
> > Pierre Gondois (6):
> >       arch_topology: Build cacheinfo from primary CPU
> 
> Reverting commit 5944ce092b97caed ("arch_topology: Build cacheinfo
> from primary CPU") fixes the issue.
>

OK, thanks for narrowing it to one patch. We will look at it. But does
it work fine even with this errors ? We had seen such a behaviour in the
past. It fails to initialise too early but works at later initcall level
which I am not sure if we investigated why.

-- 
Regards,
Sudeep
