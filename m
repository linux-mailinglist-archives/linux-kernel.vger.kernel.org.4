Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0632F5F010C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiI2Wzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiI2WzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:55:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3ACCBAD4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 15:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3D60B8250F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECBEC433D6;
        Thu, 29 Sep 2022 22:55:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oe2SI-000ckf-0i;
        Thu, 29 Sep 2022 18:56:34 -0400
Message-ID: <20220929225542.784716766@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 29 Sep 2022 18:55:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/15] tracing: More updates for 6.1
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 933678b6183bbe7afa332e70132065db3305ee44


Beau Belgrave (6):
      tracing/user_events: Use NULL for strstr checks
      tracing/user_events: Use WRITE instead of READ for io vector import
      tracing/user_events: Ensure user provided strings are safely formatted
      tracing/user_events: Use refcount instead of atomic for ref tracking
      tracing/user_events: Use bits vs bytes for enabled status page data
      tracing/user_events: Update ABI documentation to align to bits vs bytes

Colin Ian King (1):
      tracing: Fix spelling mistake "preapre" -> "prepare"

Song Liu (1):
      ftrace: Fix recursive locking direct_mutex in ftrace_modify_direct_caller

Steven Rostedt (Google) (7):
      ring-buffer: Allow splice to read previous partially read pages
      ring-buffer: Have the shortest_full queue be the shortest not longest
      ring-buffer: Check pending waiters when doing wake ups as well
      ring-buffer: Add ring_buffer_wake_waiters()
      tracing: Wake up ring buffer waiters on closing of the file
      tracing: Add ioctl() to force ring buffer waiters to wake up
      tracing: Wake up waiters when tracing is disabled

----
 Documentation/trace/user_events.rst               |  86 +++++---
 include/linux/ring_buffer.h                       |   2 +-
 include/linux/trace_events.h                      |   1 +
 include/linux/user_events.h                       |  15 +-
 kernel/trace/ftrace.c                             |   6 +-
 kernel/trace/ring_buffer.c                        |  54 ++++-
 kernel/trace/trace.c                              |  45 ++++-
 kernel/trace/trace_events_user.c                  | 228 +++++++++++++++-------
 samples/user_events/example.c                     |  25 ++-
 tools/testing/selftests/user_events/ftrace_test.c |  47 ++++-
 tools/testing/selftests/user_events/perf_test.c   |  11 +-
 11 files changed, 383 insertions(+), 137 deletions(-)
