Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15998674BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjATFPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjATFOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:14:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A94F30B24;
        Thu, 19 Jan 2023 21:03:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0C14B8267E;
        Thu, 19 Jan 2023 17:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F41FC433D2;
        Thu, 19 Jan 2023 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674148521;
        bh=rtOB0o7GVvlggA/TPHQGC4w4owt9Pi+Sfuf3oR1Rh8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=M4xYxrNNGs/aDeLFzDWywmEiIJk806FJQ4ofwDBksVtNW4Q1NypdPwmlDmwVd0jHL
         OEmTMHgEmExFX8ri6hWBIO2t8UNcCts+AG5ztYpXzHphO/UEF//nMqe7ZlYjv4oQ0c
         O0XhQWxCdlaP8Eigf0ujBq24OqwZMQVoUKLczuKWGgaf/CstfgePJ/UzuPkcZWnNEj
         JYXMkQ6ZOoZ0TuEBeLE89sbeMr4gaxXY0+qJPDnITzjmmoQc6Rd3ugwiMkDR/+J92b
         FkPbE2iQVDceu+SRly8XF8IstHOxq5ljtTR2jJZHOVpqxwDSVdtL6q9MmhgIO7jprO
         8dud3XEiJDNtQ==
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Sohom Datta <sohomdatta1+git@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.2: 3rd batch
Date:   Thu, 19 Jan 2023 14:15:10 -0300
Message-Id: <20230119171510.166368-1-acme@kernel.org>
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

	Sync of UAPI headers with the kernel sources, to address
warnings while building perf and two small fixes for the main tools + a
'perf test' fix related to the build-id fix.

	 Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit c1649ec55708ae42091a2f1bca1ab49ecd722d55:

  Merge tag 'nfsd-6.2-4' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux (2023-01-17 09:29:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.2-3-2023-01-19

for you to fetch changes up to 3d9c07c4cfc06cf7927cd00c04dffd1165d03c53:

  perf test build-id: Fix test check for PE file (2023-01-18 10:52:06 -0300)

----------------------------------------------------------------
perf tools fixes for v6.2: 3rd batch.

- Prevent reading into undefined memory in the expression lexer,
  accounting for a trailer backslash followed by the null byte.

- Fix file mode when copying files to the build id cache, the problem
  happens when the cache directory is in a different file system than the
  file being cached, otherwise the mode was preserved as only a hard link
  would be done to save space.

- Fix a related build-id 'perf test' entry that checked that permission
  when caching PE (Portable Executable) files, used when profiling
  Windows executables under wine.

- Sync the tools/ copies of kvm headers, build_bug.h, socket.h and
  arm64's cputype.h with the kernel sources.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (6):
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
      tools kvm headers arm64: Update KVM header from the kernel sources
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools headers: Syncronize linux/build_bug.h with the kernel sources

Athira Rajeev (2):
      perf buildid-cache: Fix the file mode with copyfile() while adding file to build-id cache
      perf test build-id: Fix test check for PE file

Sohom Datta (1):
      perf expr: Prevent normalize() from reading into undefined memory in the expression lexer

 tools/arch/arm64/include/asm/cputype.h         |  8 +++++++-
 tools/arch/arm64/include/uapi/asm/kvm.h        |  1 +
 tools/arch/x86/include/uapi/asm/kvm.h          |  5 +++++
 tools/include/linux/build_bug.h                |  9 +++++++++
 tools/include/uapi/linux/kvm.h                 |  3 +++
 tools/perf/tests/shell/buildid.sh              | 15 ++++++++++++++-
 tools/perf/trace/beauty/include/linux/socket.h |  5 ++++-
 tools/perf/util/build-id.c                     | 10 +++++++---
 tools/perf/util/expr.l                         |  5 ++++-
 9 files changed, 54 insertions(+), 7 deletions(-)
