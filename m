Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD574B5B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjGGRYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjGGRXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95CA268D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688750549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eoYdZ3j5mn2MTw1iUVYlPJSnwNWgHj3M8L9iz2kPLwU=;
        b=h2/rPVvGzM4GGOlFwV4rIr8J5lY+oOlyBndA7MkeH+CPH22Oss9CGml+2nMKWj+YyUz2Da
        35vve46yiNh7+sebE10s3KEIatNitIekuDGhJbLW9PRf898njChQv5Ik+erAnA5K9YhKtS
        DyBKM5fgn2QMPOroecL9ubwk4T8ALwQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-8Elu-Jy4N9m2zwot3temYw-1; Fri, 07 Jul 2023 13:22:25 -0400
X-MC-Unique: 8Elu-Jy4N9m2zwot3temYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44CBF83FC20;
        Fri,  7 Jul 2023 17:22:25 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDADB1454142;
        Fri,  7 Jul 2023 17:22:23 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2 7/9] tracing/filters: Optimise CPU vs cpumask filtering when the user mask is a single CPU
Date:   Fri,  7 Jul 2023 18:21:53 +0100
Message-Id: <20230707172155.70873-8-vschneid@redhat.com>
In-Reply-To: <20230707172155.70873-1-vschneid@redhat.com>
References: <20230707172155.70873-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven noted that when the user-provided cpumask contains a single CPU,
then the filtering function can use a scalar as input instead of a
full-fledged cpumask.

In this case we can directly re-use filter_pred_cpu(), we just need to
transform '&' into '==' before executing it.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 54d642fabb7f1..fd72dacc5d1b8 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1750,7 +1750,7 @@ static int parse_pred(const char *str, void *data,
 		 * then we can treat it as a scalar input.
 		 */
 		single = cpumask_weight(pred->mask) == 1;
-		if (single && field->filter_type != FILTER_CPU) {
+		if (single) {
 			pred->val = cpumask_first(pred->mask);
 			kfree(pred->mask);
 		}
@@ -1760,7 +1760,12 @@ static int parse_pred(const char *str, void *data,
 				FILTER_PRED_FN_CPUMASK_CPU :
 				FILTER_PRED_FN_CPUMASK;
 		} else if (field->filter_type == FILTER_CPU) {
-			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
+			if (single) {
+				pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
+				pred->fn_num = FILTER_PRED_FN_CPU;
+			} else {
+				pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
+			}
 		} else if (single) {
 			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
 			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
-- 
2.31.1

