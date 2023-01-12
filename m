Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EB1667068
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjALLCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbjALLBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:01:38 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703D550F78
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:54:35 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a184so13505070pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iP7sVq72owAsCaLRDRWrJyz/2SPBWD/zqMuimFV62c=;
        b=h8QjrQBsSmb5hvUQB05p02td/5Hg9ajyH+4BzoOFHUlA//3317l/BmN1NVnFFREt/Q
         IBYThpMg+IFwrC4k7nTg5+oHLhLnG7NWH4EfINdh0wCpVwi+EWhzzbUxyqqVnH5XgRAy
         UDz7mdbINvdPV0+IEgLpKHOnHs4kxEcfvbTkSfo/xaa/+8RKt+sfHaLbql7OwzTlqlSY
         1RAUC0PSqIYTE50N+hAI5Zyba16DrbbbiEXHglsRzXAeysPUkAmTrkQX8NCVbXfwLKv1
         kBbUv1DyAVVGaWc77h3uChMcshP9p4ahu+mbOvxU+WRnaWoS5bG4cSnkZrHTntF1YxZN
         Qbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iP7sVq72owAsCaLRDRWrJyz/2SPBWD/zqMuimFV62c=;
        b=2CQ2DUFkLEYLL76xSyAsndsOQXBCG+S0ItdmwfH4Rb0CyOXB0b+UnnrAmZuY6d7pyG
         yg+xED30pIjQJckOxFg2q5RqJd8IbEYMWSvWv4RATb+8t27bokng2lmke+p2uJtCxn+G
         GIc8fcPDBczyxyAtx4NRFc3T/Upg/52jOR42H0SSQoB8eLqbZKMVQh8XEMAaJ4AAKaU6
         DBi2ehPP/cPUogsbeLoDjZPIxA8oXhKOxoXcAs61WhMpJJHbZOPBnMKVmNk6+6JMzgVX
         yZ6EZfgqgCK8IQ3awlYqGXBYUEnCy8sZq9vNi8P+1XXlADaK9aEPEK+s9ABsKRZEONFY
         nkhA==
X-Gm-Message-State: AFqh2koXDCF0UGsHbwnnMuXcUtQdv61Ih2tjKGkweZ7A05BUDIntLmSH
        rIoTOGaBDCcLSbD+dJ0BTyrcwMX8ArE=
X-Google-Smtp-Source: AMrXdXuJYr7IANlERZdu5+nkMfo07TmOuFv1Pk8yIXbtU+EySoO4KIlu2FFiHnWNzz1MkZdOyvkThg==
X-Received: by 2002:a62:5f43:0:b0:576:dc40:6db9 with SMTP id t64-20020a625f43000000b00576dc406db9mr70336312pfb.13.1673520874465;
        Thu, 12 Jan 2023 02:54:34 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (193-116-88-198.tpgi.com.au. [193.116.88.198])
        by smtp.gmail.com with ESMTPSA id g26-20020aa796ba000000b005891c98e1aasm7070970pfk.119.2023.01.12.02.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 02:54:33 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Erhard F ." <erhard_f@mailbox.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] kallsyms: Fix scheduling with interrupts disabled in self-test
Date:   Thu, 12 Jan 2023 20:54:26 +1000
Message-Id: <20230112105426.1037325-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
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

kallsyms_on_each* may schedule so must not be called with interrupts
disabled. The iteration function could disable interrupts, but this
also changes lookup_symbol() to match the change to the other timing
code.

Reported-by: Erhard F. <erhard_f@mailbox.org>
Link: https://lore.kernel.org/all/bug-216902-206035@https.bugzilla.kernel.org%2F/
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202212251728.8d0872ff-oliver.sang@intel.com
Fixes: 30f3bb09778d ("kallsyms: Add self-test facility")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/kallsyms_selftest.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index f35d9cc1aab1..bfbc12da3326 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -157,14 +157,11 @@ static void test_kallsyms_compression_ratio(void)
 static int lookup_name(void *data, const char *name, struct module *mod, unsigned long addr)
 {
 	u64 t0, t1, t;
-	unsigned long flags;
 	struct test_stat *stat = (struct test_stat *)data;
 
-	local_irq_save(flags);
-	t0 = sched_clock();
+	t0 = ktime_get_ns();
 	(void)kallsyms_lookup_name(name);
-	t1 = sched_clock();
-	local_irq_restore(flags);
+	t1 = ktime_get_ns();
 
 	t = t1 - t0;
 	if (t < stat->min)
@@ -234,18 +231,15 @@ static int find_symbol(void *data, const char *name, struct module *mod, unsigne
 static void test_perf_kallsyms_on_each_symbol(void)
 {
 	u64 t0, t1;
-	unsigned long flags;
 	struct test_stat stat;
 
 	memset(&stat, 0, sizeof(stat));
 	stat.max = INT_MAX;
 	stat.name = stub_name;
 	stat.perf = 1;
-	local_irq_save(flags);
-	t0 = sched_clock();
+	t0 = ktime_get_ns();
 	kallsyms_on_each_symbol(find_symbol, &stat);
-	t1 = sched_clock();
-	local_irq_restore(flags);
+	t1 = ktime_get_ns();
 	pr_info("kallsyms_on_each_symbol() traverse all: %lld ns\n", t1 - t0);
 }
 
@@ -270,17 +264,14 @@ static int match_symbol(void *data, unsigned long addr)
 static void test_perf_kallsyms_on_each_match_symbol(void)
 {
 	u64 t0, t1;
-	unsigned long flags;
 	struct test_stat stat;
 
 	memset(&stat, 0, sizeof(stat));
 	stat.max = INT_MAX;
 	stat.name = stub_name;
-	local_irq_save(flags);
-	t0 = sched_clock();
+	t0 = ktime_get_ns();
 	kallsyms_on_each_match_symbol(match_symbol, stat.name, &stat);
-	t1 = sched_clock();
-	local_irq_restore(flags);
+	t1 = ktime_get_ns();
 	pr_info("kallsyms_on_each_match_symbol() traverse all: %lld ns\n", t1 - t0);
 }
 
-- 
2.37.2

