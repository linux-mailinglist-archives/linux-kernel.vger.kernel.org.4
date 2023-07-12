Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED72750025
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGLHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGLHg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:36:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A3DCB8;
        Wed, 12 Jul 2023 00:36:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6916E2F4;
        Wed, 12 Jul 2023 00:37:36 -0700 (PDT)
Received: from FVFF77S0Q05N.emea.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3637D3F67D;
        Wed, 12 Jul 2023 00:36:52 -0700 (PDT)
Date:   Wed, 12 Jul 2023 08:36:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Will Deacon <will@kernel.org>, corbet@lwn.net,
        catalin.marinas@arm.com, maz@kernel.org, quic_pkondeti@quicinc.com,
        quic_kaushalk@quicinc.com, quic_satyap@quicinc.com,
        quic_shashim@quicinc.com, quic_songxue@quicinc.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Add the arm64.nolse_atomics command line option
Message-ID: <ZK5X9bXQT7GBxNHj@FVFF77S0Q05N.emea.arm.com>
References: <20230710055955.36551-1-quic_aiquny@quicinc.com>
 <20230710093751.GC32673@willie-the-truck>
 <5cf15f85-0397-96f7-4110-13494551b53b@quicinc.com>
 <20230711082226.GA1554@willie-the-truck>
 <84f0994a-26de-c20a-a32f-ec8fe41df3a3@quicinc.com>
 <20230711102510.GA1809@willie-the-truck>
 <67c2621f-4cad-2495-9785-7737246d3e90@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c2621f-4cad-2495-9785-7737246d3e90@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:09:10AM +0800, Aiqun(Maria) Yu wrote:
> On 7/11/2023 6:25 PM, Will Deacon wrote:
> > On Tue, Jul 11, 2023 at 06:15:49PM +0800, Aiqun(Maria) Yu wrote:
> > > On 7/11/2023 4:22 PM, Will Deacon wrote:
> > > > On Tue, Jul 11, 2023 at 12:02:22PM +0800, Aiqun(Maria) Yu wrote:
> > > > > On 7/10/2023 5:37 PM, Will Deacon wrote:
> > > > > > On Mon, Jul 10, 2023 at 01:59:55PM +0800, Maria Yu wrote:
> > > > > > > In order to be able to disable lse_atomic even if cpu
> > > > > > > support it, most likely because of memory controller
> > > > > > > cannot deal with the lse atomic instructions, use a
> > > > > > > new idreg override to deal with it.
> > > > > > 
> > > > > > This should not be a problem for cacheable memory though, right?
> > > > > > 
> > > > > > Given that Linux does not issue atomic operations to non-cacheable mappings,
> > > > > > I'm struggling to see why there's a problem here.
> > > > > 
> > > > > The lse atomic operation can be issued on non-cacheable mappings as well.
> > > > > Even if it is cached data, with different CPUECTLR_EL1 setting, it can also
> > > > > do far lse atomic operations.
> > > > 
> > > > Please can you point me to the place in the kernel sources where this
> > > > happens? The architecture doesn't guarantee that atomics to non-cacheable
> > > > mappings will work, see "B2.2.6 Possible implementation restrictions on
> > > > using atomic instructions". Linux, therefore, doesn't issue atomics
> > > > to non-cacheable memory.
> > > 
> > > We encounter the issue on third party kernel modules and third party apps
> > > instead of linux kernel itself.
> > 
> > Great, so there's nothing to do in the kernel then!
> > 
> > The third party code needs to be modified not to use atomic instructions
> > with non-cacheable mappings. No need to involve us with that.
> 
> > > This is a tradeoff of performance and stability. Per my understanding,
> > > options can be used to enable the lse_atomic to have the most performance
> > > cared system, and disable the lse_atomic by stability cared most system.
> > 
> > Where do livelock and starvation fit in with "stability"? Disabling LSE
> > atomics for things like qspinlock and the scheduler just because of some
> > badly written third-party code isn't much of a tradeoff.

> We also have requirement to have cpus/system fully support lse atomic and
> cpus/system not fully support lse atomic with a generic kernel image.

Who *specifically* has this requirement (i.e. what does 'we' mean here)? The
upstream kernel does not require that atomics work on non-cacheable memory, and
saying "The company I work for want this" doesn't change that.

AFAICT the system here is architecturally compliant, and what you're relying
upon something that the architecture doesn't guarantee, and Linux doesn't
guarantee.

> Same kernel module wanted to be used by lse atomic fully support cpu and not
> fully support cpu/system as well.

Which kernel modules *specifically* need to do atomics to non-cacheable memory?

> That's why we want to have a runtime option here.

As per other replies, a runtime option doesn't solve the issue you have
described, and it will adversely affect the system in other ways (e.g. the
livelock and starvation issues will mentioned, which we have seen with
LDXR+STXR atomics).

Thanks,
Mark.
