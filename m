Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495CD72D680
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbjFMAlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjFMAl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:41:29 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5F7192;
        Mon, 12 Jun 2023 17:41:29 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34070ecad56so139915ab.3;
        Mon, 12 Jun 2023 17:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686616888; x=1689208888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rTOQWFVA6khqHtVp7GD0MN95ozRngFd7SU7JpSTOX8=;
        b=HrrgygdGd34c3hZG9Ko9EXMPUVsYt81zKlXAISkhIkWi4VGAIIeUB8yV4tMn6EH5Ft
         +TbZAoQg0H0yz2aG4uOjIOx9fmzXD/nfPETyD8Ircp6qYdBOtOxWCzwH6rQR0rHov4SZ
         1tl9uHdNkhC9HMvwDreHqjE+VjO/HFT6SoHrVHnqxQmqy0qdZWEcEFOaWo3gsckMZZd6
         Xmta/E1NggY5feulbzO82qkYgZvQ7FJJQ6Zi/ZESTfDHapp08v8sJvd5ue31SHClqXA6
         uMm9qy0zYxvgph/jQvXdKYcR2xNTWWWJhf9z99/JQ3pIB7JfUQ110GXyjT02KBZLFchX
         2iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686616888; x=1689208888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rTOQWFVA6khqHtVp7GD0MN95ozRngFd7SU7JpSTOX8=;
        b=Z0F32AuQ/6M/ISeNfOhNnYFIYneCmGBbw4rSNNq8WkVPvPd/zYEXmnFcSvYOhMu35N
         MClxvY7MYSqyX+kUVESJyqJyXQG3zEPrBDqPTSUlnKIrpgq6veMU3qWRJu9zDyM2yb7z
         H1jJB0kNNBd+wos2oufDo8X17ladGfLwMdyPCGKAvspFfAguAOrZ3H82Ma3YhNX1FWAT
         O5Yy2dIVWZMRvbWG654bh9UplsMfwp15cSO2YtzeNvPoP5TqXJ+S0TnKWnUdlhRsTNZa
         hOTEZCbImVHZU8QVw4MDH2FqKgxXUl3mPUl20pfEBxe0Ba+56N/Y0Mwal9cF9gTQooCC
         pfyg==
X-Gm-Message-State: AC+VfDx9mh+23bZL1rHQPBYKZX4rzhTpEWKqEIe+WhQkrG8U8FZ97s/f
        KYEdFC7eivD+Z7K+wtMLWFE=
X-Google-Smtp-Source: ACHHUZ5+aBw/9fdFocQCVdMI2dhsI0WYOI12EJh5UbhGeU2wuKe9u6YaezCaTrv9JoLIcSljChYktg==
X-Received: by 2002:a92:d8c9:0:b0:334:f662:6406 with SMTP id l9-20020a92d8c9000000b00334f6626406mr8041778ilo.25.1686616888245;
        Mon, 12 Jun 2023 17:41:28 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id l5-20020a92d8c5000000b00338a1272ce1sm3510408ilo.52.2023.06.12.17.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 17:41:27 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/boot: Replace strlcpy with strscpy
Date:   Tue, 13 Jun 2023 00:41:25 +0000
Message-ID: <20230613004125.3539934-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -E2BIG
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 kernel/trace/trace_boot.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 778200dd8ede..5fe525f1b8cc 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -31,7 +31,7 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 
 	/* Common ftrace options */
 	xbc_node_for_each_array_value(node, "options", anode, p) {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
 			pr_err("String is too long: %s\n", p);
 			continue;
 		}
@@ -87,7 +87,7 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 	const char *p;
 
 	xbc_node_for_each_array_value(node, "events", anode, p) {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
 			pr_err("String is too long: %s\n", p);
 			continue;
 		}
@@ -486,7 +486,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 
 	p = xbc_node_find_value(enode, "filter", NULL);
 	if (p && *p != '\0') {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
 			pr_err("filter string is too long: %s\n", p);
 		else if (apply_event_filter(file, buf) < 0)
 			pr_err("Failed to apply filter: %s\n", buf);
@@ -494,7 +494,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 
 	if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
 		xbc_node_for_each_array_value(enode, "actions", anode, p) {
-			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+			if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
 				pr_err("action string is too long: %s\n", p);
 			else if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply an action: %s\n", p);
-- 
2.41.0.162.gfafddb0af9-goog


