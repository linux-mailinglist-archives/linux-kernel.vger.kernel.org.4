Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51066ECB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjDXLXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDXLXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:23:20 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E243C2D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:23:19 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-94f5a1fa123so444049066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682335397; x=1684927397;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=klWy9eDeY9DLyh7eLsNz2mZGZzQpgILthmxtoxhfJPs=;
        b=mxilGFIr6qGQEG87YfDW5J2uPJURyiX6HOl+bYW2jIP+y/R1nS+GY4Tsz7SEqVu3q8
         iNJGENUs/fkJ3IN1UwEagRLu2Wi5OlRC7rePMrAw9JGnYNxTomfP2wZYgrHfuGSVXj0Y
         My7mMOBWyZgKnguCH465dASmx7AqHjBBQXnDDJ6xM8msgN/Bxd5IwFfe3kkS94UhaNDT
         ovYKX+1R9as8Iuam+OMrwLCe8BgEP8G/RFnQhSpzLFDHuuiZ2oIpxdscyG/kGa/yyo//
         aJ1odHmuhZRINrZ++FlEeC5GrfKHmpwy4EZmvKhYlXcIjy27ObQZLdGXel85oh9qehA+
         izyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682335397; x=1684927397;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klWy9eDeY9DLyh7eLsNz2mZGZzQpgILthmxtoxhfJPs=;
        b=gj67UZzyHRv5hub0tlk8sXFjay3dSNxLgMNG8QP1qZfX/qeQHkUHy0CiQYwEfBY/Ai
         wNyj1wh5Y7/RtN+MO6JC6Du3qglbcGAVSk9Dn9IpwBi+2X69wBzsXPN7P3tKlIHG0TdV
         prQGBabU1B3vE5Xv+NJMTjSq8qYuZwxmDiD8xey8KKtMSAW1dHkHPsgcWV7CmHxdNAbH
         wMJwRzebY97EisKt980k3vPqa3nt5jnXjzQ5U3ztnK0tiy0dVriqKARv0lCs18YR/aIJ
         WuVZvHBHIjuZzifDrBIiEET+tYPo3NlbRewAq5wlbmhNnDfxcpFU9j7EnvokQbEx7E9M
         BPZQ==
X-Gm-Message-State: AAQBX9ento78FlEHobE32QQcZKPk58J9UVECPpoquv39BS2W2oDswXz1
        OQfWYhyKBt78VmmEzA+rgVkTyQ1hPkQ=
X-Google-Smtp-Source: AKy350ZoNzOeasIEj2Fw8MS4uKUsSHqBrI5tm7dytA+d4XYszcR9uTtOdoUCuGTHYrUT6uw+vIKdqIb0D7U=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:ae04:112a:7904:fef5])
 (user=glider job=sendgmr) by 2002:a17:906:eb1a:b0:94f:c72:1de0 with SMTP id
 mb26-20020a170906eb1a00b0094f0c721de0mr3297825ejb.14.1682335397499; Mon, 24
 Apr 2023 04:23:17 -0700 (PDT)
Date:   Mon, 24 Apr 2023 13:23:13 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230424112313.3408363-1-glider@google.com>
Subject: [PATCH] string: use __builtin_memcpy() in strlcpy/strlcat
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, andy@kernel.org,
        ndesaulniers@google.com, nathan@kernel.org
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

lib/string.c is built with -ffreestanding, which prevents the compiler
from replacing certain functions with calls to their library versions.

On the other hand, this also prevents Clang and GCC from instrumenting
calls to memcpy() when building with KASAN, KCSAN or KMSAN:
 - KASAN normally replaces memcpy() with __asan_memcpy() with the
   additional cc-param,asan-kernel-mem-intrinsic-prefix=1;
 - KCSAN and KMSAN replace memcpy() with __tsan_memcpy() and
   __msan_memcpy() by default.

To let the tools catch memory accesses from strlcpy/strlcat, replace
the calls to memcpy() with __builtin_memcpy(), which KASAN, KCSAN and
KMSAN are able to replace even in -ffreestanding mode.

This preserves the behavior in normal builds (__builtin_memcpy() ends up
being replaced with memcpy()), and does not introduce new instrumentation
in unwanted places, as strlcpy/strlcat are already instrumented.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/all/20230224085942.1791837-1-elver@google.com/
---
 lib/string.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 3d55ef8901068..be26623953d2e 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -110,7 +110,7 @@ size_t strlcpy(char *dest, const char *src, size_t size)
 
 	if (size) {
 		size_t len = (ret >= size) ? size - 1 : ret;
-		memcpy(dest, src, len);
+		__builtin_memcpy(dest, src, len);
 		dest[len] = '\0';
 	}
 	return ret;
@@ -260,7 +260,7 @@ size_t strlcat(char *dest, const char *src, size_t count)
 	count -= dsize;
 	if (len >= count)
 		len = count-1;
-	memcpy(dest, src, len);
+	__builtin_memcpy(dest, src, len);
 	dest[len] = 0;
 	return res;
 }
-- 
2.40.0.634.g4ca3ef3211-goog

