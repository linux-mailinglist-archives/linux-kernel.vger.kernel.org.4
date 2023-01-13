Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF716689D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbjAMDC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbjAMDCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:02:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29276C3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:02:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF628FEC;
        Thu, 12 Jan 2023 19:03:35 -0800 (PST)
Received: from [10.162.41.9] (unknown [10.162.41.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C85573F587;
        Thu, 12 Jan 2023 19:02:50 -0800 (PST)
Message-ID: <16dcb986-74df-9a78-5cfc-e9f59fbe0997@arm.com>
Date:   Fri, 13 Jan 2023 08:32:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V7 2/6] arm64/perf: Add BRBE registers and fields
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-3-anshuman.khandual@arm.com>
 <Y8AKAZMq7YzOpwwV@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y8AKAZMq7YzOpwwV@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 18:54, Mark Rutland wrote:
> Hi Anshuman,
> 
> On Thu, Jan 05, 2023 at 08:40:35AM +0530, Anshuman Khandual wrote:
>> This adds BRBE related register definitions and various other related field
>> macros there in. These will be used subsequently in a BRBE driver which is
>> being added later on.
> 
> I haven't verified the specific values, but this looks good to me aside from
> one minor nit below.
> 
> [...]
> 
>> +# This is just a dummy register declaration to get all common field masks and
>> +# shifts for accessing given BRBINF contents.
>> +Sysreg	BRBINF_EL1	2	1	8	0	0
> 
> We don't need a dummy declaration, as we have 'SysregFields' that can be used
> for this, e.g.
> 
>   SysregFields BRBINFx_EL1
>   ...
>   EndSysregFields
> 
> ... which will avoid accidental usage of the register encoding. Note that I've
> also added an 'x' there in place of the index, which we do for other registers,
> e.g. TTBRx_EL1.
> 
> Could you please update to that?

There is a problem in defining SysregFields (which I did explore earlier as well).
SysregFields unfortunately does not support enums fields. Following build failure
comes up, while trying to convert BRBINFx_EL1 into a SysregFields definition.

Error at 932: unexpected Enum (inside SysregFields)

===============================================================================
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index a7f9054bd84c..519c4f080898 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -921,10 +921,7 @@ Enum       3:0     BT
 EndEnum
 EndSysreg
 
-
-# This is just a dummy register declaration to get all common field masks and
-# shifts for accessing given BRBINF contents.
-Sysreg BRBINF_EL1      2       1       8       0       0
+SysregFields BRBINFx_EL1
 Res0   63:47
 Field  46      CCU
 Field  45:32   CC
@@ -967,7 +964,7 @@ Enum        1:0     VALID
        0b10    SOURCE
        0b11    FULL
 EndEnum
-EndSysreg
+EndSysregFields
 
 Sysreg BRBCR_EL1       2       1       9       0       0
 Res0   63:24
===============================================================================

There are three enum fields in BRBINFx_EL1 as listed here.

Enum    13:8            TYPE
Enum    7:6		EL
Enum    1:0     	VALID

However, BRBINF_EL1 can be changed as BRBINFx_EL1, indicating its more generic
nature with a potential to be used for any index value register thereafter.

> 
> With that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
