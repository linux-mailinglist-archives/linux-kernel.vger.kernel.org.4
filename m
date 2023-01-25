Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9F467B6C9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbjAYQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbjAYQUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:20:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C016AD7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E0CAB81ACE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F51AC433AE;
        Wed, 25 Jan 2023 16:20:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKiVP-004MuB-1M;
        Wed, 25 Jan 2023 11:20:11 -0500
Message-ID: <20230125162011.241146323@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Jan 2023 11:18:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [for-linus][PATCH 08/11] tracing/filter: fix kernel-doc warnings
References: <20230125161824.332648375@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Use the 'struct' keyword for a struct's kernel-doc notation and
use the correct function parameter name to eliminate kernel-doc
warnings:

kernel/trace/trace_events_filter.c:136: warning: cannot understand function prototype: 'struct prog_entry '
kerne/trace/trace_events_filter.c:155: warning: Excess function parameter 'when_to_branch' description in 'update_preds'

Also correct some trivial punctuation problems.

Link: https://lkml.kernel.org/r/20230108021238.16398-1-rdunlap@infradead.org

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 96acc2b71ac7..e095c3b3a50d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -128,7 +128,7 @@ static bool is_not(const char *str)
 }
 
 /**
- * prog_entry - a singe entry in the filter program
+ * struct prog_entry - a singe entry in the filter program
  * @target:	     Index to jump to on a branch (actually one minus the index)
  * @when_to_branch:  The value of the result of the predicate to do a branch
  * @pred:	     The predicate to execute.
@@ -140,16 +140,16 @@ struct prog_entry {
 };
 
 /**
- * update_preds- assign a program entry a label target
+ * update_preds - assign a program entry a label target
  * @prog: The program array
  * @N: The index of the current entry in @prog
- * @when_to_branch: What to assign a program entry for its branch condition
+ * @invert: What to assign a program entry for its branch condition
  *
  * The program entry at @N has a target that points to the index of a program
  * entry that can have its target and when_to_branch fields updated.
  * Update the current program entry denoted by index @N target field to be
  * that of the updated entry. This will denote the entry to update if
- * we are processing an "||" after an "&&"
+ * we are processing an "||" after an "&&".
  */
 static void update_preds(struct prog_entry *prog, int N, int invert)
 {
-- 
2.39.0
