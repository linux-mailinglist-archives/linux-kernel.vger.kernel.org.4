Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B81719745
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjFAJmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjFAJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:42:23 -0400
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F981B5;
        Thu,  1 Jun 2023 02:42:12 -0700 (PDT)
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-6af70ff2761so617918a34.0;
        Thu, 01 Jun 2023 02:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685612532; x=1688204532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xD7Vt+s/zfrb3I67O6RtMQEijSSfyZ3z20C7E6e0J4Y=;
        b=WiQ1YXIRgNeofWs4vsRwhyvzuFjPbcTMsFRrO2sUHwGlU1X4nd+B/3i8oDwsFUJKV1
         YeWgJug9DFtggSSHqs8H0dArJtDbF/s3kJTIxpX61zLpXldfvaARlYyVvKdxVkZvw+t+
         qhz71LJ50H2G8lKTa/NqtWzWnMT7VIwrU2h4b2Dn+Ro/D9pUWFzps3xYKI/1zusFiYsN
         e0obc0qMqZocOVrx7uKuDkRScnT/SG41+xaL4dtqAnDbRtVYrqpZw7NT2Ew2PoE35V9Q
         RXTNXDpPGJ6fwS8klBs180NubXmjDttxMscJjryoHAwbxRmZpGmje9X6tAi7Z6a+Ert6
         07Tw==
X-Gm-Message-State: AC+VfDx0PfGyAwIlfTbZpKSnAoUu5xmF+FLQJuRyaoNQegIDFAxeeEv/
        GU6wWcL+/FQquexCW1OyNA==
X-Google-Smtp-Source: ACHHUZ696BwWzLLwcQ0LMduQ0GPUzk+CyMW5/XuE4T3UydrBqZzrfxMTc7k/dBTU7MhIbyuButxaNg==
X-Received: by 2002:a05:6358:e49c:b0:123:5b98:1944 with SMTP id by28-20020a056358e49c00b001235b981944mr2815301rwb.22.1685612531922;
        Thu, 01 Jun 2023 02:42:11 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id ca14-20020a17090af30e00b0025023726fc4sm995437pjb.26.2023.06.01.02.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:42:11 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, beaub@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH] tracing/user_events: Fix the incorrect trace record for null arguments events
Date:   Thu,  1 Jun 2023 17:41:58 +0800
Message-Id: <20230601094158.575019-1-sunliming@kylinos.cn>
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

The user_events support events that has null arguments. But the trace event
is discard and not really committed when the arguments is null, fix this
problem.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 0d91dac206ff..296bdfa674cb 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1399,7 +1399,7 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
 	if (unlikely(!entry))
 		return;
 
-	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
+	if (unlikely(i->count && !copy_nofault(entry + 1, i->count, i)))
 		goto discard;
 
 	if (!list_empty(&user->validators) &&
@@ -1440,7 +1440,7 @@ static void user_event_perf(struct user_event *user, struct iov_iter *i,
 
 		perf_fetch_caller_regs(regs);
 
-		if (unlikely(!copy_nofault(perf_entry + 1, i->count, i)))
+		if (unlikely(i->count && !copy_nofault(perf_entry + 1, i->count, i)))
 			goto discard;
 
 		if (!list_empty(&user->validators) &&
-- 
2.25.1

