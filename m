Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0AB5EB1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiIZTya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiIZTy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74135A1D65;
        Mon, 26 Sep 2022 12:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 119F36129B;
        Mon, 26 Sep 2022 19:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5ACC433D6;
        Mon, 26 Sep 2022 19:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664222066;
        bh=aFyuIBcggUWX+3c2+KDfoqRBYSJIPGbhdoSm0CVYV40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ab1MosxuDhcl8mRAlqIcX3C3zEXfs+IP2xmG4i8GBjUk1G/eOd9iZ+wh7leFVIK54
         UHFx8EiGLn1W6MFgbua6Zrf2sK9jBomIU59YTUUwHhYYj9ZBNxL+tYx64/ZVrPEOOm
         fuTjjNNi6yVSjvFy8jDWHIRmCuVkf9rCFYzstSsTGEGcrxyikrKVQU8N1A7bdopavk
         93KFe37gs93/Un12C4yfFtE+j2/nre7FA/FG6719UiHL4uE4QBIyvchRmC9GPCUFtM
         sLTJxh7ul971v7nm08awHuQmFHqnm8WuiyfB3zXacEwz8ZG9lCIIdba8FFcBe/RQ2M
         IQguKjgofFoew==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 286C4403B0; Mon, 26 Sep 2022 20:54:24 +0100 (IST)
Date:   Mon, 26 Sep 2022 20:54:24 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, john.garry@huawei.com,
        adrian.hunter@intel.com, ak@linux.intel.com,
        florian.fischer@muhq.space
Subject: Re: [PATCH -next 3/5] perf: Remove duplicate errbuf
Message-ID: <YzIDcPVXLabTeZ11@kernel.org>
References: <20220926031440.28275-1-chenzhongjin@huawei.com>
 <20220926031440.28275-4-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926031440.28275-4-chenzhongjin@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 26, 2022 at 11:14:38AM +0800, Chen Zhongjin escreveu:
> char errbuf[BUFSIZ] is defined twice in trace__run.
> 
> However out_error_open is not cross to other out_error path, they can
> share one errbuf together.
> 
> Define the errbuf[BUFSIZ] at the beginning of function, and remove the
> redefinations of them for code cleaning.

Have you looked at the end result in the generated code? Just out of
curiosity.

- Arnaldo
 
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  tools/perf/builtin-trace.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 7ecd76428440..5660c0ee3507 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3937,6 +3937,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	unsigned long before;
>  	const bool forks = argc > 0;
>  	bool draining = false;
> +	char errbuf[BUFSIZ];
>  
>  	trace->live = true;
>  
> @@ -4027,8 +4028,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  
>  	err = bpf__apply_obj_config();
>  	if (err) {
> -		char errbuf[BUFSIZ];
> -
>  		bpf__strerror_apply_obj_config(err, errbuf, sizeof(errbuf));
>  		pr_err("ERROR: Apply config to BPF failed: %s\n",
>  			 errbuf);
> @@ -4185,8 +4184,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	trace->evlist = NULL;
>  	trace->live = false;
>  	return err;
> -{
> -	char errbuf[BUFSIZ];
>  
>  out_error_sched_stat_runtime:
>  	tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf), "sched", "sched_stat_runtime");
> @@ -4213,7 +4210,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  		evsel->filter, evsel__name(evsel), errno,
>  		str_error_r(errno, errbuf, sizeof(errbuf)));
>  	goto out_delete_evlist;
> -}
> +
>  out_error_mem:
>  	fprintf(trace->output, "Not enough memory to run!\n");
>  	goto out_delete_evlist;
> -- 
> 2.17.1

-- 

- Arnaldo
