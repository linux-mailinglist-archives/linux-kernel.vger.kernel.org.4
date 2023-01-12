Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A76685D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbjALVso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbjALVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:47:36 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD34834D77
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:40:26 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g68so12597896pgc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvGUMU//A5tX7oB/uY4gCyETkJGZoTtytTEaxGlNFkw=;
        b=DbtSTDgDJTxKl+2n9fo09NLB/opC1JK/LEyqOK7lOQJv64J2oR1FoFfaFVtpS1s2/l
         wQSna2mI4B2LnQ8fuwmbeuHxnQQxpgdpQDHk3TSPSpd8LspQPFAQkHRubGw2Et/VbJGX
         MJJIA99ZwD4ZDb9hYQbjLlegbF54V93r0KFNykKo93ysNzjvUdjTeIs9ihmDy0yonkYv
         0mnqYlRg87mYWV+N5Hgu3e2cCN4kmdosUGtjoENP0LtvK12aI1MUDYXhpR4YPK1zlSRV
         YFZS3MYhwbjeBIVoUvWrG8auaWZNmjYiQpvZvNb/LiVUZoQ+hmycMCeP0Haj2e75WQ6x
         dDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jvGUMU//A5tX7oB/uY4gCyETkJGZoTtytTEaxGlNFkw=;
        b=KfV857IvupEjxmyx9IOqdR5Eq1MpZljaeMiKv3KEXGp0o4iFd7gC6pn0EQ1OHlvNpx
         9yJo6/xHHWW4lllHsibv0j4npt/cLUjXIaAuaQ1EUlZY4nS8dQGHrG9rhP9zUL1AL+un
         zRamAAN81lKBT1QCnWde4s1Ux5BvhXMiSudulxoZ5eF+AEg7HWkQQKZRXKOx6Fch//c+
         TTd97ThglJWVmwB+LHNjpxEh394xED1Pmpv5xAjryJx4iT8tETu61RTA/I8KtkWD22P7
         FktrEGDvbGRjSuWPXdRR9R4gPYJh2IYfg8UNm/ro7CAuo6zNfKgpp6GiPzSIBF83nCKV
         wV9w==
X-Gm-Message-State: AFqh2krgBehD8mn90laFjE7WrAuT/jxRQ0GiKEkjMJIe63eL/iDIjT0B
        LJK70kVgEC7S7lByEoGodU2uv6TWSO4=
X-Google-Smtp-Source: AMrXdXsfThK2Y6hcx1q0xA48Ay4pI+LKm8bJVZEP8KFQnDyakled3nsmI4jkyiU7SMXVMnpEcmoPOQ==
X-Received: by 2002:a62:6d07:0:b0:581:b3f4:21f8 with SMTP id i7-20020a626d07000000b00581b3f421f8mr49054158pfc.31.1673559626075;
        Thu, 12 Jan 2023 13:40:26 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b71e:23d4:aa6a:47c0])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm11344605pfl.146.2023.01.12.13.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:40:25 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH 5/8] perf/core: Set data->sample_flags in perf_prepare_sample()
Date:   Thu, 12 Jan 2023 13:40:12 -0800
Message-Id: <20230112214015.1014857-6-namhyung@kernel.org>
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

The perf_prepare_sample() sets the perf_sample_data according to the
attr->sample_type before copying it to the ring buffer.  But BPF also
wants to access the sample data so it needs to prepare the sample even
before the regular path.

That means the perf_prepare_sample() can be called more than once.  Set
the data->sample_flags consistently so that it can indicate which fields
are set already and skip them if sets.

Also update the filtered_sample_type to have the dependent flags to
reduce the number of branches.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 85 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 20 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0218b6ffaf36..7c5555051662 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7053,6 +7053,14 @@ static void perf_aux_sample_output(struct perf_event *event,
 	ring_buffer_put(rb);
 }
 
+/*
+ * A set of common sample data types saved even for non-sample records
+ * when event->attr.sample_id_all is set.
+ */
+#define PERF_SAMPLE_ID_ALL  (PERF_SAMPLE_TID | PERF_SAMPLE_TIME |	\
+			     PERF_SAMPLE_CPU | PERF_SAMPLE_ID |		\
+			     PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_STREAM_ID)
+
 static void __perf_event_header__init_id(struct perf_event_header *header,
 					 struct perf_sample_data *data,
 					 struct perf_event *event,
@@ -7561,6 +7569,11 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	return callchain ?: &__empty_callchain;
 }
 
