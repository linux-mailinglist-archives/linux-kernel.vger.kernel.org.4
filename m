Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF15BBB32
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiIRDHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIRDHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:07:23 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103352982D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:21 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id h28so18469807qka.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=28qxGuS3wBP5HWmbq1UhK0+iKUABPY0/24xMCB/mxU0=;
        b=jkN6o2n7ceG76VrpNvl/UfZg0xFsLNNx8bitngnNrLejsyCFIAfL54F5Li4umMFyQl
         jKe2CyNbf8y0iyAui0VPsF0gJuuzvuPVdG+YhE71ETGda8TagPQRWKqWuPAhX+Al4XTT
         yfCmqmZSOdQVShOG5meIXXhVGlpbix8+yWwJQdB4gxYPSkIYg6Fsyu6ThnE+h94Ys7H8
         Ww/UKngs81LGPtNPtbUdU49JDxRnDuktxCNiLvBW7GMorwGQu46QTEhyCSFAO9Jo2rt1
         3AXWUC6UgPpPpkySQivL7/sdgWK97eoFMmfjBoSFKOb+rAFJYiT/JS0tHe31UCat+Jio
         +lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=28qxGuS3wBP5HWmbq1UhK0+iKUABPY0/24xMCB/mxU0=;
        b=WYYXJCoIv17dg/QAhGr3c/eL7HjVnWTW78hzt+1C7tKgiKgBFAKJRUtsTP8LYS0Hw6
         oNolPoVVmuRhotRWwol6KrKZ/6u9ZyGwMVIa4uUHvhzyhJCc7AKA+aLTT5UwbITWsFp8
         UU/1uFXs63Du2SVtTbjsl1S8zd7e5C9YNaijiXSMsX6XYhgWh45iX1C+ZsYCDeiiIRqL
         mZvhFeVMXSaVtmeFFIjpr1EPsTmJ/OD49IVujJhV1TQjaeFfH81OS0VZbts+1PSMibWD
         jWZpEeKHEdfKm60f75n1t/HYm9VtvXI+fXwuWyKBt5QeBvyG7/E4S5Nl6IAMCbuBxuph
         Ts/Q==
X-Gm-Message-State: ACrzQf2+vWBZggIb0cpx9D9rNGMMffi/jQfMEwv5P2j309QhsPn1mEr+
        +ZrGRBRySo016v1aSjwxW5vK9W5yIj0=
X-Google-Smtp-Source: AMsMyM4K7Fr1jwBbPPlQnUvqP0q7cqiBR73NcNsSpB9SV8rGTB2SR7kwbVIBn4ZjXP8dQ/p5sFkkJQ==
X-Received: by 2002:a05:620a:1410:b0:6ce:9946:8469 with SMTP id d16-20020a05620a141000b006ce99468469mr9137829qkj.654.1663470440751;
        Sat, 17 Sep 2022 20:07:20 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:a495:2224:867e:566a])
        by smtp.gmail.com with ESMTPSA id l20-20020a05620a28d400b006ce1bfbd603sm9941918qkp.124.2022.09.17.20.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:07:20 -0700 (PDT)
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
Subject: [PATCH v3 2/6] lib/bitmap: add bitmap_weight_and()
Date:   Sat, 17 Sep 2022 20:07:12 -0700
Message-Id: <20220918030716.1252285-3-yury.norov@gmail.com>
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

The function calculates Hamming weight of (bitmap1 & bitmap2). Now we
have to do like this:
	tmp = bitmap_alloc(nbits);
	bitmap_and(tmp, map1, map2, nbits);
	weight = bitmap_weight(tmp, nbits);
	bitmap_free(tmp);

This requires additional memory, adds pressure on alloc subsystem, and
way less cache-friendly than just:
	weight = bitmap_weight_and(map1, map2, nbits);

The following patches apply it for cpumask functions.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h  | 12 ++++++++++++
 include/linux/cpumask.h | 11 +++++++++++
 lib/bitmap.c            | 30 +++++++++++++++++++++---------
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index f65410a49fda..b2aef45af0db 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -51,6 +51,7 @@ struct device;
  *  bitmap_empty(src, nbits)                    Are all bits zero in *src?
  *  bitmap_full(src, nbits)                     Are all bits set in *src?
  *  bitmap_weight(src, nbits)                   Hamming Weight: number set bits
+ *  bitmap_weight_and(src1, src2, nbits)        Hamming Weight of and'ed bitmap
  *  bitmap_set(dst, pos, nbits)                 Set specified bit area
  *  bitmap_clear(dst, pos, nbits)               Clear specified bit area
  *  bitmap_find_next_zero_area(buf, len, pos, n, mask)  Find bit free area
@@ -164,6 +165,8 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
 bool __bitmap_subset(const unsigned long *bitmap1,
 		     const unsigned long *bitmap2, unsigned int nbits);
 unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
+unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
+				 const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 
@@ -439,6 +442,15 @@ unsigned int bitmap_weight(const unsigned long *src, unsigned int nbits)
 	return __bitmap_weight(src, nbits);
 }
 
+static __always_inline
+unsigned long bitmap_weight_and(const unsigned long *src1,
+				const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return hweight_long(*src1 & *src2 & BITMAP_LAST_WORD_MASK(nbits));
+	return __bitmap_weight_and(src1, src2, nbits);
+}
+
 static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 		unsigned int nbits)
 {
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index e8ad12b5b9d2..31bf08c786e3 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -586,6 +586,17 @@ static inline unsigned int cpumask_weight(const struct cpumask *srcp)
 	return bitmap_weight(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
+/**
+ * cpumask_weight_and - Count of bits in (*srcp1 & *srcp2)
+ * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
+ * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
+ */
+static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
+						const struct cpumask *srcp2)
+{
+	return bitmap_weight_and(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
+}
+
 /**
  * cpumask_shift_right - *dstp = *srcp >> n
  * @dstp: the cpumask result
diff --git a/lib/bitmap.c b/lib/bitmap.c
index d56e275db73e..3fc2e338ec30 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -333,20 +333,32 @@ bool __bitmap_subset(const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_subset);
 
+#define BITMAP_WEIGHT(FETCH, bits)	\
+({										\
+	unsigned int __bits = (bits), idx, w = 0;				\
+										\
+	for (idx = 0; idx < __bits / BITS_PER_LONG; idx++)			\
+		w += hweight_long(FETCH);					\
+										\
+	if (__bits % BITS_PER_LONG)						\
+		w += hweight_long((FETCH) & BITMAP_LAST_WORD_MASK(__bits));	\
+										\
+	w;									\
+})
+
 unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
 {
-	unsigned int k, lim = bits/BITS_PER_LONG, w = 0;
-
-	for (k = 0; k < lim; k++)
-		w += hweight_long(bitmap[k]);
-
-	if (bits % BITS_PER_LONG)
-		w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
-
-	return w;
+	return BITMAP_WEIGHT(bitmap[idx], bits);
 }
 EXPORT_SYMBOL(__bitmap_weight);
 
+unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
+				const unsigned long *bitmap2, unsigned int bits)
+{
+	return BITMAP_WEIGHT(bitmap1[idx] & bitmap2[idx], bits);
+}
+EXPORT_SYMBOL(__bitmap_weight_and);
+
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
 	unsigned long *p = map + BIT_WORD(start);
-- 
2.34.1

