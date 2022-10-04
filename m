Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E785F4391
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJDMwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiJDMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:52:05 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816FB5C9DF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:49:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4A8414075261;
        Tue,  4 Oct 2022 12:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4A8414075261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1664887712;
        bh=Ck5Yrp59BSgdaxi8+1q8adVNB1ocEzn1VfNnbPNEZD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFt7ymXmTWj1hG9o9FgPLU28OTIotoRQuV6OXznZvoaERL1kqNoG3gpMSdzHW6I4u
         02ZKniXpFb3tm4eyLjEnoouLqjQ6Q1lm8/W3sM3/RQKc7lZt+xTiAE6yYGFDNnU2p+
         o8UdQBx/830WIOE2uexsTAYPG9wuDv4D8wkF6tuQ=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v7 1/5] x86/boot: Add strlcat() and strscpy() to compressed kernel
Date:   Tue,  4 Oct 2022 15:48:20 +0300
Message-Id: <5a625c6373750bbdbdae517dd0e58836a4347ba7.1664886978.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1664886978.git.baskov@ispras.ru>
References: <cover.1664886978.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions simplify the code of command line concatenation
helper and reduce the probability of mistakes.

Use simpler implementation of strscpy than used in it kernel itself
to avoid code bloat in compressed kernel.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/string.c | 50 +++++++++++++++++++++++++++++++
 arch/x86/purgatory/purgatory.c    |  1 +
 2 files changed, 51 insertions(+)

diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
index 81fc1eaa3229..5c193fa0a09b 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -40,6 +40,56 @@ static void *____memcpy(void *dest, const void *src, size_t n)
 }
 #endif
 
+size_t strlcat(char *dest, const char *src, size_t count)
+{
+	size_t dsize = strlen(dest);
+	size_t len = strlen(src);
+	size_t res = dsize + len;
+
+	/* This would be a bug */
+	if (dsize >= count)
+		error("strlcat(): destination too big\n");
+
+	dest += dsize;
+	count -= dsize;
+	if (len >= count)
+		len = count-1;
+	memcpy(dest, src, len);
+	dest[len] = 0;
+	return res;
+}
+
+/* Don't include word-at-a-time code path in compressed kernel for simplicity */
+size_t strscpy(char *dest, const char *src, size_t count)
+{
+	long res = 0;
+
+	if (count == 0)
+		return -E2BIG;
+
+	if (count > INT_MAX) {
+		warn("strscpy(): Count is too big");
+		return -E2BIG;
+	}
+
+	while (count) {
+		char c;
+
+		c = src[res];
+		dest[res] = c;
+		if (!c)
+			return res;
+		res++;
+		count--;
+	}
+
+	/* Hit buffer length without finding a NUL; force NUL-termination. */
+	if (res)
+		dest[res-1] = '\0';
+
+	return -E2BIG;
+}
+
 void *memset(void *s, int c, size_t n)
 {
 	int i;
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 7558139920f8..65f0cedb65ae 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -57,3 +57,4 @@ void purgatory(void)
  * arch/x86/boot/compressed/string.c
  */
 void warn(const char *msg) {}
+void error(char *m) {}
-- 
2.35.1

