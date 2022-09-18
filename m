Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000805BBB33
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIRDHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIRDHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:07:24 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EF327159
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:22 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id s13so19545248qvq.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LgocecjigwU3Agdjb8TY62Q6ibOCi0iPSWcnW4GUNJI=;
        b=BJeCZHOcdO6zOBUNdIxK5z8bIM1M8Gyv2hCjpc/o95fdn8kVtR4ype/fy3q/91YWDo
         //M6Z2kV6swHFlHTa8GX+sAVHlI5Nu3HHvMfSP+qvXUCPhjAHo6v1DPa2Ogw+FYQxMy8
         CQTuEj3VFXsSAUxYOfRElmOxbKIdctzLuGAKo/4fp6gIpmbCed8b3L5WEafJPUFwWldz
         4xphSCxGiWE5FcalqxvWJCDT/hVJDD6tlLfNHhxhjkoIWD/u1vtObyTS5LaFLx8R11bJ
         NxePgECU7eqqNDE3TYScGblkGBDP1QKM97RKaejDj20J1agJrnQbiGGx91HWW5dOX7Xy
         lWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LgocecjigwU3Agdjb8TY62Q6ibOCi0iPSWcnW4GUNJI=;
        b=cPJ/hgKXi9wPD0dFnFgFeoDSrvtYuV0w/+zz8gWh4v4udSWZW4cbtCCsTqr9AX9NeU
         JQ5Wppz7r1CUgSUH3XpvfqwrrJ1qtK3ztGsh/d3VWzzNMWfyAl/XabejAVBQ7RirkaOM
         UrSqDovl/2s1OqfIcqlPIVNXGsWmpgrruJC0gTh7FlY9UfrTEV+QVq2KnciUnGpSfLzg
         OUB9m/63B0sn6fdgpKdcqDAI6LOBi3+fKTR8z2jLa9nyYOyFTJ5YRwUseuCmLP4u1ksc
         8zJyHjyQATkNchn82jEiDou0AnNMNsnBPBfMEH8mSR0E4AFzgUeftUH7h13ynAQEVi5z
         lXIQ==
X-Gm-Message-State: ACrzQf3v6lgIm+z5vfz4E1908/P5SiN+uMiuInR2iQL4MDz5CSRCvM/o
        amVoM4oIpKd8/dtztIkH+vBi451jhto=
X-Google-Smtp-Source: AMsMyM6ZvR5uibZiHzw8/3Ayi1vOpODJ2r5OJE4qvSBCQn+Q7uunbB95pLT3hZyN5gmttiseOshRuQ==
X-Received: by 2002:ad4:5961:0:b0:4ad:2406:e014 with SMTP id eq1-20020ad45961000000b004ad2406e014mr4097608qvb.119.1663470441720;
        Sat, 17 Sep 2022 20:07:21 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:a495:2224:867e:566a])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a0f0f00b0069fe1dfbeffsm9739734qkl.92.2022.09.17.20.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:07:21 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 3/6] lib: add find_nth{,_and,_andnot}_bit()
Date:   Sat, 17 Sep 2022 20:07:13 -0700
Message-Id: <20220918030716.1252285-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220918030716.1252285-1-yury.norov@gmail.com>
References: <20220918030716.1252285-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel lacks for a function that searches for Nth bit in a bitmap.
Usually people do it like this:
	for_each_set_bit(bit, mask, size)
		if (n-- == 0)
			return bit;

We can do it more efficiently, if we:
1. find a word containing Nth bit, using hweight(); and
2. find the bit, using a helper fns(), that works similarly to
   __ffs() and ffz().

fns() is implemented as a simple loop. For x86_64, there's PDEP instruction
to do that: ret = clz(pdep(1 << idx, num)). However, for large bitmaps the
most of improvement comes from using hweight(), so I kept fns() simple.

New find_nth_bit() is ~70 times faster on x86_64/kvm in find_bit benchmark:
find_nth_bit:                  7154190 ns,  16411 iterations
for_each_bit:                505493126 ns,  16315 iterations

With all that, a family of 3 new functions is added, and used where
appropriate in the following patches.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
Comparing to v2, it adds a path that allows quit earlier if the
condition can't be met:
	for (idx = 0; (idx + 1) * BITS_PER_LONG <= sz; idx++) {	
 +		if (idx * BITS_PER_LONG + nr >= sz)
 +			goto out;
 	...

 include/linux/bitops.h | 19 ++++++++++
 include/linux/find.h   | 86 ++++++++++++++++++++++++++++++++++++++++++
 lib/find_bit.c         | 44 +++++++++++++++++++++
 3 files changed, 149 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 3b89c64bcfd8..d7dd83fafeba 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -247,6 +247,25 @@ static inline unsigned long __ffs64(u64 word)
 	return __ffs((unsigned long)word);
 }
 
