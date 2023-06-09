Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0DD72980D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbjFILTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjFILTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:19:04 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD73C1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686309542;
  x=1717845542;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=7XMigKyzIzkGYn81G4evNo2KHPOOkw2Qm++AiRLE9eM=;
  b=bgBKpe26ymYsevpWU8ZM/ybAdNsG47TSnm5L3ZpCqsyreDNiwZxVOhbf
   YJG/3BzBKBhGydzVuHmrQAVmG8fkIZEaX5QT4EitqUeN4slbbR1vQMQCh
   YEDZZCps0PQ5bW02phKFY9On+3QppH8V+euHiqguQBldqjmunLY9n578O
   5Zwgq47FgBc8i2fFF2ZXrHjbyndlWLpUECEkFlcVddjV0StXz/Fz/UKMl
   LTbntvNkNhfq2KpYuPOWo0E8XM09wP66rhVgn7sBigoZzeMLY2vS4Ls1a
   gV7MZiPlKD/5/JRr1i1zqp3FLfjCk8TKDH5U0N37gi3vEjYdm3ORH+43a
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 9 Jun 2023 13:18:54 +0200
Subject: [PATCH] x86: Fix build of UML with KASAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com>
X-B4-Tracking: v=1; b=H4sIAJ0Kg2QC/x2N0QrCMAxFf2Xk2UBNnWz+iviQtZkLm600KMLYv
 9vt8VzO5axgUlQMbs0KRb5qmlOF86mBMHF6CmqsDOTIu6vr8fNacGbjhOR7ivESfNd2UP2BTXA
 onMK0P8acaZ/fRUb9HYn7Y9v+0FOpHXIAAAA=
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        <linux-um@lists.infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        <kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building UML with KASAN fails since commit 69d4c0d32186 ("entry, kasan,
x86: Disallow overriding mem*() functions") with the following errors:

 $ tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
 ...
 ld: mm/kasan/shadow.o: in function `memset':
 shadow.c:(.text+0x40): multiple definition of `memset';
 arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
 ld: mm/kasan/shadow.o: in function `memmove':
 shadow.c:(.text+0x90): multiple definition of `memmove';
 arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
 ld: mm/kasan/shadow.o: in function `memcpy':
 shadow.c:(.text+0x110): multiple definition of `memcpy';
 arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here

If I'm reading that commit right, the !GENERIC_ENTRY case is still
supposed to be allowed to override the mem*() functions, so use weak
aliases in that case.

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/x86/lib/memcpy_64.S  | 4 ++++
 arch/x86/lib/memmove_64.S | 4 ++++
 arch/x86/lib/memset_64.S  | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 8f95fb267caa7..5dc265b36ef0b 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -40,7 +40,11 @@ SYM_TYPED_FUNC_START(__memcpy)
 SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
+#ifdef CONFIG_GENERIC_ENTRY
 SYM_FUNC_ALIAS(memcpy, __memcpy)
+#else
+SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+#endif
 EXPORT_SYMBOL(memcpy)
 
 SYM_FUNC_START_LOCAL(memcpy_orig)
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 02661861e5dd9..3b1a02357fb29 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -215,5 +215,9 @@ SYM_FUNC_START(__memmove)
 SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 
+#ifdef CONFIG_GENERIC_ENTRY
 SYM_FUNC_ALIAS(memmove, __memmove)
+#else
+SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
+#endif
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 7c59a704c4584..fe27538a355db 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -40,7 +40,11 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
+#ifdef CONFIG_GENERIC_ENTRY
 SYM_FUNC_ALIAS(memset, __memset)
+#else
+SYM_FUNC_ALIAS_WEAK(memset, __memset)
+#endif
 EXPORT_SYMBOL(memset)
 
 SYM_FUNC_START_LOCAL(memset_orig)

---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230609-uml-kasan-2392dd4c3858

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

