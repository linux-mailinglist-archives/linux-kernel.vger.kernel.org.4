Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9580D665B02
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjAKMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbjAKMEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:04:33 -0500
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78A425D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:04:13 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 11 Jan
 2023 15:04:12 +0300
Received: from KANASHIN1.fintech.ru (10.0.253.125) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 11 Jan
 2023 15:04:11 +0300
From:   Natalia Petrova <n.petrova@fintech.ru>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Natalia Petrova <n.petrova@fintech.ru>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: [PATCH] trace_events_hist: add check for return value of 'create_hist_field'
Date:   Wed, 11 Jan 2023 15:04:09 +0300
Message-ID: <20230111120409.4111-1-n.petrova@fintech.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.125]
X-ClientProxiedBy: Ex16-01.fintech.ru (10.0.10.18) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function 'create_hist_field' is called recursively at
trace_events_hist.c:1954 and can return NULL-value that's why we have
to check it to avoid null pointer dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 30350d65ac56 ("tracing: Add variable support to hist triggers")
Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
---
 kernel/trace/trace_events_hist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fdf784620c28..9c8c1614a78e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1952,6 +1952,8 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		hist_field->fn = flags & HIST_FIELD_FL_LOG2 ? hist_field_log2 :
 			hist_field_bucket;
 		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
+		if (!hist_field->operands[0])
+			goto free;
 		hist_field->size = hist_field->operands[0]->size;
 		hist_field->type = kstrdup_const(hist_field->operands[0]->type, GFP_KERNEL);
 		if (!hist_field->type)
-- 
2.34.1

