Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098A8746109
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGCQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCQ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:58:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AE3E58;
        Mon,  3 Jul 2023 09:58:40 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3458a08310aso21144185ab.3;
        Mon, 03 Jul 2023 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688403520; x=1690995520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1gGSJ/PiSm4A8FwJkg4VqG00mespObQU5IonWWaF9g=;
        b=QNZQrObPBCtp+tU5MHKcTh+qpIMP3vzmk6S9GmJmVXTQxWjwzmpKPrmHMR5vtDFyy3
         mOuxxon0KoZMts8WAWOhZKXPspHs2qkLYGURMzbMmjmC9uLojgaWxJ4A8wnvF+ukYLbH
         KJ9qF9SyjepD4AUQ+fvMqrizZtBHWnGh0v3YN68/v8TvFjpmZakB0Giw9u4Q4rTtfCvk
         HTbXmIkejDe2nbCk4hF4t+KkTwSKY1eUKC9B4kOnPf38rdhUVYTH10GLB7OSXhCS8scM
         Mph7mosXnf8jKkrnTC9N/8jK7sE69TknnZp5UoYC2Y0AEM34RQDqo3B+UWhEFkjuVBcF
         ZBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688403520; x=1690995520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1gGSJ/PiSm4A8FwJkg4VqG00mespObQU5IonWWaF9g=;
        b=GR/RGMkOlWaE+aIcqpORwKkuibK+s7ZA0BZtx1MxYv4o6jhlJgoxmGSzg1Yqu9j2Fc
         /GC9zWPyxdBJBnPa1aV7m3fCzy3COom48WtCmcfwYqCZ0wX8lhRM74JpvQ2X6WMCEatI
         L+UEzWKTPtC7k1e2awk7GPuL6B5lagrD+6gWUGsEnuEJBKWSXnIqsQFGpv6CF0okyw7+
         ZizD8bFvp6bRToWfYLZnvLMX8o7XeWB8GBSFqNAx2FaJ+FND7NRsOyiKrQ7lWybN0VkK
         J4IfO7kzzitDzzricqSx7SegzlYQ52UNXtsADB6qHKQNnURtaQfnxH7JPyBa+SMvm/si
         c8Wg==
X-Gm-Message-State: ABy/qLY8YV0I8E2vwKRk95Ej3MyRfVepNFuja5ge4MJoEn1R2syD2E8Z
        3pXo24Yydny5VF94n0jRbOc=
X-Google-Smtp-Source: APBJJlHa5vJLvAEYbpRNrOoLf2BjlUjeDhQGrJYzACaFmghuRs0GfggMClE9APrML1QXzaijwQhFng==
X-Received: by 2002:a92:c912:0:b0:345:6c70:a7cd with SMTP id t18-20020a92c912000000b003456c70a7cdmr11077327ilp.1.1688403519855;
        Mon, 03 Jul 2023 09:58:39 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id r5-20020a056638100500b0042319c38763sm6627058jab.15.2023.07.03.09.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 09:58:39 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Replace strlcpy with strscpy
Date:   Mon,  3 Jul 2023 16:58:16 +0000
Message-ID: <20230703165817.2840457-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
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
 kernel/events/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 78ae7b6f90fd..2554f5fc70dc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8249,7 +8249,7 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	unsigned int size;
 
 	memset(comm, 0, sizeof(comm));
-	strlcpy(comm, comm_event->task->comm, sizeof(comm));
+	strscpy(comm, comm_event->task->comm, sizeof(comm));
 	size = ALIGN(strlen(comm)+1, sizeof(u64));
 
 	comm_event->comm = comm;
@@ -8704,7 +8704,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	}
 
 cpy_name:
-	strlcpy(tmp, name, sizeof(tmp));
+	strscpy(tmp, name, sizeof(tmp));
 	name = tmp;
 got_name:
 	/*
@@ -9128,7 +9128,7 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
 	    ksym_type == PERF_RECORD_KSYMBOL_TYPE_UNKNOWN)
 		goto err;
 
-	strlcpy(name, sym, KSYM_NAME_LEN);
+	strscpy(name, sym, KSYM_NAME_LEN);
 	name_len = strlen(name) + 1;
 	while (!IS_ALIGNED(name_len, sizeof(u64)))
 		name[name_len++] = '\0';
-- 
2.41.0.255.g8b1d071c50-goog


