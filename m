Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53E57029BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjEOJ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjEOJ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:58:08 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2303DDF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:58:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab05018381so115818055ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684144684; x=1686736684;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OleVJpT/tSp3JbThvpJR/uVqE8ywZaeyDX9kv6FUcs=;
        b=aDFvqi3Kc+2cTVR7CAW9p2K/+peYT7xMX+X9CD4q3eRs668XvbccLxuU7S3/6ovlT4
         S0qFH8h+qhxocnusiYEeVrcMaWFF+GTJPiOFWz9SN9MoNSntz4EmnAErcip+aEm8Hx0j
         +s87DVDlwWJPZ1ryzCFM0DCwdkVQShRUZYVsfwNP4jIfwhq5nlFP9SBlQ7tY99FJTqrA
         ++Bh5uPOpcs/1uGWpcc+07zYrxC0+VLi+V4FJD7QwIGSIKvQoRpM5fatTr3NGWQ5ZvrO
         5I4xHCt5XJk/cG2UZoa5ueEba0lI/QUpfuZseVlRx92fHqEikc8droMeA28HHeHsciIH
         uy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684144684; x=1686736684;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OleVJpT/tSp3JbThvpJR/uVqE8ywZaeyDX9kv6FUcs=;
        b=JiuLIFLupv58YZtOlfDAQ5R/QZwEbi+3Vt0KW6kNJcN8aLVr2GHGRztsDT04d0Eezq
         Mvp66neCpEJxzEr/08USRU8ASI7BqG6gCBWkLLVymPWcjr2whuWaUQo1tJKudRniklJ3
         Amq4BXlVPIKyO3MLTGQJYuUzNrOjW5fmmOYpkn6OtMFabwtlRwxf95lOlxidxua2ucD1
         C4/kCE64DyzF1lWWSWJnBqqv9Yueyrc483zcRb+5HZI9AomeeYuZ7d1MpbLG3mhFzPAP
         wQAJPTohizesO+vgE/idw2oryVhYEtWVMKZqwzYITB47jKU+U2o2RLigSoODwC0hIOrJ
         f3eg==
X-Gm-Message-State: AC+VfDxzvMuW6RtzobQleThN8CcUkC3sPzPYTzTSdlsveEegJU+Iy4iY
        boXRrlU+YhYao/HKqreuPBDH1VoJEZY=
X-Google-Smtp-Source: ACHHUZ6IO/PNayfQxugzW94ZD++QyqwVhs08+86gK5utF9Jhy0YlrUm5kBy/xk0g73G/xx3yPFV9Zg==
X-Received: by 2002:a17:902:e890:b0:1ad:d500:19ce with SMTP id w16-20020a170902e89000b001add50019cemr16115537plg.41.1684144684472;
        Mon, 15 May 2023 02:58:04 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id bf12-20020a170902b90c00b001a96d295f15sm13031127plb.284.2023.05.15.02.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:58:04 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP is off
Date:   Mon, 15 May 2023 17:57:58 +0800
Message-Id: <20230515095758.10391-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

The function of pcpubuf.c is just for low-latency decompression
algorithms (e.g. lz4).

Signed-off-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Makefile   |  4 ++--
 fs/erofs/internal.h | 13 +++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 99bbc597a3e9..a3a98fc3e481 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index af0431a40647..1e39c03357d1 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -472,12 +472,6 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
 	return NULL;
 }
 
-void *erofs_get_pcpubuf(unsigned int requiredpages);
-void erofs_put_pcpubuf(void *ptr);
-int erofs_pcpubuf_growsize(unsigned int nrpages);
-void __init erofs_pcpubuf_init(void);
-void erofs_pcpubuf_exit(void);
-
 int erofs_register_sysfs(struct super_block *sb);
 void erofs_unregister_sysfs(struct super_block *sb);
 int __init erofs_init_sysfs(void);
@@ -512,6 +506,11 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct z_erofs_lz4_cfgs *lz4, int len);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
+void *erofs_get_pcpubuf(unsigned int requiredpages);
+void erofs_put_pcpubuf(void *ptr);
+int erofs_pcpubuf_growsize(unsigned int nrpages);
+void __init erofs_pcpubuf_init(void);
+void erofs_pcpubuf_exit(void);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -529,6 +528,8 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
 	}
 	return 0;
 }
+static inline void erofs_pcpubuf_init(void) {}
+static inline void erofs_pcpubuf_exit(void) {}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
-- 
2.17.1

