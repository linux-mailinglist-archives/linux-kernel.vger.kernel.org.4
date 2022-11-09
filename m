Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC107623351
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiKITSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKITSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:18:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA91633F;
        Wed,  9 Nov 2022 11:18:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FC3561C9A;
        Wed,  9 Nov 2022 19:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3F3C433D6;
        Wed,  9 Nov 2022 19:18:46 +0000 (UTC)
Date:   Wed, 9 Nov 2022 19:18:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: errata: Workaround possible Cortex-A715
 [ESR|FAR]_ELx corruption
Message-ID: <Y2v9EiNR40x/cCQm@arm.com>
References: <20221027023915.1318100-1-anshuman.khandual@arm.com>
 <20221027023915.1318100-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027023915.1318100-3-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 08:09:15AM +0530, Anshuman Khandual wrote:
> +#define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
> +static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
> +					   unsigned long addr,
> +					   pte_t *ptep)
> +{
> +	pte_t pte = ptep_get_and_clear(vma->vm_mm, addr, ptep);
>  
> +	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
> +		/*
> +		 * Break-before-make (BBM) is required for all user space mappings
> +		 * when the permission changes from executable to non-executable
> +		 * in cases where cpu is affected with errata #2645198.
> +		 */
> +		if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
> +			__flush_tlb_range(vma, addr, addr + PAGE_SIZE, PAGE_SIZE, false, 3);

Why not flush_tlb_page() here?

But more importantly, can we not use ptep_clear_flush() instead (and
huge_ptep_clear_flush())? They return the pte and do the TLBI.

-- 
Catalin
