Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF8D652D88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiLUHze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiLUHzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:55:21 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E9C21805
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:55:12 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d15so14767499pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p56YFYadKwiAgc0MnsqbNwUdZHZ1PCgYXvpEaau8qXI=;
        b=smEr4XpRA9enckwDuKr/UQkAYxUCFQt7+Rn6jW3q7sqnpU9OZGETueVipO8M9Jnuyl
         4CjOpen7LdavGhYBUgH6MzvV2BM9duC9oC49RWeYeOL0IBUKFzzGefRtNTcdxFSJkdxa
         wIaTILxbOLa4sqcMpJR6wq1A2gZve8FNp6lwRJPFlCKUhmVrpvT4GBljDpG26TGAqfzU
         MdQe71g/NSUo80iEiQ996CPCw4Av3nLYhDi3+0JQHjbZBt9/CoJ6ntoxPbz59wnYCXKX
         jFs7UOeLerDI1aWlMQBcdgD2dq2RqIp+sdowTjxp186GZdCe0qxQGKPbXcE9kGJAWq+T
         lTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p56YFYadKwiAgc0MnsqbNwUdZHZ1PCgYXvpEaau8qXI=;
        b=wf4oa9miKGpleQURsweprpWtVntg6Cl68+PQlqNzd1WL4i8WE5k/b9Ki/WQGFNADy+
         sr0nrY6lJ0pXY5i5qRilnkRdPR17uAfIxF4iB/jcRJ/jf10yTGdCzoZavZoLfKL55ghu
         LUR+5XOwEZWoivhGqw1Vh7R44gE5Qpzb2Mgi3FUXBusuqVKWZLvBoGbwGVatbggGvK4g
         uAMwfX5dTfk4D0EayPabrxKz7b0BLuCww1JMTEKLcMLv4okZSLU0U6Np8uIRZKAsK+pZ
         LUxg/3cG23q3wchqp7Tyrie2jy2C+e6yF+nCTjzE/HheyVE8kOeLmF7LS4YAWJlJAfRn
         hrEg==
X-Gm-Message-State: AFqh2kqwMGvSiLQaVPA8OzkTHDrkvv0WX96mrAI+ValZz4rT/yuaupyc
        zsiC0+Lr51/BwNwJYlBDdxB/7O0bbvozYJnHh6w=
X-Google-Smtp-Source: AMrXdXvt0k1foCfjfBOsRej5TqBsl7rwOVEWd88cgD8kMbNG6mdUJI/iQC+GGHNdWiSjJejRYcCxCg==
X-Received: by 2002:a17:90a:7d0f:b0:219:7f29:3152 with SMTP id g15-20020a17090a7d0f00b002197f293152mr1098129pjl.39.1671609311796;
        Tue, 20 Dec 2022 23:55:11 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id ne1-20020a17090b374100b0020c899b11f1sm771779pjb.23.2022.12.20.23.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 23:55:11 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Shunsuke Mie <mie@igel.co.jp>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] tools/virtio: fix the vringh test for virtio ring changes
Date:   Wed, 21 Dec 2022 16:55:06 +0900
Message-Id: <20221221075506.3291148-1-mie@igel.co.jp>
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
 tools/virtio/linux/cpumask.h  |  7 +++++++
 tools/virtio/linux/gfp.h      |  7 +++++++
 tools/virtio/linux/kernel.h   |  1 +
 tools/virtio/linux/kmsan.h    | 12 ++++++++++++
 tools/virtio/linux/log2.h     | 11 +++++++++++
 tools/virtio/linux/topology.h |  7 +++++++
 6 files changed, 45 insertions(+)
 create mode 100644 tools/virtio/linux/cpumask.h
 create mode 100644 tools/virtio/linux/gfp.h
 create mode 100644 tools/virtio/linux/kmsan.h
 create mode 100644 tools/virtio/linux/log2.h
 create mode 100644 tools/virtio/linux/topology.h

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
diff --git a/tools/virtio/linux/log2.h b/tools/virtio/linux/log2.h
new file mode 100644
index 000000000000..aa67bb21d8e2
--- /dev/null
+++ b/tools/virtio/linux/log2.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_LOG2_H
+#define _LINUX_LOG2_H
+
+inline bool is_power_of_2(unsigned long n)
+{
+	return true;
+}
+
+#endif /* _LINUX_LOG2_H */
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

