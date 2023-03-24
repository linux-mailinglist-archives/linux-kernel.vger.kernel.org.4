Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453E56C7637
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjCXDUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXDUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:20:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA50520D31;
        Thu, 23 Mar 2023 20:20:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 382F912FC;
        Thu, 23 Mar 2023 20:21:24 -0700 (PDT)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B32133F67D;
        Thu, 23 Mar 2023 20:20:35 -0700 (PDT)
Message-ID: <4665d03f-b801-679c-0b52-c426404284b9@arm.com>
Date:   Fri, 24 Mar 2023 08:50:32 +0530
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
 <f7e24b0c-3e33-755a-65c9-2ee78d5a79ec@arm.com>
 <4d93a3de-c86d-454b-8a43-b24e62ea3be7@sirena.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <4d93a3de-c86d-454b-8a43-b24e62ea3be7@sirena.org.uk>
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



On 3/23/23 18:24, Mark Brown wrote:
> On Thu, Mar 23, 2023 at 09:55:47AM +0530, Anshuman Khandual wrote:
>> On 3/22/23 00:32, Mark Brown wrote:
> 
>>> document a requirement for those traps to be disabled now in case we
>>> need them later, and do so during EL2 setup for KVM guests?  That could
>>> always be done incrementally.
> 
>> Unlike all other instruction trap enable fields in SYS_HFGITR_EL2, these BRBE
>> instructions ones are actually inverted in semantics i.e the particular fields
>> need to be set for these traps to be disabled in EL2.
> 
> Right, for backwards compatibility all newly added fields are trap by
> default.

Okay

> 
>> SYS_HFGITR_EL2.nBRBIALL
>> SYS_HFGITR_EL2.nBRBINJ
> 
>> By default entire SYS_HFGITR_EL2 is set as cleared during init and that would
>> prevent a guest from using BRBE.
> 
> It should prevent the host as well shouldn't it? 

In a EL2 host environment, BRBE is being enabled either in EL2 (kernel/hv) or
in EL0 (user space), it never gets enabled on EL1. Moreover BRBIALL/BRBINJ
instructions are always executed while being inside EL2 (kernel/hv). Hence how
could these instructions cause trap in EL2 ?

> 
>> I guess something like the following (untested) needs to be done, to enable
>> BRBE in guests.
> 
>> +       mrs     x1, id_aa64dfr0_el1
>> +       ubfx    x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
>> +       cbz     x1, .Lskip_brbe_\@
>> +       mov     x0, xzr
>> +       orr     x0, x0, #HFGITR_EL2_nBRBIALL
>> +       orr     x0, x0, #HFGITR_EL2_nBRBINJ
>> +       msr_s   SYS_HFGITR_EL2, x0
>> +
>> +.Lskip_brbe_\@:
> 
> Yes, looks roughly what I'd expect.

I could send an stand alone patch after your latest series [1], which disables
BRBINJ/BRBIALL instruction trap in EL2 to enable BRBE usage in the guest.

https://lore.kernel.org/all/20230306-arm64-fgt-reg-gen-v3-2-decba93cbaab@kernel.org/T/

> 
>>> I've got a patch adding the definition of that register to sysreg which
>>> I should be sending shortly, no need to duplicate that effort.
> 
>> Sure, I assume you are moving the existing definition for SYS_HFGITR_EL2 along
>> with all its fields from ../include/asm/sysreg.h to ../tools/sysreg. Right, it
>> makes sense.
> 
> No fields at the minute but yes, like the other conversions.

Sure.