+static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
+{
+	return d * !!(flags & s);
+}
+
 void perf_prepare_sample(struct perf_event_header *header,
 			 struct perf_sample_data *data,
 			 struct perf_event *event,
@@ -7576,14 +7589,25 @@ void perf_prepare_sample(struct perf_event_header *header,
 	header->misc |= perf_misc_flags(regs);
 
 	/*
-	 * Clear the sample flags that have already been done by the
-	 * PMU driver.
+	 * Add the sample flags that are dependent to others.  And clear the
+	 * sample flags that have already been done by the PMU driver.
 	 */
-	filtered_sample_type = sample_type & ~data->sample_flags;
+	filtered_sample_type = sample_type;
+	filtered_sample_type |= __cond_set(sample_type, PERF_SAMPLE_CODE_PAGE_SIZE,
+					   PERF_SAMPLE_IP);
+	filtered_sample_type |= __cond_set(sample_type, PERF_SAMPLE_DATA_PAGE_SIZE |
+					   PERF_SAMPLE_PHYS_ADDR, PERF_SAMPLE_ADDR);
+	filtered_sample_type |= __cond_set(sample_type, PERF_SAMPLE_STACK_USER,
+					   PERF_SAMPLE_REGS_USER);
+	filtered_sample_type &= ~data->sample_flags;
+
 	__perf_event_header__init_id(header, data, event, filtered_sample_type);
+	data->sample_flags |= sample_type & PERF_SAMPLE_ID_ALL;
 
-	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
+	if (filtered_sample_type & PERF_SAMPLE_IP) {
 		data->ip = perf_instruction_pointer(regs);
+		data->sample_flags |= PERF_SAMPLE_IP;
+	}
 
 	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
 		perf_sample_save_callchain(data, event, regs);
@@ -7600,10 +7624,15 @@ void perf_prepare_sample(struct perf_event_header *header,
 		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 	}
 
-	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
+	if (filtered_sample_type & PERF_SAMPLE_REGS_USER)
 		perf_sample_regs_user(&data->regs_user, regs);
 
-	if (sample_type & PERF_SAMPLE_REGS_USER) {
+	/*
+	 * It cannot use the filtered_sample_type here as REGS_USER can be set
+	 * by STACK_USER (using __cond_set() above) and we don't want to update
+	 * the dyn_size if it's not requested by users.
+	 */
+	if ((sample_type & ~data->sample_flags) & PERF_SAMPLE_REGS_USER) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
@@ -7613,9 +7642,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 		}
 
 		data->dyn_size += size;
+		data->sample_flags |= PERF_SAMPLE_REGS_USER;
 	}
 
-	if (sample_type & PERF_SAMPLE_STACK_USER) {
+	if (filtered_sample_type & PERF_SAMPLE_STACK_USER) {
 		/*
 		 * Either we need PERF_SAMPLE_STACK_USER bit to be always
 		 * processed as the last one or have additional check added
@@ -7638,23 +7668,30 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 		data->stack_user_size = stack_size;
 		data->dyn_size += size;
+		data->sample_flags |= PERF_SAMPLE_STACK_USER;
 	}
 
-	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
 		data->weight.full = 0;
+		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+	}
 
-	if (filtered_sample_type & PERF_SAMPLE_DATA_SRC)
+	if (filtered_sample_type & PERF_SAMPLE_DATA_SRC) {
 		data->data_src.val = PERF_MEM_NA;
+		data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+	}
 
-	if (filtered_sample_type & PERF_SAMPLE_TRANSACTION)
+	if (filtered_sample_type & PERF_SAMPLE_TRANSACTION) {
 		data->txn = 0;
+		data->sample_flags |= PERF_SAMPLE_TRANSACTION;
+	}
 
-	if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_DATA_PAGE_SIZE)) {
-		if (filtered_sample_type & PERF_SAMPLE_ADDR)
-			data->addr = 0;
+	if (filtered_sample_type & PERF_SAMPLE_ADDR) {
+		data->addr = 0;
+		data->sample_flags |= PERF_SAMPLE_ADDR;
 	}
 
-	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+	if (filtered_sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
@@ -7667,19 +7704,22 @@ void perf_prepare_sample(struct perf_event_header *header,
 		}
 
 		data->dyn_size += size;
+		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
 	}
 
-	if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
-	    filtered_sample_type & PERF_SAMPLE_PHYS_ADDR)
+	if (filtered_sample_type & PERF_SAMPLE_PHYS_ADDR) {
 		data->phys_addr = perf_virt_to_phys(data->addr);
+		data->sample_flags |= PERF_SAMPLE_PHYS_ADDR;
+	}
 
 #ifdef CONFIG_CGROUP_PERF
-	if (sample_type & PERF_SAMPLE_CGROUP) {
+	if (filtered_sample_type & PERF_SAMPLE_CGROUP) {
 		struct cgroup *cgrp;
 
 		/* protected by RCU */
 		cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
 		data->cgroup = cgroup_id(cgrp);
+		data->sample_flags |= PERF_SAMPLE_CGROUP;
 	}
 #endif
 
@@ -7688,13 +7728,17 @@ void perf_prepare_sample(struct perf_event_header *header,
 	 * require PERF_SAMPLE_ADDR, kernel implicitly retrieve the data->addr,
 	 * but the value will not dump to the userspace.
 	 */
-	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+	if (filtered_sample_type & PERF_SAMPLE_DATA_PAGE_SIZE) {
 		data->data_page_size = perf_get_page_size(data->addr);
+		data->sample_flags |= PERF_SAMPLE_DATA_PAGE_SIZE;
+	}
 
-	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+	if (filtered_sample_type & PERF_SAMPLE_CODE_PAGE_SIZE) {
 		data->code_page_size = perf_get_page_size(data->ip);
+		data->sample_flags |= PERF_SAMPLE_CODE_PAGE_SIZE;
+	}
 
-	if (sample_type & PERF_SAMPLE_AUX) {
+	if (filtered_sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
 		header->size += sizeof(u64); /* size */
@@ -7712,6 +7756,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 		WARN_ON_ONCE(size + header->size > U16_MAX);
 		data->dyn_size += size + sizeof(u64); /* size above */
+		data->sample_flags |= PERF_SAMPLE_AUX;
 	}
 
 	header->size += data->dyn_size;
-- 
2.39.0.314.g84b9a713c41-goog

