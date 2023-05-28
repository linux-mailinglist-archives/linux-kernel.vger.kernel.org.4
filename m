Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D957137CD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 07:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjE1F0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 01:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1F0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 01:26:47 -0400
Received: from mammoth.local.home (cpe-172-100-189-27.stny.res.rr.com [172.100.189.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E05E3DF;
        Sat, 27 May 2023 22:26:40 -0700 (PDT)
Received: by mammoth.local.home (Postfix, from userid 5657)
        id B39643009DD; Sun, 28 May 2023 01:17:53 -0400 (EDT)
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 0/5] tracing: Fix selftests softlockup issues
Date:   Sun, 28 May 2023 01:17:37 -0400
Message-Id: <20230528051742.1325503-1-rostedt@goodmis.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_PBL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Starting with v6.4-rc releases, the debugging of the kernel has slowed down
text_poke and friends so much that it is triggering the softlockup detector in
the ftrace selftests. There are two issues that I found.

1. The selftests run one after the other without a schedule.
2. text_poke_bp_batch can take up a lot of time itself without a schedule.

This addresses the first part. The second part is a x86 issue and I will be
addressing that with a separate patch.

As I'm currently in an Taiwan airport lounge with horrible internet connection,
and ssh'd to my home machine. I'm sending this patchset with hand typed git sendemail
If it goes bad, that's the reason!

Steven Rostedt (Google) (5):
  tracing: Move setting of tracing_selftest_running out of
    register_tracer()
  tracing: Have tracer selftests call cond_resched() before running
  tracing: Make tracing_selftest_running/delete nops when not used
  tracing: Only make selftest conditionals affect the global_trace
  tracing: Have function_graph selftest call cond_resched()

 kernel/trace/trace.c          | 42 +++++++++++++++++++++++++++++------
 kernel/trace/trace_selftest.c | 10 +++++++++
 2 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.39.2

