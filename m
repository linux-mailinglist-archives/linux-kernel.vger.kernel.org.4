Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6D1669399
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbjAMKBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241216AbjAMKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:01:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E664E5B145
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:59:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 949DEB820F8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C09CC433F0;
        Fri, 13 Jan 2023 09:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673603953;
        bh=+0jEHX2eLOEh+tvsJojwQzPDmdx+EmKB2O7b65fWGmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJlfDLKVBgxDAU0kU9uImLLbUdDYpEHuUtpYrffMns5Dy5BgerqP5fnOaCZ1uE+T1
         XXncCxzMhXz8e15/SEE+Qp/CyLFo2R8kY1WB0r50kh+qG0xGoWWAhyZJKUoM3yENrb
         3kcaI4i3484Pe8GZjqiuiCvnp73vgV02inoYLBzfdkPlk/l4Q78fxPobRWdYmtOgMo
         QML4nLjODqv33m1sFT7cVGu1hVs4fBqed6IrQcuzLwG9bScAdaMHCTkLI8Eu/R2UDH
         +JHsk469bt49ghONXa6HYUYAhBQx4gkYGbSOpm50/2l7W8wydQzP80zF0sEeUS2w/v
         OpFqe8x2fRnjw==
Date:   Fri, 13 Jan 2023 09:59:08 +0000
From:   Will Deacon <will@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: smccc: Include alternative-macros.h
Message-ID: <20230113095907.GC12235@willie-the-truck>
References: <20230112182548.537295-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112182548.537295-1-quic_eberman@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:25:47AM -0800, Elliot Berman wrote:
> Fix build error when CONFIG_ARM64_SVE is selected and
> asm/alternative-macros.h wasn't implicitly included by another header.
> 
> ./include/linux/arm-smccc.h:387:25: error: expected string literal before `ALTERNATIVE'
>   387 | #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl __arm_smccc_sve_check \n", \
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  include/linux/arm-smccc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 220c8c60e021..6a627cdbbdec 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -383,6 +383,7 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>  
>  /* nVHE hypervisor doesn't have a current thread so needs separate checks */
>  #if defined(CONFIG_ARM64_SVE) && !defined(__KVM_NVHE_HYPERVISOR__)
> +#include <asm/alternative-macros.h>
>  
>  #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl __arm_smccc_sve_check \n", \
>  				    ARM64_SVE)
> 
> base-commit: 68a63a412d18bd2e2577c8928139f92541afa7a6

Acked-by: Will Deacon <will@kernel.org>

Will
