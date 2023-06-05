Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BD5721FE8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjFEHnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFEHmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:42:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DB8D2;
        Mon,  5 Jun 2023 00:42:52 -0700 (PDT)
Date:   Mon, 05 Jun 2023 07:42:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685950970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sv18HbCElckI93VMzkWkGjR/N2CyZxgcCLkmck14mwI=;
        b=k+3SMsTAHvDe3DBCrYSx/dETWMZUJBduKbxGHnj+YpVEFc1G46wqkVa5ORUfgXqVSbReXB
        LFgFG4mkDiL+o7QmOCWyZlqhnQghnaP9zlaNrfz5iGvKl9FIPpdDU5K/yMGc59ZZL4J89N
        3H7b9qSCppE5VhJp1Mx7t0NpFRDnic344dSX/VjCEqtjNE2dFbt/mo43dDEH6hUc1vFogg
        iNK5z+OlO05ULaNxJYHDR1vSTjOydDYT3uRpRPq0fX3MGSPy/sekXl3jotU5zgxwUaRpar
        z8t6AhnlRBUdbEuyn90PRX2En2oqSkxN1jM3Zvki16kAh4mxOqM/oazqM6Vhcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685950970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sv18HbCElckI93VMzkWkGjR/N2CyZxgcCLkmck14mwI=;
        b=Kz6cUjA3E4CyrVXFS4FCd6Q8D8w+TBDsjFhMZ3VkhziHzYgo3gQkatamV2uWL4SlnGRPOC
        oAln55TK65JF7cDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86,intel_iommu: Replace cmpxchg_double()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531132323.855976804@infradead.org>
References: <20230531132323.855976804@infradead.org>
MIME-Version: 1.0
Message-ID: <168595097012.404.2163323493793351384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b1fe7f2cda2a003afe316ce8dfe8d3645694a67e
Gitweb:        https://git.kernel.org/tip/b1fe7f2cda2a003afe316ce8dfe8d3645694a67e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 15:08:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:36:38 +02:00

