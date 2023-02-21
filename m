Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5B269E00B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjBUMP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjBUMPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:15:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375D325B90
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:14:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22CBC60FE9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3C2C433D2;
        Tue, 21 Feb 2023 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676981651;
        bh=2qsJdfbDVAPOImoyJDFbsExM45F/EPoTWXpuNj4khiQ=;
        h=Date:From:To:Cc:Subject:From;
        b=fx5k+nRLXOL3D67pNCjCKXjhhSg3WapgX4YiFKvVqWIiNHTKWDd2E3o95GTcg4F9R
         sj6+Fa9A6jLxdXiGkwbf6KVSequuTCXDSwISdECZZc7nRU8P9ImZlqYVZQjoqCq5r5
         S0/DPLTYPFqINJhyWvhZcQZQwDlR+5Fw6zm/LaY0LHkhQ+11mVLZ9EHp0XO6YdhAsF
         4ch24h4PHPM66/xIU/iop00J6KageDYCpc7KyIebawXs3GINL5Hp9y/1U6ezpTAK4C
         amMNQgORqot5AWhOTAkbtKsf03e0EJUSwstTy+3CdjmwHwKyqDTqK0miCfXzl7cbho
         KJDwA0RrLhQ3Q==
Date:   Tue, 21 Feb 2023 21:14:08 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Donglin Peng <dolinux.peng@gmail.com>,
        Masami Hiramatsu (Google) <mhiramat@kernel.org>,
        Quanfa Fu <quanfafu@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [GIT PULL] probes: Updates for 6.3
Message-Id: <20230221211408.6fa4bb5868cda7d506a00c61@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

probes updates for 6.3:

- Skip negative return code check for snprintf in eprobe.

- Add recursive call test cases for kprobe unit test

- Add 'char' type to probe events to show it as the character instead of value.

- Update kselftest kprobe-event testcase to ignore '__pfx_' symbols.

- Fix kselftest to check filter on eprobe event correctly.

- Add filter on eprobe to the README file in tracefs.

- Fix optprobes to check whether there is 'under unoptimizing' optprobe when optimizing another kprobe correctly.

- Fix optprobe to check whether there is 'under unoptimizing' optprobe when fetching the original instruction correctly.

- Fix optprobe to free 'forcibly unoptimized' optprobe correctly.


Please pull the latest probes-v6.3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.3

Tag SHA1: 7aa067de8b9767c68e828eabb15b830175dc0325
Head SHA1: c96abaec78f34366b3ddf1c6be52ca5c1241e15b


Donglin Peng (1):
      tracing/probe: add a char type to show the character value of traced arguments

Masami Hiramatsu (Google) (5):
      kprobes: Fix to handle forcibly unoptimized kprobes on freeing_list
      tracing/eprobe: Fix to add filter on eprobe description in README file
      selftests/ftrace: Fix eprobe syntax test case to check filter support
      selftests/ftrace: Fix probepoint testcase to ignore __pfx_* symbols
      test_kprobes: Add recursed kprobe test case

Quanfa Fu (1):
      tracing/eprobe: no need to check for negative ret value for snprintf

Yang Jihong (2):
      x86/kprobes: Fix __recover_optprobed_insn check optimizing logic
      x86/kprobes: Fix arch_check_optimized_kprobe check within optimized_kprobe range

----
 Documentation/trace/kprobetrace.rst                |  3 +-
 arch/x86/kernel/kprobes/opt.c                      |  6 +--
 include/linux/kprobes.h                            |  2 +
 kernel/kprobes.c                                   | 27 ++++++-------
 kernel/trace/trace.c                               |  4 +-
 kernel/trace/trace_eprobe.c                        | 12 ++----
 kernel/trace/trace_probe.c                         |  2 +
 kernel/trace/trace_probe.h                         |  1 +
 lib/test_kprobes.c                                 | 39 +++++++++++++++++-
 .../test.d/dynevent/eprobes_syntax_errors.tc       |  4 +-
 .../ftrace/test.d/kprobe/kprobe_args_char.tc       | 47 ++++++++++++++++++++++
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |  2 +-
 12 files changed, 116 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
---------------------------

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
