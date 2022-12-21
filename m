Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDDF652EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiLUJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiLUJgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:36:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64E5183AB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:35:59 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so1617765pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8PYa+hzhyaXM2zhhaOaZAWlrRm4/hVUI6gNjdoah80=;
        b=eRYC09CENai5kj+0qBQ106ipvQvKCerF6/GbIaNv8EXhnYN+Wj8EBVeLL6Tc0/NZ+C
         INQJx2Qelsp8JaqgYdzpMCxMa3Myq6H9zCDxZbDDO/qW5k/hl6Ea1uG3P9cuxIQ4Q723
         I/9z0t5l9eIupPhGLfr+6kkTJs7l7mEZPAgvm4ZKz/mmcfjxi0n6r9PQ5eaQCit7xMVt
         5f1x8kIqFRuJFTjIEQ/SXU2SI+GvRENHyaGdSjthUsCuQVELOzf5m6TTLPPL37OvPhF0
         xbK9tSDxhCqddO2ifM0kZjtgZwczEuH0wr/dPdLeQN+p+Tkvdq3g5YmeyB+51rpDxp4K
         mrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8PYa+hzhyaXM2zhhaOaZAWlrRm4/hVUI6gNjdoah80=;
        b=q31Jf1v9IZHShucVTbACCBc2PAVAoOZ+xp0q1ARr1e+oLD06/h5ppULOL9gFL7LNUB
         +PoCHcjWqoAG0PazOwYklAb+l3LhtAJ7eYxFCUMSvKhSB3pN5fJwhlt62e8EZ3YwjxY3
         SySdeBFvKUbyYLm7QWtlXZ9bLpsDcqHzaM9IHtUPWxZVIycvKPVMNVHUR5SkRFxj3pdm
         U5noZHFvHktW6FQMviP/H9K8R/yjdHY1ZEO6VFC6dgENBpXd4vhY+exctKSfzJMYL+r8
         yGvZZifpczcEgz3CMvar/qBv4qMWeXe+Ot59i2WHsSVajE018tnNhPRtBjb/hjAa3nA8
         thdA==
X-Gm-Message-State: AFqh2kqaOIbZwudL20aCs1V/7r5ufkJfazIHlYhwTYLm8TKJmLq+66Kd
        rd77NNYa66V49Eqno8ynWTS7vTlTaP092eo01s6kOQ==
X-Google-Smtp-Source: AMrXdXvqydzcYWmVjFcDwSMm4Nb/SxfO5sEN1funyh2L6Cp4rTz2813agOrgX3sm6L7S81Pvc+RZhw==
X-Received: by 2002:a05:6a21:e302:b0:a3:d6:8795 with SMTP id cb2-20020a056a21e30200b000a300d68795mr2068561pzc.17.1671615359286;
        Wed, 21 Dec 2022 01:35:59 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id t76-20020a63784f000000b0046fe244ed6esm9640114pgc.23.2022.12.21.01.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 01:35:58 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Shunsuke Mie <mie@igel.co.jp>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2] tools/virtio: fix the vringh test for virtio ring changes
Date:   Wed, 21 Dec 2022 18:35:50 +0900
Message-Id: <20221221093550.3308698-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the build caused by missing kmsan_handle_dma() and is_power_of_2() that
are used in drivers/virtio/virtio_ring.c.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes in v2:
* Remove a file, tools/virtio/linux/log2.h
* Correct a include guard of tools/virtio/linux/bug.h
* Move BUILD_BUG_ON() definition into tools/virtio/linux/build_bug.h
---
---
 tools/virtio/linux/bug.h         |  8 +++-----
 tools/virtio/linux/build_bug.h   |  7 +++++++
 tools/virtio/linux/cpumask.h     |  7 +++++++
 tools/virtio/linux/gfp.h         |  7 +++++++
 tools/virtio/linux/kernel.h      |  1 +
 tools/virtio/linux/kmsan.h       | 12 ++++++++++++
 tools/virtio/linux/scatterlist.h |  1 +
 tools/virtio/linux/topology.h    |  7 +++++++
 8 files changed, 45 insertions(+), 5 deletions(-)
 create mode 100644 tools/virtio/linux/build_bug.h
 create mode 100644 tools/virtio/linux/cpumask.h
 create mode 100644 tools/virtio/linux/gfp.h
 create mode 100644 tools/virtio/linux/kmsan.h
 create mode 100644 tools/virtio/linux/topology.h

