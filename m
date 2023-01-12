Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57966685DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjALVs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbjALVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:47:36 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E231B9F3;
        Thu, 12 Jan 2023 13:40:29 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 20so9371786pfu.13;
        Thu, 12 Jan 2023 13:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFiEc4fnXcWosSJZXgNQt+xQQqIdoE277uZe1x+iaq4=;
        b=bPETWCW5IbBSYQyy6jMD+fldm74bgEgo3vBdHRXKU3fnmlEGP0/eT6B0u73M/2AaA8
         IyHPPe4jHkK0Mqa+tZkgNBza/2P4NC6Gs+eRQbyk/BP4gXjedz4eShGS743BR2XKU8lJ
         o7gjuCg2rtuHjcWL/U75YpXufj1FHXlQWL/oAQtd9HqbWs1Ta3iy7sV184SDWfXKIp/O
         HZvKzFb3XErNYlGNTIkXj6qNYEbh8jGJVIlb6G1Es9Ay7KvwaKzA1h46lFeFd4tuIVFj
         dGu1fC7IMoBpIbuqTqFrL4o6DJZJwAZCPZ4mnJ7Dw6ioHTKeQNCX4V70AMNzlsKPHMD+
         5lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFiEc4fnXcWosSJZXgNQt+xQQqIdoE277uZe1x+iaq4=;
        b=edBeMQHaJQEbrIDYmow1C+o8Gxv77S7kcr0Z02IHyMsZOl+rxQ8Kbj1hwpMt0XX67v
         6mtHCadfLkTfYHmGltT2/52duYYGQB9AAHeryI8vPNRUdw/VzuZp3Kz1YvARsTJcFidl
         yNvCeAGTWGi6j210zynVmuW7CqxZLilP/Q/1v+zPyl+2UeCsWTtvXfVDhohPaXAdkKCL
         l0h1dJEHYq2jMusrpcLcwSQ+EY9vJ9FsvCiwAeiG0Hym03DPoLT9r0MMknRy9uLpk4ue
         lPJ7cSGPB3Cn2CwGiI09WdLt0gV6oSi4z4aS1vUa4+1YK602ygWwVNCrPVqnl8Z0WDOd
         vBRA==
X-Gm-Message-State: AFqh2kqGS4FSTLWzk+Zcj5fJT49UR9K7i8+ULho25kIKhzkGNBVNtzql
        wKv1bbuBOE+sQcyhb/FW6Zc=
X-Google-Smtp-Source: AMrXdXtl1PJTJmv7dZW6vqrL/16Dcpwl/KSf0TEBH/jIL9IX3GY2dpbk9kGVN/lQNfCJ1CQS/Sh6Vw==
X-Received: by 2002:aa7:9732:0:b0:580:d722:10e7 with SMTP id k18-20020aa79732000000b00580d72210e7mr71908290pfg.24.1673559628420;
        Thu, 12 Jan 2023 13:40:28 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b71e:23d4:aa6a:47c0])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm11344605pfl.146.2023.01.12.13.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:40:28 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        linux-s390@vger.kernel.org, x86@kernel.org
Subject: [PATCH 7/8] perf/core: Introduce perf_prepare_header()
Date:   Thu, 12 Jan 2023 13:40:14 -0800
Message-Id: <20230112214015.1014857-8-namhyung@kernel.org>
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

Factor out perf_prepare_header() so that it can call
perf_prepare_sample() without a header if not needed.

Also it checks the filtered_sample_type to avoid duplicate
work when perf_prepare_sample() is called twice (or more).

Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
Suggested-by: Peter Zijlstr <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c |  3 ++-
 arch/x86/events/intel/ds.c      |  3 ++-
 include/linux/perf_event.h      | 16 +++++++++++++-
 kernel/events/core.c            | 38 +++++++++++++++++++++------------
 4 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 332a49965130..fd02f8423243 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -671,7 +671,8 @@ static void cpumsf_output_event_pid(struct perf_event *event,
 	/* Protect callchain buffers, tasks */
 	rcu_read_lock();
 
-	perf_prepare_sample(&header, data, event, regs);
+	perf_prepare_sample(data, event, regs);
+	perf_prepare_header(&header, data, event, regs);
 	if (perf_output_begin(&handle, data, event, header.size))
 		goto out;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 07c8a2cdc3ee..183efa914b99 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -807,7 +807,8 @@ int intel_pmu_drain_bts_buffer(void)
 	 * the sample.
 	 */
 	rcu_read_lock();
-	perf_prepare_sample(&header, &data, event, &regs);
+	perf_prepare_sample(&data, event, &regs);
+	perf_prepare_header(&header, &data, event, &regs);
 
 	if (perf_output_begin(&handle, &data, event,
 			      header.size * (top - base - skip)))
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7db0e9cc2682..d5628a7b5eaa 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1250,6 +1250,17 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 	data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 }
 
