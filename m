Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8A729C8A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbjFIORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFIORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:17:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A830E5;
        Fri,  9 Jun 2023 07:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1FB361D32;
        Fri,  9 Jun 2023 14:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E724DC4339B;
        Fri,  9 Jun 2023 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320265;
        bh=dwVgdncCcYDj2hwb+9JaEVfH+lUQWzk/oa0ZMJ0g83Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bcxaqp/DQ+I9UtNrpBdehBwpsXR4syK8aVC2JrCLRX81P4gijnPmZ1xgtIwJ5Nl5C
         4ckG5W2i6Gdiw+FPuuBnNeJrIEWG/StZQrvjhMIdu0ZUXKB/RdLZwx2xDbxu9X3txl
         Nzl0gndPSqh1cEZ7I6wI2Z5idDzqtFYq3nO3TFu3IopUhSb0xARu4NPaCG/aGazYwf
         RuhTnnw6X/vf8q932pwaofOkFdgaJ1PByHW5gty8dHZIU3rWpqbPCsY1B+RhK6tQ6z
         +SL8uwzcmWflu+wIJcdJIC6H9YY8NLcuCpYuPg1SERvWHuWSfZtG87gcLpFuHYfKwk
         hEIsLwe4loUfg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 20E2140692; Fri,  9 Jun 2023 11:17:42 -0300 (-03)
Date:   Fri, 9 Jun 2023 11:17:42 -0300
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
Subject: Re: [PATCH v2 04/26] perf maps: Make delete static, always use put
Message-ID: <ZIM0hlZ01pKI6ylJ@kernel.org>
References: <20230608232823.4027869-1-irogers@google.com>
 <20230608232823.4027869-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608232823.4027869-5-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 08, 2023 at 04:28:01PM -0700, Ian Rogers escreveu:
> Address/leak sanitizer with reference count checking can identify the
> location of leaks, so use put rather than delete to avoid free-ing
> memory when the reference count is >1. Add maps__zput to ensure the
> variable is cleared.

Applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/maps.c   | 2 +-
>  tools/perf/util/machine.c | 2 +-
>  tools/perf/util/maps.c    | 2 +-
>  tools/perf/util/maps.h    | 9 ++++++++-
>  4 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
> index 8c0eb5cf8bb5..5bb1123a91a7 100644
> --- a/tools/perf/tests/maps.c
> +++ b/tools/perf/tests/maps.c
> @@ -140,7 +140,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
>  	ret = check_maps(merged3, ARRAY_SIZE(merged3), maps);
>  	TEST_ASSERT_VAL("merge check failed", !ret);
>  
> -	maps__delete(maps);
> +	maps__zput(maps);
>  	return TEST_OK;
>  }
>  
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 5d34d60a0045..8972c852d3bd 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -248,7 +248,7 @@ void machine__exit(struct machine *machine)
>  		return;
>  
>  	machine__destroy_kernel_maps(machine);
> -	maps__delete(machine->kmaps);
> +	maps__zput(machine->kmaps);
>  	dsos__exit(&machine->dsos);
>  	machine__exit_vdso(machine);
>  	zfree(&machine->root_dir);
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 5ae6379a1b42..5206a6433117 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -171,7 +171,7 @@ struct maps *maps__new(struct machine *machine)
>  	return result;
>  }
>  
> -void maps__delete(struct maps *maps)
> +static void maps__delete(struct maps *maps)
>  {
>  	maps__exit(maps);
>  	unwind__finish_access(maps);
> diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
> index d2963456cfbe..83144e0645ed 100644
> --- a/tools/perf/util/maps.h
> +++ b/tools/perf/util/maps.h
> @@ -57,13 +57,20 @@ struct kmap {
>  };
>  
>  struct maps *maps__new(struct machine *machine);
> -void maps__delete(struct maps *maps);
>  bool maps__empty(struct maps *maps);
>  int maps__clone(struct thread *thread, struct maps *parent);
>  
>  struct maps *maps__get(struct maps *maps);
>  void maps__put(struct maps *maps);
>  
> +static inline void __maps__zput(struct maps **map)
> +{
> +	maps__put(*map);
> +	*map = NULL;
> +}
> +
> +#define maps__zput(map) __maps__zput(&map)
> +
>  static inline struct rb_root *maps__entries(struct maps *maps)
>  {
>  	return &RC_CHK_ACCESS(maps)->entries;
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 

- Arnaldo
