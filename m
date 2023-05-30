Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA60B7160FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjE3ND1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjE3NDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:03:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05835F3;
        Tue, 30 May 2023 06:03:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBE11C14;
        Tue, 30 May 2023 06:04:01 -0700 (PDT)
Received: from [10.57.55.247] (unknown [10.57.55.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C9863F67D;
        Tue, 30 May 2023 06:03:14 -0700 (PDT)
Message-ID: <79fec396-94c8-6f69-b869-d19b89ccd2cc@arm.com>
Date:   Tue, 30 May 2023 14:03:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V10 00/10] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230517022410.722287-1-anshuman.khandual@arm.com>
 <632289e3-6f3c-20b9-0454-77d6295c1c87@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <632289e3-6f3c-20b9-0454-77d6295c1c87@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/2023 05:35, Anshuman Khandual wrote:
> 
> 
> On 5/17/23 07:54, Anshuman Khandual wrote:
>> This series enables perf branch stack sampling support on arm64 platform
>> via a new arch feature called Branch Record Buffer Extension (BRBE). All
>> relevant register definitions could be accessed here.
>>
>> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
>>
>> This series applies on 6.4-rc2.
>>
>> Changes in V10:
>>
>> - Rebased the series on v6.4-rc2
>> - Moved ARMV8 PMUV3 changes inside drivers/perf/arm_pmuv3.c
>> - Moved BRBE driver changes inside drivers/perf/arm_brbe.[c|h]
>> - Moved the WARN_ON() inside the if condition in armv8pmu_handle_irq()
> 
> Hello Will/Mark,
> 
> There was a crash reported on V9 (applicable here in V10 as well) because of
> accessing event->pmu_ctx->task_ctx_data during a PMU IRQ for per-cpu events,
> where it would not have been allocated in the first place. I have proposed a
> fix for that on the other thread [1]. Besides, does the series looks good in
> the current form ? Unless there are other comments, will respin with the fix
> later in the week. Thank you.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/d02df808-6d2b-c24b-bc8d-8f4859c0c71b@arm.com/
> 
> - Anshuman


Hi Anshuman,

With the new fix I don't get the crash anymore and the tests are all
passing so:

Tested-by: James Clark <james.clark@arm.com>
