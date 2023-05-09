Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820C26FC4FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjEIL1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjEIL1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:27:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CADC526AF
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:27:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EAA0FEC;
        Tue,  9 May 2023 04:28:34 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.56.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D1A33F67D;
        Tue,  9 May 2023 04:27:48 -0700 (PDT)
Date:   Tue, 9 May 2023 12:27:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: perf: Mark all accessor functions inline
Message-ID: <ZFouMZpJEY23l9ZY@FVFF77S0Q05N>
References: <cover.1683561087.git.geert+renesas@glider.be>
 <3a7d9bc7470aa2d85696ee9765c74f8c03fb5454.1683561482.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a7d9bc7470aa2d85696ee9765c74f8c03fb5454.1683561482.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 06:05:18PM +0200, Geert Uytterhoeven wrote:
> When just including <asm/arm_pmuv3.h>:
> 
>     arch/arm/include/asm/arm_pmuv3.h:110:13: error: ‘write_pmevtypern’ defined but not used [-Werror=unused-function]
>       110 | static void write_pmevtypern(int n, unsigned long val)
> 	  |             ^~~~~~~~~~~~~~~~
>     arch/arm/include/asm/arm_pmuv3.h:103:13: error: ‘write_pmevcntrn’ defined but not used [-Werror=unused-function]
>       103 | static void write_pmevcntrn(int n, unsigned long val)
> 	  |             ^~~~~~~~~~~~~~~
>     arch/arm/include/asm/arm_pmuv3.h:95:22: error: ‘read_pmevcntrn’ defined but not used [-Werror=unused-function]
>        95 | static unsigned long read_pmevcntrn(int n)
> 	  |                      ^~~~~~~~~~~~~~
> 
> Fix this by adding the missing "inline" keywords to the three accessor
> functions that lack them.
> 
> Fixes: 009d6dc87a568db6 ("ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm/include/asm/arm_pmuv3.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
> index 78d3d4b82c6c2598..f4db3e75d75f024e 100644
> --- a/arch/arm/include/asm/arm_pmuv3.h
> +++ b/arch/arm/include/asm/arm_pmuv3.h
> @@ -92,7 +92,7 @@
>  
>  #define RETURN_READ_PMEVCNTRN(n) \
>  	return read_sysreg(PMEVCNTR##n)
> -static unsigned long read_pmevcntrn(int n)
> +static inline unsigned long read_pmevcntrn(int n)
>  {
>  	PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
>  	return 0;
> @@ -100,14 +100,14 @@ static unsigned long read_pmevcntrn(int n)
>  
>  #define WRITE_PMEVCNTRN(n) \
>  	write_sysreg(val, PMEVCNTR##n)
> -static void write_pmevcntrn(int n, unsigned long val)
> +static inline void write_pmevcntrn(int n, unsigned long val)
>  {
>  	PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
>  }
>  
>  #define WRITE_PMEVTYPERN(n) \
>  	write_sysreg(val, PMEVTYPER##n)
> -static void write_pmevtypern(int n, unsigned long val)
> +static inline void write_pmevtypern(int n, unsigned long val)
>  {
>  	PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
>  }
> -- 
> 2.34.1
> 
