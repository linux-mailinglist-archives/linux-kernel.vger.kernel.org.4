Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5086428BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiLEMta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLEMt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:49:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885581A205;
        Mon,  5 Dec 2022 04:49:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C1DCB81065;
        Mon,  5 Dec 2022 12:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBA6C43470;
        Mon,  5 Dec 2022 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670244566;
        bh=WVWZU6ZtReEdwq+R7Uw2OX4bdjjS/26KRvhimlJgxp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfwWPLTEJ8iv0zOw+gJRHiAVX3EbqRT3fQdCogL35xzUgYgFNqxBZ8EdYr7hLWtrz
         HViZLdyPPv54G7AkzXRaBg8by6WlIu9zWoKfyAbSoLqmROUctcwSf9hfBkpOTveIdX
         GvrvF63bQOyUulBcl2qXBEY9L6uZqv1BJZcav295Z6o/IjXfssHyOOH/Q9Amu/YIEp
         MaszihYS3LAcajt68+rt+yEIxpIEmpAEoifNcbfh+2//ykAFHRJbIO227D4v55OMbR
         UFUlWeD56vdPksUKsleBxs5nwMumVvKKmMk2J0OY2kD55GYN84/xpSKqIkRN/EZNWH
         Lag+lmx/OvUWA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 761EF40404; Mon,  5 Dec 2022 09:49:23 -0300 (-03)
Date:   Mon, 5 Dec 2022 09:49:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, james.clark@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/tool: Add remaining branch filters to perf record
Message-ID: <Y43o05Fhs2zXI3Nv@kernel.org>
References: <20221205064443.533587-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205064443.533587-1-anshuman.khandual@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 05, 2022 at 12:14:43PM +0530, Anshuman Khandual escreveu:
> This adds all remaining branch filters i.e no_cycles, no_flags and hw_index
> to perf record tool. While here, also updates the documentation.

Thanks, applied.

- Arnaldo

 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 5 +++++
>  tools/perf/util/parse-branch-options.c   | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index e41ae950fdc3..7803c0c4c8f9 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -388,6 +388,7 @@ following filters are defined:
>          - any_call: any function call or system call
>          - any_ret: any function return or system call return
>          - ind_call: any indirect branch
> +        - ind_jmp: any indirect jump
>          - call: direct calls, including far (to/from kernel) calls
>          - u:  only when the branch target is at the user level
>          - k: only when the branch target is in the kernel
> @@ -396,6 +397,10 @@ following filters are defined:
>  	- no_tx: only when the target is not in a hardware transaction
>  	- abort_tx: only when the target is a hardware transaction abort
>  	- cond: conditional branches
> +	- call_stack: save call stack
> +	- no_flags: don't save branch flags e.g prediction, misprediction etc
> +	- no_cycles: don't save branch cycles
> +	- hw_index: save branch hardware index
>  	- save_type: save branch type during sampling in case binary is not available later
>  		     For the platforms with Intel Arch LBR support (12th-Gen+ client or
>  		     4th-Gen Xeon+ server), the save branch type is unconditionally enabled
> diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
> index 31faf2bb49ff..fd67d204d720 100644
> --- a/tools/perf/util/parse-branch-options.c
> +++ b/tools/perf/util/parse-branch-options.c
> @@ -30,8 +30,11 @@ static const struct branch_mode branch_modes[] = {
>  	BRANCH_OPT("cond", PERF_SAMPLE_BRANCH_COND),
>  	BRANCH_OPT("ind_jmp", PERF_SAMPLE_BRANCH_IND_JUMP),
>  	BRANCH_OPT("call", PERF_SAMPLE_BRANCH_CALL),
> +	BRANCH_OPT("no_flags", PERF_SAMPLE_BRANCH_NO_FLAGS),
> +	BRANCH_OPT("no_cycles", PERF_SAMPLE_BRANCH_NO_CYCLES),
>  	BRANCH_OPT("save_type", PERF_SAMPLE_BRANCH_TYPE_SAVE),
>  	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
> +	BRANCH_OPT("hw_index", PERF_SAMPLE_BRANCH_HW_INDEX),
>  	BRANCH_OPT("priv", PERF_SAMPLE_BRANCH_PRIV_SAVE),
>  	BRANCH_END
>  };
> -- 
> 2.25.1

-- 

- Arnaldo
