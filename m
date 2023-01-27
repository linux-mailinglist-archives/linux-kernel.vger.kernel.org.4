Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4167E522
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjA0M1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjA0M1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:27:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C6F7EFEF;
        Fri, 27 Jan 2023 04:26:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49606CE2873;
        Fri, 27 Jan 2023 12:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F046C433EF;
        Fri, 27 Jan 2023 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674822366;
        bh=iakeOrzI/W8rfMPsrOF2YoP11AIuovtuYrPuqj0PvAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATs/GnBb/0aQEDen1l3xPzAaoG30eoC8QNJ9+GqELRyxNT6PJ7BVmL1SlZBOx40xn
         RMbwcroJXeq4VzOhKRjYUF7kTQAIJsw9CTl0MCFT+FJ3ezUf5eAXn5RjP/S9G18cqT
         ulwFSwsXU1yYncFJQB0qGzq5/rz1h41UrTIWDkX5uxcYoTTvUIBBFQTLrJPAt9OuFp
         AYTeUJFYuVEIglUjWwCjMCz0IqPWFo08qpURgcx8U8k/iLjQ7Vk4op0VL30wOgvVGX
         IhIafcpzI9U2QZ6qH5cPC6FYFLoq3zyH8583+tX5599Va1inGXv9iXgG+HK+qvb/OO
         5fG2w2CAeI5sA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1BE0B405BE; Fri, 27 Jan 2023 09:26:03 -0300 (-03)
Date:   Fri, 27 Jan 2023 09:26:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        qzhao@redhat.com, cjense@google.com,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] perf test: Fix JSON format linter test checks
Message-ID: <Y9PC2+Yqh3W8wyNU@kernel.org>
References: <20230120134039.17788-1-mpetlan@redhat.com>
 <20230120134039.17788-3-mpetlan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120134039.17788-3-mpetlan@redhat.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 20, 2023 at 02:40:39PM +0100, Michael Petlan escreveu:
> The test fails on CPUs with topdown metrics, where it is common to print
> two metrics per line. Since these are included in default event set for
> `perf stat -- something`, it causes the "no args" subtest to fail due to
> unexpected member count. We need to accept 7 or 9 members in that case.
> 
> Coming to that, counting commas in the JSON line and consider it a number
> of elements is incorrect and misleading. There should be +1 element than
> the count of commas, while also, commas can potentially appear in the
> event names. Count " : " substrings rather, since these better fit to
> what should be actually counted.

Before I apply this first patch I can run, as root, the 'perf test' JSON
lint 100 times without problems:

[root@quaco ~]# for a in $(seq 100) ; do echo -n $a ; perf test 98 ; done
1 98: perf stat JSON output linter                                    : Ok
2 98: perf stat JSON output linter                                    : Ok
3 98: perf stat JSON output linter                                    : Ok
4 98: perf stat JSON output linter                                    : Ok
<SNIP>
96 98: perf stat JSON output linter                                    : Ok
97 98: perf stat JSON output linter                                    : Ok
98 98: perf stat JSON output linter                                    : Ok
99 98: perf stat JSON output linter                                    : Ok
100 98: perf stat JSON output linter                                    : Ok
[root@quaco ~]#

After applying it it fails seemingly randomly, I'll remove both patches
from my tmp.perf/core branch and investigate.

