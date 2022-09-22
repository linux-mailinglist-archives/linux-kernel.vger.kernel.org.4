Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFEE5E6072
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiIVLFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiIVLFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:05:22 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F674D576F;
        Thu, 22 Sep 2022 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844384;
        bh=21DNDOSplsyPlSUPYYBlMZUm5y1BGHsngt2eyXoJv2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q87FssiJvDuEgVxaoBcV/5mvbwaefec+DJwyjS1nYHm/1ES9zGJhb8jIjEg/RJY+t
         Pl6UXq8b+XNBhe1/eNQnwDJHAAEfjbBt15ju4bl0bwSi5h2nB3AaXGA9cCnNsVaesL
         WYaFxRI3TACgxBLatJKG6c3plvM0ldtuBxqiQLAwN4LIgDNhVrgDguLLvN2nMEtTe/
         rcDsCV/tjtAT7JJMQRROTjTSzLpnBnEMq0yri9S95+6J1xfO7bY3qImH0CBWOVVill
         wmi3AZDbsilQipA59ZsM9fsI1QS4EXL80TA1dtJiYQzyR/qZi12RoT9z8YtVjt2+cf
         +TuqN6uZaDsiQ==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3N0wXmzNL6;
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
Subject: [PATCH v4 06/25] lib: Invert _find_next_bit source arguments
Date:   Thu, 22 Sep 2022 06:59:21 -0400
Message-Id: <20220922105941.237830-7-mathieu.desnoyers@efficios.com>
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

Apply bit-invert operations before the AND operation in _find_next_bit.
Allows AND operations on combined bitmasks in which we search either for
one or zero, e.g.: find first bit which is both zero in one bitmask AND
one in the second bitmask.

The existing use for find first zero bit does not use the second
argument, so whether the inversion is performed before or after the AND
operator does not matter.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/find.h       | 13 +++++++------
 lib/find_bit.c             | 17 ++++++++---------
 tools/include/linux/find.h |  9 +++++----
 tools/lib/find_bit.c       | 17 ++++++++---------
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 424ef67d4a42..935892da576e 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -10,7 +10,8 @@
 
 extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le);
+		unsigned long start, unsigned long invert_src1,
+		unsigned long src2, unsigned long le);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
@@ -41,7 +42,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0UL, 0);
 }
 #endif
 
@@ -71,7 +72,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0UL, 0);
 }
 #endif
 
@@ -99,7 +100,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0UL, 0);
 }
 #endif
 
@@ -247,7 +248,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0UL, 1);
 }
 #endif
 
@@ -266,7 +267,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0UL, 1);
 }
 #endif
 
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 1b8e4b2a9cba..73e78565e691 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -25,23 +25,23 @@
 /*
  * This is a common helper function for find_next_bit, find_next_zero_bit, and
  * find_next_and_bit. The differences are:
- *  - The "invert" argument, which is XORed with each fetched word before
- *    searching it for one bits.
+ *  - The "invert_src1" and "invert_src2" arguments, which are XORed to
+ *    each source word before applying the 'and' operator.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
 unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
+		unsigned long start, unsigned long invert_src1,
+		unsigned long invert_src2, unsigned long le)
 {
 	unsigned long tmp, mask;
 
 	if (unlikely(start >= nbits))
 		return nbits;
 
-	tmp = addr1[start / BITS_PER_LONG];
+	tmp = addr1[start / BITS_PER_LONG] ^ invert_src1;
 	if (addr2)
-		tmp &= addr2[start / BITS_PER_LONG];
-	tmp ^= invert;
+		tmp &= addr2[start / BITS_PER_LONG] ^ invert_src2;
 
 	/* Handle 1st word. */
 	mask = BITMAP_FIRST_WORD_MASK(start);
@@ -57,10 +57,9 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 		if (start >= nbits)
 			return nbits;
 
-		tmp = addr1[start / BITS_PER_LONG];
+		tmp = addr1[start / BITS_PER_LONG] ^ invert_src1;
 		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
-		tmp ^= invert;
+			tmp &= addr2[start / BITS_PER_LONG] ^ invert_src2;
 	}
 
 	if (le)
diff --git a/tools/include/linux/find.h b/tools/include/linux/find.h
index 47e2bd6c5174..5ab0c95086ad 100644
--- a/tools/include/linux/find.h
+++ b/tools/include/linux/find.h
@@ -10,7 +10,8 @@
 
 extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le);
+		unsigned long start, unsigned long invert_src1,
+		unsigned long src2, unsigned long le);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
@@ -41,7 +42,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0UL, 0);
 }
 #endif
 
@@ -71,7 +72,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0UL, 0);
 }
 #endif
 
@@ -99,7 +100,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0UL, 0);
 }
 #endif
 
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index ba4b8d94e004..4176232de7f9 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -24,13 +24,14 @@
 /*
  * This is a common helper function for find_next_bit, find_next_zero_bit, and
  * find_next_and_bit. The differences are:
- *  - The "invert" argument, which is XORed with each fetched word before
- *    searching it for one bits.
+ *  - The "invert_src1" and "invert_src2" arguments, which are XORed to
+ *    each source word before applying the 'and' operator.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
 unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
+		unsigned long start, unsigned long invert_src1,
+		unsigned long invert_src2, unsigned long le)
 {
 	unsigned long tmp, mask;
 	(void) le;
@@ -38,10 +39,9 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 	if (unlikely(start >= nbits))
 		return nbits;
 
-	tmp = addr1[start / BITS_PER_LONG];
+	tmp = addr1[start / BITS_PER_LONG] ^ invert_src1;
 	if (addr2)
-		tmp &= addr2[start / BITS_PER_LONG];
-	tmp ^= invert;
+		tmp &= addr2[start / BITS_PER_LONG] ^ invert_src2;
 
 	/* Handle 1st word. */
 	mask = BITMAP_FIRST_WORD_MASK(start);
@@ -64,10 +64,9 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 		if (start >= nbits)
 			return nbits;
 
-		tmp = addr1[start / BITS_PER_LONG];
+		tmp = addr1[start / BITS_PER_LONG] ^ invert_src1;
 		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
-		tmp ^= invert;
+			tmp &= addr2[start / BITS_PER_LONG] ^ invert_src2;
 	}
 
 #if (0)
-- 
2.25.1

