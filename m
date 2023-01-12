Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E666685D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbjALVsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbjALVre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:47:34 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915DA6DBB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:40:22 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c26so10354478pfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JJiMcoWlhZgKB78U5VEVvQdWOzu1ox9DCMJw9an4s8=;
        b=kUvO4oovmAHHSaIoJ2m3MMu7qTo+mucZEpq2qcSyu3sEdW2HrH2rrQ6oAmVESctwp5
         i1Vx3qMpoWOWGqLS5b2DooVkqmswps4vNl+zOWnSXVpiD6sC6fWILS6iWG5+SGPHEy0K
         WP1a/qe6NEewQOfIgjqtHxScWwYQ9XOBAwL8CcTAK1XIDDCsq9UlCLnaw7j7www4RjQ9
         w0Qx/xy1Xqm6pN8vB6jrhrWW0AUTWH590XaDQce6pwQIvPw7W7OkOUEEEz3w09mzaP/2
         MsWlfXtGvcFfO+Al2MrB0WxxosBw7P5OKP8TNBO6YkYPFsxy22nZZKQOVD2JXiREknNl
         wIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4JJiMcoWlhZgKB78U5VEVvQdWOzu1ox9DCMJw9an4s8=;
        b=rpnkH8yLIYcnLieHfGx1DprTpBVHdKZTeZalSGLFXk5o5wamw5pw/8tDuztFelP1PC
         m1ZYPLo0MKDaSWQ1SnxUwBnMOYXvAlJKFrKfAFPo2Vy441zgJUr2EfpLDeW+gnij3ZPj
         haN6HN4vFuE4AsNmgRsbG1iPZE6FPtx8P2zMevU3dWXDle3U21NrL8Ux9AIVi+bGERyn
         YWmGoX22zeersZTB7qRcgLYSJsOXX55wjH5PCYrRXIH8NW7BWvwBg906DwuVPCHOmTCt
         KB2XUyaCqgfprKUTWj6WH2F4owq5OvE4EadD7ejAaapV8GH86Y58Dfoz2bkQ0ahL7P5J
         /ihA==
X-Gm-Message-State: AFqh2kovPSDG03YOiGHJKpjH6UGuEj/IwiyknAYlnQUInKQ18pHPNsRA
        Gzo54z81vP7Hhc0/Uza4aNL4IidDkdA=
X-Google-Smtp-Source: AMrXdXtHDg7+JezyohMyRdwrtxboE7LbL/8+5LdVP47CiHY2iBqXL3dvGwfDDUNyqjtaAea8iTYtaA==
X-Received: by 2002:a05:6a00:896:b0:586:35dd:91c3 with SMTP id q22-20020a056a00089600b0058635dd91c3mr25796905pfj.29.1673559621684;
        Thu, 12 Jan 2023 13:40:21 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b71e:23d4:aa6a:47c0])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm11344605pfl.146.2023.01.12.13.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:40:21 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        x86@kernel.org
Subject: [PATCH 2/8] perf/core: Add perf_sample_save_callchain() helper
Date:   Thu, 12 Jan 2023 13:40:09 -0800
Message-Id: <20230112214015.1014857-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230112214015.1014857-1-namhyung@kernel.org>
References: <20230112214015.1014857-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When it saves the callchain to the perf sample data, it needs to update
the sample flags and the dynamic size.  To make sure this, add the
perf_sample_save_callchain() helper and convert all call sites.

Cc: x86@kernel.org
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/amd/ibs.c  |  6 ++----
 arch/x86/events/intel/ds.c | 12 ++++--------
 include/linux/perf_event.h | 16 +++++++++++++++-
 kernel/events/core.c       | 12 ++----------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index da3f5ebac4e1..417c80bd3274 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1122,10 +1122,8 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	 * recorded as part of interrupt regs. Thus we need to use rip from
 	 * interrupt regs while unwinding call stack.
 	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
-		data.callchain = perf_callchain(event, iregs);
-		data.sample_flags |= PERF_SAMPLE_CALLCHAIN;
-	}
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(&data, event, iregs);
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 6ec326b47e2e..158cf845fc80 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1617,10 +1617,8 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-		data->callchain = perf_callchain(event, iregs);
-		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
-	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(data, event, iregs);
 
 	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
@@ -1795,10 +1793,8 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-		data->callchain = perf_callchain(event, iregs);
-		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
-	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(data, event, iregs);
 
 	*regs = *iregs;
 	/* The ip in basic is EventingIP */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 16b980014449..a9419608402b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1095,6 +1095,8 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 extern u64 perf_event_read_value(struct perf_event *event,
 				 u64 *enabled, u64 *running);
 
+extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
+
 
 struct perf_sample_data {
 	/*
@@ -1167,6 +1169,19 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	}
 }
 
+static inline void perf_sample_save_callchain(struct perf_sample_data *data,
+					      struct perf_event *event,
+					      struct pt_regs *regs)
+{
+	int size = 1;
+
+	data->callchain = perf_callchain(event, regs);
+	size += data->callchain->nr;
+
+	data->dyn_size += size * sizeof(u64);
+	data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+}
+
 /*
  * Clear all bitfields in the perf_branch_entry.
  * The to and from fields are not cleared because they are
@@ -1408,7 +1423,6 @@ extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
-extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8c8de26f04ab..0fba98b9cd65 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7585,16 +7585,8 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
 		data->ip = perf_instruction_pointer(regs);
 
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-		int size = 1;
-
-		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
-			data->callchain = perf_callchain(event, regs);
-
-		size += data->callchain->nr;
-
-		data->dyn_size += size * sizeof(u64);
-	}
+	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(data, event, regs);
 
 	if (sample_type & PERF_SAMPLE_RAW) {
 		struct perf_raw_record *raw = data->raw;
-- 
2.39.0.314.g84b9a713c41-goog