x86,intel_iommu: Replace cmpxchg_double()

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230531132323.855976804@infradead.org
---
 drivers/iommu/intel/irq_remapping.c |   8 +--
 include/linux/dmar.h                | 125 ++++++++++++++-------------
 2 files changed, 68 insertions(+), 65 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index a1b9873..08f5632 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -175,18 +175,14 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 	irte = &iommu->ir_table->base[index];
 
 	if ((irte->pst == 1) || (irte_modified->pst == 1)) {
-		bool ret;
-
-		ret = cmpxchg_double(&irte->low, &irte->high,
-				     irte->low, irte->high,
-				     irte_modified->low, irte_modified->high);
 		/*
 		 * We use cmpxchg16 to atomically update the 128-bit IRTE,
 		 * and it cannot be updated by the hardware or other processors
 		 * behind us, so the return value of cmpxchg16 should be the
 		 * same as the old value.
 		 */
-		WARN_ON(!ret);
+		u128 old = irte->irte;
+		WARN_ON(!try_cmpxchg128(&irte->irte, &old, irte_modified->irte));
 	} else {
 		WRITE_ONCE(irte->low, irte_modified->low);
 		WRITE_ONCE(irte->high, irte_modified->high);
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 725d5e6..27dbd4c 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -202,67 +202,74 @@ static inline void detect_intel_iommu(void)
 
 struct irte {
 	union {
-		/* Shared between remapped and posted mode*/
 		struct {
-			__u64	present		: 1,  /*  0      */
-				fpd		: 1,  /*  1      */
-				__res0		: 6,  /*  2 -  6 */
-				avail		: 4,  /*  8 - 11 */
-				__res1		: 3,  /* 12 - 14 */
-				pst		: 1,  /* 15      */
-				vector		: 8,  /* 16 - 23 */
-				__res2		: 40; /* 24 - 63 */
+			union {
+				/* Shared between remapped and posted mode*/
+				struct {
+					__u64	present		: 1,  /*  0      */
+						fpd		: 1,  /*  1      */
+						__res0		: 6,  /*  2 -  6 */
+						avail		: 4,  /*  8 - 11 */
+						__res1		: 3,  /* 12 - 14 */
+						pst		: 1,  /* 15      */
+						vector		: 8,  /* 16 - 23 */
+						__res2		: 40; /* 24 - 63 */
+				};
+
+				/* Remapped mode */
+				struct {
+					__u64	r_present	: 1,  /*  0      */
+						r_fpd		: 1,  /*  1      */
+						dst_mode	: 1,  /*  2      */
+						redir_hint	: 1,  /*  3      */
+						trigger_mode	: 1,  /*  4      */
+						dlvry_mode	: 3,  /*  5 -  7 */
+						r_avail		: 4,  /*  8 - 11 */
+						r_res0		: 4,  /* 12 - 15 */
+						r_vector	: 8,  /* 16 - 23 */
+						r_res1		: 8,  /* 24 - 31 */
+						dest_id		: 32; /* 32 - 63 */
+				};
+
+				/* Posted mode */
+				struct {
+					__u64	p_present	: 1,  /*  0      */
+						p_fpd		: 1,  /*  1      */
+						p_res0		: 6,  /*  2 -  7 */
+						p_avail		: 4,  /*  8 - 11 */
+						p_res1		: 2,  /* 12 - 13 */
+						p_urgent	: 1,  /* 14      */
+						p_pst		: 1,  /* 15      */
+						p_vector	: 8,  /* 16 - 23 */
+						p_res2		: 14, /* 24 - 37 */
+						pda_l		: 26; /* 38 - 63 */
+				};
+				__u64 low;
+			};
+
+			union {
+				/* Shared between remapped and posted mode*/
+				struct {
+					__u64	sid		: 16,  /* 64 - 79  */
+						sq		: 2,   /* 80 - 81  */
+						svt		: 2,   /* 82 - 83  */
+						__res3		: 44;  /* 84 - 127 */
+				};
+
+				/* Posted mode*/
+				struct {
+					__u64	p_sid		: 16,  /* 64 - 79  */
+						p_sq		: 2,   /* 80 - 81  */
+						p_svt		: 2,   /* 82 - 83  */
+						p_res3		: 12,  /* 84 - 95  */
+						pda_h		: 32;  /* 96 - 127 */
+				};
+				__u64 high;
+			};
 		};
-
-		/* Remapped mode */
-		struct {
-			__u64	r_present	: 1,  /*  0      */
-				r_fpd		: 1,  /*  1      */
-				dst_mode	: 1,  /*  2      */
-				redir_hint	: 1,  /*  3      */
-				trigger_mode	: 1,  /*  4      */
-				dlvry_mode	: 3,  /*  5 -  7 */
-				r_avail		: 4,  /*  8 - 11 */
-				r_res0		: 4,  /* 12 - 15 */
-				r_vector	: 8,  /* 16 - 23 */
-				r_res1		: 8,  /* 24 - 31 */
-				dest_id		: 32; /* 32 - 63 */
-		};
-
-		/* Posted mode */
-		struct {
-			__u64	p_present	: 1,  /*  0      */
-				p_fpd		: 1,  /*  1      */
-				p_res0		: 6,  /*  2 -  7 */
-				p_avail		: 4,  /*  8 - 11 */
-				p_res1		: 2,  /* 12 - 13 */
-				p_urgent	: 1,  /* 14      */
-				p_pst		: 1,  /* 15      */
-				p_vector	: 8,  /* 16 - 23 */
-				p_res2		: 14, /* 24 - 37 */
-				pda_l		: 26; /* 38 - 63 */
-		};
-		__u64 low;
-	};
-
-	union {
-		/* Shared between remapped and posted mode*/
-		struct {
-			__u64	sid		: 16,  /* 64 - 79  */
-				sq		: 2,   /* 80 - 81  */
-				svt		: 2,   /* 82 - 83  */
-				__res3		: 44;  /* 84 - 127 */
-		};
-
-		/* Posted mode*/
-		struct {
-			__u64	p_sid		: 16,  /* 64 - 79  */
-				p_sq		: 2,   /* 80 - 81  */
-				p_svt		: 2,   /* 82 - 83  */
-				p_res3		: 12,  /* 84 - 95  */
-				pda_h		: 32;  /* 96 - 127 */
-		};
-		__u64 high;
+#ifdef CONFIG_IRQ_REMAP
+		__u128 irte;
+#endif
 	};
 };
 
