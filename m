Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1CD5F037B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 06:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiI3EHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiI3EHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:07:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 929E81005D9;
        Thu, 29 Sep 2022 21:07:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5DA615A1;
        Thu, 29 Sep 2022 21:07:17 -0700 (PDT)
Received: from [10.162.41.10] (unknown [10.162.41.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51FB3F73D;
        Thu, 29 Sep 2022 21:07:07 -0700 (PDT)
Message-ID: <8751bc38-9020-ba5f-d2d6-dd7486e1709a@arm.com>
Date:   Fri, 30 Sep 2022 09:37:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 1/7] arm64/perf: Add BRBE registers and fields
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, Marc Zyngier <maz@kernel.org>
References: <20220929075857.158358-1-anshuman.khandual@arm.com>
 <20220929075857.158358-2-anshuman.khandual@arm.com>
 <YzWBokiO1KSZNtcl@sirena.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YzWBokiO1KSZNtcl@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 16:59, Mark Brown wrote:
> On Thu, Sep 29, 2022 at 01:28:51PM +0530, Anshuman Khandual wrote:
> 
> Thanks for doing this work - I did spot a few small issues though.
> 
>>  /* id_aa64dfr0 */
>> +#define ID_AA64DFR0_BRBE_SHIFT		52
>>  #define ID_AA64DFR0_MTPMU_SHIFT		48
>>  #define ID_AA64DFR0_TRBE_SHIFT		44
>>  #define ID_AA64DFR0_TRACE_FILT_SHIFT	40
>> @@ -848,6 +952,9 @@
>>  #define ID_AA64DFR0_PMSVER_8_2		0x1
>>  #define ID_AA64DFR0_PMSVER_8_3		0x2
>>  
>> +#define ID_AA64DFR0_BRBE		0x1
>> +#define ID_AA64DFR0_BRBE_V1P1		0x2
>> +
>>  #define ID_DFR0_PERFMON_SHIFT		24
>>  
>>  #define ID_DFR0_PERFMON_8_0		0x3
> 
> This is already done in -next as a result of ID_AA64DFR0_EL1 being
> converted, the enumberation define comes out as
> ID_AA64DFR0_EL1_BRBE_BRBE_V1P1.

Right. I will rebase the series on upcoming 6.1-rc1 which should have all the
current -next patches including ID_AA64DFR0_EL1 migration into tools/sysreg.
This should just fall in place.

> 
>> +# This is just a dummy register declaration to get all common field masks and
>> +# shifts for accessing given BRBINF contents.
>> +Sysreg	BRBINF_EL1	2	1	8	0	0
>> +Res0	63:47
>> +Field	46	CCU
>> +Field	45:32	CC
>> +Res0	31:18
>> +Field	17	LASTFAILED
>> +Field	16	TX
> 
> According to DDI0487I.a bit 16 is called T not TX.

I understand :) The intention here was to keep the field name associated with
"transaction" some how. But I guess, it would be more important to keep it as
is matching the ARM ARM than something for readability purpose. Will change it
as 'T'.

> 
>> +Res0	15:14
>> +Enum	13:8		TYPE
> 
> It's probably worth noting in the comment the issue with Enums here
> that's meaning you're not using a SysregFields - I'm not sure what

Sure, will add a comment describing the problem of using enum elements inside
SysregFields definition.

> people will think of this but providing a definition using the ID for
> the 0th register does seem expedient.

I understand your concern but this turned out to be a better option

- Original sysreg.h based definitions had all field masks on the right end

	- When reading (reg >> field_shift) & field_mask
	- When writing (val & field_mask) << field_shift

- tools/sysreg format creates in-place field masks

	- When reading (reg & field_mask) >> field_shift
	- When writing (val << field_shift) & field_mask

- After moving some BRBE registers into tools/sysreg, the driver code had
  to be changed to accommodate these new write/read methods

- To avoid mix up in the BRBE driver, all BRBINF register fields need to be
  converted into in place masks, either in sysreg.h itself or moving into
  tools/sysreg

Moving BRBE fields into tools/sysreg via a dummy BRBINF_EL1 register seems
to achieve that objective. These common fields can be used to work on any
BRBINF<N>_EL1 register value. But I might just keep them in sysreg.h, if
the proposed solution is not preferable or seems expedient.

Later when enum support comes up in SysregFields and tools/sysreg supports
formula based crm/op2 expansion entire BRBINF, BRBSRC, BRBTGT register set
can be moved into tools/sysreg.

> 
>> +Enum	7:6	EL
>> +	0b00	EL0
>> +	0b01	EL1
>> +	0b10	EL2
>> +EndEnum
> 
> According to DDI0487I.a 0b11 has the value EL3 (when FEAT_BRBEv1p1).

Sure, will add it.

> 
>> +Sysreg	BRBCR_EL1	2	1	9	0	0
>> +Res0	63:24
>> +Field	23 	EXCEPTION
>> +Field	22 	ERTN
>> +Res0	21:9
>> +Field	8 	FZP
>> +Field	7	ZERO
> 
> According to DDI0487I.a bit 7 is Res0.

Sure, will change.

> 
>> +Field	2	ZERO1
> 
> According to DDI0487I.a bit 2 is Res0.

Sure, will change.

> 
>> +Sysreg	BRBFCR_EL1	2	1	9	0	1
> 
>> +Field	16	ENL
> 
> Accoding to DDI0487I.a this is EnI (ie, an L not an I).

ENL != Enl ? Do we need to match the case as well ?

> 
>> +Sysreg	BRBINFINJ_EL1	2	1	9	1	0
> 
>> +Field	16	TX
> 
> According to DDI0487I.a this is T not TX.

As mentioned, will change it as 'T'.

> 
>> +Enum	7:6	EL
>> +	0b00	EL0
>> +	0b01	EL1
>> +	0b10	EL2
>> +EndEnum
> 
> According to DDI0487I.a 0b11 has the value EL3 (when FEAT_BRBEv1p1).

Sure, will add.
