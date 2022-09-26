Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C7D5EB184
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIZTqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiIZTp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:45:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887311EC49;
        Mon, 26 Sep 2022 12:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FAFFB80DFA;
        Mon, 26 Sep 2022 19:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CA4C433D7;
        Mon, 26 Sep 2022 19:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664221550;
        bh=MNeBI45oFNpk0bJm4bTOEibWr854TsU8hMwcCFMgC1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SRkCt+/DiuV5u8aJnb4Lo/H8IqidTDwYQchwL+tSHijnMdpY4jmYpLxQCdpkQVT5l
         DJZCG/7KbMsNVRteV6Egr3eVanJvSJxOeFxnVzBY62MnzeS0cj7hGeiWX8vUISlmnR
         /6NeaswEvOy+SME52iPEyTgQPy9qUuopJYJwY9QzzWKBC1ZpSkORx63YvTlUZKi4TZ
         vYFvCq7KhnQD/FTdjx+g7H4HxXl4OPfVORgW2UVf8DM/GGeZA/RRQn3oCLnELOxduC
         lDDrhtMifJRVkjwBY6QlVSxa8lQKsMLX3mcWQzM1yiPwmJcwrOr/ktjvy3j1WVHp2D
         EsXLBn7JJuyFw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0CA74403B0; Mon, 26 Sep 2022 20:45:48 +0100 (IST)
Date:   Mon, 26 Sep 2022 20:45:48 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf lock: Add -E/--entries option
Message-ID: <YzIBbErRhxzk5ppd@kernel.org>
References: <20220924004221.841024-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924004221.841024-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 23, 2022 at 05:42:19PM -0700, Namhyung Kim escreveu:
> Like perf top, the -E option can limit number of entries to print.
> It can be useful when users want to see top N contended locks only.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-lock.txt | 10 ++++++++++
>  tools/perf/builtin-lock.c              | 20 +++++++++++++++-----
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index 5f2dc634258e..b23e76200ac2 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -94,6 +94,11 @@ REPORT OPTIONS
>           EventManager_De       1845          1             636
>           futex-default-S       1609          0               0
>  
> +-E::
> +--entries=<value>::
> +	Display this many entries.
> +
> +
>  INFO OPTIONS
>  ------------
>  
> @@ -105,6 +110,7 @@ INFO OPTIONS
>  --map::
>  	dump map of lock instances (address:name table)
>  
> +
>  CONTENTION OPTIONS
>  --------------
>  
> @@ -154,6 +160,10 @@ CONTENTION OPTIONS
>  --stack-skip
>  	Number of stack depth to skip when finding a lock caller (default: 3).
>  
> +-E::
> +--entries=<value>::
> +	Display this many entries.
> +
>  
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 25d75fa09b90..1c0d52384d9e 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -58,6 +58,7 @@ static bool use_bpf;
>  static unsigned long bpf_map_entries = 10240;
>  static int max_stack_depth = CONTENTION_STACK_DEPTH;
>  static int stack_skip = CONTENTION_STACK_SKIP;
> +static int print_nr_entries = INT_MAX / 2;
>  
>  static enum {
>  	LOCK_AGGR_ADDR,
> @@ -1266,14 +1267,14 @@ static void print_result(void)
>  	struct lock_stat *st;
>  	struct lock_key *key;
>  	char cut_name[20];
> -	int bad, total;
> +	int bad, total, printed;
>  
>  	pr_info("%20s ", "Name");
>  	list_for_each_entry(key, &lock_keys, list)
>  		pr_info("%*s ", key->len, key->header);
>  	pr_info("\n\n");
>  
> -	bad = total = 0;
> +	bad = total = printed = 0;
>  	while ((st = pop_from_result())) {
>  		total++;
>  		if (st->broken)
> @@ -1311,6 +1312,9 @@ static void print_result(void)
>  			pr_info(" ");
>  		}
>  		pr_info("\n");
> +
> +		if (++printed >= print_nr_entries)
> +			break;
>  	}
>  
>  	print_bad_events(bad, total);
> @@ -1476,7 +1480,7 @@ static void print_contention_result(struct lock_contention *con)
>  {
>  	struct lock_stat *st;
>  	struct lock_key *key;
> -	int bad, total;
> +	int bad, total, printed;
>  
>  	list_for_each_entry(key, &lock_keys, list)
>  		pr_info("%*s ", key->len, key->header);
> @@ -1486,7 +1490,7 @@ static void print_contention_result(struct lock_contention *con)
>  	else
>  		pr_info("  %10s   %s\n\n", "type", "caller");
>  
> -	bad = total = 0;
> +	bad = total = printed = 0;
>  	if (use_bpf)
>  		bad = bad_hist[BROKEN_CONTENDED];
>  
> @@ -1507,7 +1511,7 @@ static void print_contention_result(struct lock_contention *con)
>  			/* st->addr contains tid of thread */
>  			t = perf_session__findnew(session, pid);
>  			pr_info("  %10d   %s\n", pid, thread__comm_str(t));
> -			continue;
> +			goto next;
>  		}
>  
>  		pr_info("  %10s   %s\n", get_type_str(st), st->name);
> @@ -1527,6 +1531,10 @@ static void print_contention_result(struct lock_contention *con)
>  				pr_info("\t\t\t%#lx  %s\n", (unsigned long)ip, buf);
>  			}
>  		}
> +
> +next:
> +		if (++printed >= print_nr_entries)
> +			break;
>  	}
>  
>  	print_bad_events(bad, total);
> @@ -1878,6 +1886,7 @@ int cmd_lock(int argc, const char **argv)
>  		    "combine locks in the same class"),
>  	OPT_BOOLEAN('t', "threads", &show_thread_stats,
>  		    "show per-thread lock stats"),
> +	OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
>  	OPT_PARENT(lock_options)
>  	};
>  
> @@ -1905,6 +1914,7 @@ int cmd_lock(int argc, const char **argv)
>  	OPT_INTEGER(0, "stack-skip", &stack_skip,
>  		    "Set the number of stack depth to skip when finding a lock caller, "
>  		    "Default: " __stringify(CONTENTION_STACK_SKIP)),
> +	OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
>  	OPT_PARENT(lock_options)
>  	};
>  
> -- 
> 2.37.3.998.g577e59143f-goog

-- 

- Arnaldo
