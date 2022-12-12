Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7FE64AB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiLLXTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiLLXTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:19:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D00E1C415
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:19:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h7so13918660wrs.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvkJAcgJd+O1FIUzh+r0Wnbdw1Lb08jZRkvuJ8XN8TY=;
        b=JGnYa8+7d/o82h3CkSTwWBNT2WOmN5Bse7D6Nl0iJvbPtBOTZ9DnMYdlYnv8TgmH1S
         MbkRKhHcE3mV6Nu8KQNtd11TPdgKJARXkE4+wXaEnRqjcljlY/zlGD8lxgxSQrHjrMye
         WPpN7PS+TQvS8Xq0XGe504hZ/UAPIgSGB9M567NN5jRHiyCoUd0kHisZD3hDAydYCXhJ
         rXnicHOKaR38fl41vXXK4tQVeA90QIGC9k4QAhBcPvmkj3568B/VB+9BVAfOifTXkkzx
         28pfXdi6P3POo6y8AQF5UdeIIBowuSQwJyWEK3qUKmT+ZJmXM+p5kUqLwsto8jIuzj0x
         YB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvkJAcgJd+O1FIUzh+r0Wnbdw1Lb08jZRkvuJ8XN8TY=;
        b=aLsqeNQqNOTYqtRXGeZh0pIeK6ARDek+6hUg3hILWoNXHUaKaBKvq1+D58MdTmGWU5
         1eLpYi7HsjjH6p0U+Jf7XfJ3VSlh/9O6OSNlB7D483QJmbzVIrDfoZOJqHT97nOArO7c
         U5wb5VV7wbTmInrPrOqHaqMLa2vwxWtym5VhPlSG10i3dIbseepl5ZaKv24WZqVY30r1
         o3+537Je4Blcd3rjEhSAoQXBMj7877B2dEQMaRAX16Wl7Cs2jJow+DzrwwS0CtWEPEah
         djNwxG81uip/7EQwrYEbJ/776n5+kDN3dFkldHx+o4flo9pO2822E+eHW84AtTGlLz1i
         dhqA==
X-Gm-Message-State: ANoB5plJkb2ANG+fXSHtKrlAeRnjAWuwWTaHfUS5/QJPLIFj6G0paGgp
        FIHQg+QG/BRxPK4lh8hobpk=
X-Google-Smtp-Source: AA0mqf6T3Z+l+rvgecLkN4HkVOlppRVpArk5LtUos5GLDVpZetZp90BoeWYjXV8H1txrOSaaJuwM0Q==
X-Received: by 2002:a5d:44c7:0:b0:242:187f:ed44 with SMTP id z7-20020a5d44c7000000b00242187fed44mr11112478wrr.68.1670887157912;
        Mon, 12 Dec 2022 15:19:17 -0800 (PST)
Received: from localhost.localdomain (host-79-41-27-125.retail.telecomitalia.it. [79.41.27.125])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6103000000b002423edd7e50sm9964304wrt.32.2022.12.12.15.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:19:17 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 3/3] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Tue, 13 Dec 2022 00:19:06 +0100
Message-Id: <20221212231906.19424-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212231906.19424-1-fmdefrancesco@gmail.com>
References: <bpf@vger.kernel.org,linux-fsdevel@vger.kernel.org>
 <20221212231906.19424-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/ufs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
requires the mapping address, so return that address from ufs_get_page()
to be used in ufs_put_page().

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ufs/dir.c | 75 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index d1cbb48e5d52..f83071a74bef 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -61,9 +61,9 @@ static int ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
 	return err;
 }
 
-static inline void ufs_put_page(struct page *page)
+static inline void ufs_put_page(struct page *page, void *page_addr)
 {
-	kunmap(page);
+	kunmap((void *)((unsigned long)page_addr & PAGE_MASK));
 	put_page(page);
 }
 
@@ -76,7 +76,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 	de = ufs_find_entry(dir, qstr, &page);
 	if (de) {
 		res = fs32_to_cpu(dir->i_sb, de->d_ino);
-		ufs_put_page(page);
+		ufs_put_page(page, de);
 	}
 	return res;
 }
@@ -99,18 +99,17 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
 
 	err = ufs_commit_chunk(page, pos, len);
-	ufs_put_page(page);
+	ufs_put_page(page, de);
 	if (update_times)
 		dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
 }
 
 
-static bool ufs_check_page(struct page *page)
+static bool ufs_check_page(struct page *page, char *kaddr)
 {
 	struct inode *dir = page->mapping->host;
 	struct super_block *sb = dir->i_sb;
-	char *kaddr = page_address(page);
 	unsigned offs, rec_len;
 	unsigned limit = PAGE_SIZE;
 	const unsigned chunk_mask = UFS_SB(sb)->s_uspi->s_dirblksize - 1;
@@ -185,21 +184,30 @@ static bool ufs_check_page(struct page *page)
 	return false;
 }
 
