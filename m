Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E5E725509
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbjFGHHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjFGHHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:07:35 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573C3E60
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:07:33 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33dea7d5424so62235ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686121652; x=1688713652;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcGwQSVyAp3ND07pt/6FkVCagDMT34+Ln3iOxQ48B/U=;
        b=erNZDoZ/Y0f6v89AXb+jrbNE+ujTR/i887PSjYNGlw6IWW1t0yvNuTMoLfEd7AE5zp
         AC68sh1+qMjWU8PA2RccKOVd+FalC7+skzJoLNcxuDwFSzRoicta5biKuQMmlXJr9PCl
         IjaNey0iGUGLVKeySLEt5+9Itu9isty9zGMJNAGlHUqu6TyfBxgBPrtmaRe8TJwwEk0T
         weC8osFlfzCFe52LWjBXRutoci5OKFI8vswl5W0jn9n5bmx31l8Z0cIQhl2zeY3+vBV4
         rpbp4eD6CJjij6dPgVgN4qeja1ZUx755VV3BeT2LxxqtwgB1aFEHSFyHbCFe4YZrUUCT
         sOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686121652; x=1688713652;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcGwQSVyAp3ND07pt/6FkVCagDMT34+Ln3iOxQ48B/U=;
        b=VADX6Q6sbyuYy10BUhjqDZunWNOZMx+KJYxbGrmVXG99Y7vuQfn5Kxn8elIavg2YVi
         WDr3zDH2QcLAbPyPjIaP8aEg/yC+ODherBJY+tHSzva58EoRD0ZmDnVZzDt/Mv97lC+3
         W1vwUW/hVVhqDz82f4dTmXMzn0tVdXH8ZtIb3Z7MnCcs+JN8T8olPx36XfXKrBBzo4rM
         cdh/SYTOmOvnVqr/hmonUCZWEh703wQeREx4YOqKXmppO+pgSazSWEK7jlCuPu4AhfBY
         gEM4Aq9AsSz2qAA4Qiv9v4vus4YvMavKU2eurNb8ImWN56uIsZDU/E75DYFcJlFT73fW
         0rQA==
X-Gm-Message-State: AC+VfDzDoaBGoWvnk3X8SabSHuiDfch3S9dXAJ68HF7YY7xq4Qpeu/8s
        tN/nMuNokr9+A7fT+csrOg9FORXFgQPhSy+o0gYdVA==
X-Google-Smtp-Source: ACHHUZ58vsaCXdHNLV8X4ZklTwoe84disbMNsE7/mgT2qfo3AHSxVtJly/5mvt8fKIFWbFPgQuFk0B6Zj+wMuOnSh08=
X-Received: by 2002:a05:6e02:1a88:b0:33b:5343:c1be with SMTP id
 k8-20020a056e021a8800b0033b5343c1bemr78901ilv.29.1686121652421; Wed, 07 Jun
 2023 00:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 7 Jun 2023 00:07:21 -0700
Message-ID: <CAP-5=fW3B8iNyqmSTYYf7_ds37QnfmYERVz8OvMJrJE=GU5omg@mail.gmail.com>
Subject: Re: [PATCH v1 00/20] Reference count checking for thread
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
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
        Raul Silvera <rsilvera@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 6:44=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Add reference count checking to thread after first refactoring bits of
> the code, such as making the thread red-black tree non-invasive (so
> the thread it references is easier to reference count, rather than
> having 3 potential references). Part of this refactoring also removes
> the dead thread list because if we held a reference here the threads
> would never die and anything else has questionable
> correctness. addr_location is made into its own C/header file to
> capture the init, exit and copy code.
>
> Fix additional outstanding memory leak and reference count issues to
> the point that "perf test" compiled with address sanitizer but without
> libtraceevent passes all but one test - libtraceevent reports leaks
> within its own code, most likely as it isn't compiled with
> sanitizers. The remaining failing test is "68: Test dwarf unwind" and
> that has address sanitizer issues as it uses memcpy to access the
> stack within the process - we likely want to skip parts of the test
> with sanitizers enabled.

