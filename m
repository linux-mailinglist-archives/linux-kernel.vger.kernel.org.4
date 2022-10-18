Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DFD602B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiJRMDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiJRMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:02:46 -0400
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF4BBEAED
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:01:58 -0700 (PDT)
Received: by mail-pg1-f193.google.com with SMTP id 128so13122578pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ofPP8DVCUsopTN5llp+jQi2rMP9BnaBU/6vKHjTUOE=;
        b=ILaRob3h/lRFrdVMxChm74zl62XUStfHyuE3OUrqaHBlJriOphaMzyVV7l13w5Ny1j
         X3BzeqiptJrtycNk9tIClwvA84w6cBIdeTm9kMZBcjDi3T6Nv6rBX4y6L2+Ncl0D1idW
         Qk1NHYj0BcAH6Mbqxw9AruRfWbra2GYbpNmsFcqnblsFkvOOXfgmzNmYExV8WvKvocTt
         YiZqYM4Uqdi/zDbFmep+1lO6RWDqB067zG2ZQLxb7CIcSd83/d1f8fneGR4uc6TzifAj
         wmakD2EhOfsi4QFZEl+MYv04CMYc++BM+kNrLl7ZOuB2/BcOfFsX+m04gIfUQg1W/n7/
         VHvg==
X-Gm-Message-State: ACrzQf34wbwwZi6FP90fgv7BP3i/GDaaz1JjlZD4e64N5CGmfKAMJIEz
        9I9zHmoH29ck1mDezQmOOg==
X-Google-Smtp-Source: AMsMyM5kJPnzmyb4W+Q7DJhFvhGRqae42+A/afqISrvgRuSFl63B7nGZo+YcDhdmfkWs/+bdj69rww==
X-Received: by 2002:a63:450c:0:b0:443:94a1:3703 with SMTP id s12-20020a63450c000000b0044394a13703mr2272819pga.565.1666094517932;
        Tue, 18 Oct 2022 05:01:57 -0700 (PDT)
Received: from localhost.localdomain (ns1002484.ip-51-81-243.us. [51.81.243.185])
        by smtp.gmail.com with ESMTPSA id v18-20020a634812000000b0043b565cb57csm7893851pga.73.2022.10.18.05.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:01:57 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH 2/5] ring-buffer: Remove absolute timestamp from add_timestamp logic
Date:   Tue, 18 Oct 2022 20:00:53 +0800
Message-Id: <20221018120056.1321426-3-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018120056.1321426-1-sunliming@kylinos.cn>
References: <20221018120056.1321426-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove absolute timestamp from add_timestamp logic.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/ring_buffer.c | 49 +++++++++++++-------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 199759c73519..ab0aef15f82a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -436,14 +436,12 @@ struct rb_event_info {
  * Used for the add_timestamp
  *  NONE
  *  EXTEND - wants a time extend
- *  ABSOLUTE - the buffer requests all events to have absolute time stamps
  *  FORCE - force a full time stamp.
  */
 enum {
 	RB_ADD_STAMP_NONE		= 0,
 	RB_ADD_STAMP_EXTEND		= BIT(1),
-	RB_ADD_STAMP_ABSOLUTE		= BIT(2),
-	RB_ADD_STAMP_FORCE		= BIT(3)
+	RB_ADD_STAMP_FORCE		= BIT(2)
 };
 /*
  * Used for which event context the event is in.
@@ -2832,8 +2830,7 @@ static void rb_add_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 				      u64 *delta,
 				      unsigned int *length)
 {
-	bool abs = info->add_timestamp &
-		(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE);
+	bool abs = info->add_timestamp & RB_ADD_STAMP_FORCE;
 
 	if (unlikely(info->delta > (1ULL << 59))) {
 		/*
@@ -3435,8 +3432,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 	if (tail == CHECK_FULL_PAGE) {
 		full = true;
 		tail = local_read(&bpage->commit);
-	} else if (info->add_timestamp &
-		   (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE)) {
+	} else if (info->add_timestamp & RB_ADD_STAMP_FORCE) {
 		/* Ignore events with absolute time stamps */
 		return;
 	}
@@ -3535,23 +3531,19 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	barrier();
 	info->ts = rb_time_stamp(cpu_buffer->buffer);
 
-	if ((info->add_timestamp & RB_ADD_STAMP_ABSOLUTE)) {
-		info->delta = info->ts;
+	/*
+	 * If interrupting an event time update, we may need an
+	 * absolute timestamp.
+	 * Don't bother if this is the start of a new page (w == 0).
+	 */
+	if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
+		info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
+		info->length += RB_LEN_TIME_EXTEND;
 	} else {
-		/*
-		 * If interrupting an event time update, we may need an
-		 * absolute timestamp.
-		 * Don't bother if this is the start of a new page (w == 0).
-		 */
-		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
-			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
+		info->delta = info->ts - info->after;
+		if (unlikely(test_time_stamp(info->delta))) {
+			info->add_timestamp |= RB_ADD_STAMP_EXTEND;
 			info->length += RB_LEN_TIME_EXTEND;
-		} else {
-			info->delta = info->ts - info->after;
-			if (unlikely(test_time_stamp(info->delta))) {
-				info->add_timestamp |= RB_ADD_STAMP_EXTEND;
-				info->length += RB_LEN_TIME_EXTEND;
-			}
 		}
 	}
 
@@ -3586,8 +3578,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		barrier();
  /*E*/		s_ok = rb_time_read(&cpu_buffer->before_stamp, &save_before);
 		RB_WARN_ON(cpu_buffer, !s_ok);
-		if (likely(!(info->add_timestamp &
-			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
+		if (likely(!(info->add_timestamp & RB_ADD_STAMP_FORCE)))
 			/* This did not interrupt any time update */
 			info->delta = info->ts - info->after;
 		else
@@ -3644,8 +3635,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	 * If this is the first commit on the page, then it has the same
 	 * timestamp as the page itself.
 	 */
-	if (unlikely(!tail && !(info->add_timestamp &
-				(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
+	if (unlikely(!tail && !(info->add_timestamp & RB_ADD_STAMP_FORCE)))
 		info->delta = 0;
 
 	/* We reserved something on the buffer */
@@ -3698,12 +3688,7 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 
 	info.length = rb_calculate_event_length(length);
 
-	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
-		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
-		info.length += RB_LEN_TIME_EXTEND;
-	} else {
-		add_ts_default = RB_ADD_STAMP_NONE;
-	}
+	add_ts_default = RB_ADD_STAMP_NONE;
 
  again:
 	info.add_timestamp = add_ts_default;
-- 
2.25.1

