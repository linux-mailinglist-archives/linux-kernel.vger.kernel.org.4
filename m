Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A421162FBEF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiKRRrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242115AbiKRRrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:47:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B290F6035C;
        Fri, 18 Nov 2022 09:47:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A2123A;
        Fri, 18 Nov 2022 09:47:23 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42EAB3F663;
        Fri, 18 Nov 2022 09:47:15 -0800 (PST)
Date:   Fri, 18 Nov 2022 17:47:05 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V5 2/7] arm64/perf: Update struct arm_pmu for BRBE
Message-ID: <Y3fFGQN55+LM5s5u@FVFF77S0Q05N.cambridge.arm.com>
References: <20221107062514.2851047-1-anshuman.khandual@arm.com>
 <20221107062514.2851047-3-anshuman.khandual@arm.com>
 <8f6d3424-2650-8e8b-61f7-1431aec4633b@arm.com>
 <4efc0ae1-564e-dd05-842a-46fb1aeb4ad8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4efc0ae1-564e-dd05-842a-46fb1aeb4ad8@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Anshuman,

Apologies for the delayi n reviewing this.

On Fri, Nov 18, 2022 at 12:09:07PM +0530, Anshuman Khandual wrote:
> On 11/9/22 17:00, Suzuki K Poulose wrote:
> > On 07/11/2022 06:25, Anshuman Khandual wrote:
> >> Although BRBE is an armv8 speciifc HW feature, abstracting out its various
> >> function callbacks at the struct arm_pmu level is preferred, as it cleaner
> >> , easier to follow and maintain.
> >>
> >> Besides some helpers i.e brbe_supported(), brbe_probe() and brbe_reset()
> >> might not fit seamlessly, when tried to be embedded via existing arm_pmu
> >> helpers in the armv8 implementation.
> >>
> >> Updates the struct arm_pmu to include all required helpers that will drive
> >> BRBE functionality for a given PMU implementation. These are the following.
> >>
> >> - brbe_filter    : Convert perf event filters into BRBE HW filters
> >> - brbe_probe    : Probe BRBE HW and capture its attributes
> >> - brbe_enable    : Enable BRBE HW with a given config
> >> - brbe_disable    : Disable BRBE HW
> >> - brbe_read    : Read BRBE buffer for captured branch records
> >> - brbe_reset    : Reset BRBE buffer
> >> - brbe_supported: Whether BRBE is supported or not
> >>
> >> A BRBE driver implementation needs to provide these functionalities.
> > 
> > Could these not be hidden from the generic arm_pmu and kept in the
> > arm64 pmu backend  ? It looks like they are quite easy to simply
> > move these to the corresponding hooks in arm64 pmu.
> 
> We have had this discussion multiple times in the past [1], but I still
> believe, keeping BRBE implementation hooks at the PMU level rather than
> embedding them with other PMU events handling, is a much better logical
> abstraction.
> 
> [1] https://lore.kernel.org/all/c3804290-bdb1-d1eb-3526-9b0ce4c8e8b1@arm.com/
> 
> --------------------------------------------------------------------------
> > 
> > One thing to answer in the commit msg is why we need the hooks here.  
> > Have we concluded that adding BRBE hooks to struct arm_pmu for what is 
> > an armv8 specific feature is the right approach? I don't recall 
> > reaching that conclusion.
> 
> Although it might be possible to have this implementation embedded in
> the existing armv8 PMU implementation, I still believe that the BRBE
> functionalities abstracted out at the arm_pmu level with a separate
> config option is cleaner, easier to follow and to maintain as well.
> 
> Besides some helpers i.e brbe_supported(), brbe_probe() and brbe_reset()
> might not fit seamlessly, when tried to be embedded via existing arm_pmu
> helpers in the armv8 implementation.
> 
> Nonetheless if arm_pmu based additional BRBE helpers is absolutely a no
> go for folks here in general, will explore arm64 based implementation.
> ----------------------------------------------------------------------------
> 
> I am still waiting for maintainer's take on this issue. I will be happy to
> rework this series to move all these implementation inside arm64 callbacks
> instead, if that is required or preferred by the maintainers. But according
> to me, this current abstraction layout is much better.

To be honest, I'm not sure what's best right now; but at the moment it's not
clear to me why this couldn't fit within the existing hooks.

Above you say brbe_supported() / brbe_probe() / brbe_reset() didn't fit
seamlessly; can you give an example of problem? I think I'm missing something
obvious.

Thanks,
Mark.
