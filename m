Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F826DD5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDKIvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjDKIvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:51:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B3E130
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:51:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-633a6bf6af9so642840b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681203108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vp0eq9dOyQ9LiZivIOEX8Snc/Vjl4AGDIHEdpoo1Be8=;
        b=ceIR9II3v+3BnB4Ihj+HgwYOHoI8+5mu4QRYxIdgztNjPtegtY9Y75Ta9ZZTRSS7pu
         EO+pJY6xoZUWWjmeUf4kxW9M46nbPhjCVs7fDqbRb6+a2F2KFYWFEjPKenV5o0/tDbzZ
         2hjut1opqvsxh08oA2Xt3H0kaJb3rlZRF25e6F+kYg5yMuaUq5T+mXNvl4fjhSoKYthN
         qoufN0GkwduYauCqzl6ZsBu93Vgc2QcLYaKY4IglahJ8SzWCV1NDHg/aJgyUTq3UjC1U
         5vYY9MsQ9X9fE6S5apJv8YZyP7NziMpKbjXJRVUv3Lz6tPU121KyXV7TjtlGBKNz6cUb
         58aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681203108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vp0eq9dOyQ9LiZivIOEX8Snc/Vjl4AGDIHEdpoo1Be8=;
        b=BA9OuTHa7ndlvJEh3JFka7z2llloZpJfM7v9sbHQZX92DGhRftehVclCkKJLzPgV5m
         /kF50imidkrjHgqux2MXX+cZ5h1lcwxV4fFfhgUem+lB7MNu79vOZCApWYcIPWiIKhkR
         Zpf8Oe7qJ5EUzWMbE8YRaaRgCdRfzPEP8QYn74SCu2+Wi2esbMMKeJJo4LTI2GPC6/2G
         qVyhzlghkSWUL4M9Lj9vEYTk5Wnt0dPJZqzPe5xglh93sKMUq3ILCjJTA3XRSEfWUaPI
         u3vjCgYjqn9OP/mtgVR/pM8lqzxy8zp+S4MRQR9Bfv1IvQr0q1lqvPx4hmc3Ps35OCX7
         SdmQ==
X-Gm-Message-State: AAQBX9djcrEsieci4YDyRN8KXz3Lf/XhUa3o329B/qSDxxkUKD2BNMrV
        IgWaI8LJ/UQQLniz4J4g6nL1gw==
X-Google-Smtp-Source: AKy350bAfcx+pzEv0yDiZQWws7mo/brJGMxwoFip7atePKowBKAgBD/zeU+NkAFS3nD9N+aayYdqDg==
X-Received: by 2002:a62:483:0:b0:637:920c:25fd with SMTP id 125-20020a620483000000b00637920c25fdmr5495471pfe.17.1681203108285;
        Tue, 11 Apr 2023 01:51:48 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e20-20020aa78c54000000b0059085684b54sm9573579pfd.140.2023.04.11.01.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 01:51:48 -0700 (PDT)
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
Subject: [PATCH v3 2/2] tools/virtio: fix build caused by virtio_ring changes
Date:   Tue, 11 Apr 2023 17:51:39 +0900
Message-Id: <20230411085139.375393-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411085139.375393-1-mie@igel.co.jp>
References: <20230411085139.375393-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Changes from v2:
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

