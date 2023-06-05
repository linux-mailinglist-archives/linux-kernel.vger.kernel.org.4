Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857AB721FE3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjFEHnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFEHmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:42:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33832AD;
        Mon,  5 Jun 2023 00:42:52 -0700 (PDT)
Date:   Mon, 05 Jun 2023 07:42:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685950970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7PdDgM6w1ufVrBg+pEhGG43hhM2mIg7TeX3hTEv1iE=;
        b=dnYOLynH+ccQSoqIQs1FfRFJrlM/iz0zR5Ui9IFFAl5RdJ7NginDa0NUi79K2DG8ShW6Nl
        CapGle0C2HNfm43p9T8hiLAssdrKLVJXhGrOCiAoyuGVoBGNa6PRsorQg0YiWnqvXZYYB3
        A/1Z2+7KCoQlNFLk2lOc9jIyC5Msa1fQcS2j/7rz0vQT13oXDnd+6WxnusiMjL68tO/HEq
        bB8l/tGEnlC6J9clEeRR3QxESnm5DCWOd7hBqy2p2l5iIMIZMyQydjz8KIXAV+hzO2OluJ
        4sv8d2+CDyK/EP8Ot2lTn/6X+st+n5cB+x7dSNf6LONEqZrtSE1PFn3pYsXUyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685950970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7PdDgM6w1ufVrBg+pEhGG43hhM2mIg7TeX3hTEv1iE=;
        b=mqJ1G+S8O8iWoj7q4RnD627S4271Tl2GxYr2QNhGw0rKJYD/Q0kvQwwmiiNF/ulP9qXmrA
        KAyC8L5H9gthczBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86,amd_iommu: Replace cmpxchg_double()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Vasant Hegde <vasant.hegde@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531132323.788955257@infradead.org>
References: <20230531132323.788955257@infradead.org>
MIME-Version: 1.0
Message-ID: <168595097042.404.1105917513854333768.tip-bot2@tip-bot2>
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

Commit-ID:     0a0a6800b02489c1288f963ad290b6a4876a2cc8
Gitweb:        https://git.kernel.org/tip/0a0a6800b02489c1288f963ad290b6a4876a2cc8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 15:08:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:36:38 +02:00

x86,amd_iommu: Replace cmpxchg_double()

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230531132323.788955257@infradead.org
---
 drivers/iommu/amd/amd_iommu_types.h |  9 +++++++--
 drivers/iommu/amd/iommu.c           | 10 ++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 2ddbda3..ab8aa8f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -986,8 +986,13 @@ union irte_ga_hi {
 };
 
 struct irte_ga {
-	union irte_ga_lo lo;
-	union irte_ga_hi hi;
+	union {
+		struct {
+			union irte_ga_lo lo;
+			union irte_ga_hi hi;
+		};
+		u128 irte;
+	};
 };
 
 struct irq_2_irte {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4a31464..1e9f85e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3003,10 +3003,10 @@ out:
 static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 			  struct irte_ga *irte, struct amd_ir_data *data)
 {
-	bool ret;
 	struct irq_remap_table *table;
-	unsigned long flags;
 	struct irte_ga *entry;
+	unsigned long flags;
+	u128 old;
 
 	table = get_irq_table(iommu, devid);
 	if (!table)
@@ -3017,16 +3017,14 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 	entry = (struct irte_ga *)table->table;
 	entry = &entry[index];
 
-	ret = cmpxchg_double(&entry->lo.val, &entry->hi.val,
-			     entry->lo.val, entry->hi.val,
-			     irte->lo.val, irte->hi.val);
 	/*
 	 * We use cmpxchg16 to atomically update the 128-bit IRTE,
 	 * and it cannot be updated by the hardware or other processors
 	 * behind us, so the return value of cmpxchg16 should be the
 	 * same as the old value.
 	 */
-	WARN_ON(!ret);
+	old = entry->irte;
+	WARN_ON(!try_cmpxchg128(&entry->irte, &old, irte->irte));
 
 	if (data)
 		data->ref = entry;
