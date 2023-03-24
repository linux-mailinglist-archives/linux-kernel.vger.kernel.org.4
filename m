Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FD06C7F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjCXN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCXN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:56:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BCB612CF6;
        Fri, 24 Mar 2023 06:56:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7C7711FB;
        Fri, 24 Mar 2023 06:57:35 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.55.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 344073F71E;
        Fri, 24 Mar 2023 06:56:48 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:56:42 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Zaid Al-Bassam <zalbassam@google.com>,
        Will Deacon <will@kernel.org>,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu,
        "f.fainelli@gmail.comm Anshuman Khandual" <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 0/8] perf: arm: Make PMUv3 driver available for aarch32
Message-ID: <ZB2sGrsbr58ttoWI@FVFF77S0Q05N>
References: <20230317195027.3746949-1-zalbassam@google.com>
 <87v8iygyx2.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8iygyx2.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 10:02:33AM +0000, Marc Zyngier wrote:
> On Fri, 17 Mar 2023 19:50:19 +0000,
> Zaid Al-Bassam <zalbassam@google.com> wrote:
> > 
> > Currently, PMUv3 driver is only available for ARMv8 aarch64 platforms,
> > ARMv8 platorms running in aarch32 mode dont have access to the driver.
> > This is, especially, a problem for ARMv8 platforms that only have
> > aarch32 support, like the Cortex-A32.
> > 
> > Make the PMUv3 driver available to arm arch (ARMv8 aarch32) by moving
> > the PMUv3 driver from arm64 to drivers, that makes the driver common
> > to both arm and arm64 architectures, then add PMUv3 arm Support.
> > 
> > The main work in this patchset was made a while back by Marc Zyngier
> > in [1]. Patchset version 1 [v1] rebases Marc's patches to the latest
> > kernel revision and adds additional patches to accommodate the changes
> > in the kernel since Marc wrote the patches.
> > 
> > version 2 [v2] of the patchset was created by Marc Zyngier and I
> > picked it up from [2].
> 
> The SoB chain is now a bit off as you picked it from my tree. Nothing
> that we can't fix, but please be careful in the future. You also
> failed to pick Florian's Tested-by: tags, which is worse. Please make
> sure to pick these things as people reply to your series.
> 
> Will, Mark: any objection to the general shape of this series? I've
> been using it again to test the 32bit PMU support in KVM, and would
> rather see something merged while the architecture still has some
> relevance.

I think the general shape looks fine, but this is going to conflict with
Anshuman's BRBE series, so we'll need to figure out how to stage these w.r.t.
one another.

Will, any preference between handling the merge manually or rebasing one atop
the other? We'll presumably want to place the BRBE files under drivers/perf/ if
we've moved the PMUv3 code there.

Thanks,
Mark.
