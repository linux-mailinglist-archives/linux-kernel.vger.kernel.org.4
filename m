Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11370D6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjEWIP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbjEWIOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:14:55 -0400
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755381BC8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:13:06 -0700 (PDT)
Date:   Tue, 23 May 2023 08:13:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684829584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lo+8u5rwataPck7mvk/JQ6bPb50N+x5IthJ2AVYj7TE=;
        b=T5pEjF+rE92i+/I/aK5r3XFh/21/ovkhnZi11b8TR+6H0j1dSUORt9wRBEWHqUDnRiD6Z6
        mpYeaJNiFi+aqKaOpLxZX5SWooZ0yiOPOZXr3wKe5SVOr3vHoFfRRkHS4jLX0qkvdiiuOX
        zve6banWIftcCrPi7Jf4gPt2hb1A1gY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
Subject: Re: [PATCH 5/5] arm64/sysreg: Convert OSLAR_EL1 to automatic
 generation
Message-ID: <ZGx1jT4nQ9HEVWSE@linux.dev>
References: <20230419-arm64-syreg-gen-v1-0-936cd769cb9e@kernel.org>
 <20230419-arm64-syreg-gen-v1-5-936cd769cb9e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419-arm64-syreg-gen-v1-5-936cd769cb9e@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 05:22:44PM +0100, Mark Brown wrote:
> Convert OSLAR_EL1 to automatic generation as per DDI0601 2023-03. No
> functional change.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/sysreg.h | 3 ---
>  arch/arm64/tools/sysreg         | 5 +++++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 09de958e79ed..3b51e532caa9 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -140,9 +140,6 @@
>  #define SYS_DBGWCRn_EL1(n)		sys_reg(2, 0, 0, n, 7)
>  #define SYS_MDRAR_EL1			sys_reg(2, 0, 1, 0, 0)
>  
> -#define SYS_OSLAR_EL1			sys_reg(2, 0, 1, 0, 4)
> -#define OSLAR_EL1_OSLK			BIT(0)
> -
>  #define SYS_OSLSR_EL1			sys_reg(2, 0, 1, 1, 4)
>  #define OSLSR_EL1_OSLM_MASK		(BIT(3) | BIT(0))
>  #define OSLSR_EL1_OSLM_NI		0

Should the OSLSR_EL1 definitions be rolled over to the generated scheme
as well?

> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index a5ae0e19fc9f..84df0b7feb45 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -83,6 +83,11 @@ Res0	5:1
>  Field	0	SS
>  EndSysreg
>  
> +Sysreg	OSLAR_EL1	2	0	1	0	4
> +Res0	63:1
> +Field	0	OSLK
> +EndSysreg
> +
>  Sysreg ID_PFR0_EL1	3	0	0	1	0
>  Res0	63:32
>  UnsignedEnum	31:28	RAS
> 
> -- 
> 2.30.2
> 

-- 
Thanks,
Oliver
