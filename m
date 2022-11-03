Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896E6618942
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiKCUFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiKCUFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:05:00 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B92034F;
        Thu,  3 Nov 2022 13:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667505897;
        bh=yXMCQTJUBVpgK2HTSfnSaD1+EBfTlpw5kc6q1ePvqj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PX7mVB4AbWTz7C0kIbwTzWLVhDu9iR1/2N6wfo7RmJYJsORUgHmcXRCAd0xvRAHv7
         DXWh03M/4BJOlNgqS1ZgQzF8UqBz/jB9/7su1eF1jC8I1rLtKk7XJ0APZFgXlgLccj
         NfBZoU+kHlhIDZ273o0fpXCQ25oOg3ctODMLbD3R3pMdKrs6idIiCV42MH1WqzVtxi
         asS6vxrX2gKT9oGasRGXMrKD90XR10NFekdxCXSoojOUV6h5uuxaCAoG3014ZvTViz
         ar045vXY2WwYLrNxP/VjNlxXgjev7GsulEVyUXCV3nOQ0TRgMRSi2k1flWq42Q9rvT
         7oA1QQQB5Ri7Q==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N3F950gLZzftP;
        Thu,  3 Nov 2022 16:04:57 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v5 06/24] lib: Implement find_{first,next,nth}_notandnot_bit, find_first_andnot_bit
Date:   Thu,  3 Nov 2022 16:03:41 -0400
Message-Id: <20221103200359.328736-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow finding the first, next, or nth bit within two input bitmasks
which is zero in both masks.

Allow fiding the first bit within two input bitmasks which is set in
first mask and cleared in the second mask. find_next_andnot_bit and
find_nth_andnot_bit already exist, so find the first bit appears to be
missing.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/find.h | 123 +++++++++++++++++++++++++++++++++++++++++--
 lib/find_bit.c       |  42 +++++++++++++++
 2 files changed, 161 insertions(+), 4 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index ccaf61a0f5fd..43c3db92a096 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -14,6 +14,8 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
 					unsigned long nbits, unsigned long start);
 unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start);
+unsigned long _find_next_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start);
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
 					 unsigned long start);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
@@ -22,8 +24,14 @@ unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long
 				unsigned long size, unsigned long n);
 unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long size, unsigned long n);
+unsigned long __find_nth_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long size, unsigned long n);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
+extern unsigned long _find_first_andnot_bit(const unsigned long *addr1,
+					 const unsigned long *addr2, unsigned long size);
+extern unsigned long _find_first_notandnot_bit(const unsigned long *addr1,
+					 const unsigned long *addr2, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
@@ -95,15 +103,14 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 
 #ifndef find_next_andnot_bit
 /**
- * find_next_andnot_bit - find the next set bit in *addr1 excluding all the bits
- *                        in *addr2
+ * find_next_andnot_bit - find the next bit set in *addr1, cleared in *addr2
  * @addr1: The first address to base the search on
  * @addr2: The second address to base the search on
  * @size: The bitmap size in bits
  * @offset: The bitnumber to start searching at
  *
- * Returns the bit number for the next set bit
- * If no bits are set, returns @size.
+ * Returns the bit number for the next bit set in *addr1, cleared in *addr2
+ * If no such bits are found, returns @size.
  */
 static inline
 unsigned long find_next_andnot_bit(const unsigned long *addr1,
@@ -124,6 +131,37 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
 }
 #endif
 
+#ifndef find_next_notandnot_bit
+/**
+ * find_next_notandnot_bit - find the next bit cleared in both *addr1 and *addr2
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * Returns the bit number for the next bit cleared in both *addr1 and *addr2
+ * If no such bits are found, returns @size.
+ */
+static inline
+unsigned long find_next_notandnot_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = ~*addr1 & ~*addr2 & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_notandnot_bit(addr1, addr2, size, offset);
+}
+#endif
+
+
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
@@ -255,6 +293,32 @@ unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned lon
 	return __find_nth_andnot_bit(addr1, addr2, size, n);
 }
 
+/**
+ * find_nth_notandnot_bit - find N'th cleared bit in 2 memory regions.
+ * @addr1: The 1st address to start the search at
+ * @addr2: The 2nd address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed, counting from 0
+ *
+ * Returns the bit number of the N'th cleared bit.
+ * If no such, returns @size.
+ */
+static inline
+unsigned long find_nth_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n)
+{
+	if (n >= size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val =  (~*addr1) & (~*addr2) & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return __find_nth_notandnot_bit(addr1, addr2, size, n);
+}
+
 #ifndef find_first_and_bit
 /**
  * find_first_and_bit - find the first set bit in both memory regions
@@ -280,6 +344,57 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 }
 #endif
 
+#ifndef find_first_andnot_bit
+/**
+ * find_first_andnot_bit - find first set bit in 2 memory regions,
+ *			   flipping bits in 2nd region
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_first_andnot_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & (~*addr2) & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_andnot_bit(addr1, addr2, size);
+}
+#endif
+
+#ifndef find_first_notandnot_bit
+/**
+ * find_first_notandnot_bit - find first cleared bit in 2 memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next cleared bit
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_first_notandnot_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = (~*addr1) & (~*addr2) & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_notandnot_bit(addr1, addr2, size);
+}
+#endif
+
 #ifndef find_first_zero_bit
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 18bc0a7ac8ee..a1f592f2437e 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -116,6 +116,32 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
 
+#ifndef find_first_andnot_bit
+/*
+ * Find the first set bit in two memory regions, flipping bits in 2nd region.
+ */
+unsigned long _find_first_andnot_bit(const unsigned long *addr1,
+				  const unsigned long *addr2,
+				  unsigned long size)
+{
+	return FIND_FIRST_BIT(addr1[idx] & ~addr2[idx], /* nop */, size);
+}
+EXPORT_SYMBOL(_find_first_andnot_bit);
+#endif
+
+#ifndef find_first_notandnot_bit
+/*
+ * Find the first cleared bit in two memory regions.
+ */
+unsigned long _find_first_notandnot_bit(const unsigned long *addr1,
+				  const unsigned long *addr2,
+				  unsigned long size)
+{
+	return FIND_FIRST_BIT(~addr1[idx] & ~addr2[idx], /* nop */, size);
+}
+EXPORT_SYMBOL(_find_first_notandnot_bit);
+#endif
+
 #ifndef find_first_zero_bit
 /*
  * Find the first cleared bit in a memory region.
@@ -155,6 +181,13 @@ unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned l
 }
 EXPORT_SYMBOL(__find_nth_andnot_bit);
 
+unsigned long __find_nth_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+				 unsigned long size, unsigned long n)
+{
+	return FIND_NTH_BIT(~addr1[idx] & ~addr2[idx], size, n);
+}
+EXPORT_SYMBOL(__find_nth_notandnot_bit);
+
 #ifndef find_next_and_bit
 unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start)
@@ -173,6 +206,15 @@ unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned l
 EXPORT_SYMBOL(_find_next_andnot_bit);
 #endif
 
+#ifndef find_next_notandnot_bit
+unsigned long _find_next_notandnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(~addr1[idx] & ~addr2[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_notandnot_bit);
+#endif
+
 #ifndef find_next_zero_bit
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
 					 unsigned long start)
-- 
2.25.1

