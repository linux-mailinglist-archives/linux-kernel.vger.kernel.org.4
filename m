Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7FD6421ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiLEDl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiLEDlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:41:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76F1BDEB8;
        Sun,  4 Dec 2022 19:41:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 978B423A;
        Sun,  4 Dec 2022 19:41:28 -0800 (PST)
Received: from [10.163.44.51] (unknown [10.163.44.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D13B3F73B;
        Sun,  4 Dec 2022 19:41:17 -0800 (PST)
Message-ID: <64f7f939-0c71-e5de-9812-fd46bfdd89a8@arm.com>
Date:   Mon, 5 Dec 2022 09:11:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] perf/core: Reset remaining bits in
 perf_clear_branch_entry_bitfields()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     james.clark@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20221201055103.302019-1-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
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



On 12/1/22 11:21, Anshuman Khandual wrote:
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
>  

Hello Peter,

Just wondering is there a chance that this patch could make it to v6.2-rc1 ?

- Anshuman
