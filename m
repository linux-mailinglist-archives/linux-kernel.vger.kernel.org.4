Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE145B9286
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIOCHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiIOCHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:07:39 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA1D8E9AE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:07:38 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id cj27so434936qtb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=D2+7cCsVxWQuJxreBgAxCUqwVsvEMV0WKolCrPdQo9s=;
        b=LkVN93nD5+CfQcifA7mk/QAmkSOEA1E7M7PSWCs0RY897s7vx9bMIrk9q1R81AfafG
         JJ8sJz4yyo7Lo8GQjC3IGcT0+fKgUDNSGwl+m23KZeJxRaGGu17VdVpCCJLUx7ngyEB2
         M4GkkVT1CargLzseq5Gi3GaE76d1k0UnH5yBg0Bhuee4ya5/JEgtCqkMInsJo7a2lzv0
         ph/Ju2Iq/uW3PXdjGLttzGDCJ/B/Z8fN54GAE8fpRqDdDsRKNbB4qPnALU8JRTHn+Qoz
         1Idv5y34jx1st/wdlVOpms2IR9et/d2G65bldlKeq9KffKcgJF/qokLVMXrEFJIlj7iq
         ZrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=D2+7cCsVxWQuJxreBgAxCUqwVsvEMV0WKolCrPdQo9s=;
        b=Gb18rllu4otx5RWYCC0OgN4iSRsnQumUlYA4KJ8MEiOutBe7q+kgDbFADlkkz3DJFF
         CD7tVB5JNQOOlyi5rRwPEqocdOJSHDYazy/7aa13VCEYlzuHy0ihzlhXYkJh62GTuob3
         ZZcSppp0tbxPbHjdQt2MbhVRoXzcYZoGC3vvuxxS9UqK0uzLCtifIQJwm5JleKgGS1jV
         eWc3PMIdzPmJ08JBspmwcnO8tHQ43uyfAjLorgInWrAwvj10FOn8e4ynHq/mA85226c3
         6l+uLTvHML167S9fJj/XwdMwHDlkOo9wUNBH3YSCqCGd4vWvCDEn1967bkyxqL4DGpH9
         UWcw==
X-Gm-Message-State: ACgBeo2kmSAS9lxc9oEvWCRxwgz9r/pwfPfM5f4gIvK/CVTLaiUqkrO0
        4vdQAHEexPQ4m1ZF/rTOSHA=
X-Google-Smtp-Source: AA6agR44yYVr1Jlzy50qD7g6yi2RLqNn6EssYR5fc4KMn/CUOcdOKmka5QKyW1mKcMQIH9jiDqVgcA==
X-Received: by 2002:ac8:5b53:0:b0:35b:a628:873c with SMTP id n19-20020ac85b53000000b0035ba628873cmr23051922qtw.398.1663207657161;
        Wed, 14 Sep 2022 19:07:37 -0700 (PDT)
Received: from localhost (96-87-29-153-static.hfc.comcastbusiness.net. [96.87.29.153])
        by smtp.gmail.com with ESMTPSA id br36-20020a05620a462400b006cbbc3daaacsm2919544qkb.113.2022.09.14.19.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 19:07:36 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Valentin Schneider <vschneid@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 3/4] lib/find_bit: optimize find_next_bit() functions
Date:   Wed, 14 Sep 2022 19:07:29 -0700
Message-Id: <20220915020730.852234-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220915020730.852234-1-yury.norov@gmail.com>
References: <20220915020730.852234-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over the past couple years, the function _find_next_bit() was extended
with parameters that modify its behavior to implement and- zero- and le-
flavors. The parameters are passed at compile time, but current design
prevents a compiler from optimizing out the conditionals.

As find_next_bit() API grows, I expect that more parameters will be added.
Current design would require more conditional code in _find_next_bit(),
which would bloat the helper even more and make it barely readable.

This patch replaces _find_next_bit() with a macro FIND_NEXT_BIT, and adds
a set of wrappers, so that the compile-time optimizations become possible.

The common logic is moved to the new macro, and all flavors may be
generated by providing a FETCH macro parameter, like in this example:

  #define FIND_NEXT_BIT(FETCH, MUNGE, size, start) ...

  find_next_xornot_and_bit(addr1, addr2, addr3, size, start)
  {
	return FIND_NEXT_BIT(addr1[idx] ^ ~addr2[idx] & addr3[idx],
				/* nop */, size, start);
  }

The FETCH may be of any complexity, as soon as it only refers the bitmap(s)
and an iterator idx.

MUNGE is here to support _le code generation for BE builds. May be
empty.

I ran find_bit_benchmark 16 times on top of 6.0-rc2 and 16 times on top
of 6.0-rc2 + this series. The results for kvm/x86_64 are:

                      v6.0-rc2  Optimized       Difference  Z-score
Random dense bitmap         ns         ns        ns      %
find_next_bit:          787735     670546    117189   14.9     3.97
find_next_zero_bit:     777492     664208    113284   14.6    10.51
find_last_bit:          830925     687573    143352   17.3     2.35
find_first_bit:        3874366    3306635    567731   14.7     1.84
find_first_and_bit:   40677125   37739887   2937238    7.2     1.36
find_next_and_bit:      347865     304456     43409   12.5     1.35

Random sparse bitmap
find_next_bit:           19816      14021      5795   29.2     6.10
find_next_zero_bit:    1318901    1223794     95107    7.2     1.41
find_last_bit:           14573      13514      1059    7.3     6.92
find_first_bit:        1313321    1249024     64297    4.9     1.53
find_first_and_bit:       8921       8098       823    9.2     4.56
find_next_and_bit:        9796       7176      2620   26.7     5.39

Where the statistics is significant (z-score > 3), the improvement
is ~15%.

