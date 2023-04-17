Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BC36E3D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjDQCVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDQCU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:20:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571582D7D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:20:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id lh8so11131210plb.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1681698054; x=1684290054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHvjQtUaREpSNyWBXjrmpBHAA+Syp+wBJ3S8TK4rHhQ=;
        b=gzd7vt8CRFhl98tPP49VyB5QhIOFyk9OiW0U77waZv3q+sOEbugYPjOn/2iUXm0J9k
         1D5Gl2oUiWxGUgQvVeJL87XGL8ty19ACOYM96FoUlVmfkijsGOt8ZQvXd/IrYy2aAEZs
         RilTj1yls3LrbdYlne7PkVMKt29zbfFYL2YcYLeZ+NG03PPlLhd+gOd7rfgVYj3tUUo1
         U48f/4sql08oEcqAPUAz3Nf2T+jn5RYDLfItg5xyHfbUGZEAQF3qkP4ozcEVAVZYfQ4A
         q3nYU/NllkG0YuHZQMuTAVIDNgcIGrKxCd4LhkgMbO1zPkV0lao/fl10wx3kgHYs5ilP
         i4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681698054; x=1684290054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHvjQtUaREpSNyWBXjrmpBHAA+Syp+wBJ3S8TK4rHhQ=;
        b=G6TiLp84N0DjExwfIT9/Ay0dyYuGpmAF2SJN2TMYFYf0oFdCiAa2NTVaNaRytR6Zkt
         rXabZitNk2bZdDZXRaYh3TGnF4rYDTlGQyYxpMzBxCvJXOFs9G376Vk8QuyZ8MrEZEOi
         pOiQ1vDe3Mws4QLmKWBt1QCAheSMG/ONuF1phLbUt+hEdxyoL/GYyRQn3mEgWJEmH3mA
         EIFk4+hXK+PkreiI/eFllEIP2FxS4kxxBLkMDk+lNmOwYIDDmTygM+BYcjRthLnsZvJI
         RRKR1gmRgoa7fm+b+f98RI4QSdn03WVZrdiVG3cBsQnww2gduuxZ1rVKOiw9+CUp5cMM
         B7lA==
X-Gm-Message-State: AAQBX9fqi0kBWO+t32+UJ+qEW0O+Hv2jrXSqwddqjGEBQQQ6AHCrFXpE
        JfB8DoU4vIQ5UgziGbJ7Kij1ew==
X-Google-Smtp-Source: AKy350aUg/+byQRor+Xmx6jST3kydOARIy/gQeW6fnd1F/PWGpwEXFO2dl8KlBBtOUb75i/bl/lLTw==
X-Received: by 2002:a17:902:d40c:b0:1a6:712c:24c5 with SMTP id b12-20020a170902d40c00b001a6712c24c5mr9035249ple.69.1681698053769;
        Sun, 16 Apr 2023 19:20:53 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b001a68986a3d8sm6195243plb.24.2023.04.16.19.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 19:20:53 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shunsuke Mie <mie@igel.co.jp>,
        Stefano Garzarella <sgarzare@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 RESEND 2/2] tools/virtio: fix build caused by virtio_ring changes
Date:   Mon, 17 Apr 2023 11:20:37 +0900
Message-Id: <20230417022037.917668-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417022037.917668-1-mie@igel.co.jp>
References: <20230417022037.917668-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the build dependency for virtio_test. The virtio_ring that is used from
the test requires container_of_const(). Change to use container_of.h kernel
header directly and adapt related codes.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes from v2: https://lore.kernel.org/virtualization/20230410112845.337212-2-mie@igel.co.jp/
- Remove an unnecessary change
- Correct indentations
- Retrieve the __user definition to prevent any unintended side effects

 tools/include/linux/types.h   |  5 +++++
 tools/virtio/linux/compiler.h |  2 ++
 tools/virtio/linux/kernel.h   |  5 +----
 tools/virtio/linux/uaccess.h  | 11 ++---------
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 051fdeaf2670..8519386acd23 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -49,7 +49,12 @@ typedef __s8  s8;
 #endif
 
 #define __force
+/* This is defined in linux/compiler_types.h and is left for backward
+ * compatibility.
+ */
+#ifndef __user
 #define __user
+#endif
 #define __must_check
 #define __cold
 
diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 2c51bccb97bb..1f3a15b954b9 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -2,6 +2,8 @@
 #ifndef LINUX_COMPILER_H
 #define LINUX_COMPILER_H
 
+#include "../../../include/linux/compiler_types.h"
+
 #define WRITE_ONCE(var, val) \
 	(*((volatile typeof(val) *)(&(var))) = (val))
 
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 8b877167933d..6702008f7f5c 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -10,6 +10,7 @@
 #include <stdarg.h>
 
 #include <linux/compiler.h>
+#include "../../../include/linux/container_of.h"
 #include <linux/log2.h>
 #include <linux/types.h>
 #include <linux/overflow.h>
@@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
 	free((void *)addr);
 }
 
-#define container_of(ptr, type, member) ({			\
-	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
-	(type *)( (char *)__mptr - offsetof(type,member) );})
-
 # ifndef likely
 #  define likely(x)	(__builtin_expect(!!(x), 1))
 # endif
diff --git a/tools/virtio/linux/uaccess.h b/tools/virtio/linux/uaccess.h
index 991dfb263998..f13828e0c409 100644
--- a/tools/virtio/linux/uaccess.h
+++ b/tools/virtio/linux/uaccess.h
@@ -6,15 +6,10 @@
 
 extern void *__user_addr_min, *__user_addr_max;
 
-static inline void __chk_user_ptr(const volatile void *p, size_t size)
-{
-	assert(p >= __user_addr_min && p + size <= __user_addr_max);
-}
-
 #define put_user(x, ptr)					\
 ({								\
 	typeof(ptr) __pu_ptr = (ptr);				\
-	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
+	__chk_user_ptr(__pu_ptr);				\
 	WRITE_ONCE(*(__pu_ptr), x);				\
 	0;							\
 })
@@ -22,7 +17,7 @@ static inline void __chk_user_ptr(const volatile void *p, size_t size)
 #define get_user(x, ptr)					\
 ({								\
 	typeof(ptr) __pu_ptr = (ptr);				\
-	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
+	__chk_user_ptr(__pu_ptr);				\
 	x = READ_ONCE(*(__pu_ptr));				\
 	0;							\
 })
@@ -37,7 +32,6 @@ static void volatile_memcpy(volatile char *to, const volatile char *from,
 static inline int copy_from_user(void *to, const void __user volatile *from,
 				 unsigned long n)
 {
-	__chk_user_ptr(from, n);
 	volatile_memcpy(to, from, n);
 	return 0;
 }
@@ -45,7 +39,6 @@ static inline int copy_from_user(void *to, const void __user volatile *from,
 static inline int copy_to_user(void __user volatile *to, const void *from,
 			       unsigned long n)
 {
-	__chk_user_ptr(to, n);
 	volatile_memcpy(to, from, n);
 	return 0;
 }
-- 
2.25.1

