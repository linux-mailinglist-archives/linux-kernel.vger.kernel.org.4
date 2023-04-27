Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715866EFF76
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbjD0DEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjD0DD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:03:59 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661CA35A4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:03:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5286344e1d4so3340939a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682564635; x=1685156635;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A14gXOIzQ8LsUnpCV+kWBAJ4ogPDSbb3KQJ7ZlYIxs=;
        b=CGxwL2vk3j0Yl7BI3W9SYPNrRmdSJVZdUm4BiiDFB+Ar6LcG0PXNyNuBzpYQyaxTse
         XLXQdoVu8xdTnD1fad777iUEp5YoLGOoyTII71EtG/J9igUkFPj0ke6NNWW7gGEcxNKk
         2F34Ua6ky7fmEE2GSc9QNDRkjbo99IK+Szn5r03o8nJiUEHNoZPtDruWmgdQ0FjLb44E
         jdemBlMJ+EYcgbdFl8in/JMoBsKdirR2hhczuH4Bq8or+GOvtBosIuoOd8X7chVIyk9O
         B5yRHTYy4TVPMXmdY8WIfVd/o96m31vJ2eC5gmO9QHkdDf7yYAEgRg2Oed/c0u67mZ+D
         qnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682564635; x=1685156635;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A14gXOIzQ8LsUnpCV+kWBAJ4ogPDSbb3KQJ7ZlYIxs=;
        b=j+dbX9ykNpzqO98QOE64+dTrriEvZ/syxUy5uWkwrjjZSsLUHsu6geky5jMuNgkQ2V
         g8156SxL+agt2ivbbYJz4CkOF2etxIQCNQI4wWlxsOEeSeTP3ImURNO1MTBQr7g2JHoq
         81fnVxee0SKUthkqBvHLxV0pO/tWFzYsuIez3nfqRrUVrq9dLZkgV/oThGTSoNvQl+ap
         xyrzlj5mLOYpjZWVfyUTotGAbCKoBtyRMt3T77JgEXK9b2S3yHTb29qC6lmxsw7jY8Wj
         B1yzy0VihHPey8mjTchF2IPN9KgQbUlKR26b7kZnac8ERKKY9W5HgKoDYnfhUrW/qAYy
         eZMA==
X-Gm-Message-State: AC+VfDy7iqiMnoxwFwxwuLYaw3SAU1gLu5w9NCaKSIA8nD+mjcXlv3S+
        TI+BqdmO477i1+qf2/xUbs1H4MzFurY=
X-Google-Smtp-Source: ACHHUZ5NkADkq+bFRhb0WRAgEgeVe3ol89Kb4ts/o7en2zRirP5e/NpezlHp2j9+TAoMVPZxAHratg==
X-Received: by 2002:a17:90b:313:b0:247:2ff9:1cff with SMTP id ay19-20020a17090b031300b002472ff91cffmr306271pjb.25.1682564635110;
        Wed, 26 Apr 2023 20:03:55 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id f24-20020a63f118000000b0051b7d83ff22sm10380506pgi.80.2023.04.26.20.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 20:03:54 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Subject: [PATCH] erofs: do not build pcpubuf.c for uncompressed data
Date:   Thu, 27 Apr 2023 11:03:46 +0800
Message-Id: <20230427030346.5624-1-zbestahu@gmail.com>
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
---
 fs/erofs/Makefile   |  4 ++--
 fs/erofs/internal.h | 12 +++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

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
index af0431a40647..65dbfa76f854 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -472,11 +472,6 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
 	return NULL;
 }
 
-void *erofs_get_pcpubuf(unsigned int requiredpages);
-void erofs_put_pcpubuf(void *ptr);
-int erofs_pcpubuf_growsize(unsigned int nrpages);
-void __init erofs_pcpubuf_init(void);
-void erofs_pcpubuf_exit(void);
 
 int erofs_register_sysfs(struct super_block *sb);
 void erofs_unregister_sysfs(struct super_block *sb);
@@ -512,6 +507,11 @@ int z_erofs_load_lz4_config(struct super_block *sb,
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
@@ -529,6 +529,8 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
 	}
 	return 0;
 }
+static inline void erofs_pcpubuf_init(void) {}
+static inline void erofs_pcpubuf_exit(void) {}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
-- 
2.17.1

