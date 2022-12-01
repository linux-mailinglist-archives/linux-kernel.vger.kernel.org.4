Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8646963ED9D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiLAKYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLAKYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:24:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D428E25E9D;
        Thu,  1 Dec 2022 02:24:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47667D6E;
        Thu,  1 Dec 2022 02:24:19 -0800 (PST)
Received: from [10.57.7.90] (unknown [10.57.7.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 364F63F67D;
        Thu,  1 Dec 2022 02:24:11 -0800 (PST)
Message-ID: <a1312c5e-b03f-8116-7e86-cff618e9e080@arm.com>
Date:   Thu, 1 Dec 2022 10:24:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] perf/core: Reset remaining bits in
 perf_clear_branch_entry_bitfields()
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20221201055103.302019-1-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221201055103.302019-1-anshuman.khandual@arm.com>
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



On 01/12/2022 05:51, Anshuman Khandual wrote:
> perf_clear_branch_entry_bitfields() resets all struct perf_branch_entry bit
> fields before capturing branch records. This resets remaining bit fields
> except 'new_type', which is valid only when 'type' is PERF_BR_EXTEND_ABI.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-perf-users@vger.kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.1-rc6
> 
> 'perf_branch_entry.new_type' can remain uninitialized as explained earlier.
> Also there is no PERF_BR_NEW_UNKNOWN to spare, because 'perf_branch_entry.
> new_type' enumeration starts at PERF_BR_NEW_FAULT_ALGN, to save a position
> for the extended branch types instead.
> 
>  include/linux/perf_event.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 0031f7b4d9ab..c97b5f6f77a4 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1110,8 +1110,9 @@ static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *b
>  	br->in_tx = 0;
>  	br->abort = 0;
>  	br->cycles = 0;
> -	br->type = 0;
> +	br->type = PERF_BR_UNKNOWN;
>  	br->spec = PERF_BR_SPEC_NA;
> +	br->priv = PERF_BR_PRIV_UNKNOWN;
>  	br->reserved = 0;
>  }

I would vote for just memsetting the whole struct to 0 at this point and
making it work by ensuring the cleared from and to values are only set
after this function.

Or do the thing where it's wrapped in a union and the 'u64 value' member
is assigned 0. See union perf_mem_data_src. I don't know if this would
be a breaking change, but it doesn't look like it.

Currently this is a bit too fragile and the kind of bugs it will cause
are almost undetectable.

But as my proposal is an extra change on top of this:

Reviewed-by: James Clark <james.clark@arm.com>

James

>  
