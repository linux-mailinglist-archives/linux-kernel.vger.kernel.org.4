Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD772D848
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjFMEBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFMEBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:01:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06DB1E4E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:01:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 519A91FB;
        Mon, 12 Jun 2023 21:02:25 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCA513F587;
        Mon, 12 Jun 2023 21:01:36 -0700 (PDT)
Message-ID: <4fec9cf7-b4b6-c5c1-7db5-493240c54ef1@arm.com>
Date:   Tue, 13 Jun 2023 09:31:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 12/14] arm64/sysreg: Convert TRBMAR_EL1 register to
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
 <20230602062552.565992-13-anshuman.khandual@arm.com>
 <8a352dec-9655-4e7c-ba35-1c48e154bc71@sirena.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <8a352dec-9655-4e7c-ba35-1c48e154bc71@sirena.org.uk>
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



On 6/2/23 17:35, Mark Brown wrote:
> On Fri, Jun 02, 2023 at 11:55:50AM +0530, Anshuman Khandual wrote:
> 
>> +Sysreg	TRBMAR_EL1	3	0	9	11	4
>> +Res0	63:12
>> +Field	11:10	PAS
>> +Field	9:8	SH
>> +Field	7:0	Attr
>> +EndSysreg
> 
> PAS and SH look like they should be enums, Attr is a bit more complex so
> Field is probably a good fit there.  Adding the enum information could
> be done incrementally though so:

Will fold the following changes in this patch.

--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2246,8 +2246,17 @@ EndSysreg
 
 Sysreg TRBMAR_EL1      3       0       9       11      4
 Res0   63:12
-Field  11:10   PAS
-Field  9:8     SH
+Enum   11:10   PAS
+       0b00    SECURE
+       0b01    NON_SECURE
+       0b10    ROOT
+       0b11    REALM
+EndEnum
+Enum   9:8     SH
+       0b00    NON_SHAREABLE
+       0b10    OUTER_SHAREABLE
+       0b11    INNER_SHAREABLE
+EndEnum
 Field  7:0     Attr
 EndSysreg

> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
