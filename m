Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAFD6A6E9C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCAOjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCAOjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:39:45 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3942938677
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:39:44 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id t9-20020a056402524900b004af59c073abso19424888edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2FIkUEqU6YxkmcIL1AtVszo9ZqqtqhQ8yghIzSXGmA=;
        b=DcQhFeZ5qGp+AKIQFJAYw7mSn3Y3zdJdiwbFpjR09nWHgumpyTqJ77smBudhJx90b2
         +of4MO5DstJZPnWALbM1Of06Za2o7NytkJzXNNFiETyWdzrdaTvwzeqjQvfk8WKO4zWX
         nZ+35n8p65W1JWEwmllJK+DRCas7pBVJAabnp3AlbmD9fL442oIjUjwwK9Aw0IVzmE4G
         LaCLGdq2wBlsOXftBi7owZAHb13CKHLWbeuJyMfJKrGq7rXdtXxsVCEBJ1eC4cyZayTC
         p0+kMXLSlqoFuK/nAnKUEN/l83vYbnRP2DpS/RVn8EjMzruu3T02ZPom1pnLs708E3j1
         cpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2FIkUEqU6YxkmcIL1AtVszo9ZqqtqhQ8yghIzSXGmA=;
        b=K6ioeON/ftlmD7bt63y3rL6VaO3i9RGSJ3IafG//bfdf5DueatsGhrI9Gw5xRJNHta
         wTOfBRF1uUEIZc9oLiki0QgTEPdiHLx2XhdQMxJhIXz9QJmfAtIluBu6eZtltZxLwXki
         SMCxMl4U+vWEBQ5Ykd1QLx77fYu9E5Ft/3IlmwCxWK0V1GI91zABtgH08HvCeaKDq/C7
         CUoiR7oPM0fhymGSMiUPBI+yh3FF1kH7DWkop/klc5pbs37IiVGVB4y8bDph7UIqJ9nC
         C9XD0+ppGICCNXp6AxfG2F2sgY4RxUJRU+PRoc06Yr+nBLV2FTgxleBVP+SHYQCn2/Vq
         ltpg==
X-Gm-Message-State: AO0yUKVCg5SaG9QlFqoK6WnrFuUAFzUDw/trMmldAD+n3E0H+Kwbcafp
        ACDtEu7ApMZXx+VoK9WtnIjvJJ4FlhY=
X-Google-Smtp-Source: AK7set8s3Ggkq5cG5lUrm0qbBrwvCtbXX/8McRuVafkppgzT3vG80DIvRRgW6QRGvNCDsu1QYruyNWhJhlw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:3c31:b0cf:1498:e916])
 (user=glider job=sendgmr) by 2002:a50:aa8b:0:b0:4ae:f648:950b with SMTP id
 q11-20020a50aa8b000000b004aef648950bmr3893580edc.7.1677681582665; Wed, 01 Mar
 2023 06:39:42 -0800 (PST)
Date:   Wed,  1 Mar 2023 15:39:32 +0100
In-Reply-To: <20230301143933.2374658-1-glider@google.com>
Mime-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230301143933.2374658-3-glider@google.com>
Subject: [PATCH 3/4] x86: kmsan: use C versions of memset16/memset32/memset64
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        nathan@kernel.org, ndesaulniers@google.com,
        kasan-dev@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN must see as many memory accesses as possible to prevent false
positive reports. Fall back to versions of
memset16()/memset32()/memset64() implemented in lib/string.c instead of
those written in assembly.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/include/asm/string_64.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 9be401d971a99..e9c736f4686f5 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -22,6 +22,11 @@ extern void *__memcpy(void *to, const void *from, size_t len);
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
 
+/*
+ * KMSAN needs to instrument as much code as possible. Use C versions of
+ * memsetXX() from lib/string.c under KMSAN.
+ */
+#if !defined(CONFIG_KMSAN)
 #define __HAVE_ARCH_MEMSET16
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
@@ -57,6 +62,7 @@ static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 		     : "memory");
 	return s;
 }
+#endif
 
 #define __HAVE_ARCH_MEMMOVE
 void *memmove(void *dest, const void *src, size_t count);
-- 
2.39.2.722.g9855ee24e9-goog

