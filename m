Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C86C5DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 05:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCWE0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 00:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWEZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 00:25:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B873AD31;
        Wed, 22 Mar 2023 21:25:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0106B4B3;
        Wed, 22 Mar 2023 21:26:39 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C720E3F766;
        Wed, 22 Mar 2023 21:25:50 -0700 (PDT)
Message-ID: <f7e24b0c-3e33-755a-65c9-2ee78d5a79ec@arm.com>
Date:   Thu, 23 Mar 2023 09:55:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V9 00/10] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230315051444.1683170-1-anshuman.khandual@arm.com>
 <655ff114-99d2-4612-9167-cc8688f2b6b2@sirena.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <655ff114-99d2-4612-9167-cc8688f2b6b2@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 3/22/23 00:32, Mark Brown wrote:
> On Wed, Mar 15, 2023 at 10:44:34AM +0530, Anshuman Khandual wrote:
>> This series enables perf branch stack sampling support on arm64 platform
>> via a new arch feature called Branch Record Buffer Extension (BRBE). All
>> relevant register definitions could be accessed here.
>>
>> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> While looking at another feature I noticed that HFGITR_EL2 has two traps
> for BRBE instructions, nBRBINJ and nBRBIALL which trap BRB INJ and BRB
> IALL.  Even if we don't use those right now does it make sense to

Right, current branch stack sampling experiments have been on EL2 host itself.

> document a requirement for those traps to be disabled now in case we
> need them later, and do so during EL2 setup for KVM guests?  That could
> always be done incrementally.
Unlike all other instruction trap enable fields in SYS_HFGITR_EL2, these BRBE
instructions ones are actually inverted in semantics i.e the particular fields
need to be set for these traps to be disabled in EL2.

SYS_HFGITR_EL2.nBRBIALL
SYS_HFGITR_EL2.nBRBINJ

By default entire SYS_HFGITR_EL2 is set as cleared during init and that would
prevent a guest from using BRBE.

init_kernel_el()
	init_el2()
		init_el2_state()
			__init_el2_fgt()
				........
				msr_s   SYS_HFGITR_EL2, xzr
				........

I guess something like the following (untested) needs to be done, to enable
BRBE in guests.

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 037724b19c5c..309708127a2a 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -161,6 +161,15 @@
        msr_s   SYS_HFGWTR_EL2, x0
        msr_s   SYS_HFGITR_EL2, xzr
 
+       mrs     x1, id_aa64dfr0_el1
+       ubfx    x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+       cbz     x1, .Lskip_brbe_\@
+       mov     x0, xzr
+       orr     x0, x0, #HFGITR_EL2_nBRBIALL
+       orr     x0, x0, #HFGITR_EL2_nBRBINJ
+       msr_s   SYS_HFGITR_EL2, x0
+
+.Lskip_brbe_\@:
        mrs     x1, id_aa64pfr0_el1             // AMU traps UNDEF without AMU
        ubfx    x1, x1, #ID_AA64PFR0_EL1_AMU_SHIFT, #4
        cbz     x1, .Lskip_fgt_\@
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index b3bc03ee22bd..3b939c42f3b8 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -527,6 +527,9 @@
 #define SYS_HFGITR_EL2                 sys_reg(3, 4, 1, 1, 6)
 #define SYS_HACR_EL2                   sys_reg(3, 4, 1, 1, 7)
 
+#define        HFGITR_EL2_nBRBIALL             (BIT(56))
+#define HFGITR_EL2_nBRBINJ             (BIT(55))
+
 #define SYS_TTBR0_EL2                  sys_reg(3, 4, 2, 0, 0)
 #define SYS_TTBR1_EL2                  sys_reg(3, 4, 2, 0, 1)
 #define SYS_TCR_EL2                    sys_reg(3, 4, 2, 0, 2)


> 
> I've got a patch adding the definition of that register to sysreg which
> I should be sending shortly, no need to duplicate that effort.

Sure, I assume you are moving the existing definition for SYS_HFGITR_EL2 along
with all its fields from ../include/asm/sysreg.h to ../tools/sysreg. Right, it
makes sense.

- Anshuman
