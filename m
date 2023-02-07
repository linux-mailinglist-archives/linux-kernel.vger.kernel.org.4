Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACD168DEED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjBGRai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjBGRad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:30:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F221E9FE;
        Tue,  7 Feb 2023 09:30:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20C9960F6A;
        Tue,  7 Feb 2023 17:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A64C433D2;
        Tue,  7 Feb 2023 17:30:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPRnW-006Rw9-0V;
        Tue, 07 Feb 2023 12:30:26 -0500
Message-ID: <20230207172849.461894073@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 12:28:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH v2 0/4] tracing: Addition of tracing instances via kernel command line
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instance creation can happen with the bootconfig but there's currently
no way to create and enable instances via the normal command line.

This series fixes that.

 trace_instance=foo,sched_switch,sched_waking ftrace_boot_snapshot=foo

The above creates a "foo" instance at early start up and enables
the sched_switch and sched_waking events. Then at the end of boot up
a snapshot is taken so that user space does not overwrite the boot
up data.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20230111145636.450953217@goodmis.org/
 - Fixed document grammar (Randy Dunlap)
 - Removed extra workqueue.h include (Ross Zwisler)
 - Use sizeof(boot_instance_info) than using COMMAND_LINE_SIZE)
 - Remove unneeded @ip in kernel-doc (Ross Zwisler)
 - Make stub function for do_allocate_snapshot() for !CONFIG_TRACER_MAX_TRACE (kernel test robot)
 - Compare strstr() to NULL and not zero (kernel test robot)
 - Use sizeof(boot_snapshot_info) instead of COMMAND_LINE_SIZE (Ross Zwisler)

Steven Rostedt (Google) (4):
      tracing: Add creation of instances at boot command line
      tracing: Add enabling of events to boot instances
      tracing: Add trace_array_puts() to write into instance
      tracing: Allow boot instances to have snapshot buffers

----
 Documentation/admin-guide/bootconfig.rst        |   6 +-
 Documentation/admin-guide/kernel-parameters.txt |  29 +++++
 include/linux/bootconfig.h                      |   2 +-
 include/linux/trace.h                           |  12 ++
 init/Kconfig                                    |  13 --
 init/main.c                                     |   2 +-
 kernel/trace/trace.c                            | 160 +++++++++++++++++++++---
 kernel/trace/trace.h                            |   2 +
 kernel/trace/trace_events.c                     |   9 +-
 9 files changed, 193 insertions(+), 42 deletions(-)
