Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF5866E204
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjAQPXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjAQPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:22:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B48303FB;
        Tue, 17 Jan 2023 07:22:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6F08CE157F;
        Tue, 17 Jan 2023 15:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18CAC433F0;
        Tue, 17 Jan 2023 15:22:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pHnnH-001vhh-2h;
        Tue, 17 Jan 2023 10:22:35 -0500
Message-ID: <20230117152235.698632147@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Jan 2023 10:21:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [PATCH 1/6 v2] tracing: Simplify calculating entry size using struct_size()
References: <20230117152125.268986282@goodmis.org>
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


