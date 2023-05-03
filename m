Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1016F5FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjECUOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjECUOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:14:36 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B58A62
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683144808;
        bh=40ZXckww7AYtcV479k70ydFlE0zo0yVWPM2kmuXq4GE=;
        h=From:To:Cc:Subject:Date:From;
        b=iWQhduDV2eR1p8Thl+BMwPzCkIwdsiO/5RLyy8ywDEU3r6f16RUbK/SQUaD/8xsdL
         3OVqXh1KHJm0i2fCxTimnKBAcpcDrQMNByvpRV7eOP5l2Yybwd6Xia/HGrnYGDl3L0
         iMmMYtqenUAKxh8LeUqDRp7spzSOT+ONHMNuRvtTuVRX9ucQ40zsQcK/p2lkKqq2h7
         /iW+zAJ4wDCOG/bEKoPymILTMcMYk+x06S+cB1qPjcG/lUAzOw0nLM/5wMfLsDX+ZM
         w6co6Xh+3+g1i784LVhFGB7QlwV/xHSl2imfTDobzxaEN3RqOmVVCJ8KXsPyxWUflS
         XdCyV2qe+sO9w==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QBSnN4dzBz11hs;
        Wed,  3 May 2023 16:13:28 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 1/3] selftests/rseq: Implement rseq_unqual_scalar_typeof
Date:   Wed,  3 May 2023 16:13:22 -0400
Message-Id: <20230503201324.1587003-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow defining variables and perform cast with a typeof which removes
the volatile and const qualifiers.

This prevents declaring a stack variable with a volatile qualifier
within a macro, which would generate sub-optimal assembler.

This is imported from the "librseq" project.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/compiler.h | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/rseq/compiler.h b/tools/testing/selftests/rseq/compiler.h
index f47092bddeba..8dc7f881e253 100644
--- a/tools/testing/selftests/rseq/compiler.h
+++ b/tools/testing/selftests/rseq/compiler.h
@@ -33,4 +33,31 @@
 #define RSEQ_COMBINE_TOKENS(_tokena, _tokenb)	\
 	RSEQ__COMBINE_TOKENS(_tokena, _tokenb)
 
+#ifdef __cplusplus
+#define rseq_unqual_scalar_typeof(x)					\
+	std::remove_cv<std::remove_reference<decltype(x)>::type>::type
+#else
+/*
+ * Use C11 _Generic to express unqualified type from expression. This removes
+ * volatile qualifier from expression type.
+ */
+#define rseq_unqual_scalar_typeof(x)					\
+	__typeof__(							\
+		_Generic((x),						\
+			char: (char)0,					\
+			unsigned char: (unsigned char)0,		\
+			signed char: (signed char)0,			\
+			unsigned short: (unsigned short)0,		\
+			signed short: (signed short)0,			\
+			unsigned int: (unsigned int)0,			\
+			signed int: (signed int)0,			\
+			unsigned long: (unsigned long)0,		\
+			signed long: (signed long)0,			\
+			unsigned long long: (unsigned long long)0,	\
+			signed long long: (signed long long)0,		\
+			default: (x)					\
+		)							\
+	)
+#endif
+
 #endif  /* RSEQ_COMPILER_H_ */
-- 
2.25.1

