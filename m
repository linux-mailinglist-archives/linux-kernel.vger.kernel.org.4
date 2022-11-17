Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16BD62D125
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbiKQCff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiKQCfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:35:30 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B01AF0F;
        Wed, 16 Nov 2022 18:35:29 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id x18so361344qki.4;
        Wed, 16 Nov 2022 18:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1R6WF366RVPx4k/kufiGJ4ymsD6DvKzhVq3zPc5qv00=;
        b=P8m96K1ZioaHAYdCVkO+NZQXHaF7XDUUGmXvKGDFEW9ZzDAXCXi+XcjwpkvbideCj3
         mWjAXyFV1eygBgdobg+luk2umR/0fM+uutXcUDkwUvifrndPbnZ/O0JWtpnyqOrq0zoX
         IsbRMaTO8BGzqfqy4TVVrzdH9WRX+KspQ3RW85cc35KKYqMB7zCLFmKaX2ZcCBFJJjnz
         IpMDDNTEok5pB73Q+p/UkV01rOMgQh+wbb9O5CDHV9OmLRRE5l6TjSZf7Iu6ve/3zijG
         rfRBmxG5/xdukSR5hAtaowez4U92dnC8M85rEqs1DcX1r2z+DtfGX+B4ps4Wj7ho0Ll3
         5LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1R6WF366RVPx4k/kufiGJ4ymsD6DvKzhVq3zPc5qv00=;
        b=bACVz7rQuFpmt9mJPH3NRJYEAibxJ8gzpJnh3Wv4JgacmMj/nSNf9JV5Ui7FBcmH0W
         MeJlJfol9APawN+eEg8ObEpMPOZ9eK9QssNtdNUpyuo+GFzpjb1uHT0YxTPWr+yOu+Fd
         LtMMRSL/V9Dzk+GRNe2sxGk+tl7n4GODSNyIlaCsBQAd3Aut+vYQcvEEg7WijP7qLzvl
         +f5SSzHmeulSDJe0kqENJix5t19APGTTLARYvS/rXP5K0aHTiteQAuyyyyStlNf2C6YI
         ACI1h4cjDWLEUXIQQsrVcwVqra5e8HxiYVdGYPz+i0QTVWGdUdSMTxud0u/5gKa4nf33
         9KtQ==
X-Gm-Message-State: ANoB5pnlnbd50/EIOJkXxBlCLeS4hdIpA+GTbxVI+xvo3YJXemDwh++g
        rVNC4EW0Dkh9NkxQYGCBCXs5oMPe3ZI=
X-Google-Smtp-Source: AA0mqf7Bp9YzBE0nQiFqdNCXbsobeWufutFZ0732B0iChY2BoPiq77Va16Fmo5lO5w5qOjYGYd7zCw==
X-Received: by 2002:ae9:dc01:0:b0:6fa:aee9:9d40 with SMTP id q1-20020ae9dc01000000b006faaee99d40mr199237qkf.194.1668652528413;
        Wed, 16 Nov 2022 18:35:28 -0800 (PST)
Received: from shaak.xiphos.ca (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a0f0500b006eec09eed39sm11311888qkl.40.2022.11.16.18.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 18:35:27 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] math64: favor kernel-doc from header files
Date:   Wed, 16 Nov 2022 21:35:09 -0500
Message-Id: <20221117023510.2338176-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.37.1.223.g6a475b71f8c4
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

Fix the kernel-doc markings for div64 functions to point to the header
file instead of the lib/ directory.  This avoids having implementation
specific comments in generic documentation.  Furthermore, given that
some kernel-doc comments are identical, drop them from lib/math64 and
only keep there comments that add implementation details.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/core-api/kernel-api.rst |  3 ---
 include/linux/math64.h                | 12 ++++++------
 lib/math/div64.c                      | 15 ++-------------
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 06f4ab122697..c9412eb85552 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -171,9 +171,6 @@ Division Functions
 .. kernel-doc:: include/linux/math64.h
    :internal:
 
