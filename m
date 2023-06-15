Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FED3731A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbjFONfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344574AbjFONfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:35:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A38C2960
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F5E4637EE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30F5C43395;
        Thu, 15 Jun 2023 13:34:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9n79-000Tmx-28;
        Thu, 15 Jun 2023 09:34:15 -0400
Message-ID: <20230615133415.478015212@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 09:05:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sunliming <sunliming@kylinos.cn>
Subject: [for-linus][PATCH 04/15] tracing: Modify print_fields() for fields output order
References: <20230615130531.200384328@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sunliming <sunliming@kylinos.cn>

Now the print_fields() print trace event fields in reverse order. Modify
it to the positive sequence.

Example outputs for a user event:
	test0 u32 count1; u32 count2

Output before:
	example-2547    [000] .....   325.666387: test0: count2=0x2 (2) count1=0x1 (1)

Output after:
	example-2742    [002] .....   429.769370: test0: count1=0x1 (1) count2=0x2 (2)

Link: https://lore.kernel.org/linux-trace-kernel/20230525085232.5096-1-sunliming@kylinos.cn

Fixes: 80a76994b2d88 ("tracing: Add "fields" option to show raw trace event fields")
Signed-off-by: sunliming <sunliming@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 15f05faaae44..1e33f367783e 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -847,7 +847,7 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 	int ret;
 	void *pos;
 
-	list_for_each_entry(field, head, link) {
+	list_for_each_entry_reverse(field, head, link) {
 		trace_seq_printf(&iter->seq, " %s=", field->name);
 		if (field->offset + field->size > iter->ent_size) {
 			trace_seq_puts(&iter->seq, "<OVERFLOW>");
-- 
2.39.2
