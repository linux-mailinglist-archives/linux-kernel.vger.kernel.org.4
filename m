Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC0071733B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjEaBlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjEaBlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574AEBE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2A906347B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECC1C433D2;
        Wed, 31 May 2023 01:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685497261;
        bh=Ka/BcrgbTNTVs7DWpgzzzFck8oroxpb1zdPJdwMwR6c=;
        h=From:To:Cc:Subject:Date:From;
        b=bcqEZB+G6EfPu+bDyb3s+T8DQ+2LUBiFkBpvbtJLPyKzm6uUoLxvtd8SpUbs0sbfH
         WDU6imq8USvxwo0QqHMBphHA5MyyqYSQXcPM96fzyCs+S2Pd+MV/d8tmvKGCwQR3Dh
         uXHeywokn+pq3V9SaIbMkJMeRhab3AT97sP86uOzw6IqW8zemKPfWtAGwIrAEJ7k4E
         i7dmNeHHTWmA6TYdy86nzGaa3wVHLFaJYwiyunHrR+Fo4PdOrKEKBeILJ6cTg7xw/v
         ZZSoV8rkptEhrGb9j2uZIYBRYll9FS9yIwZ/pcfNIGvz0p5Ia5Qb5aG+8W39BUTKmy
         ZU9JZMKND1zRA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: do more sanity check on inode
Date:   Wed, 31 May 2023 09:40:55 +0800
Message-Id: <20230531014055.3904072-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several issues in sanity_check_inode():
- The code looks not clean, it checks extra_attr related condition
dispersively.
- It missed to check i_extra_isize w/ lower boundary
- It missed to check feature dependency: prjquota, inode_chksum,
inode_crtime, compression features rely on extra_attr feature.
- It's not necessary to check i_extra_isize due to it will only
be assigned to non-zero value if f2fs_has_extra_attr() is true
in do_read_inode().

Fix them all in this patch.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- describe current problem in commit message
 fs/f2fs/f2fs.h  |   2 +
 fs/f2fs/inode.c | 108 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 72 insertions(+), 38 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7e406da8b4b3..619ad49993ce 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3413,6 +3413,8 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
 
+#define F2FS_MIN_EXTRA_ATTR_SIZE		(sizeof(__le32))
+
 #define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
 	(offsetof(struct f2fs_inode, i_extra_end) -	\
 	offsetof(struct f2fs_inode, i_extra_isize))	\
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 0a1748444329..1e49009831c1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -300,41 +300,79 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
-	if (f2fs_sb_has_flexible_inline_xattr(sbi)
-			&& !f2fs_has_extra_attr(inode)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: corrupted inode ino=%lx, run fsck to fix.",
-			  __func__, inode->i_ino);
-		return false;
-	}
-
-	if (f2fs_has_extra_attr(inode) &&
-			!f2fs_sb_has_extra_attr(sbi)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
-			  __func__, inode->i_ino);
-		return false;
-	}
-
-	if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
+	if (f2fs_has_extra_attr(inode)) {
+		if (!f2fs_sb_has_extra_attr(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
+				  __func__, inode->i_ino);
+			return false;
+		}
+		if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
+			fi->i_extra_isize < F2FS_MIN_EXTRA_ATTR_SIZE ||
 			fi->i_extra_isize % sizeof(__le32)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_extra_isize: %d, max: %zu",
-			  __func__, inode->i_ino, fi->i_extra_isize,
-			  F2FS_TOTAL_EXTRA_ATTR_SIZE);
-		return false;
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_extra_isize: %d, max: %zu",
+				  __func__, inode->i_ino, fi->i_extra_isize,
+				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
+			return false;
+		}
+		if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
+			f2fs_has_inline_xattr(inode) &&
+			(!fi->i_inline_xattr_size ||
+			fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %zu",
+				  __func__, inode->i_ino, fi->i_inline_xattr_size,
+				  MAX_INLINE_XATTR_SIZE);
+			return false;
+		}
+		if (f2fs_sb_has_compression(sbi) &&
+			fi->i_flags & F2FS_COMPR_FL &&
+			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
+						i_compress_flag)) {
+			if (!sanity_check_compress_inode(inode, ri))
+				return false;
+		}
+	} else {
+		if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, run fsck to fix.",
+				  __func__, inode->i_ino);
+			return false;
+		}
 	}
 
-	if (f2fs_has_extra_attr(inode) &&
-		f2fs_sb_has_flexible_inline_xattr(sbi) &&
-		f2fs_has_inline_xattr(inode) &&
-		(!fi->i_inline_xattr_size ||
-		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %zu",
-			  __func__, inode->i_ino, fi->i_inline_xattr_size,
-			  MAX_INLINE_XATTR_SIZE);
-		return false;
+	if (!f2fs_sb_has_extra_attr(sbi)) {
+		if (f2fs_sb_has_project_quota(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+				  __func__, inode->i_ino, F2FS_FEATURE_PRJQUOTA);
+			return false;
+		}
+		if (f2fs_sb_has_inode_chksum(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CHKSUM);
+			return false;
+		}
+		if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+				  __func__, inode->i_ino, F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
+			return false;
+		}
+		if (f2fs_sb_has_inode_crtime(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CRTIME);
+			return false;
+		}
+		if (f2fs_sb_has_compression(sbi)) {
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+				  __func__, inode->i_ino, F2FS_FEATURE_COMPRESSION);
+			return false;
+		}
 	}
 
 	if (f2fs_sanity_check_inline_data(inode)) {
@@ -358,12 +396,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
-	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
-			fi->i_flags & F2FS_COMPR_FL &&
-			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
-						i_compress_flag))
-		return sanity_check_compress_inode(inode, ri);
-
 	return true;
 }
 
-- 
2.40.1

