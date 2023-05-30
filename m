Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB6715DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjE3Ln7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjE3LnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:43:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E451E1AE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685446982; x=1716982982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T+5BgzerfUplRpvMQvIlOZ5Zgc42+1QfY36GKGxTzgo=;
  b=cj6T/+B2T1KFZaQKsANNWi6oizgcyCRr9KVABPoafSwXCvvq9rz2xm6+
   w8nXfi3ooFW6vXKWVXCYKK/Xffx3vuCgge2g/FI7ED9o9LF7WRzISH2b2
   tdQGZumgQmq9qhU7u4hlkTsSouAHMn5V3mFcgX6q1RGoCEWVhF1v5zFwU
   tyly4NpnYDNOV6xW+yPFVp6Jmh//GqcAWePMuE1UrqtPVbuNcsWU2aFVw
   7M0YyzKHy8pk1mGk5BPK9bUxJtzXjdbHoXzra4M2eJ41E+M0G5EjOTlpu
   FIrQhMRKIus7dvSblWd6txyqHk+7ODQ4hAy/eNaTPBHav7LNR9LYzHnKq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="383145342"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383145342"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700588657"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="700588657"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2023 04:42:59 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 02/12] x86/asm: Introduce inline memcpy and memset
Date:   Tue, 30 May 2023 14:42:37 +0300
Message-Id: <20230530114247.21821-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530114247.21821-1-alexander.shishkin@linux.intel.com>
References: <20230530114247.21821-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Provide inline memcpy and memset functions that can be used instead of
the GCC builtins whenever necessary.

Code posted by Peter Zijlstra <peterz@infradead.org>.
Link: https://lore.kernel.org/lkml/Y759AJ%2F0N9fqwDED@hirez.programming.kicks-ass.net/
[Missing Signed-off-by from PeterZ]
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/string_32.h | 21 +++++++++++++++++++++
 arch/x86/include/asm/string_64.h | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 32c0d981a82a..8896270e5eda 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -151,6 +151,16 @@ extern void *memcpy(void *, const void *, size_t);
 
 #endif /* !CONFIG_FORTIFY_SOURCE */
 
+static __always_inline void *__inline_memcpy(void *to, const void *from, size_t len)
+{
+	void *ret = to;
+
+	asm volatile("rep movsb"
+		     : "+D" (to), "+S" (from), "+c" (len)
+		     : : "memory");
+	return ret;
+}
+
 #define __HAVE_ARCH_MEMMOVE
 void *memmove(void *dest, const void *src, size_t n);
 
@@ -195,6 +205,17 @@ extern void *memset(void *, int, size_t);
 #define memset(s, c, count) __builtin_memset(s, c, count)
 #endif /* !CONFIG_FORTIFY_SOURCE */
 
+static __always_inline void *__inline_memset(void *s, int v, size_t n)
+{
+	void *ret = s;
+
+	asm volatile("rep stosb"
+		     : "+D" (s), "+c" (n)
+		     : "a" ((uint8_t)v)
+		     : "memory");
+	return ret;
+}
+
 #define __HAVE_ARCH_MEMSET16
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 857d364b9888..ea51e2d73265 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -18,10 +18,31 @@
 extern void *memcpy(void *to, const void *from, size_t len);
 extern void *__memcpy(void *to, const void *from, size_t len);
 
+static __always_inline void *__inline_memcpy(void *to, const void *from, size_t len)
+{
+	void *ret = to;
+
+	asm volatile("rep movsb"
+		     : "+D" (to), "+S" (from), "+c" (len)
+		     : : "memory");
+	return ret;
+}
+
 #define __HAVE_ARCH_MEMSET
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
 
+static __always_inline void *__inline_memset(void *s, int v, size_t n)
+{
+	void *ret = s;
+
+	asm volatile("rep stosb"
+		     : "+D" (s), "+c" (n)
+		     : "a" ((uint8_t)v)
+		     : "memory");
+	return ret;
+}
+
 /*
  * KMSAN needs to instrument as much code as possible. Use C versions of
  * memsetXX() from lib/string.c under KMSAN.
-- 
2.39.2

