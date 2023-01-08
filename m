Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680A66612FC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 03:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjAHCND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 21:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjAHCMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 21:12:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA7F15FF9;
        Sat,  7 Jan 2023 18:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=09HDW0zlCSZa5+hlax6tOj4H8VxYXYEiMzJJOQxFkq4=; b=28YwxD5Bh92mtmziLR7YuU0ru4
        O8FLLGaf0imqW6//4ZcHqOimOxJvqR0RDcKoU+uPpFMpER13kLDmJ3QNyJL/0mY3hJuPVyyrRfhhw
        S8Bk58rwI89jxgdh7NPTLhvaC+qp9Parb1OMktmPucVEp6SYB3Zskl7GT272O2jN2jmt1Rfy1UADw
        HArIpdkQE+hHH6YZGC/hrIJpJa8tR7IL2PeaipqeE1mgQehAtWmIY1iXBQCXjcrmhu3jxEjCZHo4e
        Zoqh0/yGRA7pnwdlpF+teU7YAMqz9EW1h0wJ7A683XCtU8cfuR01o8nT9MDDSFC5+1px4yjMmlNLc
        pngVJ60w==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pELAs-00Aq6H-P9; Sun, 08 Jan 2023 02:12:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/filter: fix kernel-doc warnings
Date:   Sat,  7 Jan 2023 18:12:38 -0800
Message-Id: <20230108021238.16398-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the 'struct' keyword for a struct's kernel-doc notation and
use the correct function parameter name to eliminate kernel-doc
warnings:

kernel/trace/trace_events_filter.c:136: warning: cannot understand function prototype: 'struct prog_entry '
kerne/trace/trace_events_filter.c:155: warning: Excess function parameter 'when_to_branch' description in 'update_preds'

Also correct some trivial punctuation problems.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
---
 kernel/trace/trace_events_filter.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
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
