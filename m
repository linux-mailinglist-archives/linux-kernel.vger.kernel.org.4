Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB7612114
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJ2HoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ2Hn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:43:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB871C8110
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:43:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h185so6666535pgc.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itE6S863fopGMSCeOLGYHCs5YBF6CWEcSSpqYWYgmv0=;
        b=NaveGOEL7jErRNUNIowHQxw+TdbyaaqXhgsPS4hl/Ahlsl5KSz06bnvQdEHg7ikhgH
         WQ8ytNoPX9yRUkJeUuRC8D0pvgxLJCXMmASHWKIoZyqoiAVCfO2mwLDNPVcs215Jx40L
         A8NXEYT1AeCy8Yrz6sxbZr7T76z1Pij8PJwTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itE6S863fopGMSCeOLGYHCs5YBF6CWEcSSpqYWYgmv0=;
        b=wHprTriD1osLxSNTAn2olW4Sd0eTb/KaPgz7Ikr+nB/RePzrWeBSbup8Jq2HQySCxB
         N/th5iNamXgKme5DlIIIVFCUYK79qiIAgk1Ap0XYKlRVL1wraSK7zmhGqpGbtSHM6Pyx
         lUzc3Tuf0YmtSvMpEf9fi1/zSb5r2gq1N9mk1JTc60IAFpADOd1nEup+hX//ndXsuPEn
         BSzv2fCVzKO4DO3DIYxIY+2y4n+RB7sSNC2utjBPdwkS0PZ1n3RYMyyJfTGFjxyi9nTz
         DrcQqiMZc0Bhsda7OGc175qvtqzVn96cgfexyrEIvhOUp21+djDdFVl8z4D5V4ktGwCl
         B2hA==
X-Gm-Message-State: ACrzQf163ySX3b/KNc84RQ35HAP7lmHP6cZeidfxtnP/L9KOqQCQCoZk
        A0kon0oW0RE7xs0T/MolCb1e5g==
X-Google-Smtp-Source: AMsMyM4kRykVhkDH1pyNeeXW+tu7inv6fSKVxMMJDqVKWESyl+uYJtnyiOJPFlYPp1AJ7kvNbSuihw==
X-Received: by 2002:a63:1025:0:b0:46f:9191:162 with SMTP id f37-20020a631025000000b0046f91910162mr76996pgl.560.1667029435799;
        Sat, 29 Oct 2022 00:43:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027d8400b00186fd3951f7sm641707plm.211.2022.10.29.00.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:43:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] string: Add __realloc_size hint to kmemdup()
Date:   Sat, 29 Oct 2022 00:43:52 -0700
Message-Id: <20221029074346.gonna.839-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257; h=from:subject:message-id; bh=czgyyr61mC+V6qSzfPE64U9+me9WEnm/+wEEPBegNns=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjXNm40r5bZejps+YA1d47XzyNKgE+3T4HkCXQZH3r mCcgDrqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1zZuAAKCRCJcvTf3G3AJpEKEA CnTrWCxsLCD6nXNQfM+1a0PNT8wDpH/b90ZFvflQ0OHySnoiv0yjP6/EtKHEfRB/oHcg3+zxPW9Qiy w1rJVHYnrBxQmQpK0Bw7W91bKM7sUw3KwDdi50xYzm60g0k7l0yHlb+M+0kGFzAS6M3EnyAsXZTa2A YjhQO9jWE43sH99UUkzSYxIV8eDdb0thtnnZ/IKWGOICxTJHBCa8Ed4hQZImnsNKouVYC1ZWxjDDSP 4uU5tmpm4l42gGG/JH80J4885fH41VJl54L4O1sUWdR4AqiVSiCX6BkqirbcpSSf3IE22hZBVYT4o3 anPpTk718XmTyEP7A+vWFL1SUiA9z/LpYQnadAHYpjXZLe6OOx38qknF+NEVWZxQ0xuqKWZPgwCBCs THIvI7f2bBznpbUMI25U09hblREzbJ9TvWi0xROxlTu8hlaU4/xu1Kh8Uk/GwTHMEPp043IKDzmAgB abDsvYyxEaTXnjw3B0sSo65Y32mK+6WZiVq5KgcBeSuo3XnNB9J6X2YaNh9pbPKwqHdZlUDuvX/Xtq ccq0jy5+q4F+OEt3TDYZeyv2nUnlVXm+40d+ox4sOwhgkZruODs836QESvXd/X+LDR2rZNjxBY7zvt n5DzqstQNxONX0ItlO8wYSzRlEiTxpP/FeFOL5dmuttmNJxATRDIPabsgh8Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __realloc_size() hint to kmemdup() so the compiler can reason about
the length of the returned buffer. (These must not use __alloc_size,
since those include __malloc which says the contents aren't defined[1]).

[1] https://lore.kernel.org/linux-hardening/d199c2af-06af-8a50-a6a1-00eefa0b67b4@prevas.dk/

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: use __realloc_size() instead of __alloc_size()
v1: https://lore.kernel.org/linux-hardening/20221018082232.never.213-kees@kernel.org/
---
 include/linux/fortify-string.h | 3 ++-
 include/linux/string.h         | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index e5b39b1cc2fc..49782f63f015 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -659,7 +659,8 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	return __real_memchr_inv(p, c, size);
 }
 
-extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup);
+extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup)
+								    __realloc_size(2);
 __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp)
 {
 	size_t p_size = __struct_size(p);
diff --git a/include/linux/string.h b/include/linux/string.h
index cf7607b32102..db28802ab0a6 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -176,7 +176,7 @@ extern void kfree_const(const void *x);
 extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
 extern const char *kstrdup_const(const char *s, gfp_t gfp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
-extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
+extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
 
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
-- 
2.34.1

