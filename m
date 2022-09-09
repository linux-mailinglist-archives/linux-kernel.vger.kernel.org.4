Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523C25B30C0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiIIHo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiIIHne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:43:34 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D50F22CE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:40:29 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id oz30-20020a1709077d9e00b0077239b6a915so581782ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=ZgjuXiR7GOoWQwHIqm/Zq+w7cYIxur6W3viv+dY7RH8=;
        b=j+UIMYBTztIdEddAyQiLGMbyZseB1O22pSgIKiq3dObuMbk/LL18hQYw2XnwhChEno
         njdoU+3QMR7gbmgwGyVpo44ABifiMAXrO2NcXAV20tvaK2to9ta9VgLe7oqbevNVn+My
         CY1IKSTmC7bwqSToFhdGidMuTizf0IuFctMiiQ22E0ixlDDbZuVt102UdCmuTQUeDRA1
         naSl15bd2TUlgku+q5RdYvuyrx7QEZPOGsl+hbf2M6OGLfZUQW6IlzJV9y38f0cRr33g
         JcMkGIiKLKS00KTmIczkcO+n7iSbzJfAOyzGap2cwppwbotjo7CBfOlAK5w52TOPfKwb
         MWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ZgjuXiR7GOoWQwHIqm/Zq+w7cYIxur6W3viv+dY7RH8=;
        b=cUgqe1jPhZ8SbUnuGZcN5BT7FyUH/ErWcQ1mFo7GmyfX+0FeDULOWAuDZ2OiW08A7O
         vds8P0Ls0HmvYCcPu8zFulFeb7nN0StHzAeqvxq9T409nNRIM0eAeL4fRtASa/9jJ8Bd
         5wjx5EgCo7BVVWLsHy9F0/jsD6hdyuPy3rPDJxYvFtapwzHy5xNOl7r9SBRKE0qCGr50
         s+Lw8tQjm560kzPAQlXWmI0nzYzjRdDnFFMABPezvYFym59qJykAsv0CwF5+92wuZx7t
         TC+VG6whZbunQA1i7cP+3obXxcs/nxRfSt71Izh1QbGKXuO2ADN6el0h/gOceraLC0oB
         oEaw==
X-Gm-Message-State: ACgBeo1qYjIfEINVlkOwoVvynpY27ttKN0woiJ/P/KCY1JyQNf5wJ0Iq
        k4yDbil7kxwUpyA2phHb2qrIz4rAaA==
X-Google-Smtp-Source: AA6agR72lEybpcVa7cBjPW4pKXFE8r3tYkQb5/NC95gOTISnGkgRwU/Efuez6zfWhM70OFPhqME9JBdrGw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:1d1e:ddcd:2020:36c2])
 (user=elver job=sendgmr) by 2002:a05:6402:27cd:b0:44e:c4aa:5ff with SMTP id
 c13-20020a05640227cd00b0044ec4aa05ffmr10390086ede.193.1662709131149; Fri, 09
 Sep 2022 00:38:51 -0700 (PDT)
Date:   Fri,  9 Sep 2022 09:38:38 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220909073840.45349-1-elver@google.com>
Subject: [PATCH v2 1/3] s390: Always declare __mem functions
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other architectures, always declare __mem*() functions if the
architecture defines __HAVE_ARCH_MEM*.

For example, this is required by sanitizer runtimes to unambiguously
refer to the arch versions of the mem-functions, and the compiler not
attempting any "optimizations" such as replacing the calls with builtins
(which may later be inlined etc.).

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 arch/s390/include/asm/string.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/string.h b/arch/s390/include/asm/string.h
index 3fae93ddb322..2c3c48d526b9 100644
--- a/arch/s390/include/asm/string.h
+++ b/arch/s390/include/asm/string.h
@@ -20,8 +20,11 @@
 #define __HAVE_ARCH_MEMSET64	/* arch function */
 
 void *memcpy(void *dest, const void *src, size_t n);
+void *__memcpy(void *dest, const void *src, size_t n);
 void *memset(void *s, int c, size_t n);
+void *__memset(void *s, int c, size_t n);
 void *memmove(void *dest, const void *src, size_t n);
+void *__memmove(void *dest, const void *src, size_t n);
 
 #ifndef CONFIG_KASAN
 #define __HAVE_ARCH_MEMCHR	/* inline & arch function */
@@ -55,10 +58,6 @@ char *strstr(const char *s1, const char *s2);
 
 #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
 
-extern void *__memcpy(void *dest, const void *src, size_t n);
-extern void *__memset(void *s, int c, size_t n);
-extern void *__memmove(void *dest, const void *src, size_t n);
-
 /*
  * For files that are not instrumented (e.g. mm/slub.c) we
  * should use not instrumented version of mem* functions.
-- 
2.37.2.789.g6183377224-goog

