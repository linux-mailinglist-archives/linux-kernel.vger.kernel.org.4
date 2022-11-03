Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E624A6182FD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiKCPgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKCPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:36:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B8F12618;
        Thu,  3 Nov 2022 08:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54EC0B8269B;
        Thu,  3 Nov 2022 15:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EA8C433C1;
        Thu,  3 Nov 2022 15:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667489800;
        bh=bXtq23OxB7UyH+Gk6wZHWeTr763dEy0Qb3j3nS0oyKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkKRAfvUz10yJ+1E/1r8J8WRB/bvHGsz+EY5CJUKsRuO6u38O1m4rVOKXXeiQ2CbX
         BeZc53KDfGTuX4VTLpqkd8c70WizezR129pEUptXWffX8uN4/tjlWakgXoxT6+Oj7t
         6TBYtiK05md5rQ8FWduCJcb8rx+v/EmLgq4DwwqIZVzYGfHAzXsinSU78+syn0feDm
         FovQaX9w0CfMY59ATIl6RKwwizBsePtzHdnIlJ/jBWarcK6RyBeWdr/ANI2ijWtxuC
         n1HQQHtItcid8EkceN0swMwCR0qGb0CgmfgYlRmD+xHE05mS4peSsPp5GmxcyaGRnl
         zmwoA3aGNPzWQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1EA554034E; Thu,  3 Nov 2022 12:36:36 -0300 (-03)
Date:   Thu, 3 Nov 2022 12:36:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 6/7] perf trace: 5sec fix libbpf 1.0+ compatibility
Message-ID: <Y2PgBPeZsd9+YWB4@kernel.org>
References: <20221103045437.163510-1-irogers@google.com>
 <20221103045437.163510-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103045437.163510-7-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 02, 2022 at 09:54:36PM -0700, Ian Rogers escreveu:
> Avoid use of tools/perf/include/bpf/bpf.h and use the more regular BPF
> headers.
> 
> Note, on testing the probe was unable to attach and the program failed.

Humm, trying to test:

[root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/5sec.c |& head -15
In file included from /home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:
In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/bpf.h:9:
In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/workqueue.h:9:
In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/timer.h:6:
In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/ktime.h:24:
In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/time.h:6:
In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/math64.h:6:
In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/math.h:6:
/lib/modules/5.19.16-200.fc36.x86_64/build/./arch/x86/include/asm/div64.h:85:28: error: invalid output constraint '=a' in asm
        asm ("mulq %2; divq %3" : "=a" (q)
                                  ^
In file included from /home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:
In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/bpf.h:9:
In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/workqueue.h:9:
In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/timer.h:6:
[root@quaco ~]#

So I go and try to remove that <linux/bpf.h>:

[acme@quaco perf]$ git diff
diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
index 3bd7fc17631f0440..e0d5525c6a1374ae 100644
--- a/tools/perf/examples/bpf/5sec.c
+++ b/tools/perf/examples/bpf/5sec.c
@@ -39,7 +39,6 @@
    Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
 */

-#include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>

 #define NSEC_PER_SEC   1000000000L
[acme@quaco perf]$

[root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
/home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:10: fatal error: 'bpf/bpf_helpers.h' file not found
#include <bpf/bpf_helpers.h>
         ^~~~~~~~~~~~~~~~~~~
1 error generated.
ERROR:	unable to compile /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
Hint:	Check error message shown above.
Hint:	You can also pre-compile it into .o using:
     		clang -target bpf -O2 -c /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
     	with proper -I and -D options.
event syntax error: '/home/acme/git/perf/tools/perf/examples/bpf/5sec.c'
                     \___ Failed to load /home/acme/git/perf/tools/perf/examples/bpf/5sec.c from source: Error when compiling BPF scriptlet

(add -v to see detail)
Run 'perf list' for a list of valid events

 Usage: perf trace [<options>] [<command>]
    or: perf trace [<options>] -- <command> [<options>]
    or: perf trace record [<options>] [<command>]
    or: perf trace record [<options>] -- <command> [<options>]

    -e, --event <event>   event/syscall selector. use 'perf list' to list available events
[root@quaco ~]#

It is not even finding it, in this machine I have libbpf 0.7.0, so there
is a /usr/include/bpf/bpf_helpers.h, but probably that isn't in the
include path set up to build the tools/perf/examples/bpf/ files, perhaps
it should use:

-Itools/lib/  so that it gets tools/lib/bpf_helpers.h?

Trying to get this tested...

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/examples/bpf/5sec.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
> index e6b6181c6dc6..f22312c64713 100644
> --- a/tools/perf/examples/bpf/5sec.c
> +++ b/tools/perf/examples/bpf/5sec.c
> @@ -39,13 +39,15 @@
>     Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
>  */
>  
> -#include <bpf.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
>  
>  #define NSEC_PER_SEC	1000000000L
>  
> -int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
> +SEC("hrtimer_nanosleep=hrtimer_nanosleep rqtp")
> +int hrtimer_nanosleep(void *ctx, int err, long long sec)
>  {
>  	return sec / NSEC_PER_SEC == 5ULL;
>  }
> +char _license[] SEC("license") = "GPL";
>  
> -license(GPL);
> -- 
> 2.38.1.273.g43a17bfeac-goog

-- 

- Arnaldo
