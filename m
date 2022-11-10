Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACF5623D35
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiKJIPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiKJIPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:15:47 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8731B1D4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:15:46 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f63so1098185pgc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JiyZ1hWVATL+iuWQbgLK9dDD8NJ+KjIJFMCcv1dNws=;
        b=4mmXT6czmfIGpWlJqlmQJ7kyF/U8tRAzRlYHJ596QLAPAp9RO1DzlieBk3D31YyM/d
         39uaR6S/tt3G0VlYgbCVDLCPMfDTAF3l72d0FMLo4IvR5UYcvRdqOzNeB1aRq1pl/4DH
         OyDjLIpaYko5MopKW5xaUzHz3Psva0fk6QsuyJQFpv+UTMZocZMLcdMUuvNRMu/D9+md
         I+wfjbyBWBpsrKRjrBMHqykmNLdmmsNbtN245WNLTQU9eYqEa7XzaNFfxGsHkR9Sq36a
         d07BN6IVsrDIAxgwt5kXNWG3oQIs8pLJYB7wn4Jwa9shFAzrqJaxZCI4YtFCMOOYK59M
         Kl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JiyZ1hWVATL+iuWQbgLK9dDD8NJ+KjIJFMCcv1dNws=;
        b=xQAt9Ll/IXQG+bR68nudItGLlLxMgEZPgESwt3YqiGDCg3INPjVUfpM8nQthfYeV6j
         3Vs2onPhwaBxD+ZMZibc2BBDD0hNlHEs6JObWfT2x6cK8eTIkwSNrOBZCYoOcLznLGsk
         7TMRc7eRl5Z0Hfb7sfK0xrUKd/NIkTH04Rc7R8YMJD3/Q6mmRWDPNbWr3cTSpahwEv59
         UUGIapZdugjtcl2Q8pCgbVvN5qB5D7KstUEhrWMBeDrCCWLDdEvf/GE7xc0/jl30bYON
         tej6oc+yZ24GrTa5c4hbt1WYir9kZcI33DCu690XIM26uhAvr2rc/iuDnMaPHt+93uCs
         LlzA==
X-Gm-Message-State: ACrzQf2nHObPkQSszE67WCUMaiF2mTZiurpWw5OwlTIfJ+c6OOkAgu3P
        Yl7IBf1ESwSnJivy56xZgYIqlM93QB1l0Q==
X-Google-Smtp-Source: AMsMyM49RJ67toFRhCK5l74gbe/MCd1OdOXjXKe+xYWQ/1ekvADyDWElPZmm7rtLujs+ij2U04rQYw==
X-Received: by 2002:a63:7d4f:0:b0:470:399:c953 with SMTP id m15-20020a637d4f000000b004700399c953mr1864613pgn.263.1668068146139;
        Thu, 10 Nov 2022 00:15:46 -0800 (PST)
Received: from devtp.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a7f0500b0020af2411721sm2496587pjl.34.2022.11.10.00.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 00:15:45 -0800 (PST)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com
Cc:     solar@openwall.com, linux-kernel@vger.kernel.org, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v2] kprobes: kretprobe events missing on 2-core KVM guest
Date:   Thu, 10 Nov 2022 16:15:02 +0800
Message-Id: <20221110081502.492289-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026003315.266d59d5c0780c2817be3a0d@kernel.org>
References: <20221026003315.266d59d5c0780c2817be3a0d@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default value of maxactive is set as num_possible_cpus() for nonpreemptable
systems. For a 2-core system, only 2 kretprobe instances would be allocated
in default, then these 2 instances for execve kretprobe are very likely to
be used up with a pipelined command.

Here's the testcase: a shell script was added to crontab, and the content
of the script is:

  #!/bin/sh
  do_something_magic `tr -dc a-z < /dev/urandom | head -c 10`

cron will trigger a series of program executions (4 times every hour). Then
events loss would be noticed normally after 3-4 hours of testings.

The issue is caused by a burst of series of execve requests. The best number
of kretprobe instances could be different case by case, and should be user's
duty to determine, but num_possible_cpus() as the default value is inadequate
especially for systems with small number of cpus.

This patch enables the logic for preemption as default, thus increases the
minimum of maxactive to 10 for nonpreemptable systems.

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 Documentation/trace/kprobes.rst |  3 +--
 kernel/kprobes.c                | 10 +++-------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
index 48cf778a2468..fc7ce76eab65 100644
--- a/Documentation/trace/kprobes.rst
+++ b/Documentation/trace/kprobes.rst
@@ -131,8 +131,7 @@ For example, if the function is non-recursive and is called with a
 spinlock held, maxactive = 1 should be enough.  If the function is
 non-recursive and can never relinquish the CPU (e.g., via a semaphore
 or preemption), NR_CPUS should be enough.  If maxactive <= 0, it is
-set to a default value.  If CONFIG_PREEMPT is enabled, the default
-is max(10, 2*NR_CPUS).  Otherwise, the default is NR_CPUS.
+set to a default value: max(10, 2*NR_CPUS).
 
 It's not a disaster if you set maxactive too low; you'll just miss
 some probes.  In the kretprobe struct, the nmissed field is set to
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a8b202f87e2d..1e80bddf2654 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2212,11 +2212,7 @@ int register_kretprobe(struct kretprobe *rp)
 	rp->kp.post_handler = NULL;
 
 	/* Pre-allocate memory for max kretprobe instances */
-	if (rp->maxactive <= 0) {
-#ifdef CONFIG_PREEMPTION
+	if (rp->maxactive <= 0)
 		rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());
-#else
-		rp->maxactive = num_possible_cpus();
-#endif
-	}
+
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
--
2.34.1

