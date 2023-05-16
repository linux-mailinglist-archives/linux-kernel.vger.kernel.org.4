Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709EA7048C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjEPJMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEPJKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE654EE8;
        Tue, 16 May 2023 02:10:08 -0700 (PDT)
Date:   Tue, 16 May 2023 09:10:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9sWVRJedFibc6rSu8z+Ut4qppQZb1WpLCQ9D5Xg158=;
        b=j+HyFhSEYF0uLyU2IrmCPxewDSkNY5yWuYh3AOr0/E13Tuwr5lbaFqN0pPQDTYEl+c/Xvc
        k5xutZW7tQDmcSoYMgda8k9fPlMBEGrl5OlA1PiZn/r09XRHPXUGBHu73nuxAVP0BmP7DS
        OdOVyvdKFfEPxGCbf84NIVGHYqaGWTpi/n/ZQqQplOGLkrYLiAhZcY6pwv+vQRhQI2xB36
        dKv2FY3vFfzBLmoa0TZ2fuHTeDfhvcTRmkZe2KxuZaYZ2KQ1XuVVSJ4RDC4DK3rCyN3v+o
        zGBLfa+cxveLkz/gCpCxEcz0GmkPMAsGo1CnU/cCbsuW+PpFAzpdFjv5Ps3gLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9sWVRJedFibc6rSu8z+Ut4qppQZb1WpLCQ9D5Xg158=;
        b=bBVbPZPv3lS7gmGx4k7sBHPJs9FmQQZh2PAVpSgfDm8acoWA6VFP54n1iqh6VEh5ghAe3+
        YKowcwepVqZhroDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Cleanup topology_phys_to_logical_pkg()/die()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205255.493750666@linutronix.de>
References: <20230512205255.493750666@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422820378.404.3480586870507701580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     5107e3ebb868d99872e1b64b054ccfcdad79d5d7
Gitweb:        https://git.kernel.org/tip/5107e3ebb868d99872e1b64b054ccfcdad79d5d7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:06:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:47 +02:00

x86/smpboot: Cleanup topology_phys_to_logical_pkg()/die()

Make topology_phys_to_logical_pkg_die() static as it's only used in
smpboot.c and fixup the kernel-doc warnings for both functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205255.493750666@linutronix.de
---
 arch/x86/include/asm/topology.h |  3 ---
 arch/x86/kernel/smpboot.c       | 10 ++++++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 458c891..2ba5758 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -139,7 +139,6 @@ static inline int topology_max_smt_threads(void)
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
-int topology_phys_to_logical_die(unsigned int die, unsigned int cpu);
 bool topology_is_primary_thread(unsigned int cpu);
 bool topology_smt_supported(void);
 #else
@@ -149,8 +148,6 @@ topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
 static inline int
 topology_update_die_map(unsigned int dieid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
-static inline int topology_phys_to_logical_die(unsigned int die,
-		unsigned int cpu) { return 0; }
 static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce..bca9692 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -288,6 +288,7 @@ bool topology_smt_supported(void)
 
 /**
  * topology_phys_to_logical_pkg - Map a physical package id to a logical
+ * @phys_pkg:	The physical package id to map
  *
  * Returns logical package id or -1 if not found
  */
@@ -304,15 +305,17 @@ int topology_phys_to_logical_pkg(unsigned int phys_pkg)
 	return -1;
 }
 EXPORT_SYMBOL(topology_phys_to_logical_pkg);
+
 /**
  * topology_phys_to_logical_die - Map a physical die id to logical
+ * @die_id:	The physical die id to map
+ * @cur_cpu:	The CPU for which the mapping is done
  *
  * Returns logical die id or -1 if not found
  */
-int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cpu)
+static int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cpu)
 {
-	int cpu;
-	int proc_id = cpu_data(cur_cpu).phys_proc_id;
+	int cpu, proc_id = cpu_data(cur_cpu).phys_proc_id;
 
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -323,7 +326,6 @@ int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cpu)
 	}
 	return -1;
 }
-EXPORT_SYMBOL(topology_phys_to_logical_die);
 
 /**
  * topology_update_package_map - Update the physical to logical package map
