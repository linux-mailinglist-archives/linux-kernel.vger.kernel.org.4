Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099A570DEA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjEWOIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbjEWOHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:07:13 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FC61B4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:06:55 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f1411e8111so8183397e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850753; x=1687442753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1mJE8PBb75X4TbUyJXZ6L55Fw+NsuGtTu+nI/l3Cvc=;
        b=sZzbi9Or1ecOkZRiN09Yj29Ot8B7LAVjqlaksWa5mtFSaJfhhAjYBQqCbgu39f00zk
         VK7TpV3BWK7N5disTxsUT+9gEJBxOb/ehtepI30IxdIgZOD7ILx03dfX1U9LUlrqnIxN
         o/DfgylSvuaURfgnFTqAlkk4/e/2QTF/i6nSUNEA8A45JrglmfBlJskn+PBcNSxo8Nax
         UjDkj9kSQQAr49/ra9mfVBiByY1gHuy6vLurVvXWcr3GtGvlt7ps8J70oCU3gREuO2Ow
         Oymkav54lF/OR103ZsyoD4QG8gT0MmmztfsSMu7sHfsLZwHZYwfd4ojLRHaLUm/2afXV
         RLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850753; x=1687442753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1mJE8PBb75X4TbUyJXZ6L55Fw+NsuGtTu+nI/l3Cvc=;
        b=O0LexNQTnSwYUqFbPTbpXZMZG29cdUl1XXB0aKK7saRTxUOZgr7vXJOlnyRyQ3ObmJ
         kN1r3e3GtflS22A8pOhQAVs/s+MnfAtx6dSajS5rxyE9l4wROA4aL8s02ZmjVtawQ3s0
         M/JhdUgBEN40aUlC9dug4PVRBTecmIWPa60/HhNWdNb9JP8+lYiG72Ol3Sq7HgzamhIl
         9fJZ2syX2iZA7IuGXyJYGjnFBuQotoQ5C1a1ZtC0fj9CFIiOmTcyUf5j8epu84HgIzh4
         VZ5X8BxPoc8pqfClS+eIwlpWRxsF6fgrLvXOMSEBzd+O8rKl1ys/nx39bkcPkD5OhCZJ
         HZ9g==
X-Gm-Message-State: AC+VfDx3/qXM1PVhiTQ2omJ/pi1FeyQa0dqQrSamcgNqC6iRCKQL9Hk2
        zxF1iRLkaz/MHmCCdUAetHL3tw==
X-Google-Smtp-Source: ACHHUZ7YlzepS19qIlofP4XlSVUTHmMLxnEQ9ww0qjdX5Jh1QQqAhfZ8W2WtZdVOQzfdgWC9DXghfQ==
X-Received: by 2002:ac2:52ad:0:b0:4f3:8263:cfdb with SMTP id r13-20020ac252ad000000b004f38263cfdbmr3539737lfm.50.1684850753268;
        Tue, 23 May 2023 07:05:53 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004e9bf853c27sm1346562lfp.70.2023.05.23.07.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:05:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 16:05:32 +0200
Subject: [PATCH v3 08/12] arm64: vdso: Pass (void *) to virt_to_page()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v3-8-a16c19c03583@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
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
        linux-cifs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the other calls in this function virt_to_page() expects
a pointer, not an integer.

However since many architectures implement virt_to_pfn() as
a macro, this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix this up with an explicit cast.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 0119dc91abb5..d9e1355730ef 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -288,7 +288,7 @@ static int aarch32_alloc_kuser_vdso_page(void)
 
 	memcpy((void *)(vdso_page + 0x1000 - kuser_sz), __kuser_helper_start,
 	       kuser_sz);
-	aarch32_vectors_page = virt_to_page(vdso_page);
+	aarch32_vectors_page = virt_to_page((void *)vdso_page);
 	return 0;
 }
 

-- 
2.34.1

