Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D0964ED13
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiLPOnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiLPOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:42:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95598566E7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 06:42:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA1062139
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 14:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D7EC433D2;
        Fri, 16 Dec 2022 14:42:55 +0000 (UTC)
Date:   Fri, 16 Dec 2022 09:42:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Hua <hucool.lihua@huawei.com>,
        Li Huafei <lihuafei1@huawei.com>,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [GIT PULL] tracing probes: Updates for 6.2
Message-ID: <20221216094254.7876461d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

As Masami is still working on getting his gpg key working with signed tags
and such, he asked me to send his pull request on his behalf until he gets
that straighten out.

Trace probes updates for 6.2:

- New "symstr" type for dynamic events that writes the name of the
  function+offset into the ring buffer and not just the address

- Prevent kernel symbol processing on addresses in user space probes
  (uprobes).

- And minor fixes and clean ups


Please pull the latest trace-probes-v6.2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-probes-v6.2

Tag SHA1: ce1e1e9588758069e9b19ce97941133aa826699c
Head SHA1: d4505aa6afae17a20c2f3ccfbfb7a07881b7ae02


Li Hua (1):
      test_kprobes: Fix implicit declaration error of test_kprobes

Li Huafei (1):
      kprobes: Fix check for probe enabled in kill_kprobe()

Masami Hiramatsu (Google) (2):
      tracing/probes: Add symstr type for dynamic events
      tracing/probes: Reject symbol/symstr type for uprobe

Steven Rostedt (Google) (1):
      tracing: Fix race where eprobes can be called before the event

wuqiang (1):
      kprobes: kretprobe events missing on 2-core KVM guest

----
 Documentation/trace/kprobes.rst                    |  3 +-
 Documentation/trace/kprobetrace.rst                |  8 ++-
 kernel/kprobes.c                                   | 24 ++++----
 kernel/trace/trace.c                               |  2 +-
 kernel/trace/trace_eprobe.c                        |  3 +
 kernel/trace/trace_probe.c                         | 65 ++++++++++++++--------
 kernel/trace/trace_probe.h                         | 19 +++++--
 kernel/trace/trace_probe_tmpl.h                    | 47 +++++++++++++++-
 kernel/trace/trace_uprobe.c                        |  3 +-
 lib/Kconfig.debug                                  |  1 +
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |  5 ++
 11 files changed, 128 insertions(+), 52 deletions(-)
---------------------------
