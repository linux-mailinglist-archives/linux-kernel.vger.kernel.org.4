Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2190662F6E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbiKRONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241108AbiKRONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:13:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACADB0D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:13:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 878BFB823AE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9015C433C1;
        Fri, 18 Nov 2022 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668780803;
        bh=JCjICSm8pXwo9orCVyEXmyIQs3uhVXt10DDdNuRS6yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o34jLMToHAJQaDuVlBaqdI6ZPbgtVBeVlmHtaPkN3vcCL/zcek2FNP2mGC+mjdlzE
         iqVjbPgqRBnQWBzZ9oht3OodMPHlycjaR0HNDfZok/Ly6aZVv0X8fYoJn6fLffg5i3
         xzE6fvlZH/AdtQBzLauYdUlh/YDCtW5EDS3bg+5HeirZJGFVMfF/JFM55z7kzHfsfu
         5p5gIbJCXHXiMym6GENIYbgI/zGmULbn+5YmdROvHqT9IUwdGzyjtWbEs2uZg2PLuq
         5BD07dSI5P3rQ5NiTXGsxXB3D9cZQjkWs9RFFunXJ8ikPdsSSbHtLLJwWsD04LOp0C
         DHhYbVEFkXU5g==
Date:   Fri, 18 Nov 2022 14:13:18 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Intercept pfn changes in set_pte_at()
Message-ID: <20221118141317.GF4046@willie-the-truck>
References: <20221116031001.292236-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116031001.292236-1-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 08:40:01AM +0530, Anshuman Khandual wrote:
> Changing pfn on a user page table mapped entry, without first going through
> break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
> to intercept such changes, via an updated pgattr_change_is_safe(). This new
> check happens via __check_racy_pte_update(), which has now been renamed as
> __check_safe_pte_update().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com> 
> Cc: Andrew Morton <akpm@linux-foundation.org> 
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.1-rc4
> 
>  arch/arm64/include/asm/pgtable.h | 8 ++++++--
>  arch/arm64/mm/mmu.c              | 8 +++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)

I remember Mark saying that BBM is sometimes violated by the core code in
cases where the pte isn't actually part of a live pgtable (e.g. if it's on
the stack or part of a newly allocated table). Won't that cause false
positives here?

Will
