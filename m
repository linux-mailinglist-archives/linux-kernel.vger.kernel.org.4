Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A63464CBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbiLNOCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbiLNOCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:02:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC323275F0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:02:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E763B818C8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AD0C433A0;
        Wed, 14 Dec 2022 14:02:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p5SKn-000guJ-0Y;
        Wed, 14 Dec 2022 09:02:09 -0500
Message-ID: <20221214140209.038133575@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Dec 2022 09:01:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Douglas Raillard <douglas.raillard@arm.com>
Subject: [for-next][PATCH 4/8] tracing: Remove pointer (asterisk) and brackets from cpumask_t field
References: <20221214140133.608431204@goodmis.org>
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

Douglas Raillard pointed out that the "[]" are also misleading, as
cpumask_t is not an array.

Since cpumask() hasn't been created yet, and the parsers currently fail on
it (but will still produce the raw output), make it be:

  field:__data_loc cpumask_t mask;    offset:36;      size:4; signed:0;

Which is the correct type of the field.

Then the parsers can be updated to handle this.

Link: https://lore.kernel.org/lkml/6dda5e1d-9416-b55e-88f3-31d148bc925f@arm.com/
Link: https://lore.kernel.org/linux-trace-kernel/20221212193814.0e3f1e43@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 8230f27b1ccc ("tracing: Add __cpumask to denote a trace event field that is a cpumask_t")
Reported-by: Douglas Raillard <douglas.raillard@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage4_event_fields.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
index f2990d22313c..affd541fd25e 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -47,7 +47,10 @@
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
 #undef __cpumask
-#define __cpumask(item) __dynamic_array(cpumask_t *, item, -1)
+#define __cpumask(item) {						\
+	.type = "__data_loc cpumask_t", .name = #item,			\
+	.size = 4, .align = 4,						\
+	.is_signed = 0, .filter_type = FILTER_OTHER },
 
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
@@ -68,7 +71,10 @@
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
 #undef __rel_cpumask
-#define __rel_cpumask(item) __rel_dynamic_array(cpumask_t *, item, -1)
+#define __rel_cpumask(item) {						\
+	.type = "__rel_loc cpumask_t", .name = #item,			\
+	.size = 4, .align = 4,						\
+	.is_signed = 0, .filter_type = FILTER_OTHER },
 
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
-- 
2.35.1


