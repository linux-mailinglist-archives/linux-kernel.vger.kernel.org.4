Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE3D728BC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjFHX31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbjFHX3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB4E30E1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:29:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56991d8e2b0so13680167b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266951; x=1688858951;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PUR1BaDg5UCDJ5L3mZfey+gmQnRwkETeHewM4NWReSw=;
        b=I41YQStEQO3vr784nVk2AuN2KmcI6CYImyY6oj9xMSOL/Yo/n5AgLeGczhU8NFwLQe
         ttny74OBfkuK6f8/wAMn399t38lrgo1DziPG3fqg2E8EOzKtpOmCLUIlu9VJl+oy96a6
         HTs8mk3Q5WH2kmszROgWDPIekrDqjw5P+L9RKWeN+cf/s7N46twWudk+coNyz4KuYyQr
         ZbHH0YlckfKFgDJvgw6uV2fJIEg454LWFtRqaHxPfRNDcZsyr7rFBGWMgz5hpVhqY1KR
         W05OV+dPXayUdvhMkc4RX1/SbZlFDM6BolOt44PIQkCnZ9wnUmpKbi+Ww0jFE5uiRpgF
         l3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266951; x=1688858951;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUR1BaDg5UCDJ5L3mZfey+gmQnRwkETeHewM4NWReSw=;
        b=DAtweEWqVkfEgShfAaMuQM6dsHCLuayi1z3Sk8O9qIC5wuA1LFa4eH5BPsXiJfdEgL
         4QOPeCG7fRgiytuPePUrmyfDEsgjltmuFDT93uLHVZkM39yG+26RxC620G+1uJPpRUk4
         6V6DxfH48JbELXYP75LXlJd0QHqVKDNgal8CWMARUOU29Dx0ii26CxgWM+l758wjmjpq
         /JmbyLPpO/yVocb99IF+BoaFghtf8wxxe/+kxbp4EYDvvh+nZqfFwv0KnTEiDg96S9eV
         hkucHT8H1WPbFd0eFmkU7J8YDwl1gS0Aj06QIg8SB0ADLz1Q7CIs7EhA+wANFYJ3Bp/Y
         cvEw==
X-Gm-Message-State: AC+VfDwJ3ykNKviAo9m3vqYJ5k3fOpIJ8z5IdvpBRQYIXKMZAXxiHYlA
        heSI4YGJAQ3UvqUOyBc1t5GsKdo5oZLx
X-Google-Smtp-Source: ACHHUZ7nvCcbtXwbQ8tPrBNQ7joytk73IzC7nG/F+wmEeTixEorelfj8HzfbCMpJUhp83IeyIqzk8iZHWWnX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:b64e:0:b0:561:856f:69d3 with SMTP id
 h14-20020a81b64e000000b00561856f69d3mr607499ywk.7.1686266951355; Thu, 08 Jun
 2023 16:29:11 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:27:57 -0700
Message-Id: <20230608232823.4027869-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 00/26] Fix memory leaks (was reference count checking for thread)
From:   Ian Rogers <irogers@google.com>
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use leak sanitizer and reference count checking to fix outstanding
memory leaks in "perf top" or those discovered in "perf test". Also
fix address sanitizer issues discovered.

Add reference count checking to thread after first refactoring bits of
the code, such as making the thread red-black tree non-invasive (so
the thread it references is easier to reference count, rather than
having 3 potential references). Part of this refactoring also removes
the dead thread list because if we held a reference here the threads
would never die and anything else has questionable
correctness.

addr_location is made into its own C/header file to capture the init,
exit and copy code.

Refactor and change callchain_cursor to come from a pthread key so
that a destructor can run on pthreads exiting.

Fix additional outstanding memory leak and reference count issues to
the point that "perf test" compiled with address sanitizer but without
libtraceevent passes all but one test - libtraceevent reports leaks
within its own code, most likely as it isn't compiled with
sanitizers. The remaining failing test is "68: Test dwarf unwind" and
that has address sanitizer issues as it uses memcpy to access the
stack within the process - we likely want to skip parts of the test
with sanitizers enabled.

v2. Include extra fixes for callchain cursor, addr2line and related
    "perf top" fixes, as well as the 2 patches in:
    https://lore.kernel.org/lkml/20230607050148.3248353-1-irogers@google.com/

