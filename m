Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0584966D568
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbjAQElT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjAQElH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:41:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169F53ABE;
        Mon, 16 Jan 2023 20:41:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0D78611AF;
        Tue, 17 Jan 2023 04:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2CDC433EF;
        Tue, 17 Jan 2023 04:41:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pHdmO-001rrf-32;
        Mon, 16 Jan 2023 23:41:00 -0500
Message-ID: <20230117044100.805996885@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 16 Jan 2023 23:40:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH 1/5] tracing: Simplify calculating entry size using struct_size()
References: <20230117044010.838685230@goodmis.org>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When tracing a dynamic string field for a synthetic event, the offset
calculation for where to write the next event can use struct_size() to
find what the current size of the structure is.

This simplifies the code and makes it less error prone.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 67592eed0be8..9f79cd689b79 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -416,8 +416,7 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	if (is_dynamic) {
 		u32 data_offset;
 
-		data_offset = offsetof(typeof(*entry), fields);
-		data_offset += event->n_u64 * sizeof(u64);
+		data_offset = struct_size(entry, fields, event->n_u64);
 		data_offset += data_size;
 
 		len = kern_fetch_store_strlen((unsigned long)str_val);
-- 
2.39.0


