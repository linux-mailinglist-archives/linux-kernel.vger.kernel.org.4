Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577B5654251
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiLVOFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbiLVOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:05:13 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53F12716E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:05:11 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g13so2869837lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4bOXqBLEUAELZx0PBkLRni+ahOZSxFQFD0xQwRwD7M=;
        b=R/YuABqQYNQjUDTuiFo7CrY5tcfWuW86rLqIi+gm8z7bYA/mnOwVSxfWDQRYWzbuez
         cg7hRymS7avgjEG+pQ9SywyNYDFWlYJ70Ijl8XSTwUogGvWUEtIe/wPxDxhAvONH8IXG
         ipKLu+oTCNSol50sSYdmGeDRg1EXgzceYZWR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4bOXqBLEUAELZx0PBkLRni+ahOZSxFQFD0xQwRwD7M=;
        b=H9QbyGcVL1We2fwIz3+2hzLRauCYO5130z1zhvWg53gD2NBZ0HMwyFLzU+8WmDtPSd
         pGpTL46u2beG7shCoVWz1mHVpsf+Ff6wNm0x2aufCtR+qeVFiiR2leXKyKWnAH5uJWnO
         j1ylxmltmmEmGm5HN88orDx245DIFermoDsGYl2RuVlJnJZ+uaO4U7bsAFhUjOouJ2ua
         jtHKWse9DtYKxpA54jIGgQKSnppf8Pfhpk7l81BccgzjGJSpAqiRm4t4wvPieHKDFA7P
         YfMToUXPW11ElVfbd8HFbi1ojEH+g4BIeUIRH7iR6pUh9CS85nPdOMxWFUiV9BeIiQNt
         g/RQ==
X-Gm-Message-State: AFqh2kqRxl7sAA7h+v7Qc+Gf9GrXKub9yWMz+3PSsntelHGe4mUIf0Ih
        ViHm+vz+m91RO2zZqRv3r7R54Q==
X-Google-Smtp-Source: AMrXdXumgz9SdjrzNpd3ZjMzm82uzeSI4y9hf9CSxf5c4CZfBVLH3uKjn9bv/YYemwmTlB2ETW8uxA==
X-Received: by 2002:a19:c20d:0:b0:4b5:7859:349f with SMTP id l13-20020a19c20d000000b004b57859349fmr1519190lfc.48.1671717910195;
        Thu, 22 Dec 2022 06:05:10 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x11-20020a0565123f8b00b004b5adb59ed5sm75261lfa.297.2022.12.22.06.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:05:09 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Jason Donenfeld <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] string.c: test *cmp for all possible 1-character strings
Date:   Thu, 22 Dec 2022 15:05:06 +0100
Message-Id: <20221222140506.1961281-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The switch to -funsigned-char made a pre-existing bug on m68k more
apparent. That is now fixed (by removing m68k's private strcmp(), see
commit 7c0846125358), but we still have quite a few architectures that
provide one or more of strcmp(), strncmp() and memcmp().

They probably all work fine for the cases where the input is all
ASCII, and/or where the caller only wants to know about equality or
not (i.e. only checks whether the return value is 0 or not).

Let's check that all these implementations also behave correctly for
bytes with the high bit set, and provide the correct ordering -
independent of us now building with -funsigned-char, the C standard
says that these *cmp functions should consider the buffers as
consisting of unsigned chars.

This is only intended to help find other latent bugs and can/should be
ripped out again before v6.2, or perhaps moved to test_string.c in
some form, but for now I think it's worth doing unconditionally.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/string.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/string.c b/lib/string.c
index 4fb566ea610f..1718f96e8082 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -880,3 +880,30 @@ void *memchr_inv(const void *start, int c, size_t bytes)
 	return check_bytes8(start, value, bytes % 8);
 }
 EXPORT_SYMBOL(memchr_inv);
+
+static int sign(int x)
+{
+	return (x > 0) - (x < 0);
+}
+
+static int test_xxxcmp(void)
+{
+	char a[2], b[2];
+	int i, j;
+
+	a[1] = b[1] = 0;
+	for (i = 0; i < 256; ++i) {
+		a[0] = i;
+		for (j = 0; j < 256; ++j) {
+			b[0] = j;
+			WARN_ONCE(sign(strcmp(a, b)) != sign(i - j),
+				  "strcmp() broken for (%2ph, %2ph)\n", a, b);
+			WARN_ONCE(sign(memcmp(a, b, 2)) != sign(i - j),
+				  "memcmp() broken for (%2ph, %2ph)\n", a, b);
+			WARN_ONCE(sign(strncmp(a, b, 2)) != sign(i - j),
+				  "strncmp() broken for (%2ph, %2ph)\n", a, b);
+		}
+	}
+	return 0;
+}
+late_initcall(test_xxxcmp);
-- 
2.37.2

