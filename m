Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE8F662460
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjAILj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbjAILj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:39:28 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C115CB71;
        Mon,  9 Jan 2023 03:39:25 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NrBmr3DPZz8R03d;
        Mon,  9 Jan 2023 19:39:24 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 309BdI4g088435;
        Mon, 9 Jan 2023 19:39:18 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 9 Jan 2023 19:39:21 +0800 (CST)
Date:   Mon, 9 Jan 2023 19:39:21 +0800 (CST)
X-Zmail-TransId: 2b0363bbfce9ffffffffb25ceaed
X-Mailer: Zmail v1.0
Message-ID: <202301091939219689840@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <rostedt@goodmis.org>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHRyYWNpbmc6IHVzZSBzdHJzY3B5KCkgdG8gaW5zdGVhZCBvZiBzdHJuY3B5KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 309BdI4g088435
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63BBFCEC.000 by FangMail milter!
X-FangMail-Envelope: 1673264364/4NrBmr3DPZz8R03d/63BBFCEC.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63BBFCEC.000/4NrBmr3DPZz8R03d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
 kernel/trace/trace_events_synth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 67592eed0be8..cd636edd045e 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -195,8 +195,7 @@ static int synth_field_string_size(char *type)
 	if (len == 0)
 		return 0; /* variable-length string */

-	strncpy(buf, start, len);
-	buf[len] = '\0';
+	strscpy(buf, start, len + 1);

 	err = kstrtouint(buf, 0, &size);
 	if (err)
-- 
2.15.2
