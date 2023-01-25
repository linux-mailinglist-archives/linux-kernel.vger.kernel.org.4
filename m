Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5156567B6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjAYQUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbjAYQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:20:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CDE561AB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 788A1B81ACA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009ADC433D2;
        Wed, 25 Jan 2023 16:20:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKiVN-004MpN-2W;
        Wed, 25 Jan 2023 11:20:09 -0500
Message-ID: <20230125161824.332648375@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Jan 2023 11:18:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuang Wang <nashuiliang@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Natalia Petrova <n.petrova@fintech.ru>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [for-linus][PATCH 00/11] tracing: Updates for 6.2
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing updates for 6.2:

- Fix filter memory leak by calling ftrace_free_filter()

- Initialize trace_printk() earlier so that ftrace_dump_on_oops shows data
  on early crashs.

- Update the outdated instructions in scripts/tracing/ftrace-bisect.sh

- Add lockdep_is_held() to fix lockdep warning

- Add allocation failure check in create_hist_field()

- Don't initalize pointer that gets set right away in enabled_monitors_write()

- Update MAINTAINER entries

- Fix help messages in Kconfigs

- Fix kernel-doc header for update_preds()


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/urgent

Head SHA1: 78020233418518faa72fba11f40e1d53b9e88a2e


Chuang Wang (1):
      tracing/osnoise: Use built-in RCU list checking

Colin Ian King (1):
      rv: remove redundant initialization of pointer ptr

Mark Rutland (2):
      ftrace: Export ftrace_free_filter() to modules
      ftrace: Maintain samples/ftrace

Masami Hiramatsu (Google) (1):
      bootconfig: Update MAINTAINERS file to add tree and mailing list

Natalia Petrova (1):
      trace_events_hist: add check for return value of 'create_hist_field'

Randy Dunlap (3):
      tracing: Kconfig: Fix spelling/grammar/punctuation
      lib: Kconfig: fix spellos
      tracing/filter: fix kernel-doc warnings

Steven Rostedt (Google) (2):
      tracing: Make sure trace_printk() can output as soon as it can be used
      ftrace/scripts: Update the instructions for ftrace-bisect.sh

----
 MAINTAINERS                                 |  5 +++++
 kernel/trace/Kconfig                        |  8 +++----
 kernel/trace/ftrace.c                       | 23 ++++++++++++++++++-
 kernel/trace/rv/rv.c                        |  2 +-
 kernel/trace/trace.c                        |  2 ++
 kernel/trace/trace.h                        |  1 +
 kernel/trace/trace_events_filter.c          |  8 +++----
 kernel/trace/trace_events_hist.c            |  2 ++
 kernel/trace/trace_osnoise.c                |  5 ++---
 kernel/trace/trace_output.c                 |  3 +--
 lib/Kconfig.debug                           |  2 +-
 lib/Kconfig.kcsan                           |  2 +-
 samples/ftrace/ftrace-direct-multi-modify.c |  1 +
 samples/ftrace/ftrace-direct-multi.c        |  1 +
 scripts/tracing/ftrace-bisect.sh            | 34 ++++++++++++++++++++++-------
 15 files changed, 74 insertions(+), 25 deletions(-)
