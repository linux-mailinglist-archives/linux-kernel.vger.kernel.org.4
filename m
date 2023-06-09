Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4736A728EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbjFIEa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbjFIEaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:30:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDDC330C1;
        Thu,  8 Jun 2023 21:30:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F847AB6;
        Thu,  8 Jun 2023 21:31:02 -0700 (PDT)
Received: from [10.163.44.201] (unknown [10.163.44.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 988423F587;
        Thu,  8 Jun 2023 21:30:12 -0700 (PDT)
Message-ID: <006be03c-43da-6482-6bc4-83fe65dcd706@arm.com>
Date:   Fri, 9 Jun 2023 10:00:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V11 06/10] arm64/perf: Enable branch stack events via
 FEAT_BRBE
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-7-anshuman.khandual@arm.com>
 <ZH3mhorKNo77hsv5@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZH3mhorKNo77hsv5@FVFF77S0Q05N>
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



On 6/5/23 19:13, Mark Rutland wrote:
>> +static u64 branch_type_to_brbcr(int branch_type)
>> +{
>> +	u64 brbcr = BRBCR_EL1_DEFAULT_TS;
>> +
>> +	/*
>> +	 * BRBE need not be paused on PMU interrupt while tracing only
>> +	 * the user space, bcause it will automatically be inside the
>> +	 * prohibited region. But even after PMU overflow occurs, the
>> +	 * interrupt could still take much more cycles, before it can
>> +	 * be taken and by that time BRBE will have been overwritten.
>> +	 * Let's enable pause on PMU interrupt mechanism even for user
>> +	 * only traces.
>> +	 */
>> +	brbcr |= BRBCR_EL1_FZP;
> I think this is trying to say that we *should* use FZP when sampling the
> kernel (due to IRQ latency), and *can* safely use it when sampling userspace,
> so it would be good to explain it that way around.

Agreed, following updated comment explains why we should enable FZP
when sampling kernel, otherwise BRBE will capture unwanted records.
It also explains why we should enable FZP even when sampling user
space due to IRQ latency.

        /*
         * BRBE should be paused on PMU interrupt while tracing kernel
         * space to stop capturing further branch records. Otherwise
         * interrupt handler branch records might get into the samples
         * which is not desired.
         *
         * BRBE need not be paused on PMU interrupt while tracing only
         * the user space, because it will automatically be inside the
         * prohibited region. But even after PMU overflow occurs, the
         * interrupt could still take much more cycles, before it can
         * be taken and by that time BRBE will have been overwritten.
         * Hence enable pause on PMU interrupt mechanism even for user
         * only traces as well.
         */
        brbcr |= BRBCR_EL1_FZP;

> 
> It's a bit unfortunate, because where this matters we'll always be losing some
> branches either way, but I guess we don't have much say in the matter.



