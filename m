Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617256B2F61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjCIVOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCIVN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:13:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42B7E9CCB;
        Thu,  9 Mar 2023 13:13:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A9BAB820C8;
        Thu,  9 Mar 2023 21:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA451C433EF;
        Thu,  9 Mar 2023 21:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678396433;
        bh=BeV26pTW4A5lvPDrYbQpGFlfWF2dzD/VF0QL/uwIDgw=;
        h=From:To:Cc:Subject:Date:From;
        b=oW+gyq4GejWp1tCcd/bDmwPlmhQqO+xlLbPJvdgwU6OtHkSsRTJRt3bNFWFCsy8mv
         69FeyKeDo3+o3OMJWdV96x9tRbuoDYtjWs9sq9LpIEfm/23rNUFa8nzWbfjwNCm2+i
         39WKAmYcwrpXyJQ4g7obpCGRM1idCXSTQjtUHUSTRCctVtaik/rvBWouS6u1coltzr
         P5uyzj0KxQiIaF5f0VFd1+F4im+HwSxeO3ENH0rXiBtc8BKjikWs+Bc+TXfEvizToc
         IBpHCmdAY3sMrWQiqf/4EFsfZbfYU88CWP2v0c3NsK3yKeg+DAsqM7LUkY0UBm19AU
         NyAUgZIsNnCRQ==
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
        Changbin Du <changbin.du@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.3
Date:   Thu,  9 Mar 2023 18:13:46 -0300
Message-Id: <20230309211346.904516-1-acme@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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


The following changes since commit f9fa0778ee7349a9aa3d2ea10e9f2ab843a0b44e:

  perf tests stat_all_metrics: Change true workload to sleep workload for system wide check (2023-02-17 17:22:56 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.3-1-2023-03-09

for you to fetch changes up to 5b201a82cd9d0945d70562974ea6ad8e3b1861b5:

  perf tools: Add Adrian Hunter to MAINTAINERS as a reviewer (2023-03-06 17:23:18 -0300)

----------------------------------------------------------------
perf tools fixes for v6.3:

- Add Adrian Hunter to MAINTAINERS as a perf tools reviewer.

- Sync various tools/ copies of kernel headers with the kernel sources, this
  time trying to avoid first merging with upstream to then update but instead
  copy from upstream so that a merge is avoided and the end result after merging
  this pull request is the one expected, tools/perf/check-headers.sh (mostly)
  happy, less warnings while building tools/perf/.

- Fix counting when initial delay configured by setting
  perf_attr.enable_on_exec when starting workloads from the perf command line.

- Don't avoid emitting a PERF_RECORD_MMAP2 in 'perf inject --buildid-all' when
  that record comes with a build-id, otherwise we end up not being able to
  resolve symbols.

- Don't use comma as the CSV output separator the "stat+csv_output" test, as
  comma can appear on some tests as a modifier for an event, use @ instead,
  ditto for the JSON linter test.

- The offcpu test was looking for some bits being set on
  task_struct->prev_state without masking other bits not important for this
  specific 'perf test', fix it.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (12):
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers svm: Sync svm headers with the kernel sources
      tools headers: Update the copy of x86's mem{cpy,set}_64.S used in 'perf bench'
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      tools headers: Synchronize {linux,vdso}/bits.h with the kernel sources
      tools include UAPI: Synchronize linux/fcntl.h with the kernel sources
      tools headers kvm: Sync uapi/{asm/linux} kvm.h headers with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools headers x86 cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      perf tools: Add Adrian Hunter to MAINTAINERS as a reviewer

Changbin Du (1):
      perf stat: Fix counting when initial delay configured

Ian Rogers (2):
      perf tests stat+csv_output: Switch CSV separator to @
      perf test: Avoid counting commas in json linter

Namhyung Kim (2):
      perf test: Fix offcpu test prev_state check
      perf inject: Fix --buildid-all not to eat up MMAP2

 MAINTAINERS                                        |  1 +
 tools/arch/arm64/include/uapi/asm/kvm.h            |  1 +
 tools/arch/x86/include/asm/cpufeatures.h           |  2 +-
 tools/arch/x86/include/asm/disabled-features.h     |  3 +-
 tools/arch/x86/include/asm/msr-index.h             | 31 ++++++++++++++++++++
 tools/arch/x86/include/asm/required-features.h     |  3 +-
 tools/arch/x86/include/uapi/asm/kvm.h              | 34 ++++++++++++++++++++--
 tools/arch/x86/include/uapi/asm/svm.h              |  6 ++++
 tools/arch/x86/lib/memcpy_64.S                     |  5 ++--
 tools/arch/x86/lib/memset_64.S                     |  4 ++-
 tools/include/linux/bits.h                         |  1 -
 tools/include/uapi/linux/fcntl.h                   |  1 +
 tools/include/uapi/linux/kvm.h                     |  9 ++++++
 tools/include/uapi/linux/perf_event.h              |  3 ++
 tools/include/uapi/linux/prctl.h                   |  6 ++++
 tools/include/uapi/linux/vhost.h                   |  8 +++++
 tools/include/vdso/bits.h                          |  1 +
 tools/perf/builtin-inject.c                        |  1 +
 tools/perf/builtin-stat.c                          | 15 ++++------
 .../perf/tests/shell/lib/perf_json_output_lint.py  | 29 +++++++++---------
 tools/perf/tests/shell/stat+csv_output.sh          | 23 ++++++++-------
 tools/perf/util/bpf_skel/off_cpu.bpf.c             |  2 +-
 tools/perf/util/stat.c                             |  6 +---
 tools/perf/util/stat.h                             |  1 -
 tools/perf/util/target.h                           | 12 ++++++++
 25 files changed, 154 insertions(+), 54 deletions(-)
