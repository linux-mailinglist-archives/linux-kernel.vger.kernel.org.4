Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8FD627497
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiKNCdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKNCdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:33:00 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ACBDE94
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 18:32:56 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9YHp35T5zRp2l;
        Mon, 14 Nov 2022 10:32:38 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 10:32:54 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 10:32:54 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] tracing: Fix infinite loop in tracing_read_pipe on overflowed print_trace_line
Date:   Mon, 14 Nov 2022 10:29:46 +0800
Message-ID: <20221114022946.66255-1-yangjihong1@huawei.com>
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
 kernel/trace/trace.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 47a44b055a1d..2a8d5c68c29b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6788,6 +6788,19 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 		if (ret == TRACE_TYPE_PARTIAL_LINE) {
 			/* don't print partial lines */
 			iter->seq.seq.len = save_len;
+
+			/*
+			 * If one trace_line of the tracer overflows seq_file
+			 * buffer, trace_seq_to_user returns -EBUSY because
+			 * nothing in the sequence (iter->seq.seq.len = \
+			 * iter->seq.seq.readpos = 0).
+			 * In this case, we need to consume, otherwise,
+			 * "while" will peek this event next time, resulting
+			 * in an infinite loop.
+			 */
+			if (trace_seq_has_overflowed(&iter->seq))
+				trace_consume(iter);
+
 			break;
 		}
 		if (ret != TRACE_TYPE_NO_CONSUME)
-- 
2.30.GIT

