Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E2370ED0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbjEXF2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239347AbjEXF2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:28:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E0213E;
        Tue, 23 May 2023 22:28:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ae4d1d35e6so4208605ad.0;
        Tue, 23 May 2023 22:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684906117; x=1687498117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=W6kUveazmI/2mChCTnueKXfUry75ocgV/yH5bVTAw9A=;
        b=XjDPkqRK9rr1M8kESs++g8i2DeggEfB1cY59xqV+hFKaoZDNJcbIOuA8avK4mRKeUv
         3CGu+OQZSAUsLX/Mfo5keCG84W6IN4yVYpW3iWlr0t+wLZh8w/Xj6wc42uqfNDMPfo4G
         qB7+s+Jk4qan3k2GfhT4SFv4+Hzw1Ov6VWotsWjcqfTyoAm8rbT9sc9E8nuiHJAxKv+8
         MdN2+8ZaTC7+f2FOq0oZj5etQEgq+p5pGB1K0rBkgrDPK0WEbhb7F4xsQRhheiQ0oAYR
         nb4mtR0jxEUxJHrf4CyfGTBihfKxOb9JnssxSnzNYLdQ/KGdRbEVfO/3ueiWwm+g/bvx
         5bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684906117; x=1687498117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6kUveazmI/2mChCTnueKXfUry75ocgV/yH5bVTAw9A=;
        b=Unzt9fxR4+uIRDeUAqXQjdn/EpEmjByjSLeNWRkMs/5WOHEmxlpeS6UWNho/9SnLy0
         xBrCsL36czs6rMzl0YJcs1r1PeKD7aZExuc7Uul1OnrPBYPqmcR46kzr10MyiDNoXe3V
         vX81KSorD02qKOroLcjN5zVUgVuKOHY2zepI4J8KZqqPXb3zlEGoPXfXue5RKC4xv6Kf
         AZyBmgKufkP39oLbemcHzSgtsMB8qaxQ2HerBZPBQbWXQmSrVUB0QKOQVCxMKmOalDKH
         Xq8zsUf+3d5vFefsk9n1JCRn6N9lTKMMEzkqkPTfYSDIplb8D6zE5kBLbQw+K34x0He6
         k18Q==
X-Gm-Message-State: AC+VfDx/Ahefr5gai71s6nhbOEkaJDQwibQvjhzzcnx0he2lbafouuqK
        y04aoMjqFmRKYCN48Pnm6Yt9Ad7AYCs=
X-Google-Smtp-Source: ACHHUZ5644DT6wLuSLJdUqXnUd7o9sLEu9in789VD7+zDlvzds9RMvbwqDuFRKKlYJYU7Udw5813bQ==
X-Received: by 2002:a17:903:2341:b0:1a6:7ed0:147e with SMTP id c1-20020a170903234100b001a67ed0147emr20337766plh.33.1684906116826;
        Tue, 23 May 2023 22:28:36 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:806f:2bdc:cf65:f76b])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001a64011899asm7706626plg.25.2023.05.23.22.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 22:28:36 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/2] perf annotate: Handle x86 instruction suffix generally
Date:   Tue, 23 May 2023 22:28:33 -0700
Message-ID: <20230524052834.1041418-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of x86 instructions can have size suffix like b, w, l or q.
Instead of adding all these instructions in the table, we can handle
them in a general way.  For example, it can try to find an instruction
as is.  If not found, it'd try again without the suffix if it's one of
the allowed suffixes.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b708bbc49c9e..7f05f2a2aa83 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -70,6 +70,7 @@ struct arch {
 	struct ins_ops  *(*associate_instruction_ops)(struct arch *arch, const char *name);
 	bool		sorted_instructions;
 	bool		initialized;
+	const char	*insn_suffix;
 	void		*priv;
 	unsigned int	model;
 	unsigned int	family;
@@ -179,6 +180,7 @@ static struct arch architectures[] = {
 		.init = x86__annotate_init,
 		.instructions = x86__instructions,
 		.nr_instructions = ARRAY_SIZE(x86__instructions),
+		.insn_suffix = "bwlq",
 		.objdump =  {
 			.comment_char = '#',
 		},
@@ -720,6 +722,26 @@ static struct ins_ops *__ins__find(struct arch *arch, const char *name)
 	}
 
 	ins = bsearch(name, arch->instructions, nmemb, sizeof(struct ins), ins__key_cmp);
+	if (ins)
+		return ins->ops;
+
+	if (arch->insn_suffix) {
+		char tmp[32];
+		char suffix;
+		size_t len = strlen(name);
+
+		if (len == 0 || len >= sizeof(tmp))
+			return NULL;
+
+		suffix = name[len - 1];
+		if (strchr(arch->insn_suffix, suffix) == NULL)
+			return NULL;
+
+		strcpy(tmp, name);
+		tmp[len - 1] = '\0'; /* remove the suffix and check again */
+
+		ins = bsearch(tmp, arch->instructions, nmemb, sizeof(struct ins), ins__key_cmp);
+	}
 	return ins ? ins->ops : NULL;
 }
 
-- 
2.40.1.698.g37aff9b760-goog

