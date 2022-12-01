Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8650F63E8D3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLAERE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLAERB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:17:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C14269490F;
        Wed, 30 Nov 2022 20:17:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D960FD6E;
        Wed, 30 Nov 2022 20:17:06 -0800 (PST)
Received: from [10.162.43.8] (unknown [10.162.43.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA94D3F73D;
        Wed, 30 Nov 2022 20:16:56 -0800 (PST)
Message-ID: <8b7606a4-63e4-6d0c-6b83-5ef51c83385c@arm.com>
Date:   Thu, 1 Dec 2022 09:46:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] perf: Fix interpretation of branch records
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        sandipan.das@amd.com
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20221130165158.517385-1-james.clark@arm.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20221130165158.517385-1-james.clark@arm.com>
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



On 11/30/22 22:21, James Clark wrote:
> Commit 93315e46b000 ("perf/core: Add speculation info to branch
> entries") added a new field in between type and new_type. Perf has
> its own copy of this struct so update it to match the kernel side.
> 
> This doesn't currently cause any issues because new_type is only used
> by the Arm BRBE driver which isn't merged yet.
> 
> Fixes: 93315e46b000 ("perf/core: Add speculation info to branch entries")
> Signed-off-by: James Clark <james.clark@arm.com>

Again, problem from having the same structure in two different places

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  tools/perf/util/branch.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
> index d6017c9b1872..3ed792db1125 100644
> --- a/tools/perf/util/branch.h
> +++ b/tools/perf/util/branch.h
> @@ -22,9 +22,10 @@ struct branch_flags {
>  			u64 abort:1;
>  			u64 cycles:16;
>  			u64 type:4;
> +			u64 spec:2;
>  			u64 new_type:4;
>  			u64 priv:3;
> -			u64 reserved:33;
> +			u64 reserved:31;
>  		};
>  	};
>  };
