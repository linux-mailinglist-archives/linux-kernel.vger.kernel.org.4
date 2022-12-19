Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC21D651216
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiLSSfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiLSSe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:34:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AF11176;
        Mon, 19 Dec 2022 10:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58697B80F62;
        Mon, 19 Dec 2022 18:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C30C433D2;
        Mon, 19 Dec 2022 18:32:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p7Kvt-0005SZ-2r;
        Mon, 19 Dec 2022 13:32:13 -0500
Message-ID: <20221219183106.518341498@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Dec 2022 13:31:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [PATCH 0/2] tracing: Add a way to filter function addresses to function names
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's been several times where an event records a function address in
its field and I needed to filter on that address for a specific function
name. It required looking up the function in kallsyms, finding its size,
and doing a compare of "field >= function_start && field < function_end".

But this would change from boot to boot and is unreliable in scripts.
Also, it is useful to have this at boot up, where the addresses will not
be known. For example, on the boot command line:

  trace_trigger="initcall_finish.traceoff if func.function == acpi_init"

To implement this, add a ".function" prefix, that will check that the
field is of size long, and the only operations allowed (so far) are "=="
and "!=".

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20221214125209.09d736dd@gandalf.local.home/

 - Fix commit log "initcall_finish.function" to "func.function" (Ross Zwisler)

 - Fixed processing of address (Ross Zwisler)

 - Added selftest (Masami Hiramatsu)

 - Just use "trigger" instead of "strsep(&trigger, "")" (Zheng Yejian)

Steven Rostedt (Google) (2):
      tracing: Add a way to filter function addresses to function names
      tracing/selftests: Add test for event filtering on function name

----
 Documentation/trace/events.rst                     | 12 +++
 kernel/trace/trace_events.c                        |  2 +-
 kernel/trace/trace_events_filter.c                 | 93 +++++++++++++++++++++-
 .../ftrace/test.d/filter/event-filter-function.tc  | 58 ++++++++++++++
 4 files changed, 163 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
