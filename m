Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A67729DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjFIPHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjFIPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F5635A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686323187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HhCGDFDeE6330wjTb7+eVdOM5sDQ6eAc/Pd0Q124xLM=;
        b=XCOLcq3N0RtxwxyMV5G1epM4iyIsgYU3nh8+nyKNMl/iWE5sY6W5gN/X/AOd630rY8Twk1
        1schNugwd2LAlsa0rGpCN0YBoFjdPbCf8NZhjhmRD0bLIjcqiYGdbWHDrxvc+4KOy553Rt
        sYJY0tWMiv2iWi533SEewGt5I1DdZms=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-Tk9tFEnVO-ePKnVkh1JcRA-1; Fri, 09 Jun 2023 11:04:26 -0400
X-MC-Unique: Tk9tFEnVO-ePKnVkh1JcRA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CDA43C0D1A5;
        Fri,  9 Jun 2023 15:04:18 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD1BC4087C6A;
        Fri,  9 Jun 2023 15:04:16 +0000 (UTC)
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
Subject: [RFC PATCH 4/5] tracing/filters: Enable filtering the CPU common field by a cpumask
Date:   Fri,  9 Jun 2023 16:03:23 +0100
Message-Id: <20230609150324.143538-5-vschneid@redhat.com>
In-Reply-To: <20230609150324.143538-1-vschneid@redhat.com>
References: <20230609150324.143538-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

$ trace-cmd record -e 'sched_switch' -f 'CPU & MASK{12-52}' \
		   -e 'sched_wakeup' -f 'target_cpu & MASK{12-52}'

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 99e111c237a93..b3d2612d4670a 100644
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
@@ -933,6 +934,13 @@ static int filter_pred_cpu(struct filter_pred *pred, void *event)
 	}
 }
 
+static int filter_pred_cpu_cpumask(struct filter_pred *pred, void *event)
+{
+	int cpu = raw_smp_processor_id();
+
+	return do_filter_cpumask_scalar(pred->op, cpu, pred->mask);
+}
+
 /* Filter predicate for cpumasks. */
 static int filter_pred_cpumask(struct filter_pred *pred, void *event)
 {
@@ -1436,6 +1444,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_pchar(pred, event);
 	case FILTER_PRED_FN_CPU:
 		return filter_pred_cpu(pred, event);
+	case FILTER_PRED_FN_CPU_CPUMASK:
+		return filter_pred_cpu_cpumask(pred, event);
 	case FILTER_PRED_FN_CPUMASK:
 		return filter_pred_cpumask(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
@@ -1654,6 +1664,7 @@ static int parse_pred(const char *str, void *data,
 		char *tmp;
 
 		if (field->filter_type != FILTER_CPUMASK &&
+		    field->filter_type != FILTER_CPU &&
 		    field->filter_type != FILTER_OTHER) {
 			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
 			goto err_free;
@@ -1698,6 +1709,8 @@ static int parse_pred(const char *str, void *data,
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

