Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778DC63162B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiKTUHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKTUHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:07:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AEF17401
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:07:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0898660D27
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57953C433D6;
        Sun, 20 Nov 2022 20:07:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1owqbF-00Di3H-0z;
        Sun, 20 Nov 2022 15:07:33 -0500
Message-ID: <20221120200700.725968899@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 20 Nov 2022 15:07:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/13] tracing: Fixes for 6.1
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 94eedf3dded5fb472ce97bfaf3ac1c6c29c35d26


Aashish Sharma (1):
      tracing: Fix warning on variable 'struct trace_array'

Daniil Tatianin (1):
      ring_buffer: Do not deactivate non-existant pages

Qiujun Huang (1):
      tracing: Remove unused __bad_type_size() method

Shang XiaoJing (2):
      tracing: Fix memory leak in test_gen_synth_cmd() and test_empty_synth_event()
      tracing: Fix wild-memory-access in register_synth_event()

Steven Rostedt (Google) (3):
      tracing/ring-buffer: Have polling block on watermark
      ring-buffer: Include dropped pages in counting dirty patches
      tracing: Fix race where eprobes can be called before the event

Wang Wensheng (2):
      ftrace: Fix the possible incorrect kernel message
      ftrace: Optimize the allocation for mcount entries

Wang Yufen (1):
      tracing: Fix memory leak in tracing_read_pipe()

Xiu Jianfeng (1):
      ftrace: Fix null pointer dereference in ftrace_add_mod()

Zheng Yejian (1):
      tracing: Fix potential null-pointer-access of entry in list 'tr->err_log'

----
 include/linux/ring_buffer.h         |  2 +-
 include/linux/trace.h               |  4 +--
 kernel/trace/ftrace.c               |  5 +--
 kernel/trace/ring_buffer.c          | 71 ++++++++++++++++++++++++++-----------
 kernel/trace/synth_event_gen_test.c | 16 ++++-----
 kernel/trace/trace.c                | 12 ++++---
 kernel/trace/trace_eprobe.c         |  3 ++
 kernel/trace/trace_events_synth.c   |  5 ++-
 kernel/trace/trace_syscalls.c       |  2 --
 9 files changed, 74 insertions(+), 46 deletions(-)