-.. kernel-doc:: lib/math/div64.c
-   :functions: div_s64_rem div64_u64_rem div64_u64 div64_s64
-
 .. kernel-doc:: lib/math/gcd.c
    :export:
 
diff --git a/include/linux/math64.h b/include/linux/math64.h
index a14f40de1dca..1538844fcb51 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -29,7 +29,7 @@ static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
 	return dividend / divisor;
 }
 
-/*
+/**
  * div_s64_rem - signed 64bit divide with 32bit divisor with remainder
  * @dividend: signed 64bit dividend
  * @divisor: signed 32bit divisor
@@ -43,7 +43,7 @@ static inline s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder)
 	return dividend / divisor;
 }
 
-/*
+/**
  * div64_u64_rem - unsigned 64bit divide with 64bit divisor and remainder
  * @dividend: unsigned 64bit dividend
  * @divisor: unsigned 64bit divisor
@@ -57,7 +57,7 @@ static inline u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 	return dividend / divisor;
 }
 
-/*
+/**
  * div64_u64 - unsigned 64bit divide with 64bit divisor
  * @dividend: unsigned 64bit dividend
  * @divisor: unsigned 64bit divisor
@@ -69,7 +69,7 @@ static inline u64 div64_u64(u64 dividend, u64 divisor)
 	return dividend / divisor;
 }
 
-/*
+/**
  * div64_s64 - signed 64bit divide with 64bit divisor
  * @dividend: signed 64bit dividend
  * @divisor: signed 64bit divisor
@@ -300,7 +300,7 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
 #define DIV64_U64_ROUND_CLOSEST(dividend, divisor)	\
 	({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
 
-/*
+/**
  * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
  * @dividend: unsigned 64bit dividend
  * @divisor: unsigned 32bit divisor
@@ -313,7 +313,7 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
 #define DIV_U64_ROUND_CLOSEST(dividend, divisor)	\
 	({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
 
-/*
+/**
  * DIV_S64_ROUND_CLOSEST - signed 64bit divide with 32bit divisor rounded to nearest integer
  * @dividend: signed 64bit dividend
  * @divisor: signed 32bit divisor
diff --git a/lib/math/div64.c b/lib/math/div64.c
index 46866394fc84..55a81782e271 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -63,12 +63,6 @@ uint32_t __attribute__((weak)) __div64_32(uint64_t *n, uint32_t base)
 EXPORT_SYMBOL(__div64_32);
 #endif
 
-/**
- * div_s64_rem - signed 64bit divide with 64bit divisor and remainder
- * @dividend:	64bit dividend
- * @divisor:	64bit divisor
- * @remainder:  64bit remainder
- */
 #ifndef div_s64_rem
 s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder)
 {
@@ -89,7 +83,7 @@ s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder)
 EXPORT_SYMBOL(div_s64_rem);
 #endif
 
-/**
+/*
  * div64_u64_rem - unsigned 64bit divide with 64bit divisor and remainder
  * @dividend:	64bit dividend
  * @divisor:	64bit divisor
@@ -129,7 +123,7 @@ u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 EXPORT_SYMBOL(div64_u64_rem);
 #endif
 
-/**
+/*
  * div64_u64 - unsigned 64bit divide with 64bit divisor
  * @dividend:	64bit dividend
  * @divisor:	64bit divisor
@@ -163,11 +157,6 @@ u64 div64_u64(u64 dividend, u64 divisor)
 EXPORT_SYMBOL(div64_u64);
 #endif
 
-/**
- * div64_s64 - signed 64bit divide with 64bit divisor
- * @dividend:	64bit dividend
- * @divisor:	64bit divisor
- */
 #ifndef div64_s64
 s64 div64_s64(s64 dividend, s64 divisor)
 {

base-commit: 59d0d52c30d4991ac4b329f049cc37118e00f5b0
-- 
2.37.1.223.g6a475b71f8c4

