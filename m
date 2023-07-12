Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0009E750A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGLOLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjGLOLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:11:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8416212E;
        Wed, 12 Jul 2023 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/DWXQqdXB8XEBn9nrcxVpdVWWih+jjCwvlX2nEsLPTI=; b=Wz9OuEdTC/U+pAiGDh2QSB1rQh
        estO8miU9AZSQNeT1ZfBneiErxb37LhSNHRZWtuGfrfLL1EYkRTytC/eqtBQ5flUhEkMN1zCFkngN
        CVzVfJexnFAvgPRqAnyVh6g8uw/+7RiOaL7qFDbPWf+LxBDspZS1XQHRjPG10xiWCycFSlzSeQ2pS
        qkhXaNVnuBwkoDhccV3f/fFDXhPTzT7MM2g/KNXJHQ/EEWc8ngzF5xbTsxRq1oXCgKmASiLZwPe8+
        dX/EJQBH+CNoE/6rDxPZB9iyHwbKpAVKYbdYizbASNU7oByvubO1HFOqmYxrD49elB6ZmrjF3w4C2
        y9jxJUrA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJaYV-003fwd-0S;
        Wed, 12 Jul 2023 14:10:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E17A30049D;
        Wed, 12 Jul 2023 16:10:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46BDE200D8DF7; Wed, 12 Jul 2023 16:10:56 +0200 (CEST)
Date:   Wed, 12 Jul 2023 16:10:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [RFC][PATCH] sched: Rename DIE domain
Message-ID: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Thomas just tripped over the x86 topology setup creating a 'DIE' domain
for the package mask :-)

Since these names are SCHED_DEBUG only, rename them.
I don't think anybody *should* be relying on this, but who knows.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/kernel/smp.c   | 2 +-
 arch/s390/kernel/topology.c | 2 +-
 arch/x86/kernel/smpboot.c   | 2 +-
 kernel/sched/topology.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index fbbb695bae3d..5ed6b9fe5094 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1050,7 +1050,7 @@ static struct sched_domain_topology_level powerpc_topology[] = {
 #endif
 	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
 	{ cpu_mc_mask, SD_INIT_NAME(MC) },
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
 	{ NULL, },
 };
 
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 68adf1de8888..c803f5e6ab46 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -522,7 +522,7 @@ static struct sched_domain_topology_level s390_topology[] = {
 	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
 	{ cpu_book_mask, SD_INIT_NAME(BOOK) },
 	{ cpu_drawer_mask, SD_INIT_NAME(DRAWER) },
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
 	{ NULL, },
 };
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1aa2cd7734b..09cc9d0aa358 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -653,7 +653,7 @@ static void __init build_sched_topology(void)
 	 */
 	if (!x86_has_numa_in_package) {
 		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, SD_INIT_NAME(DIE)
+			cpu_cpu_mask, SD_INIT_NAME(PKG)
 		};
 	}
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d3a3b2646ec4..e9d9cf776b7a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1670,7 +1670,7 @@ static struct sched_domain_topology_level default_topology[] = {
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
 #endif
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
 	{ NULL, },
 };
 

