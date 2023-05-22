Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4C70B5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjEVHCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjEVHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:01:33 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41219B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:00:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af20198f20so41912251fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738851; x=1687330851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=721W88MgL2sNJMPnk6EOnDreN0TGHiKcLljkK4k+Xz4=;
        b=XQtAW71u4fTNd1m3CoQ2jBdXD9/L9co0wiCGXKPV7VPHkFBkn2paLpq4u7Zun4vihP
         Jt89fVfIK/kqwIEhUG0rEaMiY9youfI2gwNHpVmFNoLUlHPTqMB+dSsLsyZ0Nud3GfbF
         dtwCWhOjSDsxmfy8EsojhF7c8s35Z8LE87tWI+GqyJFAAak2TwvLXaQdq7RckdkYTHnU
         18kKgbLJk4GVeA4A4vRYQZN2Dj0n1wcSakUxJpXVVadQkTB4oxfQonCpFh8YOMyqM+LF
         0rSyjSqVr+DzD+fnTYDbXV9mB2Zq6QefKszArXVUbAr8pzAQFYflvnoSfXBTu+vX7dJn
         HUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738851; x=1687330851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=721W88MgL2sNJMPnk6EOnDreN0TGHiKcLljkK4k+Xz4=;
        b=DFFEvEQjx6vVsG/Jvc9TLcR2iYwOya5OC2LpCKIEENLQJhr0lLihTn5oiYjGs/VlWI
         phrtHBsNeBz6qC0QwTQEIoRcvbaMIOjzv02CfPQlZCPpTJUAAaXvW195D8lT3N1qAEuz
         SL+qYcScF3UPjfnx450q2SJhHd19PrY1c2hm/Wvu8opJklF06XCrol8krNkqE2Myrl43
         tsn4V0VUJ5KOy6i4RkIOvp7J4kCkqIhS44xsYA6gZmNlLznwjbMC6J/MdlAKVn4Q1qQO
         ePFNHb+u/igoXci02s2DWHQhvG3UAyRVrkmF9ujMFjYcpIhz0vNPtQPRFvPxrthbYE03
         NfdA==
X-Gm-Message-State: AC+VfDxjfTuQQK2PinAgwkVkAaCgBX6O4TBJU38dvnnXTdfbLi8bMjVW
        y1WJp9vB/4hooXp3mAG+S7XUZQ==
X-Google-Smtp-Source: ACHHUZ5ydZUl5A6m9S8q9aK0NB+Gru9l4ALPwz/cspLv7wmn5Xxzg3mgI231HvvSe3EG+T/ALpu70Q==
X-Received: by 2002:a2e:8e89:0:b0:2b0:259d:f670 with SMTP id z9-20020a2e8e89000000b002b0259df670mr453615ljk.4.1684738850979;
        Mon, 22 May 2023 00:00:50 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q4-20020a2e8744000000b002adb98fdf81sm1010187ljj.7.2023.05.22.00.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:00:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 09:00:46 +0200
Subject: [PATCH v2 11/12] arm64: memory: Make virt_to_pfn() a static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v2-11-0948d38bddab@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

Since arm64 is using <asm-generic/memory_model.h> to provide
__phys_to_pfn() we need to move the inclusion of that header
up, so we can resolve the static inline at compile time.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/include/asm/memory.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index c735afdf639b..4d85212b622e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -331,6 +331,14 @@ static inline void *phys_to_virt(phys_addr_t x)
 	return (void *)(__phys_to_virt(x));
 }
 
+/* Needed already here for resolving __phys_to_pfn() in virt_to_pfn() */
+#include <asm-generic/memory_model.h>
+
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __phys_to_pfn(virt_to_phys(kaddr));
+}
+
 /*
  * Drivers should NOT use these either.
  */
@@ -339,7 +347,6 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define __pa_nodebug(x)		__virt_to_phys_nodebug((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-#define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
 #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
 /*

-- 
2.34.1