So I tried a bit harder to break things and ran into crashes/leaks
around callchains fixed by the patch below - I used  'perf top -g' and
I'll merge the patch into a v2 for the series. The largest remaining
leak is caused by map/maps retaining dsos retaining symbols. The map
and maps are being retained by the TLS call chain cursors [1]
allocated in callchain_cursor_append. For perf report there are
similar retention issues via "struct hists", but as this maybe merged
with evsels it is messy to cleanup.

Thanks,
Ian

```
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 437325d19ad3..909f62b3b266 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -590,6 +590,7 @@ fill_node(struct callchain_node *node, struct
callchain_cursor *cursor)
               call->ip =3D cursor_node->ip;
               call->ms =3D cursor_node->ms;
               call->ms.map =3D map__get(call->ms.map);
+               call->ms.maps =3D maps__get(call->ms.maps);
               call->srcline =3D cursor_node->srcline;

               if (cursor_node->branch) {
@@ -649,6 +650,7 @@ add_child(struct callchain_node *parent,
               list_for_each_entry_safe(call, tmp, &new->val, list) {
                       list_del_init(&call->list);
                       map__zput(call->ms.map);
+                       maps__zput(call->ms.maps);
                       free(call);
               }
               free(new);
@@ -1010,10 +1012,16 @@ merge_chain_branch(struct callchain_cursor *cursor,
       int err =3D 0;

       list_for_each_entry_safe(list, next_list, &src->val, list) {
-               callchain_cursor_append(cursor, list->ip, &list->ms,
-                                       false, NULL, 0, 0, 0, list->srcline=
);
+               struct map_symbol ms =3D {
+                       .maps =3D maps__get(list->ms.maps),
+                       .map =3D map__get(list->ms.map),
+               };
+               callchain_cursor_append(cursor, list->ip, &ms, false,
NULL, 0, 0, 0, list->srcline);
               list_del_init(&list->list);
+               map__zput(ms.map);
+               maps__zput(ms.maps);
               map__zput(list->ms.map);
+               maps__zput(list->ms.maps);
               free(list);
       }

@@ -1068,8 +1076,8 @@ int callchain_cursor_append(struct
callchain_cursor *cursor,
       maps__zput(node->ms.maps);
       map__zput(node->ms.map);
       node->ms =3D *ms;
-       node->ms.maps =3D maps__get(node->ms.maps);
-       node->ms.map =3D map__get(node->ms.map);
+       node->ms.maps =3D maps__get(ms->maps);
+       node->ms.map =3D map__get(ms->map);
       node->branch =3D branch;
       node->nr_loop_iter =3D nr_loop_iter;
       node->iter_cycles =3D iter_cycles;
@@ -1463,12 +1471,14 @@ static void free_callchain_node(struct
callchain_node *node)
       list_for_each_entry_safe(list, tmp, &node->parent_val, list) {
               list_del_init(&list->list);
               map__zput(list->ms.map);
+               maps__zput(list->ms.maps);
               free(list);
       }

       list_for_each_entry_safe(list, tmp, &node->val, list) {
               list_del_init(&list->list);
               map__zput(list->ms.map);
+               maps__zput(list->ms.maps);
               free(list);
       }

@@ -1554,6 +1564,7 @@ int callchain_node__make_parent_list(struct
callchain_node *node)
       list_for_each_entry_safe(chain, new, &head, list) {
               list_del_init(&chain->list);
               map__zput(chain->ms.map);
+               maps__zput(chain->ms.maps);
               free(chain);
       }
       return -ENOMEM;
@@ -1599,8 +1610,10 @@ void callchain_cursor_reset(struct
callchain_cursor *cursor)
       cursor->nr =3D 0;
       cursor->last =3D &cursor->first;

-       for (node =3D cursor->first; node !=3D NULL; node =3D node->next)
+       for (node =3D cursor->first; node !=3D NULL; node =3D node->next) {
               map__zput(node->ms.map);
+               maps__zput(node->ms.maps);
+       }
}

void callchain_param_setup(u64 sample_type, const char *arch)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 16dc49876e87..bdad4b8bf77d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2321,7 +2321,7 @@ static int add_callchain_ip(struct thread *thread,
                           struct iterations *iter,
                           u64 branch_from)
{
-       struct map_symbol ms;
+       struct map_symbol ms =3D {};
       struct addr_location al;
       int nr_loop_iter =3D 0, err =3D 0;
       u64 iter_cycles =3D 0;
@@ -3091,6 +3091,7 @@ static int append_inlines(struct
callchain_cursor *cursor, struct map_symbol *
ms
       struct dso *dso;
       u64 addr;
       int ret =3D 1;
+       struct map_symbol ilist_ms;

       if (!symbol_conf.inline_name || !map || !sym)
               return ret;
@@ -3107,18 +3108,20 @@ static int append_inlines(struct
callchain_cursor *cursor, struct map_symbol
*ms
               inlines__tree_insert(&dso->inlined_nodes, inline_node);
       }

+       ilist_ms =3D (struct map_symbol) {
+               .maps =3D maps__get(ms->maps),
+               .map =3D map__get(map),
+       };
       list_for_each_entry(ilist, &inline_node->val, list) {
-               struct map_symbol ilist_ms =3D {
-                       .maps =3D ms->maps,
-                       .map =3D map,
-                       .sym =3D ilist->symbol,
-               };
+               ilist_ms.sym =3D ilist->symbol;
               ret =3D callchain_cursor_append(cursor, ip, &ilist_ms, false=
,
                                             NULL, 0, 0, 0, ilist->srcline)=
;

               if (ret !=3D 0)
                       return ret;
       }
+       map__put(ilist_ms.map);
+       maps__put(ilist_ms.maps);

       return ret;
}
```

