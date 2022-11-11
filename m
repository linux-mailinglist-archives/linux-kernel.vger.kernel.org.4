Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91686264B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiKKWgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbiKKWgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:36:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5BE77E6C;
        Fri, 11 Nov 2022 14:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4067E62112;
        Fri, 11 Nov 2022 22:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B131C433C1;
        Fri, 11 Nov 2022 22:36:37 +0000 (UTC)
Date:   Fri, 11 Nov 2022 22:36:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: errata: Workaround possible Cortex-A715
 [ESR|FAR]_ELx corruption
Message-ID: <Y27Ob8aRX919Hhu0@arm.com>
References: <20221027023915.1318100-1-anshuman.khandual@arm.com>
 <20221027023915.1318100-3-anshuman.khandual@arm.com>
 <Y2v9EiNR40x/cCQm@arm.com>
 <73c40107-0d7a-d988-c817-7bba6d72c371@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c40107-0d7a-d988-c817-7bba6d72c371@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 08:45:07AM +0530, Anshuman Khandual wrote:
> On 11/10/22 00:48, Catalin Marinas wrote:
> > On Thu, Oct 27, 2022 at 08:09:15AM +0530, Anshuman Khandual wrote:
> >> +#define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
> >> +static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
> >> +					   unsigned long addr,
> >> +					   pte_t *ptep)
> >> +{
> >> +	pte_t pte = ptep_get_and_clear(vma->vm_mm, addr, ptep);
> >>  
> >> +	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
> >> +		/*
> >> +		 * Break-before-make (BBM) is required for all user space mappings
> >> +		 * when the permission changes from executable to non-executable
> >> +		 * in cases where cpu is affected with errata #2645198.
> >> +		 */
> >> +		if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
> >> +			__flush_tlb_range(vma, addr, addr + PAGE_SIZE, PAGE_SIZE, false, 3);
> > 
> > Why not flush_tlb_page() here?
> > 
> > But more importantly, can we not use ptep_clear_flush() instead (and
> 
> Something like ...
> 
> ptep_modify_prot_start -
> 
> if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
> 	if (pte_user_exec(READ_ONCE(*ptep)) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
> 		return ptep_clear_flush(vma, addr, ptep);
> } else {
> 	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
> }

Yes, this should work but avoid the 'else' when you have a return, so
something like:

	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
	    cpus_have_const_cap(ARM64_WORKAROUND_2645198) &&
	    pte_user_exec(READ_ONCE(*ptep)))
		return ptep_clear_flush(vma, addr, ptep);

	return ptep_get_and_clear(vma->vm_mm, addr, ptep);


> > huge_ptep_clear_flush())? They return the pte and do the TLBI.
> 
> huge_ptep_modify_prot_start -
> 
> if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
> 	if (pte_user_exec(READ_ONCE(*ptep)) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
> 		return huge_ptep_clear_flush(vma, addr, ptep);
> } else {
> 	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> }
> 
> pte_user_exec(READ_ONCE(*ptep) should identify an user exec mapping even though
> ptep represents a cont PTE/PMD huge page ? OR should huge_ptep_get() helper be
> used instead ?

This should work as a shortcut. The contiguous ptes should all be the
same, so it's sufficient to check one of them.

-- 
Catalin
