Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61E76DC641
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDJL3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDJL25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:28:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E3730E0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 04:28:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 20so6228785plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 04:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681126135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciKrq/Yl42ou0lRDT5MfvrbGiLHmmyRP4TLMhDsCh3E=;
        b=pHUTQCfUpVOzEVF3sbeGEFofvk8HKR084Iuw9uH3ue1A1DXQkdvSN7E1r/f0nsyBHv
         12OZBvKgalq4gXCq+/xdu1ZYptVV+6nl4eLwujelCO1/slbckVk5Nds8t2ciDnEmkp6l
         9iXB1xsuI7Bp3t2r6PGF/ZhXm/YJnGCRdID0OSkNLqwPn41oMdnaqxRyv715xL69+Y4w
         G2ZKpwHWawQ5Hx4ZMIcJ42tmPn1cS6oWcf74xcoGBFZOM3y2TakpG1YszImHJOseHHZN
         808esbtEb4eYLyNDVXhHLmPB/930ezbU9cbnW4cHD1wi8L5T+cVl1gB0Ok22EKca4RM/
         vNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681126135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciKrq/Yl42ou0lRDT5MfvrbGiLHmmyRP4TLMhDsCh3E=;
        b=ObTUVTM4ccrg810ePJ45F6RJzetV4vzusegmYhVC9HFQ9a1/7pfpLtL8i9pSiFeuWj
         0tFA+aGDKAhiEE/of7wiBxrl0iQGVo1owc6rOxhk28ErLp6h72wTctYs0RwAi+Yam5HV
         N0e7sl0oOc8CdK9uf0RvOUEP5EAVPMP4j1XOCZDTgmie4v2T0QB3X5aUGZvLMFSAXB4Y
         ZdnYieSJNj0BznGxz87CQsMlxBVVvaaOxcsRZzpIDJnsQUDCLJ23oCDqthkznA+qpWpM
         4ZHflww8TV9Ye7mpX4Z8MWEhYLsby36nUP9XPOnHW459mFC1+VlUoq9el0lgW5KlCb+U
         2HDw==
X-Gm-Message-State: AAQBX9f0t8eSBuaUDgs6oXnLmm8Jg7+0XeOhrStuaqTAbIsP0/jsJjvQ
        NPKRHM8ICO4fbTbF+r7qcStt1w==
X-Google-Smtp-Source: AKy350ZpKKAzldtZX1peVNJtayz/p4zL8IKT/lEfnP6SxlT3XHUUF2eamZZCkR+RV1yHIP6Ue5NOqQ==
X-Received: by 2002:a17:902:e852:b0:1a5:684:7fda with SMTP id t18-20020a170902e85200b001a506847fdamr15595169plg.59.1681126135587;
        Mon, 10 Apr 2023 04:28:55 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709027c8b00b0019c919bccf8sm7575052pll.86.2023.04.10.04.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:28:55 -0700 (PDT)
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
Subject: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring changes
Date:   Mon, 10 Apr 2023 20:28:45 +0900
Message-Id: <20230410112845.337212-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410112845.337212-1-mie@igel.co.jp>
References: <20230410112845.337212-1-mie@igel.co.jp>
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
 tools/include/linux/types.h   |  1 -
 tools/virtio/linux/compiler.h |  2 ++
 tools/virtio/linux/kernel.h   |  5 +----
 tools/virtio/linux/module.h   |  1 -
 tools/virtio/linux/uaccess.h  | 11 ++---------
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 051fdeaf2670..f1896b70a8e5 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -49,7 +49,6 @@ typedef __s8  s8;
 #endif
 
 #define __force
-#define __user
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
diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
index 9dfa96fea2b2..5cf39167d47a 100644
--- a/tools/virtio/linux/module.h
+++ b/tools/virtio/linux/module.h
@@ -4,4 +4,3 @@
 #define MODULE_LICENSE(__MODULE_LICENSE_value) \
 	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
 		__MODULE_LICENSE_value
-
diff --git a/tools/virtio/linux/uaccess.h b/tools/virtio/linux/uaccess.h
index 991dfb263998..cde2c344b260 100644
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
+	__chk_user_ptr(__pu_ptr);		\
 	WRITE_ONCE(*(__pu_ptr), x);				\
 	0;							\
 })
@@ -22,7 +17,7 @@ static inline void __chk_user_ptr(const volatile void *p, size_t size)
 #define get_user(x, ptr)					\
 ({								\
 	typeof(ptr) __pu_ptr = (ptr);				\
-	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
+	__chk_user_ptr(__pu_ptr);		\
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

