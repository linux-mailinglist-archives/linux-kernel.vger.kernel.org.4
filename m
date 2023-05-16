Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419FC704385
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjEPCng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEPCnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:43:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D529BE79
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:43:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD1B12F4;
        Mon, 15 May 2023 19:44:17 -0700 (PDT)
Received: from [10.163.70.134] (unknown [10.163.70.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0596D3F663;
        Mon, 15 May 2023 19:43:30 -0700 (PDT)
Message-ID: <b9a15953-ad88-7ca6-f485-116ac0217aae@arm.com>
Date:   Tue, 16 May 2023 08:13:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2] arm64: Disable EL2 traps for BRBE instructions
 executed in EL1
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230515105328.239204-1-anshuman.khandual@arm.com>
 <86ilctn233.wl-maz@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <86ilctn233.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/15/23 19:12, Marc Zyngier wrote:
> On Mon, 15 May 2023 11:53:28 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> This disables EL2 traps for BRBE instructions executed in EL1. This would
>> enable BRBE to be configured and used successfully in the guest kernel.
>> While here, this updates Documentation/arm64/booting.rst as well.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This patch applies on v6.4-rc2
>>
>> Changes in V2:
>>
>> - Updated Documentation/arm64/booting.rst
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/all/20230324055127.2228330-1-anshuman.khandual@arm.com/
>>
>>  Documentation/arm64/booting.rst    |  8 ++++++++
>>  arch/arm64/include/asm/el2_setup.h | 10 ++++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
>> index ffeccdd6bdac..cb9e151f6928 100644
>> --- a/Documentation/arm64/booting.rst
>> +++ b/Documentation/arm64/booting.rst
>> @@ -379,6 +379,14 @@ Before jumping into the kernel, the following conditions must be met:
>>  
>>      - SMCR_EL2.EZT0 (bit 30) must be initialised to 0b1.
>>  
>> +  For CPUs with the Branch Record Buffer Extension (FEAT_BRBE):
>> +
>> + - If the kernel is entered at EL1 and EL2 is present:
>> +
>> +    - HFGITR_EL2.nBRBINJ (bit 55) must be initialised to 0b1.
>> +
>> +    - HFGITR_EL2.nBRBIALL (bit 56) must be initialised to 0b1.
>> +
>>  The requirements described above for CPU mode, caches, MMUs, architected
>>  timers, coherency and system registers apply to all CPUs.  All CPUs must
>>  enter the kernel in the same exception level.  Where the values documented
>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>> index 037724b19c5c..06bf321a17be 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -161,6 +161,16 @@
>>  	msr_s	SYS_HFGWTR_EL2, x0
>>  	msr_s	SYS_HFGITR_EL2, xzr
>>  
>> +	mrs	x1, id_aa64dfr0_el1
>> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
>> +	cbz	x1, .Lskip_brbe_\@
>> +
>> +	mov	x0, xzr
>> +	orr	x0, x0, #HFGITR_EL2_nBRBIALL
>> +	orr	x0, x0, #HFGITR_EL2_nBRBINJ
>> +	msr_s	SYS_HFGITR_EL2, x0
> 
> This will break badly if someone inserts something between this hunk
> and the initial setting of HFGITR_EL2. I'd really prefer a RMW
> approach.  It's not that this code has to be optimised anyway.

Something like this instead ? So that even if there are more changes
before this hunk, it will be fetched correctly with first mrs_s and
only additional bits related to BRBE will be set there after.

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 037724b19c5c..bfaf41ad9c4e 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -161,6 +161,16 @@
        msr_s   SYS_HFGWTR_EL2, x0
        msr_s   SYS_HFGITR_EL2, xzr
 
+       mrs     x1, id_aa64dfr0_el1
+       ubfx    x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+       cbz     x1, .Lskip_brbe_\@
+
+       mrs_s   x0, SYS_HFGITR_EL2
+       orr     x0, x0, #HFGITR_EL2_nBRBIALL
+       orr     x0, x0, #HFGITR_EL2_nBRBINJ
+       msr_s   SYS_HFGITR_EL2, x0
+
+.Lskip_brbe_\@:
        mrs     x1, id_aa64pfr0_el1             // AMU traps UNDEF without AMU
        ubfx    x1, x1, #ID_AA64PFR0_EL1_AMU_SHIFT, #4
        cbz     x1, .Lskip_fgt_\@

