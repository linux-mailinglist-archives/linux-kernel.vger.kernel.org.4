Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834345B9288
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiIOCHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIOCHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:07:37 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4800E8E9A8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:07:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q11so9232144qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=K2R1iy21HsJbeE0Fr+rvJINP8Hx2Z3d/5iM9+cUl0Mc=;
        b=MtE4YlPz6GSinYPA7O6U58FScSNenLLpnFARHYmejMCEbQ8SjfT+VPr9HvfYfRDVKG
         0VcJ+QE5TBow44fI7GypVig5xj0eVFs8z4rM3/iECjw+Q9B/CVMj5abLnYi20syh1vtQ
         VaNsoi9siBz/hjvR38gja49xd72rBEsyp6N4/wQZSzNoo27NFe1JjCdf4btz0jvQpOOQ
         upSxM3fZmfTLwNAurS1Bf4rtIIx7RrSnyF4rB/Verp73+2c2YJ/tKgKWOSqBaZYYIM2B
         hgivupoOy/xsI+cwqEk9XCzLY0Cl/mi1LaoPnRyklIMSCKApeFZ3TN3z+ef0Ba8/lUx/
         Utow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=K2R1iy21HsJbeE0Fr+rvJINP8Hx2Z3d/5iM9+cUl0Mc=;
        b=1tFLJG9zzp+cUKWtQcVjGGgVStTpqlNMdZXgEALS/8zfLePvLFaBpbk0qpf2fbP56E
         GIDXMqIEJKLabXKz7zsb8HcoXwgS7z+uIk5HAffkNFNhDfWZravspxsLX79nkGPUxDGS
         mt/rU5iRdyIK0IXNzcG59vUax8qnIPpcTmwmbkwPmikNukM2a/LHTzivz1UnL15/zwsO
         5St/k5gvTM1TChUIEpd6QT6mbilA9v0lvGL7ZrVRDDH1Ybd1gL7VeMfbc5CW54/Gdt7M
         RAfJy3VnpSFZa+IAvI1C7fhLIasdMiA4ld2BhhS8oeHkEYXDv1iVbTcWxt8bl3nDO/nk
         jp1w==
X-Gm-Message-State: ACgBeo1AfAWALvNasFx+UHUlWMPCjRB6IdzFGdVUGvENwV8wLJvFzBP9
        0U45zz96exrKM/wET4NVU4BM3wk+yIk=
X-Google-Smtp-Source: AA6agR5+wjLr8XCFamIspuz6ol/NsYiy/v95crsMi2gk010QtKIGdh/6yUYNia/tNfjAUWDLhKPNNA==
X-Received: by 2002:a05:620a:bc6:b0:6bc:644b:8e94 with SMTP id s6-20020a05620a0bc600b006bc644b8e94mr28710551qki.321.1663207655353;
        Wed, 14 Sep 2022 19:07:35 -0700 (PDT)
Received: from localhost (96-87-29-153-static.hfc.comcastbusiness.net. [96.87.29.153])
        by smtp.gmail.com with ESMTPSA id v26-20020ac8729a000000b0031f36cd1958sm2485833qto.81.2022.09.14.19.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 19:07:35 -0700 (PDT)
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
Subject: [PATCH v4 1/4] lib/find_bit: introduce FIND_FIRST_BIT() macro
Date:   Wed, 14 Sep 2022 19:07:27 -0700
Message-Id: <20220915020730.852234-2-yury.norov@gmail.com>
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

Now that we have many flavors of find_first_bit(), and expect even more,
it's better to have one macro that generates optimal code for all and makes
maintaining of slightly different functions simpler.

The logic common to all versions is moved to the new macro, and all the
flavors are generated by providing an FETCH macro-parameter, like
in this example:

  #define FIND_FIRST_BIT(FETCH, MUNGE, size) ...

  find_first_ornot_and_bit(addr1, addr2, addr3, size)
  {
        return FIND_FIRST_BIT(addr1[idx] | ~addr2[idx] & addr3[idx], /* nop */, size);
  }

The FETCH may be of any complexity, as soon as it only refers
the bitmap(s) and an iterator idx.

MUNGE is here to support _le code generation for BE builds. May be
empty.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/find_bit.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/lib/find_bit.c b/lib/find_bit.c
index 1b8e4b2a9cba..894b656f6836 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -19,6 +19,27 @@
 #include <linux/minmax.h>
 #include <linux/swab.h>
 
+/*
+ * Common helper for find_bit() function family
+ * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
+ * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
+ * @size: The bitmap size in bits
+ */
+#define FIND_FIRST_BIT(FETCH, MUNGE, size)					\
+({										\
+	unsigned long idx, val, sz = (size);					\
+										\
+	for (idx = 0; idx * BITS_PER_LONG < sz; idx++) {			\
+		val = (FETCH);							\
+		if (val) {							\
+			sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(val)), sz);	\
+			break;							\
+		}								\
+	}									\
+										\
+	sz;									\
+})
+
 #if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
 	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
 	!defined(find_next_and_bit)
@@ -77,14 +98,7 @@ EXPORT_SYMBOL(_find_next_bit);
  */
 unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
 {
-	unsigned long idx;
-
-	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
-		if (addr[idx])
-			return min(idx * BITS_PER_LONG + __ffs(addr[idx]), size);
-	}
-
-	return size;
+	return FIND_FIRST_BIT(addr[idx], /* nop */, size);
 }
 EXPORT_SYMBOL(_find_first_bit);
 #endif
@@ -97,15 +111,7 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
 				  const unsigned long *addr2,
 				  unsigned long size)
 {
-	unsigned long idx, val;
-
-	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
-		val = addr1[idx] & addr2[idx];
-		if (val)
-			return min(idx * BITS_PER_LONG + __ffs(val), size);
-	}
-
-	return size;
+	return FIND_FIRST_BIT(addr1[idx] & addr2[idx], /* nop */, size);
 }
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
@@ -116,14 +122,7 @@ EXPORT_SYMBOL(_find_first_and_bit);
  */
 unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
-	unsigned long idx;
-
-	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
-		if (addr[idx] != ~0UL)
-			return min(idx * BITS_PER_LONG + ffz(addr[idx]), size);
-	}
-
-	return size;
+	return FIND_FIRST_BIT(~addr[idx], /* nop */, size);
 }
 EXPORT_SYMBOL(_find_first_zero_bit);
 #endif
-- 
2.34.1

