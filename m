Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9346264AB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiLLXTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiLLXTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:19:20 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3B41C133
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:19:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h10so13919250wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG+oyDWBfjBlSXbH84d4Jf+JAXSY+Hr7j0N14fdKo+g=;
        b=e+MD86YQuM8Lk6UJbsdDPz1d5Rf/6PBFLcmc2eGAVhnQa10tgKt1NE1vCGHLCTzb2n
         xs/3FOdH5Wh6yueT4DcW7zDssK2ICryJP4/gm4uX6+07vebyimHVuZGXGUublS2Nlzwu
         5orTsaL9F2m/c2nj0G25Cbcd4Cw0BJ9XXqtMZ7LxodjNdDaNU7xnqDpbNSm9tUR/M9UK
         DPTv+BsF1gFLfubj5ihk+xgzuoydbTAqu2GPRieJxw4zZd65lmMGA7/JjgvlncUNmvev
         TUw+WGeOlXlwa53FYxhlnjpOJYenp4AUSu/a13hIgwv84LtJKJ/OI8hgK8+n/2haOsZL
         5j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lG+oyDWBfjBlSXbH84d4Jf+JAXSY+Hr7j0N14fdKo+g=;
        b=N6YpnWXaw2Z1f5rxrXsMuprmiDDZLh/8VHiwCN2dYAHb8Ymwa63LDxVBsnAtpa+Wom
         2H7aPi9zaNc6Jvj5XpZBQDfu6DJQDfcjv6E+pzIlCSQbyufCi3YxUb8tJlejLZLLIBbJ
         83TsU0nWTnZ55MGtvKiSOr0x2W6XjePecmeMOokHu3GtpIgeQHFyX3jxQV71wKLpdnPY
         aWAXKJhPfRHkt7YXQB+TLCspozAOX/hTeN5CyFlOTXxA+/S6TeyBzwXhA/p21oiowB/u
         w5BKPyO7B3jSEYFNyQOVFhkyB5zjyN/iHOOl94CPW90+XEKAPVpcJq9KQYFq98UldQNr
         Ndgw==
X-Gm-Message-State: ANoB5pmgVLHLygNJg8NHWN03Gv8VdlOwyLOxEB776NE+4+MI33RFTAQq
        3/UB412eEc81PRXp8c5h8rw=
X-Google-Smtp-Source: AA0mqf5LL/qiHIazIFeR3WDLucCGuWbS97RXipYZKNjBlfIbQkjpEtPzzU9LhsO4+SeWsQx75eXVIw==
X-Received: by 2002:adf:e44a:0:b0:242:763:34a5 with SMTP id t10-20020adfe44a000000b00242076334a5mr11288838wrm.2.1670887156249;
        Mon, 12 Dec 2022 15:19:16 -0800 (PST)
Received: from localhost.localdomain (host-79-41-27-125.retail.telecomitalia.it. [79.41.27.125])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6103000000b002423edd7e50sm9964304wrt.32.2022.12.12.15.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:19:15 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 2/3] fs/ufs: Change the signature of ufs_get_page()
Date:   Tue, 13 Dec 2022 00:19:05 +0100
Message-Id: <20221212231906.19424-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212231906.19424-1-fmdefrancesco@gmail.com>
References: <bpf@vger.kernel.org,linux-fsdevel@vger.kernel.org>
 <20221212231906.19424-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the signature of ufs_get_page() in order to prepare this function
to the conversion to the use of kmap_local_page(). Change also those call
sites which are required to conform its invocations to the new
signature.

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ufs/dir.c | 59 ++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 69f78583c9c1..d1cbb48e5d52 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -185,21 +185,21 @@ static bool ufs_check_page(struct page *page)
 	return false;
 }
 