+static inline u32 perf_sample_data_size(struct perf_sample_data *data,
+					struct perf_event *event)
+{
+	u32 size = sizeof(struct perf_event_header);
+
+	size += event->header_size + event->id_header_size;
+	size += data->dyn_size;
+
+	return size;
+}
+
 /*
  * Clear all bitfields in the perf_branch_entry.
  * The to and from fields are not cleared because they are
@@ -1271,7 +1282,10 @@ extern void perf_output_sample(struct perf_output_handle *handle,
 			       struct perf_event_header *header,
 			       struct perf_sample_data *data,
 			       struct perf_event *event);
-extern void perf_prepare_sample(struct perf_event_header *header,
+extern void perf_prepare_sample(struct perf_sample_data *data,
+				struct perf_event *event,
+				struct pt_regs *regs);
+extern void perf_prepare_header(struct perf_event_header *header,
 				struct perf_sample_data *data,
 				struct perf_event *event,
 				struct pt_regs *regs);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 127dddd20f93..5c4f3fa3d2b7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7574,20 +7574,13 @@ static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
 	return d * !!(flags & s);
 }
 
-void perf_prepare_sample(struct perf_event_header *header,
-			 struct perf_sample_data *data,
+void perf_prepare_sample(struct perf_sample_data *data,
 			 struct perf_event *event,
 			 struct pt_regs *regs)
 {
 	u64 sample_type = event->attr.sample_type;
 	u64 filtered_sample_type;
 
-	header->type = PERF_RECORD_SAMPLE;
-	header->size = sizeof(*header) + event->header_size + event->id_header_size;
-
-	header->misc = 0;
-	header->misc |= perf_misc_flags(regs);
-
 	/*
 	 * Add the sample flags that are dependent to others.  And clear the
 	 * sample flags that have already been done by the PMU driver.
@@ -7601,6 +7594,12 @@ void perf_prepare_sample(struct perf_event_header *header,
 					   PERF_SAMPLE_REGS_USER);
 	filtered_sample_type &= ~data->sample_flags;
 
+	if (filtered_sample_type == 0) {
+		/* Make sure it has the correct data->type for output */
+		data->type = event->attr.sample_type;
+		return;
+	}
+
 	__perf_event_header__init_id(data, event, filtered_sample_type);
 	data->sample_flags |= sample_type & PERF_SAMPLE_ID_ALL;
 
@@ -7653,9 +7652,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 		 * up the rest of the sample size.
 		 */
 		u16 stack_size = event->attr.sample_stack_user;
+		u16 header_size = perf_sample_data_size(data, event);
 		u16 size = sizeof(u64);
 
-		stack_size = perf_sample_ustack_size(stack_size, header->size,
+		stack_size = perf_sample_ustack_size(stack_size, header_size,
 						     data->regs_user.regs);
 
 		/*
@@ -7740,8 +7740,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (filtered_sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
+		u16 header_size = perf_sample_data_size(data, event);
 
-		header->size += sizeof(u64); /* size */
+		header_size += sizeof(u64); /* size */
 
 		/*
 		 * Given the 16bit nature of header::size, an AUX sample can
@@ -7749,17 +7750,25 @@ void perf_prepare_sample(struct perf_event_header *header,
 		 * Make sure this doesn't happen by using up to U16_MAX bytes
 		 * per sample in total (rounded down to 8 byte boundary).
 		 */
-		size = min_t(size_t, U16_MAX - header->size,
+		size = min_t(size_t, U16_MAX - header_size,
 			     event->attr.aux_sample_size);
 		size = rounddown(size, 8);
 		size = perf_prepare_sample_aux(event, data, size);
 
-		WARN_ON_ONCE(size + header->size > U16_MAX);
+		WARN_ON_ONCE(size + header_size > U16_MAX);
 		data->dyn_size += size + sizeof(u64); /* size above */
 		data->sample_flags |= PERF_SAMPLE_AUX;
 	}
+}
 
-	header->size += data->dyn_size;
+void perf_prepare_header(struct perf_event_header *header,
+			 struct perf_sample_data *data,
+			 struct perf_event *event,
+			 struct pt_regs *regs)
+{
+	header->type = PERF_RECORD_SAMPLE;
+	header->size = perf_sample_data_size(data, event);
+	header->misc = perf_misc_flags(regs);
 
 	/*
 	 * If you're adding more sample types here, you likely need to do
@@ -7788,7 +7797,8 @@ __perf_event_output(struct perf_event *event,
 	/* protect the callchain buffers */
 	rcu_read_lock();
 
-	perf_prepare_sample(&header, data, event, regs);
+	perf_prepare_sample(data, event, regs);
+	perf_prepare_header(&header, data, event, regs);
 
 	err = output_begin(&handle, data, event, header.size);
 	if (err)
-- 
2.39.0.314.g84b9a713c41-goog

