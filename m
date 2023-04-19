Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71A6E83E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjDSVl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDSVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:41:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5467126AC;
        Wed, 19 Apr 2023 14:41:49 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id B751B21C2059;
        Wed, 19 Apr 2023 14:41:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B751B21C2059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681940508;
        bh=IXjbGEskcNTff4+aJt5LnXLwyuaiOG5Sy+TvmAmP5hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJWkt+4FpnNq6+JLhnjsXDtJlA0zm0JkaqCOonqtFKcGZIYkgg0C8SxZ5tcEjfr0L
         V4Dd419sNbn43J6DhSBZC0vHhJSwfFACAxI/OWHRHTeoixg2aE8X3Gp5SDuA4li4u5
         4FzMs6X6Ae+YS7FeVgLyDr6UUEYL9hx2eO/e203s=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing: Fix print_fields() for __dyn_loc/__rel_loc
Date:   Wed, 19 Apr 2023 14:41:40 -0700
Message-Id: <20230419214140.4158-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419214140.4158-1-beaub@linux.microsoft.com>
References: <20230419214140.4158-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 80a76994b2d8 ("tracing: Add "fields" option to show raw trace event fields")
Reported-by: Doug Cook <dcook@linux.microsoft.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
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
2.25.1

