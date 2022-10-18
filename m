Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2BB6026AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiJRIWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiJRIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:22:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CB397D64
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:22:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m6so13451722pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnqNHNhYyLH9Wo68LD4x3bwQRhcMnm8gL4scZhF5muk=;
        b=g+M0tP4FeC0OrEgQxOE3oJjv9pUB6oD9RgZ+XBPsA0B85VsOEiUZa6cSIgQOnwn/bl
         PMcN3F6LLRPoLDCxP3nuCJikCNGhdt00VAuMFuO3rxW1gs8KlSrBeB+vNyMB4cCCH/Gc
         kvdVgkwL8LfHNJuSEL7+LJTehFvWBdJr0abNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnqNHNhYyLH9Wo68LD4x3bwQRhcMnm8gL4scZhF5muk=;
        b=KfYuf7l/I69MebWy1TxZx9GW6omz5oA6YyIB/Tgu0DWAiSnvEQ5jGQUPHGeAGoKlYq
         uYPuZdpcOqruwY3oEJAL4e9zv5zRZCsq4bwIFtkimLp2CyKkNIhU83dT/zp1oT1eMlgv
         UUGi9A2KBZLlDVGpeaaAYSj1HF7l0dxoegaTDQSk63tc3b8dZ54sf7pKUb7db1cMc7a1
         zRBSWYTQZJGAHqQpO6oiO/GjYPC1vJc1C4zIM5OHPbUmSX9Ts4s6YfpOSzuatVIV038J
         JQqL2NzUeEnsXYmBtefO5ziJwRtzhPkP6ckZ20YSjIHReXYZel/plsRsJQn2UC/RqRXN
         Lpdg==
X-Gm-Message-State: ACrzQf0hRd7PC2R3kEW3eLvF9XO4MFf9KulwjBaPhxj+ai5ms17p/u/5
        yaEGl4616xamYnrIxoOV716pKg==
X-Google-Smtp-Source: AMsMyM72YdgZRaJDiZ9MU6bvh+RA5iQHpj06/whPZsYV2r2RwYl4tM6cKQGl0WtEaQrAYe7tdQtb5Q==
X-Received: by 2002:a63:4283:0:b0:457:dced:8ba3 with SMTP id p125-20020a634283000000b00457dced8ba3mr1711359pga.220.1666081364707;
        Tue, 18 Oct 2022 01:22:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b0017d97d13b18sm8026045plx.65.2022.10.18.01.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 01:22:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] string: Add __alloc_size hint to kmemdup()
Date:   Tue, 18 Oct 2022 01:22:41 -0700
Message-Id: <20221018082232.never.213-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853; h=from:subject:message-id; bh=SgzbSvS/b5ZrTbA0wJ9E9tBFT9DRkYwk8ZJEQZFVEak=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTmJRV6GiRT0HuXsWsQSPL85x/s8fMsdifykSjHzh OlUuKfmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05iUQAKCRCJcvTf3G3AJj8rD/ 9KYnzy5bqIwa32boPh44jUw+r1zKss52V+nzSaViIRwLNMVToZqpHJ2eZ7cIQKOwfMoHYAPiOhhFCE yUV8wPUrPSzXQSc6Y/4etatCvIVMl6/LpGjfjELhI5SOKGmfpMTI77z45BTRoZJFabztTn3aSt18hX AF6wjRN8M/oLYCX8lws5Jm1x/CwOnb8Y9yLaLaVRFpaloXmTNijmKNDioJ3qCyX9D/zvSQZ2o7TAi7 0jA+eem6Aq8EIFBeRb9axI7myTreYHszRjIFO+Z10WSLfh9MpvZ78HuK2WDTjbFr1iX/pPqGl+7Zc6 qCa+lJfFF7IjkI3mG7SYwUyVktGy5BqO61c/T2TS+V9XKORhBy4rmyA50/RMt1DfMW6ETiWuCMGp2u VdRwBsZ8qNwaq3nx/51bwQXEFc1U056LcUYBH25qctK872Y7LQVFzJ/WA4HmZmj1hlT8cqb57AVP/3 dIAQI5YZz6PKJpg97tjLaO5ccXGqXrNbSVck7v+h49vz+UUTQdtYUtCOUQ+Bze4KRdjJWqhpZI3r5N dLB9ifjVvhwjnAjuPJIWE6eKu1uC/lqjhZBxmCByUWw64JZGQKjx6LDf3HN+ZD7R//tYqoPM6Vnk9u FddwMhg6qb1FNSRb+45QtPu0FB+r4Fe7JhjpR+EPEYO1XheosCSb3ouIA/+w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __alloc_size() hint to kmemdup() so the compiler can reason about
the length of the returned buffer.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 3 ++-
 include/linux/string.h         | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index b166364ce3e0..aa1a50009632 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -661,7 +661,8 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	return __real_memchr_inv(p, c, size);
 }
 
-extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup);
+extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup)
+								    __alloc_size(2);
 __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp)
 {
 	size_t p_size = __struct_size(p);
diff --git a/include/linux/string.h b/include/linux/string.h
index cf7607b32102..af1d69e5610e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -176,7 +176,7 @@ extern void kfree_const(const void *x);
 extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
 extern const char *kstrdup_const(const char *s, gfp_t gfp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
-extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
+extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __alloc_size(2);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
 
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
-- 
2.34.1

