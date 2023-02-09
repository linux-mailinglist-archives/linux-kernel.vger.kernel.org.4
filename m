Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578C268FE0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjBIDlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBIDk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:40:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AF2A83CD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:40:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47BB7150C;
        Wed,  8 Feb 2023 19:41:39 -0800 (PST)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7DFD3F71E;
        Wed,  8 Feb 2023 19:40:54 -0800 (PST)
Message-ID: <656cdc72-b01c-914e-9ace-59cc9fea572f@arm.com>
Date:   Thu, 9 Feb 2023 09:10:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V7 3/6] arm64/perf: Add branch stack support in struct
 arm_pmu
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-4-anshuman.khandual@arm.com>
 <Y8ARAjUaE44y+Cw3@FVFF77S0Q05N>
 <0351f0bc-d94b-957f-8e03-6525e47d63a4@arm.com>
 <Y+P3g8/85FIe/sUK@FVFF77S0Q05N.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y+P3g8/85FIe/sUK@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/23 00:56, Mark Rutland wrote:
> On Fri, Jan 13, 2023 at 09:45:22AM +0530, Anshuman Khandual wrote:
>>
>> On 1/12/23 19:24, Mark Rutland wrote:
>>> On Thu, Jan 05, 2023 at 08:40:36AM +0530, Anshuman Khandual wrote:
>>>>  struct arm_pmu {
>>>>  	struct pmu	pmu;
>>>>  	cpumask_t	supported_cpus;
>>>>  	char		*name;
>>>>  	int		pmuver;
>>>> +	int		features;
>>>>  	irqreturn_t	(*handle_irq)(struct arm_pmu *pmu);
>>>>  	void		(*enable)(struct perf_event *event);
>>>>  	void		(*disable)(struct perf_event *event);
>>>
>>> Hmm, we already have the secure_access field separately. How about we fold that
>>> in and go with:
>>>
>>> 	unsigned int	secure_access    : 1,
>>> 			has_branch_stack : 1;
>>
>> Something like this would work, but should we use __u32 instead of unsigned int
>> to ensure 32 bit width ?
> 
> I don't think that's necessary; the exact size doesn't really matter, and
> unsigned int is 32-bits on all targets suppropted by Linux, not just arm and
> arm64.
> 
> I do agree that if this were a userspace ABI detail, it might be preferable to
> use __u32. However, I think using it here gives the misleading impression that
> there is an ABI concern when there is not, and as above it's not necessary, so
> I'd prefer unsigned int here.

Makes sense, will this as unsigned int.