According to the bloat-o-meter, the Image size is 10-11K less:

x86_64/defconfig:
add/remove: 32/14 grow/shrink: 61/782 up/down: 6344/-16521 (-10177)

arm64/defconfig:
add/remove: 3/2 grow/shrink: 50/714 up/down: 608/-11556 (-10948)

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h |  23 ++++++---
 lib/find_bit.c       | 119 +++++++++++++++++++++++++------------------
 2 files changed, 85 insertions(+), 57 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 2464bff5de04..dead6f53a97b 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -8,9 +8,12 @@
 
 #include <linux/bitops.h>
 
-extern unsigned long _find_next_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le);
+unsigned long _find_next_bit(const unsigned long *addr1, unsigned long nbits,
+				unsigned long start);
+unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start);
+unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
+					 unsigned long start);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
@@ -19,6 +22,10 @@ extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long siz
 
 #ifdef __BIG_ENDIAN
 unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size);
+unsigned long _find_next_zero_bit_le(const  unsigned long *addr, unsigned
+					long size, unsigned long offset);
+unsigned long _find_next_bit_le(const unsigned long *addr, unsigned
+				long size, unsigned long offset);
 #endif
 
 #ifndef find_next_bit
@@ -45,7 +52,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+	return _find_next_bit(addr, size, offset);
 }
 #endif
 
@@ -75,7 +82,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+	return _find_next_and_bit(addr1, addr2, size, offset);
 }
 #endif
 
@@ -103,7 +110,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+	return _find_next_zero_bit(addr, size, offset);
 }
 #endif
 
@@ -251,7 +258,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		return val == ~0UL ? size : ffz(val);
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+	return _find_next_zero_bit_le(addr, size, offset);
 }
 #endif
 
@@ -284,7 +291,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 		return val ? __ffs(val) : size;
 	}
 
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
+	return _find_next_bit_le(addr, size, offset);
 }
 #endif
 
diff --git a/lib/find_bit.c b/lib/find_bit.c
index f4d9b9684811..8707b4ef3e5e 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -40,57 +40,33 @@
 	sz;									\
 })
 
-#if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
-	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
-	!defined(find_next_and_bit)
 /*
- * This is a common helper function for find_next_bit, find_next_zero_bit, and
- * find_next_and_bit. The differences are:
- *  - The "invert" argument, which is XORed with each fetched word before
- *    searching it for one bits.
- *  - The optional "addr2", which is anded with "addr1" if present.
+ * Common helper for find_next_bit() function family
+ * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
+ * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
+ * @size: The bitmap size in bits
+ * @start: The bitnumber to start searching at
  */
-unsigned long _find_next_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert, unsigned long le)
-{
-	unsigned long tmp, mask;
-
-	if (unlikely(start >= nbits))
-		return nbits;
-
-	tmp = addr1[start / BITS_PER_LONG];
-	if (addr2)
-		tmp &= addr2[start / BITS_PER_LONG];
-	tmp ^= invert;
-
-	/* Handle 1st word. */
-	mask = BITMAP_FIRST_WORD_MASK(start);
-	if (le)
-		mask = swab(mask);
-
-	tmp &= mask;
-
-	start = round_down(start, BITS_PER_LONG);
-
-	while (!tmp) {
-		start += BITS_PER_LONG;
-		if (start >= nbits)
-			return nbits;
-
-		tmp = addr1[start / BITS_PER_LONG];
-		if (addr2)
-			tmp &= addr2[start / BITS_PER_LONG];
-		tmp ^= invert;
-	}
-
-	if (le)
-		tmp = swab(tmp);
-
-	return min(start + __ffs(tmp), nbits);
-}
-EXPORT_SYMBOL(_find_next_bit);
-#endif
+#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)				\
+({										\
+	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
+										\
+	if (unlikely(__start >= sz))						\
+		goto out;							\
+										\
+	mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));				\
+	idx = __start / BITS_PER_LONG;						\
+										\
+	for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {			\
+		if ((idx + 1) * BITS_PER_LONG >= sz)				\
+			goto out;						\
+		idx++;								\
+	}									\
+										\
+	sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(tmp)), sz);			\
+out:										\
+	sz;									\
+})
 
 #ifndef find_first_bit
 /*
@@ -127,6 +103,32 @@ unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size
 EXPORT_SYMBOL(_find_first_zero_bit);
 #endif
 
+#ifndef find_next_bit
+unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_bit);
+#endif
+
+#ifndef find_next_and_bit
+unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr1[idx] & addr2[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_and_bit);
+#endif
+
+#ifndef find_next_zero_bit
+unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
+					 unsigned long start)
+{
+	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_zero_bit);
+#endif
+
 #ifndef find_last_bit
 unsigned long _find_last_bit(const unsigned long *addr, unsigned long size)
 {
@@ -173,4 +175,23 @@ unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long s
 EXPORT_SYMBOL(_find_first_zero_bit_le);
 #endif
 
+#ifndef find_next_zero_bit_le
+unsigned long _find_next_zero_bit_le(const unsigned long *addr, unsigned
+		long size, unsigned long offset)
+{
+	return FIND_NEXT_BIT(~addr[idx], swab, size, offset);
+}
+EXPORT_SYMBOL(_find_next_zero_bit_le);
+#endif
+
+#ifndef find_next_bit_le
+unsigned long _find_next_bit_le(const unsigned long  *addr, unsigned
+		long size, unsigned long offset)
+{
+	return FIND_NEXT_BIT(addr[idx], swab, size, offset);
+}
+EXPORT_SYMBOL(_find_next_bit_le);
+
+#endif
+
 #endif /* __BIG_ENDIAN */
-- 
2.34.1

