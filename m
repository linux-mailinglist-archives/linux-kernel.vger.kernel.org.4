Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8715E5602
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiIUWAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIUWAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:00:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3EE9F191
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:00:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p18so6990195plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=LOBnyRZinL+mvNsZ0ir5iBTMS0UFXibMLgUWm8nGILY=;
        b=Cubklnkzo/KeKdYwjDV1MSHt/IosQdqyNAYGjaBcA/XnTAQc5lOrX6H/p5yodpKPuw
         c21KbUu1gSuX3bkxEc91A9o3R8Jh6bHlWuZH0/LAKwao7b+exHy2RSAminYfjh7rJwAb
         sMFvdGILxH9gfORxK4aT04MUhc5GNHmOmlmJKQhIWX3p5wdQZX/pqi5RydAnbTFEzQ/y
         /a6eN7vlw9K2vze4+wf0Qtkr7z0a9h2V6tWxUAymVVlvtkaMf+8VH9/MTiK8QAY+0fWq
         RHO0X+ppF0DqktUHZEz3whXwaodW+yzvIIydiChXC4z7p3trP0Wo25BZaICts2u4hd8/
         U3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=LOBnyRZinL+mvNsZ0ir5iBTMS0UFXibMLgUWm8nGILY=;
        b=sp0y513++wDiZxvxTefnqQWbLadksvRy38hAuZeNecCTgluKD5RDN3gHwy/B/V6ALu
         jtqM6vvs/uhd4mrFgXr/gMnklymzPXXu46b9YLPs+vnQ9Ro+sNr0WI7KPrLvUu/k4xEX
         VUWnj4rPsEOSMF6/5R3U9zf5DdQ0FCroZx5HqcJ2zqwQwH5rKmVb6GhlSBMr5bxZKYld
         ZPrRnj3NJ7NKo0siqZesPpi6v1etYOEc2K1M9Alt8EBGd9ElGszp52eYlUtwdxMZRKLd
         JJXEaLDLi/2C46SYGSdFhrZF5mK3axWKnheckfh39qv2A7Bm9gppYgl81ze8mqcTcCPG
         gidw==
X-Gm-Message-State: ACrzQf2fi1lqIq3DGmESNepc35TMmKJPNF1PhVLsOA5boJfg8Ohq7H1T
        vOQdbpNNt2n42x83iqqdbQc=
X-Google-Smtp-Source: AMsMyM71iXfrr1a3S03hPCOX0xb8uf8XF1HOBW6IwFey80H7/rkIpMZqmYcp50D4CI6vcTkXg8He6Q==
X-Received: by 2002:a17:90a:df90:b0:203:41e1:36db with SMTP id p16-20020a17090adf9000b0020341e136dbmr280293pjv.8.1663797642111;
        Wed, 21 Sep 2022 15:00:42 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:8bcd:ba5c:3c6b:4140])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090300d400b0017693722e7dsm2520554plc.6.2022.09.21.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:00:41 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf: Use sample_flags for raw_data
Date:   Wed, 21 Sep 2022 15:00:32 -0700
Message-Id: <20220921220032.2858517-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220921220032.2858517-1-namhyung@kernel.org>
References: <20220921220032.2858517-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new sample_flags to indicate whether the raw data field is
filled by the PMU driver.  Although it could check with the NULL,
follow the same rule with other fields.

Remove the raw field from the perf_sample_data_init() to minimize
the number of cache lines touched.

Cc: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/s390/kernel/perf_cpum_cf.c    | 1 +
 arch/s390/kernel/perf_pai_crypto.c | 1 +
 arch/x86/events/amd/ibs.c          | 1 +
 include/linux/perf_event.h         | 5 ++---
 kernel/events/core.c               | 3 ++-
 5 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index f7dd3c849e68..f043a7ff220b 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -664,6 +664,7 @@ static int cfdiag_push_sample(struct perf_event *event,
 		raw.frag.data = cpuhw->stop;
 		raw.size = raw.frag.size;
 		data.raw = &raw;
+		data.sample_flags |= PERF_SAMPLE_RAW;
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index b38b4ae01589..6826e2a69a21 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -366,6 +366,7 @@ static int paicrypt_push_sample(void)
 		raw.frag.data = cpump->save;
 		raw.size = raw.frag.size;
 		data.raw = &raw;
+		data.sample_flags |= PERF_SAMPLE_RAW;
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index ce5720bfb350..c29a006954c7 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -781,6 +781,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 			},
 		};
 		data.raw = &raw;
+		data.sample_flags |= PERF_SAMPLE_RAW;
 	}
 
 	/*
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f4a13579b0e8..e9b151cde491 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1028,7 +1028,6 @@ struct perf_sample_data {
 	 * minimize the cachelines touched.
 	 */
 	u64				sample_flags;
-	struct perf_raw_record		*raw;
 	u64				period;
 
 	/*
@@ -1040,6 +1039,7 @@ struct perf_sample_data {
 	union  perf_mem_data_src	data_src;
 	u64				txn;
 	u64				addr;
+	struct perf_raw_record		*raw;
 
 	u64				type;
 	u64				ip;
@@ -1078,8 +1078,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 					 u64 addr, u64 period)
 {
 	/* remaining struct members initialized in perf_prepare_sample() */
-	data->sample_flags = 0;
-	data->raw  = NULL;
+	data->sample_flags = PERF_SAMPLE_PERIOD;
 	data->period = period;
 
 	if (addr) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a91f74db9fe9..04e19a857d4b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7332,7 +7332,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 		struct perf_raw_record *raw = data->raw;
 		int size;
 
-		if (raw) {
+		if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
 			struct perf_raw_frag *frag = &raw->frag;
 			u32 sum = 0;
 
@@ -7348,6 +7348,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			frag->pad = raw->size - sum;
 		} else {
 			size = sizeof(u64);
+			data->raw = NULL;
 		}
 
 		header->size += size;
-- 
2.37.3.968.ga6b4b080e4-goog

