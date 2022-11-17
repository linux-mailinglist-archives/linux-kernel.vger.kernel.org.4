Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F07A62E1FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiKQQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbiKQQeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:34:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0CE5B5BD;
        Thu, 17 Nov 2022 08:31:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81AFAB8210C;
        Thu, 17 Nov 2022 16:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F09C433D6;
        Thu, 17 Nov 2022 16:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702717;
        bh=b0YjUGAglSS0uu1T/tbf8INnGz3tzsSTKbmCWUW4cy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MN3s+Rl+pKxEChgQjLEVVHdepE/MYwmZikbLvEmzHaJ5B4+tkBAgs5THUxTgtu+2D
         iZoacj4jBYsn3vD+/iEQl5RzH61pq4xYnO5yapYDtSwJP+RJ5TzcbkTZSK/JOVclUc
         F14c3RhwBJAC+SO3gqtP+R9Iy0VQo6VIwQufzj0i/mZ7LwWpn7aTY4fz28hcxTcE6+
         hjl5I2HQL8KVqMyK2bBUSDI5VBzyQxRk5yYiU+4nS1lQW18eQY2n1YNMc/eAiMiOe6
         dTCIh/PRheS752t9n08YUT5oCBtteiX8xXQ0vQcoFtMXQAWLhJYxKxC5cfjZq35Ptd
         uvuwmCxUZRV8Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 755ED4034E; Thu, 17 Nov 2022 13:31:53 -0300 (-03)
Date:   Thu, 17 Nov 2022 13:31:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 10/10] perf list: Add json output option
Message-ID: <Y3Zh+XTXbhrOXAla@kernel.org>
References: <20221114210723.2749751-1-irogers@google.com>
 <20221114210723.2749751-11-irogers@google.com>
 <Y3OX1pcclKCgbpeT@kernel.org>
 <Y3TIG7BIzltgvCPw@kernel.org>
 <Y3TK/6bBFsHxduPc@kernel.org>
 <Y3TOwYdhzURKTgyB@kernel.org>
 <Y3Tah5Ocvx6lQ4jP@kernel.org>
 <Y3ThXYH3SAyEGmQ+@kernel.org>
 <Y3T/35DcAw+h4R93@kernel.org>
 <CAP-5=fU-tJPdxosVFfbbKtrswom7bnY6Ei3JczRJaQYyOnjcAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU-tJPdxosVFfbbKtrswom7bnY6Ei3JczRJaQYyOnjcAA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 16, 2022 at 11:52:39AM -0800, Ian Rogers escreveu:
> On Wed, Nov 16, 2022 at 7:21 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Nov 16, 2022 at 10:10:53AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Wed, Nov 16, 2022 at 09:41:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > But then:
> > >
> > > > [root@five ~]# perf list syscalls:sys_enter_open* |& grep syscalls:
> > > >   syscalls:sys_enter_open                            [Tracepoint event]
> > > >   syscalls:sys_enter_open_by_handle_at               [Tracepoint event]
> > > >   syscalls:sys_enter_open_tree                       [Tracepoint event]
> > > >   syscalls:sys_enter_openat                          [Tracepoint event]
> > > >   syscalls:sys_enter_openat2                         [Tracepoint event]
> > > > [root@five ~]#
> > > >
> > > > This stops working, looking into it.
> > >
> > > Sidetracked with other stuff, please find what I have patched at
> > > perf/perf-list-json-output in my tree.
> > >
> > > I removed the last two patches and I'm testing so that I can push
> > > perf/core with your series modulo the last two + Namhyung's 'perf list'
> > > kit.
> >
> > I just saw you sent a patch on top of the previous one, will try and
> > combine stuff to remove failures from the bisect history.
> >
> > - Arnaldo
> 
> So the failing test was skipping for me due to a lack of kernel
> symbols, sorry for not spotting it. I find that the issue is resolved
> with your fixes and:
> 
> ```
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 30937e1dd82c..ad6cb5d2e1cc 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -107,7 +107,7 @@ static void default_print_event(void *ps, const
> char *pmu_name, const char *topi
>        if (deprecated && !print_state->deprecated)
>                return;
> 
> -       if (print_state->pmu_glob && !strglobmatch(pmu_name,
> print_state->pmu_glob))
> +       if (print_state->pmu_glob && pmu_name &&
> !strglobmatch(pmu_name, print_state->pmu_glob))
>                return;
> 
>        if (print_state->event_glob &&
> @@ -534,24 +534,18 @@ int cmd_list(int argc, const char **argv)
>                        default_ps.metrics = false;
>                        metricgroup__print(&print_cb, ps);
>                } else if ((sep = strchr(argv[i], ':')) != NULL) {
> -                       int sep_idx;
> -
> -                       sep_idx = sep - argv[i];
> -                       s = strdup(argv[i]);
> -                       if (s == NULL) {
> +                       default_ps.event_glob = strdup(argv[i]);
> +                       if (!default_ps.event_glob) {
>                                ret = -1;
>                                goto out;
>                        }
> -
> -                       s[sep_idx] = '\0';
> -                       default_ps.pmu_glob = s;
> -                       default_ps.event_glob = s + sep_idx + 1;
>                        print_tracepoint_events(&print_cb, ps);
>                        print_sdt_events(&print_cb, ps);
>                        default_ps.metrics = true;
>                        default_ps.metricgroups = true;
>                        metricgroup__print(&print_cb, ps);
> -                       free(s);
> +                       free(default_ps.event_glob);
> +                       default_ps.event_glob = NULL;
> ```
> I think this should be squashed into "perf list: Reorganize to use
> callbacks". Some explanation, in porting the : glob case I'd assumed
> the before the colon would be the PMU and the after the event. Doing
> things caused tracepoint output to differ too much and so for
> tracepoints the : is kept in the event name. So we can simplify the
> matching to not be pmu and event, just use the event glob.

Next time please send the patch, I did it manually and before the last
option I get:

[root@quaco ~]# perf list syscalls:sys_enter_open |& grep syscalls
  syscalls:sys_enter_open                            [Tracepoint event]
[root@quaco ~]# perf test 112
112: Check open filename arg using perf trace + vfs_getname          : Ok
[root@quaco ~]#

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 0c84fdb3ad37c1ad..7b63bc30665a7f56 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -19,6 +19,7 @@
 #include "util/strlist.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
+#include <linux/zalloc.h>
 #include <stdio.h>
 
 /**
@@ -328,25 +329,20 @@ int cmd_list(int argc, const char **argv)
 			ps.metrics = false;
 			metricgroup__print(&print_cb, &ps);
 		} else if ((sep = strchr(argv[i], ':')) != NULL) {
-			int sep_idx;
 			char *old_pmu_glob = ps.pmu_glob;
 
-			sep_idx = sep - argv[i];
-			s = strdup(argv[i]);
-			if (s == NULL) {
+			ps.event_glob = strdup(argv[i]);
+			if (!ps.event_glob) {
 				ret = -1;
 				goto out;
 			}
 
-			s[sep_idx] = '\0';
-			ps.pmu_glob = s;
-			ps.event_glob = s + sep_idx + 1;
 			print_tracepoint_events(&print_cb, &ps);
 			print_sdt_events(&print_cb, &ps);
 			ps.metrics = true;
 			ps.metricgroups = true;
 			metricgroup__print(&print_cb, &ps);
-			free(s);
+			zfree(&ps.event_glob);
 			ps.pmu_glob = old_pmu_glob;
 		} else {
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
