Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291DA708DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjESCeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjESCd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:33:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA7AE4D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 19:33:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a516fb6523so26355235ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 19:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684463637; x=1687055637;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+KLO8kfhh/ehAJcoZFZyic4XaS3xMS9Q6emroTwVE0=;
        b=cthiU+9IQNQti2B6zpcXJctFQENHs0De8M6OVjXZWRjvv89ObB19AZcSD1hVDI6bIq
         tp47XOiQ5hLPTIcKTmJBD+YtJC4x/SCCq4RJlX2Z65RpKbueEotZjTmRO0A9Y4zgtTLP
         oBvuUSZrtkTYzDp7Ov2jI5d3bZO+MdXODjgbqscpmRjZZcRbtlu5GYXS6bt/yj8xw6Tk
         Zw5Ny5cp0YWLiN8TRnDjD6ORYVQ1Dntv33LzcFKislzRHhwb4b3Laet2ZksVkc1+LteY
         TDVAV6SHdjRkvkMM62Tb/WfktPGJijJ/00pMnAZTEJSeJZJTw12rt3f/iJjl3IqHKTJw
         EiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684463637; x=1687055637;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+KLO8kfhh/ehAJcoZFZyic4XaS3xMS9Q6emroTwVE0=;
        b=jj9khY7lfHlEk0ya/5Y9IznzCVwczbSRXRrq+4pYCtVyixXMDD1VZUZSF2ZrAPEx7S
         VatX2G1JjK4VGLhpKtm4yw4NM2QhgX2L0D9PBl5U5avwB1YmxFQcHDR9P2yTZaTlzFN/
         t9SPH++6d+gaYnQuo/ycZynY6vyUbkQKKbSLAuWqSTct9ZKWef6+w6HLHm+H3lp7A8/D
         vrU1M1Ze+dZsBoq4xr+Jjv8/5DBklJ+JwyXrQulv+JX2dSpq9IR+MAzBdQS5S0BQibhz
         d9r6odoqxLSMFMdOOzWM9MO2lOc26Hk3BCK0xxuH9acVG58myso9l/nSVxdZSBhqqCd8
         a3gQ==
X-Gm-Message-State: AC+VfDxKQF2GtMRja8MzwcySyfTSJSKSR6lL/biglHdNRzqy4fngC6Fk
        d1webbzW35LUwo4idx0l3Hoewm0k26I=
X-Google-Smtp-Source: ACHHUZ6XisjMlgkxAik7qc3jmnRJ2+i1rCJ9pNHbYp/N+aeCFg8vUvXVuKM/KOZCM1bxHdyI7J9UyA==
X-Received: by 2002:a17:902:ecc6:b0:1a6:9f9b:1327 with SMTP id a6-20020a170902ecc600b001a69f9b1327mr1343417plh.45.1684463637189;
        Thu, 18 May 2023 19:33:57 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b0019f3cc463absm2202645plg.0.2023.05.18.19.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 19:33:56 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: [PATCH] erofs: move erofs_{allocpage,release_pages}() under CONFIG_EROFS_FS_ZIP
Date:   Fri, 19 May 2023 10:33:13 +0800
Message-Id: <20230519023313.24892-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

These two functions are only used for compression side now. Also,
eliminate unused pagevec.h inclusion.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/Makefile | 4 ++--
 fs/erofs/utils.c  | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index a3a98fc3e481..1b1c3e3127cd 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o sysfs.o
+erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o utils.o pcpubuf.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 46627cb69abe..72ba7daba33c 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -4,7 +4,6 @@
  *             https://www.huawei.com/
  */
 #include "internal.h"
-#include <linux/pagevec.h>
 
 struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
 {
@@ -29,7 +28,6 @@ void erofs_release_pages(struct page **pagepool)
 	}
 }
 
-#ifdef CONFIG_EROFS_FS_ZIP
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
 
@@ -289,4 +287,3 @@ void erofs_exit_shrinker(void)
 {
 	unregister_shrinker(&erofs_shrinker_info);
 }
-#endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.17.1

