Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95EC68983B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjBCMHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjBCMHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:07:19 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DCB71658
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:07:18 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id lu11so14786554ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 04:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFRsk/X+fnAREo/+AWk3QTswlx80QT6mGneWCbGiQ+4=;
        b=LGQjQdvPkVBdxtP8ZuCni04JjjQA6UFJyazwOrHg1ms+OVoLrnMTcAXngnFlA1U5Bv
         E+YXXbKAG4iXBEVyCpVDxWf1nf7Z1bBQvN2a/1PjPB4sJ2IH4hYKI4Q6Jco+FPzDW7iO
         jycmwR7jAUPMcDWNTuNAPfiWe4ETRQbqa5jcmPoHru0oJp0RtLRJLoCCwfOKgFiZIFm9
         G/8YJRMAJWHqMn3/2NUOD/tyyJEM1IYJGb3Bb4ieb3USb2rEpYr5+ibEAhlhgBxCmCK6
         uRKxQLkQGUOTpBepoSz5ecMfvJ4uT6+feY0lZHUTIL4RI9IoL6GT7GEKzOhmyr6k43Cj
         zqIw==
X-Gm-Message-State: AO0yUKWFpMVjwjDIBrXYNODb/moQJsL4LOy4XFOmgxZDt0zNvOqFyWZk
        2EtHYS3iRb3QdZCyMR5gDao=
X-Google-Smtp-Source: AK7set+5CHZ2lXvb8b4OU8erIYj4OssZ2cXTWuA0sz/fEoVJ+S4WpTVM+gmdFmxKTBkZgCZandy9gA==
X-Received: by 2002:a17:906:281b:b0:86a:833d:e7d8 with SMTP id r27-20020a170906281b00b0086a833de7d8mr9128750ejc.17.1675426036948;
        Fri, 03 Feb 2023 04:07:16 -0800 (PST)
Received: from localhost (fwdproxy-cln-012.fbsv.net. [2a03:2880:31ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id qp22-20020a170907207600b0087862f45a29sm1297001ejb.174.2023.02.03.04.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:07:16 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     tglx@linutronix.de, bp@alien8.de,
        pawan.kumar.gupta@linux.intel.com, paul@paul-moore.com
Cc:     leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Date:   Fri,  3 Feb 2023 04:06:15 -0800
Message-Id: <20230203120615.1121272-1-leitao@debian.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now it is not possible to disable CPU vulnerabilities mitigations
at build time. Mitigation needs to be disabled passing kernel
parameters, such as 'mitigations=off'.

Create a new config option (CONFIG_CPU_MITIGATIONS_DEFAULT_OFF) that
sets the global variable `cpu_mitigations` to OFF, instead of AUTO. This
allows the creation of kernel binaries that boots with the CPU
mitigations turned off by default, and does not require dealing kernel
parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/cpu.c     |  7 +++++--
 security/Kconfig | 11 +++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..90afb29eb62f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2727,8 +2727,11 @@ enum cpu_mitigations {
 	CPU_MITIGATIONS_AUTO_NOSMT,
 };
 
-static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	CPU_MITIGATIONS_AUTO;
+#ifdef CONFIG_CPU_MITIGATIONS_DEFAULT_OFF
+static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_OFF;
+#else
+static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
+#endif
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
diff --git a/security/Kconfig b/security/Kconfig
index e6db09a779b7..644f91b6c26a 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -258,6 +258,17 @@ config LSM
 
 	  If unsure, leave this as the default.
 
+config CPU_MITIGATIONS_DEFAULT_OFF
+	bool "Disable mitigations for CPU vulnerabilities by default"
+	default n
+	help
+	  This option disables mitigations for CPU vulnerabilities by default.
+	  Disabling CPU mitigations improves system performance,
+	  but it may also expose users to several CPU vulnerabilities.
+	  This option has the same effect of passing `mitigations=off` kernel
+	  parameter. The CPU mitigations could be enabled back using the
+	  'mitigations' parameter.
+
 source "security/Kconfig.hardening"
 
 endmenu
-- 
2.30.2

