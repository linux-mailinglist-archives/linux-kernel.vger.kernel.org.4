Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFA3663195
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjAIUeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjAIUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:34:40 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B064ECE39
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:34:39 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-434eb7c6fa5so104402997b3.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E9ogL9fBGTlSiBOaxHLGDQsLf+6hnlNrkyQf9wzS9SY=;
        b=eEkzzVs5l+fuL/ZtoLR38Eh9shkZTUb1u9waCyY7/UaKpmIh1ELVebXzD0+s1raGtu
         oquWZsAlt6BGf7J2m/rbCpxuQTIIOWLvyzlBAZQZ84+rYumGBpmCpvjjyq7MLoWSFRBc
         Md56UfNxdasYFiwlazLBzJ4ZpGzHMMHruv6E3dmi+RLvyCklp12meVmoMJ/dloJy25j6
         Htp0ssLwbCyX00gYBGX5JfCyQukcmJvMwHszcf6QQ2if64eREnjEDgcuvwbGsGXXa+eN
         XC3ti0Ly9nIDGDXhi2VvdNr/2iLzRU1VEL1lFmS0lW18MpdF92qEhGIFwt3NBC9diSyW
         sUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9ogL9fBGTlSiBOaxHLGDQsLf+6hnlNrkyQf9wzS9SY=;
        b=ROX9jhPIW5ryzFNturbv+5abHMxh2Nd/skUommN8aPU7pj9SUjy5TEhjVilRdsbyQw
         PbQl8ow+Szc62zQ7BQ20fFg/XgiDg8yG/vCU3zSTM6KOtOrrgY4nEHEG3INnYrqRFDZy
         jFNlu7biBqGQv6KeMBGdwAzlL1+1wnbO6xZihXQPF7XxkA5uVPfANGvd9xFSUV9mvU8f
         1/bnUnLCf2nbuSUgvxbktuk/9a3kR+v8epCerk7zUHCbrA1hZtfHIXZ2syhkC/badNO/
         7tmud2k85WIbvCqT6hznN2p0vY+mNcXulED+e1K7fJxThre5UDH8L/AjAilZEG7tzf6y
         is6Q==
X-Gm-Message-State: AFqh2koGfZMX0nSXPsQpIjLD7F61gBPfrsnj9TROhrnKwTK+4+4U8rQg
        byEo398XaZ3BDqOYCWyze9cGnPhdZWvZ
X-Google-Smtp-Source: AMrXdXtsVMhlvmlCs0y5swSgfwYhYMXnszwXJB/jKls1bekFVoIVNVsLB6ctPb8sHOk+oJVR7s+cPUzqzyHx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:59e7:81ad:bc43:d9dc])
 (user=irogers job=sendgmr) by 2002:a81:124e:0:b0:499:f27a:28ba with SMTP id
 75-20020a81124e000000b00499f27a28bamr2056335yws.145.1673296478964; Mon, 09
 Jan 2023 12:34:38 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:34:21 -0800
Message-Id: <20230109203424.1157561-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 0/3] Assume libbpf 1.0 in build
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libbpf 1.0 was a major change in API. Perf has partially supported
older libbpf's but an implementation may be:
..
       pr_err("%s: not support, update libbpf\n", __func__);
       return -ENOTSUP;
..

Rather than build a binary that would fail at runtime it is
preferrential just to build libbpf statically and link against
that. The static version is in the kernel tools tree and newer than
1.0.

These patches change the libbpf test to only pass when at least
version 1.0 is installed, then remove the conditional build and
feature logic.

The issue is discussed here:
https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@google.com/

Ian Rogers (3):
  tools build: Pass libbpf feature only if libbpf 1.0+
  perf build: Remove libbpf pre-1.0 feature tests
  perf bpf: Remove pre libbpf 1.0 conditional logic

 tools/build/feature/Makefile                  |  7 --
 .../feature/test-libbpf-bpf_map_create.c      |  8 ---
 .../test-libbpf-bpf_object__next_map.c        |  8 ---
 .../test-libbpf-bpf_object__next_program.c    |  8 ---
 .../build/feature/test-libbpf-bpf_prog_load.c |  9 ---
 .../test-libbpf-bpf_program__set_insns.c      |  8 ---
 .../test-libbpf-btf__load_from_kernel_by_id.c |  8 ---
 .../build/feature/test-libbpf-btf__raw_data.c |  8 ---
 tools/build/feature/test-libbpf.c             |  4 ++
 tools/perf/Makefile.config                    | 37 +----------
 tools/perf/util/bpf-event.c                   | 66 -------------------
 tools/perf/util/bpf-loader.c                  | 18 -----
 tools/perf/util/bpf_counter.c                 | 18 -----
 13 files changed, 5 insertions(+), 202 deletions(-)
 delete mode 100644 tools/build/feature/test-libbpf-bpf_map_create.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_map.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_program.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_prog_load.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_program__set_insns.c
 delete mode 100644 tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
 delete mode 100644 tools/build/feature/test-libbpf-btf__raw_data.c

-- 
2.39.0.314.g84b9a713c41-goog

