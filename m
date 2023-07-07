Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0327774B5BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjGGRYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjGGRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C82695
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688750550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3SClOtTb5K9y8gZXjCHv42uNQ6hcmWjrBQMdqu658k=;
        b=Q/bmqNY6D6rS+svzPKR3QslL4QgKmyB5CGR21/tKhE+vy+MrRoFK6g0iA+uqFIUXTB3voK
        GjFOgfyJ3y3stJqvlkIYAuU/2oau6Zal78eJltrAAVoKgR9VVSAhq8MAY8TDchm42zdH7s
        hsqjZ8b57ZkTqhwQQld2vFGYd87dhEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-amTFn5uzP1yLYEZe2nRM0A-1; Fri, 07 Jul 2023 13:22:27 -0400
X-MC-Unique: amTFn5uzP1yLYEZe2nRM0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C52C385CEE6;
        Fri,  7 Jul 2023 17:22:26 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 790241454142;
        Fri,  7 Jul 2023 17:22:25 +0000 (UTC)
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
Subject: [PATCH v2 8/9] tracing/filters: Further optimise scalar vs cpumask comparison
Date:   Fri,  7 Jul 2023 18:21:54 +0100
Message-Id: <20230707172155.70873-9-vschneid@redhat.com>
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

Per the previous commits, we now only enter do_filter_scalar_cpumask() with
a mask of weight greater than one. Optimise the equality checks.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index fd72dacc5d1b8..3a529214a21b7 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -667,6 +667,25 @@ do_filter_cpumask(int op, const struct cpumask *mask, const struct cpumask *cmp)
 /* Optimisation of do_filter_cpumask() for scalar fields */
 static inline int
 do_filter_scalar_cpumask(int op, unsigned int cpu, const struct cpumask *mask)
+{
+	/*
+	 * Per the weight-of-one cpumask optimisations, the mask passed in this
+	 * function has a weight >= 2, so it is never equal to a single scalar.
+	 */
+	switch (op) {
+	case OP_EQ:
+		return false;
+	case OP_NE:
+		return true;
+	case OP_BAND:
+		return cpumask_test_cpu(cpu, mask);
+	default:
+		return 0;
+	}
+}
+
+static inline int
+do_filter_cpumask_scalar(int op, const struct cpumask *mask, unsigned int cpu)
 {
 	switch (op) {
 	case OP_EQ:
@@ -966,12 +985,7 @@ static int filter_pred_cpumask_cpu(struct filter_pred *pred, void *event)
 	const struct cpumask *mask = (event + loc);
 	unsigned int cpu = pred->val;
 
-	/*
-	 * This inverts the usual usage of the function (field is first element,
-	 * user parameter is second), but that's fine because the (scalar, mask)
-	 * operations used are symmetric.
-	 */
-	return do_filter_scalar_cpumask(pred->op, cpu, mask);
+	return do_filter_cpumask_scalar(pred->op, mask, cpu);
 }
 
 /* Filter predicate for COMM. */
-- 
2.31.1

