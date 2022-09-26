Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A205EB1A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiIZTvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiIZTvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C163718E;
        Mon, 26 Sep 2022 12:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03A0B61232;
        Mon, 26 Sep 2022 19:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4773CC433D6;
        Mon, 26 Sep 2022 19:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664221842;
        bh=JQOzzpXQFDP3fmKmOkxTPI3sAp47fGadoT8ETOKv49o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPEOczmIOPhSR6wmOug8olbgr2rySWkpMWF7CxwOu+hoD0MbUx7aVcYtm33IBOXW/
         8Z3ESBDtg2322+L32bpxtOXsOvZ9ksRPLwpTSOlgqsVtLXONxdeF1opD5MR14qehIl
         lWnGyIGOhNXtDwpcdR5w+fNyqsGZ7GHKXVG2jzKbO9k7XO8ebnCqGSRabP4XONsz6y
         nejYMcMpFANoAbUb0pun8XfrCUttTdQRMkPvbpIMYhHMSu1ewvEOUdLJeI8cZYeg6C
         59JJS9xbuDWlgD726BzvF+ZCG02ETGl/Saxe4k4Yda1Hc71lzkMFjX5hJEVSbgb4DT
         Gy0bn3fI+OjHw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 604BB403B0; Mon, 26 Sep 2022 20:50:40 +0100 (IST)
Date:   Mon, 26 Sep 2022 20:50:40 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, john.garry@huawei.com,
        adrian.hunter@intel.com, ak@linux.intel.com,
        florian.fischer@muhq.space
Subject: Re: [PATCH -next 1/5] perf: Fix show_arg_names not working for tp
 arg names
Message-ID: <YzICkLT4/oiwqgfK@kernel.org>
References: <20220926031440.28275-1-chenzhongjin@huawei.com>
 <20220926031440.28275-2-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926031440.28275-2-chenzhongjin@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 26, 2022 at 11:14:36AM +0800, Chen Zhongjin escreveu:
> trace__fprintf_tp_fields() will always print arg names because when
> implemented it is forced to print arg_names with:
> (1 || trace->show_arg_names)
> 
> So the printing looks like:
> 
> > cat ~/.perfconfig
>     [trace]
>         show_arg_names = no
> 
> > perf trace -e syscalls:*mmap sleep 1
>     0.000 sleep/1119 syscalls:sys_enter_mmap(NULL, 8192, READ|WRITE, PRIVATE|ANONYMOUS)
>     0.179 sleep/1119 syscalls:sys_exit_mmap(__syscall_nr: 9, ret: 140535426170880)
>     ...
> 
> Although the comment said that perhaps we need a show_tp_arg_names.
> I don't think it's necessary to control them separately because
> it's not so clean that part of the log shows arg names but other not.
> Also when we are tracing functions it's rare to especially distinguish
> syscalls and tp trace.
> 
> Only use one option to control arg names printing is more resonable
> and simple. So remove the force condition and commit.
> 
> After fix:
 
> > perf trace -e syscalls:*mmap sleep 1
>     0.000 sleep/1121 syscalls:sys_enter_mmap(NULL, 8192, READ|WRITE, PRIVATE|ANONYMOUS)
>     0.163 sleep/1121 syscalls:sys_exit_mmap(9, 140454467661824)
>     ...

Thanks, applied.

- Arnaldo

 
> Fixes: f11b2803bb88 ("perf trace: Allow choosing how to augment the tracepoint arguments")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  tools/perf/builtin-trace.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 0bd9d01c0df9..c7bb7a8222a6 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2762,11 +2762,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>  
>  		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
>  
> -		/*
> -		 * XXX Perhaps we should have a show_tp_arg_names,
> -		 * leaving show_arg_names just for syscalls?
> -		 */
> -		if (1 || trace->show_arg_names)
> +		if (trace->show_arg_names)
>  			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
>  
>  		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
> -- 
> 2.17.1

-- 

- Arnaldo
