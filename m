Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A266623E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjAKRoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjAKRns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:43:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C85C1740A;
        Wed, 11 Jan 2023 09:43:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA891B81BB4;
        Wed, 11 Jan 2023 17:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7216C433EF;
        Wed, 11 Jan 2023 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673459023;
        bh=ZZwQM8Y8BQdj74nMk/ReDulPCgU+sZ0CNX/Jvg5Oms0=;
        h=From:To:Cc:Subject:Date:From;
        b=HR9PCFox+528RqyEM/DmSeUsR0WSgXloPEMDod9QrlCctn77uAztrKoLtu8TYmQYb
         smGwFLgF1eZxbF7B7yQMDEE1AHARheTE6DNJFVfwHnCmlmdQi/DCo+2lmMJ5YpvXj6
         jK0pohXaumgz8mYAfj6BlQVepNhIQ2bluJJGwMP5ZhhVEHhsdfpX+PdwYkBSoXmdam
         M8GeK/5GLUhqHJcGzjLPDt6czxQlfN7Q2LMunOad3GZyPwKfY1O4MHT8Bx/mKYyDkw
         h8jVRuhnC7FbE8nin3SLjyiu0qEZ8aj+tGZvoTrEy62fdrDhNdxCXLheb24/FqIunK
         dbFg2uBsu93IQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Dmitry Dolgov <9erthalion6@gmail.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.2: 2nd batch
Date:   Wed, 11 Jan 2023 14:43:31 -0300
Message-Id: <20230111174331.984275-1-acme@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo


The following changes since commit 1fe4fd6f5cad346e598593af36caeadc4f5d4fa9:

  Merge tag 'xfs-6.2-fixes-2' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2023-01-08 12:11:45 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.2-2-2023-01-11

for you to fetch changes up to cf129830ee820f7fc90b98df193cd49d49344d09:

  perf auxtrace: Fix address filter duplicate symbol selection (2023-01-11 14:03:44 -0300)

----------------------------------------------------------------
perf tools fixes for v6.2: 2nd batch

- Make 'perf kmem' cope with the removal of kmem:kmem_cache_alloc_node and
  kmem:kmalloc_node in the 11e9734bcb6a7361 ("mm/slab_common: unify NUMA and
  UMA version of tracepoints") commit, making sure it works with Linux >= 6.2 as well
  as with older kernels where those tracepoints are present.

- Also make it handle the new "node" kmem:kmalloc and kmem:kmem_cache_alloc tracepoint
  field introduced in that same commit.

- Fix hardware tracing PMU address filter duplicate symbol selection, that was
  preventing to match with static functions with the same name present in different
  object files.

- Fix regression on what linux/types.h file gets used to build the "BPF prologue"
  'perf test' entry, the system one lacks the fmode_t definition used in this test,
  so provide that type in the test itself.

- Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DYNAMIC=1. If the user asks for
  linking with the libbpf package provided by the distro, then it has to be >= 0.8.0.
  Using the libbpf supplied with the kernel would be a fallback in that case.

- Fix the build when libbpf isn't available or explicitly disabled via NO_LIBBPF=1.

- Don't try to install libtraceevent plugins as its not anymore in the kernel sources
  and will thus always fail.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf auxtrace: Fix address filter duplicate symbol selection

Arnaldo Carvalho de Melo (2):
      perf tools: Don't install libtraceevent plugins as its not anymore in the kernel sources
      perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DYNAMIC=1

Athira Rajeev (1):
      perf tests bpf prologue: Fix bpf-script-test-prologue test compile issue with clang

Ian Rogers (2):
      perf build: Properly guard libbpf includes
      perf build: Fix build error when NO_LIBBPF=1

Leo Yan (2):
      perf kmem: Support legacy tracepoints
      perf kmem: Support field "node" in evsel__process_alloc_event() coping with recent tracepoint restructuring

 tools/perf/Makefile.config                  | 12 ++----
 tools/perf/Makefile.perf                    | 21 ++++++----
 tools/perf/builtin-kmem.c                   | 65 ++++++++++++++++++++++-------
 tools/perf/builtin-trace.c                  |  2 +
 tools/perf/tests/bpf-script-test-prologue.c |  2 +
 tools/perf/tests/make                       | 12 ------
 tools/perf/util/auxtrace.c                  |  2 +-
 tools/perf/util/bpf_counter.h               |  6 +++
 8 files changed, 77 insertions(+), 45 deletions(-)
