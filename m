Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBBF679750
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjAXMJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjAXMJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:09:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DAD2330C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:09:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A399B8117B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C380AC433D2;
        Tue, 24 Jan 2023 12:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674562159;
        bh=xe566WnBUK91cLXhbLFUcuJ0dYHv1Hz6QseOUQ+OQc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ub0WnhQoXGSCa0JzYkItDwmhZGG03zhWsbTgQvFKchw/EkQaFh7T2Q8xxvedLJjpl
         bjokgal61ocp5FKogWw5bCcagr2GuaB5XyJzw9a+z/urA9d42ZibajHHO08ACHFrLd
         Lqww+3qOmIi4o0yTQn6wlVwMkvnKtf7vNoNzIPunkYpa/7OEJ2twYRNYp4Kgul9KXE
         JhaQl/3IxZ1sC46oFvLYcd2F0QB9xul+G/7kWiAWw91cEC5m5oK0Pjth80z6tY7yIn
         GWhp4wEDAFKYRo7ZcciNtqgaAFam5MXBMFfX4wBRciB/xkuNvvlp3FsD+Gle8/yzh8
         YWBzTuLbAP93A==
Date:   Tue, 24 Jan 2023 12:09:15 +0000
From:   Will Deacon <will@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arch: Enable function alignment for arm64
Message-ID: <20230124120913.GA26449@willie-the-truck>
References: <20221208053649.540891-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208053649.540891-1-almasrymina@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 09:36:48PM -0800, Mina Almasry wrote:
> We recently ran into a double-digit percentage hackbench regression
> when backporting commit 12df140f0bdf ("mm,hugetlb: take hugetlb_lock
> before decrementing h->resv_huge_pages") to an older kernel. This was
> surprising since hackbench does use hugetlb pages at all and the
> modified code is not invoked. After some debugging we found that the
> regression can be fixed by back-porting commit d49a0626216b ("arch:
> Introduce CONFIG_FUNCTION_ALIGNMENT") and enabling function alignment
> for arm64. I suggest enabling it by default for arm64 if possible.
> 
> Tested by examing function alignment on a compiled object file
> before/after:
> 
> After this patch:
> 
> $ ~/is-aligned.sh mm/hugetlb.o 16
> file=mm/hugetlb.o, alignment=16
> total number of functions: 146
> total number of unaligned: 0
> 
> Before this patch:
> 
> $ ~/is-aligned.sh mm/hugetlb.o 16
> file=mm/hugetlb.o, alignment=16
> total number of functions: 146
> total number of unaligned: 94
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index cf6d1cd8b6dc..bcc9e1578937 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -235,6 +235,7 @@ config ARM64
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select TRACE_IRQFLAGS_NMI_SUPPORT
>  	select HAVE_SOFTIRQ_ON_OWN_STACK
> +	select FUNCTION_ALIGNMENT_16B
>  	help
>  	  ARM 64-bit (AArch64) Linux support.

This increases the size of .text for a defconfig build by ~2%, so I think it
would be nice to have some real numbers for the performance uplift. Are you
able to elaborate beyond "double-digit percentage hackbench regression"?

In general, however, I'm supportive of the patch (and it seems that x86
does the same thing) so:

Acked-by: Will Deacon <will@kernel.org>

Will
