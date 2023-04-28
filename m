Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E364F6F15D6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345937AbjD1Kju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345929AbjD1Kj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:39:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31F335FC1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:38:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6F0BC14;
        Fri, 28 Apr 2023 03:38:40 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BE0C3F64C;
        Fri, 28 Apr 2023 03:37:55 -0700 (PDT)
Date:   Fri, 28 Apr 2023 11:37:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 01/60] arm64: kernel: Disable latent_entropy GCC
 plugin in early C runtime
Message-ID: <ZEuh/V6luuvCjd55@FVFF77S0Q05N>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307140522.2311461-2-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 03:04:23PM +0100, Ard Biesheuvel wrote:
> Avoid build issues in the early C code related to the latent_entropy GCC
> plugin, by incorporating the C flags fragment that disables it.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Just to check, are you seeing issues today? IIUC the plugin only instruments
functions which are explicitly marked with __latent_entropy, and if we're
seeing that happen unexpectedly (or due to that being applying to __meminit /
__init), we might need to do likewise for other noinstr code.

Regardless, for this patch:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/pi/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
> index 4c0ea3cd4ea406b6..c844a0546d7f0e62 100644
> --- a/arch/arm64/kernel/pi/Makefile
> +++ b/arch/arm64/kernel/pi/Makefile
> @@ -3,6 +3,7 @@
>  
>  KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
>  		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
> +		   $(DISABLE_LATENT_ENTROPY_PLUGIN) \
>  		   $(call cc-option,-mbranch-protection=none) \
>  		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
>  		   -include $(srctree)/include/linux/hidden.h \
> -- 
> 2.39.2
> 
> 
