Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2266CF376
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjC2TqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjC2Tpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4057CA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 406BC61E1D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A377C433EF;
        Wed, 29 Mar 2023 19:45:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbjz-002RjB-03;
        Wed, 29 Mar 2023 15:45:51 -0400
Message-ID: <20230329194550.833880823@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Ross Zwisler <zwisler@google.com>
Subject: [for-next][PATCH 09/25] leaking_addresses: also skip canonical ftrace path
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Zwisler <zwisler@google.com>

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

scripts/leaking_addresses.pl only skipped this older debugfs path, so
let's add the canonical path as well.

Link: https://lkml.kernel.org/r/20230313211746.1541525-2-zwisler@kernel.org

Cc: "Tobin C. Harding" <me@tobin.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Acked-by: Tycho Andersen <tycho@tycho.pizza>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/leaking_addresses.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index 8f636a23bc3f..e695634d153d 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -61,6 +61,7 @@ my @skip_abs = (
 	'/proc/device-tree',
 	'/proc/1/syscall',
 	'/sys/firmware/devicetree',
+	'/sys/kernel/tracing/trace_pipe',
 	'/sys/kernel/debug/tracing/trace_pipe',
 	'/sys/kernel/security/apparmor/revision');
 
-- 
2.39.1
