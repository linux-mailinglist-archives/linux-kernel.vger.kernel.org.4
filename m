Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CC55ED0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 01:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiI0XRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 19:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiI0XRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:17:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFC91129E7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 353C8B81E49
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7848C433D7;
        Tue, 27 Sep 2022 23:17:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odJqJ-00HDd9-1s;
        Tue, 27 Sep 2022 19:18:23 -0400
Message-ID: <20220927231523.298295015@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 19:15:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] tracing: Handle ring buffer waiters
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on libtracefs functions that allow for reading the
raw trace files, I found that my test programs would get stuck
waiting on the buffer when they should stop. Signals work fine, but
closing the file would not break them out of the wait.

I found this confusing and the reading functions would lose a lot
of data. This fixes the wake up issue, which should have always been
the case. I also added an ioctl() to the trace_pipe_raw that will
wake up all waiters on any ioctl.

Steven Rostedt (Google) (5):
      ring-buffer: Have the shortest_full queue be the shortest not longest
      ring-buffer: Check pending waiters when doing wake ups as well
      ring-buffer: Add ring_buffer_wake_waiters()
      tracing: Wake up ring buffer waiters on closing of the file
      tracing: Add ioctl() to force ring buffer waiters to wake up

----
 include/linux/ring_buffer.h  |  2 +-
 include/linux/trace_events.h |  1 +
 kernel/trace/ring_buffer.c   | 39 +++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.c         | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 3 deletions(-)
