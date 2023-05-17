Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFC070689C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjEQMty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjEQMtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:49:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6EE2105
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 073A963BA4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C545AC433D2;
        Wed, 17 May 2023 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684327790;
        bh=8lkciz7oC+UxHNVTKqiQ6m8JshO9scCqH3ab8zPOqRY=;
        h=From:To:Cc:Subject:Date:From;
        b=dUCYVuTnKbWaEN3kCVb/rQwBk4MzkacbW803oIJFcVX2NEvTSMpWcI9g1jzZ8C8c8
         nbssGJFy2pFWh4LlhLY5CuHVte04PdvwXtwZ+ZI7hFRpUGotq5DVCzu5EmVbwiSco0
         h32QAhiyA9K/lIvql/ZzDj2i6EhENnOQQd9MwX8YwHUk1CLC0JfiphVfgy6wZO5bpx
         4ohtOdtnd9rptghrHz4jznXr/GTic0zH6+eyWcGl7o9O6JHlvRJWVE0bLk8tVsEOHe
         1fR5EzsjFor4K0ZGPwF2J8tZfip6uP4sFQnlgpbVbJ1VHa2g2MS1a6l83xhrR4qwhP
         /EjnwhquuB9aw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     kasan-dev@googlegroups.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Rong Tao <rongtao@cestc.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kcov: add prototypes for helper functions
Date:   Wed, 17 May 2023 14:49:25 +0200
Message-Id: <20230517124944.929997-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A number of internal functions in kcov are only called from
generated code and don't technically need a declaration, but
'make W=1' warns about global symbols without a prototype:

kernel/kcov.c:199:14: error: no previous prototype for '__sanitizer_cov_trace_pc' [-Werror=missing-prototypes]
kernel/kcov.c:264:14: error: no previous prototype for '__sanitizer_cov_trace_cmp1' [-Werror=missing-prototypes]
kernel/kcov.c:270:14: error: no previous prototype for '__sanitizer_cov_trace_cmp2' [-Werror=missing-prototypes]
kernel/kcov.c:276:14: error: no previous prototype for '__sanitizer_cov_trace_cmp4' [-Werror=missing-prototypes]
kernel/kcov.c:282:14: error: no previous prototype for '__sanitizer_cov_trace_cmp8' [-Werror=missing-prototypes]
kernel/kcov.c:288:14: error: no previous prototype for '__sanitizer_cov_trace_const_cmp1' [-Werror=missing-prototypes]
kernel/kcov.c:295:14: error: no previous prototype for '__sanitizer_cov_trace_const_cmp2' [-Werror=missing-prototypes]
kernel/kcov.c:302:14: error: no previous prototype for '__sanitizer_cov_trace_const_cmp4' [-Werror=missing-prototypes]
kernel/kcov.c:309:14: error: no previous prototype for '__sanitizer_cov_trace_const_cmp8' [-Werror=missing-prototypes]
kernel/kcov.c:316:14: error: no previous prototype for '__sanitizer_cov_trace_switch' [-Werror=missing-prototypes]

Adding prototypes for these in a header solves that problem, but now
there is a mismatch between the built-in type and the prototype on
64-bit architectures because they expect some functions to take
a 64-bit 'unsigned long' argument rather than an 'unsigned long long'
u64 type:

include/linux/kcov.h:84:6: error: conflicting types for built-in function '__sanitizer_cov_trace_switch'; expected 'void(long long unsigned int,  void *)' [-Werror=builtin-declaration-mismatch]
   84 | void __sanitizer_cov_trace_switch(u64 val, u64 *cases);
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Avoid this as well with a custom type definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/kcov.h | 17 +++++++++++++++++
 kernel/kcov.c        |  7 ++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index ee04256f28af..b851ba415e03 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -72,6 +72,23 @@ static inline void kcov_remote_stop_softirq(void)
 		kcov_remote_stop();
 }
 
+#ifdef CONFIG_64BIT
+typedef unsigned long kcov_u64;
+#else
+typedef unsigned long long kcov_u64;
+#endif
+
+void __sanitizer_cov_trace_pc(void);
+void __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2);
+void __sanitizer_cov_trace_cmp2(u16 arg1, u16 arg2);
+void __sanitizer_cov_trace_cmp4(u32 arg1, u32 arg2);
+void __sanitizer_cov_trace_cmp8(kcov_u64 arg1, kcov_u64 arg2);
+void __sanitizer_cov_trace_const_cmp1(u8 arg1, u8 arg2);
+void __sanitizer_cov_trace_const_cmp2(u16 arg1, u16 arg2);
+void __sanitizer_cov_trace_const_cmp4(u32 arg1, u32 arg2);
+void __sanitizer_cov_trace_const_cmp8(kcov_u64 arg1, kcov_u64 arg2);
+void __sanitizer_cov_trace_switch(kcov_u64 val, void *cases);
+
 #else
 
 static inline void kcov_task_init(struct task_struct *t) {}
diff --git a/kernel/kcov.c b/kernel/kcov.c
index ddcf4f3ca9c9..c3124f6d5536 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -279,7 +279,7 @@ void notrace __sanitizer_cov_trace_cmp4(u32 arg1, u32 arg2)
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_cmp4);
 
-void notrace __sanitizer_cov_trace_cmp8(u64 arg1, u64 arg2)
+void notrace __sanitizer_cov_trace_cmp8(kcov_u64 arg1, kcov_u64 arg2)
 {
 	write_comp_data(KCOV_CMP_SIZE(3), arg1, arg2, _RET_IP_);
 }
@@ -306,16 +306,17 @@ void notrace __sanitizer_cov_trace_const_cmp4(u32 arg1, u32 arg2)
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_const_cmp4);
 
-void notrace __sanitizer_cov_trace_const_cmp8(u64 arg1, u64 arg2)
+void notrace __sanitizer_cov_trace_const_cmp8(kcov_u64 arg1, kcov_u64 arg2)
 {
 	write_comp_data(KCOV_CMP_SIZE(3) | KCOV_CMP_CONST, arg1, arg2,
 			_RET_IP_);
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_const_cmp8);
 
-void notrace __sanitizer_cov_trace_switch(u64 val, u64 *cases)
+void notrace __sanitizer_cov_trace_switch(kcov_u64 val, void *arg)
 {
 	u64 i;
+	u64 *cases = arg;
 	u64 count = cases[0];
 	u64 size = cases[1];
 	u64 type = KCOV_CMP_CONST;
-- 
2.39.2

