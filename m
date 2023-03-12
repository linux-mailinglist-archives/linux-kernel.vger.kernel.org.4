Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EB16B6737
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCLOlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCLOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:41:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2330D43927;
        Sun, 12 Mar 2023 07:41:16 -0700 (PDT)
Date:   Sun, 12 Mar 2023 14:41:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678632073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFEybelJ9loE0Nupy89Z06wvn5RgHE9M3FshmrNfoEg=;
        b=iBSKYR6tfeXGG4Q5owQf8Y7yDmbz1YxTy7mdFsmO4DU3PeGvkZf7BI9mlrO3FpscfWdF84
        9KG0aeMWMJDF0g9Rb66DLU8CBdmnseWd98tlyX4qSuVl1FnlAsF7EsmUvEyU+Qyx+iRuHJ
        QBPQiYR66nKRBJA0Ivwp1UsPwR8KcOpsInrkWd8Y406TdXqhA5k3Fi/PdByvYq1dD4AzIq
        zM2QoBuUfA+jW96GdT/SYD9lK8Sspz1RaDvR13YPeGYg2YI6BB14s54+cLg+OAnvW8oQtc
        eOshsyJaDQ9yqTtzPk7RnKuvIh/Fz4Gbb18ObMrowJXya/6CmarIzY0AjIRlYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678632073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFEybelJ9loE0Nupy89Z06wvn5RgHE9M3FshmrNfoEg=;
        b=mDMdfjAKLvXwx0Hb0StL0ZAy5QcTEdHkYofGzVkMapNFN3EGJs2XWAce/9nwVTREtLitNz
        uJphoAqfxtqGusDg==
From:   "tip-bot2 for Andrzej Hajda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] qed: use __xchg if possible
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Shyti <andi.shyti@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118154450.73842-6-andrzej.hajda@intel.com>
References: <20230118154450.73842-6-andrzej.hajda@intel.com>
MIME-Version: 1.0
Message-ID: <167863207321.5837.328011126625602425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9b579a841f9032a231e9b14a23dc6699cbe6d311
Gitweb:        https://git.kernel.org/tip/9b579a841f9032a231e9b14a23dc6699cbe6d311
Author:        Andrzej Hajda <andrzej.hajda@intel.com>
AuthorDate:    Wed, 18 Jan 2023 16:44:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Mar 2023 14:03:59 +01:00

qed: use __xchg if possible

Recently introduced helper simplifies the code.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/20230118154450.73842-6-andrzej.hajda@intel.com
---
 include/linux/qed/qed_chain.h | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/linux/qed/qed_chain.h b/include/linux/qed/qed_chain.h
index a840634..6355d55 100644
--- a/include/linux/qed/qed_chain.h
+++ b/include/linux/qed/qed_chain.h
@@ -11,6 +11,7 @@
 #include <asm/byteorder.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/non-atomic/xchg.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/qed/common_hsi.h>
@@ -368,7 +369,7 @@ static inline void qed_chain_return_produced(struct qed_chain *p_chain)
  */
 static inline void *qed_chain_produce(struct qed_chain *p_chain)
 {
-	void *p_ret = NULL, *p_prod_idx, *p_prod_page_idx;
+	void *p_prod_idx, *p_prod_page_idx;
 
 	if (is_chain_u16(p_chain)) {
 		if ((p_chain->u.chain16.prod_idx &
@@ -390,11 +391,8 @@ static inline void *qed_chain_produce(struct qed_chain *p_chain)
 		p_chain->u.chain32.prod_idx++;
 	}
 
-	p_ret = p_chain->p_prod_elem;
-	p_chain->p_prod_elem = (void *)(((u8 *)p_chain->p_prod_elem) +
-					p_chain->elem_size);
-
-	return p_ret;
+	return __xchg(&p_chain->p_prod_elem,
+		      (u8 *)p_chain->p_prod_elem + p_chain->elem_size);
 }
 
 /**
@@ -439,7 +437,7 @@ static inline void qed_chain_recycle_consumed(struct qed_chain *p_chain)
  */
 static inline void *qed_chain_consume(struct qed_chain *p_chain)
 {
-	void *p_ret = NULL, *p_cons_idx, *p_cons_page_idx;
+	void *p_cons_idx, *p_cons_page_idx;
 
 	if (is_chain_u16(p_chain)) {
 		if ((p_chain->u.chain16.cons_idx &
@@ -461,11 +459,8 @@ static inline void *qed_chain_consume(struct qed_chain *p_chain)
 		p_chain->u.chain32.cons_idx++;
 	}
 
-	p_ret = p_chain->p_cons_elem;
-	p_chain->p_cons_elem = (void *)(((u8 *)p_chain->p_cons_elem) +
-					p_chain->elem_size);
-
-	return p_ret;
+	return __xchg(&p_chain->p_cons_elem,
+		      (u8 *)p_chain->p_cons_elem + p_chain->elem_size);
 }
 
 /**
