Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50F68E097
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjBGSwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjBGSvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:51:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270B317CFE;
        Tue,  7 Feb 2023 10:51:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E688B81AB7;
        Tue,  7 Feb 2023 18:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E53C433EF;
        Tue,  7 Feb 2023 18:51:50 +0000 (UTC)
Date:   Tue, 7 Feb 2023 13:51:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-ID: <20230207135147.5ce618d6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The kprobe probepoint.tc test started failing because of the added __pfx_
symbols that were added because of -fpatchable-function-entry=X,Y causing
unwinders to see them as part of the previous functions. But kprobes can
not be added on top of them. The selftest looks for tracefs_create_dir and
picks it and the previous and following functions to add at their address.
This caused it to include __pfx_tracefs_create_dir which is invalid to
attach a kprobe to and caused the test to fail.

Fixes: 9f2899fe36a62 ("objtool: Add option to generate prefix symbols")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
index 624269c8d534..e1b7506c1b11 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
@@ -21,7 +21,7 @@ set_offs() { # prev target next
 
 # We have to decode symbol addresses to get correct offsets.
 # If the offset is not an instruction boundary, it cause -EILSEQ.
-set_offs `grep -A1 -B1 ${TARGET_FUNC} /proc/kallsyms | cut -f 1 -d " " | xargs`
+set_offs `grep -v __pfx_ /proc/kallsyms | grep -A1 -B1 ${TARGET_FUNC} |  cut -f 1 -d " " | xargs`
 
 UINT_TEST=no
 # printf "%x" -1 returns (unsigned long)-1.
-- 
2.39.0

