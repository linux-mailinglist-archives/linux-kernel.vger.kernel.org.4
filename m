Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3715A72D89E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbjFMEa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbjFMEai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:30:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB8F04215
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:27:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 081661FB;
        Mon, 12 Jun 2023 21:27:23 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77E0B3F587;
        Mon, 12 Jun 2023 21:26:34 -0700 (PDT)
Message-ID: <1dca7ec8-a0d1-3038-7e9f-0d2934dc2e37@arm.com>
Date:   Tue, 13 Jun 2023 09:56:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 14/14] arm64/sysreg: Convert TRBIDR_EL1 register to
 automatic generation
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
 <20230602062552.565992-15-anshuman.khandual@arm.com>
 <4de1ec32-f07b-4eca-99e2-f71a08f5cd5b@sirena.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <4de1ec32-f07b-4eca-99e2-f71a08f5cd5b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/23 17:42, Mark Brown wrote:
> On Fri, Jun 02, 2023 at 11:55:52AM +0530, Anshuman Khandual wrote:
>> This converts TRBIDR_EL1 register to automatic generation without
>> causing any functional change.
> 
>> +Sysreg	TRBIDR_EL1	3	0	9	11	7
>> +Res0	63:12
>> +Field	11:8	EA
> 
> EA is another field which looks like it should be an enum, as with the
> others this shouldn't be a blocker and could be done incrementally.

Will fold the following changes in this patch.

--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2267,7 +2267,11 @@ EndSysreg
 
 Sysreg TRBIDR_EL1      3       0       9       11      7
 Res0   63:12
-Field  11:8    EA
+Enum   11:8    EA
+       0b0000  NON_DESC
+       0b0001  IGNORE
+       0b0010  SERROR
+EndEnum
 Res0   7:6
 Field  5       F
 Field  4       P


> 
>> +Res0	7:6
>> +Field	5	F
>> +Field	4	P
>> +Field	3:0	Align
> 
> Align arguably too though really it's just encoding the relevant power
> of 2 with the enum coming from the fact that it's limited to at most 2KB
> alignment so a Field may well make more sense.

Can fold the following changes in this patch (if required) unless the Field
looks better than Enum.

--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2275,5 +2275,18 @@ EndEnum
 Res0   7:6
 Field  5       F
 Field  4       P
-Field  3:0     Align
+Enum   3:0     Align
+       0b0000  BYTE
+       0b0001  HALF_WORD
+       0b0010  WORD
+       0b0011  DOUBLE_WORD
+       0b0100  16_BYTES
+       0b0101  32_BYTES
+       0b0110  64_BYTES
+       0b0111  128_BYTES
+       0b1000  156_BYTES
+       0b1001  512_BYTES
+       0b1010  1_KB
+       0b1011  2_KB
+EndEnum
 EndSysreg

> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
