Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC557147E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjE2K2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjE2K2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:28:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753D1C4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10DBF6101A
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F959C433EF;
        Mon, 29 May 2023 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356082;
        bh=IJLIQq1chUklXte5PhtFAFs0mire2QtY9PJNSSEzrHs=;
        h=From:To:Cc:Subject:Date:From;
        b=sBtgyvEit3uCvlbTRP5yHC+e5nciFVqpCz0/ljIWoo8gp18aq9laYndbbyTqiHvjQ
         i/HjBmK5FvWKKOceIIS0i3vSJNrSlv1tHYSdyuHo8pAiR1bd0s01aUQg1KYmFJkg9x
         Rkelf5Mrf0M7H7CQWGagt2+B5g5ny46sq8wWDscMcpsiCVy7D6bhpki0RhrNmHIvmv
         CXdMAtf4xDe+zM1b0K1GoO+C2su3vhKHh6kQ0hOta06pI5YvuyIfoT5q4/TNeCaPFO
         X3e4+kw6H5sz9PQfSWuk1Kj2gHc8qd0/AWZtq+MjRi1vi5z42by8SS3dgtmK2aml6s
         5lMS9lgXnAC2Q==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: do more sanity check on inode
Date:   Mon, 29 May 2023 18:27:55 +0800
Message-Id: <20230529102755.2547478-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does below changes:
- clean up check condition
- add sanity check for i_extra_isize w/ lower boundary
- add sanity check for feature dependency
- check i_extra_isize only if f2fs_has_extra_attr() is true

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h  |   2 +
 fs/f2fs/inode.c | 108 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 72 insertions(+), 38 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9bd83fb28439..11c0bb12c686 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3424,6 +3424,8 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
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

