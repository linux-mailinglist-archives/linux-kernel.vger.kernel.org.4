Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CD56B5B21
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjCKL1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCKL0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:26:52 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D33912CCB;
        Sat, 11 Mar 2023 03:22:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nn12so7672225pjb.5;
        Sat, 11 Mar 2023 03:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678533737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ3pWdzvgyzFWwehYnV2owVmjn0zg/w4S967lskCtEY=;
        b=o9by0IefuLncZNR0lGzGGkYmV3tCLpct/VIqyysUdtMMmijUXRXVvYczYF19jx4w/9
         3P6Wph9/uqDRVkssg8IcDPd0N1cNPDcjXEdXGSMl62MwpYHv5MnmyQdaxrI8G244b8G9
         mIL82j60RuLTahi1ij14+rGMY02lmqKmUx/2FGa5at0nQjiL1b/oUqtsvgVkpYvyZfzU
         lUTJUpaW0OyZQvg3OkSIPqpshIzG+8OL2wcZaKE2R8/gpC+bbnUj7jNBfKrePZSJsswO
         8BPGWMynCzdEmSqGxS4gbYJJcbQmU6XO1TYIUsoghWSJkre2IZIvDaX9DAbifYkeW5IA
         CWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQ3pWdzvgyzFWwehYnV2owVmjn0zg/w4S967lskCtEY=;
        b=bVEYXMBr1Uj/geDWdRoOzJQaHzixFAqDCJPDQRaJbdlhDp7iQnPn32U2WMUweF3Yrf
         GqfvMozhnhrHltHKTRYHzrzURLF/EH87ClbBC1jgWROl+w9OTOhL/uAyDTOXpFIJzaja
         y9DDUvoX4F3vTkrp2wcdR4VA7qtBpg1pmNBxbAf5e2MlXb2rLjUxmcK6BM97DBAUrGuJ
         Sor7gUnsBO6fETmDO4+x7t+PJm0b5oEn49LMoUAVjvSdV5MEqtdyURC61t+Dq/d3PPG6
         V7WN8VO4jRXayrQXamR3iB5X8g7sH9jX9jdZhBlOIRuRqE3sSc0qhORfwNmD/r9qflDs
         JUUg==
X-Gm-Message-State: AO0yUKUH2l5ArJr1C5ZP1s3VmjX3NIN1mKHVDb7KVwgtLVqQRyAdxsmK
        Nftgyd3c+LChk/Pjy9RM7nReKIn9ul7aO3G4
X-Google-Smtp-Source: AK7set+2yemjXIhufbiQIUZV+/nrTJ6zdAlrOSUpszmESQ+sgDlwA8YkmZRJZG9bi+ACHzp79Mr3Mw==
X-Received: by 2002:a17:903:230e:b0:19c:b4e3:c660 with SMTP id d14-20020a170903230e00b0019cb4e3c660mr32223340plh.47.1678533736916;
        Sat, 11 Mar 2023 03:22:16 -0800 (PST)
Received: from kim-GL702ZC.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id ls8-20020a17090b350800b002367325203fsm1326941pjb.50.2023.03.11.03.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:22:16 -0800 (PST)
From:   paranlee <p4ranlee@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, paranlee <p4ranlee@gmail.com>
Subject: [PATCH] perf tools riscv: Add support for riscv lookup_binutils_path
Date:   Sat, 11 Mar 2023 20:21:22 +0900
Message-Id: <20230311112122.28894-1-p4ranlee@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add to know RISC-V binutils path.
Secondarily, edit the code block with alphabetical order.

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 tools/perf/arch/common.c | 51 +++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 59dd875fd5e4..058527ededdd 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -29,11 +29,23 @@ const char *const arm_triplets[] = {
 };
 
 const char *const arm64_triplets[] = {
+	"aarch64-unknown-linux-",
 	"aarch64-linux-android-",
 	"aarch64-linux-gnu-",
 	NULL
 };
 
+const char *const mips_triplets[] = {
+	"mips-unknown-linux-gnu-",
+	"mipsel-linux-android-",
+	"mips-linux-gnu-",
+	"mips64-linux-gnu-",
+	"mips64el-linux-gnuabi64-",
+	"mips64-linux-gnuabi64-",
+	"mipsel-linux-gnu-",
+	NULL
+};
+
 const char *const powerpc_triplets[] = {
 	"powerpc-unknown-linux-gnu-",
 	"powerpc-linux-gnu-",
@@ -43,6 +55,20 @@ const char *const powerpc_triplets[] = {
 	NULL
 };
 
+const char *const riscv32_triplets[] = {
+	"riscv32-unknown-linux-gnu-",
+	"riscv32-linux-android-",
+	"riscv32-linux-gnu-",
+	NULL
+};
+
+const char *const riscv64_triplets[] = {
+	"riscv64-unknown-linux-gnu-",
+	"riscv64-linux-android-",
+	"riscv64-linux-gnu-",
+	NULL
+};
+
 const char *const s390_triplets[] = {
 	"s390-ibm-linux-",
 	"s390x-linux-gnu-",
@@ -78,17 +104,6 @@ const char *const x86_triplets[] = {
 	NULL
 };
 
-const char *const mips_triplets[] = {
-	"mips-unknown-linux-gnu-",
-	"mipsel-linux-android-",
-	"mips-linux-gnu-",
-	"mips64-linux-gnu-",
-	"mips64el-linux-gnuabi64-",
-	"mips64-linux-gnuabi64-",
-	"mipsel-linux-gnu-",
-	NULL
-};
-
 static bool lookup_path(char *name)
 {
 	bool found = false;
@@ -164,18 +179,22 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		path_list = arm_triplets;
 	else if (!strcmp(arch, "arm64"))
 		path_list = arm64_triplets;
+	else if (!strcmp(arch, "mips"))
+		path_list = mips_triplets;
 	else if (!strcmp(arch, "powerpc"))
 		path_list = powerpc_triplets;
-	else if (!strcmp(arch, "sh"))
-		path_list = sh_triplets;
+	else if (!strcmp(arch, "riscv32"))
+		path_list = riscv32_triplets;
+	else if (!strcmp(arch, "riscv64"))
+		path_list = riscv64_triplets;
 	else if (!strcmp(arch, "s390"))
-		path_list = s390_triplets;
+		path_list = s390_triplets;		
+	else if (!strcmp(arch, "sh"))
+		path_list = sh_triplets;		
 	else if (!strcmp(arch, "sparc"))
 		path_list = sparc_triplets;
 	else if (!strcmp(arch, "x86"))
 		path_list = x86_triplets;
-	else if (!strcmp(arch, "mips"))
-		path_list = mips_triplets;
 	else {
 		ui__error("binutils for %s not supported.\n", arch);
 		goto out_error;
-- 
2.34.1

