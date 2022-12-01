Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEF263ED72
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiLAKSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLAKRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:17:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C0ED17891;
        Thu,  1 Dec 2022 02:17:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9359D6E;
        Thu,  1 Dec 2022 02:17:50 -0800 (PST)
Received: from [10.57.7.90] (unknown [10.57.7.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96FD63F67D;
        Thu,  1 Dec 2022 02:17:42 -0800 (PST)
Message-ID: <38c6bc97-0c18-c645-6973-55a0d29083ff@arm.com>
Date:   Thu, 1 Dec 2022 10:17:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] perf: Fix interpretation of branch records
Content-Language: en-US
To:     Sandipan Das <sandipan.das@amd.com>,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        Anshuman.Khandual@arm.com
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20221130165158.517385-1-james.clark@arm.com>
 <444e806b-4593-7ea9-a8aa-27d2f726a751@amd.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <444e806b-4593-7ea9-a8aa-27d2f726a751@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/12/2022 09:02, Sandipan Das wrote:
> On 11/30/2022 10:21 PM, James Clark wrote:
>> Commit 93315e46b000 ("perf/core: Add speculation info to branch
>> entries") added a new field in between type and new_type. Perf has
>> its own copy of this struct so update it to match the kernel side.
>>
>> This doesn't currently cause any issues because new_type is only used
>> by the Arm BRBE driver which isn't merged yet.
>>
>> Fixes: 93315e46b000 ("perf/core: Add speculation info to branch entries")
> 
> Technically, in the kernel sources, commit 93315e46b000 ("perf/core: Add
> speculation info to branch entries") landed before commit b190bc4ac9e6
> ("perf: Extend branch type classification").
> 
> So I think the Fixes tag should instead have commit 0ddea8e2a0c2
> ("perf branch: Extend branch type classification") which added the
> UAPI changes to the perf tool headers.

Yes maybe, or 831c05a7621b ("tools headers UAPI: Sync linux/perf_event.h
with the kernel sources") where spec was added to the perf copy of the
headers.

It's hard to say for sure which one is best. I think that the earliest
possible one is best in case anyone is debugging that kernel version
with userspace Perf. And to me it seems any kernel that has the spec
record should have it matching in userspace so I would still prefer
93315e46b000. Applying it on top of any other change would still lead to
misleading interpretation of the records.

> 
> Aside from that, the patch looks good to me.

Thanks for the review.

> 
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/util/branch.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
>> index d6017c9b1872..3ed792db1125 100644
>> --- a/tools/perf/util/branch.h
>> +++ b/tools/perf/util/branch.h
>> @@ -22,9 +22,10 @@ struct branch_flags {
>>  			u64 abort:1;
>>  			u64 cycles:16;
>>  			u64 type:4;
>> +			u64 spec:2;
>>  			u64 new_type:4;
>>  			u64 priv:3;
>> -			u64 reserved:33;
>> +			u64 reserved:31;
>>  		};
>>  	};
>>  };
> 
> 
