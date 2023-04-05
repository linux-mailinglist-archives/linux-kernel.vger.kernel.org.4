Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CB66D725D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbjDECXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjDECXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:23:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE4B1FE3;
        Tue,  4 Apr 2023 19:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75D976365A;
        Wed,  5 Apr 2023 02:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AFAC433D2;
        Wed,  5 Apr 2023 02:23:42 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pjsoH-000hUd-27;
        Tue, 04 Apr 2023 22:23:41 -0400
Message-ID: <20230405022113.860447811@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 04 Apr 2023 22:21:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH 0/2 v2] tracing: Fix ftrace_boot_snapshot command line
X-Spam-Status: No, score=-2.1 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging some boot up code, I found that the snapshots were
constantly triggering at boot up, even though there was no boot
snapshot specified. Looking into it, I found there were too bugs.

1) It would trigger a snapshot on any instance if one was created
   from the kernel command line.

2) The error handling would only affect the top level instance.
   So the fact that a snapshot was done on a instance that didn't
   allocate a buffer triggered a warning written into the top level
   buffer, and worse yet, disabled the top level buffer.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20230404230011.757302390@goodmis.org/

 - My tests failed due to tr->allocated_snapshot only being a field
   when CONFIG_TRACE_MAX_TRACE is defined. And it doesn't make sense
   doing any of that logic if it is not, as snapshots depend on that config.

This addresses both of the above bugs.

Steven Rostedt (Google) (2):
      tracing: Have tracing_snapshot_instance_cond() write errors to the appropriate instance
      tracing: Fix ftrace_boot_snapshot command line logic

----
 kernel/trace/trace.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)
