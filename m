Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413F26EEE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbjDZGv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 02:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbjDZGvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB1C26AD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682491836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2EMYluwvhrMA17BDykO/E+Vbp/FohqG3vlUmCHX23RY=;
        b=IqvtpSGyrf4TVSrzBsSODe9+HSucHL6RpLyMPvz9V1RLMHbGkBpQGWx33rjk6xzMfRg4GD
        zsk/nOyQCbVeZEeXaP1uzodO6Je2dBAnCejeaXGEcpuJBY18EdY8uIV0nmDS8wGE4IS/t8
        QG24Ifyis6Bszxmr4xuc+jxJixJ5KPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-fJMySYbeMG6TtRg1n50BnA-1; Wed, 26 Apr 2023 02:50:34 -0400
X-MC-Unique: fJMySYbeMG6TtRg1n50BnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55105858F09;
        Wed, 26 Apr 2023 06:50:34 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F29040C6E67;
        Wed, 26 Apr 2023 06:50:33 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-ia64@vger.kernel.org
Subject: [PATCH] arch/ia64/include: Remove CONFIG_IA64_DEBUG_CMPXCHG from uapi header
Date:   Wed, 26 Apr 2023 08:50:32 +0200
Message-Id: <20230426065032.517693-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_* switches should not be exposed in uapi headers.
The macros that are defined here are also only useful for the
kernel code, so let's move them to asm/cmpxchg.h instead.

The only two files that are using these macros are the headers
arch/ia64/include/asm/bitops.h and arch/ia64/include/asm/atomic.h
and these include asm/cmpxchg.h via asm/intrinsics.h, so this
movement should not cause any trouble.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/ia64/include/asm/cmpxchg.h      | 17 +++++++++++++++++
 arch/ia64/include/uapi/asm/cmpxchg.h | 17 -----------------
 scripts/headers_install.sh           |  1 -
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/ia64/include/asm/cmpxchg.h b/arch/ia64/include/asm/cmpxchg.h
index 94ef84429843..d9f01ede9768 100644
--- a/arch/ia64/include/asm/cmpxchg.h
+++ b/arch/ia64/include/asm/cmpxchg.h
@@ -13,4 +13,21 @@
 #define arch_cmpxchg_local		arch_cmpxchg
 #define arch_cmpxchg64_local		arch_cmpxchg64
 
+#ifdef CONFIG_IA64_DEBUG_CMPXCHG
+# define CMPXCHG_BUGCHECK_DECL	int _cmpxchg_bugcheck_count = 128;
+# define CMPXCHG_BUGCHECK(v)						\
+do {									\
+	if (_cmpxchg_bugcheck_count-- <= 0) {				\
+		void *ip;						\
+		extern int _printk(const char *fmt, ...);		\
+		ip = (void *) ia64_getreg(_IA64_REG_IP);		\
+		_printk("CMPXCHG_BUGCHECK: stuck at %p on word %p\n", ip, (v));\
+		break;							\
+	}								\
+} while (0)
+#else /* !CONFIG_IA64_DEBUG_CMPXCHG */
+# define CMPXCHG_BUGCHECK_DECL
+# define CMPXCHG_BUGCHECK(v)
+#endif /* !CONFIG_IA64_DEBUG_CMPXCHG */
+
 #endif /* _ASM_IA64_CMPXCHG_H */
diff --git a/arch/ia64/include/uapi/asm/cmpxchg.h b/arch/ia64/include/uapi/asm/cmpxchg.h
index 259ae57570bf..986dbe01d883 100644
--- a/arch/ia64/include/uapi/asm/cmpxchg.h
+++ b/arch/ia64/include/uapi/asm/cmpxchg.h
@@ -133,23 +133,6 @@ extern long ia64_cmpxchg_called_with_bad_pointer(void);
 #define cmpxchg64_local		cmpxchg64
 #endif
 
-#ifdef CONFIG_IA64_DEBUG_CMPXCHG
-# define CMPXCHG_BUGCHECK_DECL	int _cmpxchg_bugcheck_count = 128;
-# define CMPXCHG_BUGCHECK(v)						\
-do {									\
-	if (_cmpxchg_bugcheck_count-- <= 0) {				\
-		void *ip;						\
-		extern int _printk(const char *fmt, ...);		\
-		ip = (void *) ia64_getreg(_IA64_REG_IP);		\
-		_printk("CMPXCHG_BUGCHECK: stuck at %p on word %p\n", ip, (v));\
-		break;							\
-	}								\
-} while (0)
-#else /* !CONFIG_IA64_DEBUG_CMPXCHG */
-# define CMPXCHG_BUGCHECK_DECL
-# define CMPXCHG_BUGCHECK(v)
-#endif /* !CONFIG_IA64_DEBUG_CMPXCHG */
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_IA64_CMPXCHG_H */
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 36b56b746fce..afdddc82f02b 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -76,7 +76,6 @@ arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
 arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
 arch/hexagon/include/uapi/asm/ptrace.h:CONFIG_HEXAGON_ARCH_VERSION
 arch/hexagon/include/uapi/asm/user.h:CONFIG_HEXAGON_ARCH_VERSION
-arch/ia64/include/uapi/asm/cmpxchg.h:CONFIG_IA64_DEBUG_CMPXCHG
 arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
-- 
2.31.1

