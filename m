Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB062FC9B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbiKRSYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242641AbiKRSXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:23:21 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDC9942F5;
        Fri, 18 Nov 2022 10:23:20 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id s4so3662843qtx.6;
        Fri, 18 Nov 2022 10:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vrZu6MxE9V2lrmkTP7p6YrgX3yUV8vdw6JbzZsfWtro=;
        b=M0mVeRFPGC+9qlEjwEetRK5+DS6SNGvQSlv/m2A+xNrwYtXIbXX24a36XThAaDwvqE
         bPpb3Sd4xO9/1fiymHJ9y0QaLdoO5d3H0v22bp3hE0eTgowt1cQKRPERbG7SOVgeqBSR
         rklzhXJeaAqFNEdoYIlES3etk/L3b0bXEqs/JL8s6UVeVQ62FJBnallgIaBFZRu62hZ0
         sRuomxQ4KQFz/VGKkrysPPj1pBE56FLH7lPkkbP1GoLzNC0aOaOqEJ45CrVSkCMrkEEz
         jc3vj0qAzLbX5eKbfDY08yx63TZiEOf42bAJdiLWn9q+odepbPy/knIpqBLL4LYu4NZO
         eskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrZu6MxE9V2lrmkTP7p6YrgX3yUV8vdw6JbzZsfWtro=;
        b=W6mARYIapk2iELId0hDmoRhiodXNQG5qQA9lY5iLrQTJx3N+cQCKwrL2tU8+o+gAvz
         dN0jCMrRapAJX00uRQm03rmlsLQw8tltOYBmCOYEjL6yf7jCv+lFLj33Und2nBrJ0Ocy
         mhRD5soBuhPiVKjZMkwKVBhOO3QGs+42YCNQeW9ZhagGgKKytuLnq8+u360vZ8APLTh1
         D0gOz7YTJ9ZVR/7lkNIoNQclkogcRReOA30xMkT5YyWFFNJo7Smy5w86vcNRoWTH+Viy
         xuX9y+6llzNLyuRPDgFlKme8Mj6fP/yGPVftC8q7S9ReqSuRX0iSWar9xSkIa0iDElX9
         Ix7A==
X-Gm-Message-State: ANoB5plTrBseSHQmybrdbwkRqaq8KuAbJDzFLmlCgBKXiQP1E0jNbvXB
        WOJQx/Ki0mcT0PWUcNvYun8=
X-Google-Smtp-Source: AA0mqf6R/O3Cj5gBnOvw5T267/VeAkkaVpyito6Zd3ugqbHRvVal8RDe9yr4aL/5iiyUkWHxamslBQ==
X-Received: by 2002:a05:622a:1e87:b0:3a5:4cee:6eb1 with SMTP id bz7-20020a05622a1e8700b003a54cee6eb1mr7719977qtb.20.1668795799974;
        Fri, 18 Nov 2022 10:23:19 -0800 (PST)
Received: from shaak.xiphos.ca (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id q46-20020a05620a2a6e00b006fbcab95d70sm2349025qkp.101.2022.11.18.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:23:19 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] math64: favor kernel-doc from header files
Date:   Fri, 18 Nov 2022 13:23:07 -0500
Message-Id: <20221118182309.3824530-1-liambeguin@gmail.com>
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
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
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

