Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B0A63799F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiKXNCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiKXNCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:02:01 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794058754A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:02:00 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHymc5ScCzHw3R;
        Thu, 24 Nov 2022 21:01:20 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 21:01:52 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 21:01:52 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v3] tracing: Fix infinite loop in tracing_read_pipe on overflowed print_trace_line
Date:   Thu, 24 Nov 2022 20:58:50 +0800
Message-ID: <20221124125850.155449-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

print_trace_line may overflow seq_file buffer. If the event is not
consumed, the while loop keeps peeking this event, causing a infinite loop.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 kernel/trace/trace.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a7fe0e115272..55733224fa88 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6787,7 +6787,27 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 
 		ret = print_trace_line(iter);
 		if (ret == TRACE_TYPE_PARTIAL_LINE) {
-			/* don't print partial lines */
+			/*
+			 * If one trace_line of the tracer overflows seq_file
+			 * buffer, trace_seq_to_user returns -EBUSY.
+			 * In this case, we need to consume it, otherwise,
+			 * while loop will peek this event next time,
+			 * resulting in an infinite loop.
+			 */
+			if (trace_seq_has_overflowed(&iter->seq)) {
+				/*
+				 * Here we only consider the case that one
+				 * print_trace_line() fills the entire trace_seq
+				 * in one shot, in that case, iter->seq.seq.len is zero,
+				 * we simply output a log of too long line to inform the user.
+				 */
+				iter->seq.full = 0;
+				trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
+				trace_consume(iter);
+				break;
+			}
+
+			/* In other cases, don't print partial lines */
 			iter->seq.seq.len = save_len;
 			break;
 		}
-- 
2.30.GIT

