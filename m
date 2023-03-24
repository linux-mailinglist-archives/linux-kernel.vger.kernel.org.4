Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA926C7D70
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCXLr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCXLrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:47:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D17212B1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:47:23 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679658441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KDPHyC6kWyePMtKLTpdAD+GT0kcy5lpaGKk40vT9Trk=;
        b=pYBaWSXTO+Wz8eDa1FUSKeX9XRTcRQiGR+tn0DaBZaj2pSQTCpNciw284AfXoUL43F9/pV
        ZOLFU7nwE/quHO0F/ujK2j9/zEHeD3HdpaL210Mc/1M7FdJZ3el8yttzJ7i5vac/ID3MFm
        wySJqyLXZNpqqqLQjb/IU/8eqp1/CndsZSgnYrYSbhZJ746MDVQ8yJRQpvfi1jPB/zpVOM
        YgnnRtaecElUEyVKkHOnWdGISCEUpK/RlIbSKRs79znEqHpzkOzefb9JTMgZ5b1AIwe0C7
        6UOiqpAsvC0RbYOX2EZ7f/wtsT0JpFP5DGnM4zBa/Z9NqH2V2VUsw+l+0fMFBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679658441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KDPHyC6kWyePMtKLTpdAD+GT0kcy5lpaGKk40vT9Trk=;
        b=p7MsW3zN+G0mjBxUNC5rQL58AdcZjYToNkx+sxTQB3HC9GmzxCrXtkkXG+pbPo6AYvg4le
        wr4fyU/kQ4RsauCw==
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/microcode: move @microcode_mutex definition near usage
Date:   Fri, 24 Mar 2023 11:47:20 +0000
Message-Id: <20230324114720.1756466-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_MICROCODE_LATE_LOADING is not enabled, the compiler warns:

'microcode_mutex' defined but not used

Since reload_store() is the only function using this mutex, move the
mutex definititon there. Then it is also within the #ifdef block for
CONFIG_MICROCODE_LATE_LOADING.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7a329e561354..e7b8f7ad105d 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -49,20 +49,6 @@ bool initrd_gone;
 
 LIST_HEAD(microcode_cache);
 
-/*
- * Synchronization.
- *
- * All non cpu-hotplug-callback call sites use:
- *
- * - microcode_mutex to synchronize with each other;
- * - cpus_read_lock/unlock() to synchronize with
- *   the cpu-hotplug-callback call sites.
- *
- * We guarantee that only a single cpu is being
- * updated at any particular moment of time.
- */
-static DEFINE_MUTEX(microcode_mutex);
-
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
 struct cpu_info_ctx {
@@ -465,6 +451,20 @@ static int microcode_reload_late(void)
 	return ret;
 }
 
+/*
+ * Synchronization.
+ *
+ * All non cpu-hotplug-callback call sites use:
+ *
+ * - microcode_mutex to synchronize with each other;
+ * - cpus_read_lock/unlock() to synchronize with
+ *   the cpu-hotplug-callback call sites.
+ *
+ * We guarantee that only a single cpu is being
+ * updated at any particular moment of time.
+ */
+static DEFINE_MUTEX(microcode_mutex);
+
 static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)

base-commit: 1e760fa3596e8c7f08412712c168288b79670d78
-- 
2.30.2

