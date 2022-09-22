Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A575E6070
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiIVLFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiIVLFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:05:22 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C913FD74DA;
        Thu, 22 Sep 2022 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844384;
        bh=/QQrNnvXDKnSREykPdUSiR8Sh8yIfQgEV+lIvslB0AQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuIbajCgNovoaQ0oztWQ795DD8FSseu3sMjHG8HMB1Cep28Az9Qaf4qlSn4jaU8DA
         icc8MOGKQu2TlhRJ+9V/ukHI6m10DKbP5FoDbQtCclesUo56LzkRakfZqo6INcQjyb
         qZQk+uvXlBmOSWH7fyXUeryD6rN4vj8NudIIlYLjxGvgBAswPgLyMBCWUKRkXVP8LN
         AzKSiuLktrBe7Hbb7916OQ9o5CtuSNDzZ0uGNAesr8rtpCtrdALtxQfJ1ZQ40uC9wG
         nQaO5ZqiiudV0wZKaoKBQCjHhjLKabV45FuXdS0TFulQ9tZdbV81HJfXYHCRyZa7Us
         mCbcNS1pvp/Uw==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3N3RLszNbv;
        Thu, 22 Sep 2022 06:59:44 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 07/25] lib: Implement find_{first,next}_{zero,one}_and_zero_bit
Date:   Thu, 22 Sep 2022 06:59:22 -0400
Message-Id: <20220922105941.237830-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
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

Allow finding the first or next bit within two input bitmasks which is
either:

- both zero and zero,
- respectively one and zero.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/find.h | 110 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/include/linux/find.h b/include/linux/find.h
index 935892da576e..325707b8bd56 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -76,6 +76,66 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 }
 #endif
 
+#ifndef find_next_one_and_zero_bit
+/**
+ * find_next_one_and_zero_bit - find the next bit which is one in addr1 and zero in addr2 memory region
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next bit set in addr1 and cleared in addr2
+ * If no corresponding bits meet this criterion, returns @size.
+ */
+static inline
+unsigned long find_next_one_and_zero_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr1 & ~*addr2 & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, ~0UL, 0);
+}
+#endif
+
+#ifndef find_next_zero_and_zero_bit
+/**
+ * find_next_zero_and_zero_bit - find the next bit which is zero in addr1 and addr2 memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next bit cleared in addr1 and addr2
+ * If no corresponding bits meet this criterion, returns @size.
+ */
+static inline
+unsigned long find_next_zero_and_zero_bit(const unsigned long *addr1,
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
+	return _find_next_bit(addr1, addr2, size, offset, ~0UL, ~0UL, 0);
+}
+#endif
+
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
@@ -173,6 +233,56 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
+#ifndef find_first_one_and_zero_bit
+/**
+ * find_first_one_and_zero_bit - find the first bit which is one in addr1 and zero in addr2 memory region
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the first bit set in addr1 and cleared in addr2
+ * If no corresponding bits meet this criterion, returns @size.
+ */
+static inline
+unsigned long find_first_one_and_zero_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & ~*addr2 & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_bit(addr1, addr2, size, 0, 0UL, ~0UL, 0);
+}
+#endif
+
+#ifndef find_first_zero_and_zero_bit
+/**
+ * find_first_zero_and_zero_bit - find the first bit which is zero in addr1 and addr2 memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the first bit cleared in addr1 and addr2
+ * If no corresponding bits meet this criterion, returns @size.
+ */
+static inline
+unsigned long find_first_zero_and_zero_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = ~*addr1 & ~*addr2 & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_bit(addr1, addr2, size, 0, ~0UL, ~0UL, 0);
+}
+#endif
+
 #ifndef find_last_bit
 /**
  * find_last_bit - find the last set bit in a memory region
-- 
2.25.1

