Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A726721F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjARPqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjARPqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:46:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578FB392B4;
        Wed, 18 Jan 2023 07:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674056742; x=1705592742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6s3fA2jhqnAHgwbfGrKCZDIy07cNkborYz0vvTXb80k=;
  b=ARBxIRa8dOe2aTvANSHwhwDAZb/B9J/CYENY+VceAGs91iYP2hvhVcFL
   pgbPbT+ghnRyGID5IspmKMbimup3eB+zT+zhYr23FiinwIoC39VoqR9CO
   wXWJdp5rdit6EftFTiUxYU/k9n8fOTQLrUWxxfsc60GcTdwbP11pce3fO
   3Fy9/3DHTcxWZbO0cITD88Komsj1sPIq9b+HLiKV87Z1n4yeHxbxtlAvY
   tgVskRL0vd22R3O1u9u2Ca14pI2UgL7YvOI2YTXrclBAqqjrsJdFeq89n
   qMUr2FsG8n1SY0NqBwjIZpNc+51WUhmRMOGXsaUejTZSC+jl1nyJOL90P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322701411"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322701411"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:45:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="661759384"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="661759384"
Received: from lab-ah.igk.intel.com ([10.102.42.211])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:45:35 -0800
From:   Andrzej Hajda <andrzej.hajda@intel.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 6/7] qed: use __xchg if possible
Date:   Wed, 18 Jan 2023 16:44:49 +0100
Message-Id: <20230118154450.73842-6-andrzej.hajda@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118154450.73842-1-andrzej.hajda@intel.com>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <20230118154450.73842-1-andrzej.hajda@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently introduced helper simplifies the code.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 include/linux/qed/qed_chain.h | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/linux/qed/qed_chain.h b/include/linux/qed/qed_chain.h
index a84063492c71ae..6355d558cf01b2 100644
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
-- 
2.34.1