+/**
+ * fns - find N'th set bit in a word
+ * @word: The word to search
+ * @n: Bit to find
+ */
+static inline unsigned long fns(unsigned long word, unsigned int n)
+{
+	unsigned int bit;
+
+	while (word) {
+		bit = __ffs(word);
+		if (n-- == 0)
+			return bit;
+		__clear_bit(bit, &word);
+	}
+
+	return BITS_PER_LONG;
+}
+
 /**
  * assign_bit - Assign value to a bit in memory
  * @nr: the bit to set
diff --git a/include/linux/find.h b/include/linux/find.h
index dead6f53a97b..b100944daba0 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -15,6 +15,11 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
 					 unsigned long start);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
+unsigned long __find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n);
+unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n);
+unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long size, unsigned long n);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
@@ -136,6 +141,87 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
+/**
+ * find_nth_bit - find N'th set bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed, counting from 0
+ *
+ * The following is semantically equivalent:
+ *	 idx = find_nth_bit(addr, size, 0);
+ *	 idx = find_first_bit(addr, size);
+ *
+ * Returns the bit number of the N'th set bit.
+ * If no such, returns @size.
+ */
+static inline
+unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
+{
+	if (n >= size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val =  *addr & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return __find_nth_bit(addr, size, n);
+}
+
+/**
+ * find_nth_and_bit - find N'th set bit in 2 memory regions
+ * @addr1: The 1st address to start the search at
+ * @addr2: The 2nd address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed, counting from 0
+ *
+ * Returns the bit number of the N'th set bit.
+ * If no such, returns @size.
+ */
+static inline
+unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n)
+{
+	if (n >= size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val =  *addr1 & *addr2 & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return __find_nth_and_bit(addr1, addr2, size, n);
+}
+
+/**
+ * find_nth_andnot_bit - find N'th set bit in 2 memory regions,
+ *			 flipping bits in 2nd region
+ * @addr1: The 1st address to start the search at
+ * @addr2: The 2nd address to start the search at
+ * @size: The maximum number of bits to search
+ * @n: The number of set bit, which position is needed, counting from 0
+ *
+ * Returns the bit number of the N'th set bit.
+ * If no such, returns @size.
+ */
+static inline
+unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+				unsigned long size, unsigned long n)
+{
+	if (n >= size)
+		return size;
+
+	if (small_const_nbits(size)) {
+		unsigned long val =  *addr1 & (~*addr2) & GENMASK(size - 1, 0);
+
+		return val ? fns(val, n) : size;
+	}
+
+	return __find_nth_andnot_bit(addr1, addr2, size, n);
+}
+
 #ifndef find_first_and_bit
 /**
  * find_first_and_bit - find the first set bit in both memory regions
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 8707b4ef3e5e..ae2a59b59bfe 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -68,6 +68,30 @@ out:										\
 	sz;									\
 })
 
+#define FIND_NTH_BIT(FETCH, size, num)						\
+({										\
+	unsigned long sz = (size), nr = (num), idx, w, tmp;			\
+										\
+	for (idx = 0; (idx + 1) * BITS_PER_LONG <= sz; idx++) {			\
+		if (idx * BITS_PER_LONG + nr >= sz)				\
+			goto out;						\
+										\
+		tmp = (FETCH);							\
+		w = hweight_long(tmp);						\
+		if (w > nr)							\
+			goto found;						\
+										\
+		nr -= w;							\
+	}									\
+										\
+	if (sz % BITS_PER_LONG)							\
+		tmp = (FETCH) & BITMAP_LAST_WORD_MASK(sz);			\
+found:										\
+	sz = min(idx * BITS_PER_LONG + fns(tmp, nr), sz);			\
+out:										\
+	sz;									\
+})
+
 #ifndef find_first_bit
 /*
  * Find the first set bit in a memory region.
@@ -111,6 +135,26 @@ unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, uns
 EXPORT_SYMBOL(_find_next_bit);
 #endif
 
+unsigned long __find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
+{
+	return FIND_NTH_BIT(addr[idx], size, n);
+}
+EXPORT_SYMBOL(__find_nth_bit);
+
+unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
+				 unsigned long size, unsigned long n)
+{
+	return FIND_NTH_BIT(addr1[idx] & addr2[idx], size, n);
+}
+EXPORT_SYMBOL(__find_nth_and_bit);
+
+unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+				 unsigned long size, unsigned long n)
+{
+	return FIND_NTH_BIT(addr1[idx] & ~addr2[idx], size, n);
+}
+EXPORT_SYMBOL(__find_nth_andnot_bit);
+
 #ifndef find_next_and_bit
 unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start)
-- 
2.34.1

