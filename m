Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF6F6D5367
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjDCVWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjDCVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9E93A97
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C54086264C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 21:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E31C433D2;
        Mon,  3 Apr 2023 21:22:43 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pjRdR-000FOE-2y;
        Mon, 03 Apr 2023 17:22:41 -0400
Message-ID: <20230403212125.244064799@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 03 Apr 2023 17:21:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        John Keeping <john@metanate.com>,
        Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-linus][PATCH 0/6] tracing: Fixes for 6.3
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing fixes for 6.3:

- Fix timerlat notification, as it was not triggering the
  notify to users when a new max latency was hit.

- Do not trigger max latency if the tracing is off.
  When tracing is off, the ring buffer is not updated, it
  does not make sense to notify when there's a new max latency
  detected by the tracer, as why that latency happened is not available.
  The tracing logic still runs when the ring buffer is disabled, but
  it should not be triggering notifications.

- Fix race on freeing the synthetic event "last_cmd" variable by
  adding a mutex around it.

- Fix race between reader and writer of the ring buffer by adding
  memory barriers. When the writer is still on the reader page
  it must have its content visible on the buffer before it moves
  the commit index that the reader uses to know how much content is
  on the page.

- Make get_lock_parent_ip() always inlined, as it uses _THIS_IP_
  and _RET_IP_, which gets broken if it is not inlined.

- Make __field(int, arr[5]) in a TRACE_EVENT() macro fail to build.
  The field formats of trace events are calculated by using sizeof(type)
  and other means by what is passed into the structure macros like
  __field(). The __field() macro is only meant for atom types like
  int, long, short, pointer, etc. It is not meant for arrays. But
  the code will currently compile with arrays, but then the format
  produced will be inaccurate, and user space parsing tools will break.
  Two bugs have already been fixed, now add code that will make the
  kernel fail to build if another trace event includes this buggy
  field format.


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: f82e7ca019dfad3b006fd3b772f7ac569672db55


Daniel Bristot de Oliveira (2):
      tracing/timerlat: Notify new max thread latency
      tracing/osnoise: Fix notify new tracing_max_latency

John Keeping (1):
      ftrace: Mark get_lock_parent_ip() __always_inline

Steven Rostedt (Google) (1):
      tracing: Error if a trace event has an array for a __field()

Tze-nan Wu (1):
      tracing/synthetic: Fix races on freeing last_cmd

Zheng Yejian (1):
      ring-buffer: Fix race while reader and writer are on the same page

----
 include/linux/ftrace.h                    |  2 +-
 include/trace/stages/stage5_get_offsets.h | 21 +++++++++++++++++----
 kernel/trace/ring_buffer.c                | 13 ++++++++++++-
 kernel/trace/trace_events_synth.c         | 19 +++++++++++++++----
 kernel/trace/trace_osnoise.c              |  4 +++-
 5 files changed, 48 insertions(+), 11 deletions(-)
