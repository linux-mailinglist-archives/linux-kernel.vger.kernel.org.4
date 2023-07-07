Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2AE74B5B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjGGRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjGGRXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E3C2686
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688750546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ru1xpHoly8RVJpDGIBIPQWc2v6Ebq5LepRuPaIIUDyE=;
        b=D/GcFg/kYCyIDD0ZZSaBIi8aab9pYhVcn4F8qTNq65v94KCbgNEv2vtb9vXghFlR292TaW
        q7yhOKbeQcCFW+mF6DoZAJ2qGyNPzRQLBG60oHABZkEtq3+iLahLCuoWsQNxfvADYIgh8K
        SGCbbbVLvCMpTn52RRa6SgvxQ2ndX/c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-MItPMPKePTeia_LL4MNj8g-1; Fri, 07 Jul 2023 13:22:21 -0400
X-MC-Unique: MItPMPKePTeia_LL4MNj8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C4A8185A794;
        Fri,  7 Jul 2023 17:22:20 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D9611454142;
        Fri,  7 Jul 2023 17:22:19 +0000 (UTC)
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
Subject: [PATCH v2 4/9] tracing/filters: Enable filtering the CPU common field by a cpumask
Date:   Fri,  7 Jul 2023 18:21:50 +0100
Message-Id: <20230707172155.70873-5-vschneid@redhat.com>
In-Reply-To: <20230707172155.70873-1-vschneid@redhat.com>
References: <20230707172155.70873-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracing_cpumask lets us specify which CPUs are traced in a buffer
instance, but doesn't let us do this on a per-event basis (unless one
creates an instance per event).

A previous commit added filtering scalar fields by a user-given cpumask,
make this work with the CPU common field as well.

This enables doing things like

$ trace-cmd record -e 'sched_switch' -f 'CPU & CPUS{12-52}' \
		   -e 'sched_wakeup' -f 'target_cpu & CPUS{12-52}'

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1e14f801685a8..3009d0c61b532 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -68,6 +68,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_PCHAR_USER,
 	FILTER_PRED_FN_PCHAR,
 	FILTER_PRED_FN_CPU,
+	FILTER_PRED_FN_CPU_CPUMASK,
 	FILTER_PRED_FN_CPUMASK,
 	FILTER_PRED_FN_FUNCTION,
 	FILTER_PRED_FN_,
@@ -937,6 +938,14 @@ static int filter_pred_cpu(struct filter_pred *pred, void *event)
 	}
 }
 
+/* Filter predicate for current CPU vs user-provided cpumask */
+static int filter_pred_cpu_cpumask(struct filter_pred *pred, void *event)
+{
+	int cpu = raw_smp_processor_id();
+
+	return do_filter_scalar_cpumask(pred->op, cpu, pred->mask);
+}
+
 /* Filter predicate for cpumask field vs user-provided cpumask */
 static int filter_pred_cpumask(struct filter_pred *pred, void *event)
 {
@@ -1440,6 +1449,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_pchar(pred, event);
 	case FILTER_PRED_FN_CPU:
 		return filter_pred_cpu(pred, event);
+	case FILTER_PRED_FN_CPU_CPUMASK:
+		return filter_pred_cpu_cpumask(pred, event);
 	case FILTER_PRED_FN_CPUMASK:
 		return filter_pred_cpumask(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
@@ -1659,6 +1670,7 @@ static int parse_pred(const char *str, void *data,
 
 		switch (field->filter_type) {
 		case FILTER_CPUMASK:
+		case FILTER_CPU:
 		case FILTER_OTHER:
 			break;
 		default:
@@ -1714,6 +1726,8 @@ static int parse_pred(const char *str, void *data,
 		i++;
 		if (field->filter_type == FILTER_CPUMASK) {
 			pred->fn_num = FILTER_PRED_FN_CPUMASK;
+		} else if (field->filter_type == FILTER_CPU) {
+			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
 		} else {
 			switch (field->size) {
 			case 8:
-- 
2.31.1

