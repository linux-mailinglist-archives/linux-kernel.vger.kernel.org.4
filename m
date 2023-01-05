Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B9265EA8F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjAEMSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjAEMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:18:04 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5785C4FCE1;
        Thu,  5 Jan 2023 04:18:03 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NnlqF4skCz6FK2Q;
        Thu,  5 Jan 2023 20:18:01 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl2.zte.com.cn with SMTP id 305CHs0m064884;
        Thu, 5 Jan 2023 20:17:54 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 5 Jan 2023 20:17:57 +0800 (CST)
Date:   Thu, 5 Jan 2023 20:17:57 +0800 (CST)
X-Zmail-TransId: 2b0363b6bff5ffffffff94a6df4f
X-Mailer: Zmail v1.0
Message-ID: <202301052017571305723@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <rostedt@goodmis.org>
Cc:     <mhiramat@kernel.org>, <paulmck@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHJjdS90cmFjZTogdXNlIHN0cnNjcHkoKSB0byBpbnN0ZWFkIG9mIHN0cm5jcHkoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 305CHs0m064884
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63B6BFF9.000 by FangMail milter!
X-FangMail-Envelope: 1672921081/4NnlqF4skCz6FK2Q/63B6BFF9.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63B6BFF9.000/4NnlqF4skCz6FK2Q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 include/trace/events/rcu.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 90b2fb0292cb..2703992edecd 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -776,9 +776,8 @@ TRACE_EVENT_RCU(rcu_torture_read,
 	),

 	TP_fast_assign(
-		strncpy(__entry->rcutorturename, rcutorturename,
+		strscpy(__entry->rcutorturename, rcutorturename,
 			RCUTORTURENAME_LEN);
-		__entry->rcutorturename[RCUTORTURENAME_LEN - 1] = 0;
 		__entry->rhp = rhp;
 		__entry->secs = secs;
 		__entry->c_old = c_old;
-- 
2.15.2
