Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AEC70A73D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjETKtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETKtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:49:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3566AE54;
        Sat, 20 May 2023 03:49:04 -0700 (PDT)
Date:   Sat, 20 May 2023 10:49:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684579742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEcx6R0vMTxhLaMxIyehMiLk4f4YLBPdXojbYXfq0QU=;
        b=Nrk2CMMwNGV5+iGXON1q75dYapEFejIW8Q+LEXt67DFV+lHRbG55Lp2JHZgG2wy1xhvX0Z
        kd2lCrQ/FPVO1uFlBK7AOK9gRCRNgCXKZfr/Gx/56eqgMShEvzVHiHw4HDDR06Cn0PtWRA
        vkPnxAqjFDUKYbKPi+etkekA0xPomySk91L/SWU74zp2sYhw+QxrMfG+hfwAJj/WrGIyVq
        PR8JOiiJGc3IeNFfl9f2Hm9lOvMz5KKf2JSxnpi4FKUK3rz/sHrbQ+qGE0msbgDDpinl8A
        Xlvx1DK+aUyA/NoSVIV4bGNExXP4iknAg+99EvMjede12WgzeFPsF6LLVG3/yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684579742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEcx6R0vMTxhLaMxIyehMiLk4f4YLBPdXojbYXfq0QU=;
        b=ek3uP4UcF/SoyPSzt0DEz8O90yYXxCLWkM4lNTopS8zgszWp3l1NyC0n9k/LXikyFSKpkq
        kDCVslOku7izC6BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86,amd_iommu: Replace cmpxchg_double()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vasant Hegde <vasant.hegde@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515080554.315901115@infradead.org>
References: <20230515080554.315901115@infradead.org>
MIME-Version: 1.0
Message-ID: <168457974238.404.5428671026952030867.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d41f6f473d0f825678585fd1d782b4bdb9c3a528
Gitweb:        https://git.kernel.org/tip/d41f6f473d0f825678585fd1d782b4bdb9c3a528
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 May 2023 09:57:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 May 2023 12:35:13 +02:00

x86,amd_iommu: Replace cmpxchg_double()

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/20230515080554.315901115@infradead.org
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
