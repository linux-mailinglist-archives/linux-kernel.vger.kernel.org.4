Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FB46C8478
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjCXSGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCXSFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:05:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5AC1A64F;
        Fri, 24 Mar 2023 11:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE884B825E4;
        Fri, 24 Mar 2023 18:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AF2C433D2;
        Fri, 24 Mar 2023 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679681017;
        bh=tKZ9/oaRhxbLg4cyo+nZSht23wve8VKRZIBqjwFQmvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOtfXKpy4ZeaeGs0OgT28VpaQz9ExkzXUFR39d3k5EVNfIV4R15SVr6LcEcc619J3
         VEM0RY2TJMcdgCh7vqb2W3yZ441ciQ8AT0qs7h5LLrvvpdvBzUV0icGcDrBnmwiZUW
         SLVL0AV52MA3tYv9QoTTaroasr7H2MNKveoYRVC6tHfAbWuIHGoVkYyXVLx9cRP1Ob
         aNuXWxyDJcPslQbYa65Z274NEReYF9fLBX+kDlFjfEa/kpIUgTzDPk7BV7thPDSIcf
         BSRnisG3kGFix5vDpypcxmtavGu1SMqi/37KCEdLeVOms/oLdbgcCGesRo2tjx5fNV
         +z4/WFzqHLL1A==
Date:   Fri, 24 Mar 2023 18:03:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
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
Message-ID: <20230324180329.GB27948@willie-the-truck>
References: <20230317195027.3746949-1-zalbassam@google.com>
 <87v8iygyx2.wl-maz@kernel.org>
 <ZB2sGrsbr58ttoWI@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB2sGrsbr58ttoWI@FVFF77S0Q05N>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 01:56:42PM +0000, Mark Rutland wrote:
> On Sat, Mar 18, 2023 at 10:02:33AM +0000, Marc Zyngier wrote:
> > On Fri, 17 Mar 2023 19:50:19 +0000,
> > Zaid Al-Bassam <zalbassam@google.com> wrote:
> > > 
> > > Currently, PMUv3 driver is only available for ARMv8 aarch64 platforms,
> > > ARMv8 platorms running in aarch32 mode dont have access to the driver.
> > > This is, especially, a problem for ARMv8 platforms that only have
> > > aarch32 support, like the Cortex-A32.
> > > 
> > > Make the PMUv3 driver available to arm arch (ARMv8 aarch32) by moving
> > > the PMUv3 driver from arm64 to drivers, that makes the driver common
> > > to both arm and arm64 architectures, then add PMUv3 arm Support.
> > > 
> > > The main work in this patchset was made a while back by Marc Zyngier
> > > in [1]. Patchset version 1 [v1] rebases Marc's patches to the latest
> > > kernel revision and adds additional patches to accommodate the changes
> > > in the kernel since Marc wrote the patches.
> > > 
> > > version 2 [v2] of the patchset was created by Marc Zyngier and I
> > > picked it up from [2].
> > 
> > The SoB chain is now a bit off as you picked it from my tree. Nothing
> > that we can't fix, but please be careful in the future. You also
> > failed to pick Florian's Tested-by: tags, which is worse. Please make
> > sure to pick these things as people reply to your series.
> > 
> > Will, Mark: any objection to the general shape of this series? I've
> > been using it again to test the 32bit PMU support in KVM, and would
> > rather see something merged while the architecture still has some
> > relevance.
> 
> I think the general shape looks fine, but this is going to conflict with
> Anshuman's BRBE series, so we'll need to figure out how to stage these w.r.t.
> one another.
> 
> Will, any preference between handling the merge manually or rebasing one atop
> the other? We'll presumably want to place the BRBE files under drivers/perf/ if
> we've moved the PMUv3 code there.

Probably easiest to queue this and have Anshuman rebase BRBE on top once
I've done that. I'll look at it next week.

Will
