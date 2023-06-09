Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95A72A359
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjFITsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFITsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:48:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A0BE4A;
        Fri,  9 Jun 2023 12:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9938C65B55;
        Fri,  9 Jun 2023 19:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C3CC433EF;
        Fri,  9 Jun 2023 19:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686340088;
        bh=vRa5+x8YqrUPTrMvhWgSuXzIjrvokCR+9EDGmt85tqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ChS1WcA0jb9t3utyWXMEm7DclUZ62ObuGUG46Swbeqx1GbA1hlbcJQHlu2stE9hIv
         GH1NSTdsT/MseOoSIUE54kM+kcazwtBa97h+DOy5EJ/b2dDWy077Tv5RIfj3UnsA14
         7LuDRvovdrXGN4yO8NgoQqmE8OIDhgO0MvuReZ0DK2VSXv9AMXdTlwEr4jb0ZztOFT
         PIl40lOqD+NoJZkGwcMITMb7yHdAgAaHoHSk1cxDrS6qaIkEsOZxQU9TUM7MKRvjvB
         jZ2ok9uKAnj5r4yhw+ekgoIrVEf0ZJDPs99Z/ihWppNQcf89FrxJLj7SZKalOxIxAK
         xOv1EQ/We2oAg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BAEE940692; Fri,  9 Jun 2023 16:48:04 -0300 (-03)
Date:   Fri, 9 Jun 2023 16:48:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH v2 06/26] perf addr_location: Add init/exit/copy functions
Message-ID: <ZIOB9Kmg+uQ+vgSI@kernel.org>
References: <20230608232823.4027869-1-irogers@google.com>
 <20230608232823.4027869-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608232823.4027869-7-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 08, 2023 at 04:28:03PM -0700, Ian Rogers escreveu:
> +++ b/tools/perf/builtin-kmem.c
> @@ -399,7 +399,9 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
>  	struct addr_location al;
>  	struct machine *machine = &kmem_session->machines.host;
>  	struct callchain_cursor_node *node;
> +	u64 result;
>  
> +	addr_location__init(&al);
>  	if (alloc_func_list == NULL) {
>  		if (build_alloc_func_list() < 0)
>  			goto out;
> @@ -427,16 +429,19 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
>  			else
>  				addr = node->ip;
>  
> -			return addr;
> +			result = addr;
> +			goto out;
>  		} else
>  			pr_debug3("skipping alloc function: %s\n", caller->name);
>  
>  		callchain_cursor_advance(&callchain_cursor);
>  	}
>  
> -out:
>  	pr_debug2("unknown callsite: %"PRIx64 "\n", sample->ip);
> -	return sample->ip;
> +	result = sample->ip;
> +out:
> +	addr_location__exit(&al);
> +	return result;
>  }

I needed this to make sure result is set to something, mostly keeping
the previous logic as build_alloc_func_list() already does
debugging/error prints about what went wrong if it takes the 'goto out'.

- Arnaldo

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index a11f280d20bd3d12..96a6611e4e53f448 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -399,7 +399,7 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
 	struct addr_location al;
 	struct machine *machine = &kmem_session->machines.host;
 	struct callchain_cursor_node *node;
-	u64 result;
+	u64 result = sample->ip;
 
 	addr_location__init(&al);
 	if (alloc_func_list == NULL) {
@@ -438,7 +438,6 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
 	}
 
 	pr_debug2("unknown callsite: %"PRIx64 "\n", sample->ip);
-	result = sample->ip;
 out:
 	addr_location__exit(&al);
 	return result;
