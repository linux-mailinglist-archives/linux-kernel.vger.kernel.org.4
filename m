Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04646EF925
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjDZRSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjDZRRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D4659C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 561556307A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93DDC433A0;
        Wed, 26 Apr 2023 17:17:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1prim5-005KYl-2a;
        Wed, 26 Apr 2023 13:17:49 -0400
Message-ID: <20230426171749.616376240@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 26 Apr 2023 13:17:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Cook <dcook@linux.microsoft.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 03/11] tracing: Fix print_fields() for __dyn_loc/__rel_loc
References: <20230426171703.202523909@goodmis.org>
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

From: Beau Belgrave <beaub@linux.microsoft.com>

Both print_fields() and print_array() do not handle if dynamic data ends
at the last byte of the payload for both __dyn_loc and __rel_loc field
types. For __rel_loc, the offset was off by 4 bytes, leading to
incorrect strings and data being printed out. In print_array() the
buffer pos was missed from being advanced, which results in the first
payload byte being used as the offset base instead of the field offset.

Advance __rel_loc offset by 4 to ensure correct offset and advance pos
to the field offset to ensure correct data is displayed when printing
arrays. Change >= to > when checking if data is in-bounds, since it's
valid for dynamic data to include the last byte of the payload.

Example outputs for event format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:__rel_loc char text[];  offset:8;      size:4; signed:1;

Output before:
tp_rel_loc: text=<OVERFLOW>

Output after:
tp_rel_loc: text=Test

Link: https://lkml.kernel.org/r/20230419214140.4158-3-beaub@linux.microsoft.com

Fixes: 80a76994b2d8 ("tracing: Add "fields" option to show raw trace event fields")
Reported-by: Doug Cook <dcook@linux.microsoft.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 780c6971c944..952cc8aa8e59 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -819,13 +819,15 @@ static void print_array(struct trace_iterator *iter, void *pos,
 	len = *(int *)pos >> 16;
 
 	if (field)
-		offset += field->offset;
+		offset += field->offset + sizeof(int);
 
-	if (offset + len >= iter->ent_size) {
+	if (offset + len > iter->ent_size) {
 		trace_seq_puts(&iter->seq, "<OVERFLOW>");
 		return;
 	}
 
+	pos = (void *)iter->ent + offset;
+
 	for (i = 0; i < len; i++, pos++) {
 		if (i)
 			trace_seq_putc(&iter->seq, ',');
@@ -861,9 +863,9 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 			len = *(int *)pos >> 16;
 
 			if (field->filter_type == FILTER_RDYN_STRING)
-				offset += field->offset;
+				offset += field->offset + sizeof(int);
 
-			if (offset + len >= iter->ent_size) {
+			if (offset + len > iter->ent_size) {
 				trace_seq_puts(&iter->seq, "<OVERFLOW>");
 				break;
 			}
-- 
2.39.2
