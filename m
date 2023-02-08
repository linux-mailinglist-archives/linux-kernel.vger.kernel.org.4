Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFDF68F7FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjBHT1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBHT1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:27:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1B795279
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:27:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CE181477;
        Wed,  8 Feb 2023 11:27:45 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF7063F703;
        Wed,  8 Feb 2023 11:27:01 -0800 (PST)
Date:   Wed, 8 Feb 2023 19:26:59 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V7 3/6] arm64/perf: Add branch stack support in struct
 arm_pmu
Message-ID: <Y+P3g8/85FIe/sUK@FVFF77S0Q05N.cambridge.arm.com>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-4-anshuman.khandual@arm.com>
 <Y8ARAjUaE44y+Cw3@FVFF77S0Q05N>
 <0351f0bc-d94b-957f-8e03-6525e47d63a4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0351f0bc-d94b-957f-8e03-6525e47d63a4@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 09:45:22AM +0530, Anshuman Khandual wrote:
> 
> On 1/12/23 19:24, Mark Rutland wrote:
> > On Thu, Jan 05, 2023 at 08:40:36AM +0530, Anshuman Khandual wrote:
> >>  struct arm_pmu {
> >>  	struct pmu	pmu;
> >>  	cpumask_t	supported_cpus;
> >>  	char		*name;
> >>  	int		pmuver;
> >> +	int		features;
> >>  	irqreturn_t	(*handle_irq)(struct arm_pmu *pmu);
> >>  	void		(*enable)(struct perf_event *event);
> >>  	void		(*disable)(struct perf_event *event);
> > 
> > Hmm, we already have the secure_access field separately. How about we fold that
> > in and go with:
> > 
> > 	unsigned int	secure_access    : 1,
> > 			has_branch_stack : 1;
> 
> Something like this would work, but should we use __u32 instead of unsigned int
> to ensure 32 bit width ?

I don't think that's necessary; the exact size doesn't really matter, and
unsigned int is 32-bits on all targets suppropted by Linux, not just arm and
arm64.

I do agree that if this were a userspace ABI detail, it might be preferable to
use __u32. However, I think using it here gives the misleading impression that
there is an ABI concern when there is not, and as above it's not necessary, so
I'd prefer unsigned int here.

Thanks,
Mark.
