Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FAF6637E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjAJDn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAJDnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:43:25 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0D83C383
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:43:24 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso15068940pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 19:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8PYa+hzhyaXM2zhhaOaZAWlrRm4/hVUI6gNjdoah80=;
        b=kghkntqKiFozed/F99S8rMEQ2w+X51Asft+UjkjWufEwFUVSyDEdhFew7WdMPoZD2f
         PuxBnrMXcq+/cYKoZGfDQAcMpXkSM68ssJNJN55AWx0TzM7EtrmqrIOLVJ6Bti0n4zNT
         nnd4XR8sxymco9Z6R8Jy9eddT9y3fB0TacVPQKS50RIIiqG+tnW/pLlKK+0tfWGcuhkt
         1Eu8Swq6hXkVY2K3RtX9O3iw+UI8afbTsmO2Zg6YGF2r4m6H8Jh1cBhcKdVxL1KtnF2P
         w65YlBuRsvEllwO+ty6WVQMak+5A/ogF1tZPyAa6x9KoQWCKhdF+qA7R/zNIvFfkazqy
         hKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8PYa+hzhyaXM2zhhaOaZAWlrRm4/hVUI6gNjdoah80=;
        b=o0uvNUFI45Ycvhpjg6FxBR3IZ9paN1LwiIltd+lUTKUT/2sqi29S4NSObOdV2A6FmY
         zrq7X1gzIqXDmib7LHdhlYWdOkx+WhukywhtlaWS/uc3jCHaxhU7nBlpvSPKOlCW5pyX
         tjJ+ISeXlnAYwZ5Mk6II1mmHJPwyHrgqDn3/PEFYNWSsVkZDTNHaMTHVoMA4Sm7jC4+n
         TkaIg8HcqEasaQxEXyj/Eb9wVBWsQFZjKhOf1lKpQrsSEE6h1WPkKv3ISe+9RLXPri5h
         FRnz6ZrYB1J1vwxWUVrnQheh7Wb0mPnqpHUIrsj2Rpz8fSaHZjLZQGkL1H4lobOca+RR
         FGPw==
X-Gm-Message-State: AFqh2krlHY537aUP5Fq6ZtgQkIrAza8Bjr33cgb1SdW3RlyVYr3Xr4Pd
        61JhSLNJGgG2fi8OZFqcvpdukg==
X-Google-Smtp-Source: AMrXdXu+Su10aJVWtb/Qf0B1dAwQwFsN8PAiBIH5CnKXmuWX+zVgKVEQziXpn3khH29tk1wr1XjYTQ==
X-Received: by 2002:a17:90a:ab16:b0:226:6d:1a31 with SMTP id m22-20020a17090aab1600b00226006d1a31mr54801112pjq.49.1673322203637;
        Mon, 09 Jan 2023 19:43:23 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id j16-20020a63ec10000000b004b1b9e23790sm3331619pgh.92.2023.01.09.19.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 19:43:23 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Shunsuke Mie <mie@igel.co.jp>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2] tools/virtio: fix the vringh test for virtio ring changes
Date:   Tue, 10 Jan 2023 12:43:10 +0900
Message-Id: <20230110034310.779744-1-mie@igel.co.jp>
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