+/*
+ * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
+ * rules documented in kmap_local_page()/kunmap_local().
+ *
+ * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page()
+ * and must be treated accordingly for nesting purposes.
+ */
 static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **page)
 {
+	char *kaddr;
+
 	struct address_space *mapping = dir->i_mapping;
 	*page = read_mapping_page(mapping, n, NULL);
 	if (!IS_ERR(*page)) {
-		kmap(*page);
+		kaddr = kmap_local_page(*page);
 		if (unlikely(!PageChecked(*page))) {
-			if (!ufs_check_page(*page))
+			if (!ufs_check_page(*page, kaddr))
 				goto fail;
 		}
 	}
-	return page_address(*page);
+	return kaddr;
 
 fail:
-	ufs_put_page(*page);
+	ufs_put_page(*page, kaddr);
 	return ERR_PTR(-EIO);
 }
 
@@ -225,6 +233,13 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
 					fs16_to_cpu(sb, p->d_reclen));
 }
 
+/*
+ * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
+ * rules documented in kmap_local_page()/kunmap_local().
+ *
+ * ufs_dotdot() acts as a call to ufs_get_page() and must be treated
+ * accordingly for nesting purposes.
+ */
 struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
 {
 	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);
@@ -236,12 +251,15 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
 }
 
 /*
- *	ufs_find_entry()
+ * Finds an entry in the specified directory with the wanted name. It returns a
+ * pointer to the directory's entry. The page in which the entry was found is
+ * in the res_page out parameter. The page is returned mapped and unlocked.
+ * The entry is guaranteed to be valid.
  *
- * finds an entry in the specified directory with the wanted name. It
- * returns the page in which the entry was found, and the entry itself
- * (as a parameter - res_dir). Page is returned mapped and unlocked.
- * Entry is guaranteed to be valid.
+ * On Success ufs_put_page() should be called on *res_page.
+ *
+ * ufs_find_entry() acts as a call to ufs_get_page() and must be treated
+ * accordingly for nesting purposes.
  */
 struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 				     struct page **res_page)
@@ -280,7 +298,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 					goto found;
 				de = ufs_next_entry(sb, de);
 			}
-			ufs_put_page(page);
+			ufs_put_page(page, kaddr);
 		}
 		if (++n >= npages)
 			n = 0;
@@ -358,7 +376,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
 		}
 		unlock_page(page);
-		ufs_put_page(page);
+		ufs_put_page(page, kaddr);
 	}
 	BUG();
 	return -EINVAL;
@@ -388,7 +406,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
-	ufs_put_page(page);
+	ufs_put_page(page, kaddr);
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -466,13 +484,13 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 					       ufs_get_de_namlen(sb, de),
 					       fs32_to_cpu(sb, de->d_ino),
 					       d_type)) {
-					ufs_put_page(page);
+					ufs_put_page(page, kaddr);
 					return 0;
 				}
 			}
 			ctx->pos += fs16_to_cpu(sb, de->d_reclen);
 		}
-		ufs_put_page(page);
+		ufs_put_page(page, kaddr);
 	}
 	return 0;
 }
@@ -483,10 +501,10 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
  * previous entry.
  */
 int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
-		     struct page * page)
+		     struct page *page)
 {
 	struct super_block *sb = inode->i_sb;
-	char *kaddr = page_address(page);
+	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);
 	unsigned int from = offset_in_page(dir) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
 	unsigned int to = offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen);
 	loff_t pos;
@@ -525,7 +543,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
 out:
-	ufs_put_page(page);
+	ufs_put_page(page, kaddr);
 	UFSD("EXIT\n");
 	return err;
 }
@@ -549,8 +567,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 		goto fail;
 	}
 
-	kmap(page);
-	base = (char*)page_address(page);
+	base = kmap_local_page(page);
 	memset(base, 0, PAGE_SIZE);
 
 	de = (struct ufs_dir_entry *) base;
@@ -567,7 +584,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
 	ufs_set_de_namlen(sb, de, 2);
 	strcpy (de->d_name, "..");
-	kunmap(page);
+	kunmap_local(base);
 
 	err = ufs_commit_chunk(page, 0, chunk_size);
 fail:
@@ -583,9 +600,9 @@ int ufs_empty_dir(struct inode * inode)
 	struct super_block *sb = inode->i_sb;
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
+	char *kaddr;
 
 	for (i = 0; i < npages; i++) {
-		char *kaddr;
 		struct ufs_dir_entry *de;
 
 		kaddr = ufs_get_page(inode, i, &page);
@@ -618,12 +635,12 @@ int ufs_empty_dir(struct inode * inode)
 			}
 			de = ufs_next_entry(sb, de);
 		}
-		ufs_put_page(page);
+		ufs_put_page(page, kaddr);
 	}
 	return 1;
 
 not_empty:
-	ufs_put_page(page);
+	ufs_put_page(page, kaddr);
 	return 0;
 }
 
-- 
2.38.1

