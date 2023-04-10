Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979E26DC510
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjDJJYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDJJYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:24:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3779A4C3C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:24:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p8so4251410plk.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681118665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf5bveb+ux4A6UqkD/1l5g+psrLw8BnlaeaDh2PpD9g=;
        b=XWmBIi7gc16NVFGgnHOQOJSQ+Yvhu3RtDTX+FnMBMfo7p0o/V9vknY67SFTGmwOTEL
         gMHKvguortA40zG42HOvhcHI0zCdfX+ErKzqx06+NPmOJzy4cbc7hUE+zG51OhhT6s1g
         OXOK+80SUGN1J52TdCEXNTYo5wMdcirrw7eNv+cfNLqou5aPk/0mdks33Cj4oK/yJWur
         f37xX5H2gIagX7OHTpu42RmKRwKMCPiXC9Pi3DD+z8kwCBRJCqKsWnzNgmrV6T8zub+0
         k+dBUYcaCSxwUuWGJ5AN2MJuKHT40B4PN1eqIQLlmoVvA5Mx/AqxC/NUCS7+MmAvKGNb
         oqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681118665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bf5bveb+ux4A6UqkD/1l5g+psrLw8BnlaeaDh2PpD9g=;
        b=NGQ70EAS6m4hSXzFuGw4MNNnUx8+jIm4nCNexJNvPUI4hxEOfZtfZTlJTLYig/ihp9
         prZS6r3DKLLbTbbbFTy5dyxZyirwqDIhXBr4hdxTktEASoAo+39qpJMupcUlmo6FCMYf
         O9fuWXFTXU8VldVcNL1kl7pjYJlZFVhrTdwUyao8aT0chuIEREOmTLzdkKNhcJGLsdmb
         Qd+jDUtJ2wy9hMIMViq4kbm30kiXPWnG9qEzKWkMn4tg8K4ORAARPBz2JuTok+7SK9Cu
         M2Sn5nelYC7AGomcQ/StCPvoD3As6i0i9Vc47hZuHqNRX5MDQuP+XtrPre/zRBE2eruG
         DBag==
X-Gm-Message-State: AAQBX9cf5WCusYY3YNBT1qicGYBF8oASAVe7IXo3NSvHBEq/q50YcNqo
        EejgJBOuuJ4Pi8t0MFl5yC0jDQ==
X-Google-Smtp-Source: AKy350YfQaZVFEQLwC/r29BiDxuJxEj2g8fTOfEoogL7h4DUBMApctGUgORL7Ak29eFjlUtBLd6KNQ==
X-Received: by 2002:a17:90a:e7c2:b0:240:1014:a1b3 with SMTP id kb2-20020a17090ae7c200b002401014a1b3mr12349661pjb.35.1681118665654;
        Mon, 10 Apr 2023 02:24:25 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id k91-20020a17090a4ce400b00246b1b4a3ffsm1179217pjh.0.2023.04.10.02.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 02:24:25 -0700 (PDT)
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
Subject: [PATCH] tools/virtio: fix build caused by virtio_ring changes
Date:   Mon, 10 Apr 2023 18:24:19 +0900
Message-Id: <20230410092419.302932-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
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

Fix the build dependency for virtio_test. virtio_ring requires
container_of_const() and struce device.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 tools/include/linux/container_of.h | 36 ++++++++++++++++++++++++++++++
 tools/virtio/linux/compiler.h      |  3 +++
 tools/virtio/linux/kernel.h        |  5 +----
 tools/virtio/linux/module.h        |  1 +
 4 files changed, 41 insertions(+), 4 deletions(-)
 create mode 100644 tools/include/linux/container_of.h

diff --git a/tools/include/linux/container_of.h b/tools/include/linux/container_of.h
new file mode 100644
index 000000000000..06e293b7cfda
--- /dev/null
+++ b/tools/include/linux/container_of.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CONTAINER_OF_H
+#define _LINUX_CONTAINER_OF_H
+
+#include <linux/build_bug.h>
+#include <linux/stddef.h>
+
+/**
+ * container_of - cast a member of a structure out to the containing structure
+ * @ptr:	the pointer to the member.
+ * @type:	the type of the container struct this is embedded in.
+ * @member:	the name of the member within the struct.
+ *
+ * WARNING: any const qualifier of @ptr is lost.
+ */
+#define container_of(ptr, type, member) ({				\
+	void *__mptr = (void *)(ptr);					\
+	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
+		      __same_type(*(ptr), void),			\
+		      "pointer type mismatch in container_of()");	\
+	((type *)(__mptr - offsetof(type, member))); })
+
+/**
+ * container_of_const - cast a member of a structure out to the containing
+ *			structure and preserve the const-ness of the pointer
+ * @ptr:		the pointer to the member
+ * @type:		the type of the container struct this is embedded in.
+ * @member:		the name of the member within the struct.
+ */
+#define container_of_const(ptr, type, member)				\
+	_Generic(ptr,							\
+		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
+		default: ((type *)container_of(ptr, type, member))	\
+	)
+
+#endif	/* _LINUX_CONTAINER_OF_H */
diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 2c51bccb97bb..ac27b3ea6e67 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -8,4 +8,7 @@
 #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
 
 #define __aligned(x) __attribute((__aligned__(x)))
+
+#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
+
 #endif
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 8b877167933d..3cd20cb92649 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -10,6 +10,7 @@
 #include <stdarg.h>
 
 #include <linux/compiler.h>
+#include <linux/container_of.h>
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
index 9dfa96fea2b2..e2e791dbd104 100644
--- a/tools/virtio/linux/module.h
+++ b/tools/virtio/linux/module.h
@@ -5,3 +5,4 @@
 	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
 		__MODULE_LICENSE_value
 
+struct device;
-- 
2.25.1

