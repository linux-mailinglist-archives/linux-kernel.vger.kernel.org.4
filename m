Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C042729C97
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjFIOTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbjFIOSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:18:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E73C04;
        Fri,  9 Jun 2023 07:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A42260F55;
        Fri,  9 Jun 2023 14:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C2AC433D2;
        Fri,  9 Jun 2023 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320329;
        bh=Zb/QrR0wax3Fy/77ML8eioj8ePs8p5HDZtXKHZi0OSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNkOU9Yf/y5hFxZkd6DOQzmPPRc8S1Z9E3pRJK/Mo7rmYwqBlXXDfis5s//61/A68
         bOqAscNaLFMi30ewJKsrgbHzYSAFvEXCpZldJp7Iqm34KnOUWe/VqcuGMH7OsFgwgF
         /+QLEbuRi/j6cj6PQ+osk7eimHr5ZBkEehceehhBpfUAINIwrNkEzUxdXN6KZQc4ul
         VEwskEqhS93eH408uwB1KvKVonJq1bjbSNnCbeZqVI3h4Tnkrl/jrHAzCCelpijC3X
         S6xtrzCip0lpRuTCdRQoIlgKSBRntL1JudGe1kLfSj+T/eAxTe3ISzP0dlY09tft8O
         YiuqY9EgHKLWA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 61ADA40692; Fri,  9 Jun 2023 11:18:46 -0300 (-03)
Date:   Fri, 9 Jun 2023 11:18:46 -0300
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
Subject: Re: [PATCH v2 05/26] perf addr_location: Move to its own header
Message-ID: <ZIM0xpF5qxojDaqW@kernel.org>
References: <20230608232823.4027869-1-irogers@google.com>
 <20230608232823.4027869-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608232823.4027869-6-irogers@google.com>
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

Em Thu, Jun 08, 2023 at 04:28:02PM -0700, Ian Rogers escreveu:
> addr_location is a common abstraction, move it into its own header and
> source file in preparation for wider clean up.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/Build           |  1 +
>  tools/perf/util/addr_location.c | 16 ++++++++++++++++
>  tools/perf/util/addr_location.h | 28 ++++++++++++++++++++++++++++
>  tools/perf/util/event.c         | 12 ------------
>  tools/perf/util/symbol.h        | 17 +----------------
>  5 files changed, 46 insertions(+), 28 deletions(-)
>  create mode 100644 tools/perf/util/addr_location.c
>  create mode 100644 tools/perf/util/addr_location.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index c449741adf30..ff2fd1a36bb8 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -1,4 +1,5 @@
>  perf-y += arm64-frame-pointer-unwind-support.o
> +perf-y += addr_location.o
>  perf-y += annotate.o
>  perf-y += block-info.o
>  perf-y += block-range.o
> diff --git a/tools/perf/util/addr_location.c b/tools/perf/util/addr_location.c
> new file mode 100644
> index 000000000000..c73fc2aa236c
> --- /dev/null
> +++ b/tools/perf/util/addr_location.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "addr_location.h"
> +#include "map.h"
> +#include "thread.h"
> +
> +/*
> + * The preprocess_sample method will return with reference counts for the
> + * in it, when done using (and perhaps getting ref counts if needing to
> + * keep a pointer to one of those entries) it must be paired with
> + * addr_location__put(), so that the refcounts can be decremented.
> + */
> +void addr_location__put(struct addr_location *al)
> +{
> +	map__zput(al->map);
> +	thread__zput(al->thread);
> +}
> diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
> new file mode 100644
> index 000000000000..7dfa7417c0fe
> --- /dev/null
> +++ b/tools/perf/util/addr_location.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_ADDR_LOCATION
> +#define __PERF_ADDR_LOCATION 1
> +
> +#include <linux/types.h>
> +
> +struct thread;
> +struct maps;
> +struct map;
> +struct symbol;
> +
> +struct addr_location {
> +	struct thread *thread;
> +	struct maps   *maps;
> +	struct map    *map;
> +	struct symbol *sym;
> +	const char    *srcline;
> +	u64	      addr;
> +	char	      level;
> +	u8	      filtered;
> +	u8	      cpumode;
> +	s32	      cpu;
> +	s32	      socket;
> +};
> +
> +void addr_location__put(struct addr_location *al);
> +
> +#endif /* __PERF_ADDR_LOCATION */
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index e1ce7cb5e421..6ee23145ee7e 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -767,18 +767,6 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>  	return 0;
>  }
>  
> -/*
> - * The preprocess_sample method will return with reference counts for the
> - * in it, when done using (and perhaps getting ref counts if needing to
> - * keep a pointer to one of those entries) it must be paired with
> - * addr_location__put(), so that the refcounts can be decremented.
> - */
> -void addr_location__put(struct addr_location *al)
> -{
> -	map__zput(al->map);
> -	thread__zput(al->thread);
> -}
> -
>  bool is_bts_event(struct perf_event_attr *attr)
>  {
>  	return attr->type == PERF_TYPE_HARDWARE &&
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 7558735543c2..5ca8665dd2c1 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -9,6 +9,7 @@
>  #include <linux/list.h>
>  #include <linux/rbtree.h>
>  #include <stdio.h>
> +#include "addr_location.h"
>  #include "path.h"
>  #include "symbol_conf.h"
>  #include "spark.h"
> @@ -120,22 +121,6 @@ struct ref_reloc_sym {
>  	u64		unrelocated_addr;
>  };
>  
> -struct addr_location {
> -	struct thread *thread;
> -	struct maps   *maps;
> -	struct map    *map;
> -	struct symbol *sym;
> -	const char    *srcline;
> -	u64	      addr;
> -	char	      level;
> -	u8	      filtered;
> -	u8	      cpumode;
> -	s32	      cpu;
> -	s32	      socket;
> -};
> -
> -void addr_location__put(struct addr_location *al);
> -
>  int dso__load(struct dso *dso, struct map *map);
>  int dso__load_vmlinux(struct dso *dso, struct map *map,
>  		      const char *vmlinux, bool vmlinux_allocated);
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 

- Arnaldo