[acme@quaco perf]$ git log --oneline -1
fdafd42aac3629db (HEAD) perf stat: Fix JSON metric printout for multiple metrics per line
[acme@quaco perf]$ perf -v
perf version 6.2.rc5.gfdafd42aac36
[acme@quaco perf]$
[root@quaco ~]# perf -v
perf version 6.2.rc5.gfdafd42aac36
[root@quaco ~]# for a in $(seq 100) ; do echo -n $a ; perf test 98 ; done
[root@quaco ~]# perf -v
perf version 6.2.rc5.gfdafd42aac36
[root@quaco ~]# for a in $(seq 100) ; do echo -n $a ; perf test 98 ; done
1 98: perf stat JSON output linter                                    : Ok
2 98: perf stat JSON output linter                                    : Ok
3 98: perf stat JSON output linter                                    : FAILED!
4 98: perf stat JSON output linter                                    : Ok
5 98: perf stat JSON output linter                                    : Ok
6 98: perf stat JSON output linter                                    : Ok
7 98: perf stat JSON output linter                                    : FAILED!
8 98: perf stat JSON output linter                                    : Ok
9 98: perf stat JSON output linter                                    : Ok
10 98: perf stat JSON output linter                                    : Ok
11 98: perf stat JSON output linter                                    : Ok
12 98: perf stat JSON output linter                                    : Ok
13 98: perf stat JSON output linter                                    : Ok
14 98: perf stat JSON output linter                                    : Ok
15 98: perf stat JSON output linter                                    : Ok
16 98: perf stat JSON output linter                                    : FAILED!
17 98: perf stat JSON output linter                                    : Ok
18 98: perf stat JSON output linter                                    : Ok
19 98: perf stat JSON output linter                                    : Ok
20 98: perf stat JSON output linter                                    : FAILED!
21 98: perf stat JSON output linter                                    : Ok
22 98: perf stat JSON output linter                                    : Ok
23 98: perf stat JSON output linter                                    : FAILED!
24 98: perf stat JSON output linter                                    : Ok
25 98: perf stat JSON output linter                                    : Ok
26 98: perf stat JSON output linter                                    : Ok
27 98: perf stat JSON output linter                                    : Ok
28 98: perf stat JSON output linter                                    : FAILED!
29 98: perf stat JSON output linter                                    : Ok
30 98: perf stat JSON output linter                                    : Ok
31 98: perf stat JSON output linter                                    : FAILED!
32 98: perf stat JSON output linter                                    : FAILED!
33 98: perf stat JSON output linter                                    : FAILED!
34 98: perf stat JSON output linter                                    : Ok
35 98: perf stat JSON output linter                                    : Ok
36 98: perf stat JSON output linter                                    : Ok
37 98: perf stat JSON output linter                                    : Ok
38 98: perf stat JSON output linter                                    : FAILED!
39 98: perf stat JSON output linter                                    : FAILED!
40 98: perf stat JSON output linter                                    : FAILED!
41 98: perf stat JSON output linter                                    : Ok
42 98: perf stat JSON output linter                                    : Ok
43 98: perf stat JSON output linter                                    : Ok
44 98: perf stat JSON output linter                                    : Ok
45 98: perf stat JSON output linter                                    : Ok
46 98: perf stat JSON output linter                                    : FAILED!
47 98: perf stat JSON output linter                                    : Ok
48 98: perf stat JSON output linter                                    : FAILED!
49 98: perf stat JSON output linter                                    : FAILED!
50 98: perf stat JSON output linter                                    : FAILED!
51 98: perf stat JSON output linter                                    : FAILED!
52 98: perf stat JSON output linter                                    : Ok
53 98: perf stat JSON output linter                                    : FAILED!
54 98: perf stat JSON output linter                                    : Ok
55 98: perf stat JSON output linter                                    : Ok
56 98: perf stat JSON output linter                                    : FAILED!
57 98: perf stat JSON output linter                                    : Ok
58 98: perf stat JSON output linter                                    : Ok
59 98: perf stat JSON output linter                                    : FAILED!
60 98: perf stat JSON output linter                                    : Ok
61 98: perf stat JSON output linter                                    : FAILED!
62 98: perf stat JSON output linter                                    : Ok
63 98: perf stat JSON output linter                                    : Ok
64 98: perf stat JSON output linter                                    : Ok
65 98: perf stat JSON output linter                                    : Ok
66 98: perf stat JSON output linter                                    : Ok
67 98: perf stat JSON output linter                                    : Ok
68 98: perf stat JSON output linter                                    : Ok
69 98: perf stat JSON output linter                                    : Ok
70 98: perf stat JSON output linter                                    : Ok
71 98: perf stat JSON output linter                                    : FAILED!
72 98: perf stat JSON output linter                                    : FAILED!
73 98: perf stat JSON output linter                                    : Ok
74 98: perf stat JSON output linter                                    : FAILED!
75 98: perf stat JSON output linter                                    : Ok
76 98: perf stat JSON output linter                                    : FAILED!
77 98: perf stat JSON output linter                                    : Ok
78 98: perf stat JSON output linter                                    : FAILED!
79 98: perf stat JSON output linter                                    : FAILED!
80 98: perf stat JSON output linter                                    : FAILED!
81 98: perf stat JSON output linter                                    : Ok
82 98: perf stat JSON output linter                                    : FAILED!
83 98: perf stat JSON output linter                                    : FAILED!
84 98: perf stat JSON output linter                                    : Ok
85 98: perf stat JSON output linter                                    : Ok
86 98: perf stat JSON output linter                                    : Ok
87 98: perf stat JSON output linter                                    : FAILED!
88 98: perf stat JSON output linter                                    : FAILED!
89 98: perf stat JSON output linter                                    : Ok
90 98: perf stat JSON output linter                                    : FAILED!
91 98: perf stat JSON output linter                                    : FAILED!
92 98: perf stat JSON output linter                                    : Ok
93 98: perf stat JSON output linter                                    : FAILED!
94 98: perf stat JSON output linter                                    : FAILED!
95 98: perf stat JSON output linter                                    : FAILED!
96 98: perf stat JSON output linter                                    : FAILED!
97 98: perf stat JSON output linter                                    : FAILED!
98 98: perf stat JSON output linter                                    : Ok
99 98: perf stat JSON output linter                                    : Ok
100 98: perf stat JSON output linter                                    : FAILED!
[root@quaco ~]#

 
> Fixes: 0c343af2a2f8 ("perf test: JSON format checking")
> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  .../tests/shell/lib/perf_json_output_lint.py     | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> index d90f8d102eb9..4f1bbb3f07ec 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -40,17 +40,17 @@ def is_counter_value(num):
>    return isfloat(num) or num == '<not counted>' or num == '<not supported>'
>  
>  def check_json_output(expected_items):
> -  if expected_items != -1:
> +  if expected_items:
>      for line in Lines:
>        if 'failed' not in line:
>          count = 0
> -        count = line.count(',')
> -        if count != expected_items and count >= 1 and count <= 3 and 'metric-value' in line:
> +        count = line.count(' : ')
> +        if count not in expected_items and count >= 2 and count <= 4 and 'metric-value' in line:
>            # Events that generate >1 metric may have isolated metric
>            # values and possibly other prefixes like interval, core and
>            # aggregate-number.
>            continue
> -        if count != expected_items:
> +        if count not in expected_items:
>            raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
>                               f' in \'{line}\'')
>    checks = {
> @@ -82,14 +82,14 @@ def check_json_output(expected_items):
>  
>  try:
>    if args.no_args or args.system_wide or args.event:
> -    expected_items = 6
> +    expected_items = [7, 9]
>    elif args.interval or args.per_thread or args.system_wide_no_aggr:
> -    expected_items = 7
> +    expected_items = [8, 10]
>    elif args.per_core or args.per_socket or args.per_node or args.per_die:
> -    expected_items = 8
> +    expected_items = [9, 11]
>    else:
>      # If no option is specified, don't check the number of items.
> -    expected_items = -1
> +    expected_items = []
>    check_json_output(expected_items)
>  except:
>    print('Test failed for input:\n' + '\n'.join(Lines))
> -- 
> 2.18.4
> 

-- 

- Arnaldo
