Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F8729EEC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbjFIPno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbjFIPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:43:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D603AAF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:43:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso780356a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686325393; x=1688917393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YcNWElfzuHmvHEteOQOaYn8quGWbB0S6G/IrszP+gtw=;
        b=EZoxjoT+sbbWXFq3ckovd0SjjsIzQf7/P4/ZOBrkvYIMDFJNw3/gcOEBFqgWQMDDo2
         iynJdjNid1Kpt6yfFROS3fcMtu5y22Sf5FXHCPvPYkWauaXg6jTTof3LEEurXDJOJNmw
         /FQRBK9niUZla8tVcfBy3xoX5JppoQuPJ8mTSGuo/8znup40G/tVUkpg6X9Q2H3/J6WB
         DDCVAzycCzL1m5bHECPmK5Posa35NDttHJ4E+KtRE2t5m+HMxkjDpsliYgaspTU/ZKo1
         FDib+kXivtdTaJSd5yvEB+CRB278/Au/D5a1Z/OClkFTnPZEYphcs9T3l1BAIQrItYlr
         Nf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325393; x=1688917393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcNWElfzuHmvHEteOQOaYn8quGWbB0S6G/IrszP+gtw=;
        b=WQz8ibtyA4B5YIzO5czWoSCxl4oeCRK9C2BQTfPaFGn6GCTfsv0+d0eKLERCCwROix
         KlOAXQWI4RaMvsRjAnVKBONnUbIoFmLO0MvrlE55oNn3SxYnP32VyLKQyR5mEr5X/fEd
         WoDMetqoweNRbhH0OVvUUsh+5lTet4pbozE/D3v4epr1E/wOCKo0kv+d8D1+2KYMTsm7
         W0zx7X+RKc8/iQS86BXnusXaL4u7uZDszFS5Ab/WMvM6uAOID0xSvnTYyUMVPDj52+6M
         K4jTnssovcgQjbNAzJMODOpgBW4MXK4FajEXQijJ3CRepkQoRTeBVOGNfGdhDNCo8yns
         HQZg==
X-Gm-Message-State: AC+VfDyXvE2tKR8aG/1hFgMD+EhExm8actFSs2ziBuTSdRX7lw4b300q
        5wFhv9NyxkcAI5nbPQGTUwjS0ro0Qdc=
X-Google-Smtp-Source: ACHHUZ6FMnkvQP5CRedHYI1o4NMqL8GmK1nI3K7sungBEl2uIce9FxWCtql5/aYEW/UqUVGmz2YxUQ==
X-Received: by 2002:a17:90a:6408:b0:259:ba4a:134d with SMTP id g8-20020a17090a640800b00259ba4a134dmr6404330pjj.20.1686325393515;
        Fri, 09 Jun 2023 08:43:13 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:1bc3:5645:d3d:e4be])
        by smtp.gmail.com with ESMTPSA id mu13-20020a17090b388d00b0024e1172c1d3sm3081760pjb.32.2023.06.09.08.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:43:13 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: report trax and perf counters in cpuinfo
Date:   Fri,  9 Jun 2023 08:43:06 -0700
Message-Id: <20230609154306.1911894-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'trax' to the list of CPU features when xtensa core is configured
with TRAX.
Add 'perf' to the list of CPU features when xtensa core is configured
with perf counters and show the number of configured perf counters.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/core.h |  8 ++++++++
 arch/xtensa/kernel/setup.c     | 12 ++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/core.h b/arch/xtensa/include/asm/core.h
index f856d2bcb9f3..0e1bb6f019d6 100644
--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -26,6 +26,14 @@
 #define XCHAL_SPANNING_WAY 0
 #endif
 
+#ifndef XCHAL_HAVE_TRAX
+#define XCHAL_HAVE_TRAX 0
+#endif
+
+#ifndef XCHAL_NUM_PERF_COUNTERS
+#define XCHAL_NUM_PERF_COUNTERS 0
+#endif
+
 #if XCHAL_HAVE_WINDOWED
 #if defined(CONFIG_USER_ABI_DEFAULT) || defined(CONFIG_USER_ABI_CALL0_PROBE)
 /* Whether windowed ABI is supported in userspace. */
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index ba20c6800fd4..357e7b0dff09 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -587,6 +587,12 @@ c_show(struct seq_file *f, void *slot)
 # if XCHAL_HAVE_OCD
 		     "ocd "
 # endif
+#if XCHAL_HAVE_TRAX
+		     "trax "
+#endif
+#if XCHAL_NUM_PERF_COUNTERS
+		     "perf "
+#endif
 #endif
 #if XCHAL_HAVE_DENSITY
 	    	     "density "
@@ -636,11 +642,13 @@ c_show(struct seq_file *f, void *slot)
 	seq_printf(f,"physical aregs\t: %d\n"
 		     "misc regs\t: %d\n"
 		     "ibreak\t\t: %d\n"
-		     "dbreak\t\t: %d\n",
+		     "dbreak\t\t: %d\n"
+		     "perf counters\t: %d\n",
 		     XCHAL_NUM_AREGS,
 		     XCHAL_NUM_MISC_REGS,
 		     XCHAL_NUM_IBREAK,
-		     XCHAL_NUM_DBREAK);
+		     XCHAL_NUM_DBREAK,
+		     XCHAL_NUM_PERF_COUNTERS);
 
 
 	/* Interrupt. */
-- 
2.30.2

