Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDFD688618
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjBBSJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBBSJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:09:07 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A7C1206C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:09:06 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id dr8so8292097ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTNk0BA5NM2oMhge3KzqOkD0ufAOyhldxWNhE6pIRMo=;
        b=WmZV5nrhLAZoYwruYQ0B1F7QEq5giCZrfaxgd34v/rXS0lBEiPSSyvaO6vv5NhF9W2
         G3B5hS0jh8XgWT2+yJL55OocCPM13NG055aVvrSU1Sew6qgdrE0R3z8iwSbCOC1qv6gE
         02y6nXmfmUUdKGeZ5K35RwTm5uDTQ/hG0cYeFIYfM9CfjE1wNgCbScgzPmU86QDh8dQx
         FA8LyGHXa0D04858KdUi2DEyBQjkFhzXgDjF55gZGqYP0ZmPnrhiogTYQqQzp/iYLKDf
         IyRutNahm/KSLdPyHSTkny94sLVNpHRwzy9RKsYu3WrJRcecb8mHJMBpB2KLARPhKdOK
         ZjHw==
X-Gm-Message-State: AO0yUKUtQ+m6x01FbK2k8ShMLUmEvwaWIiAzdTw87l9fTpHkzPLkP9gi
        f9X4tiJrMqnGZyLQTdHjRXrIvg7ip9Uugg==
X-Google-Smtp-Source: AK7set+ikZ5pIJ3yDO30FYgZHmWdRV5lvyieAXCeXF3igMOfTjRElSj8xvqbq8MCXjISdZWvWpgY9g==
X-Received: by 2002:a17:906:8a63:b0:888:7ce4:1dc1 with SMTP id hy3-20020a1709068a6300b008887ce41dc1mr7421458ejc.26.1675361344779;
        Thu, 02 Feb 2023 10:09:04 -0800 (PST)
Received: from localhost (fwdproxy-cln-034.fbsv.net. [2a03:2880:31ff:22::face:b00c])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060a4a00b00880dbd4b6d4sm108421ejf.136.2023.02.02.10.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 10:09:04 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     tglx@linutronix.de, bp@alien8.de,
        pawan.kumar.gupta@linux.intel.com, paul@paul-moore.com
Cc:     leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Date:   Thu,  2 Feb 2023 10:08:58 -0800
Message-Id: <20230202180858.1539234-1-leitao@debian.org>
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

This patch creates an easy way to disable mitigation during compilation
time (CONFIG_DEFAULT_CPU_MITIGATIONS_OFF), so, insecure kernel users don't
need to deal with kernel parameters when booting insecure kernels.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/cpu.c     |  5 +++++
 security/Kconfig | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..497e9a3d3d77 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2727,8 +2727,13 @@ enum cpu_mitigations {
 	CPU_MITIGATIONS_AUTO_NOSMT,
 };
 
+#ifdef CONFIG_DEFAULT_CPU_MITIGATIONS_OFF
+static enum cpu_mitigations cpu_mitigations __ro_after_init =
+	CPU_MITIGATIONS_OFF;
+#else
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
 	CPU_MITIGATIONS_AUTO;
+#endif
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
diff --git a/security/Kconfig b/security/Kconfig
index e6db09a779b7..a70427dc6ace 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -258,6 +258,17 @@ config LSM
 
 	  If unsure, leave this as the default.
 
+config CONFIG_DEFAULT_CPU_MITIGATIONS_OFF
+	bool "Disable mitigations for CPU vulnerabilities by default"
+	default n
+	help
+	  This option disable mitigations for CPU vulnerabilities by default.
+	  This improves system performance, but it may also expose users
+	  to several CPU vulnerabilities.
+	  This has the same effect as passing `mitigations=off` kernel
+	  parameter. The mitigations could be enabled back passing the
+	  'mitigations' parameter.
+
 source "security/Kconfig.hardening"
 
 endmenu
-- 
2.30.2

