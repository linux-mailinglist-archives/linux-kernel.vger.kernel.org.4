Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D7A731FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjFOSE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjFOSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:04:25 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE33C294A;
        Thu, 15 Jun 2023 11:04:23 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33aa60f4094so4118675ab.1;
        Thu, 15 Jun 2023 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686852263; x=1689444263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/u+///EcupbIJP0wmwzWwwhqxbaWqaZ46VmaNSEFYns=;
        b=NwXE6DH7KcGFqGahn7YCqVt/g6QP3KBqz0tDM1qLmE/9igLwfk2duRLPGN/GtJn6jU
         Rwyg0UkRwZ1rz/JdQiDm+V0VodKkd0MvXTPpa9ZZmNdDnI2sed5D2pbzoHJdBrQt2WwN
         3Zj3ibXFxp5Fw8jGzOI6gHa8hEFGFkWBsNEOXb7vv/sGK9ZvTPetn3VooYDBErUDVhMU
         4uClS8KpJ7vDGKrUq9uKrsPJd6fMp0YcPgvDxwMNQwYCfZdpE8rWj/caC9Q7ZVBCsBjy
         c+LD5iDkvLmzWguOcKUiWz/Ttna8GBYaLU9zh5khbuMGyqy5ZvbKkK44CrZaJIxGVYtg
         sRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686852263; x=1689444263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/u+///EcupbIJP0wmwzWwwhqxbaWqaZ46VmaNSEFYns=;
        b=g9C+73OTJQaedG0T/sQbjASxELabJ8FbzYTJ7lQyGuY7HQGVIfT9h1F+MMy/w6j9d+
         Podoq7q9VKoXOcrMxANiYh+xhSlNFikKtBNBpgkBOG3JK4yB970g61PLjGsbkXadEJ1j
         LGmu/uPwVskRw3xfyaGNEuBiL1DH5Xx9lIP/E94guZBcEn3P4/6bTTbr6UPl6O72WtM5
         QINSGORrJQwqcgAtLprkfX8lJGyrOJ8luUeK+Ylso5ozwR/Yt0klmqeIrInQ4ooWeLrv
         j2MSUU1NFh0ytUhZRFXkgbiOqemALza/KSuORiwuNxaRahZh0+caYIHqO6GvxuUKdwBP
         0LFg==
X-Gm-Message-State: AC+VfDxAuB4G9rJw6TljM1awSVGKCBv0WfRmnVHHfttieDnWNqVKVsCy
        iB0pA1gf0eVA2qVotfnyi4U=
X-Google-Smtp-Source: ACHHUZ7zHUNNjFwo+XUa1IpVOBDaASLdVU8eFLjZMuf3xpn0Ypd/YbViRraMO9er1ZfPRv82PKSxMg==
X-Received: by 2002:a05:6e02:ca9:b0:341:df27:8a97 with SMTP id 9-20020a056e020ca900b00341df278a97mr781250ilg.12.1686852262994;
        Thu, 15 Jun 2023 11:04:22 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id a11-20020a92a30b000000b0033ce0ef231bsm3039027ili.23.2023.06.15.11.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 11:04:22 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing/boot: Replace strlcpy with strscpy
Date:   Thu, 15 Jun 2023 18:04:20 +0000
Message-ID: <20230615180420.400769-1-azeemshaikh38@gmail.com>
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

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v2:
 * Use "< 0" instead of -E2BIG.

v1:
 * https://lore.kernel.org/all/20230613004125.3539934-1-azeemshaikh38@gmail.com/

 kernel/trace/trace_boot.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 778200dd8ede..7ccc7a8e155b 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -31,7 +31,7 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 
 	/* Common ftrace options */
 	xbc_node_for_each_array_value(node, "options", anode, p) {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0) {
 			pr_err("String is too long: %s\n", p);
 			continue;
 		}
@@ -87,7 +87,7 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 	const char *p;
 
 	xbc_node_for_each_array_value(node, "events", anode, p) {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0) {
 			pr_err("String is too long: %s\n", p);
 			continue;
 		}
@@ -486,7 +486,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 
 	p = xbc_node_find_value(enode, "filter", NULL);
 	if (p && *p != '\0') {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0)
 			pr_err("filter string is too long: %s\n", p);
 		else if (apply_event_filter(file, buf) < 0)
 			pr_err("Failed to apply filter: %s\n", buf);
@@ -494,7 +494,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 
 	if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
 		xbc_node_for_each_array_value(enode, "actions", anode, p) {
-			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+			if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0)
 				pr_err("action string is too long: %s\n", p);
 			else if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply an action: %s\n", p);
-- 
2.41.0.162.gfafddb0af9-goog


