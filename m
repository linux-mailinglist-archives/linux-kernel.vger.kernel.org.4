Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C7874548A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 06:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGCE3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 00:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGCE3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 00:29:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD6109;
        Sun,  2 Jul 2023 21:28:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d80c5c834so7131649a12.1;
        Sun, 02 Jul 2023 21:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688358536; x=1690950536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+PYWg+lKhTt8ra3LWD/J7Z1Qh9cmVHXjH6CInXEcLc=;
        b=eAYEYlVGup5RcV0jQc1nzBdJSSyovSMRCP39Jd4dlFdU9CFtRTK+OL0FlCFPIeJnsK
         2ebF+rvg6YzFlA/Ym1PixMR6F4OubpmhPKmKnmTIytQkaKzCZyTyFjt6kVcj9pMmo1CD
         6oqAgM54CQ5nfG/tFeUL7YwZTZlM1CjGdsAquQWxhXS9H+bg5DTRQ5i4eCLkhEgbgJJy
         mmEQyvg9GsjnX6AVHdwJgCEXyrGdMlEpeh/WTuJtYOmvUVc0natn5lACorQwx2Cqsf7d
         /7nmvZ5OmJBEKiJKhF5Lx4NXRY7pciOS9LUR3eMpgPVL1q6rwRIokDQxpV7VAvWxs/uo
         /arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688358536; x=1690950536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+PYWg+lKhTt8ra3LWD/J7Z1Qh9cmVHXjH6CInXEcLc=;
        b=C8iJ/JHK/alcycbwjOM9uC4B42auad5IiSRAqMb4/X+LgHJ56UIuLnl7vOUkPoJcUT
         bK1JOaWVITpqeW5L0jQYOqfTJTG1qDDXwmOWVPdtrQTtLCPTkYiSA2ny+YeyIGZs/aZN
         iRLwbDdBp9iyLYg+afLlIyczezNYc8QzWtmDuU+jpIsco/sf15kNKt5/xRdhf3wRkqds
         qRclP6NRJLLH4d//LrOrXbWjQd/TJrCqFWoonMGxsmc5PnZmQijgDgZqqp/Ow5NCVd/+
         WaMT1d2hXg/qb3D8DrtgmsR5kWr0DvwMRzJ/49qWjz6qF5gZvD9OGawZzs1SAvIg0y3L
         McoA==
X-Gm-Message-State: AC+VfDyTcHts1kK0KhwXOvVLm0ubxKyDZSXBILNNwZ8q9OZK0ZCc0JN3
        UPgUmb6k04WqL1HcbCYoLUWVoYAVrgs=
X-Google-Smtp-Source: ACHHUZ4zasJ6oGKcRBsCsz+K6U7gJPRczvp/Figt1wCQTvtMd0txtpGzuuAXskWdFTeHZkh2ET1ljA==
X-Received: by 2002:aa7:d047:0:b0:51b:f862:7b6a with SMTP id n7-20020aa7d047000000b0051bf8627b6amr12617211edo.14.1688358535938;
        Sun, 02 Jul 2023 21:28:55 -0700 (PDT)
Received: from oberon.zico.biz (77-85-190-39.ip.btc-net.bg. [77.85.190.39])
        by smtp.gmail.com with ESMTPSA id s19-20020a056402165300b0051d9df5dd2fsm7724006edx.72.2023.07.02.21.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 21:28:55 -0700 (PDT)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, dan.carpenter@linaro.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] kernel/trace: Fix cleanup logic of enable_trace_eprobe
Date:   Mon,  3 Jul 2023 07:28:53 +0300
Message-ID: <20230703042853.1427493-1-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enable_trace_eprobe() function enables all event probes, attached
to given trace probe. If an error occurs in enabling one of the event
probes, all others should be roll backed. There is a bug in that roll
back logic - instead of all event probes, only the failed one is
disabled.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
Changes since v1: https://lore.kernel.org/all/20230628121811.338655-1-tz.stoyanov@gmail.com/
 - Added one-time warning, suggested by Steven Rostedt.
Changed since v2: https://lore.kernel.org/lkml/20230630121627.833560-1-tz.stoyanov@gmail.com/
 - Added counter of successfully enabled eprobes, suggested by Steven Rostedt.

 kernel/trace/trace_eprobe.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index cb0077ba2b49..a0a704ba27db 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -644,6 +644,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 	struct trace_eprobe *ep;
 	bool enabled;
 	int ret = 0;
+	int cnt = 0;
 
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
@@ -667,12 +668,25 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 		if (ret)
 			break;
 		enabled = true;
+		cnt++;
 	}
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled)
-			disable_eprobe(ep, file->tr);
+		if (enabled) {
+			/*
+			 * It's a bug if one failed for something other than memory
+			 * not being available but another eprobe succeeded.
+			 */
+			WARN_ON_ONCE(ret != -ENOMEM);
+
+			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+				ep = container_of(pos, struct trace_eprobe, tp);
+				disable_eprobe(ep, file->tr);
+				if (!--cnt)
+					break;
+			}
+		}
 		if (file)
 			trace_probe_remove_file(tp, file);
 		else
-- 
2.41.0

