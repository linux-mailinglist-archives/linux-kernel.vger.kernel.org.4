Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C805B74EBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGKKeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGKKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:34:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70186E6C;
        Tue, 11 Jul 2023 03:34:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FD7E2B;
        Tue, 11 Jul 2023 03:35:19 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DEB43F67D;
        Tue, 11 Jul 2023 03:34:35 -0700 (PDT)
Date:   Tue, 11 Jul 2023 11:34:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Will Deacon <will@kernel.org>, corbet@lwn.net,
        catalin.marinas@arm.com, maz@kernel.org, quic_pkondeti@quicinc.com,
        quic_kaushalk@quicinc.com, quic_satyap@quicinc.com,
        quic_shashim@quicinc.com, quic_songxue@quicinc.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
Message-ID: <ZK0wMGTagEl6amHH@FVFF77S0Q05N.cambridge.arm.com>
References: <20230710055955.36551-1-quic_aiquny@quicinc.com>
 <20230710093751.GC32673@willie-the-truck>
 <5cf15f85-0397-96f7-4110-13494551b53b@quicinc.com>
 <20230711082226.GA1554@willie-the-truck>
 <84f0994a-26de-c20a-a32f-ec8fe41df3a3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84f0994a-26de-c20a-a32f-ec8fe41df3a3@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 06:15:49PM +0800, Aiqun(Maria) Yu wrote:
> On 7/11/2023 4:22 PM, Will Deacon wrote:
> > On Tue, Jul 11, 2023 at 12:02:22PM +0800, Aiqun(Maria) Yu wrote:
> > > On 7/10/2023 5:37 PM, Will Deacon wrote:
> > > > On Mon, Jul 10, 2023 at 01:59:55PM +0800, Maria Yu wrote:
> > > > > In order to be able to disable lse_atomic even if cpu
> > > > > support it, most likely because of memory controller
> > > > > cannot deal with the lse atomic instructions, use a
> > > > > new idreg override to deal with it.
> > > > 
> > > > This should not be a problem for cacheable memory though, right?
> > > > 
> > > > Given that Linux does not issue atomic operations to non-cacheable mappings,
> > > > I'm struggling to see why there's a problem here.
> > > 
> > > The lse atomic operation can be issued on non-cacheable mappings as well.
> > > Even if it is cached data, with different CPUECTLR_EL1 setting, it can also
> > > do far lse atomic operations.
> > 
> > Please can you point me to the place in the kernel sources where this
> > happens? The architecture doesn't guarantee that atomics to non-cacheable
> > mappings will work, see "B2.2.6 Possible implementation restrictions on
> > using atomic instructions". Linux, therefore, doesn't issue atomics
> > to non-cacheable memory.
> 
> We encounter the issue on third party kernel modules 

Which kernel modules?

Those modules are clearly broken; as Will has already said, the architecture
says doing atomics to non-cacheable memory can result in external aborts, and
that's exaclty the behaviour that you're reporting as a problem. This is
working *as designed*.

Note that the same is true for LDXR+STXR; so just hiding LSE doesn't make
sense: if the code falls back to LDXR+STXR it still suffers from the exact same
problem.

Regardless, hiding bugs in out-of-tree code is not a justification for changing
the upstream kernel.

> and third party apps instead of linux kernel itself.

Which apps?

Why are those apps using non-cacheable memory?

Why are those apps trying to perform atomics to non-cacheable memory?

> This is a tradeoff of performance and stability. Per my understanding,
> options can be used to enable the lse_atomic to have the most performance
> cared system, and disable the lse_atomic by stability cared most system.

I think that's a misrepresentation of this patch.

This patch disables a feature to *hide* bugs in out-of-tree kernel modules and
userspace software. It's not about making the system more stable, it's about
making broken code appear to work.

The LSE atomics aren't just about performance. They're significantly fairer
than LDXR+STXR in many practical situations, and contribute to the stability of
the system.

Thanks,
Mark.

> > > > Please can you explain the problem that you are trying to solve?
> > > 
> > > In our current case, it is a 100% reproducible issue that happened for
> > > uncached data, the cpu which support LSE atomic, but the system's DDR
> > > subsystem is not support this and caused a NOC error and thus synchronous
> > > external abort happened.
> > 
> > So? The Arm ARM allows this behaviour and Linux shouldn't run into it.
> > 
> > Will
> 
> -- 
> Thx and BRs,
> Aiqun(Maria) Yu
> 