diff --git a/tools/virtio/linux/bug.h b/tools/virtio/linux/bug.h
index 813baf13f62a..51a919083d9b 100644
--- a/tools/virtio/linux/bug.h
+++ b/tools/virtio/linux/bug.h
@@ -1,13 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef BUG_H
-#define BUG_H
+#ifndef _LINUX_BUG_H
+#define _LINUX_BUG_H
 
 #include <asm/bug.h>
 
 #define BUG_ON(__BUG_ON_cond) assert(!(__BUG_ON_cond))
 
-#define BUILD_BUG_ON(x)
-
 #define BUG() abort()
 
-#endif /* BUG_H */
+#endif /* _LINUX_BUG_H */
diff --git a/tools/virtio/linux/build_bug.h b/tools/virtio/linux/build_bug.h
new file mode 100644
index 000000000000..cdbb75e28a60
--- /dev/null
+++ b/tools/virtio/linux/build_bug.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_BUILD_BUG_H
+#define _LINUX_BUILD_BUG_H
+
+#define BUILD_BUG_ON(x)
+
+#endif	/* _LINUX_BUILD_BUG_H */
diff --git a/tools/virtio/linux/cpumask.h b/tools/virtio/linux/cpumask.h
new file mode 100644
index 000000000000..307da69d6b26
--- /dev/null
+++ b/tools/virtio/linux/cpumask.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CPUMASK_H
+#define _LINUX_CPUMASK_H
+
+#include <linux/kernel.h>
+
+#endif /* _LINUX_CPUMASK_H */
diff --git a/tools/virtio/linux/gfp.h b/tools/virtio/linux/gfp.h
new file mode 100644
index 000000000000..43d146f236f1
--- /dev/null
+++ b/tools/virtio/linux/gfp.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_GFP_H
+#define __LINUX_GFP_H
+
+#include <linux/topology.h>
+
+#endif
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 21593bf97755..8b877167933d 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -10,6 +10,7 @@
 #include <stdarg.h>
 
 #include <linux/compiler.h>
+#include <linux/log2.h>
 #include <linux/types.h>
 #include <linux/overflow.h>
 #include <linux/list.h>
diff --git a/tools/virtio/linux/kmsan.h b/tools/virtio/linux/kmsan.h
new file mode 100644
index 000000000000..272b5aa285d5
--- /dev/null
+++ b/tools/virtio/linux/kmsan.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KMSAN_H
+#define _LINUX_KMSAN_H
+
+#include <linux/gfp.h>
+
+inline void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
+			     enum dma_data_direction dir)
+{
+}
+
+#endif /* _LINUX_KMSAN_H */
diff --git a/tools/virtio/linux/scatterlist.h b/tools/virtio/linux/scatterlist.h
index 369ee308b668..74d9e1825748 100644
--- a/tools/virtio/linux/scatterlist.h
+++ b/tools/virtio/linux/scatterlist.h
@@ -2,6 +2,7 @@
 #ifndef SCATTERLIST_H
 #define SCATTERLIST_H
 #include <linux/kernel.h>
+#include <linux/bug.h>
 
 struct scatterlist {
 	unsigned long	page_link;
diff --git a/tools/virtio/linux/topology.h b/tools/virtio/linux/topology.h
new file mode 100644
index 000000000000..910794afb993
--- /dev/null
+++ b/tools/virtio/linux/topology.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TOPOLOGY_H
+#define _LINUX_TOPOLOGY_H
+
+#include <linux/cpumask.h>
+
+#endif /* _LINUX_TOPOLOGY_H */
-- 
2.25.1

