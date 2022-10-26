Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3738B60E26A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiJZNpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiJZNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:45:10 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E611F635
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:45:07 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13be3ef361dso7588724fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bbm+l4bLeOSRm9s5ha5+XQZbn7pNH2J857qo3gkrOnk=;
        b=B482P0lmAFC4Dhprsr3RMQsvAgFYIrmm2RDv9uP0I2sn0ocXxw+o96FuZi635/Dnda
         QukXRyjWj7vcKMWXX8LoewxfuFafbG8kWwNrq7McerZTRXWS2BrSRxZ+PxLKj+fR+oZS
         mQKR37wmiaLL9Ta47YOhQIDiv7kwDJAQTNYEJJ/kAi+w9k62vARjFTGnIo2H3yjsglE+
         QLQsJeeldb/7mkN+rEdOuoNrXtoxi4KCxt80Oe3r3DH3ub7rZwKDppXn6T97mZq2Xzfd
         oqJNcqkVfbsSd9nYVSOGQpt9VhZnxf5i/6pC427Gr3heqCq8v0i/2mvb809yYLpkyo58
         vkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbm+l4bLeOSRm9s5ha5+XQZbn7pNH2J857qo3gkrOnk=;
        b=vgnNeD4MSGyC7HL7srZ2OYM4EDTOJSNW7eaCXxrjTE5CsmU3fYoa6sIMPKecFTragD
         ImnSBhJUND/VK+QtPE8voBYwnKFncWsOAzeoUVK3yEUuh8Zm2UFqsyik9YCUv0HIaut9
         9MHfAozPEdlzTq4hx4SRUgSCN9uqGBT09N5G7hEYKKrXk/V3pA2m974EAOtJ1m1x9P29
         EA6c73+KV8+joMl1cxs7riYhLGtsS3vPZGdA4wczxqPr1P/PUYjnf39tXfP+lpjBsYob
         o3S8Fm0aLRJeaR/kTukMN6YJM2kQttlrY7G/lbrWxmM6Nge61gmuBCJmi1BPzIYFyezf
         VzaA==
X-Gm-Message-State: ACrzQf3N+4BFbL2e0FV2EknaHWdYRC+3he3phgH+HzGDCWAAp2EvRfOt
        6HqJT+pCv3rexye1PWWHdtBmS8u2L4U=
X-Google-Smtp-Source: AMsMyM5ydkYYXtoMRUwOJDePbAzsC1uRnKFvwFbE7qTkPEyfAL0rRKvWnS3ROZODcaoCtN7bQV/W4g==
X-Received: by 2002:a05:6870:70a6:b0:13c:2cfc:9c6c with SMTP id v38-20020a05687070a600b0013c2cfc9c6cmr968260oae.204.1666791906371;
        Wed, 26 Oct 2022 06:45:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.238.93])
        by smtp.gmail.com with ESMTPSA id b20-20020a05687061d400b0013b1301ce42sm851395oah.47.2022.10.26.06.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:45:06 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B41DF404BE; Wed, 26 Oct 2022 10:45:00 -0300 (-03)
Date:   Wed, 26 Oct 2022 10:45:00 -0300
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1 FYI] tools headers UAPI: Sync linux/perf_event.h with the
 kernel sources
Message-ID: <Y1k53KMdzypmU0WS@kernel.org>
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

There is a kernel patch pending that renames PERF_MEM_LVLNUM_EXTN_MEM to
PERF_MEM_LVLNUM_CXL, tooling this time is ahead of the kernel :-)

This thus partially addresses this perf build warning:

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
 tools/include/uapi/linux/perf_event.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ea6defacc1a7d22d..ccb7f5dad59be96b 100644
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
-- 
2.37.3

