Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2149A7107ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbjEYIx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjEYIx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:53:27 -0400
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4BB18D;
        Thu, 25 May 2023 01:53:26 -0700 (PDT)
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-64d247a023aso1477686b3a.2;
        Thu, 25 May 2023 01:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685004805; x=1687596805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0ktlHLUqr7tobF2W37f5gg25uCvUm1lAaeh1EoSirE=;
        b=hdee6vG9LWjJthd9snnHvEDauHgPAtSIZkiCj3rahWp4aAVzNVV8VPsFZSasX0SpTo
         w9Y90FwqiRswo0lF2ZnSQej6ZOV3vHVBmjUnjAJIro/P20sWxPjAof7dHVTWTjIlgrD4
         BEGf/gHz+rNPoXC3MJZWRXm3WCgfS2eyl8aw0kNzNmhwtCQ5DUtbbDzrg/pY2UZSmfqF
         vSxGzZdIf0yAKthSZ9e1rGMBS06q0W1NTvSh0zpP2pDu4wwo4KhwHj0Q4AlemYxTihPd
         YF/7MFpFt7BJ8wzOopbKYUNsQHeNksx/BRl6rQvXsN4X2YFj47jp/zKS1X6HZhNr9B6Z
         w44g==
X-Gm-Message-State: AC+VfDywJO6Ti2pmm9rv3PZAmoBv4OtcX2adWEwrdRRI+x2R/Z3984IH
        gYmhBASzwus/QIv35Z5ymw==
X-Google-Smtp-Source: ACHHUZ4hZcFc6Fg4ZJATuVjsuWQ9MhBQOsCdoiNZVQBhKU6aceeP8OMAEZzTZ7HNqL1RUQhh6dWMIA==
X-Received: by 2002:a05:6a00:22c2:b0:64c:c5f9:1533 with SMTP id f2-20020a056a0022c200b0064cc5f91533mr8940660pfj.33.1685004805442;
        Thu, 25 May 2023 01:53:25 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78d49000000b00643889e30c2sm730352pfe.180.2023.05.25.01.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:53:24 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        kelulanainsley@gmail.com, sunliming <sunliming@kylinos.cn>
Subject: [PATCH] tracing: Modify print_fields() for fields output order
Date:   Thu, 25 May 2023 16:52:32 +0800
Message-Id: <20230525085232.5096-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the print_fields() print trace event fields in reverse order. Modify
it to the positive sequence.

Example outputs for a user event:
	test0 u32 count1; u32 count2

Output before:
	example-2547    [000] .....   325.666387: test0: count2=0x2 (2) count1=0x1 (1)

Output after:
	example-2742    [002] .....   429.769370: test0: count1=0x1 (1) count2=0x2 (2)

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 15f05faaae44..1e33f367783e 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -847,7 +847,7 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 	int ret;
 	void *pos;
 
-	list_for_each_entry(field, head, link) {
+	list_for_each_entry_reverse(field, head, link) {
 		trace_seq_printf(&iter->seq, " %s=", field->name);
 		if (field->offset + field->size > iter->ent_size) {
 			trace_seq_puts(&iter->seq, "<OVERFLOW>");
-- 
2.25.1

