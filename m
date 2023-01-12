Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05A76685CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjALVsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbjALVrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:47:33 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2693A95BF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:40:21 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i65so11320783pfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nuL0A6b/Cc0UYziUfDk8TnmjwdlAAeWvEhDoJKmGGg=;
        b=h4yPXUpM4r5Qaaf1l3vXl7ZzDwfTEguwSCBWDkCCeXlC7UoH/Hn6Dvbb/QNdZULD3P
         QpmWnNV89arn29Y8fZns3qK1XzdXdf5OS/BjNz/nv3aZU9fggTD01LCl0IP1OAuzLFvR
         iqpyQfB9mrPqy6RgLAw7RCE7xn1tLzfAdlMaBjIK6Fgy0RW9pIdgQF+LccZpOuRoBjFn
         6ymS+Y9Vz42FBpgu24knYF+rAWaXMfIn/Ew8ixRgIHUWavQDR11RejJqUkZ+gP+MVs6Y
         QI7jNerOp3oGBGZSoM5jI68pDWHat25n0KVwuTSSUmLfKjH59KZxPS8NBMNOv27dZzsJ
         JlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6nuL0A6b/Cc0UYziUfDk8TnmjwdlAAeWvEhDoJKmGGg=;
        b=UAstYBxOeR4OCWnRjWXPkOALlEk/EJ5Di5B9VjkDixCCe96Z9ccqn4NVYwayOCXNH7
         rAYwd4XE1YNlxxlrj4QLWpJQLM3HG7PI5Wy96hYu/qOygl2f0TSeASC6iLlg9OTN9VrX
         kXJddvp2wZe/7jLMg1JTGOGDCq/fHrUgkDw1DvH8FTo61QdtSe9gb6vELqi/aoeaLti+
         HO0JYsEleBGhbLCGZX5f2e5MaCCQ6HJk1zBYqCISDuDM3sDXOolha0ggh3SDYpoCMGBI
         Wp7qKYRpG/EP5p7Q+r/U9Hsu3gpyOAA5RCYoF/aiRsmOmDTZrOGHOdsMmPyDwYACmLTZ
         JaOg==
X-Gm-Message-State: AFqh2krmBqL6IOJ7juG5zTdCk7nheKWpFkcLX6QVGlEDG/IwkoR11hTo
        HSj5aPjNwVi9UYRvhozUX6s=
X-Google-Smtp-Source: AMrXdXvx4WDioRI5o5hNOn4FDnQL4K9ysgh6nuiXfKhf2xRQQAe6PjHrcFtj5LSaywE3krabmIfaFw==
X-Received: by 2002:a05:6a00:1d03:b0:580:149a:5650 with SMTP id a3-20020a056a001d0300b00580149a5650mr79037670pfx.22.1673559620511;
        Thu, 12 Jan 2023 13:40:20 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b71e:23d4:aa6a:47c0])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm11344605pfl.146.2023.01.12.13.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:40:20 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH 1/8] perf/core: Save the dynamic parts of sample data size
Date:   Thu, 12 Jan 2023 13:40:08 -0800
Message-Id: <20230112214015.1014857-2-namhyung@kernel.org>
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

The perf sample data can be divided into parts.  The event->header_size
and event->id_header_size keep the static part of the sample data which
is determined by the sample_type flags.

But other parts like CALLCHAIN and BRANCH_STACK are changing dynamically
so it needs to see the actual data.  In preparation of handling repeated
calls for perf_prepare_sample(), it can save the dynamic size to the
perf sample data to avoid the duplicate work.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h |  2 ++
 kernel/events/core.c       | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 03949d017ac9..16b980014449 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1103,6 +1103,7 @@ struct perf_sample_data {
 	 */
 	u64				sample_flags;
 	u64				period;
+	u64				dyn_size;
 
 	/*
 	 * Fields commonly set by __perf_event_header__init_id(),
@@ -1158,6 +1159,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	/* remaining struct members initialized in perf_prepare_sample() */
 	data->sample_flags = PERF_SAMPLE_PERIOD;
 	data->period = period;
+	data->dyn_size = 0;
 
 	if (addr) {
 		data->addr = addr;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index eacc3702654d..8c8de26f04ab 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7593,7 +7593,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 		size += data->callchain->nr;
 
-		header->size += size * sizeof(u64);
+		data->dyn_size += size * sizeof(u64);
 	}
 
 	if (sample_type & PERF_SAMPLE_RAW) {
@@ -7619,7 +7619,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			data->raw = NULL;
 		}
 
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -7631,7 +7631,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += data->br_stack->nr
 			      * sizeof(struct perf_branch_entry);
 		}
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
@@ -7646,7 +7646,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += hweight64(mask) * sizeof(u64);
 		}
 
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & PERF_SAMPLE_STACK_USER) {
@@ -7671,7 +7671,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += sizeof(u64) + stack_size;
 
 		data->stack_user_size = stack_size;
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
@@ -7700,7 +7700,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += hweight64(mask) * sizeof(u64);
 		}
 
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
@@ -7745,8 +7745,11 @@ void perf_prepare_sample(struct perf_event_header *header,
 		size = perf_prepare_sample_aux(event, data, size);
 
 		WARN_ON_ONCE(size + header->size > U16_MAX);
-		header->size += size;
+		data->dyn_size += size + sizeof(u64); /* size above */
 	}
+
+	header->size += data->dyn_size;
+
 	/*
 	 * If you're adding more sample types here, you likely need to do
 	 * something about the overflowing header::size, like repurpose the
-- 
2.39.0.314.g84b9a713c41-goog

