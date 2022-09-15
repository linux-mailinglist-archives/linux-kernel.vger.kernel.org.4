Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2738E5B928A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiIOCHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiIOCHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:07:37 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2900C8E9A3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:07:37 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id cj27so434912qtb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3+iTs7Qci+cQAiUkXQV8UIioBFj35PInyrTjTdgkjzM=;
        b=Tc0X3VRnLhT04xI+XfW7wjfijgeKow0ZUOe5T6e/nT+yvW8ECrkf/+IVs09upXULh1
         Jl+EON47HmzO70hb51m2HWXztDLyL6iwcXrusFujfAG7RqmKthBKggvNZbVdmRX4leKW
         oSXBnzX3TBN4xhx7qrXNezuKGVehmr9JTPXM3ejhWFY8h92ThJZ9gFwaljxD1iuWzzH6
         SiZvlHSldccCxuF+j1c1ReLXJgNnM40cRuy9Rlp+pnAdzXRyh5vLzIH9MwVaohVEg682
         bRhPJ3CHJaO8ghf9D/ZzE4xaZjr2WUJ0R4U839XZZPkYnvq/o5inFZcLrzD+zt5ZkQ48
         2+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3+iTs7Qci+cQAiUkXQV8UIioBFj35PInyrTjTdgkjzM=;
        b=c2Nmg0Uq0S2UkJmoHvPWbswlw/IN9MXgEH5pntF+4gzSezI5YefAabFIH4ABsWfmKI
         RJrs1KY3eAPNeT92dmn8zqJdAYzETKfu+wz6FwbBRFiQobaaInhM3DBhphyzk93QqMac
         TBlnz71Yn48W1mWj/5YntQ81RShakLyOi90qlidU+f+Oy6+2xw3e8Q/HMMKcqDugEAQR
         zi0AiVn1Abv71BC6QOM2ECmLGPFTP8Dh0B/torH5j+zbZqE2Ka6TIsnMQIZ5nQtlc0A0
         6SeE5lg8F8E6TAmB1Aff9ouZBasL0SVWmrlDaXdUyqSOwoZaWhILzBl3+VCxXryCkK1c
         ZaoA==
X-Gm-Message-State: ACgBeo3mpqLCqTrQxvhgoi/tpa6wKDkMf8WnzZDwom6TWU9mtMcsK3JY
        sgafHJ7H/y3ZEa6IikLSzlg=
X-Google-Smtp-Source: AA6agR7m/mLwKEBVZiieSHstxBu6MKX6UIaW9upYvHvQ8i0DfggUcpjyXKeucYsiDeIlV95y7ehw6A==
X-Received: by 2002:ac8:5c51:0:b0:344:5510:be77 with SMTP id j17-20020ac85c51000000b003445510be77mr36449031qtj.84.1663207656216;
        Wed, 14 Sep 2022 19:07:36 -0700 (PDT)
Received: from localhost (96-87-29-153-static.hfc.comcastbusiness.net. [96.87.29.153])
        by smtp.gmail.com with ESMTPSA id bp44-20020a05622a1bac00b0034456277e3asm2549454qtb.89.2022.09.14.19.07.35
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
Subject: [PATCH v4 2/4] lib/find_bit: create find_first_zero_bit_le()
Date:   Wed, 14 Sep 2022 19:07:28 -0700
Message-Id: <20220915020730.852234-3-yury.norov@gmail.com>
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

find_first_zero_bit_le() is an alias to find_next_zero_bit_le(),
despite that 'next' is known to be slower than 'first' version.

Now that we have common FIND_FIRST_BIT() macro helper, it's trivial
to implement find_first_zero_bit_le() as a real function.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h | 23 ++++++++++++++++++-----
 lib/find_bit.c       | 14 ++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 424ef67d4a42..2464bff5de04 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -17,6 +17,10 @@ extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
+#ifdef __BIG_ENDIAN
+unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size);
+#endif
+
 #ifndef find_next_bit
 /**
  * find_next_bit - find the next set bit in a memory region
@@ -251,6 +255,20 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 }
 #endif
 
+#ifndef find_first_zero_bit_le
+static inline
+unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = swab(*(const unsigned long *)addr) | ~GENMASK(size - 1, 0);
+
+		return val == ~0UL ? size : ffz(val);
+	}
+
+	return _find_first_zero_bit_le(addr, size);
+}
+#endif
+
 #ifndef find_next_bit_le
 static inline
 unsigned long find_next_bit_le(const void *addr, unsigned
@@ -270,11 +288,6 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 }
 #endif
 
-#ifndef find_first_zero_bit_le
-#define find_first_zero_bit_le(addr, size) \
-	find_next_zero_bit_le((addr), (size), 0)
-#endif
-
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 894b656f6836..f4d9b9684811 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -160,3 +160,17 @@ unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
 	return offset;
 }
 EXPORT_SYMBOL(find_next_clump8);
+
+#ifdef __BIG_ENDIAN
+#ifndef find_first_zero_bit_le
+/*
+ * Find the first cleared bit in an LE memory region.
+ */
+unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
+{
+	return FIND_FIRST_BIT(~addr[idx], swab, size);
+}
+EXPORT_SYMBOL(_find_first_zero_bit_le);
+#endif
+
+#endif /* __BIG_ENDIAN */
-- 
2.34.1