-static struct page *ufs_get_page(struct inode *dir, unsigned long n)
+static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **page)
 {
 	struct address_space *mapping = dir->i_mapping;
-	struct page *page = read_mapping_page(mapping, n, NULL);
-	if (!IS_ERR(page)) {
-		kmap(page);
-		if (unlikely(!PageChecked(page))) {
-			if (!ufs_check_page(page))
+	*page = read_mapping_page(mapping, n, NULL);
+	if (!IS_ERR(*page)) {
+		kmap(*page);
+		if (unlikely(!PageChecked(*page))) {
+			if (!ufs_check_page(*page))
 				goto fail;
 		}
 	}
-	return page;
+	return page_address(*page);
 
 fail:
-	ufs_put_page(page);
+	ufs_put_page(*page);
 	return ERR_PTR(-EIO);
 }
 
@@ -227,15 +227,12 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
 
 struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
 {
-	struct page *page = ufs_get_page(dir, 0);
-	struct ufs_dir_entry *de = NULL;
+	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);
 
-	if (!IS_ERR(page)) {
-		de = ufs_next_entry(dir->i_sb,
-				    (struct ufs_dir_entry *)page_address(page));
-		*p = page;
-	}
-	return de;
+	if (!IS_ERR(de))
+		return ufs_next_entry(dir->i_sb, de);
+	else
+		return NULL;
 }
 
 /*
@@ -273,11 +270,10 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 		start = 0;
 	n = start;
 	do {
-		char *kaddr;
-		page = ufs_get_page(dir, n);
-		if (!IS_ERR(page)) {
-			kaddr = page_address(page);
-			de = (struct ufs_dir_entry *) kaddr;
+		char *kaddr = ufs_get_page(dir, n, &page);
+
+		if (!IS_ERR(kaddr)) {
+			de = (struct ufs_dir_entry *)kaddr;
 			kaddr += ufs_last_byte(dir, n) - reclen;
 			while ((char *) de <= kaddr) {
 				if (ufs_match(sb, namelen, name, de))
@@ -328,12 +324,10 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	for (n = 0; n <= npages; n++) {
 		char *dir_end;
 
-		page = ufs_get_page(dir, n);
-		err = PTR_ERR(page);
-		if (IS_ERR(page))
-			goto out;
+		kaddr = ufs_get_page(dir, n, &page);
+		if (IS_ERR(kaddr))
+			return PTR_ERR(kaddr);
 		lock_page(page);
-		kaddr = page_address(page);
 		dir_end = kaddr + ufs_last_byte(dir, n);
 		de = (struct ufs_dir_entry *)kaddr;
 		kaddr += PAGE_SIZE - reclen;
@@ -395,7 +389,6 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	/* OFFSET_CACHE */
 out_put:
 	ufs_put_page(page);
-out:
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -429,6 +422,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 	unsigned chunk_mask = ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
 	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
 	unsigned flags = UFS_SB(sb)->s_flags;
+	struct page *page;
 
 	UFSD("BEGIN\n");
 
@@ -439,16 +433,14 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 		char *kaddr, *limit;
 		struct ufs_dir_entry *de;
 
-		struct page *page = ufs_get_page(inode, n);
-
-		if (IS_ERR(page)) {
+		kaddr = ufs_get_page(inode, n, &page);
+		if (IS_ERR(kaddr)) {
 			ufs_error(sb, __func__,
 				  "bad page in #%lu",
 				  inode->i_ino);
 			ctx->pos += PAGE_SIZE - offset;
 			return -EIO;
 		}
-		kaddr = page_address(page);
 		if (unlikely(need_revalidate)) {
 			if (offset) {
 				offset = ufs_validate_entry(sb, kaddr, offset, chunk_mask);
@@ -595,12 +587,11 @@ int ufs_empty_dir(struct inode * inode)
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
 		struct ufs_dir_entry *de;
-		page = ufs_get_page(inode, i);
 
-		if (IS_ERR(page))
+		kaddr = ufs_get_page(inode, i, &page);
+		if (IS_ERR(kaddr))
 			continue;
 
-		kaddr = page_address(page);
 		de = (struct ufs_dir_entry *)kaddr;
 		kaddr += ufs_last_byte(inode, i) - UFS_DIR_REC_LEN(1);
 
-- 
2.38.1

