Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252606DAEB7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbjDGORd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbjDGORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:17:22 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA66EB8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:17:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfX7DF5_1680877036;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfX7DF5_1680877036)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:17:16 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] erofs: add helpers to load long xattr name prefixes
Date:   Fri,  7 Apr 2023 22:17:08 +0800
Message-Id: <20230407141710.113882-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long xattr name prefixes will be scanned upon mounting and the in-memory
long xattr name prefix array will be initialized accordingly.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h | 10 ++++++++
 fs/erofs/super.c    |  6 ++---
 fs/erofs/xattr.c    | 56 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/xattr.h    |  4 ++++
 4 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8b5168f94dd2..5a9c19654b19 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -117,6 +117,11 @@ struct erofs_fscache {
 	char *name;
 };
 
+struct erofs_xattr_prefix_item {
+	struct erofs_xattr_long_prefix *prefix;
+	u8 infix_len;
+};
+
 struct erofs_sb_info {
 	struct erofs_mount_opts opt;	/* options */
 #ifdef CONFIG_EROFS_FS_ZIP
@@ -145,6 +150,9 @@ struct erofs_sb_info {
 	u32 meta_blkaddr;
 #ifdef CONFIG_EROFS_FS_XATTR
 	u32 xattr_blkaddr;
+	u32 xattr_prefix_start;
+	u8 xattr_prefix_count;
+	struct erofs_xattr_prefix_item *xattr_prefixes;
 #endif
 	u16 device_id_mask;	/* valid bits of device id to be used */
 
@@ -440,6 +448,8 @@ extern const struct iomap_ops z_erofs_iomap_report_ops;
 #define EROFS_REG_COOKIE_SHARE		0x0001
 #define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
 
+void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
+			  erofs_off_t *offset, int *lengthp);
 void erofs_unmap_metabuf(struct erofs_buf *buf);
 void erofs_put_metabuf(struct erofs_buf *buf);
 void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 8f2f8433db61..bf396e0c243a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -126,10 +126,9 @@ static bool check_layout_compatibility(struct super_block *sb,
 	return true;
 }
 
-#ifdef CONFIG_EROFS_FS_ZIP
 /* read variable-sized metadata, offset will be aligned by 4-byte */
-static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
-				 erofs_off_t *offset, int *lengthp)
+void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
+			  erofs_off_t *offset, int *lengthp)
 {
 	u8 *buffer, *ptr;
 	int len, i, cnt;
@@ -162,6 +161,7 @@ static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 	return buffer;
 }
 
+#ifdef CONFIG_EROFS_FS_ZIP
 static int erofs_load_compr_cfgs(struct super_block *sb,
 				 struct erofs_super_block *dsb)
 {
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index d76b74ece2e5..684571e83a2c 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -610,6 +610,62 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	return ret;
 }
 
+void erofs_xattr_prefixes_cleanup(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	int i;
+
+	if (sbi->xattr_prefixes) {
+		for (i = 0; i < sbi->xattr_prefix_count; i++)
+			kfree(sbi->xattr_prefixes[i].prefix);
+		kfree(sbi->xattr_prefixes);
+		sbi->xattr_prefixes = NULL;
+	}
+}
+
+int erofs_xattr_prefixes_init(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	erofs_off_t pos = (erofs_off_t)sbi->xattr_prefix_start << 2;
+	struct erofs_xattr_prefix_item *pfs;
+	int ret = 0, i, len;
+
+	if (!sbi->xattr_prefix_count)
+		return 0;
+
+	pfs = kzalloc(sbi->xattr_prefix_count * sizeof(*pfs), GFP_KERNEL);
+	if (!pfs)
+		return -ENOMEM;
+
+	if (erofs_sb_has_fragments(sbi))
+		buf.inode = sbi->packed_inode;
+	else
+		erofs_init_metabuf(&buf, sb);
+
+	for (i = 0; i < sbi->xattr_prefix_count; i++) {
+		void *ptr = erofs_read_metadata(sb, &buf, &pos, &len);
+
+		if (IS_ERR(ptr)) {
+			ret = PTR_ERR(ptr);
+			break;
+		} else if (len < sizeof(*pfs->prefix) ||
+			   len > EROFS_NAME_LEN + sizeof(*pfs->prefix)) {
+			kfree(ptr);
+			ret = -EFSCORRUPTED;
+			break;
+		}
+		pfs[i].prefix = ptr;
+		pfs[i].infix_len = len - sizeof(struct erofs_xattr_long_prefix);
+	}
+
+	erofs_put_metabuf(&buf);
+	sbi->xattr_prefixes = pfs;
+	if (ret)
+		erofs_xattr_prefixes_cleanup(sb);
+	return ret;
+}
+
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
 struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 {
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index a65158cba14f..e1265351aedd 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -40,9 +40,13 @@ static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
 
 extern const struct xattr_handler *erofs_xattr_handlers[];
 
+int erofs_xattr_prefixes_init(struct super_block *sb);
+void erofs_xattr_prefixes_cleanup(struct super_block *sb);
 int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
 ssize_t erofs_listxattr(struct dentry *, char *, size_t);
 #else
+static inline int erofs_xattr_prefixes_init(struct super_block *sb) { return 0; }
+static inline void erofs_xattr_prefixes_cleanup(struct super_block *sb) {}
 static inline int erofs_getxattr(struct inode *inode, int index,
 				 const char *name, void *buffer,
 				 size_t buffer_size)
-- 
2.19.1.6.gb485710b

