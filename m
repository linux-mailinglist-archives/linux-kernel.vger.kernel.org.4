Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0306E721C6F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 05:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjFEDPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 23:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjFEDO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 23:14:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 115FFA9;
        Sun,  4 Jun 2023 20:14:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 504A1D75;
        Sun,  4 Jun 2023 20:15:43 -0700 (PDT)
Received: from [10.162.41.6] (a077893.blr.arm.com [10.162.41.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45FE03F663;
        Sun,  4 Jun 2023 20:14:52 -0700 (PDT)
Message-ID: <a11beb49-7b4f-08f0-b1e2-782a0ba973ea@arm.com>
Date:   Mon, 5 Jun 2023 08:44:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V11 08/10] arm64/perf: Add struct brbe_regset helper
 functions
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-9-anshuman.khandual@arm.com>
 <CAM9d7cihqiUULBR7JoizDGySVYdOx3TH_CJV=QDpeck3p8z5wg@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAM9d7cihqiUULBR7JoizDGySVYdOx3TH_CJV=QDpeck3p8z5wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/23 08:10, Namhyung Kim wrote:
> On Tue, May 30, 2023 at 9:15 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> The primary abstraction level for fetching branch records from BRBE HW has
>> been changed as 'struct brbe_regset', which contains storage for all three
>> BRBE registers i.e BRBSRC, BRBTGT, BRBINF. Whether branch record processing
>> happens in the task sched out path, or in the PMU IRQ handling path, these
>> registers need to be extracted from the HW. Afterwards both live and stored
>> sets need to be stitched together to create final branch records set. This
>> adds required helper functions for such operations.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Tested-by: James Clark <james.clark@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
> 
> [SNIP]
>> +
>> +static inline void copy_brbe_regset(struct brbe_regset *src, int src_idx,
>> +                                   struct brbe_regset *dst, int dst_idx)
>> +{
>> +       dst[dst_idx].brbinf = src[src_idx].brbinf;
>> +       dst[dst_idx].brbsrc = src[src_idx].brbsrc;
>> +       dst[dst_idx].brbtgt = src[src_idx].brbtgt;
>> +}
>> +
>> +/*
>> + * This function concatenates branch records from stored and live buffer
>> + * up to maximum nr_max records and the stored buffer holds the resultant
>> + * buffer. The concatenated buffer contains all the branch records from
>> + * the live buffer but might contain some from stored buffer considering
>> + * the maximum combined length does not exceed 'nr_max'.
>> + *
>> + *     Stored records  Live records
>> + *     ------------------------------------------------^
>> + *     |       S0      |       L0      |       Newest  |
>> + *     ---------------------------------               |
>> + *     |       S1      |       L1      |               |
>> + *     ---------------------------------               |
>> + *     |       S2      |       L2      |               |
>> + *     ---------------------------------               |
>> + *     |       S3      |       L3      |               |
>> + *     ---------------------------------               |
>> + *     |       S4      |       L4      |               nr_max
>> + *     ---------------------------------               |
>> + *     |               |       L5      |               |
>> + *     ---------------------------------               |
>> + *     |               |       L6      |               |
>> + *     ---------------------------------               |
>> + *     |               |       L7      |               |
>> + *     ---------------------------------               |
>> + *     |               |               |               |
>> + *     ---------------------------------               |
>> + *     |               |               |       Oldest  |
>> + *     ------------------------------------------------V
>> + *
>> + *
>> + * S0 is the newest in the stored records, where as L7 is the oldest in
>> + * the live reocords. Unless the live buffer is detetcted as being full
>> + * thus potentially dropping off some older records, L7 and S0 records
>> + * are contiguous in time for a user task context. The stitched buffer
>> + * here represents maximum possible branch records, contiguous in time.
>> + *
>> + *     Stored records  Live records
>> + *     ------------------------------------------------^
>> + *     |       L0      |       L0      |       Newest  |
>> + *     ---------------------------------               |
>> + *     |       L0      |       L1      |               |
>> + *     ---------------------------------               |
>> + *     |       L2      |       L2      |               |
>> + *     ---------------------------------               |
>> + *     |       L3      |       L3      |               |
>> + *     ---------------------------------               |
>> + *     |       L4      |       L4      |             nr_max
>> + *     ---------------------------------               |
>> + *     |       L5      |       L5      |               |
>> + *     ---------------------------------               |
>> + *     |       L6      |       L6      |               |
>> + *     ---------------------------------               |
>> + *     |       L7      |       L7      |               |
>> + *     ---------------------------------               |
>> + *     |       S0      |               |               |
>> + *     ---------------------------------               |
>> + *     |       S1      |               |    Oldest     |
>> + *     ------------------------------------------------V
>> + *     |       S2      | <----|
>> + *     -----------------      |
>> + *     |       S3      | <----| Dropped off after nr_max
>> + *     -----------------      |
>> + *     |       S4      | <----|
>> + *     -----------------
>> + */
>> +static int stitch_stored_live_entries(struct brbe_regset *stored,
>> +                                     struct brbe_regset *live,
>> +                                     int nr_stored, int nr_live,
>> +                                     int nr_max)
>> +{
>> +       int nr_total, nr_excess, nr_last, i;
>> +
>> +       nr_total = nr_stored + nr_live;
>> +       nr_excess = nr_total - nr_max;
>> +
>> +       /* Stored branch records in stitched buffer */
>> +       if (nr_live == nr_max)
>> +               nr_stored = 0;
>> +       else if (nr_excess > 0)
>> +               nr_stored -= nr_excess;
>> +
>> +       /* Stitched buffer branch records length */
>> +       if (nr_total > nr_max)
>> +               nr_last = nr_max;
>> +       else
>> +               nr_last = nr_total;
>> +
>> +       /* Move stored branch records */
>> +       for (i = 0; i < nr_stored; i++)
>> +               copy_brbe_regset(stored, i, stored, nr_last - nr_stored - 1 + i);
> 
> I'm afraid it can overwrite some entries if nr_live is small
> and nr_stored is big.  Why not use memmove()?

nr_stored is first adjusted with nr_excess if both live and stored entries combined
exceed the maximum branch records in the HW. I am wondering how it can override ?

> 
> Also I think it'd be simpler if you copy store to live.
> It'll save copying live in the IRQ but it will copy the
> whole content to store again for the sched switch.

But how that is better than the current scheme ?
