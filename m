Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D560E6EF91F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbjDZRRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDZRRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7932701
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB62861B36
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5309FC433EF;
        Wed, 26 Apr 2023 17:17:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1prim5-005KX3-0a;
        Wed, 26 Apr 2023 13:17:49 -0400
Message-ID: <20230426171703.202523909@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 26 Apr 2023 13:17:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/11] tracing: Final fixes and minor updates before sending pull request
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: adace4408252cc1c9913958d71e81a688af90a30


Beau Belgrave (6):
      tracing/user_events: Set event filter_type from type
      tracing: Fix print_fields() for __dyn_loc/__rel_loc
      tracing/user_events: Ensure write index cannot be negative
      tracing/user_events: Ensure bit is cleared on unregister
      tracing/user_events: Prevent same address and bit per process
      tracing/user_events: Limit max fault-in attempts

Hao Zeng (1):
      recordmcount: Fix memory leaks in the uwrite function

Ken Lin (1):
      tracing: Add missing spaces in trace_print_hex_seq()

Sergey Senozhatsky (1):
      seq_buf: Add seq_buf_do_printk() helper

Tze-nan Wu (1):
      ring-buffer: Ensure proper resetting of atomic variables in ring_buffer_reset_online_cpus

Zheng Yejian (1):
      ring-buffer: Clearly check null ptr returned by rb_set_head_page()

----
 include/linux/seq_buf.h                           |   2 +
 kernel/trace/ring_buffer.c                        |  21 +++-
 kernel/trace/trace_events_user.c                  | 126 +++++++++++++++++++---
 kernel/trace/trace_output.c                       |  15 ++-
 lib/seq_buf.c                                     |  32 ++++++
 scripts/recordmcount.c                            |   6 +-
 tools/testing/selftests/user_events/abi_test.c    |   9 +-
 tools/testing/selftests/user_events/ftrace_test.c |  14 ++-
 8 files changed, 198 insertions(+), 27 deletions(-)
