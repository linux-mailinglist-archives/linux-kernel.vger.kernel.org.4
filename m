Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9010F60D52C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiJYUFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiJYUFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:05:00 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4769D13DDA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:04:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 101-20020a9d0bee000000b00661b54d945fso8478479oth.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frsfVVx8zXf3o96Jbso4m6xBby4czlce4kMSbWIXkR4=;
        b=XSvauMEQNygAEYmYClNfj8XEB0JbKsoQEKVStKRpgvkjV/7J3/AQEjOvE7unchMS+W
         Hxpjyz/DGoPEPEV2cCkUeo7pCbXWvHAXDsr1bsJyjWqDGIb7xtet/MlKBvYF/Js8+HHP
         cpDdbYd12oI33rzTZRjPfFXw8AcLDeNWbK4amBAZBpvxsQdy9YyFoUc8GGyJfqhArM2A
         aAj6XACik1EUJASYz/94U6zSdp9D3aOme6AYbRCZkOSDAysEY5EvTQc2+f0+JoAhiT0G
         avxPIrcf6yWjqnlrujXEkpruv9MVC4sr3THS8Y8kxAZXwgkUX0w+SK9FkkD93C0cBDwS
         lV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frsfVVx8zXf3o96Jbso4m6xBby4czlce4kMSbWIXkR4=;
        b=hC9yH1DYT9RXD5bErKeO2yxq2LaZB5oc+udTwXXDbC/u1o2Ie8XVKtmxe/NrbqJ6DY
         cbvajLeGGgonXlix6v+i0aOkkXWebquL4K1v/6UfLDbX2UYxJI9jAmYInwGT98OasEnv
         3EsOQ2jw89HphgK1e8tBqwA7uW1dFWh/d36CsZdyJpSq8mKQ5P8yulcMwfnz5kQIsf8L
         gReOFmaKYF1YJV4UFXE+SPbIXu+dZvNth2vipJxGPPZW+cSCpS0HZL+P+IBMVZLtqPC0
         9wkTZHOXdypw1RBNrc4Q3QSAFnjASsoLBa+AuHx35tHXotSKeAIDkRYnoINRloBChJ0n
         6mYA==
X-Gm-Message-State: ACrzQf1Vq5qk00n0lq2Bmir05OsXZ+LnQ0nVm1vSN2s2M4qODsMbVmc9
        3XOE/cd7L7UQKhY65Ebw/E+LyK2gLwc=
X-Google-Smtp-Source: AMsMyM6phoK4AnY1DukI2sTWyxmFn5KoJk0jC40irxOYNVhjp5Dmb7j8KtJwgkPfnftuXRsfLUdr+g==
X-Received: by 2002:a9d:5e8b:0:b0:661:d7f8:171c with SMTP id f11-20020a9d5e8b000000b00661d7f8171cmr20405565otl.130.1666728294540;
        Tue, 25 Oct 2022 13:04:54 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.238.93])
        by smtp.gmail.com with ESMTPSA id ep2-20020a056870a98200b0013ae5246449sm2074862oab.22.2022.10.25.13.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 13:04:53 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E0B2404BE; Tue, 25 Oct 2022 17:04:51 -0300 (-03)
Date:   Tue, 25 Oct 2022 17:04:51 -0300
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1 FYI] tools headers UAPI: Sync linux/perf_event.h with the
 kernel sources
Message-ID: <Y1hBY+51vpyERSrZ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pick the changes in:

  cfef80bad4cf79cd ("perf/uapi: Define PERF_MEM_SNOOPX_PEER in kernel header file")
  ee3e88dfec23153d ("perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}")
  b4e12b2d70fd9ecc ("perf: Kill __PERF_SAMPLE_CALLCHAIN_EARLY")

A previous sync:

  b7ddd38ccc723f0d ("tools headers UAPI: Sync include/uapi/linux/perf_event.h header with the kernel")

brought a PERF_MEM_LVLNUM_CXL, and used it in
tools/perf/util/mem-events.c, but when the feature really hit the kernel
that define had been renamed to PERF_MEM_LVLNUM_EXTN_MEM, so reflect
that on the tooling side.

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
  diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 29 ++++++++++++++++++---------
 tools/perf/util/mem-events.c          |  2 +-
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ea6defacc1a7d22d..85be78e0e7f654c8 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -164,8 +164,6 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
 
 	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
-
-	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
@@ -263,6 +261,17 @@ enum {
 	PERF_BR_MAX,
 };
 
+/*
+ * Common branch speculation outcome classification
+ */
+enum {
+	PERF_BR_SPEC_NA			= 0,	/* Not available */
+	PERF_BR_SPEC_WRONG_PATH		= 1,	/* Speculative but on wrong path */
+	PERF_BR_NON_SPEC_CORRECT_PATH	= 2,	/* Non-speculative but on correct path */
+	PERF_BR_SPEC_CORRECT_PATH	= 3,	/* Speculative and on correct path */
+	PERF_BR_SPEC_MAX,
+};
+
 enum {
 	PERF_BR_NEW_FAULT_ALGN		= 0,    /* Alignment fault */
 	PERF_BR_NEW_FAULT_DATA		= 1,    /* Data fault */
@@ -282,11 +291,11 @@ enum {
 	PERF_BR_PRIV_HV		= 3,
 };
 
-#define PERF_BR_ARM64_FIQ              PERF_BR_NEW_ARCH_1
-#define PERF_BR_ARM64_DEBUG_HALT       PERF_BR_NEW_ARCH_2
-#define PERF_BR_ARM64_DEBUG_EXIT       PERF_BR_NEW_ARCH_3
-#define PERF_BR_ARM64_DEBUG_INST       PERF_BR_NEW_ARCH_4
-#define PERF_BR_ARM64_DEBUG_DATA       PERF_BR_NEW_ARCH_5
+#define PERF_BR_ARM64_FIQ		PERF_BR_NEW_ARCH_1
+#define PERF_BR_ARM64_DEBUG_HALT	PERF_BR_NEW_ARCH_2
+#define PERF_BR_ARM64_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
+#define PERF_BR_ARM64_DEBUG_INST	PERF_BR_NEW_ARCH_4
+#define PERF_BR_ARM64_DEBUG_DATA	PERF_BR_NEW_ARCH_5
 
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
@@ -1328,7 +1337,7 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
 /* 5-0x8 available */
-#define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
+#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
 #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
 #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
@@ -1397,6 +1406,7 @@ union perf_mem_data_src {
  *     abort: aborting a hardware transaction
  *    cycles: cycles from last branch (or 0 if not supported)
  *      type: branch type
+ *      spec: branch speculation info (or 0 if not supported)
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1407,9 +1417,10 @@ struct perf_branch_entry {
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
 		type:4,     /* branch type */
+		spec:2,     /* branch speculation info */
 		new_type:4, /* additional branch type */
 		priv:3,     /* privilege level */
-		reserved:33;
+		reserved:31;
 };
 
 union perf_sample_weight {
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index b3a91093069a5715..c80fce18025051ae 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -295,7 +295,7 @@ static const char * const mem_lvl[] = {
 };
 
 static const char * const mem_lvlnum[] = {
-	[PERF_MEM_LVLNUM_CXL] = "CXL",
+	[PERF_MEM_LVLNUM_EXTN_MEM] = "Extension mem",
 	[PERF_MEM_LVLNUM_IO] = "I/O",
 	[PERF_MEM_LVLNUM_ANY_CACHE] = "Any cache",
 	[PERF_MEM_LVLNUM_LFB] = "LFB/MAB",
-- 
2.37.3