[1] http://lkml.kernel.org/r/1338443007-24857-1-git-send-email-namhyung.kim=
@lge.com

> Ian Rogers (20):
>   perf thread: Remove notion of dead threads
>   perf thread: Make threads rbtree non-invasive
>   perf thread: Add accessor functions for thread
>   perf maps: Make delete static, always use put
>   perf addr_location: Move to its own header
>   perf addr_location: Add init/exit/copy functions
>   perf thread: Add reference count checking
>   perf machine: Make delete_threads part of machine__exit
>   perf report: Avoid thread leak
>   perf header: Ensure bitmaps are freed
>   perf stat: Avoid evlist leak
>   perf intel-pt: Fix missed put and leak
>   perf evlist: Free stats in all evlist destruction
>   perf python: Avoid 2 leak sanitizer issues
>   perf jit: Fix two thread leaks
>   perf symbol-elf: Correct holding a reference
>   perf maps: Fix overlapping memory leak
>   perf machine: Fix leak of kernel dso
>   perf machine: Don't leak module maps
>   perf map/maps/thread: Changes to reference counting
>
>  tools/perf/arch/arm/tests/dwarf-unwind.c      |   2 +-
>  tools/perf/arch/arm64/tests/dwarf-unwind.c    |   2 +-
>  tools/perf/arch/powerpc/tests/dwarf-unwind.c  |   2 +-
>  tools/perf/arch/x86/tests/dwarf-unwind.c      |   2 +-
>  tools/perf/builtin-annotate.c                 |  28 +-
>  tools/perf/builtin-c2c.c                      |  18 +-
>  tools/perf/builtin-diff.c                     |  16 +-
>  tools/perf/builtin-inject.c                   |   4 +-
>  tools/perf/builtin-kmem.c                     |  13 +-
>  tools/perf/builtin-kwork.c                    |  15 +-
>  tools/perf/builtin-mem.c                      |   4 +-
>  tools/perf/builtin-report.c                   |  21 +-
>  tools/perf/builtin-sched.c                    |  80 +++--
>  tools/perf/builtin-script.c                   |  97 +++---
>  tools/perf/builtin-stat.c                     |   1 +
>  tools/perf/builtin-timechart.c                |  11 +-
>  tools/perf/builtin-top.c                      |   8 +-
>  tools/perf/builtin-trace.c                    |  38 ++-
>  .../scripts/python/Perf-Trace-Util/Context.c  |   4 +-
>  tools/perf/tests/code-reading.c               |   6 +-
>  tools/perf/tests/dwarf-unwind.c               |   1 -
>  tools/perf/tests/hists_common.c               |   2 +-
>  tools/perf/tests/hists_cumulate.c             |  18 +-
>  tools/perf/tests/hists_filter.c               |  11 +-
>  tools/perf/tests/hists_link.c                 |  20 +-
>  tools/perf/tests/hists_output.c               |  12 +-
>  tools/perf/tests/maps.c                       |   2 +-
>  tools/perf/tests/mmap-thread-lookup.c         |   5 +-
>  tools/perf/tests/perf-targz-src-pkg           |   5 +-
>  tools/perf/tests/symbols.c                    |   1 -
>  tools/perf/tests/thread-maps-share.c          |  13 +-
>  tools/perf/trace/beauty/pid.c                 |   4 +-
>  tools/perf/ui/browsers/hists.c                |  19 +-
>  tools/perf/ui/hist.c                          |   5 +-
>  tools/perf/ui/stdio/hist.c                    |   2 +-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/addr_location.c               |  44 +++
>  tools/perf/util/addr_location.h               |  31 ++
>  tools/perf/util/arm-spe.c                     |   4 +-
>  tools/perf/util/build-id.c                    |   2 +
>  tools/perf/util/callchain.c                   |   7 +-
>  tools/perf/util/cs-etm.c                      |  28 +-
>  tools/perf/util/data-convert-json.c           |  16 +-
>  tools/perf/util/db-export.c                   |  20 +-
>  tools/perf/util/dlfilter.c                    |  17 +-
>  tools/perf/util/event.c                       |  37 +--
>  tools/perf/util/evlist.c                      |   2 +
>  tools/perf/util/evsel_fprintf.c               |   8 +-
>  tools/perf/util/header.c                      |  12 +-
>  tools/perf/util/hist.c                        |  22 +-
>  tools/perf/util/intel-bts.c                   |   2 +-
>  tools/perf/util/intel-pt.c                    |  88 +++---
>  tools/perf/util/jitdump.c                     |  12 +-
>  tools/perf/util/machine.c                     | 277 +++++++++---------
>  tools/perf/util/map.c                         |   2 +-
>  tools/perf/util/maps.c                        |   5 +-
>  tools/perf/util/maps.h                        |   9 +-
>  tools/perf/util/python.c                      |   4 +
>  .../scripting-engines/trace-event-python.c    |  28 +-
>  tools/perf/util/session.c                     |   8 +-
>  tools/perf/util/sort.c                        |  12 +-
>  tools/perf/util/symbol-elf.c                  |   4 +-
>  tools/perf/util/symbol.h                      |  17 +-
>  tools/perf/util/thread-stack.c                |  25 +-
>  tools/perf/util/thread.c                      | 218 +++++++-------
>  tools/perf/util/thread.h                      | 210 +++++++++++--
>  tools/perf/util/unwind-libdw.c                |  27 +-
>  tools/perf/util/unwind-libunwind-local.c      |  19 +-
>  tools/perf/util/unwind-libunwind.c            |   2 +-
>  tools/perf/util/vdso.c                        |   2 +-
>  70 files changed, 1059 insertions(+), 655 deletions(-)
>  create mode 100644 tools/perf/util/addr_location.c
>  create mode 100644 tools/perf/util/addr_location.h
>
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
