Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775225E6D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIVU42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIVU4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:56:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BA2ABF1D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:56:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id rt12so8548787pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=QYiPAZGQUdjLQ3pC/Y7rWGlodnle4eRBsTkmkurUbzo=;
        b=lqSG5BzEvEvQU7McBt7G4mD1rCaFTU/Kc5I5IVy5RA2IBKHUOKsYh/+wU8uCn58JGV
         p2NvvzXULI/270cBuJo7UCngbrWnlRLns/i4A5xN6fQ5gYVBLroWvafOK4KWmgT+Evtt
         AqUGsh0wz5vPm9kKcu+X4h55wC+l1Syd7nXE6QgmV0JLujXIwvA/13XxG5Qn/LT6ly3B
         jtb2cqsP/WRbnEIWDvIII4d3ApHw1WzDnFkGh7Fo8zTjXkYKHdDvgdAhwDUoA0DY5AVi
         0Y2jECZRqbqNA4ZxO35ehR9BY8aoLks1A1FKPx+53XRYUyeR8GMu0LCtvLUJL+Z5DKUD
         Sacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=QYiPAZGQUdjLQ3pC/Y7rWGlodnle4eRBsTkmkurUbzo=;
        b=cpIREYSEJ5Z1YgnLkOjVbSpSt9u8v6fXYS4CZ4TG0WuNroFFIAIBQnC0NVvRtm/pdT
         A3MjBmlAiEFwXkAtD2d+eh7h4Yd8C5iJN0nXHmkpq1hQM8Nk1A97vkojSMHFS9lDPR/J
         zGgCe23J4dpvwnYF4b+00tdPy9OH6kmbrmzxdIH5uQgmlpjuIWLC9VmQqffKyJ/nNyJv
         ouBSF7VxMVclZxc3XIJVPcNcPGtYtQhYyAzsx3e9iOeAGYsy8lOCWr7wWbgyijMsObwa
         TGhOX5u9mMoQC8f4J9SrT3OZUrNnOcPXBaG/45mWrAigCILpoGqCxdLhPLXvl+1nAWXi
         Gl4Q==
X-Gm-Message-State: ACrzQf3GC18e1aIJwMy4RijSVHx/JlK5BKqhcZzzhrA9rQhaYwBR6Tum
        7ZUULpWTr+kTb0twKLNMbDE=
X-Google-Smtp-Source: AMsMyM7PCv78LN7wMcq4HEuJmZ7Kaj3Nzdprzc8QTqLhOuoeUpzGmwpcicKjya63pDVrjUv/aoey1g==
X-Received: by 2002:a17:90b:4c10:b0:203:bef9:987b with SMTP id na16-20020a17090b4c1000b00203bef9987bmr5720977pjb.9.1663880184497;
        Thu, 22 Sep 2022 13:56:24 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:48bc:f6f4:1035:cf16])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b0016d295888e3sm4479515plh.241.2022.09.22.13.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 13:56:24 -0700 (PDT)
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
Subject: [PATCH] perf: Change the layout of perf_sample_data
Date:   Thu, 22 Sep 2022 13:55:50 -0700
Message-Id: <20220922205550.3094090-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <CAM9d7cgDTy96eeCAARufSKZJFMvAAo6QSLAoEQv_zUFD-Rf+Lw@mail.gmail.com>
References: <CAM9d7cgDTy96eeCAARufSKZJFMvAAo6QSLAoEQv_zUFD-Rf+Lw@mail.gmail.com>
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

With recent change, it can set fields only if it's actually used.
Change the data layout so that it can have commonly used fields together
in a cache line boundary.  The main user (the perf tools) sets the
IP, TID, TIME, PERIOD always.  Also group relevant fields like addr,
phys_addr and data_page_size.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e9b151cde491..8c16dae6e6bb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1023,25 +1023,13 @@ extern u64 perf_event_read_value(struct perf_event *event,
 
 
 struct perf_sample_data {
-	/*
-	 * Fields set by perf_sample_data_init(), group so as to
-	 * minimize the cachelines touched.
-	 */
 	u64				sample_flags;
 	u64				period;
-
+	u64				type;
 	/*
-	 * The other fields, optionally {set,used} by
-	 * perf_{prepare,output}_sample().
+	 * Fields set commonly by perf tools, group so as to
+	 * minimize the cachelines touched.
 	 */
-	struct perf_branch_stack	*br_stack;
-	union perf_sample_weight	weight;
-	union  perf_mem_data_src	data_src;
-	u64				txn;
-	u64				addr;
-	struct perf_raw_record		*raw;
-
-	u64				type;
 	u64				ip;
 	struct {
 		u32	pid;
@@ -1049,22 +1037,33 @@ struct perf_sample_data {
 	}				tid_entry;
 	u64				time;
 	u64				id;
-	u64				stream_id;
 	struct {
 		u32	cpu;
 		u32	reserved;
 	}				cpu_entry;
+
+	/*
+	 * The other fields, optionally {set,used} by
+	 * perf_{prepare,output}_sample().
+	 */
 	struct perf_callchain_entry	*callchain;
-	u64				aux_size;
+	struct perf_raw_record		*raw;
+	struct perf_branch_stack	*br_stack;
+	union perf_sample_weight	weight;
+	union  perf_mem_data_src	data_src;
+	u64				txn;
 
 	struct perf_regs		regs_user;
 	struct perf_regs		regs_intr;
 	u64				stack_user_size;
 
-	u64				phys_addr;
+	u64				stream_id;
 	u64				cgroup;
+	u64				addr;
+	u64				phys_addr;
 	u64				data_page_size;
 	u64				code_page_size;
+	u64				aux_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
-- 
2.37.3.998.g577e59143f-goog

