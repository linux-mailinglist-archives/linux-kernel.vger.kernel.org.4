Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5227C7169C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjE3QgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjE3QgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:36:11 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C035D123;
        Tue, 30 May 2023 09:35:50 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-39a3f2668bdso540114b6e.2;
        Tue, 30 May 2023 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685464550; x=1688056550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMjYKQ2PlZitUpCphm+vKSc5wezwssaSZO31t1ueH0c=;
        b=r476RQSdTR6xTXIl/DE6+1yq3sBfoNAJfwfKe+zjzaVW+ei0z8JZvo5gAURjHWmfUl
         x+1IEAOAwLtt9iIybFCimHLWnZsXDtr6b3Q4YoFykth3FXWqZ15b32vib2t9Tw9iy+Yz
         yyglPe7G4b/gyoORnL8TDiKsI8yYfHo6xzX1jNtggXK5Nb/W3S3e9ZuXiZl/Qov0KNSv
         anr7zuy9g9Jp5TV63Ub7dJoQDE7LPsPNo0Bg3wHPLLdcWTiK0zzNneY8mVK2mF4Q4/Ty
         RqY0MxtJafogVr+vgly2hE9u0pQkgCW2mTvBttD2ceEmLT5Nm9eaVRpWrKHhAuzHW7v7
         qNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464550; x=1688056550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMjYKQ2PlZitUpCphm+vKSc5wezwssaSZO31t1ueH0c=;
        b=kaVaRZzZjcYN6XNLP0K8aRirkPutK/2FOMksIb/dj4G+swXVyBFJvZsf9VC3s8RQoc
         Z+8djBbGGYBT7+V1WRLV4Cv1DlhBCxcURBmxWEYSNHNcRVA5p0RZ05FZoQBn3oynXSTg
         XBl7NRzJXS7KX04XQINnDZVECudQhbKmPGh/Gqj+iURVKtmI7mEY7aBWWPSKCcDHCVmP
         gi5AtRoRCTUD4w3X/43CwUh2uO4qLoyjBO8lcSolPY7BkdvaJaoZMm7hFnPKx6I9rOmv
         LkVFa5igoHs7+UxFmIr9eYYUEoVMKvNJnCnUJkqiOyNjr71uw3M3XPYiwPi7M4w89dpv
         /TWw==
X-Gm-Message-State: AC+VfDzUm8xpOS3/T5JphDisWUz0dMggutjt9YzOPjwTYDbA5y3vgeqh
        RZispvpOLLK0hHIhwWu0ReBjVezAPN3QnQ==
X-Google-Smtp-Source: ACHHUZ4QKNaHMg7IgLSfs6rgcULW9vkIiMfB21T72+x/KhXMgytdyZnCOYRD52E1Vrt/utuAaZrYKQ==
X-Received: by 2002:a54:4e83:0:b0:398:dd2d:b114 with SMTP id c3-20020a544e83000000b00398dd2db114mr1337550oiy.58.1685464549833;
        Tue, 30 May 2023 09:35:49 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id co17-20020a0566383e1100b003c4e02148e5sm803901jab.53.2023.05.30.09.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:35:49 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:35:46 +0000
Message-ID: <20230530163546.986188-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 kernel/time/clocksource.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 91836b727cef..88cbc1181b23 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1480,7 +1480,7 @@ static int __init boot_override_clocksource(char* str)
 {
 	mutex_lock(&clocksource_mutex);
 	if (str)
-		strlcpy(override_name, str, sizeof(override_name));
+		strscpy(override_name, str, sizeof(override_name));
 	mutex_unlock(&clocksource_mutex);
 	return 1;
 }

