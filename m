Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9B664A85F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiLLUFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiLLUFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:05:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB1178AA;
        Mon, 12 Dec 2022 12:04:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CA8DB80E02;
        Mon, 12 Dec 2022 20:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703B9C433D2;
        Mon, 12 Dec 2022 20:04:55 +0000 (UTC)
Date:   Mon, 12 Dec 2022 15:04:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Douglas Raillard <douglas.raillard@arm.com>
Subject: [PATCH v2] tracing: Remove pointer (asterisk) from cpumask_t field
Message-ID: <20221212150453.1df47ddf@gandalf.local.home>
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

To differentiate between long arrays and cpumasks, the __cpumask() field
was created. Part of the TRACE_EVENT() macros test if the type is signed
or not by using the is_signed_type() macro. The __cpumask() field used the
__dynamic_array() helper but because cpumask_t is a structure, it could
not be used in the is_signed_type() macro as that would fail to build, so
instead it passed in the pointer to cpumask_t.

Unfortunately, that creates in the format file:

  field:__data_loc cpumask_t *[] mask;    offset:36;      size:4; signed:0;

Which looks like an array of pointers to cpumask_t and not a cpumask_t
type, which is misleading to user space parsers.

Instead, create another helper called __dynamic_array_sign() that can be
used directly by the __cpumaks() field macro where it passes in an
unsigned value to avoid using the is_signed_type() and have the
__dynamic_array() macro call it by passing it the is_signed_type() on the
type.

This now produces:

  field:__data_loc cpumask_t[] mask;    offset:36;      size:4; signed:0;

Which is the correct type of the field.

Link: https://lore.kernel.org/lkml/6dda5e1d-9416-b55e-88f3-31d148bc925f@arm.com/

Fixes: 8230f27b1ccc ("tracing: Add __cpumask to denote a trace event field that is a cpumask_t")
Reported-by: Douglas Raillard <douglas.raillard@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20221212130352.606d7ce2@gandalf.local.home

 - Passed in (_type, item, len) and not (_type, _item, _len) to
   __dynamic_array_sign() from __dynamic_array(). Fixed it.

 include/trace/stages/stage4_event_fields.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
index f2990d22313c..a4e2403cf53e 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -28,11 +28,15 @@
 	.size = sizeof(_type[_len]), .align = ALIGN_STRUCTFIELD(_type),	\
 	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
 
-#undef __dynamic_array
-#define __dynamic_array(_type, _item, _len) {				\
+#undef __dynamic_array_sign
+#define __dynamic_array_sign(_type, _item, _len, _sign) {		\
 	.type = "__data_loc " #_type "[]", .name = #_item,		\
 	.size = 4, .align = 4,						\
-	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
+	.is_signed = _sign, .filter_type = FILTER_OTHER },
+
+#undef __dynamic_array
+#define __dynamic_array(_type, _item, _len)				\
+	__dynamic_array_sign(_type, _item, _len, is_signed_type(_type))
 
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
@@ -47,7 +51,7 @@
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
 #undef __cpumask
-#define __cpumask(item) __dynamic_array(cpumask_t *, item, -1)
+#define __cpumask(item) __dynamic_array_sign(cpumask_t, item, -1, 0)
 
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
-- 
2.35.1

