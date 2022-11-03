Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A65618304
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiKCPkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKCPkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC01BC94;
        Thu,  3 Nov 2022 08:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36C7261F37;
        Thu,  3 Nov 2022 15:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648C4C433C1;
        Thu,  3 Nov 2022 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667490003;
        bh=7cNJ3eImJN9ggcpVDNFcQ1cXwlPLaUGnXqZBgd/8k9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRILNxQcN5dT9cnjWyrxeHJUgZbPQXB5o++XUXdWDnmQBR0fKvgY4nFIaP7Y+xQlY
         lzrblDkmdS7FCE5aLmyitObJvc6/R2hBR+3qWMd3Y5d1wJzrW+Au4lYQ8ThyHXU5OS
         O9YgtQ23TTw+gRmlu/vRk5dc+6uNovHr+vZnYkRx4bNdySxHfUiCVQQgdenmDyGR22
         DcqQbb8E2EZCi+jXIZ7HPIHyIL4ynH5QInIRPMYSV9Zz1Pfv/eu3Db8ri1f+pyAno5
         5Lt7aPtH1TVQzXCx6soMErAkQEGbBQkkFKd+5DqO4XX4CQr3WzCHTRnr6E/PAfRTmM
         CNLQyWNrscAgg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DD9864034E; Thu,  3 Nov 2022 12:39:59 -0300 (-03)
Date:   Thu, 3 Nov 2022 12:39:59 -0300
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
Message-ID: <Y2Pgz7luG77Wr+Ci@kernel.org>
References: <20221103045437.163510-1-irogers@google.com>
 <20221103045437.163510-7-irogers@google.com>
 <Y2PgBPeZsd9+YWB4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PgBPeZsd9+YWB4@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 03, 2022 at 12:36:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Nov 02, 2022 at 09:54:36PM -0700, Ian Rogers escreveu:
> > Avoid use of tools/perf/include/bpf/bpf.h and use the more regular BPF
> > headers.
> > 
> > Note, on testing the probe was unable to attach and the program failed.
> 
> Humm, trying to test:
> 
> [root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/5sec.c |& head -15
> In file included from /home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:
> In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/bpf.h:9:
> In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/workqueue.h:9:
> In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/timer.h:6:
> In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/ktime.h:24:
> In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/time.h:6:
> In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/math64.h:6:
> In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/math.h:6:
> /lib/modules/5.19.16-200.fc36.x86_64/build/./arch/x86/include/asm/div64.h:85:28: error: invalid output constraint '=a' in asm
>         asm ("mulq %2; divq %3" : "=a" (q)
>                                   ^
> In file included from /home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:
> In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/bpf.h:9:
> In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/workqueue.h:9:
> In file included from /lib/modules/5.19.16-200.fc36.x86_64/build/./include/linux/timer.h:6:
> [root@quaco ~]#
> 
> So I go and try to remove that <linux/bpf.h>:
> 
> [acme@quaco perf]$ git diff
> diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
> index 3bd7fc17631f0440..e0d5525c6a1374ae 100644
> --- a/tools/perf/examples/bpf/5sec.c
> +++ b/tools/perf/examples/bpf/5sec.c
> @@ -39,7 +39,6 @@
>     Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
>  */
> 
> -#include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
> 
>  #define NSEC_PER_SEC   1000000000L
> [acme@quaco perf]$
> 
> [root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
> /home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:10: fatal error: 'bpf/bpf_helpers.h' file not found
> #include <bpf/bpf_helpers.h>
>          ^~~~~~~~~~~~~~~~~~~
> 1 error generated.
> ERROR:	unable to compile /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
> Hint:	Check error message shown above.
> Hint:	You can also pre-compile it into .o using:
>      		clang -target bpf -O2 -c /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
>      	with proper -I and -D options.
> event syntax error: '/home/acme/git/perf/tools/perf/examples/bpf/5sec.c'
>                      \___ Failed to load /home/acme/git/perf/tools/perf/examples/bpf/5sec.c from source: Error when compiling BPF scriptlet
> 
> (add -v to see detail)
> Run 'perf list' for a list of valid events
> 
>  Usage: perf trace [<options>] [<command>]
>     or: perf trace [<options>] -- <command> [<options>]
>     or: perf trace record [<options>] [<command>]
>     or: perf trace record [<options>] -- <command> [<options>]
> 
>     -e, --event <event>   event/syscall selector. use 'perf list' to list available events
> [root@quaco ~]#
> 
> It is not even finding it, in this machine I have libbpf 0.7.0, so there
> is a /usr/include/bpf/bpf_helpers.h, but probably that isn't in the
> include path set up to build the tools/perf/examples/bpf/ files, perhaps
> it should use:
> 
> -Itools/lib/  so that it gets tools/lib/bpf_helpers.h?
> 
> Trying to get this tested...

Running with -v:

llvm compiling command : /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CPUS__=8 -DLINUX_VERSION_CODE=0x51310 -g -I/home/acme/lib/perf/include/bpf -nostdinc -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/5.19.16-200.fc36.x86_64/build -c /home/acme/git/perf/tools/perf/examples/bpf/5sec.c -target bpf  -g -O2 -o -
/home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:10: fatal error: 'bpf/bpf_helpers.h' file not found

There is still that -I/home/acme/lib/perf/include/bpf, I'll remove it
from the include path and try to replace it with the libbpf path...

- Arnaldo
