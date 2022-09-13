Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025CC5B6765
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIMFd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIMFdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:33:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CABDE54C80;
        Mon, 12 Sep 2022 22:33:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 692B8106F;
        Mon, 12 Sep 2022 22:33:59 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C8373F73B;
        Mon, 12 Sep 2022 22:34:16 -0700 (PDT)
Message-ID: <84683aa7-58ad-85f8-327b-daed2f704834@arm.com>
Date:   Tue, 13 Sep 2022 11:03:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 3/7] arm64/perf: Update struct pmu_hw_events for BRBE
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
 <20220908051046.465307-4-anshuman.khandual@arm.com>
 <Yx8GBq1FJN49iJs9@sirena.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Yx8GBq1FJN49iJs9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/22 15:42, Mark Brown wrote:
> On Thu, Sep 08, 2022 at 10:40:42AM +0530, Anshuman Khandual wrote:
> 
>> +	/* Captured BRBE buffer - copied as is into perf_sample_data */
>> +	struct perf_branch_stack	brbe_stack;
>> +	struct perf_branch_entry	brbe_entries[BRBE_MAX_ENTRIES];
> 
> It looks like perf_branch_entry is intended to be the variably
> sized entries array at the end of perf_branch_stack?  That could

That is right. Because max number of entries for brbe_entries[] array
is platform dependent i.e BHRB_MAX_ENTRIES on powerpc, MAX_LBR_ENTRIES
on x86 and BRBE_MAX_ENTRIES on arm64.

The generic definition

struct perf_branch_stack {
        __u64                           nr;
        __u64                           hw_idx;
        struct perf_branch_entry        entries[];
};

On x86 platform

#define MAX_LBR_ENTRIES         32

struct cpu_hw_events {
	....
	struct perf_branch_stack        lbr_stack;
        struct perf_branch_entry        lbr_entries[MAX_LBR_ENTRIES];
	....
}

On powerpc platform

#define BHRB_MAX_ENTRIES        32

struct cpu_hw_events {
	....
        struct  perf_branch_stack       bhrb_stack;
        struct  perf_branch_entry       bhrb_entries[BHRB_MAX_ENTRIES];
	....
}

Followed same format on arm64 platform as well

#define BRBE_MAX_ENTRIES	64

struct pmu_hw_events {
	....
	....
	struct perf_branch_stack	brbe_stack;
	struct perf_branch_entry	brbe_entries[BRBE_MAX_ENTRIES];
	....
	....
}

> probably do with being called out if it's the case.  It feels

Right, we could add a comment in this regard.

> like it would be clearer and safer to allocate these dynamically
> when BRBE is used if that's possible, I'd expect that should also
> deal with the stack frame size issues as well.

That might not be possible because the generic 'struct perf_branch_stack'
expects 'perf_branch_stack.entries' to be a variable array which is also
contiguous in memory, with other elements in 'perf_branch_stack'. Besides
that will be a deviation from similar implementations on x86 and powerpc
platforms.

The stack frame size came up because BRBE_MAX_ENTRIES is 64 compared to
just 32 on other platforms, which follow the exact same method.
