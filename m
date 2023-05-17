Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47114706BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjEQOyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjEQOyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:54:05 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E826DAD34;
        Wed, 17 May 2023 07:53:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-76c7b46a261so4096639f.1;
        Wed, 17 May 2023 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684335213; x=1686927213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAZUJozcoVKmsjLyeB1bGV79CfS9One1jPdm+WsF08I=;
        b=aYYHo7zbKhRT/HVxBLv6M1twfy2wwHKF7qG6JhX6whSTjIiNZCnGGp6PojOLpkmq/H
         5xkQgCbr0/zmOcBXHseD07zi7KLmEg78q020Azwm54+uqJxNmIHM683VTo/c7n8q9Hy7
         tq/Yc4B4XcHs6qQzyTmRlpNN+JrUByMsTEQoqn1y6JNz0Nq87t11WsvdvWfciE/+jmq/
         3L7OOVM+oU5a8XICbPPdo1N4bdDxvDTeWU05thcGM7AsVl1sR8fhf5+o3i492qd/i/Y9
         GagukKJdk6pjpQDkNY7Fj/z1QoOJo4VNLXZv/9v0KeIbjzLuSVvVolwSry6ZdjqYbzwx
         6StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335213; x=1686927213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAZUJozcoVKmsjLyeB1bGV79CfS9One1jPdm+WsF08I=;
        b=faQD1j2jM2wSK3zk17wLNV3M7/NQQtceGdY3EJKTvAgDDwowk5RqImnwOMpaiUHWyf
         5HcR22Mh73bCLkUooMNzfWyR1+xzyrbZ0peeaowYcwt5IefZGZu2WESnJUxxq0lrVMBy
         Gt4CYQqK/tImYVygDGhYpWut7lLbJ7wr+bmzMrIkFszS7an6/AxhzPaYcHjsr7QrHEm6
         st6DHnqFJAi7ZxwxKDoL5E62JLNhCmH1a3XfMqiWz9m9GJQ3mbUZwSpCzf7PC0LGceGc
         MKpY6i+t1UwWCkKYaUX3R9D6WcY/+zsAi5fVMJeHWe2j4lHtNTikBX3aOGxcFSs3TtVy
         gFYg==
X-Gm-Message-State: AC+VfDwSil9riM4wverKJKQof3HeXsd9B8NADkRCBInvK66TfKP+aBtq
        0WkKDwW4JWaa9D+DvQWZdMTtkXnCXUttXg==
X-Google-Smtp-Source: ACHHUZ4WEsrvwhzmJcdRbyYb0lJDcP9K4xTlgtQdZ1p77RNM9llM6MVqkmJ5ulUczj1vTYSSZ6jsdg==
X-Received: by 2002:a6b:dc0e:0:b0:76c:8d6c:9654 with SMTP id s14-20020a6bdc0e000000b0076c8d6c9654mr1655694ioc.7.1684335213494;
        Wed, 17 May 2023 07:53:33 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id a18-20020a056602209200b0076c76dfdaa0sm4921681ioa.25.2023.05.17.07.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:53:33 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace: Replace all non-returning strlcpy with strscpy
Date:   Wed, 17 May 2023 14:53:23 +0000
Message-ID: <20230517145323.1522010-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
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
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 kernel/trace/ftrace.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 764668467155..6a77edb51f18 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5743,7 +5743,7 @@ bool ftrace_filter_param __initdata;
 static int __init set_ftrace_notrace(char *str)
 {
 	ftrace_filter_param = true;
-	strlcpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
+	strscpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_notrace=", set_ftrace_notrace);
@@ -5751,7 +5751,7 @@ __setup("ftrace_notrace=", set_ftrace_notrace);
 static int __init set_ftrace_filter(char *str)
 {
 	ftrace_filter_param = true;
-	strlcpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
+	strscpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_filter=", set_ftrace_filter);
@@ -5763,14 +5763,14 @@ static int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
 
 static int __init set_graph_function(char *str)
 {
-	strlcpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
+	strscpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_graph_filter=", set_graph_function);
 
 static int __init set_graph_notrace_function(char *str)
 {
-	strlcpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
+	strscpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_graph_notrace=", set_graph_notrace_function);
@@ -6569,8 +6569,8 @@ static int ftrace_get_trampoline_kallsym(unsigned int symnum,
 			continue;
 		*value = op->trampoline;
 		*type = 't';
-		strlcpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
-		strlcpy(module_name, FTRACE_TRAMPOLINE_MOD, MODULE_NAME_LEN);
+		strscpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
+		strscpy(module_name, FTRACE_TRAMPOLINE_MOD, MODULE_NAME_LEN);
 		*exported = 0;
 		return 0;
 	}
@@ -6933,7 +6933,7 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
 		if (off)
 			*off = addr - found_func->ip;
 		if (sym)
-			strlcpy(sym, found_func->name, KSYM_NAME_LEN);
+			strscpy(sym, found_func->name, KSYM_NAME_LEN);
 
 		return found_func->name;
 	}
@@ -6987,8 +6987,8 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
 
 			*value = mod_func->ip;
 			*type = 'T';
-			strlcpy(name, mod_func->name, KSYM_NAME_LEN);
-			strlcpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
+			strscpy(name, mod_func->name, KSYM_NAME_LEN);
+			strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
 			*exported = 1;
 			preempt_enable();
 			return 0;