Ian Rogers (26):
  perf thread: Remove notion of dead threads
  perf thread: Make threads rbtree non-invasive
  perf thread: Add accessor functions for thread
  perf maps: Make delete static, always use put
  perf addr_location: Move to its own header
  perf addr_location: Add init/exit/copy functions
  perf thread: Add reference count checking
  perf machine: Make delete_threads part of machine__exit
  perf report: Avoid thread leak
  perf header: Ensure bitmaps are freed
  perf stat: Avoid evlist leak
  perf intel-pt: Fix missed put and leak
  perf evlist: Free stats in all evlist destruction
  perf python: Avoid 2 leak sanitizer issues
  perf jit: Fix two thread leaks
  perf symbol-elf: Correct holding a reference
  perf maps: Fix overlapping memory leak
  perf machine: Fix leak of kernel dso
  perf machine: Don't leak module maps
  perf map/maps/thread: Changes to reference counting
  perf annotate: Fix parse_objdump_line memory leak
  perf top: Add exit routine for main thread
  perf header: Avoid out-of-bounds read
  perf callchain: Use pthread keys for tls callchain_cursor
  perf srcline: Change free_srcline to zfree_srcline
  perf hist: Fix srcline memory leak

 tools/perf/arch/arm/tests/dwarf-unwind.c      |   2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c    |   2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c  |   2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c      |   2 +-
 tools/perf/builtin-annotate.c                 |  28 +-
 tools/perf/builtin-c2c.c                      |  22 +-
 tools/perf/builtin-diff.c                     |  20 +-
 tools/perf/builtin-inject.c                   |   4 +-
 tools/perf/builtin-kmem.c                     |  13 +-
 tools/perf/builtin-kwork.c                    |  15 +-
 tools/perf/builtin-mem.c                      |   4 +-
 tools/perf/builtin-report.c                   |  21 +-
 tools/perf/builtin-sched.c                    |  80 ++---
 tools/perf/builtin-script.c                   | 123 ++++----
 tools/perf/builtin-stat.c                     |   1 +
 tools/perf/builtin-timechart.c                |  11 +-
 tools/perf/builtin-top.c                      |  19 +-
 tools/perf/builtin-trace.c                    |  38 ++-
 .../scripts/python/Perf-Trace-Util/Context.c  |   4 +-
 tools/perf/tests/code-reading.c               |   6 +-
 tools/perf/tests/dwarf-unwind.c               |   1 -
 tools/perf/tests/hists_common.c               |   2 +-
 tools/perf/tests/hists_cumulate.c             |  18 +-
 tools/perf/tests/hists_filter.c               |  11 +-
 tools/perf/tests/hists_link.c                 |  20 +-
 tools/perf/tests/hists_output.c               |  12 +-
 tools/perf/tests/maps.c                       |   2 +-
 tools/perf/tests/mmap-thread-lookup.c         |   5 +-
 tools/perf/tests/perf-targz-src-pkg           |   5 +-
 tools/perf/tests/symbols.c                    |   1 -
 tools/perf/tests/thread-maps-share.c          |  13 +-
 tools/perf/trace/beauty/pid.c                 |   4 +-
 tools/perf/ui/browsers/hists.c                |  19 +-
 tools/perf/ui/hist.c                          |   5 +-
 tools/perf/ui/stdio/hist.c                    |   2 +-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/addr_location.c               |  44 +++
 tools/perf/util/addr_location.h               |  31 ++
 tools/perf/util/annotate.c                    |   5 +-
 tools/perf/util/arm-spe.c                     |   4 +-
 tools/perf/util/block-info.c                  |   4 +-
 tools/perf/util/build-id.c                    |   2 +
 tools/perf/util/callchain.c                   |  68 +++-
 tools/perf/util/callchain.h                   |   4 +-
 tools/perf/util/cs-etm.c                      |  28 +-
 tools/perf/util/data-convert-json.c           |  16 +-
 tools/perf/util/db-export.c                   |  30 +-
 tools/perf/util/dlfilter.c                    |  17 +-
 tools/perf/util/event.c                       |  37 +--
 tools/perf/util/evlist.c                      |   2 +
 tools/perf/util/evsel_fprintf.c               |   8 +-
 tools/perf/util/header.c                      |  14 +-
 tools/perf/util/hist.c                        |  59 ++--
 tools/perf/util/intel-bts.c                   |   2 +-
 tools/perf/util/intel-pt.c                    |  88 +++---
 tools/perf/util/jitdump.c                     |  12 +-
 tools/perf/util/machine.c                     | 292 +++++++++---------
 tools/perf/util/map.c                         |   4 +-
 tools/perf/util/maps.c                        |   5 +-
 tools/perf/util/maps.h                        |   9 +-
 tools/perf/util/python.c                      |   4 +
 .../scripting-engines/trace-event-python.c    |  40 ++-
 tools/perf/util/session.c                     |   8 +-
 tools/perf/util/sort.c                        |  12 +-
 tools/perf/util/srcline.c                     |  15 +-
 tools/perf/util/srcline.h                     |   2 +-
 tools/perf/util/symbol-elf.c                  |   4 +-
 tools/perf/util/symbol.h                      |  17 +-
 tools/perf/util/thread-stack.c                |  25 +-
 tools/perf/util/thread.c                      | 222 +++++++------
 tools/perf/util/thread.h                      | 210 ++++++++++++-
 tools/perf/util/unwind-libdw.c                |  27 +-
 tools/perf/util/unwind-libunwind-local.c      |  19 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 tools/perf/util/vdso.c                        |   2 +-
 75 files changed, 1210 insertions(+), 722 deletions(-)
 create mode 100644 tools/perf/util/addr_location.c
 create mode 100644 tools/perf/util/addr_location.h

-- 
2.41.0.162.gfafddb0af9-goog

